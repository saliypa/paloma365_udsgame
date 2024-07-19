unit UFunc;
{$WARNINGS OFF}
{$HINTS OFF}

interface

uses Forms,Windows,UConst,MyCrypt,Classes,StdCtrls,SysUtils,Controls,Dialogs,ComCtrls,
     Registry,UMyTJSONParser,{UCustomer,}UMainForm;

 function MyGreatFormModal(var Form; MyFormClass: TFormClass):boolean;
 function MyGetVersion(PluginName: string):string;
 function My_Dll_Path:string; stdcall;
 function MyParent:boolean; stdcall;
 function MyName:string;
 function MyFirstRun:boolean;
 function MySaveLogin(Z:string;U:string):boolean;
 function MySetCustomer(ORI:string;C:string):boolean;
 function RoundUp(X:Extended):Extended;
 function MyTestLogin(Login:string;Pas:string;URL:string):boolean;
 //***************************************************************************//
 function MyInit(AppHandle: THandle;XApiKey:string;URLAuthorize:string):boolean;
 //function MyRunCustomerParser(AppHandle: THandle):TMyResultStrings; StdCall;
 function MyRunCompanyParser(AppHandle: THandle):TMyResultStrings; StdCall;
 function MyRunPurchaseParser(AppHandle: THandle):TMyResultStrings; StdCall;
 function MyRunMain(AppHandle: THandle;Total:string;Executor:string):TMyResultStrings; StdCall;

//function showWebKassaErrors(JsonArray:TJSONArray;type_:String='show'):String;
var
  I: integer;
  Registry: TRegistry;
  Mutex : THandle;
  MyJSONParser:TMyJSONParser;

implementation




function MyGreatFormModal(var Form; MyFormClass: TFormClass):boolean;
begin
 try
  Result:=True;
  //if Not Assigned(TForm(Form)) then
                                   Application.CreateForm(MyFormClass, Form);
  TForm(Form).ShowModal;
  TForm(Form).Free;
 except
  Result:=False;
 end;
end;

function MyGetVersion(PluginName: string):string;
var
   PVer, DPchar: PChar;
   MyPoint: Pointer;
   PLen: Cardinal;
   version: ^TVersionInfo;
   DumD: DWORD;
   LWord, HWord: Word;
