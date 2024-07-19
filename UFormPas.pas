unit UFormPas;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AdvMetroForm, Vcl.ExtCtrls, AdvPanel, AdvGlowButton, Vcl.StdCtrls,
  RTFLabel, AdvEdit,MyCrypt, AdvAppStyler, System.ImageList, Vcl.ImgList,
  AdvGDIPicture, GDIPPictureContainer, AdvSmoothButton, AdvSmoothPanel, CalcEdit;

type
  TFormPas = class(TAdvMetroForm)
    Panel1: TPanel;
    AdvGlowButton1: TAdvSmoothButton;
    AdvGlowButton3: TAdvSmoothButton;
    Edit4: TAdvEdit;
    lbl1: TLabel;
    Edit5: TEdit;
    procedure AdvMetroFormCreate(Sender: TObject);
    procedure AdvMetroFormClose(Sender: TObject; var Action: TCloseAction);
    procedure AdvMetroFormShow(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit3Enter(Sender: TObject);
    procedure Edit5Enter(Sender: TObject);
    procedure ButtonMySQLClick(Sender: TObject);
    procedure pnl_nextClick(Sender: TObject);
  private
    { Private declarations }
    procedure MyExcept(Sender: TObject; E: Exception);
  protected
    { Protected declarations }
  public
    { Public declarations }
  end;

var
  FormPas: TFormPas;

implementation

 uses  UConst, UFunc,UMyTJSONParser;

{$R *.dfm}


procedure TFormPas.AdvMetroFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 {  if MessageDlg(ReallyClose, mtConfirmation, [mbOK,mbCancel], 0) = mrCancel then
    begin
     Action:=caNone;
     exit;
    end;

   Application.Handle := 0;    }
end;

procedure TFormPas.AdvMetroFormCreate(Sender: TObject);
begin
   Application.OnException := MyExcept;
   FormPas.Width:=331;
   FormPas.Height:=193;
   FormPas.Top:=(Screen.Height div 2)-(FormPas.Height div 2);
   FormPas.Left:=(Screen.Width div 2)-(FormPas.Width div 2);

   FormPas.Caption:=sCompany+UFunc.MyName;
  // AdvGlowButton3.Caption:=TestLoginStart;
end;

procedure TFormPas.AdvMetroFormShow(Sender: TObject);
begin

 // AdvGlowButton3.Picture:=AdvGDIPPicture1.Picture;
//  VarURLAuthorize:=URLAuthorize;

 if Not (MyFirstRun) then
   begin
    Edit4.Text:=VarAPIKey;
    Edit5.Text:=VarURLMain;
   end;
end;

procedure TFormPas.ButtonMySQLClick(Sender: TObject);
begin
 if (Edit4.Text<>VarAPIKey)or(Edit5.Text<>VarURLMain) then
      MySaveLogin(Edit4.Text,Edit5.Text);
      Self.Close;
end;

procedure TFormPas.Edit1Enter(Sender: TObject);
begin
 // AdvGlowButton3.Caption:=TestLoginStart;
end;

procedure TFormPas.Edit3Enter(Sender: TObject);
begin
//  AdvGlowButton3.Caption:=TestLoginStart;
end;

procedure TFormPas.Edit5Enter(Sender: TObject);
begin
 // AdvGlowButton3.Caption:=TestLoginStart;
end;

procedure TFormPas.MyExcept(Sender: TObject; E: Exception);
begin
  if E is Exception then
   begin
    Screen.Cursor:=crDefault;
   // MessageDlg(TestLoginError, mtInformation, [mbOk], 0);
   end
  else
    raise E;
end;

procedure TFormPas.pnl_nextClick(Sender: TObject);
begin
 Screen.Cursor:=crHourGlass;
 if Not Assigned(MyJSONParser) then  MyJSONParser:= TMyJSONParser.Create;
 MyJSONParser.XApiKey:=Edit4.Text;
 MyJSONParser.MainURL:=Edit5.Text;
 if Not (MyJSONParser.PostCompanyOperation) then
     begin
  //    AdvGlowButton3.Picture:=AdvGDIPPicture3.Picture;
      AdvGlowButton3.Caption:=TestLoginError;
     end
                                             else
     begin
    //   AdvGlowButton3.Picture:=AdvGDIPPicture2.Picture;
       AdvGlowButton3.Caption:=TestLoginGood;
     end;
 Screen.Cursor:=crDefault;
end;

end.
