program PRHPRORETSYS;

uses
  ShareMem,
  SysUtils,
  Dialogs,
  Windows,
  ShellAPI,
  Forms,
  U_main in 'U_main.pas' {F_main},
  U_ObjectForm in 'U_ObjectForm.pas' {F_ObjectForm},
  UOF_flckdck in 'UOF_flckdck.pas' {FOF_flckdck},
  ZsbFunPro in 'ZsbFunPro.pas',
  ZsbVariable in 'ZsbVariable.pas',
  ZsbDLL in 'ZsbDLL.pas',
  UDM in 'UDM.pas' {FDM: TDataModule},
  UOF_rukudanchakan in 'UOF_rukudanchakan.pas' {FOF_rukudanchakan},
  UOF_tuihuodanchakan in 'UOF_tuihuodanchakan.pas' {FOF_tuihuodanchakan},
  UOF_tuihuodanxiugai in 'UOF_tuihuodanxiugai.pas' {FOF_tuihuodanxiugai},
  UOF_faliaochukudanxiugai in 'UOF_faliaochukudanxiugai.pas' {FOF_faliaochukudanxiugai},
  UOF_shengchangtuikudanchakan in 'UOF_shengchangtuikudanchakan.pas' {FOF_shengchangtuikudanchakan},
  UOF_shengchangtuikudanxiugai in 'UOF_shengchangtuikudanxiugai.pas' {FOF_shengchangtuikudanxiugai},
  UOF_chengpinrukudanchakan in 'UOF_chengpinrukudanchakan.pas' {FOF_chengpinrukudanchakan},
  UOF_chengpinrukudanxiugai in 'UOF_chengpinrukudanxiugai.pas' {FOF_chengpinrukudanxiugai},
  UOF_chengpinchukudanchakan in 'UOF_chengpinchukudanchakan.pas' {FOF_chengpinchukudanchakan},
  UOF_chengpinchukudanxiugai in 'UOF_chengpinchukudanxiugai.pas' {FOF_chengpinchukudanxiugai},
  U_xiugaimima in 'U_xiugaimima.pas' {F_xiugaimima},
  UOF_rkdxg in 'UOF_rkdxg.pas' {FOF_rkdxg},
  UOF_qiangongchengyongliao in 'UOF_qiangongchengyongliao.pas' {FOF_qiangongchengyongliao},
  UOF_YuanLiaoPiCiShiXiaoQi in 'UOF_YuanLiaoPiCiShiXiaoQi.pas' {FOF_YuanLiaoPiCiShiXiaoQi};

type
  Func = function: string; stdcall;
var
  PCharOperCode: string;
  Th: Thandle;
  Tf: Func;
  Tp: TFarProc;
  strEx:string;
{$R *.res}

{
begin
  Application.Initialize;
  Application.Title := '厦门睿和电子生产追溯管理系统';
  Application.CreateForm(TF_main, F_main);
  Application.CreateForm(TFDM, FDM);
  Application.CreateForm(TFOF_rkdxg, FOF_rkdxg);
  Application.Run;
end.
}

procedure Halt0;
begin
  Halt;
end;

begin
  Application.Initialize;
  Application.Title := '力真追溯管理系统';

  if GetStringFromIni(ExtractFilePath(Application.Exename) + 'updateconfig.ini', 'SYSTEM', 'HaveUpdate') = 'Y' then
  begin
    if FileExists(ExtractFilePath(Application.ExeName) + 'ZsbUpdateForFtp.exe') then
    begin
      ShellExecute(Application.Handle, 'open', PChar(ExtractFilePath(Application.ExeName) + 'ZsbUpdateForFtp.exe'), '-s', nil, SW_SHOWNORMAL);
      Exit;
    end
    else
    begin
      Application.MessageBox('程序发现新版本，却没有更新程序,无法完成更新,请联系管理员...', '错误', MB_ICONERROR);
    end;
  end;

  PCharOperCode := '0';
  try
    Th := LoadLibrary('LoginIn.dll');
    if Th > 0 then ///大于0为DLL装载成功
    try
      Tp := GetProcAddress(Th, PChar('ShowF_LoginIn')); ///取得DLL中TestC函数在内存中的地址
      if Tp <> nil then
      begin
        Tf := Func(Tp);
        PCharOperCode := Tf;
      end;
    finally
      //FreeLibrary(Th); //释放DLL
    end;
  except
    on e:Exception do
    begin
      strEx:='对不起，程序启动异常，在加载[ ShowF_LoginIn ]处.请联系管理员，或者重新启动。'+#13+#10+#13+#10;
      strEx:=strEx+'错误代码:'+e.Message+'.';
      Application.MessageBox(PChar(strEx), '系统异常', MB_ICONERROR);
      Exit;
    end;
  end;
  ZStrUserCode:=PCharOperCode;

  //Application.MessageBox(PChar(ZStrUserCode), '错误信息', MB_ICONERROR);
  if ZStrUserCode <> '' then
  begin
    //ShowMessage('用户帐号：'+ZStrUserCode);
   // PleaseWait(0);
    Application.CreateForm(TF_main, F_main);
    Application.CreateForm(TFDM, FDM);
  //F_main.Caption := F_main.Caption + strOperCode;
    Application.Run;

    //ShowMessage('Application.Run');
   { asm
      xor edx, edx
      push ebp
      push OFFSET @@safecode
      push dword ptr fs:[edx]
      mov fs:[edx],esp
      call Halt0
      jmp @@exit;
      @@safecode:
      call Halt0;
      @@exit:
    end;   }
  end;{
  else
  begin
      strEx:='对不起，程序启动失败，可能是登录文件丢失导致'+#13+#10+#13+#10+
              '主程序无法获取操作人员帐号，请联系管理员。'+#13+#10+#13+#10+
              '因此错误带来的不便敬请谅解。';
      Application.MessageBox(PChar(strEx), '错误信息', MB_ICONERROR);
  end; }
end.

