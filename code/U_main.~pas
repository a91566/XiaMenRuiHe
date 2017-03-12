unit U_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan, Mask, RzEdit, Menus, DB, DBClient, RzLabel,
  RzTabs, RzPanel, RzGroupBar, RzSplit, RzStatus, ExtCtrls, RzBckgnd,
  ImgList, jpeg, Buttons, ShellAPI, IdBaseComponent, IdComponent, IdIPWatch, StrUtils;

type
  TF_main = class(TForm)
    XPManifest1: TXPManifest;
    RzStatusBar1: TRzStatusBar;
    RzStatusPane1: TRzStatusPane;
    RzStatusPane3: TRzStatusPane;
    RzStatusPane4: TRzStatusPane;
    RzStatusPane2: TRzStatusPane;
    RzSizePanel1: TRzSizePanel;
    RzGroupBar1: TRzGroupBar;
    RzGroup0: TRzGroup;
    RzGroup1: TRzGroup;
    RzGroup3: TRzGroup;
    RzGroup5: TRzGroup;
    RzGroup7: TRzGroup;
    RzGroup9: TRzGroup;
    RzPanel1: TRzPanel;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    MainMenu1: TMainMenu;
    ShowArrayAndFoms1: TMenuItem;
    ShowArrayAndFoms2: TMenuItem;
    Timer1: TTimer;
    RzGroup99: TRzGroup;
    RzGroup8: TRzGroup;
    CheckBox1: TCheckBox;
    TimClosePage: TTimer;
    RzLabel12: TRzLabel;
    Image32: TImage;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel6: TRzLabel;
    Image17: TImage;
    Image18: TImage;
    RzLabel3: TRzLabel;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Panel1: TPanel;
    RzGroupBox1: TRzGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Image1: TImage;
    Image5: TImage;
    RzStatusPane5: TRzStatusPane;
    RzClockStatus2: TRzClockStatus;
    Image6: TImage;
    Label6: TLabel;
    TimLinkDB: TTimer;
    TimerPleaseWait: TTimer;
    TNewVer: TTimer;
    RzLabel7: TRzLabel;
    Image7: TImage;
    Timer2: TTimer;
    IdIPWatch1: TIdIPWatch;
    RzStatusPane6: TRzStatusPane;
    Timer3: TTimer;
    Timer4: TTimer;
    RzGroup2: TRzGroup;
    RzGroup4: TRzGroup;
    RzGroup6: TRzGroup;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label1Click(Sender: TObject);
    procedure TimClosePageTimer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure TimLinkDBTimer(Sender: TObject);
    procedure TimerPleaseWaitTimer(Sender: TObject);
    procedure TNewVerTimer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure RzGroup0Items0Click(Sender: TObject);
    procedure RzGroup0Items1Click(Sender: TObject);
    procedure RzGroup0Items2Click(Sender: TObject);
    procedure RzGroup0Items3Click(Sender: TObject);
    procedure RzGroup0Items4Click(Sender: TObject);
    procedure RzGroup0Items5Click(Sender: TObject);
    procedure RzGroup0Items6Click(Sender: TObject);
    procedure RzGroup0Items7Click(Sender: TObject);
    procedure RzGroup0Items8Click(Sender: TObject);
    procedure RzGroup1Items1Click(Sender: TObject);
    procedure RzGroup1Items7Click(Sender: TObject);
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure RzGroup1Items2Click(Sender: TObject);
    procedure RzGroup1Items3Click(Sender: TObject);
    procedure RzGroup1Items4Click(Sender: TObject);
    procedure RzGroup1Items5Click(Sender: TObject);
    procedure RzGroup1Items6Click(Sender: TObject);
    procedure RzGroup2Items0Click(Sender: TObject);
    procedure RzGroup2Items1Click(Sender: TObject);
    procedure RzGroup2Items2Click(Sender: TObject);
    procedure RzGroup2Items3Click(Sender: TObject);
    procedure RzGroup2Items4Click(Sender: TObject);
    procedure RzGroup2Items5Click(Sender: TObject);
    procedure RzGroup3Items0Click(Sender: TObject);
    procedure RzGroup3Items1Click(Sender: TObject);
    procedure RzGroup3Items2Click(Sender: TObject);
    procedure RzGroup3Items3Click(Sender: TObject);
    procedure RzGroup3Items4Click(Sender: TObject);
    procedure RzGroup3Items5Click(Sender: TObject);
    procedure RzGroup3Items6Click(Sender: TObject);
    procedure RzGroup3Items7Click(Sender: TObject);
    procedure RzGroup4Items0Click(Sender: TObject);
    procedure RzGroup4Items1Click(Sender: TObject);
    procedure RzGroup4Items2Click(Sender: TObject);
    procedure RzGroup4Items3Click(Sender: TObject);
    procedure RzGroup4Items4Click(Sender: TObject);
    procedure RzGroup4Items5Click(Sender: TObject);
    procedure RzGroup4Items6Click(Sender: TObject);
    procedure RzGroup4Items7Click(Sender: TObject);
    procedure RzGroup5Items0Click(Sender: TObject);
    procedure RzGroup5Items1Click(Sender: TObject);
    procedure RzGroup5Items2Click(Sender: TObject);
    procedure RzGroup6Items0Click(Sender: TObject);
    procedure RzGroup6Items1Click(Sender: TObject);
    procedure RzGroup6Items2Click(Sender: TObject);
    procedure RzGroup6Items3Click(Sender: TObject);
    procedure RzGroup7Items0Click(Sender: TObject);
    procedure RzGroup7Items1Click(Sender: TObject);
    procedure RzGroup7Items2Click(Sender: TObject);
    procedure RzGroup8Items0Click(Sender: TObject);
    procedure RzGroup9Items0Click(Sender: TObject);
    procedure RzGroup9Items1Click(Sender: TObject);
    procedure RzGroup9Items2Click(Sender: TObject);
    procedure RzGroup9Items3Click(Sender: TObject);
    procedure RzGroup9Items4Click(Sender: TObject);
    procedure RzGroup9Items5Click(Sender: TObject);
    procedure RzGroup99Items0Click(Sender: TObject);
    procedure RzGroup99Items1Click(Sender: TObject);
    procedure RzGroup5Items3Click(Sender: TObject);
  private
    iPrNextPageIndex: SmallInt;
    { Private declarations }
  public
    iPuActivPage: SmallInt;
    procedure InitFormAll; {初始化}
    procedure CreatePageForm(strFormCaption: string; AClass: TFormClass); {创建新页}
    procedure ClosePageForm(iPageIndex: SmallInt); {关闭页}
    procedure DLLCreateFormApp(dllName, funcName: string); {DLL 加载子窗体}
    procedure DLLSetUserDept(dllName, funcName: string); {DLL 传递所需的值}
    procedure ErrorShow(Sender: TObject; E: Exception); {异常显示}
    procedure InsertIntoFuncMenu; {插入菜单}
    procedure LoadUserPower(strUserCode: string); {获取用户菜单项目 用户权限}
    procedure InitUserInfo; {初始化用户信息}
    { Public declarations }
  end;

