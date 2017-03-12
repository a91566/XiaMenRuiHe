unit ZsbFunPro;

interface

uses
  Windows, Forms, DBClient, SysUtils, ShellAPI, Messages, rzpanel, rzedit, RzCmboBx, RzBtnEdt,
  Classes, StrUtils;

  {dxCntner, dxEditor, dxExEdtr, dxEdLib for TdxCurrencyEdit}

procedure AddLog_ExSQLText(TempExSQL: string);
function EXSQLClientDataSetNoLog(ClientDataSet1: TClientDataSet; EXSQL: string): Boolean;
function EXSQLClientDataSet(ClientDataSet1: TClientDataSet; EXSQL: string): Boolean;
function SelectClientDataSetResultCount(ClientDataSet1: TClientDataSet; strSQL: string): Integer;
function SelectClientDataSetResultFieldCaption(ClientDataSet1: TClientDataSet; strSQL, FieldName: string): string;
procedure SelectClientDataSet(ClientDataSet1: TClientDataSet; strSQL: string);
procedure SelectClientDataSetNoTips(ClientDataSet1: TClientDataSet; strSQL: string);

function MsgBoxOk(sInfo: string): Boolean;
function MsgErrorInfo_RetryCancel(ErInfo: string): Boolean;
function GetPyChar(const HZ: AnsiString): string;
function GetYMXXSl(strtemp: string; strtype: string): Boolean;
function GetYMXXStr(strtemp: string; strtype: string): Boolean;
function GetCRKDH(bRk: Boolean): string;
function DownKC(strbm: string; strph: string; iSL: SmallInt): string;
function CheckKC(strbm: string; strph: string; iSL: SmallInt): Boolean;
function SelectDeptOrDepotName(strCode: string): string;
function isCanUsesGoOn: Boolean;
function isSuprAdmin: Boolean;
function isAdmin: Boolean;

procedure MsgBoxInfo(sInfo: string);
procedure MsgErrorInfo(ErInfo: string);
procedure PleaseWait(i_StartOrExit: SmallInt);
procedure ClearEditAndBox(RzPanel1: TRzPanel; b: Boolean);
procedure AddUpdateDelBtnEnabled(RzPanel1: TRzPanel; b: Boolean);
procedure LocateClientDataSet(ClientDataSet1: TClientDataSet; field: string; value: string);
procedure ComboxLoadFromFile(ComboBox1: TRzComboBox; filepath: string);
procedure GetDateTimeSecond;
procedure GetDateTimeDate;
procedure AddRzComcomboBoxFromTable(Combox: TRzComboBox; TableName: string; FieldName: string);
procedure ShowBox(sShowMessage: string; iShowMode: Integer = 0);
procedure UpdateLastCompileTime;
procedure zsbSimpleMSNPopUpShow(strText: string; booalBottom: Boolean = True);
procedure ShowTrayWndOrNot(b: Boolean);
procedure ShowFullScreenOrNot(b: Boolean);
procedure SaveMessage(strMess: string; FileType: string='sql'; FileName: string = '');
procedure IncFuncCodeUsesTime(funccode: string);
procedure WaitTime(MSecs: integer);
procedure AddLog_ErrorText(TempExSQL: string);
procedure AddLog_Operation(TempExSQL: string);

implementation

uses U_main, ZsbVariable, ZsbDLL, UDM;

{$I 'FechaCompilacion.inc'}

///////////----------------------------------

procedure WaitTime(MSecs: integer);
var
  FirstTickCount, Now: Longint;
begin
  FirstTickCount := Windows.GetTickCount();
  repeat Application.ProcessMessages;
    Now := Windows.GetTickCount();
  until (Now - FirstTickCount >= MSecs) or (Now < FirstTickCount);
end;

procedure IncFuncCodeUsesTime(funccode: string);
var
  exsql: string;
