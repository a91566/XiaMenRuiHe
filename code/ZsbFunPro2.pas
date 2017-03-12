{DLL ��װ�Ĵ���ר��,��ͬ��������}

{
MF_ML (ML����) ML_NO ���ڴ˱�
TF_ML          MO_NO ���ڴ˱����������MO_NO��ѯ����ı�

MF_MO (MO����)
TF_MO
}

unit ZsbFunPro2;

interface

uses
  Windows, Forms, DBClient, SysUtils, ShellAPI, Messages, rzpanel, rzedit, RzCmboBx, RzBtnEdt,
  Classes, StrUtils, StdCtrls, DBGridEh, Graphics;

  {dxCntner, dxEditor, dxExEdtr, dxEdLib for TdxCurrencyEdit}


function EXSQLClientDataSet(ClientDataSet1: TClientDataSet; EXSQL: string): Boolean;
function EXSQLClientDataSetNoLog(ClientDataSet1: TClientDataSet; EXSQL: string): Boolean;
function SelectClientDataSetResultCount(ClientDataSet1: TClientDataSet; strSQL: string): Integer;
function SelectClientDataSetResultFieldCaption(ClientDataSet1: TClientDataSet; strSQL, FieldName: string): string;
procedure SelectClientDataSet(ClientDataSet1: TClientDataSet; strSQL: string);
procedure SelectClientDataSetNoTips(ClientDataSet1: TClientDataSet; strSQL: string);

function MsgBoxOk(sInfo: string): Boolean;
function MsgErrorInfo_RetryCancel(ErInfo: string): Boolean;
function GetPyChar(const HZ: AnsiString): string;
function SelectDeptOrDepotName(strCode: string): string; //���ݱ����ȡ��������
function SelectEndProtNameForCode(strCode: string): string; //���ݳ�ƷƷ����ѯƷ��

procedure WaitTime(MSecs: integer);
procedure MsgBoxInfo(sInfo: string);
procedure MsgErrorInfo(ErInfo: string);
procedure PleaseWait(i_StartOrExit: SmallInt);
procedure ClearEditAndBox(RzPanel1: TRzPanel; b: Boolean);
procedure AddUpdateDelBtnEnabled(RzPanel1: TRzPanel; b: Boolean);
procedure LocateClientDataSet(ClientDataSet1: TClientDataSet; field: string; value: string);
procedure ComboxLoadFromFile(ComboBox1: TComboBox; filepath: string);
procedure AddRzComcomboBoxFromTable(Combox: TRzComboBox; TableName: string; FieldName: string);
procedure UpdateLastCompileTime;
procedure zsbSimpleMSNPopUpShow(strText: string; booalBottom: Boolean = True);
procedure zsbSimpleMSNPopUpShow_2(strText: string; acol: TColor = clYellow;iw:Integer=300);
procedure SaveMessage(strMess: string; FileType: string='.sql'; FileName: string = '');  
procedure SetDBGridEhFooterRowCount(DBGridEhXXX: TDBGridEh; ClientDataSetXXX: TClientDataSet);
procedure DBGridEhWidth(DBGridEhXXX: TDBGridEh; strType, filename: string);
procedure AddLog_Operation(TempExSQL: string);
procedure AddLog_ExSQLText(TempExSQL: string);
procedure AddLog_ErrorText(TempExSQL: string);
procedure LabelMoveLeave(LabelXXX: TLabel; bMove: Boolean);
procedure LabelMoveLeaveType2(LabelXXX: TLabel; bMove: Boolean);

