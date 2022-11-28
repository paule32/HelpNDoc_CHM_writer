// ---------------------------------------------------------------------------
// chmMaker.pas  Create Microsoft compiled Help files based on HTML.
//               (c) 2022 by IBE-Software - all rights reserved.
//               (c) 2023 by Jens Kallup
//
// license:      IBE-Software License for use with HelpNDoc 8.3
// ---------------------------------------------------------------------------
program chmmaker;

{$IFDEF FPC}{$mode delphi}{$ENDIF}

uses
  Windows, SysUtils, Classes, IniFiles,
  LazFileUtils, FileUtil, chmFileWriter, globals;

var
  i: Integer;
  Filename: String;
  OutFile: TFileStream;

begin
  WriteLn(' ');
  WriteLn('HelpNDoc CHM Project writer (c) 2022 by IBE-Software');
  WriteLn('HelpNDoc 8.3');

  if ParamCount >= 1 then
  begin
    if not FileExists(ParamStr(1)) then
    begin
      WriteLn('Unable to open: ' + ParamStr(1));
      Halt(1);
    end;

    compileTopics        := 0;
    compileLocalLinks    := 0;
    compileInternetLinks := 0;
    compileGraphics      := 0;

    try
      Project        := TChmProject.Create;
      compileIniFile := TIniFile.Create(ParamStr(1));

      Project.OutputFileName   := compileIniFile.ReadString('OPTIONS','Compiled file', 'C:\tmp\output.chm');
      Project.IndexFileName    := compileIniFile.ReadString('OPTIONS','Index file',    'keywords.hhk');
      Project.DefaultPage      := compileIniFile.ReadString('OPTIONS','Default topic', 'index.htm');
      Project.FileName         := ParamStr(1);
      Project.MakeSearchable   := true;
      Project.ScanHtmlContents := true;

      Project.LoadFromhhp(ParamStr(1),false);

      compileIniFile.Free;

      OutFile := TFileStream.Create(Project.OutputFileName, fmCreate or fmOpenWrite);
      Project.WriteChm(OutFile);

      compileTopics := Project.Files.Count;

      if compileLocalLinks > 1 then compileLocalLinks := compileLocalLinks - 1;
      if compileGraphics   > 1 then compileGraphics   := compileGraphics   - 1;

      WriteLn('Compile time: ' + Format('%d minutes, %d seconds',[
      compileMinutes,
      compileSeconds]));

      WriteLn(Format(
      '%-7d Topics'         + #13#10 +
      '%-7d Local links'    + #13#10 +
      '%-7d Internet links' + #13#10 +
      '%-7d Graphics'       + #13#10,[
      compileTopics,
      compileLocalLinks,
      compileInternetLinks,
      compileGraphics]));

      Project.Free;

      WriteLn('done.');
      ExitProcess(0);
    except
      on E: Exception do
      begin
        WriteLn('Exception occur:' + #13#10 + E.Message);
        ExitProcess(1);
      end;
    end;
  end;

  WriteLn('no input file.');
  ExitProcess(0);
end.

