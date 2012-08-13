// ModPlug.cpp : Definiert den Einsprungpunkt für die DLL-Anwendung.
//

#include "stdafx.h"

#include <conio.h>

// We define our own DllMain instead!
// IMPLEMENT_PACKAGE(ModPlug);
extern "C" DLL_EXPORT TCHAR GPackage[];
DLL_EXPORT TCHAR GPackage[] = TEXT("UnLua");

IMPLEMENT_CLASS(AUnLua);

// Package implementation.
extern "C" {
	HINSTANCE hInstance;
}

FName fMODPLUG(TEXT("UnLua"));

INT DLL_EXPORT STDCALL DllMain(HINSTANCE hInInstance, DWORD Reason, void* Reserved)
{
	hInstance = hInInstance;
	switch(Reason)
	{
	case DLL_PROCESS_ATTACH:
		// GLog->Logf(NAME_Log, TEXT("UnLua initialized"));
		break;

	case DLL_PROCESS_DETACH:
		break;
	}
	return 1;
}

/*
enum EPropertyType
{
	CPT_None			= 0,
	CPT_Byte			= 1,
	CPT_Int				= 2,
	CPT_Bool			= 3,
	CPT_Float			= 4,
	CPT_ObjectReference	= 5,
	CPT_Name			= 6,
	CPT_Struct			= 10,
	CPT_Vector          = 11,
	CPT_Rotation        = 12,
	CPT_String          = 13,
	CPT_MAX				= 14,
};
*/

const int CPT_Byte			  = 1;
const int CPT_Int             = 2;
const int CPT_Bool			  = 3;
const int CPT_Float			  = 4;
const int CPT_ObjectReference = 5;
const int CPT_Name            = 6;
const int CPT_String          = 13;
const int CPT_MAX             = 14;

struct UnLuaProperty {
	int propertyType;
	EName propertyName;
	void* property;
};

struct UnLuaActor {
	AActor* actor;
	char* actorname;
	FName actortag;
	int numProperties;
	int maxProperties;
	struct UnLuaProperty* properties;
};

struct UnrealClass {
	UClass* uclass;
	char* classname;
};


static int luaGetActorByPointer(lua_State *L);
static int luaCallFunction(lua_State *L);
static int luaGCActor(lua_State *L);
static int luaActorToString(lua_State *L);
static int luaClassToString(lua_State *L);
static int luaClassGC(lua_State *L);
static int luaGetClass(lua_State *L);
static int luaGetNextActor(lua_State *L);
static int luaCalcDistance(lua_State *L);

static char* fname2dupstr(FName name);
static char* fstring2dupstr(FName name);

static AActor* getUnLua(lua_State *L)
{
	lua_getglobal(L, "__unlua");
	AActor* unlua = (AActor*) lua_topointer(L, -1);
	lua_remove(L, -1);
	return unlua;

}

static int
luaPrint(lua_State *L)
{
	size_t len;
	const char* ls = luaL_tolstring(L, 1, &len);

	if (!ls) ls = "Unable to convert to string";
	FString fs(ls, len);
	lua_getglobal(L, "__logfstring");
	FString* logstring = (FString*) lua_topointer(L, -1);
	if (logstring == NULL)
		GLog->Logf(TEXT("No __logfstring set; cannot log from Lua!"));
	else {
		lua_pop(L, 1);
		*logstring += fs;
	}

	return 0;
}

static int
luaPrintLn(lua_State *L)
{
	size_t len;
	const char* ls = luaL_tolstring(L, 1, &len);

	if (!ls) ls = "Unable to convert to string";
	FString fs(ls, len);
	lua_getglobal(L, "__logfstring");
	FString* logstring = (FString*) lua_topointer(L, -1);
	if (logstring == NULL)
		GLog->Logf(TEXT("No __logfstring set; cannot log from Lua!"));
	else {
		lua_pop(L, 1);
		*logstring += fs;
		*logstring += "\n";
	}

	return 0;
}


static int
luaExec(lua_State *L)
{
	if((lua_gettop(L) != 1) || !lua_isstring(L, 1)) {
		lua_pushstring(L, "luaExec: Argument error");
		lua_error(L);
	}
	const char* ls = lua_tostring(L, 1);
	FString fs(ls);
	GExec->Exec(*fs, *GLog);
	lua_pushboolean(L, 1);
	return 1;
}

