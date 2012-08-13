//=============================================================================
// UnLua.
// Lua Interface for UnrealScript
// Plugin by Hans-Christian Esperer <hc-dx@hcesperer.org>
//=============================================================================

class UnLua extends Actor
    native;
    
var native transient PlayerPawn AssignedPlayer;

native function int runLuaScript(String codeOrBytecode, out String result, out int success);
native function int compileScript(String sourceCode, out String bytecode, out int success);
native function int setGlobalVariable(String varName, String varValue);
native function int getGlobalVariable(String varName, out String varValue);

defaultproperties
{
     bHidden=True
}
