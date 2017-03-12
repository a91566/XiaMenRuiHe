unit funpro;

interface

uses Forms, Windows, DB, DBClient, Classes, StrUtils, SysUtils, ShellAPI, ExtCtrls,
  Messages, Printers, StdCtrls, WinSock, Dialogs;

var
  Pu_Un: string;
  bShowIt: Boolean;


function GetStringFromIni(FromFile, Section, Ident: WideString): WideString; stdcall; external 'OperIniFile.dll';
function SetStringToIni(ToFile, Section, Ident, strValue: WideString): Boolean; stdcall; external 'OperIniFile.dll';

procedure SelectClientDataSetNoTips(strSQL: string);
function EXSQLClientDataSet(EXSQL: string): Boolean;
procedure WaitTime(MSecs: integer);

function SelectShowOrNot: Boolean;
function LinkDBServer: Boolean;


implementation

uses UMain, U_DM, DateUtils;

function SelectShowOrNot: Boolean;
var
  strsql, temp: string;
  ids: Integer;
  bRt: Boolean;
begin
  Pu_Un := '';
  ids := 0;
  bRt := False;
  temp := GetStringFromIni(ExtractFilePath(ParamStr(0)) + 'config.ini', 'config', 'username');
  if temp = 'fzlzbarcode' then temp := 'zsb';
  strsql := 'select username from userinfo where usercode=''' + temp + ''''; //查姓名
  SelectClientDataSetNoTips(strsql);
  if DataModule1.ClientDataSet1.RecordCount = 1 then
  begin
    Pu_Un := DataModule1.ClientDataSet1.FieldByName('username').AsString; ;
  end;
  if Pu_Un <> '' then
  begin
    strsql := 'select count(id) ids from kqb where ygxm=''' + Pu_Un +
      ''' and rq>=''' + FormatDateTime('yyyy年MM月dd日', now() - 30) + ''''; //查最近30天考勤记录 
    SelectClientDataSetNoTips(strsql);
    if DataModule1.ClientDataSet1.RecordCount = 1 then
    begin
      ids := DataModule1.ClientDataSet1.FieldByName('ids').AsInteger;
    end;
  end;



  if ids > 10 then //最近30天内有10条的考勤记录给予提醒
  begin
    bRt := True;
  end;
  Result := bRt;
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
    data := RemoteServer.AppServer.Zsb_getdatasql(strSQL, 'ShowUpForDaKa.Exe');
  end;
end;

function EXSQLClientDataSet(EXSQL: string): Boolean;
var
  temp: string;
begin
  with DataModule1.ClientDataSet2 do
  begin
    temp := RemoteServer.AppServer.zsb_exsql(EXSQL, 'ShowUpForDaKa.Exe');
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

