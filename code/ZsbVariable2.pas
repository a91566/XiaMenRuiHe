{DLL 封装的窗体专用,不同于主程序}

unit ZsbVariable2;

interface

//说明：全部定义变量当全局变量使用
//规格： Z+类型+变量名称
//Str=string,Boo=boolean,Int=integer  SL=TStringList

uses
  Windows,Forms,DBClient,SysUtils,ShellAPI,Messages,rzpanel,rzedit,RzCmboBx,RzBtnEdt,
  Classes;


type //疫苗信息用于传入疫苗编码或条码 即可赋值其他信息
  TYMXX = record
    SlBm,SlTm, SlMc, SlGg, SlDw,SlLb, SlJx, SlJg, SlJk, SlGys, SlSccj: TStringList;
    StrBm,StrTm, StrMc, StrGg, StrDw,StrLb, StrJx, StrJg, StrJk, StrGys, StrSccj: string;
  end;


var         
   
  PCharPuOpercode: string;//登录帐号
  ZStrAppVer:string;//版本号
  ZSLYMXX:TYMXX;       //
  ZStrUser,ZStrUserDept:string;//样式：  001/小宝
  ZStrUserCode,ZStrStafCode,ZStrStafName,ZStrUserDeptCode,ZStrUserDeptName:string;//登录者的编码，姓名，科室编码，科室名称
  //ZStrDate,ZStrTime:string;//服务器时间
  ZBooF_ckdshOpenMode:Boolean; //  F_ckdsh 窗体开启模式  true 为审核 false 为完成出库 因为两个界面极其类似，所以不多创建窗体



implementation

end.