function LoadOwnFile(FileName: string): TStringList;
function GetOldestMatlCode(strCode: string; dQuat: Double; strERPPDNO: string): string; //��ȡ���������
function GetOldestMatlShefCode(strCode, strLot: string): string; //��ȡ����
function GetMatlName(strCode: string): string; //��ȡ�Է��Ϻ�
function GetSuprName(strCode: string): string; //��ȡ��Ӧ������
function GetSetSerialNo(sType: string; strDT: string = '1'): string; //��ȡ���� ����Ĭ��Ϊ����
//function SetPrintLot(strLot, sType: string): Boolean; //��������
function SplitString(const source, ch: string): TStringList;
function Split2DCode(str2DCode: string): TStringList;
function isAdmin: Boolean;
function isSuprAdmin: Boolean;  
function GetDateTimeSecond: string;
function GetDateTimeDate: string;

implementation

uses ZsbVariable2, ZsbDLL2, UDM;

{$I 'FechaCompilacion.inc'}

///////////----------------------------------  black     SYSLOGS

//ERPProduceDocZ -> LZz_ML_MO_FromERP
//ERPProduceDocMx -> LZm_ML_MO_FromERP
//ERPPDNO -> ML_NO
//ERPZLDH-> MO_NO
//OccupyERPPDNO ->  OccupyML_NO

procedure LabelMoveLeave(LabelXXX: TLabel; bMove: Boolean);
begin
  if bMove then
  begin
    LabelXXX.Font.Style := [fsBold];
    LabelXXX.Font.Color := clBlue;
  end
  else
  begin
    LabelXXX.Font.Style := [];
    LabelXXX.Font.Color := clNavy;
  end;
end;

procedure LabelMoveLeaveType2(LabelXXX: TLabel; bMove: Boolean);
begin
  if bMove then
  begin
    LabelXXX.Font.Style := [fsBold];
    LabelXXX.Color := clRed;
  end
  else
  begin
    LabelXXX.Font.Style := [];
    LabelXXX.Color := clMaroon;
  end;
end;

procedure DBGridEhWidth(DBGridEhXXX: TDBGridEh; strType, filename: string);
var //filename ������·��
  i: SmallInt;
  TSList: TStringList;
  filepath: string;
begin
  {
  FormClose DBGridEhWidth(DBGridEh1,'save','F_PrintCodeNew_DBGridEh1.zsb');
  FormShow  DBGridEhWidth(DBGridEh1,'get','F_PrintCodeNew_DBGridEh1.zsb');
  }
  filepath := ExtractFilePath(ParamStr(0)) + 'DBGridEhWidth\';
  if strType = 'get' then
  begin
    if not FileExists(filepath + filename) then Exit;
    TSList := TStringList.Create();
    TSList.LoadFromFile(filepath + filename);
    for i := 0 to TSList.Count - 1 do
    begin
      DBGridEhXXX.Columns[i].Width := StrToInt(TSList[i]);
    end;
    TSList.Free;
  end
  else if strType = 'save' then
  begin
    if not DirectoryExists(filepath) then CreateDirectory(PChar(filepath), nil);
    TSList := TStringList.Create();
    for i := 0 to DBGridEhXXX.Columns.Count - 1 do
    begin
      TSList.Add(IntToStr(DBGridEhXXX.Columns[i].Width));
    end;
    TSList.SaveToFile(filepath + filename);
    TSList.Free;
  end;
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

procedure SetDBGridEhFooterRowCount(DBGridEhXXX: TDBGridEh; ClientDataSetXXX: TClientDataSet);
begin
  if ClientDataSetXXX.RecordCount > 0 then
  begin
    DBGridEhXXX.FooterRowCount := 1;
    DBGridEhXXX.FooterDisplayStyle := True;
    DBGridEhXXX.SumList.Active := True;
  end
  else
  begin
    DBGridEhXXX.FooterRowCount := 0;
    DBGridEhXXX.SumList.Active := False;
  end;
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

