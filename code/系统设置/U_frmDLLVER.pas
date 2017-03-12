unit U_frmDLLVER;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBClient, StdCtrls, Grids, DBGridEh, RzPanel,
  RzTabs, StrUtils, ComCtrls, Menus;

type
  TfrmDLLVer = class(TForm)
    Image1: TImage;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPanel99: TRzPanel;
    DBGridEh1: TDBGridEh;
    RzPanel3: TRzPanel;
    Button1: TButton;
    ClientDataSet11: TClientDataSet;
    ClientDataSet12: TClientDataSet;
    Button5: TButton;
    Button2: TButton;
    Button4: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    OpenDialog1: TOpenDialog;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cReadMe = 'DLL �汾����,����˵��:' +
    #13 + #10 + '�洢�����и���DLL�İ汾��.' +   
    #13 + #10 + '�����PDA��ͬ�İ汾�����ڿͻ��˸������ѣ�˫���С������汾���á�����ת��ֵ��ֻ�����PDA��.' +
    #13 + #10 + #13 + #10 + '2014��11��21�� 11:46:33 ֣�ٱ�';

var
  frmDLLVer: TfrmDLLVer;

implementation

uses ZsbFunPro2, ZsbDLL2, ZsbVariable2;

{$R *.dfm}

function MakeFileList(Path, FileExt: string; bPathName: Boolean): TStringList;
var //�Ƿ�����·��
  sch: TSearchrec;
begin
  Result := TStringlist.Create;
  if rightStr(trim(Path), 1) <> '\' then
    Path := trim(Path) + '\'
  else
    Path := trim(Path);
  if not DirectoryExists(Path) then
  begin
    Result.Clear;
    exit;
  end;
  if FindFirst(Path + '*', faAnyfile, sch) = 0 then
  begin
    repeat
      Application.ProcessMessages;
      if ((sch.Name = '.') or (sch.Name = '..')) then Continue;
      if DirectoryExists(Path + sch.Name) then
      begin
        Result.AddStrings(MakeFileList(Path + sch.Name, FileExt, bPathName));
      end
      else
      begin
        if (UpperCase(extractfileext(Path + sch.Name)) = UpperCase(FileExt)) or (FileExt = '.*') then
        begin
          if bPathName then
          begin
            Result.Add(Path + sch.Name);
          end
          else
          begin
            Result.Add(sch.Name);
          end;
        end;
      end;
    until FindNext(sch) <> 0;
    SysUtils.FindClose(sch);
  end;
end;

procedure TfrmDLLVer.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //���� ��ʾ��������
end;



procedure TfrmDLLVer.Button1Click(Sender: TObject);
var
  strsql: string;
begin
  strsql := 'select * from AppVer_DLL where 1=1';
  if (CheckBox1.Checked = True) and (CheckBox2.Checked = False) then
  begin
    strsql := strsql + ' and iType=''PC''';
  end;
  if (CheckBox2.Checked = True) and (CheckBox1.Checked = False) then
  begin
    strsql := strsql + ' and iType=''PDA''';
  end;
  strsql := strsql + ' order by iType desc,DLLNAMe';
  SelectClientDataSet(ClientDataSet1, strsql);
end;


procedure TfrmDLLVer.Timer1Timer(Sender: TObject);
var
  h: THandle;
  bit: TBitmap;
begin
  Timer1.Enabled := False;
  if FileExists(ExtractFilePath(Application.Exename) + 'BitBtnImageFormZsbDll2.dll') then
  begin
    h := LoadLibrary('BitBtnImageFormZsbDll2.dll'); //���� DLL
    bit := TBitmap.Create;
    bit.LoadFromResourceName(h, 'imgLZtopForZhuiSuSYS2'); //��ȡ��Դ
    Image1.Picture.Assign(bit);
    FreeLibrary(h); //��ж DLL
    bit.Free;
  end;
  RzPanel99.Visible := True;
  Button1.Click;
end;

procedure TfrmDLLVer.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 200, AW_CENTER); //������С���
end;

procedure TfrmDLLVer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;




procedure TfrmDLLVer.Image1DblClick(Sender: TObject);
begin
  ZsbShowMessageNoApp(Self, cReadMe);
end;




procedure TfrmDLLVer.Button2Click(Sender: TObject);
var
  exsql, TeVer: string;
  TSList: TStringList;
  i: SmallInt;
begin
  exsql := '';
  TSList := MakeFileList(ExtractFilePath(Application.ExeName), '.dll', False);
  for i := 0 to TSList.Count - 1 do
  begin
    TeVer := GetVersionString(ExtractFilePath(Application.ExeName) + TSList[i]);
    exsql := exsql + 'insert into APPVER_DLL(DLLNAME,DLLVER,un,iType) values(''' + TSList[i] +
      ''',''' + TeVer + ''',''' + ZStrUser + ''',''PC'');';

  end;
  EXSQLClientDataSet(ClientDataSet11, 'delete from APPVER_DLL where iType=''PC''');
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');
    Button1.Click;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '��ʼ��ʧ��,����ϵ����Ա.');
  end;
