unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Web.HTTPApp, System.NetEncoding, Whatsapp;

type
  TFrmPrincipal = class(TForm)
    Label1: TLabel;
    EdtNumero: TEdit;
    Label2: TLabel;
    MemMensagem: TMemo;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private

  public

  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}


procedure TFrmPrincipal.BitBtn1Click(Sender: TObject);
var
  Whats : TWhatsapp;
begin
  Whats := TWhatsapp.Create;
  try
    Whats.TelefoneComDDD := EdtNumero.Text;
    Whats.Mensagem := MemMensagem.Text;
    Whats.EnviarMensagem;
  finally
    Whats.Free;
  end;
end;

end.
