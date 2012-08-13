# Microsoft Developer Studio Project File - Name="ModPlug" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** NICHT BEARBEITEN **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=ModPlug - Win32 Debug
!MESSAGE Dies ist kein gültiges Makefile. Zum Erstellen dieses Projekts mit NMAKE
!MESSAGE verwenden Sie den Befehl "Makefile exportieren" und führen Sie den Befehl
!MESSAGE 
!MESSAGE NMAKE /f "UnLua.mak".
!MESSAGE 
!MESSAGE Sie können beim Ausführen von NMAKE eine Konfiguration angeben
!MESSAGE durch Definieren des Makros CFG in der Befehlszeile. Zum Beispiel:
!MESSAGE 
!MESSAGE NMAKE /f "UnLua.mak" CFG="ModPlug - Win32 Debug"
!MESSAGE 
!MESSAGE Für die Konfiguration stehen zur Auswahl:
!MESSAGE 
!MESSAGE "ModPlug - Win32 Release" (basierend auf  "Win32 (x86) Dynamic-Link Library")
!MESSAGE "ModPlug - Win32 Debug" (basierend auf  "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "ModPlug___Win32_Release"
# PROP BASE Intermediate_Dir "ModPlug___Win32_Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "UnLua___Win32_Release"
# PROP Intermediate_Dir "UnLua___Win32_Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "MODPLUG_EXPORTS" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "WINDOWS" /D "_WINDOWS" /D "UNICODE" /D "_UNICODE" /D UNLUA_API=__declspec(dllexport) /FR /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib Lib/Engine.lib Lib/Core.lib /nologo /dll /machine:I386 /out:"..\System\UnLua.dll"

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "ModPlug___Win32_Debug"
# PROP BASE Intermediate_Dir "ModPlug___Win32_Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "UnLua___Win32_Debug"
# PROP Intermediate_Dir "UnLua___Win32_Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "MODPLUG_EXPORTS" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "MODPLUG_EXPORTS" /Yu"stdafx.h" /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept

!ENDIF 

# Begin Target

# Name "ModPlug - Win32 Release"
# Name "ModPlug - Win32 Debug"
# Begin Group "Quellcodedateien"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\lapi.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lauxlib.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lbaselib.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lbitlib.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lcode.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lcorolib.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lctype.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\ldblib.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\ldebug.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\ldo.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\ldump.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lfunc.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lgc.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\linit.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\liolib.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\llex.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lmathlib.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lmem.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\loadlib.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lobject.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lopcodes.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\loslib.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lparser.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lstate.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lstring.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lstrlib.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\ltable.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\ltablib.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\ltm.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lundump.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lvm.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\lzio.c

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc"
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc" /Yc"stdafx.h"

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

# ADD CPP /Yc"stdafx.h"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\UnLua.cpp

!IF  "$(CFG)" == "ModPlug - Win32 Release"

# ADD CPP /I "Inc" /Yu"stdafx.h"

!ELSEIF  "$(CFG)" == "ModPlug - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "Header-Dateien"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\Inc\A3D.h
# End Source File
# Begin Source File

SOURCE=.\Inc\AActor.h
# End Source File
# Begin Source File

SOURCE=.\Inc\AAugmentation.h
# End Source File
# Begin Source File

SOURCE=.\Inc\AAugmentationManager.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ABrush.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ACamera.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ADeusExDecoration.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ADeusExLevelInfo.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ADeusExPlayer.h
# End Source File
# Begin Source File

SOURCE=.\Inc\afxres.h
# End Source File
# Begin Source File

SOURCE=.\Inc\AGameReplicationInfo.h
# End Source File
# Begin Source File

SOURCE=.\Inc\AInternetLink.h
# End Source File
# Begin Source File

SOURCE=.\Inc\AInventory.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Amd3d.h
# End Source File
# Begin Source File

SOURCE=.\Inc\AMover.h
# End Source File
# Begin Source File

SOURCE=.\Inc\APawn.h
# End Source File
# Begin Source File

SOURCE=.\Inc\APlayerPawn.h
# End Source File
# Begin Source File

SOURCE=.\Inc\APlayerReplicationInfo.h
# End Source File
# Begin Source File

SOURCE=.\Inc\AScriptedPawn.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ATcpLink.h
# End Source File
# Begin Source File

SOURCE=.\Inc\AUdpLink.h
# End Source File
# Begin Source File

SOURCE=.\Inc\AZoneInfo.h
# End Source File
# Begin Source File

SOURCE=.\Inc\begin_code.h
# End Source File
# Begin Source File

SOURCE=.\Inc\close_code.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConAudioList.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConCamera.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConChoice.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEvent.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventAddCredits.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventAddGoal.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventAddNote.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventAddSkillPoints.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventAnimation.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventCheckFlag.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventCheckObject.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventCheckPersona.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventChoice.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventComment.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventEnd.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventJump.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventMoveCamera.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventRandomLabel.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventSetFlag.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventSpeech.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventTrade.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventTransferObject.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConEventTrigger.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConFlagRef.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConHistory.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConHistoryEvent.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConImport.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConItem.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConListItem.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConObject.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConSpeech.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConSys.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConUtils.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Conversation.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConversationList.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ConversationMIssionList.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Core.h
# End Source File
# Begin Source File

SOURCE=.\Inc\CorePrivate.h
# End Source File
# Begin Source File

SOURCE=.\Inc\d3d.h
# End Source File
# Begin Source File

SOURCE=.\Inc\d3dcaps.h
# End Source File
# Begin Source File

SOURCE=.\Inc\D3DDrv.h
# End Source File
# Begin Source File

SOURCE=.\Inc\d3drm.h
# End Source File
# Begin Source File

SOURCE=.\Inc\d3drmdef.h
# End Source File
# Begin Source File

SOURCE=.\Inc\d3drmobj.h
# End Source File
# Begin Source File

SOURCE=.\Inc\d3drmwin.h
# End Source File
# Begin Source File

SOURCE=.\Inc\d3dtypes.h
# End Source File
# Begin Source File

SOURCE=.\Inc\d3dx.h
# End Source File
# Begin Source File

SOURCE=.\Inc\d3dxcore.h
# End Source File
# Begin Source File

SOURCE=.\Inc\d3dxerr.h
# End Source File
# Begin Source File

SOURCE=.\Inc\d3dxmath.h
# End Source File
# Begin Source File

SOURCE=.\Inc\d3dxshapes.h
# End Source File
# Begin Source File

SOURCE=.\Inc\d3dxsprite.h
# End Source File
# Begin Source File

SOURCE=.\Inc\DbgInfoCpp.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Ddc.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ddraw.h
# End Source File
# Begin Source File

SOURCE=.\Inc\DeusEx.h
# End Source File
# Begin Source File

SOURCE=.\Inc\DeusExClasses.h
# End Source File
# Begin Source File

SOURCE=.\Inc\DeusExGameEngine.h
# End Source File
# Begin Source File

SOURCE=.\Inc\DeusExText.h
# End Source File
# Begin Source File

SOURCE=.\Inc\DeusExTextParser.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dinput.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dinputd.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dls1.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dls2.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dmdls.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dmerror.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dmksctrl.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dmusbuff.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dmusicc.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dmusicf.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dmusici.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dplay.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dplobby.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dsound.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dvp.h
# End Source File
# Begin Source File

SOURCE=.\Inc\dxfile.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Editor.h
# End Source File
# Begin Source File

SOURCE=.\Inc\EditorClasses.h
# End Source File
# Begin Source File

SOURCE=.\Inc\EditorPrivate.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Engine.h
# End Source File
# Begin Source File

SOURCE=.\Inc\EngineClasses.h
# End Source File
# Begin Source File

SOURCE=.\Inc\EnginePrivate.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtBorder.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtButton.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtCheckbox.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtClipWindow.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtComputerWindow.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtEdit.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtEditorEngine.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Extension.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtensionCore.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtFlag.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtFlagBase.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtGameDirectory.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtGameEngine.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtGC.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtInput.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtLargeText.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtList.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtModal.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtObject.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtPlayerPawn.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtRadioBox.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtRoot.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtScale.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtScaleManager.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtScrollArea.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtString.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtTabGroup.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtText.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtTextLog.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtTile.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtToggle.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtViewport.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtWindow.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ExtWindowCore.h
# End Source File
# Begin Source File

SOURCE=.\Inc\fastfile.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FCodec.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FConfigCacheIni.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FFeedbackContextAnsi.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FFeedbackContextWindows.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FFileManagerAnsi.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FFileManagerGeneric.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FFileManagerLinux.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FFileManagerWindows.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FireClasses.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FMallocAnsi.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FMallocDebug.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FMallocWindows.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FOutputDeviceAnsiError.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FOutputDeviceFile.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FOutputDeviceNull.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FOutputDeviceStdout.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FOutputDeviceWindowsError.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FractalPrivate.h
# End Source File
# Begin Source File

SOURCE=.\Inc\FRiffChunk.h
# End Source File
# Begin Source File

SOURCE=.\Inc\GameSpyClasses.h
# End Source File
# Begin Source File

SOURCE=.\Inc\GameSpyClassesPublic.h
# End Source File
# Begin Source File

SOURCE=.\Inc\glext.h
# End Source File
# Begin Source File

SOURCE=.\Inc\glide.h
# End Source File
# Begin Source File

SOURCE=.\Inc\glidesys.h
# End Source File
# Begin Source File

SOURCE=.\Inc\glideutl.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Hooksgl.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ia3dapi.h
# End Source File
# Begin Source File

SOURCE=.\Inc\IpDrvClasses.h
# End Source File
# Begin Source File

SOURCE=.\Inc\IpDrvPrivate.h
# End Source File
# Begin Source File

SOURCE=.\Inc\LaunchPrivate.h
# End Source File
# Begin Source File

SOURCE=.\Inc\LaunchRes.h
# End Source File
# Begin Source File

SOURCE=.\Inc\libmodplug.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Line.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Line1.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Metal.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ModPlug.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ModPlugClasses.h
# End Source File
# Begin Source File

SOURCE=.\Inc\multimon.h
# End Source File
# Begin Source File

SOURCE=.\Inc\OpenGlDrv.h
# End Source File
# Begin Source File

SOURCE=.\Inc\OpenGlFuncs.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Palette.h
# End Source File
# Begin Source File

SOURCE=.\Inc\RenderPrivate.h
# End Source File
# Begin Source File

SOURCE=.\Inc\resource.h
# End Source File
# Begin Source File

SOURCE=.\Inc\rmxfguid.h
# End Source File
# Begin Source File

SOURCE=.\Inc\rmxftmpl.h
# End Source File
# Begin Source File

SOURCE=.\Inc\S3tc.h
# End Source File
# Begin Source File

SOURCE=.\Inc\SerialNumber.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Setup.h
# End Source File
# Begin Source File

SOURCE=.\Inc\SetupPrivate.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Sgl.h
# End Source File
# Begin Source File

SOURCE=.\Inc\SoftDrvPrivate.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# Begin Source File

SOURCE=.\Inc\TextImport.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UBrushBuilder.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UDataVaultImageNote.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UDebugInfo.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UDeusExLog.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UDeusExSaveInfo.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UDumpLocation.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UExporter.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UFactory.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ULaserIterator.h
# End Source File
# Begin Source File

SOURCE=.\Inc\ULevelSummary.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnActor.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnArc.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnAudio.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnBits.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnBuild.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnBunch.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnCache.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnCamera.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnChan.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnCId.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnClass.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnCon.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnConn.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnCoreNet.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnCorObj.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnDDraw.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnDemoPenLev.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnDemoRec.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnDynBsp.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnEdTran.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnEngine.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnEngineGnuG.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnEngineWin.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnEventManager.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnFile.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnGame.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnGnuG.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnIn.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnLevel.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnLinker.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnLua.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnLuaClasses.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnMath.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnMem.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnMesh.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnMeshRnLOD.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnModel.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnName.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnNames.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnNet.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnNetDrv.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnObj.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnObjBas.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnObjVer.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnPath.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnPenLev.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnPlayer.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnPrim.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnReach.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnRender.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnRenderIterator.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnRenDev.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnScrCom.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnScript.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnScrTex.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Unsgl.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnSocket.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnSpan.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnStack.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnTemplate.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnTex.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnTopics.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnType.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnUnix.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnURL.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnVcWin32.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UnVcWn32SSE.h
# End Source File
# Begin Source File

SOURCE=.\Inc\uparticle.h
# End Source File
# Begin Source File

SOURCE=.\Inc\UParticleIterator.h
# End Source File
# Begin Source File

SOURCE=.\Inc\USetupDefinitionWindows.h
# End Source File
# Begin Source File

SOURCE=.\Inc\Window.h
# End Source File
# Begin Source File

SOURCE=.\Inc\WindowRes.h
# End Source File
# Begin Source File

SOURCE=.\Inc\WinDrv.h
# End Source File
# Begin Source File

SOURCE=.\Inc\WinDrvRes.h
# End Source File
# End Group
# Begin Group "Ressourcendateien"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# Begin Source File

SOURCE=.\ReadMe.txt
# End Source File
# End Target
# End Project
