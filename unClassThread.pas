unit unClassThread;

interface

uses
    System.Classes, System.SysUtils, Vcl.Forms, Vcl.Dialogs;

type
    TThreadGenerica = class(TThread)
    private
        FProcedimentoExecutar : TProc;

        procedure FinalizarThread(Sender: TObject);
    protected
        procedure Execute; override;
    public
        constructor Create(CriarSuspensa: Boolean);

        procedure AtualizacaoSincrona(Processo : TProc);
        procedure AtualizacaoFila(Processo : TProc);
        procedure IniciarThread;

        property ProcedimentoExecutar : TProc read FProcedimentoExecutar write FProcedimentoExecutar;
    end;

implementation

{ TThreadGenerica }

uses
    unLoading;

constructor TThreadGenerica.Create(CriarSuspensa: Boolean);
begin
    inherited Create(CriarSuspensa);
    FreeOnTerminate := True;
    FProcedimentoExecutar := nil;

    OnTerminate := FinalizarThread;
end;

procedure TThreadGenerica.Execute;
begin
  inherited;
    if (Terminated) then
        Exit;

    try
        if (Assigned(FProcedimentoExecutar)) then
            FProcedimentoExecutar;
    except
        on E : Exception do
        begin
            Synchronize(procedure
            begin
                ShowMessage('Erro: ' + E.Message);
            end);
        end;
    end;
end;

procedure TThreadGenerica.FinalizarThread(Sender: TObject);
begin
    if (frmLoading <> nil) then
        frmLoading.Close;

    ShowMessage('Processo Terminado');
end;

procedure TThreadGenerica.IniciarThread;
begin
    Start;

    frmLoading := TfrmLoading.Create(Application);
    frmLoading.ShowModal;
end;

procedure TThreadGenerica.AtualizacaoSincrona(Processo : TProc);
begin
    if (Assigned(Processo)) then
    begin
        Synchronize(procedure
        begin
            Processo;
        end);
    end;
end;

procedure TThreadGenerica.AtualizacaoFila(Processo : TProc);
begin
    if (Assigned(Processo)) then
    begin
        Queue(procedure
        begin
            Processo;
        end);
    end;
end;

end.
