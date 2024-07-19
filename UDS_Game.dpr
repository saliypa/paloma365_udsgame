library UDS_Game;

uses
  SysUtils,
  Classes,
  Dialogs,
  Windows,
  Forms,
  ComObj,
  Variants,
  Vcl.Graphics,
  UFunc in 'UFunc.pas',
  UConst in 'UConst.pas',
  UMyTJSONParser in 'UMyTJSONParser.pas',
  UFormPas in 'UFormPas.pas' {FormPas: TAdvMetroForm},
  MyCrypt in 'MyCrypt.pas',
  UMainForm in 'UMainForm.pas' {MainForm};

{$R *.res}

function IntSetLoginData(AppHandle: THandle):boolean; StdCall;
begin
  Result:=False;
 try
  MyGreatFormModal(FormPas,TFormPas);
  Result:=True;
 except
 end;
end;

////////////////////
function IntMain(AppHandle: THandle;Total:string;Executor:string):TMyResultStrings; StdCall;
var
   tempTotal:real;
begin
  SetLength(Result, 2);
  If MyFirstRun then
   begin
    IntSetLoginData(AppHandle);
    Result[0]:='Error';
    Result[1]:=sFirstRun;
    exit;
   end;

  try
   tempTotal:=StrToFloat(Total);
   tempTotal:=round(tempTotal * 100)/100;
   tempTotal:=RoundUp(tempTotal);
  except
    Result[0]:='Error';
    Result[1]:=sNoMoney;
    exit;
  end;

  Result:=MyRunMain(AppHandle,FloatToStr(tempTotal),Executor);
end;
////////////////////

procedure MyPlugin0001(AppHandle: THandle); StdCall;
var
 s:String;
 i:word;
begin
// Result:=True;
 try
   s:=My_Dll_Path;
   for i:=Length(s) downto 1 do
       if Copy(s,i,1)<>'\' then Delete(s,i,1)
                           else break;
   MyName;
   Application.Handle := AppHandle;
 except
  //Result:=False;
 end;

 end;


exports
    MyPlugin0001 name 'MyPlugin',
    IntSetLoginData name 'UDS_Game_SetLoginData',
    IntMain name 'Loyalty_IntMain';

begin

end.







 