static int
luaURPropertyInt(lua_State *L)
{
	char* actor            = (char*) lua_topointer(L, lua_upvalueindex(1));
	UIntProperty* property = (UIntProperty*) lua_topointer(L, lua_upvalueindex(2));
	if (lua_gettop(L) == 1) {
		int newInt = lua_tointeger(L, -1);
		memcpy(actor + property->Offset, &newInt, property->ElementSize);
		return 0;
	} else {
		int theint = 0;
		memcpy(&theint, actor + property->Offset, property->ElementSize);
		lua_pushinteger(L, theint);
		return 1;
	}
}

static int
luaURPropertyFloat(lua_State *L)
{
	char* actor              = (char*) lua_topointer(L, lua_upvalueindex(1));
	UFloatProperty* property = (UFloatProperty*) lua_topointer(L, lua_upvalueindex(2));
	if (lua_gettop(L) == 1) {
		FLOAT newFloat = (float)lua_tonumber(L, -1);
		memcpy(actor + property->Offset, &newFloat, property->ElementSize);
		return 0;
	} else {
		FLOAT thefloat = 0;
		memcpy(&thefloat, actor + property->Offset, property->ElementSize);
		lua_pushnumber(L, thefloat);
		return 1;
	}
}

static int
luaURPropertyBool(lua_State *L)
{
	char* actor             = (char*) lua_topointer(L, lua_upvalueindex(1));
	UBoolProperty* property = (UBoolProperty*) lua_topointer(L, lua_upvalueindex(2));
	if (lua_gettop(L) == 1) {
		int theint = 0;
		memcpy(&theint, actor + property->Offset, property->ElementSize);
		if (lua_toboolean(L, -1))
			theint |= property->BitMask;
		else
			theint &= ~property->BitMask;
		memcpy(actor + property->Offset, &theint, property->ElementSize);
		return 0;
	} else {
		int theint = 0;
		memcpy(&theint, actor + property->Offset, property->ElementSize);
		if (theint & property->BitMask)
			lua_pushboolean(L, 1);
		else
			lua_pushboolean(L, 0);
		return 1;
	}
}

static int
luaURPropertyByte(lua_State *L)
{
	char* actor             = (char*) lua_topointer(L, lua_upvalueindex(1));
	UByteProperty* property = (UByteProperty*) lua_topointer(L, lua_upvalueindex(2));
	if (lua_gettop(L) == 1) {
		unsigned char newchar = lua_tointeger(L, -1);
		memcpy(actor + property->Offset, &newchar, property->ElementSize);
		return 0;
	} else {
		unsigned char thechar = 0;
		memcpy(&thechar, actor + property->Offset, property->ElementSize);
		lua_pushinteger(L, thechar);
		return 1;
	}
}

static int
luaURPropertyActor(lua_State *L)
{
	char* actor               = (char*) lua_topointer(L, lua_upvalueindex(1));
	UObjectProperty* property = (UObjectProperty*) lua_topointer(L, lua_upvalueindex(2));
	char* ptr = actor + property->Offset;
	UObject** uobj = (UObject**) ptr;
	if (lua_gettop(L) == 1) {
		struct UnLuaActor* ula  = (struct UnLuaActor*)  luaL_testudata(L, -1, "UnrealActor");
		struct UnrealClass *ulc = (struct UnrealClass*) luaL_testudata(L, -1, "UnrealClass");
		if ((ula == NULL) && (ulc == NULL)) {
			*uobj = NULL;
		} else {
			if (property->PropertyClass == UClass::StaticClass()) {
				if (ulc == NULL) {
					lua_pushliteral(L, "Invalid type");
					lua_error(L);
				}
				*uobj = ulc->uclass;
			} else {
				if ((ula != NULL) && (ula->actor->IsA(property->PropertyClass))) {
					*uobj = ula->actor;
				} else {
					lua_pushliteral(L, "Invalid type");
					lua_error(L);
				}
			}
		}
	} else {
		if (*uobj == NULL) {
			lua_pushnil(L);
			return 1;
		}
		if ((*uobj)->IsA(AActor::StaticClass())) {
			lua_pushlightuserdata(L, *uobj);
			luaGetActorByPointer(L);
			return 1;
		} else if ((*uobj)->IsA(UClass::StaticClass())) {
			UClass* uclass = Cast<UClass>(*uobj);
			struct UnrealClass* uc = (struct UnrealClass*)
				lua_newuserdata(L, sizeof(struct UnrealClass));
			luaL_setmetatable(L, "UnrealClass");
			uc->uclass = uclass;
			uc->classname = fname2dupstr(uclass->GetFName());
			return 1;
		} else {
			lua_pushliteral(L, "Only getting actor classes or metaclasses is supported");
			lua_error(L);
		}
	}
	return 0;
}