begin
  Result:='';
 try
  DPchar := PChar(PluginName);
  PVer := StrAlloc(getFileVersionInfoSize(DPchar, Plen));
  getFileVersionInfo(DPChar, 0, 255, PVer);
  VerQueryValue(Pver, '\', MyPoint, Plen);
  Version := myPoint;
  dumD  := Version.dwFileVersionMS;
  hword := dumD shr 16;
  lword := dumD and 255;
  Result  := IntToStr(Hword) + '.' + IntToStr(LWord);
  dumD  := Version.dwFileVersionLs;
  hword := dumD shr 16;
  lword := dumD and 255;
  Result := Result + '.' + IntToStr(Hword) + '.' + IntToStr(lWord);
 except
 end;
end;

function My_Dll_Path:string; stdcall;
var
  FileName: array[0..MAX_PATH] of char;
begin
try
  FillChar(FileName, sizeof(FileName), #0);
  GetModuleFileName(hInstance, FileName, sizeof(FileName));
  Result:=FileName;
except
 Result:='C:\';
end;
end;

function MyName:string;
begin
 Result:=sMyVersion+' ('+MyGetVersion(My_Dll_Path)+')';
end;

function MyParent:boolean; stdcall;
begin
 Result:=False;
 try
  Mutex := CreateMutex(nil, False, 'paloma_win.exe');
  if Mutex = 0 then Application.MessageBox('Ошибка!','Ошибка запуска', 48)
  else if GetLastError = ERROR_ALREADY_EXISTS then Result:=True;
 except
 end;
end;

function MyFirstRun:boolean;
var
 Reg: TRegistry;
begin
 Result:=False;
 Reg := TRegistry.Create;
 try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Not Reg.KeyExists(sRegPath) {Reg.OpenKeyReadOnly(sRegPath)} then
     begin
      Result:=True;
     end
     else
      begin
       Result:=False;
       Reg.OpenKey(sRegPath, true);
       VarAPIKey:=Reg.ReadString(sRegAPIKey);//xebi(Reg.ReadString(sRegAPIKey), FileKey);
       VarURLMain:=xebi(Reg.ReadString(sRegURL), FileKey);
      end;
  finally
    Reg.Free;
  end;

end;

function MySaveLogin(Z:string;U:string):boolean;
var
 Reg: TRegistry;
begin
 Reg := TRegistry.Create;
 try
  Reg.RootKey := HKEY_CURRENT_USER;

  Reg.OpenKey(sRegPath, true);
  Reg.WriteString(sRegAPIKey,Z{xebi(Z, FileKey)});

  Reg.OpenKey(sRegPath, true);
  Reg.WriteString(sRegURL,xebi(U, FileKey));
 finally
  Reg.Free;
  MessageDlg(sSaveOK, mtInformation, [mbOK], 0);
 end;
end;

function MyTestLogin(Login:string;Pas:string;URL:string):boolean;
var
 MyJSONParserTemp:TMyJSONParser;
begin
 Result:=False;
 MyJSONParserTemp:= TMyJSONParser.Create;
 try
   MyJSONParserTemp.MainURL:=URL;
  // if MyJSONParserTemp.PostLogin then Result:=True;
 finally
   MyJSONParserTemp.Free;
 end;
end;

function MySetCustomer(ORI:string;C:string):boolean;
begin
 try
  Result:=True;
  MyJSONParser.IDCustomer:=ORI;
  MyJSONParser.PromoKod:=C;
  MyJSONParser.CustomerIdPurchase:=ORI;
  MyJSONParser.CodePurchase:=C;
 except
  Result:=False;
 end;
end;

function RoundUp(X:Extended):Extended;
begin
 if Frac(X)<>0 then Result:=Int(X)+1 else Result:=Int(X);
end;

//***************************************************************************//
function MyInit(AppHandle: THandle;XApiKey:string;URLAuthorize:string):boolean;
var
 s:String;
 i:word;
begin

 try
   Result:=False;
   s:=My_Dll_Path;
   for i:=Length(s) downto 1 do
       if Copy(s,i,1)<>'\' then Delete(s,i,1)
                           else break;
   MyName;
   Application.Handle := AppHandle;

   if Not Assigned(MyJSONParser) then  MyJSONParser:= TMyJSONParser.Create;
   MyJSONParser.SetNull;


   MyJSONParser.XApiKey:=XApiKey;
   MyJSONParser.MainURL:=URLAuthorize;
   MyJSONParser.ErrorStatus:='';
  // if Not(MyJSONParser.PostLogin) then exit;
   Result:=True;
  except
  end;
end;
///////////////////
{function MyRunCustomerParser(AppHandle: THandle):TMyResultStrings; StdCall;
begin
 try
  MyInit(AppHandle,VarAPIKey,VarURLMain);
 // MyGreatFormModal(CustomerForm,TCustomerForm);

  MyJSONParser.PostCustomerOperation;

 except
 end;
end; }

function MyRunCompanyParser(AppHandle: THandle):TMyResultStrings; StdCall;
begin
 try
  MyInit(AppHandle,VarAPIKey,VarURLMain);
//  MyGreatFormModal(CustomerForm,TCustomerForm);

  MyJSONParser.PostCompanyOperation;

 except
 end;
end;

function MyRunPurchaseParser(AppHandle: THandle):TMyResultStrings; StdCall;
begin
 try
  MyInit(AppHandle,VarAPIKey,VarURLMain);
//  MyGreatFormModal(CustomerForm,TCustomerForm);

  MyJSONParser.PostPurchaseOperation;

 except
 end;
end;

function MyRunMain(AppHandle: THandle;Total:string;Executor:string):TMyResultStrings; StdCall;
{var
  tempPercent:real; }
begin
 try
  SetLength(Result, 2);
  MyInit(AppHandle,VarAPIKey,VarURLMain);
  MyJSONParser.TotalPurchase:=Total;
  MyJSONParser.CashierExternalIdPurchase:=Executor;
  MyGreatFormModal(MainForm,TMainForm);

  if (MyJSONParser.ErrorStatus<>sOK)or(MyJSONParser.ErrorStatus='') then
   begin
    Result[0]:=sError;
    Result[1]:=MyJSONParser.ErrorStatus;
   end
    else
     begin
      Result[0]:=sOK;
     { tempPercent:=0;
      tempPercent:=(StrToFloat(MyJSONParser.CashPurchase)*100)/StrToFloat(Total);
      tempPercent:=round(100-tempPercent);
      Result[1]:=FloatToStr(tempPercent); } //Вернет процент скидки
      Result[1]:=MyJSONParser.CashPurchase; //Вернет номинал к оплате
     end;

 except
 end;
end;

//***************************************************************************//

initialization
  if Not(MyParent) then
  begin
   Application.MessageBox('Не обнаружена Paloma365!','Ошибка запуска', 48);
   Application.Terminate;
  end;
finalization
  if Mutex <> 0 then CloseHandle(Mutex);
end.

