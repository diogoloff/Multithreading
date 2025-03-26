unit unLoading;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmLoading = class(TForm)
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLoading: TfrmLoading;

implementation

{$R *.dfm}

procedure TfrmLoading.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := CaFree;
    frmLoading := nil;
end;

end.