static char*
fname2dupstr(FName name)
{
	const TCHAR* tcr = FName::SafeString((EName) name.GetIndex());
	FString str(tcr);
	int l = str.Len();
	char* buf = (char*) malloc(l + 1);
	check(buf != NULL);
	for (int i = 0; i <= l; ++i)
		buf[i] = tcr[i];
	return buf;
}

static char*
fstring2dupstr(FString* string)
{
	const TCHAR* tcr = **string;
	int l = string->Len();
	char* buf = (char*) malloc(l + 1);
	check(buf != NULL);
	for (int i = 0; i <= l; ++i)
		buf[i] = tcr[i];
	return buf;
}

static int
luaURPropertyStr(lua_State *L)
{
	char* actor            = (char*) lua_topointer(L, lua_upvalueindex(1));
	UStrProperty* property = (UStrProperty*) lua_topointer(L, lua_upvalueindex(2));
	char* addr             = actor + property->Offset;
	FString* thestring     = (FString*) addr;
	if (lua_gettop(L) == 1) {
		const char* strbuf = lua_tostring(L, -1);
		FString fstring(strbuf);
		*thestring = fstring;
		return 0;
	} else {
		const char *strbuf_t = (const char*) thestring->GetCharArray().GetData();
		int len = thestring->Len();
		char *strbuf = (char*) malloc(len + 1);
		check(strbuf != NULL);
		/* hack to convert tchar into char */
		for(int i = 0; i < len; ++i)
			strbuf[i] = strbuf_t[i * 2];
		strbuf[len] = 0;
		lua_pushlstring(L, strbuf, len);
		cprintf("Pushed value %s to the lua stack\n\r", strbuf);
		free(strbuf);
		return 1;
	}
}

static int
luaURPropertyName(lua_State *L)
{
	char* actor             = (char*) lua_topointer(L, lua_upvalueindex(1));
	UNameProperty* property = (UNameProperty*) lua_topointer(L, lua_upvalueindex(2));
	char* addr              = actor + property->Offset;
	if (lua_gettop(L) == 1) {
		const char* strbuf = lua_tostring(L, -1);
		FString fstring(strbuf);
		FName fname(*fstring, FNAME_Add);
		memcpy(addr, &fname, property->ElementSize);
		return 0;
	} else {
		FName thename;
		memcpy(&thename, addr, property->ElementSize);
		FString thestring(*thename);
		const char *strbuf_t = (const char*) *thestring;
		int len = thestring.Len();
		char *strbuf = (char*) malloc(len + 1);
		check(strbuf != NULL);
		/* hack to convert tchar into char */
		for(int i = 0; i < len; ++i)
			strbuf[i] = strbuf_t[i * 2];
		strbuf[len] = 0;
		lua_pushlstring(L, strbuf, len);
		cprintf("Pushed value %s to the lua stack\n\r", strbuf);
		free(strbuf);
		return 1;
	}
}

static int
luaGetProperties(lua_State *L)
{
	char propname_utf8[512];
	int i, j, l;
	struct UnLuaActor* a = (struct UnLuaActor*)
		luaL_checkudata(L, 1, "UnrealActor");
	lua_createtable(L, a->numProperties, 0);
	for (i = 0; i < a->numProperties; ++i) {
		const TCHAR* propname_tchar = FName::SafeString(a->properties[i].propertyName);
		FString propname_s(propname_tchar);
		l = propname_s.Len();
		l = (l <= 512) ? l : 512;
		for (j = 0; j < l; ++j)
			propname_utf8[j] = propname_tchar[j];
		lua_pushinteger(L, i + 1); /* +1 because lua starts its indices at 1, not zero */
		lua_pushlstring(L, propname_utf8, l);
		lua_settable(L, -3);
	}
	return 1;
}