var
  F_main: TF_main;

implementation //ZStrUserCode   RzStatusPane5

uses U_ObjectForm, UOF_rkdxg, UOF_flckdck,
  ZsbDLL, ZsbFunPro, ZsbVariable, UDM, UOF_chengpinchukudanchakan,
  UOF_chengpinchukudanxiugai, UOF_chengpinrukudanchakan,
  UOF_chengpinrukudanxiugai, UOF_faliaochukudanxiugai, UOF_rukudanchakan,
  UOF_shengchangtuikudanchakan, UOF_shengchangtuikudanxiugai,
  UOF_tuihuodanchakan, UOF_tuihuodanxiugai, U_xiugaimima,
  UOF_qiangongchengyongliao, UOF_YuanLiaoPiCiShiXiaoQi;

{$R *.dfm}

procedure TF_main.ErrorShow(Sender: TObject; E: Exception);
var
  temp, temp1, exsql: string;
begin
  temp := e.Message;
  temp1 := Sender.ClassName;
  //temp1:=e
  temp := StringReplace(temp, '''', '''''', [rfReplaceAll]); //万一有单引号
  temp1 := StringReplace(temp1, '''', '''''', [rfReplaceAll]); //万一有单引号
  exsql := 'insert into Log_Exception(emessage,esender,edt,un) values(''' + temp + ''',''' + temp1 +
    ''',''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''',''' + zstruser + ''')';
  //SaveMessage(exsql,'.sql');
  EXSQLClientDataSetNoLog(FDM.ClientDataSet2, exsql);
  temp := #13 + #10 + '应用程序：' + Application.Title + #13 + #10 + #13 + #10;
  temp := temp + '发生时间：' + FormatDateTime('yyyy年MM月dd日 HH:mm:ss', Now) + #13 + #10 + #13 + #10;
  temp := temp + '错误信息：' + e.Message + #13 + #10 + #13 + #10;
  temp := temp + '错误类型：' + e.ClassName + #13 + #10 + #13 + #10;
  temp := temp + '错误对象：' + Sender.ClassName + #13 + #10 + #13 + #10;
  temp := temp + '发生时间：' + FormatDateTime('yyyy年MM月dd日 HH:mm:ss', Now) + #13 + #10 + #13 + #10;
  temp := temp + '请联系管理员 或者 更正后重试.' + #13 + #10 + #13 + #10;
  ExceptionShowStrNoApp(temp, False);
end;

procedure TF_main.LoadUserPower(strUserCode: string);
var
  i, j: SmallInt;
  strsql, iStr, jStr, strFuncCode: string; //两位 i ,j 的值
begin
  //strUserCode := '1';
  strsql := 'select funccode from userpower where usercode=''' + strUserCode + ''' and powertype=''PC''';
  //MSNPopUpShow('strUserCode:'+strUserCode);
  SelectClientDataSetNoTips(FDM.ClientDataSet1, strsql);
  if FDM.ClientDataSet1.RecordCount = 0 then Exit;
  for i := 0 to RzGroupBar1.GroupCount - 1 do
  begin
    iStr := IntToStr(i);
    if Length(iStr) = 1 then iStr := '0' + iStr;
    if FDM.ClientDataSet1.Locate('FuncCode', iStr, []) then
    begin
      RzGroupBar1.Groups[i].Enabled := True;
      for j := 0 to RzGroupBar1.Groups[i].Items.Count - 1 do
      begin
        jStr := IntToStr(j);
        if Length(jStr) = 1 then jStr := '0' + jStr;
        strFuncCode := iStr + jStr;
        if FDM.ClientDataSet1.Locate('FuncCode', strFuncCode, []) = False then //没有找到权限就不显示
        begin
          RzGroupBar1.Groups[i].Items[j].Visible := False;
        end;
      end;
    end
    else
    begin
      RzGroupBar1.Groups[i].Visible := False;
    end;
  end;
  RzGroupBar1.Visible := True;


  if ZStrUserCode = 'admin' then //超级管理员才有的权限
  begin
    RzGroupBar1.Groups[8].Items[4].Enabled := True;
    RzGroupBar1.Groups[8].Items[5].Enabled := True;
  end;
end;

procedure TF_main.InsertIntoFuncMenu;
var
  strFuncCode, exsql: string;
  i, j: SmallInt;
  iStr, jStr: string; //两位 i ,j 的值