procedure AddLog_ExSQLText(TempExSQL: string);
var
  exsql, temp: string;
  sl: TStringList;
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
    zsbSimpleMSNPopUpShow_2('Log_ExSQLText ����ʧ��,�����Ժ��Դ���,������ϵ����Ա.',clRed,600);


    begin
      temp := ExtractFilePath(Application.Exename) + 'SYSLOGS';
      if not DirectoryExists(temp) then
      begin
        CreateDir(temp);
      end;
      temp := temp + '/AddLog_ExSQLText_' + FormatDateTime('yyyyMMddhhmmss', Now) + '.sql';
      sl := TStringList.Create;
      sl.Add(TempExSQL);
      sl.SaveToFile(temp);
      sl.Free;
    end;
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

function Split2DCode(str2DCode: string): TStringList;
var
  i, iCount: SmallInt;
  SLFieldName: TStringList;
begin
  result := TStringList.Create;
  SLFieldName := TStringList.Create;
  SLFieldName := SplitString(str2DCode, ',');
  iCount := SLFieldName.Count;
 { if iCount <> 10 then
  begin
    zsbSimpleMSNPopUpShow('��ά���������');
    Memo2.Text := '';
    exit;
  end;
  if (SLFieldName[0] <> 'begin') and (SLFieldName[9] <> 'end') then
  begin
    zsbSimpleMSNPopUpShow('��ά���������');
    Memo2.Text := '';
    exit;
  end;  }

  for i := 0 to iCount - 1 do
  begin
    result.Add(SLFieldName[i]);
  end;
  SLFieldName.Free;
end;

function SplitString(const source, ch: string): TStringList;
var //�ַ������ָ���  �������ÿո�ָ�յ�Ҳ���ᱻɾ��
  temp, t2: string;
  i: integer;
begin
  result := TStringList.Create;
  temp := source;
  i := pos(ch, source);
  while i <> 0 do
  begin
    t2 := copy(temp, 0, i - 1);
   // if (t2 <> '') then   //������Ҫ
    result.Add(t2);
    delete(temp, 1, i - 1 + Length(ch));
    i := pos(ch, temp);
  end;
  result.Add(temp);
end;

function GetSetSerialNo(sType: string; strDT: string = '1'): string;
var    //2014��5��23�� 17:05:26 ����Ϊ�洢���̴���
  strsql,dt,dt_no: string;
begin
  if strDT = '1' then
  begin
    dt := FormatDateTime('yyyy-MM-dd', Now);
    dt_no := FormatDateTime('yyyyMMdd', Now);
  end
  else
  begin
    dt := strDT;
    dt_no := FormatDateTime('yyyyMMdd', StrToDate(strDT));
  end;

  strsql:='declare @out nvarchar(15)  exec @out=ZP_getLotHistory_No ';

  strsql:=strsql+''''+dt+'''';
  strsql:=strsql+','+''''+dt_no+'''';
  strsql:=strsql+','+''''+sType+'''';
  Result:=SelectClientDataSetResultFieldCaption(FDM.ClientDataSet2,strsql,'outvalue'); //outvalue ��д�ڴ洢�������
end;