begin
  exsql := 'update funcmenu set usestime=usestime+1 where funccode=''' + funccode + '''';
  EXSQLClientDataSet(FDM.ClientDataSet2, exsql);
end;

procedure SaveMessage(strMess: string; FileType: string='sql'; FileName: string = '');
var //���ݣ���׺��
  sl: TStringList;
  temp: string;
begin
  if FileName = '' then
  begin
    temp := ExtractFilePath(Application.Exename) + 'SYSLOGS';
    if not DirectoryExists(temp) then
    begin
      CreateDir(temp);
    end;
    temp := temp + '/' + FormatDateTime('yyyyMMddhhmmss', Now) + '.' + FileType;
  end
  else
  begin
    temp := ExtractFilePath(Application.Exename) + FileName + '.' + FileType;
  end;
  sl := TStringList.Create;
  sl.Add(strMess);
  sl.SaveToFile(temp);
  sl.Free;
end;

function isCanUsesGoOn: Boolean; //2014��11��19�� 09:40:44
var
  strsql: string;
  iRt: Boolean;
begin
  //�� ���� id Ϊ1 ��VvΪ1�������ϵͳ����ʹ��
  strSQL := 'select Vv from US where id=1';
  SelectClientDataSet(FDM.ClientDataSet1, strSQL);
  iRt := FDM.ClientDataSet1.FieldByName('Vv').AsBoolean;
  if iRt = True then
  begin
    strSQL := 'select ForceLost from staff where usercode=''' + zstrusercode + '''';
    SelectClientDataSet(FDM.ClientDataSet1, strSQL);
    iRt := FDM.ClientDataSet1.FieldByName('ForceLost').AsBoolean;
  end;
  Result := iRt;
end;

function isSuprAdmin: Boolean;
var
  bTemp: Boolean;
begin
  bTemp := False;
  if ZStrUserCode = 'admin' then
  begin
    bTemp := True;
  end;
  Result := bTemp;
end;

function isAdmin: Boolean;
var
  strsql: string;
  bTemp: Boolean;
begin
  bTemp := False;
  strsql := 'select id from staff where usercode=''' + ZStrUserCode + ''' and usertype in (''��������Ա'',''����Ա'')';
  if SelectClientDataSetResultCount(FDM.ClientDataSet1, strsql) >= 1 then
  begin
    bTemp := True;
  end;
  SaveMessage(strsql, 'sql');
  Result := bTemp;
end;

function SelectDeptOrDepotName(strCode: string): string;
var //2014��3��25�� 17:22:20 ��ɾ��
  strsql, temp: string;
begin //��ѯ���һ��ֿ߲����� ��ƴ����˺��񣬲ֿ��벿��û�з���ͬһ������
  strSQL := 'select DeptName from DepartMent where DeptCode=''' + strCode + '''';
  temp := SelectClientDataSetResultFieldCaption(FDM.ClientDataSet1, strSQL, 'DeptName');
  if temp = '' then
  begin
    strSQL := 'select DepotName from Depot where DepotCode=''' + strCode + '''';
    temp := SelectClientDataSetResultFieldCaption(FDM.ClientDataSet1, strSQL, 'DepotName');
  end;
  Result := temp;
end;

procedure ShowFullScreenOrNot(b: Boolean);
begin
  if b then
  begin
    F_main.Height := Screen.Height;
  end
  else
  begin
    F_main.Height := Screen.Height - 30;
  end;
end;

procedure ShowTrayWndOrNot(b: Boolean);
var //��ʾ���������
  hWnd: Integer;
begin
  hWnd := FindWindow('Shell_TrayWnd', '');
  if b then
  begin
    ShowWindow(hWnd, SW_SHOW); //��ʾ
    F_main.Height := Screen.Height - 30;
  end
  else
  begin
    ShowWindow(hWnd, SW_HIDE); //����
    F_main.Height := Screen.Height;
  end;
end;


procedure zsbSimpleMSNPopUpShow(strText: string; booalBottom: Boolean = True);
var
  itemp, ix, iy: SmallInt;
begin
 {
  MSNPopUp1.Width:=200;
  MSNPopUp11.Height := 50;
  }
  itemp := F_main.Width + 300;
  itemp := itemp div 2;
  itemp := itemp + F_main.Left;
  itemp := Screen.Width - itemp;
  ix := itemp;
  iy := Screen.Height - F_main.Top - F_main.Height + 20;
  SimpleMSNPopUpShow(strText, ix, iy);
end;

procedure AddLog_ErrorText(TempExSQL: string);
var
  exsql, temp: string;
begin
  temp := StringReplace(TempExSQL, '''', '''''', [rfReplaceAll]); //����е����ŵ��滻
  exsql := 'insert into Log_ErrorText(Text,DT,UN) values(''' + temp + ''',''' +
    FormatDateTime('yyyy-MM-dd hh:mm:ss', Now) + ''',''' + ZStrUser + ''')';

  with FDM.ClientDataSet2 do
  begin
    temp := RemoteServer.AppServer.fun_peradd(EXSQL);
  end;
  if temp = 'false' then //���ص����ַ���
  begin
    zsbSimpleMSNPopUpShow('AddLog_ErrorText ����ʧ��,����ϵ����Ա.');
  end;
end;

procedure AddLog_Operation(TempExSQL: string);
var
  exsql, temp: string;
begin
  temp := StringReplace(TempExSQL, '''', '''''', [rfReplaceAll]); //����е����ŵ��滻
  exsql := 'insert into Log_Operation(Text,dt,un) values(''' + temp + ''',''' +
    FormatDateTime('yyyy-MM-dd hh:mm:ss', Now) + ''',''' + ZStrUser + ''')';

  with FDM.ClientDataSet2 do
  begin
    temp := RemoteServer.AppServer.fun_peradd(EXSQL);
  end;
  if temp = 'false' then //���ص����ַ���
  begin
    zsbSimpleMSNPopUpShow('Log_Operation ����ʧ��,����ϵ����Ա.');
  end;
end;

function CheckKC(strbm: string; strph: string; iSL: SmallInt): Boolean;
var
  temp: string;
begin //��֤�ܷ����
  Result := False;
  if (strbm = '') or (strph = '') or (iSL < 0) then Exit;
  temp := 'select sum(kcs) kcs from rkmxb where bm=''' + strbm + ''' and ph=''' + strph + '''';
  SelectClientDataSet(FDM.ClientDataSet1, temp);
  if FDM.ClientDataSet1.FieldByName('kcs').AsInteger >= iSL then Result := True;
end;

function DownKC(strbm: string; strph: string; iSL: SmallInt): string;
var //
  temp, exsql: string;
  itemp: SmallInt;
begin
  Result := '';
  exsql := '';
  if (strbm = '') or (strph = '') or (iSL < 0) then Exit;
  itemp := iSL;
  temp := 'select kcs,rkdh from rkmxb where bm=''' + strbm + ''' and ph=''' + strph + ''' order by rkdh';
  SelectClientDataSet(FDM.ClientDataSet1, temp);
  if FDM.ClientDataSet1.RecordCount = 0 then Exit;
  with FDM.ClientDataSet1 do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('kcs').AsInteger >= itemp then //������
      begin //����Ҫ�Ӵ˳�ȥ
        exsql := exsql + 'update rkmxb set kcs=kcs-' + inttostr(itemp) + ' where rkdh=''' + FieldByName('rkdh').AsString +
          ''' and bm=''' + strbm + ''' and ph=''' + strph + ''';';
        Break;
      end
      else
      begin
        exsql := exsql + 'update rkmxb set kcs=kcs-kcs where rkdh=''' + FieldByName('rkdh').AsString +
          ''' and bm=''' + strbm + ''' and ph=''' + strph + ''';';
        itemp := itemp - FieldByName('kcs').AsInteger;
        Next;
      end;
    end;
  end;
  Result := exsql;
end;

procedure UpdateLastCompileTime;
var //�����°汾
  strsql, temp, exsql, sLastCompileTime: string;
begin
  sLastCompileTime := FechaCompilacion + ' ' + HoraCompilacion;
  strsql := 'select LASTCOMPILETIME from unit where id=''1''';
  SelectClientDataSet(FDM.ClientDataSet1, strsql);
  exsql := '';
  if FDM.ClientDataSet1.RecordCount = 0 then
  begin
    exsql := 'insert into unit(id,ver,LASTCOMPILETIME)values(''1'',''' + GetVersionString(Application.ExeName) + ''',''' + sLastCompileTime + ''')';
  end
  else
  begin
    temp := FDM.ClientDataSet1.fieldbyname('LASTCOMPILETIME').AsString;
    if temp < sLastCompileTime then //�����ǰ���������°�ľ͸���
    begin
      exsql := 'update unit set ver=''' + GetVersionString(Application.ExeName) + ''',LASTCOMPILETIME=''' + sLastCompileTime + ''' where id=''1''';
    end;
  end;
  if exsql <> '' then
  begin
    if EXSQLClientDataSet(FDM.ClientDataSet2, exsql) then
    begin
      //MessageShow('�°汾�������.');
    end
    else
    begin
      //MessageShow('�°汾����ʧ��.');
    end;
  end;