begin
  //显示树形,表结构要求严格



  if EXSQLClientDataSet(FDM.ClientDataSet1, 'delete from FuncMenu') = False then
  begin
    zsbSimpleMSNPopUpShow('旧菜单删除失败啦!');
    Exit;
  end;

  for i := 0 to RzGroupBar1.GroupCount - 1 do
  begin
    iStr := IntToStr(i);
    if Length(iStr) = 1 then iStr := '0' + iStr;
    exsql := 'insert into FuncMenu (FuncCode,FuncName,FuncParent,FuncIndex,FuncType)values(''' + iStr + ''',''' +
      RzGroupBar1.Groups[i].Caption + ''',''0'',''' + iStr + ''',''PC'');';
    for j := 0 to RzGroupBar1.Groups[i].Items.Count - 1 do
    begin
      jStr := IntToStr(j);
      if Length(jStr) = 1 then jStr := '0' + jStr;
      strFuncCode := iStr + jStr;
      exsql := exsql + 'insert into FuncMenu (FuncCode,FuncName,FuncParent,FuncIndex,FuncType)values(''' + strFuncCode + ''',''' +
        RzGroupBar1.Groups[i].Items[j].Caption + ''',''' + iStr + ''',''' + jStr + ''',''PC'');';
    end;
    if EXSQLClientDataSet(FDM.ClientDataSet1, ' begin ' + exsql + ' commit; end;') = False then
    begin
      zsbSimpleMSNPopUpShow('菜单获取失败啦!');
      Exit;
    end;
  end;
  //------------------------------PDA 的权限菜单
  
  exsql :=  'insert into FuncMenu (FuncCode,FuncName,FuncParent,FuncIndex,FuncType)values' +
    '(''PDA01'',''采购入库'',''0'',''01'',''PDA'');';
  exsql := exsql + 'insert into FuncMenu (FuncCode,FuncName,FuncParent,FuncIndex,FuncType)values' +
    '(''PDA02'',''采购退库'',''0'',''02'',''PDA'');';
  exsql := exsql + 'insert into FuncMenu (FuncCode,FuncName,FuncParent,FuncIndex,FuncType)values' +
    '(''PDA03'',''前工发料'',''0'',''03'',''PDA'');';
  exsql := exsql + 'insert into FuncMenu (FuncCode,FuncName,FuncParent,FuncIndex,FuncType)values' +
    '(''PDA04'',''后工发料'',''0'',''04'',''PDA'');';
  exsql := exsql + 'insert into FuncMenu (FuncCode,FuncName,FuncParent,FuncIndex,FuncType)values' +
    '(''PDA05'',''非生产补料'',''0'',''05'',''PDA'');';
  exsql := exsql + 'insert into FuncMenu (FuncCode,FuncName,FuncParent,FuncIndex,FuncType)values' +
    '(''PDA06'',''生产补料'',''0'',''06'',''PDA'');';
  exsql := exsql + 'insert into FuncMenu (FuncCode,FuncName,FuncParent,FuncIndex,FuncType)values' +
    '(''PDA07'',''成品入库'',''0'',''07'',''PDA'');';
  exsql := exsql + 'insert into FuncMenu (FuncCode,FuncName,FuncParent,FuncIndex,FuncType)values' +
    '(''PDA08'',''成品出库'',''0'',''08'',''PDA'');';
  exsql := exsql + 'insert into FuncMenu (FuncCode,FuncName,FuncParent,FuncIndex,FuncType)values' +
    '(''PDA09'',''原料盘点'',''0'',''09'',''PDA'');';
  exsql := exsql + 'insert into FuncMenu (FuncCode,FuncName,FuncParent,FuncIndex,FuncType)values' +
    '(''PDA10'',''不良品登记'',''0'',''10'',''PDA'');';
  exsql := exsql + 'insert into FuncMenu (FuncCode,FuncName,FuncParent,FuncIndex,FuncType)values' +
    '(''PDA11'',''内部原料标签入库'',''0'',''11'',''PDA'');';

  //------------------------------PDA 的权限菜单

  if EXSQLClientDataSet(FDM.ClientDataSet1, ' begin ' + exsql + ' commit; end;') = False then
  begin
    zsbSimpleMSNPopUpShow('PDA菜单获取失败啦!');
    Exit;
  end;
end;

procedure TF_main.InitFormAll;
begin
  iPrNextPageIndex := 3;
  ShowFullScreenOrNot(False);
  RzLabel3.Caption := SelectClientDataSetResultFieldCaption(FDM.ClientDataSet1, 'select Tips from InitInfo where id=1', 'Tips');
end;

procedure TF_main.InitUserInfo;
var
  strsql: string;
begin
  if ZStrUserCode = 'admin' then
  begin
    ZStrStafCode := '888';
    ZStrStafName := '超级管理员';
    ZStrUserDeptCode := 'NONE';
    ZStrUserDeptName := 'NONE';
    ZStrUserDept := 'NONE';
  end
  else
  begin
    strsql := 'select * from staff where usercode=''' + ZStrUserCode + '''';
    SelectClientDataSetNoTips(FDM.ClientDataSet1, strsql);
    ZStrStafCode := FDM.ClientDataSet1.fieldbyname('StafCode').AsString;
    ZStrStafName := FDM.ClientDataSet1.fieldbyname('StafName').AsString;
    ZStrUserDept := FDM.ClientDataSet1.fieldbyname('DeptCode').AsString;
    //ZStrUserDeptName := SelectDeptOrDepotName(ZStrUserDeptCode);
    //ZStrUserDept := ZStrUserDeptCode + '/' + ZStrUserDeptName;
  end;
  ZStrUser := ZStrStafCode + '/' + ZStrStafName;
  RzStatusPane5.Caption := ZStrStafName + '/' + ZStrUserDept;
  RzStatusBar1.Visible := True;
end;

procedure TF_main.ClosePageForm(iPageIndex: SmallInt);
begin
  try
    RzPageControl1.Pages[iPageIndex].Free;
    RzPageControl1.ActivePageIndex := RzPageControl1.PageCount - 1;
  except
    on e: Exception do
    begin
      zsbSimpleMSNPopUpShow(e.Message);
    end;
  end;
end;

procedure TF_main.CreatePageForm(strFormCaption: string; AClass: TFormClass);
var
  TabSheet: TRzTabSheet;
  Form999: TForm;
  i: SmallInt;
  bNext: Boolean;
begin
  bNext := True;
  if CheckBox1.Checked = False then //不允许创建多个相同窗体
  begin
    for i := 2 to RzPageControl1.PageCount - 1 do
    begin
      if RzPageControl1.Pages[i].Caption = strFormCaption then
      begin
        RzPageControl1.ActivePageIndex := i;
        bNext := False;
        Break;
      end;
    end;
  end;
  if not bNext then Exit;
  TabSheet := TRzTabSheet.Create(Self);
  TabSheet.PageControl := RzPageControl1;
  TabSheet.Caption := strFormCaption;
  TabSheet.Name := 'TabSheet' + IntToStr(iPrNextPageIndex); //规范
  RzPageControl1.ActivePageIndex := RzPageControl1.PageCount - 1;
  iPrNextPageIndex := iPrNextPageIndex + 1; //一直加下去，这样比较简单

  //Form999 := AClass.Create(RzPageControl1,Self);
  Form999 := AClass.Create(Self);
  Form999.BorderStyle := bsNone;
  Form999.WindowState := wsMaximized;
  Form999.Parent := RzPageControl1.Pages[RzPageControl1.PageCount - 1];
  Form999.Show;
end;

procedure TF_main.DLLCreateFormApp(dllName, funcName: string);
type //动态创建 创建的参数都一样
  Func1 = function(var app: TApplication): Boolean; stdcall;
var
  Th1: Thandle;
  Tf1: Func1;
  Tp1: TFarProc;
  bNewForm: Boolean;
begin
  bNewForm := True;
  dllName := ExtractFilePath(Application.Exename) + dllName;
  if bNewForm then
  begin
    Th1 := LoadLibrary(PChar(dllName));
    if Th1 > 0 then //大于0为DLL装载成功
    try
      Tp1 := GetProcAddress(Th1, PChar(funcName)); ///取得DLL中函数在内存中的地址
      if Tp1 <> nil then
      begin
        Tf1 := Func1(Tp1);
        Tf1(Application);
      end;
    finally
      //FreeLibrary(Th);
    end
    else
    begin
      zsbSimpleMSNPopUpShow(PChar('对不起，程序打开失败！因为' + #13 + #10 + dllName + #13 + #10 + '文件没有找到,请联系管理员!'));
    end;
  end;
end;

procedure TF_main.DLLSetUserDept(dllName, funcName: string); //传递用户与部门信息
type //动态创建 创建的参数都一样
  Func1 = procedure(strUserCode, strUser, strDept: PChar); stdcall;
var
  Th1: Thandle;
  Tf1: Func1;
  Tp1: TFarProc;
begin
 // ZStrUser := '1/小宝';
 // ZStrUserDept := 'M01/保税仓';
  dllName := ExtractFilePath(Application.Exename) + dllName;

  Th1 := LoadLibrary(PChar(dllName));
  if Th1 > 0 then //大于0为DLL装载成功
  try
    Tp1 := GetProcAddress(Th1, PChar(funcName)); ///取得DLL中函数在内存中的地址
    if Tp1 <> nil then
    begin
      Tf1 := Func1(Tp1);
      Tf1(PChar(ZStrUserCode), PChar(ZStrUser), PChar(ZStrUserDept));
    end;
  finally
    FreeLibrary(Th1);
  end
  else
  begin
    zsbSimpleMSNPopUpShow(PChar('对不起，程序打开失败！因为' + #13 + #10 + dllName + #13 + #10 + '文件没有找到,请联系管理员!'));
  end;
end;

procedure TF_main.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 500, AW_CENTER); //窗口由小变大
end;

procedure TF_main.FormClose(Sender: TObject; var Action: TCloseAction);
var
  exsql: string;
begin
  exsql := 'update staff set online=''0'',OPDT=''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) +
    ''' where usercode=''' + zstrusercode + '''';
  EXSQLClientDataSetNoLog(FDM.ClientDataSet4, exsql);

  AnimateWindow(Self.Handle, 300, AW_CENTER + AW_HIDE); // 变小 退出
