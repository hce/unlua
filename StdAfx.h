// stdafx.h : Include-Datei f�r Standard-System-Include-Dateien,
//  oder projektspezifische Include-Dateien, die h�ufig benutzt, aber
//      in unregelm��igen Abst�nden ge�ndert werden.
//

#if !defined(AFX_STDAFX_H__C00771B1_4087_40CA_A3BC_9DF6D8F52126__INCLUDED_)
#define AFX_STDAFX_H__C00771B1_4087_40CA_A3BC_9DF6D8F52126__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

// F�gen Sie hier Ihre Header-Dateien ein
//#define WIN32_LEAN_AND_MEAN		// Selten benutzte Teile der Windows-Header nicht einbinden

#include <windows.h>

// ZU ERLEDIGEN: Verweisen Sie hier auf zus�tzliche Header-Dateien, die Ihr Programm ben�tigt
#include "Inc/Engine.h"
#include "Inc/Core.h"

extern "C" {
	#include "Inc/lua.h"
	#include "Inc/lualib.h"
	#include "Inc/lauxlib.h"
}


#include "Inc/UnLuaClasses.h"



//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ f�gt zus�tzliche Deklarationen unmittelbar vor der vorherigen Zeile ein.

#endif // !defined(AFX_STDAFX_H__C00771B1_4087_40CA_A3BC_9DF6D8F52126__INCLUDED_)
