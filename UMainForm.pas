unit UMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Keyboard, Vcl.ExtCtrls,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Imaging.pngimage, AdvSmoothTouchKeyBoard,
  AdvAppStyler, AdvSmoothButton, AdvPanel, AdvGroupBox, AdvEdit,
  PictureContainer, Vcl.Buttons, AdvLabel;

type
  TMainForm = class(TForm)
    GroupBox1: TAdvGroupBox;
    LabelTotal: TLabel;
    PanelBack: TAdvPanel;
    Panel2: TAdvPanel;
    qPayTypes: TFDQuery;
    Panel3: TAdvPanel;
    Label4: TLabel;
    btn_cancel: TAdvSmoothButton;
    AdvPanelStyler1: TAdvPanelStyler;
    AdvPanel1: TAdvPanel;
    pnl_calc: TAdvPanel;
    Label2: TAdvLabel;
    edt_result: TAdvEdit;
    KeyButton3: TAdvPanel;
    btn1: TSpeedButton;
    KeyButton2: TAdvPanel;
    btn2: TSpeedButton;
    KeyButton1: TAdvPanel;
    btn3: TSpeedButton;
    KeyButton12: TAdvPanel;
    btn4: TSpeedButton;
    KeyButton10: TAdvPanel;
    btn5: TSpeedButton;
    KeyButton6: TAdvPanel;
    btn6: TSpeedButton;
    KeyButton9: TAdvPanel;
    btn7: TSpeedButton;
    KeyButton4: TAdvPanel;
    btn8: TSpeedButton;
    KeyButton5: TAdvPanel;
    btn9: TSpeedButton;
    KeyButton8: TAdvPanel;
    btn10: TSpeedButton;
    KeyButton7: TAdvPanel;
    btn11: TSpeedButton;
    KeyButton11: TAdvPanel;
    btn12: TSpeedButton;
    KeyButton14: TAdvPanel;
    btn13: TSpeedButton;
    KeyButton13: TAdvPanel;
    btn14: TSpeedButton;
    btn_pay: TAdvSmoothButton;
    lbl1: TLabel;
    Panel1: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Panel16: TPanel;
    btn_up_scroll: TAdvSmoothButton;
    btn_down_scroll: TAdvSmoothButton;
    Label5: TLabel;
    LabelCash: TLabel;
    PanelRight: TPanel;
    Panel5: TPanel;
    Label3: TLabel;
    LabelFIO: TLabel;
    LabelScores2: TLabel;
    Label9: TLabel;
    LabelBallCanT: TLabel;
    LabelBallCan: TLabel;
    PictureContainer1: TPictureContainer;
    SpinEdit1: TAdvEdit;
    Label6: TLabel;
    LabelIncrement: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure edt_out_sumClick(Sender: TObject);
    procedure edt_in_sumClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btn11Click(Sender: TObject);
    procedure btn_payClick(Sender: TObject);
    procedure btn_up_scrollClick(Sender: TObject);
    procedure btn_down_scrollClick(Sender: TObject);
    procedure edt_resultKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure SpinEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure calc_click_2(key:Integer);
    procedure PostCode;
    procedure TestMax;
    procedure UpDownValue;
    procedure PanelShow(b: boolean);
    procedure MyExcept(Sender: TObject; E: Exception);
  public

  end;


var
  MainForm: TMainForm;
  MaxValue:Integer;
  Increment:Integer;
  NowValue:Integer;


implementation

 uses  UConst, UFunc,UFormPas;

{$R *.dfm}


procedure TMainForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TMainForm.btn_down_scrollClick(Sender: TObject);
begin
  if (NowValue-Increment)>=0 then NowValue:=NowValue-Increment else exit;
  SpinEdit1.Text:=IntToStr(NowValue);
  UpDownValue;
  LabelIncrement.Caption:=IntToStr((NowValue div Increment)*Increment);
end;