static int
luaGetActorsByTag(lua_State *L)
{
  FName* actorTag_n;
  struct UnrealClass* uc = (struct UnrealClass*)
	  luaL_checkudata(L, 1, "UnrealClass");
  if (lua_gettop(L) > 1) {
	  const char* actorTag_s = lua_tostring(L, 2);
	  FString actorTag(actorTag_s);
	  actorTag_n = new FName(*actorTag, FNAME_Find);
  } else {
	  actorTag_n = NULL;
  }
  int* n = (int*) malloc(sizeof(int));
  check(n != NULL);
  *n = 0;
  lua_pushlightuserdata(L, actorTag_n);
  lua_pushlightuserdata(L, n);
  lua_pushlightuserdata(L, uc->uclass);
  lua_pushcclosure(L, luaGetNextActor, 3);
  lua_pushnil(L); lua_pushnil(L);
  return 3;
}

static int
luaGetNextActor(lua_State *L)
{
  int i;
  AActor* unlua = getUnLua(L);
  int numActors = unlua->XLevel->Actors.Num();
  FName* actorTag = (FName*) lua_topointer(L, lua_upvalueindex(1));
  int* n = (int*) lua_topointer(L, lua_upvalueindex(2));
  cprintf("Iterator called; n=%d\r\n", *n);
  UClass* actorClass = (UClass*) lua_topointer(L, lua_upvalueindex(3));
  for (i = *n; i < numActors; ++i) {
    AActor* a = unlua->XLevel->Actors(i);
    if (a == NULL) continue;
	if (!a->IsA(actorClass)) continue;
    if ((actorTag == NULL) || (a->Tag == *actorTag)) {
	  *n = i + 1; /* update counter for next iteration */
      lua_pushlightuserdata(L, a);
      return luaGetActorByPointer(L);
    }
  }

  /* No more actors to be returned; free iterator state */
  free(n);
  if (actorTag != NULL) free(actorTag);

  /* And indicate the fact there's nothing else to return to the caller */
  lua_pushnil(L);
  return 1;
}

/* Get an actor as a lua type */
static int
luaGetActor(lua_State *L)
{
	if((lua_gettop(L) != 1) || !lua_isstring(L, 1)) {
		lua_pushstring(L, "luaGetActor: Argument error");
		lua_error(L);
	}
	int n=0;
	const char* actorName_s = lua_tostring(L, 1);
	FString actorName_f(actorName_s);
	AActor* unlua = getUnLua(L);
	AActor* actor;

	actor = FindObject<AActor> (ANY_PACKAGE, *actorName_f);

	/*
	FName actorName = FName(*actorName_f, FNAME_Find);
	actor = NULL;
	int numActors = unlua->XLevel->Actors.Num();
	int i;
	for (i = 0; i < numActors; ++i) {
		AActor* a = unlua->XLevel->Actors(i);
		if (a == NULL) continue;
		if (a->GetFName() == actorName) {
			actor = a;
			break;
		}
	}
	*/

	if(actor == NULL) {
		lua_pushstring(L, "luaGetActor: Actor not found");
		lua_error(L);
	}
	lua_pushlightuserdata(L, actor);
	return luaGetActorByPointer(L);
}

/* Get the player pawn actor */
static int
luaGetPlayerPawn(lua_State *L)
{
	lua_getglobal(L, "__unlua");
	AUnLua* unlua = (AUnLua*) lua_topointer(L, -1);

	//actor = FindObject<AActor> (ANY_PACKAGE, *actorName_f);
	check(unlua->AssignedPlayer);
	lua_pushlightuserdata(L, unlua->AssignedPlayer);
	return luaGetActorByPointer(L);
}