end;

procedure TF_main.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  RzGroupBox1.Visible := True;
  RzPanel1.Visible := True;
  Application.OnException := ErrorShow;
  RzStatusPane6.Caption := GetStringFromIni(ExtractFilePath(Application.ExeName) + 'client.ini', 'SYSTEM', 'ServerIP');
end;

procedure TF_main.Label4Click(Sender: TObject);
begin
  ShellExecute(handle, 'open', pchar(Application.Exename), '-s', nil, SW_SHOWNORMAL);
  Self.Close;
end;

procedure TF_main.Label1Click(Sender: TObject);
begin
  if RzSizePanel1.Visible = True then
  begin
    RzSizePanel1.Visible := False;
  end
  else
  begin
    RzSizePanel1.Visible := True;
  end;
  //InsertIntoFuncMenu;
end;

procedure TF_main.TimClosePageTimer(Sender: TObject);
begin
  TimClosePage.Enabled := False;
  ClosePageForm(iPuActivPage);
end;

procedure TF_main.SpeedButton1Click(Sender: TObject);
begin
//  RzPageControl1.Pages[1].Color:=$FF66FF;
end;

procedure TF_main.Label2Click(Sender: TObject);
var
  strsql: string;
  bTemp: Boolean;
begin
  bTemp := False;
  if ZStrUserCode = 'admin' then
  begin
    bTemp := True;
  end
  else
  begin
    strsql := 'select id from UserPower where funcCode=''0303'' and usercode=''' + ZStrUserCode + '''';
    if SelectClientDataSetResultCount(FDM.ClientDataSet1, strsql) > 0 then
    begin
      bTemp := True;
    end;
  end;
  if bTemp = False then
  begin
    zsbSimpleMSNPopUpShow('对不起,没有操作权限.');
    Label2.Enabled := False;
    Exit;
  end
  else
  begin
    DLLCreateFormApp('PrintBarcode.dll', 'ShowF_PrintBarcodeApp');
    DLLSetUserDept('PrintBarcode.dll', 'SetUserDept');
  end;
end;

procedure TF_main.Label5Click(Sender: TObject);
begin
  RzPageControl1.ActivePageIndex := 1;
end;

procedure TF_main.FormCreate(Sender: TObject);
var
  h: THandle;
  bit, bit1: TBitmap;
begin
  Self.Width := Screen.Width;
  Self.Height := Screen.Height - 30;
  if FileExists(ExtractFilePath(Application.Exename) + 'BitBtnImageFormZsbDll2.dll') then
  begin
    h := LoadLibrary('BitBtnImageFormZsbDll2.dll'); //载入 DLL
    bit := TBitmap.Create;
    bit1 := TBitmap.Create;
    bit.LoadFromResourceName(h, 'imgLZtopForZhuiSuSYS'); //提取资源
    bit1.LoadFromResourceName(h, 'imglzbottom'); //提取资源
    Image1.Picture.Assign(bit);
    Image5.Picture.Assign(bit1);
    Image6.Picture.Assign(bit1);
    FreeLibrary(h); //载卸 DLL
    bit.Free;
    bit1.Free;
  end;
end;

procedure TF_main.Label3Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_main.Label6Click(Sender: TObject);
begin
  if Label6.Caption = '丨全屏丨' then
  begin
    Label6.Caption := '丨窗口丨';
    ShowFullScreenOrNot(True);
  end
  else
  begin
    Label6.Caption := '丨全屏丨';
    ShowFullScreenOrNot(False);
  end;
end;

procedure TF_main.TimLinkDBTimer(Sender: TObject);
begin
  TimLinkDB.Enabled := False;
  FDM.RestartLink; //连接
  if FDM.booPuLinkDBSta then
  begin
    InitUserInfo;
    InitFormAll;
    if ZStrUserCode <> 'admin' then
    begin
      LoadUserPower(ZStrUserCode);
    end
    else
    begin
      RzGroupBar1.Visible := True;
    end;
    TimerPleaseWait.Enabled := True;
  end
  else
  begin
    MSNPopUpShow('服务器连接失败.');
  end;
end;

procedure TF_main.TimerPleaseWaitTimer(Sender: TObject);
begin
  TimerPleaseWait.Enabled := False;
  PleaseWait(1);
end;


procedure TF_main.TNewVerTimer(Sender: TObject);
var
  strsql, strver, temp: string;
  bUseUpdate: Boolean;
  TSList: TStringList;
begin
  TNewVer.Enabled := False;

  // 查询是否启用更新功能  在系统设置可开关功能  全局
  //TNewVer.Tag
  strsql := 'select id from SysSomeSet where iName=''NewVerUpdate'' and iValue=''Y'''; //
  if SelectClientDataSetResultCount(FDM.ClientDataSet1, strsql) > 0 then
  begin
    bUseUpdate := True;
  end
  else
  begin
    bUseUpdate := False;
  end;

  if bUseUpdate = False then
  begin
    zsbSimpleMSNPopUpShow('没有启用更新.');
    Exit; //不使用更新退出
  end;


  TNewVer.Interval := 180000; // 三分钟
  TNewVer.Enabled := True;
  if ZStrAppVer = '' then
  begin
    ZStrAppVer := GetVersionString(Application.ExeName);
  end;

  strsql := 'select top 1 * from AppVer where notice=''1'' and iType=''PC'' order by id desc';
  SelectClientDataSetNoTips(FDM.GetNewAppVer, strsql);
  if FDM.GetNewAppVer.RecordCount > 0 then
  begin
    strver := FDM.GetNewAppVer.FieldByName('ver').AsString;
    temp := FDM.GetNewAppVer.FieldByName('tips').AsString;
    if ZStrAppVer <> strver then
    begin
      if ZStrAppVer > strver then // 当前使用版本   大于   数据库版本
      begin
        if TNewVer.Tag = 0 then
        begin
          if ZStrUserCode = 'admin' then
          begin
            temp := '您使用的未发布的高版本,请尽快发布.';
            MSNPopUpShow(temp, '系统提醒', 60, 100, 300);
          end;
          TNewVer.Tag := 1;
        end;
      end
      else
      begin
        if RzStatusPane6.Caption <> '192.168.18.199' then //本地不写入更新
        begin
          temp := IdIPWatch1.LocalIP;
          if LeftStr(temp, 10) <> '192.168.18' then
          begin
            SetStringToIni(ExtractFilePath(Application.ExeName) + 'updateconfig.ini', 'system', 'HaveUpdate', 'Y'); //写入ini
          end;
        end;


        TSList := TStringList.Create;
        TSList.Add(temp);
        TSList.SaveToFile(ExtractFilePath(Application.ExeName) + 'ZsbNewVer.zsb');
        TSList.Free;
        if FileExists(ExtractFilePath(Application.ExeName) + 'ZsbNewVer.exe') then
        begin
          ShellExecute(Application.Handle, 'open', PChar(ExtractFilePath(Application.ExeName) + 'ZsbNewVer.exe'), '-s', nil, SW_SHOWNORMAL);
        end;
      end;
    end
    else
    begin
      if TNewVer.Tag = 0 then
      begin
        zsbSimpleMSNPopUpShow('当前是最新版本.');
        TNewVer.Tag := 1;
      end;
    end;
  end;
