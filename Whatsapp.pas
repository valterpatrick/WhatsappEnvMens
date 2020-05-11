unit Whatsapp;

// BIBLIOTECA DE FUNÇÕES DESEVOLVIDA POR VALTER PATRICK SILVA FERREIRA - valterpatrick@hotmail.com

interface

uses System.StrUtils, System.SysUtils, System.NetEncoding, ShellApi;

type
  TWhatsapp = class
  private
    FProtocolo: String;
    FLinkAPI: String;
    FIdioma: String;
    FTelefoneComDDD: String;
    FCodigoPais: Integer;
    FMensagem: String;
    function MontarTelefone: String;
    function EncodeMensagem(Mens: String): String;
    function SomenteNumeros(Num: String): String;
    function GetProtocolo: String;
    function GetLinkAPI: String;
    function GetLinkCompleto: String;
    function GetIdioma: String;
    function GetTextoCodificado: String;
    function GetCodigoPais: Integer;
  public
    property Protocolo: String read GetProtocolo write FProtocolo;
    property LinkAPI: String read GetLinkAPI write FLinkAPI;
    property Idioma: String read GetIdioma write FIdioma;
    property TelefoneComDDD: String read FTelefoneComDDD write FTelefoneComDDD;
    property CodigoPais: Integer read GetCodigoPais write FCodigoPais;
    property Mensagem: String read FMensagem write FMensagem;
    property TextoCodificado: String read GetTextoCodificado;
    property LinkCompleto: String read GetLinkCompleto;

    procedure EnviarMensagem;
  end;

CONST
  ProtocoloPadrao = 'https';
  LinkAPIPadrao = 'api.whatsapp.com';
  IdiomaPadrao = 'pt_BR';
  CodigoPaisPadrao = 55;
  ParametroIdiomaPadrao = 'l';
  ParametroTelefonePadrao = 'phone';
  ParametroMensagemPadrao = 'text';

implementation

{ TWhatsapp }

function TWhatsapp.EncodeMensagem(Mens: String): String;
begin
  Result := IfThen(Mens = '', '', TNetEncoding.URL.Encode(Mens));
end;

function TWhatsapp.MontarTelefone: String;
begin
  Result := '';
  Result := SomenteNumeros(FTelefoneComDDD);
  if Length(Result) > 0 then
    Result := '+' + IntToStr(GetCodigoPais) + Result
  else
    Result := '';
end;

procedure TWhatsapp.EnviarMensagem;
begin
  if FMensagem.Trim = '' then
    raise Exception.Create('Não há mensagem para ser enviada.');

  ShellExecute(0, 'open', PWideChar(GetLinkCompleto), '', '', 1)
end;

function TWhatsapp.GetCodigoPais: Integer;
begin
  if FCodigoPais = 0 then
    Result := CodigoPaisPadrao
  else
    Result := FCodigoPais;
end;

function TWhatsapp.GetIdioma: String;
begin
  if FIdioma.Trim = '' then
    Result := IdiomaPadrao
  else
    Result := FIdioma.Trim;
end;

function TWhatsapp.GetLinkAPI: String;
begin
  if FLinkAPI.Trim = '' then
    Result := LinkAPIPadrao
  else
    Result := FLinkAPI.Trim.Replace('/', '').Replace('\', '');
end;

function TWhatsapp.GetLinkCompleto: String;
var
  ParTel, ParIdioma, ParMensagem: String;
begin
  ParTel := MontarTelefone;
  ParTel := Ifthen(ParTel = '', '', ParametroTelefonePadrao + '=' + ParTel);
  ParIdioma := ParametroIdiomaPadrao + '=' + GetIdioma;
  ParMensagem := ParametroMensagemPadrao + '=' + EncodeMensagem(FMensagem);
  Result := GetProtocolo + '://' + GetLinkAPI + '/send?' + ParIdioma + Ifthen(ParTel = '', '', '&' + ParTel) + Ifthen(ParMensagem = '', '', '&' + ParMensagem);
end;

function TWhatsapp.GetProtocolo: String;
begin
  if FProtocolo.Trim = '' then
    Result := ProtocoloPadrao
  else
    Result := FProtocolo.Trim.Replace(':', '').Replace('/', '').Replace('\', '');
end;

function TWhatsapp.GetTextoCodificado: String;
begin
  Result := EncodeMensagem(FMensagem);
end;

function TWhatsapp.SomenteNumeros(Num: String): String;
var
  I: Integer;
begin
  Result := '';
  if Length(Num.Trim) = 0 then
    Exit;
  for I := 0 to Length(Num) do
    if CharInSet(Num[I], ['0' .. '9']) then
      Result := Result + Num[I];
end;

end.