static int
luaGetActorByPointer(lua_State *L)
{
	AActor* actor = (AActor*) lua_topointer(L, -1);
	lua_pop(L, 1);

	struct UnLuaActor* ula = (struct UnLuaActor*)
		lua_newuserdata(L, sizeof(struct UnLuaActor));
	luaL_setmetatable(L, "UnrealActor");

	ula->actor = actor;

	const TCHAR* aname = actor->GetName();
	FString actorName_f (actor->GetName());
	ula->actorname = (char*) malloc(actorName_f.Len() + 1);
	check(ula->actorname != NULL);
	for (int i = 0; i <= actorName_f.Len(); ++i)
		ula->actorname[i] = aname[i];

	FName atag = actor->GetName();
	ula->actortag = atag;

	ula->numProperties = 0;
	ula->maxProperties = 100;
	ula->properties = (struct UnLuaProperty*)
		malloc(ula->maxProperties * sizeof(struct UnLuaProperty));
	for(TFieldIterator<UProperty> It(actor->GetClass()); It; ++It) {
		if (ula->numProperties == ula->maxProperties) {
			ula->maxProperties += 100;
			ula->properties = (struct UnLuaProperty*)
				realloc(ula->properties, ula->maxProperties * sizeof(struct UnLuaProperty));
		}
		ula->properties[ula->numProperties].property = *It;
		ula->properties[ula->numProperties].propertyName =
			(EName) It->GetFName().GetIndex();
		if (It->IsA(UIntProperty::StaticClass()))
			ula->properties[ula->numProperties].propertyType = CPT_Int;
		else if (It->IsA(UStrProperty::StaticClass()))
			ula->properties[ula->numProperties].propertyType = CPT_String;
		else if (It->IsA(UNameProperty::StaticClass()))
			ula->properties[ula->numProperties].propertyType = CPT_Name;
		else if (It->IsA(UByteProperty::StaticClass()))
			ula->properties[ula->numProperties].propertyType = CPT_Byte;
		else if (It->IsA(UBoolProperty::StaticClass()))
			ula->properties[ula->numProperties].propertyType = CPT_Bool;
		else if (It->IsA(UFloatProperty::StaticClass()))
			ula->properties[ula->numProperties].propertyType = CPT_Float;
		else if (It->IsA(UObjectProperty::StaticClass()))
			ula->properties[ula->numProperties].propertyType = CPT_ObjectReference;
		else
			ula->properties[ula->numProperties].propertyType = CPT_MAX;
		
		//if (ula->properties[ula->numProperties].propertyType == CPT_Bool) GLog->Logf(TEXT("%s %d %d %d"), It->GetFullName(), It->Offset, It->ElementSize, ((UBoolProperty*) *It)->BitMask);
		++ula->numProperties;
	}

	return 1;
}


static int
luaGCActor(lua_State *L)
{
	struct UnLuaActor* ula = (struct UnLuaActor*) luaL_testudata(L, 1, "UnrealActor");
	free(ula->properties); ula->properties = NULL;
	free(ula->actorname);  ula->actorname  = NULL;
	return 0;
}

static int
luaActorToString(lua_State *L)
{
	struct UnLuaActor* ula = (struct UnLuaActor*) luaL_testudata(L, 1, "UnrealActor");
	lua_pushfstring(L, "Actor %s", ula->actorname);
	return 1;
}


static int
luaGetUnrealPropertyOrFunction(lua_State *L)
{
	struct UnLuaActor* ula = (struct UnLuaActor*) luaL_testudata(L, 1, "UnrealActor");
	const char* elemName = lua_tostring(L, 2);
	FString elemName_s(elemName);
	FName fn(*elemName_s, FNAME_Find);
	EName elemIdx = (EName) fn.GetIndex();
	if (elemIdx == 0) {
		lua_pushnil(L);
		return 1;
	}
	UFunction* func = ula->actor->FindFunction(fn);
	if (func != NULL) {
		lua_pushlightuserdata(L, ula->actor);
		lua_pushlightuserdata(L, func);
		lua_pushstring(L, elemName);
		lua_pushcclosure(L, luaCallFunction, 3);
		return 1;
	}

	for (int i = 0; i < ula->numProperties; ++i) {
		if (ula->properties[i].propertyName == elemIdx) {
			lua_pushlightuserdata(L, ula->actor);
			lua_pushlightuserdata(L, ula->properties[i].property);
			switch(ula->properties[i].propertyType) {
			case CPT_Int:
				lua_pushcclosure(L, luaURPropertyInt, 2);
				break;
			case CPT_String:
				lua_pushcclosure(L, luaURPropertyStr, 2);
				break;
			case CPT_Name:
				lua_pushcclosure(L, luaURPropertyName, 2);
				break;
			case CPT_Byte:
				lua_pushcclosure(L, luaURPropertyByte, 2);
				break;
			case CPT_Bool:
				lua_pushcclosure(L, luaURPropertyBool, 2);
				break;
			case CPT_Float:
				lua_pushcclosure(L, luaURPropertyFloat, 2);
				break;
			case CPT_ObjectReference:
				lua_pushcclosure(L, luaURPropertyActor, 2);
				break;
			}
			return 1;
		}
	}

	return 0;
}