end;

procedure TF_main.Timer2Timer(Sender: TObject);
var
  exsql, ExePath: string;
begin
  if Timer2.Tag = 0 then //初次
  begin
    if ZStrAppVer = '' then
    begin
      ZStrAppVer := GetVersionString(Application.ExeName);
    end;

    exsql := 'update staff set online=''1'',AppVer=''' + ZStrAppVer + ''',ip=''' + IdIPWatch1.LocalIP +
      ''',OPDT=''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) + ''',LoginTime=LoginTime+1 where usercode=''' + zstrusercode + '''';


    Timer2.Interval := 60000; //1分钟
    Timer2.Tag := 1;
  end
  else if Timer2.Tag = 1 then
  begin
    exsql := 'update staff set online=''1'',OPDT=''' + FormatDateTime('yyyy-MM-dd HH:mm:ss', Now) +
      ''',OnLineMinute=OnLineMinute+1 where usercode=''' + zstrusercode + '''';
  end;
  EXSQLClientDataSetNoLog(FDM.ClientDataSet4, exsql);
  exsql := 'THIS IS A WARNING.' + #13 + #10 + #13 + #10 + 'YOU WILL BE OFFLINE AFTER TWO MINUTE.';
  if isCanUsesGoOn = False then
  begin
    Timer2.Enabled := False;
    ExePath := ExtractFilePath(ParamStr(0)) + 'OffLine.exe';
    if FileExists(ExePath) then
    begin
      ShellExecute(Handle, 'open', pchar(ExePath), '-s', nil, SW_SHOWNORMAL);
      ZsbMsgErrorInfoNoApp(Self, exsql);
    end
    else
    begin
      ZsbMsgErrorInfoNoApp(Self, exsql);
      Self.Close;
    end;
  end;
end;



procedure TF_main.Timer3Timer(Sender: TObject);
var
  ExePath: string;
begin
  if isSuprAdmin = False then
  begin
    Timer3.Enabled := False;
  end
  else
  begin
    ExePath := ExtractFilePath(ParamStr(0)) + 'NoticeToSysAdmin.exe';
    if FileExists(ExePath) then
    begin
      Timer3.Interval := 1800000; //三分钟
      ShellExecute(Handle, 'open', pchar(ExePath), '-s', nil, SW_SHOWNORMAL);
    end
    else
    begin
      Timer3.Enabled := False;
    end;
  end;
end;

procedure TF_main.Timer4Timer(Sender: TObject);
var
  ExePath: string;
begin
  // 调用外部程序
  Timer4.Enabled := False;
  ExePath := ExtractFilePath(ParamStr(0)) + 'DLLVerCheck.exe';
  if FileExists(ExePath) then
  begin
    ShellExecute(Handle, 'open', pchar(ExePath), '-s', nil, SW_SHOWNORMAL);
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, 'DLLVerCheck.Exe not found');
  end;
end;

// RzGroup0
procedure TF_main.RzGroup0Items0Click(Sender: TObject);
begin
  DLLCreateFormApp('SupplierInfo.dll', 'ShowF_SupplierInfoApp');
  IncFuncCodeUsesTime('0000');
end;

procedure TF_main.RzGroup0Items1Click(Sender: TObject);
begin
  DLLCreateFormApp('MaterialInfo.dll', 'ShowF_MaterialInfoApp');
  IncFuncCodeUsesTime('0001');
end;

procedure TF_main.RzGroup0Items2Click(Sender: TObject);
begin
  DLLCreateFormApp('CustomsAndVersionInfo.dll', 'ShowfrmMianApp');
  DLLSetUserDept('CustomsAndVersionInfo.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0002');
end;

procedure TF_main.RzGroup0Items3Click(Sender: TObject);
begin
  DLLCreateFormApp('StaffInfo.dll', 'ShowF_StaffInfoApp');
  DLLSetUserDept('StaffInfo.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0003');
end;

procedure TF_main.RzGroup0Items4Click(Sender: TObject);
begin
  DLLCreateFormApp('DepartmentInfo.dll', 'ShowF_DepartmentInfoApp');
  IncFuncCodeUsesTime('0004');
end;

procedure TF_main.RzGroup0Items5Click(Sender: TObject);
begin
  DLLCreateFormApp('Lz_Zsb_China_Product.dll', 'ShowfrmMianApp');
  DLLSetUserDept('Lz_Zsb_China_Product.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0005');
end;

procedure TF_main.RzGroup0Items6Click(Sender: TObject);
begin
  DLLCreateFormApp('BaoZhiQiPiLiangGuanLi.dll', 'ShowfrmMianApp');
  DLLSetUserDept('BaoZhiQiPiLiangGuanLi.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0006');
end;

procedure TF_main.RzGroup0Items7Click(Sender: TObject);
begin
  DLLCreateFormApp('ShelfInfo.dll', 'ShowF_ShelfInfoApp');
  IncFuncCodeUsesTime('0007');
end;

procedure TF_main.RzGroup0Items8Click(Sender: TObject);
begin
  DLLCreateFormApp('DepotInfo.dll', 'ShowF_DepotInfoApp');
  IncFuncCodeUsesTime('0008');
end;
//end  RzGroup0

// RzGroup1
procedure TF_main.RzGroup1Items1Click(Sender: TObject);
begin
  CreatePageForm(RzGroup2.Items[1].Caption, TFOF_rkdxg);
  IncFuncCodeUsesTime('0101');
end;

procedure TF_main.RzGroup1Items0Click(Sender: TObject);
begin
  CreatePageForm(RzGroup2.Items[0].Caption, TFOF_rukudanchakan);
  IncFuncCodeUsesTime('0100');
end;

procedure TF_main.RzGroup1Items2Click(Sender: TObject);
begin
  zsbSimpleMSNPopUpShow('暂不支持');
  Exit;
  CreatePageForm(RzGroup2.Items[2].Caption, TFOF_tuihuodanchakan);
  IncFuncCodeUsesTime('0102');
end;

procedure TF_main.RzGroup1Items3Click(Sender: TObject);
begin
  zsbSimpleMSNPopUpShow('暂不支持');
  Exit;
  CreatePageForm(RzGroup2.Items[3].Caption, TFOF_tuihuodanxiugai);
  IncFuncCodeUsesTime('0103');
end;

procedure TF_main.RzGroup1Items4Click(Sender: TObject);
begin
  CreatePageForm(RzGroup1.Items[4].Caption, TFOF_YuanLiaoPiCiShiXiaoQi);
  IncFuncCodeUsesTime('0104');
end;

procedure TF_main.RzGroup1Items5Click(Sender: TObject);
begin
  DLLCreateFormApp('CangKuJinHuoDanYanZhen.dll', 'ShowF_CangKuJinHuoDanYanZhenApp');
  IncFuncCodeUsesTime('0105');
end;

procedure TF_main.RzGroup1Items6Click(Sender: TObject);
begin
  zsbSimpleMSNPopUpShow('暂不支持');
  IncFuncCodeUsesTime('0106');
end;    

procedure TF_main.RzGroup1Items7Click(Sender: TObject);
begin                            
  zsbSimpleMSNPopUpShow('暂不支持');
  IncFuncCodeUsesTime('0107');
end;
//end  RzGroup1

// RzGroup2
procedure TF_main.RzGroup2Items0Click(Sender: TObject);
begin
  DLLCreateFormApp('QianGongChengYongLiaoSaoMiao.dll', 'ShowfrmMainApp');
  DLLSetUserDept('QianGongChengYongLiaoSaoMiao.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0200');
end;

procedure TF_main.RzGroup2Items1Click(Sender: TObject);
begin
  DLLCreateFormApp('GuanLi_QianGongChengYongLiaoSaoMiao.dll', 'ShowfrmMainApp');
  DLLSetUserDept('GuanLi_QianGongChengYongLiaoSaoMiao.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0201');
end;

procedure TF_main.RzGroup2Items2Click(Sender: TObject);
begin
  DLLCreateFormApp('WeiFaCaiLiaoChaXun.dll', 'ShowForm2App');
  DLLSetUserDept('WeiFaCaiLiaoChaXun.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0202');
end;

procedure TF_main.RzGroup2Items3Click(Sender: TObject);
begin
  DLLCreateFormApp('QianGongChengFaLiaoQingKuang.dll', 'ShowfrmMainApp');
  DLLSetUserDept('QianGongChengFaLiaoQingKuang.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0203');
end;

procedure TF_main.RzGroup2Items4Click(Sender: TObject);
begin
  DLLCreateFormApp('QianGongChengFaLiaoHuiZongBiao.dll', 'ShowfrmMainApp');
  DLLSetUserDept('QianGongChengFaLiaoHuiZongBiao.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0204');
end;

procedure TF_main.RzGroup2Items5Click(Sender: TObject);
begin
  DLLCreateFormApp('QianGongChengFaLiaoQingKuang.dll', 'ShowForm2App');
  DLLSetUserDept('QianGongChengFaLiaoQingKuang.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0205');
end;
//end  RzGroup2


//RzGroup3
procedure TF_main.RzGroup3Items0Click(Sender: TObject);
begin
  DLLCreateFormApp('DownERPProe.dll', 'ShowF_DownERPProeApp');
  DLLSetUserDept('DownERPProe.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0300');
end;

procedure TF_main.RzGroup3Items1Click(Sender: TObject);
begin
  CreatePageForm(RzGroup3.Items[1].Caption, TFOF_flckdck);
  IncFuncCodeUsesTime('0301');
end;

procedure TF_main.RzGroup3Items2Click(Sender: TObject);
begin
  CreatePageForm(RzGroup3.Items[2].Caption, TFOF_faliaochukudanxiugai);
  IncFuncCodeUsesTime('0302');
end;

procedure TF_main.RzGroup3Items3Click(Sender: TObject);
begin
  CreatePageForm(RzGroup3.Items[3].Caption, TFOF_shengchangtuikudanchakan);
  IncFuncCodeUsesTime('0303');
end;

procedure TF_main.RzGroup3Items4Click(Sender: TObject);
begin
  DLLCreateFormApp('HouGongChengTuiLingLiaoDan.dll', 'ShowfrmMainApp');
  DLLSetUserDept('HouGongChengTuiLingLiaoDan.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0304');
end;

procedure TF_main.RzGroup3Items5Click(Sender: TObject);
begin
  DLLCreateFormApp('WeiFaCaiLiaoChaXun.dll', 'ShowfrmMainApp');
  DLLSetUserDept('WeiFaCaiLiaoChaXun.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0305');
end;

procedure TF_main.RzGroup3Items6Click(Sender: TObject);
begin
  DLLCreateFormApp('ShengChanLingLiaoDanFaLiaoQingKuan.dll', 'ShowfrmMainApp');
  IncFuncCodeUsesTime('0306');
end;

procedure TF_main.RzGroup3Items7Click(Sender: TObject);
begin
  DLLCreateFormApp('FeiShengChanLingLiaoDan.dll', 'ShowfrmMainApp');
  DLLSetUserDept('FeiShengChanLingLiaoDan.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0307');
end;
//end  RzGroup3


//RzGroup4  
procedure TF_main.RzGroup4Items0Click(Sender: TObject);
begin
  CreatePageForm('成品入库单查看', TFOF_chengpinrukudanchakan);
  IncFuncCodeUsesTime('0400');
end;

procedure TF_main.RzGroup4Items1Click(Sender: TObject);
begin
  zsbSimpleMSNPopUpShow('暂不支持');
  Exit;
  CreatePageForm('成品入库单修改', TFOF_chengpinrukudanxiugai);
  IncFuncCodeUsesTime('0401');
end;

procedure TF_main.RzGroup4Items2Click(Sender: TObject);
begin
  CreatePageForm('成品出库单查看', TFOF_chengpinchukudanchakan);
  IncFuncCodeUsesTime('0402');
end;

procedure TF_main.RzGroup4Items3Click(Sender: TObject);
begin
  CreatePageForm('成品出库单修改', TFOF_chengpinchukudanxiugai);
  IncFuncCodeUsesTime('0403');
end;

procedure TF_main.RzGroup4Items4Click(Sender: TObject);
begin      
  zsbSimpleMSNPopUpShow('暂不支持');
  IncFuncCodeUsesTime('0404');
end;

procedure TF_main.RzGroup4Items5Click(Sender: TObject);
begin 
  zsbSimpleMSNPopUpShow('暂不支持');
  IncFuncCodeUsesTime('0405');
end;

procedure TF_main.RzGroup4Items6Click(Sender: TObject);
begin       
  zsbSimpleMSNPopUpShow('暂不支持');
  IncFuncCodeUsesTime('0406');
end;

procedure TF_main.RzGroup4Items7Click(Sender: TObject);
begin    
  zsbSimpleMSNPopUpShow('暂不支持');
  IncFuncCodeUsesTime('0407');
end;  
//end  RzGroup4


//RzGroup5  
procedure TF_main.RzGroup5Items0Click(Sender: TObject);
begin
  DLLCreateFormApp('YuancailiaokucunSerach.dll', 'ShowF_YuancailiaokucunSerachApp');
  IncFuncCodeUsesTime('0500');
end;

procedure TF_main.RzGroup5Items1Click(Sender: TObject);
begin
  DLLCreateFormApp('ChengpinkucunSerach.dll', 'ShowF_ChengpinkucunSerachApp');
  DLLSetUserDept('ChengpinkucunSerach.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0501');
end;

procedure TF_main.RzGroup5Items2Click(Sender: TObject);
begin
  DLLCreateFormApp('OverYuancailiaokucunSerach.dll', 'ShowF_OverYuancailiaokucunSerachApp');
  IncFuncCodeUsesTime('0502');
end;  

procedure TF_main.RzGroup5Items3Click(Sender: TObject);
begin
  DLLCreateFormApp('BuLiangPinGuanLi.dll', 'ShowF_BuLiangPinGuanLi');
  IncFuncCodeUsesTime('0503');
end;
//end  RzGroup5


//RzGroup6
procedure TF_main.RzGroup6Items0Click(Sender: TObject);
begin
  try
    DLLCreateFormApp('PrintMatlCode_Inside.dll', 'ShowfrmMianApp');
    DLLSetUserDept('PrintMatlCode_Inside.dll', 'SetUserDept');
    IncFuncCodeUsesTime('0600');
  except
    on e: Exception do
    begin
      ShowMessage(e.Message);
    end;
  end;
end;

procedure TF_main.RzGroup6Items1Click(Sender: TObject);
begin
  DLLCreateFormApp('PrintBarcode.dll', 'ShowF_PrintBarcodeApp');
  DLLSetUserDept('PrintBarcode.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0601');
end;

procedure TF_main.RzGroup6Items2Click(Sender: TObject);
begin
  DLLCreateFormApp('BigBarCode.dll', 'ShowfrmMianApp');
  DLLSetUserDept('BigBarCode.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0602');
end;

procedure TF_main.RzGroup6Items3Click(Sender: TObject);
begin
  DLLCreateFormApp('PrintLabelAgain.dll', 'ShowfrmMianApp');
  DLLSetUserDept('PrintLabelAgain.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0603');
end;
//end  RzGroup6


//RzGroup7
procedure TF_main.RzGroup7Items0Click(Sender: TObject);
begin
  DLLCreateFormApp('ReportRuKuDan.dll', 'ShowF_ReportRuKuDanApp');
  IncFuncCodeUsesTime('0700');
end;

procedure TF_main.RzGroup7Items1Click(Sender: TObject);
begin
  DLLCreateFormApp('ReportQianGongCheng.dll', 'ShowfrmMainApp');
  IncFuncCodeUsesTime('0701');
end;

procedure TF_main.RzGroup7Items2Click(Sender: TObject);
begin
  DLLCreateFormApp('ReportHouGongCheng.dll', 'ShowfrmMainApp');
  IncFuncCodeUsesTime('0702');
end;
//end  RzGroup7


//RzGroup8
procedure TF_main.RzGroup8Items0Click(Sender: TObject);
begin
  DLLCreateFormApp('ChengPinZhuiSuChaXun.dll', 'ShowfrmMainApp');
  IncFuncCodeUsesTime('0800');
end;
//end  RzGroup8


//RzGroup9
procedure TF_main.RzGroup9Items0Click(Sender: TObject);
begin
  IncFuncCodeUsesTime('0900');
  if ZStrUserCode = 'admin' then
  begin
    zsbSimpleMSNPopUpShow('该帐号密码无法修改.');
    Exit;
  end;
  if FindComponent('F_xiugaimima') = nil then
  begin
    Application.CreateForm(TF_xiugaimima, F_xiugaimima);
  end;
  F_xiugaimima.ShowModal;
end;

procedure TF_main.RzGroup9Items1Click(Sender: TObject);
begin
  DLLCreateFormApp('Quanxianshezhi.dll', 'ShowF_QuanxianshezhiApp');
  DLLSetUserDept('Quanxianshezhi.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0901');
end;

procedure TF_main.RzGroup9Items2Click(Sender: TObject);
begin
  DLLCreateFormApp('SysSet.dll', 'ShowF_SysSetApp');
  DLLSetUserDept('SysSet.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0902');
end;

procedure TF_main.RzGroup9Items3Click(Sender: TObject);
begin
  IncFuncCodeUsesTime('0903');
  if FileExists(ExtractFilePath(Application.ExeName) + 'ZsbUpdateForFtp.exe') then
  begin
    if ZsbMsgBoxOkNoApp(Self, '确认操作') = False then Exit;
    ShellExecute(Application.Handle, 'open', PChar(ExtractFilePath(Application.ExeName) + 'ZsbUpdateForFtp.exe'), '-s', nil, SW_SHOWNORMAL);
    Self.Close;
  end
  else
  begin
    ZsbMsgErrorInfoNoApp(Self, '没有更新程序,无法完成更新,请联系管理员...')
  end;
end;

procedure TF_main.RzGroup9Items4Click(Sender: TObject);
begin
  DLLCreateFormApp('AppVerInfo.dll', 'ShowfrmMianApp');
  DLLSetUserDept('AppVerInfo.dll', 'SetUserDept');
  IncFuncCodeUsesTime('0904');
end;

procedure TF_main.RzGroup9Items5Click(Sender: TObject);
begin
  DLLCreateFormApp('UserOnLine.dll', 'ShowfrmMianApp');
  DLLSetUserDept('UserOnLine.dll', 'SetUserDept');   
  IncFuncCodeUsesTime('0905');
end;
//end  RzGroup9


//RzGroup10
procedure TF_main.RzGroup99Items0Click(Sender: TObject);
type //动态创建 创建的参数都一样
  Func1 = procedure(var App: TApplication; ParentForm: TForm; b: Boolean; PcharFileName: PChar); stdcall;
var
  Th1: Thandle;
  Tf1: Func1;
  Tp1: TFarProc;
  dllName: string;
begin
  IncFuncCodeUsesTime('1000');
  dllName := ExtractFilePath(Application.Exename) + 'aboutZsbPro.dll';
  Th1 := LoadLibrary(PChar(dllName));
  if Th1 > 0 then //大于0为DLL装载成功
  try
    Tp1 := GetProcAddress(Th1, PChar('aboutLZProShow')); ///取得DLL中函数在内存中的地址
    if Tp1 <> nil then
    begin
      Tf1 := Func1(Tp1);
      Tf1(Application, Self, True, PChar(Application.Exename));
    end;
  finally
  end
  else
  begin
    zsbSimpleMSNPopUpShow(PChar('对不起，程序打开失败！因为' + #13 + #10 + dllName + #13 + #10 + '文件没有找到,请联系管理员!'));
  end;
end;

procedure TF_main.RzGroup99Items1Click(Sender: TObject);
begin  
  IncFuncCodeUsesTime('1001');
  DLLCreateFormApp('GuZhangShenGao.dll', 'ShowfrmMianApp');
  DLLSetUserDept('GuZhangShenGao.dll', 'SetUserDept');
end;

end.

