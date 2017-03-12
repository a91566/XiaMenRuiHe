unit funpro;

interface

uses Forms, Windows, DB, DBClient, Classes, StrUtils, SysUtils, ShellAPI, ExtCtrls,
  Messages, Printers, StdCtrls, WinSock, Dialogs,IniFiles;

//var
 // bShowIt: Boolean;

  
function GetStringFromIni(FromFile, Section, Ident: WideString): WideString;
procedure SelectClientDataSetNoTips(strSQL: string);
function EXSQLClientDataSet(EXSQL: string): Boolean;
procedure WaitTime(MSecs: integer);

function SelectShowOrNot: Boolean;
function LinkDBServer: Boolean;


implementation

uses U_DM, DateUtils;

function SelectShowOrNot: Boolean;
begin
  Result:=True;

{var
  strsql: string;
  bRt: Boolean;
begin
  PuID:='';
  bRt := False;
  strsql := 'select ID from NoticeToSysAdmin where alreadyRead=0'; //
  SelectClientDataSetNoTips(strsql);
  with DataModule1.ClientDataSet1 do
  begin
    First;
    while not eof do
    begin   
      if PuID='' then
      begin
        PuID:=FieldByName('ID').AsString; //为了置为已读
      end
      else
      begin
        PuID:=PuID+','+FieldByName('ID').AsString;
      end;
      PuIDSHOW:=PuIDSHOW+'['+FieldByName('ID').AsString+']';
      Next;
    end;
  end;

  if PuID <> '' then
  begin
    PuID:='('+PuID+')';
    bRt := True;
  end;
  Result := bRt; }
end;

function LinkDBServer: Boolean;
var
  temp, strServerIP: string;
  WSAData: TWSAData;
  HostEnt: PHostEnt;
  bRt: Boolean;
begin
  //Memo1.Lines.Text := ''+#13+#10+'连接中,请稍候...';
  //WaitTime(100);
  bRt := False;
  strServerIP := GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'client.ini', 'SYSTEM', 'ServerIP');
  temp := GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'client.ini', 'SYSTEM', 'fs');
  if temp = '1' then //域名解析IP
  begin
    WSAStartup(2, WSAData);
    HostEnt := gethostbyname(PChar(strServerIP));
    if HostEnt <> nil then
    begin
      with HostEnt^ do
        temp := Format('%d.%d.%d.%d', [Byte(h_addr^[0]), Byte(h_addr^[1]), Byte(h_addr^[2]), Byte(h_addr^[3])]);
    end;
    WSACleanup;
    strServerIP := temp;
  end;
  try
    with DataModule1.SC do
    begin
      connected := false;
      Address := strServerIP;
      port := strtoint(GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'client.ini', 'SYSTEM', 'ServerPost'));
      serverguid := GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'client.ini', 'SYSTEM', 'SGUID');
      servername := GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'client.ini', 'SYSTEM', 'SName');
      connected := true;
      bRt := True;
    end;
  except
    on e: Exception do
    begin
    //  Memo1.Font.Color:=clRed;
     // Memo1.Lines.Text := ''+#13+#10+'系统异常.LinkDBServer,'+#13+#10+#13+#10+e.Message+'.';
     // SpeedButton2.Visible:=True;
    end;
  end;
  result := bRt;
end;


function GetStringFromIni(FromFile, Section, Ident: WideString): WideString;
var
  ReadIniFile: TIniFile;
begin
  ReadIniFile := TIniFile.Create(FromFile);
  Result := ReadIniFile.ReadString(Section, Ident, '');
  ReadIniFile.Free;
end;

procedure WaitTime(MSecs: integer);
var
  FirstTickCount, Now: Longint;
begin
  FirstTickCount := Windows.GetTickCount();
  repeat Application.ProcessMessages;
    Now := Windows.GetTickCount();
  until (Now - FirstTickCount >= MSecs) or (Now < FirstTickCount);
end;

procedure SelectClientDataSetNoTips(strSQL: string);
begin
  with DataModule1.ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strSQL);
  end;
end;

function EXSQLClientDataSet(EXSQL: string): Boolean;
var
  temp: string;
begin
  with DataModule1.ClientDataSet2 do
  begin
    temp := RemoteServer.AppServer.fun_peradd(EXSQL);
  end;
  if temp = 'false' then //返回的是字符串
  begin
    result := False;
  end
  else
  begin
    result := True;
  end;
end;


end.