static int
luaGetField(lua_State *L)
{
	if(lua_gettop(L) != 2) {
		cprintf("%d\n", lua_gettop(L));
		lua_pushstring(L, "luaGetField: Argument error");
		lua_error(L);
	}
	lua_getglobal(L, "__unlua");
	AActor* unlua = (AActor*) lua_topointer(L, -1);
	lua_remove(L, -1);
	AActor* actor = (AActor*) lua_topointer(L, 1);
	const char* fieldName_s = lua_tostring(L, 2);
	FString fieldName_f(fieldName_s);
	FName fieldName(*fieldName_f, FNAME_Find);
	//UProperty* field = FindObject<UProperty>(UObject::StaticClass()->GetOuter(), *fieldName_f, 0);
	//UProperty* field = FindObject<UProperty>(actor->GetClass()->GetOuter(), TEXT("BindName"), 0);
	for(TFieldIterator<UProperty> It(actor->GetClass()); It; ++It) {
		GLog->Logf(TEXT("PROPERTY: %s"), It->GetFullName());
	}
	GLog->Logf(TEXT("Got field! Yay!"));

	return 1;
}

static int
luaCallFunction(lua_State *L)
{
	int numparams = lua_gettop(L);
	lua_getglobal(L, "__unlua");
	AActor* unlua = (AActor*) lua_topointer(L, -1);
	lua_remove(L, -1);

	AActor* actor = (AActor*) lua_topointer(L, lua_upvalueindex(1));
	UFunction* func = (UFunction*) lua_topointer(L, lua_upvalueindex(2));
	const char* funcName_s = lua_tostring(L, lua_upvalueindex(3));
	

	if (func->NumParms == 0) {
		actor->ProcessEvent(func, NULL, NULL);
		return 0;
	}

	TFieldIterator<UProperty> It (func);
	char params[1024];
	memset(params, 0, sizeof(params));
	char* parptr = params;
	TArray<FString*> allocatedStrings;
	for (int i = 0; i < func->NumParms; ++i) {
		if (i >= numparams) {
			if (It->PropertyFlags & CPF_OptionalParm) {
				break;
			} else {
				lua_pushfstring(L, "Too few parameters for call to %s", funcName_s);
				lua_error(L);
			}
		}
		if (It->IsA(UIntProperty::StaticClass())) {
			int anint = lua_tointeger(L, i + 1);
			memcpy(parptr, &anint, It->ElementSize);
		} else if (It->IsA(UStrProperty::StaticClass())) {
			FString* astr = new FString(lua_tostring(L, i + 1));
			allocatedStrings.AddItem(astr);
			memcpy(parptr, astr, It->ElementSize);
		} else if (It->IsA(UNameProperty::StaticClass())) {
			FString astr(lua_tostring(L, i + 1));
			FName aname(*astr, FNAME_Add);
			memcpy(parptr, &aname, It->ElementSize);
		} else if (It->IsA(UByteProperty::StaticClass())) {
			*parptr = (char) lua_tointeger(L, i + 1);
		} else if (It->IsA(UBoolProperty::StaticClass())) {
			int bval = lua_toboolean(L, i + 1);
			memcpy(parptr, &bval, It->ElementSize);
		} else if (It->IsA(UFloatProperty::StaticClass())) {
			float fval = (float)lua_tonumber(L, i + 1);
			memcpy(parptr, &fval, It->ElementSize);
		} else if (It->IsA(UObjectProperty::StaticClass())) {
			UObjectProperty *uop = (UObjectProperty*) *It;
			struct UnLuaActor* ula  = (struct UnLuaActor*)
				luaL_testudata(L, i + 1, "UnrealActor");
			struct UnrealClass* ulc = (struct UnrealClass*)
				luaL_testudata(L, i + 1, "UnrealClass");
			UObject** uobj = (UObject**) parptr;
			if ((ula == NULL) && (ulc == NULL))
				*uobj = NULL;
			else {
				if (uop->PropertyClass == UClass::StaticClass()) {
					if (ulc == NULL) {
						lua_pushfstring(L, "Invalid type for parameter %d", i+1);
						lua_error(L);
					}
					*uobj = ulc->uclass;
				} else {
					if (ula->actor->IsA(uop->PropertyClass)) {
						//memcpy(parptr, ula->actor, It->ElementSize);
						*uobj = ula->actor;
					} else {
						lua_pushfstring(L, "Invalid type for parameter %d", i+1);
						lua_error(L);
					}
				}
			}
		} else {
			lua_pushfstring(L, "luaCallFunction: Unreal function %s requires "
				"parameter type not yet supported by UnLua", funcName_s);
			lua_error(L);
		}
		parptr += It->ElementSize;
		++It;
	}
	actor->ProcessEvent(func, params, NULL);
	free(params);
	while(allocatedStrings.Num())
		delete allocatedStrings.Pop();

	return 0;
}

