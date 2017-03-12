unit UOF_shengchangtuikudanxiugai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_ObjectForm, ExtCtrls, Buttons, Grids, DBGridEh, RzTabs,
  ComCtrls, StdCtrls;

type
  TFOF_shengchangtuikudanxiugai = class(TF_ObjectForm)
    LabeledEdit2: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    Label2: TLabel;
    Label1: TLabel;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker1: TDateTimePicker;
    RzPageControl1: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    RzPageControl2: TRzPageControl;
    RzTabSheet2: TRzTabSheet;
    DBGridEh2: TDBGridEh;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FOF_shengchangtuikudanxiugai: TFOF_shengchangtuikudanxiugai;

implementation

{$R *.dfm}

end.