end;

procedure ShowBox(sShowMessage: string; iShowMode: Integer = 0);
begin

end;

procedure AddRzComcomboBoxFromTable(Combox: TRzComboBox; TableName: string; FieldName: string); //�����ݿ���߼����ֶε� RzComcomboBox
var //1 �ؼ� 2 ���� 3�ֶ���     ����   ���ظ�
  strsql: string;
begin
  strsql := 'select distinct ' + FieldName + ' from ' + TableName + ' order by ' + FieldName;
  with FDM.ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strsql);
    First;
    Combox.Clear;
    Combox.Items.Add('');
    while not Eof do
    begin
      Combox.Items.Add(fieldbyname(FieldName).AsString);
      Next;
    end;
  end;
end;

procedure GetDateTimeDate; //��ȡ��ǰʱ��
var
  s: string;
begin
  with FDM.getdatetime do
  begin
    s := 'select to_char(sysdate,' + '''yyyy-mm-dd''' + ')now from dual';
    data := RemoteServer.AppServer.fun_getdatasql(s);
    ZStrDate := Fieldbyname('now').AsString;
  end;
end;

procedure GetDateTimeSecond; //��ȡ��ǰʱ�� ��ȷ����
var
  s: string;
begin
  with FDM.getdatetime do
  begin
    s := 'select to_char(sysdate,' + '''HH24:MI:SS''' + ')now from dual';
    data := RemoteServer.AppServer.fun_getdatasql(s);
    ZStrTime := Fieldbyname('now').AsString;
  end;
