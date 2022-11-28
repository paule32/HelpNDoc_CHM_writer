// ---------------------------------------------------------------------------
// globals.pas   Create Microsoft compiled Help files based on HTML.
//               (c) 2022 by IBE-Software - all rights reserved.
//               (c) 2023 by Jens Kallup
//
// license:      IBE-Software License for use with HelpNDoc 8.3
// ---------------------------------------------------------------------------
unit globals;

{$IFDEF FPC}{$mode delphi}{$ENDIF}

interface

uses
  Classes, SysUtils, IniFiles, chmFileWriter;

var
  compileMinutes: Integer;
  compileSeconds: Integer;

  compileTopics        : Integer;
  compileLocalLinks    : Integer;
  compileInternetLinks : Integer;
  compileGraphics      : Integer;

  compileFileName : String;
  compileFile     : File of Byte;

  compileIniFile  : TIniFile;
  compileChmFile  : String;

  Project: TChmProject;
implementation

end.

