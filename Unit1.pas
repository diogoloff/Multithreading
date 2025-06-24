unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.SyncObjs, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.Samples.Gauges;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Gauge1: TGauge;
    DBGrid1: TDBGrid;
    CdDados: TClientDataSet;
    DsDados: TDataSource;
    CdDadosCODIGO: TIntegerField;
    CdDadosNOME: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FRodando : Boolean;
    FEvento : TEvent;
  
    procedure LimparClient;
    procedure PopularClient(liCodigo: Integer; lsNome: String);
    function EstaRodandoThread: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit2;

procedure TForm1.Button2Click(Sender: TObject); 
begin
    if (EstaRodandoThread) then
        Exit;

    FEvento := TEvent.Create(nil, True, False, '');

    LimparClient;
    Gauge1.Progress := 0;

    CdDados.DisableControls;
    try
        TThread.CreateAnonymousThread(
        procedure
        var
            liConta : Integer;
        begin
            liConta := 0;

            while (liConta < 100) do
            begin
                inc(liConta);
                PopularClient(liConta, 'Pessoa ' + IntToStr(liConta));

                TThread.Synchronize(nil,
                procedure
                begin
                    Gauge1.Progress := Gauge1.Progress + 1;
                end);

                Sleep(300);

                if (not FRodando) then
                    Exit;
            end;

            FEvento.SetEvent;            
        end).Start;

        FRodando := True;

        {Form2 := TForm2.Create(Application);
        Form2.SetarEvento(FEvento);
        Form2.ShowModal;  } 
    finally
        {Gauge1.Progress := 0;
        CdDados.First;
        CdDados.EnableControls;
        FRodando := False;
        FEvento.Free; } 
           
        TThread.CreateAnonymousThread(
        procedure
        begin
            while FEvento.WaitFor(1000) <> wrSignaled do;
            
            TThread.Synchronize(nil,
            procedure
            begin
                Gauge1.Progress := 0;
                CdDados.First;
                CdDados.EnableControls;
            end);

            FRodando := False;
            FEvento.Free;
        end).Start;  
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
    lTh1 : TThread;
    lTh2 : TThread;

    liConta : Integer;

    SessaoCritica : TCriticalSection;
begin
    if (EstaRodandoThread) then
        Exit;

    FEvento := TEvent.Create(nil, True, False, '');
    SessaoCritica := TCriticalSection.Create;

    LimparClient;
    Gauge1.Progress := 0;
    liConta := 0;

    lTh1 := TThread.CreateAnonymousThread(
    procedure
    begin
        while (liConta < 100) do
        begin
            SessaoCritica.Enter;
            try
                inc(liConta);
                PopularClient(liConta, 'Pessoa TH1 ' + IntToStr(liConta));
            finally
                SessaoCritica.Leave;
            end;
            
            Sleep(300);

            if (not FRodando) then
                Exit;
        end;          
    end);

    lTh2 := TThread.CreateAnonymousThread(
    procedure
    begin
        while (liConta < 100) do
        begin
            SessaoCritica.Enter;
            try
                inc(liConta);
                PopularClient(liConta, 'Pessoa TH2 ' + IntToStr(liConta));
            finally
                SessaoCritica.Leave;
            end;
            
            Sleep(299);

            if (not FRodando) then
                Exit;
        end;          
    end);

    CdDados.DisableControls;
    try
        TThread.CreateAnonymousThread(
        procedure
        begin
            lTh1.Start;
            lTh2.Start;

            while (FRodando) do
            begin
                TThread.Synchronize(nil,
                procedure
                begin
                    Gauge1.Progress := liConta;
                end);

                Sleep(1000);

                if (liConta = 100) then
                    FEvento.SetEvent;
            end;

        end).Start;

        FRodando := True;

        {Form2 := TForm2.Create(Application);
        Form2.SetarEvento(FEvento);
        Form2.ShowModal;  } 
    finally
        {Gauge1.Progress := 0;
        CdDados.First;
        CdDados.EnableControls;
        FRodando := False;
        FEvento.Free; } 
           
        TThread.CreateAnonymousThread(
        procedure
        begin
            while FEvento.WaitFor(1000) <> wrSignaled do;
            
            TThread.Synchronize(nil,
            procedure
            begin
                Gauge1.Progress := 0;
                CdDados.First;
                CdDados.EnableControls;
            end);

            FRodando := False;
            FEvento.Free;
        end).Start;  
    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
    if (not FRodando) then
    begin
        ShowMessage('Não esta rodando para cancelar');
        Exit;
    end;

    FEvento.SetEvent;
end;

procedure TForm1.LimparClient;
begin
    CdDados.EmptyDataSet;
end;

procedure TForm1.PopularClient(liCodigo: Integer; lsNome: String);
begin
    CdDados.Append;
    CdDadosCODIGO.AsInteger := liCodigo;
    CdDadosNOME.AsString := lsNome;
    CdDados.Post;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
    liConta: Integer;
begin
    if (EstaRodandoThread) then
        Exit;

    LimparClient;
    liConta := 0;
    Gauge1.Progress := 0;

    CdDados.DisableControls;
    try
        while (liConta < 100) do
        begin
            inc(liConta);
            PopularClient(liConta, 'Pessoa ' + IntToStr(liConta));
            Gauge1.Progress := Gauge1.Progress + 1;
            Sleep(300);
        end;
    finally
        Gauge1.Progress := 0;
        CdDados.First;
        CdDados.EnableControls;
    end;
end;

function TForm1.EstaRodandoThread: Boolean;
begin
    if (FRodando) then
        ShowMessage('Esta Rodando Aguarde');

    Result := FRodando;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    FRodando := False;
end;

end.
