{DLL ��װ�Ĵ���ר��,��ͬ��������}

unit ZsbVariable2;

interface

//˵����ȫ�����������ȫ�ֱ���ʹ��
//��� Z+����+��������
//Str=string,Boo=boolean,Int=integer  SL=TStringList

uses
  Windows,Forms,DBClient,SysUtils,ShellAPI,Messages,rzpanel,rzedit,RzCmboBx,RzBtnEdt,
  Classes;


type //������Ϣ���ڴ��������������� ���ɸ�ֵ������Ϣ
  TYMXX = record
    SlBm,SlTm, SlMc, SlGg, SlDw,SlLb, SlJx, SlJg, SlJk, SlGys, SlSccj: TStringList;
    StrBm,StrTm, StrMc, StrGg, StrDw,StrLb, StrJx, StrJg, StrJk, StrGys, StrSccj: string;
  end;


var         
   
  PCharPuOpercode: string;//��¼�ʺ�
  ZStrAppVer:string;//�汾��
  ZSLYMXX:TYMXX;       //
  ZStrUser,ZStrUserDept:string;//��ʽ��  001/С��
  ZStrUserCode,ZStrStafCode,ZStrStafName,ZStrUserDeptCode,ZStrUserDeptName:string;//��¼�ߵı��룬���������ұ��룬��������
  //ZStrDate,ZStrTime:string;//������ʱ��
  ZBooF_ckdshOpenMode:Boolean; //  F_ckdsh ���忪��ģʽ  true Ϊ��� false Ϊ��ɳ��� ��Ϊ�������漫�����ƣ����Բ��ഴ������



implementation

end.