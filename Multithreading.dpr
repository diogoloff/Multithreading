program Multithreading;

uses
  Vcl.Forms,
  unMultithreading in 'unMultithreading.pas' {frmMultithreading},
  unLoading in 'unLoading.pas' {frmLoading},
  unClassThread in 'unClassThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMultithreading, frmMultithreading);
  Application.Run;
end.
