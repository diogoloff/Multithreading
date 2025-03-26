unit unMultithreading;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Gauges;

type
  TfrmMultithreading = class(TForm)
    Timer1: TTimer;
    lbHora: TLabel;
    Button1: TButton;
    Gauge1: TGauge;
    Button2: TButton;
    Button3: TButton;
    ckQueue: TCheckBox;
    Button4: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    procedure SimulaProcesso;
    procedure IncrementaProgresso;
    function SimulaFimProcesso: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMultithreading: TfrmMultithreading;

implementation

{$R *.dfm}

uses unLoading, unClassThread;

procedure TfrmMultithreading.IncrementaProgresso;
begin
    Gauge1.AddProgress(1);
end;

procedure TfrmMultithreading.SimulaProcesso;
begin
    Sleep(100);
end;

function TfrmMultithreading.SimulaFimProcesso : Boolean;
begin
    Result := Gauge1.Progress = 100;
end;

procedure TfrmMultithreading.Button1Click(Sender: TObject);
begin
    Gauge1.Progress := 0;

    try
        while (True) do
        begin
            SimulaProcesso;
            IncrementaProgresso;
            //Application.ProcessMessages;

            if (SimulaFimProcesso) then
                Break;
        end;
    finally
        Cursor := crDefault;
    end;

    ShowMessage('Processo Terminado');
end;

procedure TfrmMultithreading.Button2Click(Sender: TObject);
begin
    Gauge1.Progress := 0;
    Cursor := crHourGlass;

    TThread.CreateAnonymousThread(
    procedure
    begin
        try
            while (True) do
            begin
                SimulaProcesso;

                TThread.Synchronize(nil,
                procedure
                begin
                    IncrementaProgresso;
                end);

                if (SimulaFimProcesso) then
                    Break;
            end;
        finally
            Cursor := crDefault;

            TThread.Synchronize(nil,
            procedure
            begin
                ShowMessage('Processo Terminado');
            end);
        end;
    end).Start;
end;

procedure TfrmMultithreading.Button3Click(Sender: TObject);
var
    JanelasCongeladas : Pointer;
begin
    Gauge1.Progress := 0;
    Cursor := crHourGlass;

    TThread.CreateAnonymousThread(
    procedure
    begin
        try
            while (True) do
            begin
                SimulaProcesso;

                TThread.Synchronize(nil,
                procedure
                begin
                    IncrementaProgresso;
                end);

                if (ckQueue.Checked) then
                begin
                    TThread.Queue(nil,
                    procedure
                    begin
                        ShowMessage('Simulando fila... Progresso ' + IntToStr(Gauge1.Progress));
                    end);
                end;

                if (SimulaFimProcesso) then
                    Break;
            end;
        finally
            Cursor := crDefault;

            if (JanelasCongeladas <> nil) then
            begin
                EnableTaskWindows(JanelasCongeladas);
                JanelasCongeladas := nil;
            end;

            if (frmLoading <> nil) then
                frmLoading.Close;

            TThread.Synchronize(nil,
            procedure
            begin
                ShowMessage('Processo 1 Terminado');
            end);
        end;
    end).Start;

    frmLoading := TfrmLoading.Create(Application);
    frmLoading.ShowModal;

    //frmLoading.Show;
    //JanelasCongeladas := DisableTaskWindows(frmLoading.Handle);

    // Aqui poderia ter outra thread rodando
    ShowMessage('Iniciando outra thread');
end;

procedure TfrmMultithreading.Button4Click(Sender: TObject);
var
    minhaThread : TThreadGenerica;
begin
    Gauge1.Progress := 0;

    minhaThread := TThreadGenerica.Create(True);
    minhaThread.ProcedimentoExecutar := procedure
    begin
        while (True) do
        begin
            SimulaProcesso;

            minhaThread.AtualizacaoSincrona(
            procedure
            begin
                IncrementaProgresso;
            end);

            if (ckQueue.Checked) then
            begin
                minhaThread.AtualizacaoFila(
                procedure
                begin
                    ShowMessage('Simulando fila... Progresso ' + IntToStr(Gauge1.Progress));
                end);
            end;

            if (SimulaFimProcesso) then
                Break;
        end;
    end;

    minhaThread.IniciarThread;
end;

procedure TfrmMultithreading.Timer1Timer(Sender: TObject);
begin
    lbHora.Caption := 'Hora: ' + TimeToStr(Time);
end;

end.