IMPLEMENT_FUNCTION(AUnLua, -1, execrunLuaScript);
void
AUnLua::execrunLuaScript(FFrame& Stack, RESULT_DECL)
{
	guard(AUnLua::execrunLuaScript);
	P_GET_STR(script);
	P_GET_STR_REF(resultAsString);
	P_GET_INT_REF(success);
	P_FINISH

	FString lualog;

	lua_pushlightuserdata(luaState, &lualog);
	lua_setglobal(luaState, "__logfstring");

	const char *scrbuf_t = (const char*) script.GetCharArray().GetData();
	int len = script.Len();

	char *scrbuf = (char*) malloc(len);
	check(scrbuf != NULL);
	/* hack to convert tchar into char */
	for(int i = 0; i < len; ++i)
		scrbuf[i] = scrbuf_t[i * 2];
	int status = luaL_loadbuffer(luaState, scrbuf, len, "unrealscript");
	free(scrbuf);

	if (status == LUA_OK) {
		status = lua_pcall(luaState, 0, 1, 0);
		if (status == LUA_OK)
			*success = 1;
		else if (status == LUA_ERRRUN)
			*success = 0;
	} else {
		*success = 0;
	}

	lualog += TEXT("\0");
	lua_pushlightuserdata(luaState, NULL);
	lua_setglobal(luaState, "__logfstring");

	unsigned int resultMsgLen = 0;
	const char* resultMsg = luaL_tolstring(luaState, -1, &resultMsgLen);
	lua_remove(luaState, -1); /* the result */
	if (*success)
		*resultAsString = lualog;
	else
		*resultAsString = FString(resultMsg, resultMsgLen);

	*(DWORD*)Result = 0;
	unguardexec;
}

IMPLEMENT_FUNCTION(AUnLua, -1, execcompileScript);
void
AUnLua::execcompileScript(FFrame& Stack, RESULT_DECL)
{
	guard(AUnLua::execcompileScript);
	P_GET_STR(scriptCode);
	P_GET_INT_REF(successful);
	P_FINISH
	unguardexec;
}

/*
	UField* FindObjectField( FName InName, UBOOL Global=0 );
	UFunction* FindFunction( FName InName, UBOOL Global=0 );
	UFunction* FindFunctionChecked( FName InName, UBOOL Global=0 );
	UState* FindState( FName InName );

*/

static  int
luaAllocConsole(lua_State *L)
{
	int bShow = 1;
	if (lua_gettop(L) >= 1)
		bShow = lua_toboolean(L, 1);
	if (bShow)
		AllocConsole();
	else
		FreeConsole();
	return 0;
}

static int
luaIsA(lua_State *L)
{
	struct UnLuaActor* ula = (struct UnLuaActor*)
		luaL_checkudata(L, 1, "UnrealActor");
	struct UnrealClass* ulc = (struct UnrealClass*)
		luaL_checkudata(L, 2, "UnrealClass");

	lua_pushboolean(L, ula->actor->IsA(ulc->uclass));
	return 1;
}