end;

procedure TfrmDLLVer.Button5Click(Sender: TObject);
var
  exsql, TeVer, ExN: string;
  TSList: TStringList;
  i: SmallInt;
begin
  OpenDialog1.Filter := '����(PDA)׷�ݹ���ϵͳ.exe|����(PDA)׷�ݹ���ϵͳ.exe';
  if OpenDialog1.Execute = False then Exit;
  ExN := OpenDialog1.FileName;
  exsql := '';
  TSList := MakeFileList(ExtractFilePath(ExN), '.dll', False);
  for i := 0 to TSList.Count - 1 do
  begin
    TeVer := GetVersionString(ExtractFilePath(ExN) + TSList[i]);
    exsql := exsql + 'insert into APPVER_DLL(DLLNAME,DLLVER,un,iType) values(''' + TSList[i] +
      ''',''' + TeVer + ''',''' + ZStrUser + ''',''PDA'');';

  end;
  EXSQLClientDataSet(ClientDataSet11, 'delete from APPVER_DLL where iType=''PDA''');
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    zsbSimpleMSNPopUpShow('is ok');
    Button1.Click;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '��ʼ��ʧ��,����ϵ����Ա.');
  end;
end;

procedure TfrmDLLVer.Button4Click(Sender: TObject);
begin
  //PopupMenu1.Popup(Button4.Left + 1, Image1.Height + RzPanel3.Height + 15);
end;

procedure TfrmDLLVer.N2Click(Sender: TObject);
var
  TSList: TStringList;
  fn: string;
begin
  if ClientDataSet1.RecordCount = 0 then Exit;
  TSList := TStringList.Create;
  with ClientDataSet1 do
  begin
    First;
    while not eof do
    begin
      if FieldByName('TB_Tips').AsString <> '' then
      begin
        TSList.Add(FieldByName('TB_Name').AsString + '*' + FieldByName('TB_Tips').AsString);
      end;
      Next;
    end;
  end;
  fn := ExtractFilePath(Application.Exename) + '�������ļ�\TBREMARK.ZSB';
  TSList.SaveToFile(fn);
  zsbSimpleMSNPopUpShow_2('�����ļ�-[ ' + fn + ' ]', clYellow, 800);
end;

procedure TfrmDLLVer.N4Click(Sender: TObject);
var
  TSList, TSList2: TStringList;
  exsql: string;
  i: SmallInt;
begin
  OpenDialog1.Filter := '*.ZSB|*.ZSB';
  OpenDialog1.InitialDir := ExtractFilePath(Application.Exename) + '�������ļ�';
  if OpenDialog1.Execute = False then Exit;
  TSList := TStringList.Create;
  TSList.LoadFromFile(OpenDialog1.FileName);
  for i := 0 to TSList.Count - 1 do
  begin
    TSList2 := SplitString(TSList[i], '*');
    exsql := exsql + 'update ZZZZZZZZZ_UserTableRemark set TB_Tips=''' + TSList2[1] + ''' where TB_Name=''' + TSList2[0] + ''';';
  end;
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    zsbSimpleMSNPopUpShow('�������');
    Button1.Click;
  end
  else
  begin
    zsbSimpleMSNPopUpShow('����ʧ��,����ϵ����Ա.');
  end;
end;

procedure TfrmDLLVer.DBGridEh1DblClick(Sender: TObject);
var
  temp, exsql: string;
begin
  if DBGridEh1.Col <> 6 then Exit;
  if ClientDataSet1.FieldByName('iType').AsString = 'PC' then Exit;
  temp := ClientDataSet1.FieldByName('OtherCanUses').AsString;
  if temp = '��' then
  begin
    temp := '��';
  end
  else
  begin
    temp := '��';
  end;
  exsql := 'update appver_dll set OtherCanUses=''' + temp + ''' where iType=''PDA'' and DLLName=''' + ClientDataSet1.FieldByName('DLLName').AsString + '''';
  if EXSQLClientDataSet(ClientDataSet11, exsql) then
  begin
    Button1.Click;
    DBGridEh1.Repaint;
  end
  else
  begin
    zsbSimpleMSNPopUpShow('����ʧ��.');
  end;
end;

procedure TfrmDLLVer.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if (ClientDataSet1.FieldByName('iType').AsString = 'PDA') and
    (ClientDataSet1.FieldByName('OtherCanUses').AsString = '��') then
  begin
    DBGridEh1.Canvas.Brush.Color := clYellow;
    DBGridEh1.Canvas.Font.Color := clRed;
    DBGridEh1.Canvas.Font.Style := [fsBold];
    DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end; 
end;

end.