end;

function GetCRKDH(bRk: Boolean): string;
var //ֻ������1-99  �� һ�쵥�Ӳ�����100��
  temp, strsql, strResult: string;
  n, mo: SmallInt;
begin //��ȡ��ⵥ��  true��� false ����
  temp := FormatDateTime('yyyy', Now);
  strResult := temp;
  temp := FormatDateTime('M', Now);
  n := StrToInt(temp);
  if n >= 10 then
  begin
    mo := n mod 36;
    case mo of
      10..35: temp := chr(mo + 55);
    end;
  end;
  strResult := strResult + temp;
  temp := FormatDateTime('d', Now);
  n := StrToInt(temp);
  if n >= 10 then
  begin
    mo := n mod 36;
    case mo of
      10..35: temp := chr(mo + 55);
    end;
  end;
  strResult := strResult + temp;
  if bRk then
  begin
    strResult := 'R' + strResult; //���
    strsql := 'select rkdh from rkzb where rkrq=''' + ZStrDate + ''' order by rkdh desc';
  end
  else
  begin
    strResult := 'C' + strResult; //���
    strsql := 'select ckdh from ckzb where ckrq=''' + ZStrDate + ''' order by ckdh desc';
  end;
  with FDM.ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strsql);
  end;
  if FDM.ClientDataSet1.RecordCount <= 0 then
  begin
    temp := '0';
  end
  else
  begin
    FDM.ClientDataSet1.First;
    if bRk then
    begin
      temp := FDM.ClientDataSet1.fieldbyname('rkdh').AsString;
    end
    else
    begin
      temp := FDM.ClientDataSet1.fieldbyname('ckdh').AsString;
    end;
    temp := RightStr(temp, 2);
  end;
  temp := IntToStr(StrToInt(temp) + 1);
  if Length(temp) <> 2 then temp := '0' + temp;
  strResult := strResult + temp;
  Result := strResult;
end;

function GetYMXXStr(strtemp: string; strtype: string): Boolean;
var //1 ֵ   2 ���ͣ���������
  temp: string;
begin
  Result := False;
  if (strtype <> 'bm') and (strtype <> 'tm') then Exit;
  temp := 'select bm,tm,mc,gg,dw,lb,jx,jg,jk,gys,sccj from ymxx where';
  if (strtype = 'bm') then
  begin
    temp := temp + ' bm=''' + strtemp + '''';
  end
  else if strtype = 'tm' then
  begin
    temp := temp + ' tm=''' + strtemp + '''';
  end;
  with FDM.ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(temp);
  end;
  if FDM.ClientDataSet1.RecordCount = 1 then
  begin
    Result := True;
    ZSLYMXX.StrBm := FDM.ClientDataSet1.FieldByName('bm').AsString;
    ZSLYMXX.StrTm := FDM.ClientDataSet1.FieldByName('tm').AsString;
    ZSLYMXX.StrMc := FDM.ClientDataSet1.FieldByName('mc').AsString;
    ZSLYMXX.StrGg := FDM.ClientDataSet1.FieldByName('gg').AsString;
    ZSLYMXX.StrDw := FDM.ClientDataSet1.FieldByName('dw').AsString;
    ZSLYMXX.StrLb := FDM.ClientDataSet1.FieldByName('lb').AsString;
    ZSLYMXX.StrJx := FDM.ClientDataSet1.FieldByName('jx').AsString;
    ZSLYMXX.StrJg := FDM.ClientDataSet1.FieldByName('jg').AsString;
    ZSLYMXX.StrJk := FDM.ClientDataSet1.FieldByName('jk').AsString;
    ZSLYMXX.StrGys := FDM.ClientDataSet1.FieldByName('gys').AsString;
    ZSLYMXX.StrSccj := FDM.ClientDataSet1.FieldByName('sccj').AsString;
  end;
end;

function GetYMXXSl(strtemp: string; strtype: string): Boolean;
begin
  Result := False;
  if (strtype <> 'bm') or (strtype <> 'tm') then Exit;
  if (strtype = 'bm') or (strtype = 'tm') then
  begin
    ZSLYMXX.SlBm := TStringList.Create;
    ZSLYMXX.SlTm := TStringList.Create;
    ZSLYMXX.SlMc := TStringList.Create;
    ZSLYMXX.SlGg := TStringList.Create;
    ZSLYMXX.SlDw := TStringList.Create;
    ZSLYMXX.SlLb := TStringList.Create;
    ZSLYMXX.SlJx := TStringList.Create;
    ZSLYMXX.SlJg := TStringList.Create;
    ZSLYMXX.SlGys := TStringList.Create;
    ZSLYMXX.SlSccj := TStringList.Create;
  end;
  if (strtype = 'bm') then
  begin

  end
  else if strtype = 'tm' then
  begin

  end;
end;

procedure ComboxLoadFromFile(ComboBox1: TRzComboBox; filepath: string);
var
  sl: TStringList;
begin //  ComboBox1  ���ļ�����
  ComboBox1.Items.Clear;
  sl := TStringList.Create();
  sl.LoadFromFile(filepath);
  ComboBox1.Items.Text := sl.Text;
  sl.Free;
end;

procedure LocateClientDataSet(ClientDataSet1: TClientDataSet; field: string; value: string);
begin //��λ
  ClientDataSet1.Locate(field, value, []);
end;

procedure AddUpdateDelBtnEnabled(RzPanel1: TRzPanel; b: Boolean);
begin //����һ TRzPanel�ؼ��� ;������ �Ƿ���combobox {��ť������������ɾ�����޸ġ�ȡ�������� �����ť}
       //������ ��Ϊ˳����Ԥ�������
  if b then
  begin
    RzPanel1.Controls[0].Enabled := False; // 0 ����
    MsgBoxInfo(RzPanel1.Controls[0].Name);
    RzPanel1.Controls[1].Enabled := False; // 1 ɾ��
    MsgBoxInfo(RzPanel1.Controls[1].Name);
    RzPanel1.Controls[2].Enabled := False; // 2 �޸�
    MsgBoxInfo(RzPanel1.Controls[2].Name);
    RzPanel1.Controls[3].Enabled := True; // 3 ȡ��
    MsgBoxInfo(RzPanel1.Controls[3].Name);
    RzPanel1.Controls[4].Enabled := True; // 4 ����
    MsgBoxInfo(RzPanel1.Controls[4].Name);
  end
  else
  begin
    RzPanel1.Controls[0].Enabled := True;
    RzPanel1.Controls[1].Enabled := True;
    RzPanel1.Controls[2].Enabled := True;
    RzPanel1.Controls[3].Enabled := False;
    RzPanel1.Controls[4].Enabled := False;
  end;
end;

procedure ClearEditAndBox(RzPanel1: TRzPanel; b: Boolean);
var //����һ TRzPanel�ؼ��� ;������ �Ƿ���combobox
  i: SmallInt;
begin //��� TRzPanel �ϵ�����ؼ� Edit,RzEdit
  for i := 0 to RzPanel1.ControlCount - 1 do
  begin
    if (RzPanel1.Controls[i].ClassType = TRzEdit) then
    begin
      (RzPanel1.Controls[i] as TRzEdit).Text := '';
    end;
    if (RzPanel1.Controls[i].ClassType = TRzButtonEdit) then
    begin
      (RzPanel1.Controls[i] as TRzButtonEdit).Text := '';
    end;
   { if (RzPanel1.Controls[i].ClassType = TdxCurrencyEdit) then
    begin
      (RzPanel1.Controls[i] as TdxCurrencyEdit).Text := '0';
    end;  }
    if b then
    begin
      if (RzPanel1.Controls[i].ClassType = TRzComboBox) then
      begin
        (RzPanel1.Controls[i] as TRzComboBox).ItemIndex := -1;
      end;
    end;
  end;
end;

procedure PleaseWait(i_StartOrExit: SmallInt); //���ض���
var
  HWndCalculator: HWnd;
  S_file: string;
begin
  HWndCalculator := Windows.FindWindow(nil, 'ZSB_PleaseWaitAutoClose');
  if i_StartOrExit = 0 then
  begin
    S_file := ExtractFilePath(Application.Exename) + 'PleaseWait.exe';
    if FileExists(S_file) then
    begin
      ShellExecute(Application.Handle, 'open', pchar(S_file), '-s', nil, SW_SHOWNORMAL);
    end;
  end;
  if i_StartOrExit = 1 then
  begin
    if HWndCalculator <> 0 then
    begin
      SendMessage(HWndCalculator, WM_CLOSE, 0, 0);
    end;
  end;
end;



function GetPyChar(const HZ: AnsiString): string;
const
  HZCode: array[0..25, 0..1] of Integer = ((1601, 1636), (1637, 1832), (1833, 2077),
    (2078, 2273), (2274, 2301), (2302, 2432), (2433, 2593), (2594, 2786), (9999, 0000),
    (2787, 3105), (3106, 3211), (3212, 3471), (3472, 3634), (3635, 3722), (3723, 3729),
    (3730, 3857), (3858, 4026), (4027, 4085), (4086, 4389), (4390, 4557), (9999, 0000),
    (9999, 0000), (4558, 4683), (4684, 4924), (4925, 5248), (5249, 5589));
var
  i, j, HzOrd: Integer;
  n: Integer;
begin
  i := 1;
  while i <= Length(HZ) do
  begin
    if (HZ[i] >= #160) and (HZ[i + 1] >= #160) then
    begin
      n := 0;

      HzOrd := (Ord(HZ[i]) - 160) * 100 + Ord(HZ[i + 1]) - 160;
      for j := 0 to 25 do
      begin
        if (HzOrd >= HZCode[j][0]) and (HzOrd <= HZCode[j][1]) then
        begin
          Result := Result + Char(Byte('A') + j);
          n := 1;
          Break;
        end;
      end;
      if n = 0 then
        Result := Result + ' ';
      Inc(i);
    end
    else Result := Result + HZ[i];
    Inc(i);
  end;
end;

procedure MsgBoxInfo(sInfo: string);
begin
  Application.MessageBox(PChar(sInfo), '��ʾ��Ϣ', MB_ICONINFORMATION);
end;

procedure MsgErrorInfo(ErInfo: string);
begin
  Application.MessageBox(PChar(ErInfo), '������Ϣ', MB_ICONERROR);
end;

function MsgBoxOk(sInfo: string): Boolean;
begin
  if Application.MessageBox(PChar(sInfo), '����ȷ��',
    MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON1) = IDYES then
    Result := TRUE
  else Result := FALSE;
end;

function MsgErrorInfo_RetryCancel(ErInfo: string): Boolean;
begin
  if Application.MessageBox(PChar(ErInfo), '������Ϣ', MB_ICONERROR + MB_RETRYCANCEL) = idRETRY then
    Result := TRUE
  else Result := FALSE;
end;

function SelectClientDataSetResultCount(ClientDataSet1: TClientDataSet; strSQL: string): Integer;
begin
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strSQL);
  end;
  Result := ClientDataSet1.RecordCount;
end;

function SelectClientDataSetResultFieldCaption(ClientDataSet1: TClientDataSet; strSQL, FieldName: string): string;
var
  temp: string;
begin
  temp := '';
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strSQL);
  end;
  if ClientDataSet1.RecordCount = 1 then //����0����¼����������¼�򷵻ؿ�ֵ
  begin
    temp := ClientDataSet1.fieldbyname(FieldName).AsString;
  end;
  Result := temp;
end;

procedure SelectClientDataSet(ClientDataSet1: TClientDataSet; strSQL: string);
begin
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strSQL);
  end;
  if ClientDataSet1.RecordCount = 0 then
  begin
    zsbSimpleMSNPopUpShow('û����ؼ�¼.');
  end;
end;

procedure SelectClientDataSetNoTips(ClientDataSet1: TClientDataSet; strSQL: string);
begin
  with ClientDataSet1 do
  begin
    data := RemoteServer.AppServer.fun_getdatasql(strSQL);
    //data := RemoteServer.AppServer.zsb_getdatasql(strSQL,zstruser);
  end;
end;

procedure AddLog_ExSQLText(TempExSQL: string);
var
  exsql, temp: string;
begin
  temp := StringReplace(TempExSQL, '''', '''''', [rfReplaceAll]); //����е����ŵ��滻
  exsql := 'insert into Log_ExSQLText(SQLText,OpeeDT,UserName) values(''' + temp + ''',''' +
    FormatDateTime('yyyy-MM-dd hh:mm:ss', Now) + ''',''' + ZStrUser + ''')';

  with FDM.ClientDataSet2 do
  begin
    temp := RemoteServer.AppServer.fun_peradd(EXSQL);
  end;
  if temp = 'false' then //���ص����ַ���
  begin
    zsbSimpleMSNPopUpShow('Log_ExSQLText ����ʧ��,����ϵ����Ա.');
  end;
end;

function EXSQLClientDataSet(ClientDataSet1: TClientDataSet; EXSQL: string): Boolean;
var
  temp: string;
begin
  //AddLog_ExSQLText(EXSQL);
  with ClientDataSet1 do
  begin
    temp := RemoteServer.AppServer.fun_peradd(EXSQL);
  end;
  if temp = 'false' then //���ص����ַ���
  begin
    result := False;
  end
  else
  begin
    result := True;
  end;
end;

function EXSQLClientDataSetNoLog(ClientDataSet1: TClientDataSet; EXSQL: string): Boolean;
var
  temp: string;
begin
  with ClientDataSet1 do
  begin
    temp := RemoteServer.AppServer.fun_peradd(EXSQL);
  end;
  if temp = 'false' then //���ص����ַ���
  begin
    result := False;
  end
  else
  begin
    result := True;
  end;
end;


end.
