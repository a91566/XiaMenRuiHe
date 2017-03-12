unit U_Quanxianshezhi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGridEh, StdCtrls, Buttons, Mask,
  DBCtrlsEh, RzLabel, ExtCtrls, RzPanel, RzTabs, MConnect, SConnect,
  ComCtrls, ImgList;

type
  TF_Quanxianshezhi = class(TForm)
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    Timer2: TTimer;
    RzPanel1: TRzPanel;
    SpeedButton999: TSpeedButton;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton1: TSpeedButton;
    ilCheckBox: TImageList;
    Image1: TImage;
    ClientDataSet2: TClientDataSet;
    ClientDataSet3: TClientDataSet;
    RzPageControl2: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    TreeView1: TTreeView;
    RzTabSheet2: TRzTabSheet;
    TreeView2: TTreeView;
    Label2: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton999Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeView2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox1Change(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
    procedure LoadFuncMenuForPC;                                       {加载菜单项目}
    procedure LoadFuncMenuForPDA;                                      {加载菜单项目}
    procedure LoadUserPowerForPC(strUserCode:string);                  {加载用户的权限菜单项目}
    procedure LoadUserPowerForPDA(strUserCode:string);                 {加载用户的权限菜单项目}
    procedure AddUser;
    { Private declarations }
  public
    S_menucodelist: tstringlist;  
    S_menucodelist2: tstringlist;
    { Public declarations }
  end;

var
  F_Quanxianshezhi: TF_Quanxianshezhi;

implementation

uses UDM, ZsbFunPro2;

{$R *.dfm}

procedure TF_Quanxianshezhi.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0; //重载 显示在任务栏
end;

procedure TF_Quanxianshezhi.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_Quanxianshezhi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //AnimateWindow(Self.Handle, 300, AW_CENTER+ AW_HIDE); // 没效果好像2013年3月18日 11:38:05
  S_menucodelist.Free;
  S_menucodelist2.Free;
  Action := caFree;
end;

procedure TF_Quanxianshezhi.FormCreate(Sender: TObject);
begin
  //Self.Top := 0;
  //Self.Top := 0;
end;

procedure TF_Quanxianshezhi.FormShow(Sender: TObject);
begin
  AnimateWindow(Handle, 250, AW_CENTER); //窗口由小变大
end;

procedure TF_Quanxianshezhi.AddUser;
var
  strsql:string;
begin
  strsql:='select stafname,usercode from staff where stafname<>''超级管理员'' order by stafname';
  SelectClientDataSetNoTips(ClientDataSet2,strsql);
  ComboBox1.Clear;
  ComboBox2.Clear;
  with ClientDataSet2 do
  begin
    First;
    while not Eof do
    begin
      ComboBox1.Items.Add(FieldByName('stafname').AsString);
      ComboBox2.Items.Add(FieldByName('usercode').AsString);
      Next;
    end;
  end;
end;

procedure TF_Quanxianshezhi.LoadUserPowerForPC(strUserCode:string);
var
  I: INTEGER;
begin
  if TreeView1.Items.Count=0 then Exit;
  for I := 0 to TREEVIEW1.ITEMS.COUNT - 1 do
  begin
    treeview1.Items[i].StateIndex := 1;
  end;
  SelectClientDataSetNoTips(ClientDataSet1,'select FuncCode from UserPower where usercode=''' + strUserCode + ''' and powertype=''PC''');
  with ClientDataSet1 do
  begin
    while not eof do
    begin
      for I := 0 to TREEVIEW1.ITEMS.COUNT - 1 do
      begin
        if S_menucodelist.Strings[i] = fieldbyname('funccode').AsString then
        begin
          TreeView1.ITEMS[I].StateIndex := 2;
        end;
      end;
      next;
    end;
    close;
  end;
end;

procedure TF_Quanxianshezhi.LoadUserPowerForPDA(strUserCode:string);
var
  I: INTEGER;
begin
  if TreeView2.Items.Count=0 then Exit;
  for I := 0 to TREEVIEW2.ITEMS.COUNT - 1 do
  begin
    treeview2.Items[i].StateIndex := 1;
  end;
  SelectClientDataSetNoTips(ClientDataSet1,'select FuncCode from UserPower where usercode=''' + strUserCode + ''' and powertype=''PDA''');
  with ClientDataSet1 do
  begin
    while not eof do
    begin
      for I := 0 to TREEVIEW2.ITEMS.COUNT - 1 do
      begin
        if S_menucodelist2.Strings[i] = fieldbyname('funccode').AsString then
        begin
          TreeView2.ITEMS[I].StateIndex := 2;
        end;
      end;
      next;
    end;
    close;
  end;
end;

procedure NoteParent(note: ttreenode);
begin
  if note.Parent <> nil then
  begin
    note.Parent.StateIndex := 2;
    noteparent(note.Parent);
  end
end;

procedure TF_Quanxianshezhi.LoadFuncMenuForPC;
var
  strsql: string;
  note,  note2, note3: ttreenode;
begin
  TreeView1.Items.Clear;
  S_menucodelist := tstringlist.Create;
  strsql := 'select * from funcmenu where funcparent=''0'' and FuncType=''PC'' order by funcindex';
  SelectClientDataSetNoTips(ClientDataSet1, strsql);
  with ClientDataSet1 do
  begin
    while not ClientDataSet1.Eof do
    begin
      note := TreeView1.Items.Add(nil, fieldbyname('funcname').AsString);
      S_menucodelist.Add(ClientDataSet1.fieldbyname('funccode').AsString);
      note.StateIndex := 1;

      strsql := 'select * from funcmenu where funcparent=''' + ClientDataSet1.fieldbyname('funccode').AsString + ''' and FuncType=''PC'' order by funcindex';
      SelectClientDataSetNoTips(ClientDataSet2, strsql);
      with ClientDataSet2 do
      begin
        while not ClientDataSet2.Eof do
        begin
          note2 := treeview1.Items.AddChild(note, ClientDataSet2.fieldbyname('funcname').AsString);
          S_menucodelist.Add(ClientDataSet2.fieldbyname('funccode').asstring);
          note2.StateIndex := 1;


          strsql := 'select * from funcmenu where funcparent=''' + ClientDataSet2.fieldbyname('funccode').AsString + ''' and FuncType=''PC'' order by funcindex';
          SelectClientDataSetNoTips(ClientDataSet3, strsql);
          with ClientDataSet3 do
          begin
            while not ClientDataSet3.Eof do
            begin
              note3 := treeview1.Items.AddChild(note2, fieldbyname('funcname').AsString);
              S_menucodelist.Add(fieldbyname('funccode').asstring);
              note3.StateIndex := 1;
              Next;
            end;
          end;
          Next;
        end;
      end;
      Next;
    end;
  end;
  TreeView1.Visible:=True;
end;

procedure TF_Quanxianshezhi.LoadFuncMenuForPDA;
var
  strsql: string;
  note,  note2, note3: ttreenode;
begin    //S_menucodelist
  TreeView2.Items.Clear;
  S_menucodelist2 := tstringlist.Create;
  strsql := 'select * from funcmenu where funcparent=''0'' and FuncType=''PDA'' order by funcindex';
  SelectClientDataSetNoTips(ClientDataSet1, strsql);
  with ClientDataSet1 do
  begin
    while not ClientDataSet1.Eof do
    begin
      note := TreeView2.Items.Add(nil, fieldbyname('funcname').AsString);
      S_menucodelist2.Add(ClientDataSet1.fieldbyname('funccode').AsString);
      note.StateIndex := 1;

      strsql := 'select * from funcmenu where funcparent=''' + ClientDataSet1.fieldbyname('funccode').AsString + ''' and FuncType=''PC'' order by funcindex';
      SelectClientDataSetNoTips(ClientDataSet2, strsql);
      with ClientDataSet2 do
      begin
        while not ClientDataSet2.Eof do
        begin
          note2 := TreeView2.Items.AddChild(note, ClientDataSet2.fieldbyname('funcname').AsString);
          S_menucodelist2.Add(ClientDataSet2.fieldbyname('funccode').asstring);
          note2.StateIndex := 1;


          strsql := 'select * from funcmenu where funcparent=''' + ClientDataSet2.fieldbyname('funccode').AsString + ''' and FuncType=''PC'' order by funcindex';
          SelectClientDataSetNoTips(ClientDataSet3, strsql);
          with ClientDataSet3 do
          begin
            while not ClientDataSet3.Eof do
            begin
              note3 := TreeView2.Items.AddChild(note2, fieldbyname('funcname').AsString);
              S_menucodelist2.Add(fieldbyname('funccode').asstring);
              note3.StateIndex := 1;
              Next;
            end;
          end;
          Next;
        end;
      end;
      Next;
    end;
  end;
  TreeView2.Visible:=True;
end;

procedure TF_Quanxianshezhi.SpeedButton999Click(Sender: TObject);
var
  strSQL, temp: string;
begin
  if SpeedButton999.Visible=False then
  begin 
    zsbSimpleMSNPopUpShow('操作受限.');
    Exit;
  end;
  strSQL := 'select StafCode,StafName,StafState,UserState,DeptCode from Staff where UserCode=''' + ComboBox2.Text + '''';
  SelectClientDataSet(ClientDataSet1, strSQL);
  if ClientDataSet1.RecordCount = 1 then
  begin
    if ClientDataSet1.FieldByName('StafState').AsString = '在职' then
    begin
      if ClientDataSet1.FieldByName('UserState').AsString = 'Y' then
      begin
        temp := ClientDataSet1.FieldByName('StafName').AsString; 
        temp := ClientDataSet1.FieldByName('StafCode').AsString+ '/' +temp ;
       // temp := temp + '/' + SelectDeptOrDepotName(ClientDataSet1.FieldByName('DeptCode').AsString);
        LoadUserPowerForPC(ComboBox2.Text);
        LoadUserPowerForPDA(ComboBox2.Text);
        SpeedButton3.Enabled:=True;
      end
      else
      begin
        zsbSimpleMSNPopUpShow('该帐号已经禁用.');
      end
    end
    else
    begin
      zsbSimpleMSNPopUpShow('该人员不在职.');
    end;
  end
  else
  begin
    zsbSimpleMSNPopUpShow('没有相关信息.');
  end;
end;

procedure TF_Quanxianshezhi.Timer1Timer(Sender: TObject);
var
  h: THandle;
  bit: TBitmap;
begin
  Timer1.Enabled := False;
  if FileExists(ExtractFilePath(Application.Exename) + 'BitBtnImageFormZsbDll2.dll') then
  begin
    h := LoadLibrary('BitBtnImageFormZsbDll2.dll'); //载入 DLL
    bit := TBitmap.Create;
    bit.LoadFromResourceName(h, 'imgLZtopForZhuiSuSYS2'); //提取资源
    Image1.Picture.Assign(bit);
    FreeLibrary(h); //载卸 DLL
    bit.Free;
  end;
  RzPageControl1.Visible := True;
  RzPageControl1.ActivePageIndex := 0;
end;

procedure TF_Quanxianshezhi.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := False;
  try
    FDM := TFDM.Create(nil);
    FDM.RestartLink; //创建数据库连接
    if FDM.booPuLinkDBSta = False then
    begin
      if Application.MessageBox(PChar(FDM.strPuLinkError), '错误信息', MB_ICONERROR + MB_RETRYCANCEL) = idRETRY then
      begin
        FDM.RestartLink;
      end
      else
      begin
        Self.Close;
      end;
    end;
    SpeedButton999.Visible:=isAdmin;
    LoadFuncMenuForPC;
    LoadFuncMenuForPDA;
    AddUser;
  finally

  end;
end;

procedure TF_Quanxianshezhi.SpeedButton1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TF_Quanxianshezhi.SpeedButton3Click(Sender: TObject);
var
  i: integer;
  exsql,strusercode: string;
begin
  strusercode:=ComboBox2.Text;
  exsql := 'delete from  userpower where usercode=''' + strusercode + '''';
  for i := 0 to treeview1.Items.Count - 1 do
  begin
    if treeview1.Items[i].StateIndex = 2 then
    begin
      exsql := exsql + ' insert into userpower(usercode,funccode,powertype) values(''' +
        strusercode + ''',''' + S_menucodelist.Strings[i] + ''',''PC'');';
    end;
  end;
  for i := 0 to treeview2.Items.Count - 1 do
  begin
    if treeview2.Items[i].StateIndex = 2 then
    begin
      exsql := exsql + ' insert into userpower(usercode,funccode,powertype) values(''' +
        strusercode + ''',''' + S_menucodelist2.Strings[i] + ''',''PDA'');';
    end;
  end;
  if exsql <> '' then
  begin
    exsql:=' begin tran ' + exsql  + ' commit tran';
    if EXSQLClientDataSet(ClientDataSet3,exsql) then
    begin  
      zsbSimpleMSNPopUpShow('操作成功.');
    end
    else
    begin
      zsbSimpleMSNPopUpShow('操作失败.');
    end;
  end
  else
  begin 
    zsbSimpleMSNPopUpShow('SQL语句获取失败.');
  end;
end;

procedure TF_Quanxianshezhi.TreeView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  MyHitTest: THitTests;
  node: TTreeNode;
  i, j: integer;
begin
  node := TreeView1.GetNodeAt(x, y);
  MyHitTest := TreeView1.GetHitTestInfoAt(X, Y);
  if htOnStateIcon in MyHitTest then
  begin
    if node.StateIndex = 1 then
    begin
      node.StateIndex := 2;
      if node.HasChildren = true then
        for i := 0 to node.Count - 1 do
        begin
          node.Item[i].StateIndex := 2;
          if node.Item[i].HasChildren = true then
            for j := 0 to node.Item[i].Count - 1 do
            begin
              node.Item[i].Item[j].StateIndex := 2;
            end;
        end
      else
        if node.Parent <> nil then
        begin
                       //node.Parent.StateIndex:=2;
                       //if node.Parent.Parent<>nil then
                       //begin
                       //end;
          noteparent(node);
        end
    end

    else
    begin
      if node.HasChildren = true then
        for i := 0 to node.Count - 1 do
        begin
          node.Item[i].StateIndex := 1;
          if node.Item[i].HasChildren = true then
            for j := 0 to node.Item[i].Count - 1 do
            begin
              node.Item[i].Item[j].StateIndex := 1;
            end;
        end;
      node.StateIndex := 1;
    end;
  end;
end;

procedure TF_Quanxianshezhi.TreeView2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  MyHitTest: THitTests;
  node: TTreeNode;
  i, j: integer;
begin    
  node := TreeView2.GetNodeAt(x, y);
  MyHitTest := TreeView2.GetHitTestInfoAt(X, Y);
  if htOnStateIcon in MyHitTest then
  begin
    if node.StateIndex = 1 then
    begin
      node.StateIndex := 2;
      if node.HasChildren = true then
        for i := 0 to node.Count - 1 do
        begin
          node.Item[i].StateIndex := 2;
          if node.Item[i].HasChildren = true then
            for j := 0 to node.Item[i].Count - 1 do
            begin
              node.Item[i].Item[j].StateIndex := 2;
            end;
        end
      else
        if node.Parent <> nil then
        begin
                       //node.Parent.StateIndex:=2;
                       //if node.Parent.Parent<>nil then
                       //begin
                       //end;
          noteparent(node);
        end
    end

    else
    begin
      if node.HasChildren = true then
        for i := 0 to node.Count - 1 do
        begin
          node.Item[i].StateIndex := 1;
          if node.Item[i].HasChildren = true then
            for j := 0 to node.Item[i].Count - 1 do
            begin
              node.Item[i].Item[j].StateIndex := 1;
            end;
        end;
      node.StateIndex := 1;
    end;
  end;

end;

procedure TF_Quanxianshezhi.ComboBox1Change(Sender: TObject);
begin
  ComboBox2.ItemIndex:=ComboBox1.ItemIndex;
end;

end.