{
function GetSetSerialNo(sType: string; strDT: string = '1'): string;
var //���θ�ʽ 201401150001 ����4λΪ��ˮ��
  strRt, strsql, temp, exsql, dt: string;
begin
  strRt := '';
  if strDT = '1' then
  begin
    dt := FormatDateTime('yyyy-MM-dd', Now);
  end
  else
  begin
    dt := strDT;
  end;
  strsql := 'select Lot from LotHistory where OPDT=''' + dt + ''' and type=''' + sType + '''';
  temp := SelectClientDataSetResultFieldCaption(FDM.ClientDataSet1, strsql, 'Lot');
  if temp <> '' then
  begin
    strRt := IntToStr(StrToInt64(temp) + 1);
    exsql := 'update LotHistory set Lot=''' + strRt + ''' where OPDT=''' + dt + ''' and type=''' + sType + '''';
  end
  else
  begin
    strRt := FormatDateTime('yyyyMMdd', Now) + '0001';
    exsql := 'insert into LotHistory(Lot,OPDT,type)values(''' + strRt + ''',''' + dt + ''',''' + sType + ''')';
  end;
  if EXSQLClientDataSet(FDM.ClientDataSet2, exsql) = False then //��¼
  begin
    strRt := 'Error';
    zsbSimpleMSNPopUpShow('LotHistory ��ˮ�Ų���ʧ��,����ϵ����Ա.');
    SaveMessage(exsql, 'sql');
  end;
  Result := strRt;
end;  }

function GetSuprName(strCode: string): string;
var
  strsql, strRt: string;
begin
  if strCode = '' then
  begin
    strRt := '';
  end
  else
  begin
    strSQL := 'select SuprName from Supplier where SuprCode=''' + strCode + '''';
    strRt := SelectClientDataSetResultFieldCaption(FDM.ClientDataSet1, strSQL, 'SuprName');
  end;
  Result := strRt;
end;

function GetMatlName(strCode: string): string;
var
  strsql, strRt: string;
begin
  if strCode = '' then
  begin
    strRt := '';
  end
  else
  begin
    strSQL := 'select MatlName from Material where matlcode=''' + strCode + '''';
    strRt := SelectClientDataSetResultFieldCaption(FDM.ClientDataSet1, strSQL, 'MatlName');
  end;
  Result := strRt;
end;

function GetOldestMatlShefCode(strCode, strLot: string): string;
var //�Ϻ�,����      ,������� �Զ��Ÿ���
  strsql, temp, strRt: string;
  i, iCount: SmallInt;
  TSList: TStringList;
begin
  if strLot = '' then
  begin
    strRt := '';
  end
  else
  begin
    TSList := TStringList.Create;
    iCount := ExtractStrings([','], [], PChar(strLot), TSList); //���ŷָ�
    for i := 0 to iCount - 1 do
    begin
      strSQL := 'select ShefCode from matlindepotmx where matlcode=''' + strCode +
        ''' and matllot=''' + TSList[i] + '''';
      temp := SelectClientDataSetResultFieldCaption(FDM.ClientDataSet1, strSQL, 'ShefCode');
      if i = 0 then
      begin
        strRt := temp;
      end
      else
      begin
        strRt := strRt + ',' + temp;
      end;
    end;
    TSList.Free;
  end;
  Result := strRt;
end;

function GetOldestMatlCode(strCode: string; dQuat: Double; strERPPDNO: string): string;
var //�Ϻ�,����,ռ�õ�sql���      ,������� �Զ��Ÿ���
  strsql, exsqlOccupyQuat, temp: string;
  dtemp: Double;
begin
  exsqlOccupyQuat := '';
  strSQL := 'select MatlLot,StockQuat,MIDDONO from matlindepotmx where MatlCode=''' + strCode +
    ''' and StockQuat>0 and  OccupyQuat<=StockQuat order by MIDDONO ';
  SelectClientDataSet(FDM.ClientDataSet1, strSQL);
  temp := '';
  with FDM.ClientDataSet1 do
  begin
    First;
    dtemp := dQuat;
    while not eof do
    begin
      if temp = '' then
      begin
        temp := FieldByName('MatlLot').AsString;
        exsqlOccupyQuat := 'update matlindepotmx set OccupyQuat=OccupyQuat+' + FieldByName('stockquat').AsString +
          ',OccupyML_NO=''' + strERPPDNO + ''' where MatlCode=''' + strCode +
          ''' and MatlLot=''' + FieldByName('MatlLot').AsString + ''' and MIDDONO=''' + FieldByName('MIDDONO').AsString + ''';';
      end
      else
      begin
        temp := temp + ',' + FieldByName('MatlLot').AsString;
        exsqlOccupyQuat := exsqlOccupyQuat + 'update matlindepotmx set OccupyQuat=OccupyQuat+' + FloatToStr(dtemp) +
          ',OccupyML_NO=''' + strERPPDNO + ''' where MatlCode=''' + strCode +
          ''' and MatlLot=''' + FieldByName('MatlLot').AsString + ''' and MIDDONO=''' + FieldByName('MIDDONO').AsString + ''';';
      end;
      dtemp := dtemp - FieldByName('stockquat').AsFloat;
      if dtemp <= 0 then
      begin
        Break; //�����㹻�ˣ��˳�
      end;
      Next;
    end;
  end;
  temp := temp + '/' + exsqlOccupyQuat;
  Result := temp;
end;

function SelectEndProtNameForCode(strCode: string): string;
var
  strsql, temp: string;
begin
  strSQL := 'select top 1 EndProtName from ERPSellDocMX where EndProtCode=''' + strCode + '''';
  temp := SelectClientDataSetResultFieldCaption(FDM.ClientDataSet1, strSQL, 'EndProtName');
  if temp = '' then temp := 'δ֪����';
  Result := temp;
end;

function SelectDeptOrDepotName(strCode: string): string;
var
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

procedure WaitTime(MSecs: integer);
var
  FirstTickCount, Now: Longint;
begin
  FirstTickCount := Windows.GetTickCount();
  repeat Application.ProcessMessages;
    Now := Windows.GetTickCount();
  until (Now - FirstTickCount >= MSecs) or (Now < FirstTickCount);
end;

procedure zsbSimpleMSNPopUpShow(strText: string; booalBottom: Boolean = True);
var
  ix, iy: SmallInt;
begin
  ix := Screen.Width div 2;
  ix := ix - 150;
  if booalBottom then //�ײ�
  begin
    iy := 20;
  end
  else
  begin //�ϲ�
    iy := Screen.Height - 20;
  end;
  //SimpleMSNPopUpShow(strText, ix, iy);
  SimpleMSNPopUpShowMoreVar(strText, ix, iy,300,50,3,clYellow,clWhite);
end;

procedure zsbSimpleMSNPopUpShow_2(strText: string; acol: TColor = clYellow;iw:Integer=300);
var
  ix, iy: SmallInt;
begin
  ix := Screen.Width div 2;
  iy:=iw div 2;
  ix := ix - iy; 
  iy := 20;
  SimpleMSNPopUpShowMoreVar(strText, ix, iy,iw,50,3,acol,acol);
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

function LoadOwnFile(FileName: string): TStringList;
begin
  Result := TStringList.Create;
  Result.LoadFromFile(FileName);
end;

procedure SaveMessage(strMess: string; FileType: string='.sql'; FileName: string = '');
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

function GetDateTimeDate:string; //��ȡ��ǰʱ�� yyyy-MM-dd
begin
  Result:=SelectClientDataSetResultFieldCaption(FDM.getdatetime,'Select convert(varchar,getdate(),23) dt','dt');
end;

function GetDateTimeSecond:string; //��ȡ��ǰʱ�� yyyy-MM-dd HH:mm:ss
begin
  Result:=SelectClientDataSetResultFieldCaption(FDM.getdatetime,'Select convert(varchar,getdate(),120) dt','dt');
end;

procedure ComboxLoadFromFile(ComboBox1: TComboBox; filepath: string);
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
    end;   }
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
    SetStringToIni(ExtractFilePath(Application.Exename) + 'config.ini','config','CLOSEPLEASEWAIT','N');
    if FileExists(S_file) then
    begin
      ShellExecute(Application.Handle, 'open', pchar(S_file), '-s', nil, SW_SHOWNORMAL);
    end;
  end
  else if i_StartOrExit = 1 then
  begin   
    SetStringToIni(ExtractFilePath(Application.Exename) + 'config.ini','config','CLOSEPLEASEWAIT','Y');
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
  end;
end;

function EXSQLClientDataSet(ClientDataSet1: TClientDataSet; EXSQL: string): Boolean;
var
  temp: string;
begin
  AddLog_ExSQLText(EXSQL);
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