AUnLua::AUnLua(void)
{
	luaState = luaL_newstate();
	//lua_newmetatable(luaState, "UnActor");

	lua_pushlightuserdata(luaState, this);
	lua_setglobal(luaState, "__unlua");

	luaL_newmetatable(luaState, "UnrealActor");
	lua_pushcfunction(luaState, luaGetUnrealPropertyOrFunction);
	lua_setfield(luaState, -2, "__index");
	lua_pushcfunction(luaState, luaGCActor);
	lua_setfield(luaState, -2, "__gc");
	lua_pushcfunction(luaState, luaActorToString);
	lua_setfield(luaState, -2, "__tostring");
	lua_pop(luaState, 1);

	luaL_newmetatable(luaState, "UnrealClass");
	lua_pushcfunction(luaState, luaClassToString);
	lua_setfield(luaState, -2, "__tostring");
	lua_pop(luaState, 1);


	lua_register(luaState, "print", luaPrint);
	lua_register(luaState, "println", luaPrintLn);
	lua_register(luaState, "properties", luaGetProperties);
	lua_register(luaState, "unexec", luaExec);
	lua_register(luaState, "getplayerpawn", luaGetPlayerPawn);
	lua_register(luaState, "actor", luaGetActor);
	lua_register(luaState, "class", luaGetClass);
	lua_register(luaState, "allactors", luaGetActorsByTag);
	lua_register(luaState, "console", luaAllocConsole);
	lua_register(luaState, "distance", luaCalcDistance);
	lua_register(luaState, "isa", luaIsA);

	
	luaL_openlibs(luaState);
}

static int
luaCalcDistance(lua_State *L)
{
	struct UnLuaActor* actor1 = (struct UnLuaActor*)
		luaL_checkudata(L, 1, "UnrealActor");
	struct UnLuaActor* actor2 = (struct UnLuaActor*)
		luaL_checkudata(L, 2, "UnrealActor");

	FVector distLoc = actor1->actor->Location -
		actor2->actor->Location;
	lua_pushnumber(L, distLoc.Size());

	return 1;
}

static int
luaClassToString(lua_State *L)
{
	struct UnrealClass* uc = (struct UnrealClass*)
		luaL_checkudata(L, 1, "UnrealClass");
	lua_pushstring(L, uc->classname);
	return 1;
}

static int
luaClassGC(lua_State *L)
{
	struct UnrealClass* uc = (struct UnrealClass*)
		luaL_checkudata(L, 1, "UnrealClass");
	free(uc->classname);
	uc->uclass = NULL;
	return 0;
}

static int
luaGetClass(lua_State *L)
{
	const char* className = lua_tostring(L, 1);
	FString className_w(className);
	UClass* uclass = FindObject<UClass>(ANY_PACKAGE, *className_w);
	if (uclass == NULL) {
		lua_pushliteral(L, "Class not found");
		lua_error(L);
		return 0;
	} else {
		struct UnrealClass* uc = (struct UnrealClass*)
			lua_newuserdata(L, sizeof(struct UnrealClass));
		luaL_setmetatable(L, "UnrealClass");
		uc->uclass = uclass;
		uc->classname = strdup(className);
		return 1;
	}
}


IMPLEMENT_FUNCTION(AUnLua, -1, execsetGlobalVariable);
void
AUnLua::execsetGlobalVariable(FFrame& Stack, RESULT_DECL)
{
	guard(AUnLua::execsetGlobalVariable);
	P_GET_STR(varName);
	P_GET_STR(varValue);
	P_FINISH

	char* varName_u;
	char* varValue_u;

	varName_u  = fstring2dupstr(&varName);
	varValue_u = fstring2dupstr(&varValue);
	lua_pushstring(luaState, varValue_u);
	lua_setglobal(luaState, varName_u);

	free(varValue_u); free(varName_u);

	unguardexec;
}

IMPLEMENT_FUNCTION(AUnLua, -1, execgetGlobalVariable);
void
AUnLua::execgetGlobalVariable(FFrame& Stack, RESULT_DECL)
{
	guard(AUnLua::execsetGlobalVariable);
	P_GET_STR(varName);
	P_GET_STR_REF(varValue);
	P_FINISH

	char* varName_u;
	const char* varValue_u;
	size_t len = 0;

	varName_u  = fstring2dupstr(&varName);
	lua_getglobal(luaState, varName_u);
	varValue_u = luaL_tolstring(luaState, -1, &len);
	lua_pop(luaState, 1);
	free(varName_u);

	FString str(varValue_u, len);
	*varValue = str;
	

	unguardexec;
}

void 
AUnLua::Destroy(void)
{
	lua_close(luaState);
	Super::Destroy();
}

UBOOL
AUnLua::Tick(FLOAT fTime, ELevelTick TickType)
{
    UBOOL ret;

    ret = Super::Tick(fTime, TickType);


	return ret;
}