procedure TMainForm.btn_payClick(Sender: TObject);
begin
  NowValue:=StrToInt(SpinEdit1.Text);
  if (NowValue mod Increment)<>0 then NowValue:=(NowValue div Increment)*Increment;
  if NowValue<=MaxValue then SpinEdit1.Text:=IntToStr(NowValue) else
   begin
    NowValue:=MaxValue;
    SpinEdit1.Text:=IntToStr(NowValue);
    exit;
   end;
  UpDownValue;
 if MyJSONParser.PostPurchaseOperation then MyJSONParser.ErrorStatus:=sOK;
 Self.Close;
end;

procedure TMainForm.btn_up_scrollClick(Sender: TObject);
begin
  if (NowValue+Increment)<=MaxValue then NowValue:=NowValue+Increment else exit;
  SpinEdit1.Text:=IntToStr(NowValue);
  UpDownValue;
  LabelIncrement.Caption:=IntToStr((NowValue div Increment)*Increment);
end;

procedure TMainForm.calc_click_2(key: Integer);
  procedure add_key(k:string);
  begin
    if (ActiveControl is TAdvEdit) then
     begin
      (ActiveControl as TAdvEdit).Text:=(ActiveControl as TAdvEdit).Text+k;
      (ActiveControl as TAdvEdit).SelLength:=0;
      (ActiveControl as TAdvEdit).SelStart:=Length((ActiveControl as TAdvEdit).Text);
     end;
  end;
  procedure del_key;
  var
    k:string;
  begin
   if (ActiveControl is TAdvEdit) then
     begin
      k:=(ActiveControl as TAdvEdit).Text;
      Delete(k,Length(k),1);
     (ActiveControl as TAdvEdit).Text:=k;
     (ActiveControl as TAdvEdit).SelLength:=0;
     (ActiveControl as TAdvEdit).SelStart:=Length((ActiveControl as TAdvEdit).Text);
     end;
  end;
begin

  case key of
    1:add_key('1');
    2:add_key('2');
    3:add_key('3');
    4:add_key('4');
    5:add_key('5');
    6:add_key('6');
    7:add_key('7');
    8:add_key('8');
    9:add_key('9');
    0:add_key('0');
    13:begin
        if (ActiveControl is TAdvEdit)and((ActiveControl as TAdvEdit).Name=edt_result.Name) then PostCode;
        if (ActiveControl is TAdvEdit)and((ActiveControl as TAdvEdit).Name=SpinEdit1.Name) then TestMax;
        if (ActiveControl is TAdvEdit) then (ActiveControl as TAdvEdit).Text:='';
        //edt_result.Text:='';
       end;
   // 12:add_key('.');
    -1:del_key;
    -2:if (ActiveControl is TAdvEdit) then (ActiveControl as TAdvEdit).Text:='';
  end;
  {if edt_result.CanFocus then
    edt_result.SetFocus;  }
  if (ActiveControl is TAdvEdit)and((ActiveControl as TAdvEdit).Name=SpinEdit1.Name)and(SpinEdit1.Text<>'')and(SpinEdit1.Text<>'0') then TestMax;
end;

procedure TMainForm.edt_in_sumClick(Sender: TObject);
begin
  edt_result.SetFocus;
  edt_result.SelStart := Length(edt_result.text);
  edt_result.SelLength := 0;
end;

procedure TMainForm.edt_out_sumClick(Sender: TObject);
begin
  edt_result.SetFocus;
  edt_result.SelStart := Length(edt_result.text);
  edt_result.SelLength := 0;
end;

procedure TMainForm.edt_resultKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then btn14.OnClick(btn14);
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  edt_result.SetFocus;
  edt_result.SelStart := Length(edt_result.text);
  edt_result.SelLength := 0;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 Application.OnException := MyExcept;
end;

