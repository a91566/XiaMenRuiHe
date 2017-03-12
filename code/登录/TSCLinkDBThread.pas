unit TSCLinkDBThread;

interface

type
  TSCLinkDBThread = class(TThread)
  protected
    procedure Execute; override;
  end;

implementation

end.
 