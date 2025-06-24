unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.SyncObjs,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FEvento : TEvent;
    FEventoSetado : Boolean;
  public
    { Public declarations }
    procedure SetarEvento(Evento: TEvent);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if (Assigned(FEvento)) then
    begin
        if (not FEventoSetado) then
        begin
            FEvento.SetEvent;
            Action := CaNone;
            Exit;
        end;
    end;

    Action := CaFree;
    Form2 := nil;
end;

procedure TForm2.SetarEvento(Evento: TEvent);
begin
    FEventoSetado := False;
    FEvento := Evento;

    TThread.CreateAnonymousThread(
    procedure
    begin
        while (Evento.WaitFor(300) <> wrSignaled) do;

        FEventoSetado := True;

        TThread.Synchronize(nil,
        procedure
        begin
            Form2.Close;
        end);
    end).Start;
end;

end.