procedure TMainForm.FormResize(Sender: TObject);
 procedure ResizeBtn;
  const btnSpace=1; pnlHeight=390; pnlWidth=390;
  var btnWidth,btnHeight:word;
  begin
    pnl_calc.Width:=pnlWidth;
    pnl_calc.Height:=pnlHeight;
    btnWidth:=(pnl_calc.Width div 3)-2*btnSpace;
    btnHeight:=(pnl_calc.Height-Label2.Height-edt_result.Height-5*btnSpace) div 5;
    KeyButton1.Width:=btnWidth;
    KeyButton2.Width:=btnWidth;
    KeyButton3.Width:=btnWidth;
    KeyButton4.Width:=btnWidth;
    KeyButton5.Width:=btnWidth;
    KeyButton6.Width:=btnWidth;
    KeyButton7.Width:=btnWidth;
    KeyButton8.Width:=btnWidth;
    KeyButton9.Width:=btnWidth;
    KeyButton10.Width:=btnWidth;
    KeyButton11.Width:=btnWidth;
    KeyButton12.Width:=btnWidth;
    KeyButton13.Width:=2*btnWidth+btnSpace;
    KeyButton14.Width:=btnWidth;
    KeyButton1.Height:=btnHeight;
    KeyButton2.Height:=btnHeight;
    KeyButton3.Height:=btnHeight;
    KeyButton4.Height:=btnHeight;
    KeyButton5.Height:=btnHeight;
    KeyButton6.Height:=btnHeight;
    KeyButton7.Height:=btnHeight;
    KeyButton8.Height:=btnHeight;
    KeyButton9.Height:=btnHeight;
    KeyButton10.Height:=btnHeight;
    KeyButton11.Height:=btnHeight;
    KeyButton12.Height:=btnHeight;
    KeyButton13.Height:=btnHeight;
    KeyButton14.Height:=btnHeight;
    KeyButton1.Top:=Label2.Height+edt_result.Height+btnSpace;
    KeyButton2.Top:=KeyButton1.Top;
    KeyButton3.Top:=KeyButton1.Top;
    KeyButton4.Top:=KeyButton1.Top+btnHeight+btnSpace;
    KeyButton5.Top:=KeyButton4.Top;
    KeyButton6.Top:=KeyButton4.Top;
    KeyButton7.Top:=KeyButton6.Top+btnHeight+btnSpace;
    KeyButton8.Top:=KeyButton7.Top;
    KeyButton9.Top:=KeyButton7.Top;
    KeyButton10.Top:=KeyButton7.Top+btnHeight+btnSpace;
    KeyButton11.Top:=KeyButton10.Top;
    KeyButton12.Top:=KeyButton10.Top;
    KeyButton13.Top:=KeyButton10.Top+btnHeight+btnSpace;
    KeyButton14.Top:=KeyButton13.Top;
    KeyButton1.Left:=2*btnSpace;
    KeyButton2.Left:=KeyButton1.Left+btnSpace+KeyButton1.Width;
    KeyButton3.Left:=KeyButton2.Left+btnSpace+KeyButton2.Width;
    KeyButton4.Left:=KeyButton1.Left;
    KeyButton5.Left:=KeyButton2.Left;
    KeyButton6.Left:=KeyButton3.Left;
    KeyButton7.Left:=KeyButton1.Left;
    KeyButton8.Left:=KeyButton2.Left;
    KeyButton9.Left:=KeyButton3.Left;
    KeyButton10.Left:=KeyButton1.Left;
    KeyButton11.Left:=KeyButton2.Left;
    KeyButton12.Left:=KeyButton3.Left;
    KeyButton13.Left:=KeyButton11.Left;
    KeyButton14.Left:=KeyButton10.Left;
  end;


begin
 ResizeBtn;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  FormResize(Self);
  edt_result.SetFocus;
  LabelTotal.Caption:=MyJSONParser.TotalPurchase;
  if MyJSONParser.PostCompanyOperation then
    begin
     Screen.Cursor:=crDefault;
     LabelBallCanT.Caption:=sLabMain11;
     LabelBallCan.Caption:=MyJSONParser.MaxScoresDiscountCompany+'%';
   {  LabelComp.Caption:=MyJSONParser.NameCompany;
     LabelBase.Caption:=sLabMain7+MyJSONParser.DiscountBaseCompany;
     LabelLev1.Caption:=sLabMain8+MyJSONParser.DiscountLevel1Company;
     LabelLev2.Caption:=sLabMain9+MyJSONParser.DiscountLevel2Company;
     LabelLev3.Caption:=sLabMain10+MyJSONParser.DiscountLevel3Company;
     LabelBallCan.Caption:=sLabMain11+MyJSONParser.MaxScoresDiscountCompany; }
    end
     else
      begin
       Screen.Cursor:=crDefault;
       MyGreatFormModal(FormPas,TFormPas);
       MyJSONParser.ErrorStatus:=sError;
       MainForm.Close;
      end;
end;

procedure TMainForm.MyExcept(Sender: TObject; E: Exception);
begin
  if E is Exception then
   begin
    Screen.Cursor:=crDefault;
   // MessageDlg(TestLoginError, mtInformation, [mbOk], 0);
   end
  else
    raise E;
end;

procedure TMainForm.PanelShow(b: boolean);
begin
if b then
 begin
    GroupBox1.Visible:=True;
 end
  else
   begin
    GroupBox1.Visible:=False;
   end;
end;

procedure TMainForm.PostCode;
begin
 try
  if edt_result.Text='' then Exit;
  Screen.Cursor:=crHourGlass;
  KeyButton13.Enabled:=False;
  MySetCustomer('',edt_result.Text);
  MaxValue:=1;
  Increment:=1;
  NowValue:=0;
  SpinEdit1.Text:=IntToStr(NowValue);
  //MyJSONParser.SetNull;
  if MyJSONParser.PostCustomerOperation then
   begin
    LabelFIO.Caption:=MyJSONParser.SurnameCustomer+' '+MyJSONParser.NameCustomer;
    Label9.Caption:=sLabMain6;
    LabelScores2.Caption:=IntToStr(trunc(StrToFloat(MyJSONParser.ScoresCustomer)));

    PanelShow(True);
    if (SpinEdit1.Text>'0')or(SpinEdit1.Text<>'') then LabelScores2.Caption:=IntToStr(trunc(StrToFloat(MyJSONParser.ScoresCustomer)))+' - '+SpinEdit1.Text;
    if Not MyJSONParser.CashPurchaseCalc(SpinEdit1.Text) then exit;
    MaxValue:=StrToInt(MyJSONParser.DiscontMaxScores);//trunc(StrToFloat(MyJSONParser.ScoresCustomer));
    Increment:=StrToInt(MyJSONParser.StepScores);
    NowValue:=0; //ShowMessage(IntToStr(MaxValue)); // ShowMessage(IntToStr(MaxValue)+' ' +IntToStr(Increment)+' '+IntToStr(NowValue)+' ');
    SpinEdit1.Text:=IntToStr(NowValue);
    LabelCash.Caption:=MyJSONParser.CashPurchase;
    LabelIncrement.Caption:=IntToStr(Increment);
   // PanelShow(True);
   end
    else PanelShow(False);
 finally
  KeyButton13.Enabled:=True;
  Screen.Cursor:=crDefault;
 end;
end;

procedure TMainForm.SpinEdit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 TestMax;
end;

procedure TMainForm.TestMax;
begin
  NowValue:=StrToInt(SpinEdit1.Text);
  {if (NowValue > Increment)and((NowValue mod Increment)<>0) then }LabelIncrement.Caption:=IntToStr((NowValue div Increment)*Increment);

  if NowValue<=MaxValue then SpinEdit1.Text:=IntToStr(NowValue) else
   begin
    NowValue:=MaxValue;
    SpinEdit1.Text:=IntToStr(NowValue);
    exit;
   end;
  UpDownValue;
{
  if (StrToInt(SpinEdit1.Text))<=MaxValue then NowValue:=StrToInt(SpinEdit1.Text)
                                                   else SpinEdit1.Text:=IntToStr(MaxValue);
  UpDownValue;}
end;

procedure TMainForm.UpDownValue;
begin
  if Not MyJSONParser.CashPurchaseCalc(SpinEdit1.Text) then exit;
  LabelCash.Caption:=MyJSONParser.CashPurchase;
  LabelScores2.Caption:=IntToStr(trunc(StrToFloat(MyJSONParser.ScoresCustomer)));
  if (SpinEdit1.Text<>'0')or(SpinEdit1.Text<>'') then LabelScores2.Caption:=IntToStr(trunc(StrToFloat(MyJSONParser.ScoresCustomer)))+' - '+SpinEdit1.Text;
end;

procedure TMainForm.btn11Click(Sender: TObject);
begin
 calc_click_2((Sender as TSpeedButton).Tag);
end;

end.
