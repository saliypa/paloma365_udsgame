unit UMyTJSONParser;
{$WARNINGS OFF}
{$HINTS OFF}

interface

uses
  System.Classes,Data.DBXJSON,System.JSON,System.SysUtils,System.DateUtils,
  Vcl.Dialogs,
  IdHTTP,  IdCookieManager,  IdSSLOpenSSL,  IdHeaderList, IdGlobalProtocols;


type
  TShemaCompany = class
  private
    {$J+}
    const Accept: string = 'Accept';
    const Appjs: string = 'application/json';
    const XOrReqId: string = 'X-Origin-Request-Id';
    const XTimeStamp: string = 'X-Timestamp';
    const XApiKey: string = 'X-Api-Key';

    const baseDiscountPolicy: string = 'baseDiscountPolicy';
    const id: string = 'id';
    const marketingSettings: string = 'marketingSettings';
    const discountBase: string = 'discountBase';
    const discountLevel1: string = 'discountLevel1';
    const discountLevel2: string = 'discountLevel2';
    const discountLevel3: string = 'discountLevel3';
    const maxScoresDiscount: string = 'maxScoresDiscount';
    const name: string = 'name';
    const promoCode: string = 'promoCode';
    {$J-}
  end;


type
  TShemaCustomer = class
  private
    {$J+}
    const Code: string = 'code=';
    const CustomerId: string = 'customerId=';
    const Ampersand: string = '&';
    const Question: string = '?';
    const Accept: string = 'Accept';
    const Appjs: string = 'application/json';
    const XOrReqId: string = 'X-Origin-Request-Id';
    const XTimeStamp: string = 'X-Timestamp';
    const XApiKey: string = 'X-Api-Key';

    const phone: string = 'phone';
    const level: string = 'level';
    const scores: string = 'scores';
    const dateCreated: string = 'dateCreated';
    const id: string = 'id';
    const skype: string = 'skype';
    const name: string = 'name';
    const gender: string = 'gender';
    const instagram: string = 'instagram';
    const birthDate: string = 'birthDate';
    const surname: string = 'surname';
    const participant: string = 'participant';
    const discountRate: string = 'discountRate';
    {$J-}
  end;

type
  TShemaPurchase = class
  private
    {$J+}
    const Accept: string = 'Accept';
    const Appjs: string = 'application/json';
    const XOrReqId: string = 'X-Origin-Request-Id';
    const XTimeStamp: string = 'X-Timestamp';
    const XApiKey: string = 'X-Api-Key';
    const ContType: string = 'Content-Type';

    const scores: string = 'scores';
    const total: string = 'total';
    const cash: string = 'cash';
    const code: string = 'code';
    const invoiceNumber: string = 'invoiceNumber';
    const customerId: string = 'customerId';
    const cashierExternalId: string = 'cashierExternalId';
    const operation: string = 'operation';
    const cashier: string = 'cashier';
    const email: string = 'email';
    const externalId: string = 'externalId';
    const name: string = 'name';
    const customer: string = 'customer';
    const id: string = 'id';
    const surname: string = 'surname';
    const dateCreated: string = 'dateCreated';
    const marketingSettings: string = 'marketingSettings';
    const discountBase: string = 'discountBase';
    const discountLevel1: string = 'discountLevel1';
    const discountLevel2: string = 'discountLevel2';
    const discountLevel3: string = 'discountLevel3';
    const maxScoresDiscount: string = 'maxScoresDiscount';
    const scoresDelta: string = 'scoresDelta';
    const scoresNew: string = 'scoresNew';
    {$J-}
  end;

    {$J+}
  //  const URLConst:     string = 'https://udsgame.com/v1/partner';
    const URLCustomer: string = '/customer';
    const URLCompany:  string = '/company';
    const URLPurchase: string = '/purchase';
    const APPLY_DISCOUNT: string = 'APPLY_DISCOUNT';
    const CHARGE_SCORES: string = 'CHARGE_SCORES';
    {$J-}


var
    ShemaCompany:TShemaCompany;
    ShemaCustomer:TShemaCustomer;
    ShemaPurchase:TShemaPurchase;

resourcestring

    sURLTest='https://uds.app';//'https://udsgame.com';
    E1   = 'Ошибка обнуления данных';
    E2   = 'Ошибка при попытке получить токен пользователя';
    E404 = 'Клиент связанный с указанным ID или промо-кодом не найден';
    E4   = 'Ошибка! Не указан промо код';
    E400 = 'Ошибка проверки бизнес логики';
    E6   = 'Errors';
    E403 = 'Доступ запрещен, маркер данной аутентификации не установлен или не имеет достаточных разрешений';
    E7   = 'Нет доступа к ';

type
  TMyJSONParser = class(TPersistent)
  private
   fURL:string;
   fXApiKey:string;
   fMainURL:string;
   //
   fCustomerObject:TStringList;
   fPromoKod:string;
   fIDCustomer:string;
   fPhoneCustomer:string;
   fLevelCustomer:string;
   fScoresCustomer:string;
   fDateCreatedCustomer:string;
   fIdCustomerResp:string;
   fSkypeCustomer:string;
   fNameCustomer:string;
   fGenderCustomer:string;
   fInstagramCustomer:string;
   fBirthDateCustomer:string;
   fSurnameCustomer:string;
   fParticipantCustomer:string;
   fDiscountRateCustomer:string;
   //
   fCompanyObject:TStringList;
   fBaseDiscountPolicyCompany:string;
   fIDCompany:string;
   fDiscountBaseCompany:string;
   fDiscountLevel1Company:string;
   fDiscountLevel2Company:string;
   fDiscountLevel3Company:string;
   fMaxScoresDiscountCompany:string;
   fNameCompany:string;
   fPromoCodeCompany:string;
   //
   fPurchaseObject:TStringList;
   fScoresPurchase:string;
   fTotalPurchase:string;
   fDiscontMaxScores:string;
   fCashPurchase:string;
   fCodePurchase:string;
   fInvoiceNumberPurchase:string;
   fCustomerIdPurchase:string;
   fCashierExternalIdPurchase:string;
   fStepScores:string;

   fCashPurchaseResp:string;
   fEmailCashierPurchaseResp:string;
   fExternalIdCashierPurchaseResp:string;
   fNameCashierPurchaseResp:string;
   fIdCustomerPurchaseResp:string;
   fNamePurchaseResp:string;
   fSurnamePurchaseResp:string;
   fDateCreatedPurchaseResp:string;
   fIdPurchaseResp:string;
   fDiscountBasePurchaseResp:string;
   fDiscountLevel1PurchaseResp:string;
   fDiscountLevel2PurchaseResp:string;
   fDiscountLevel3PurchaseResp:string;
   fMaxScoresDiscountPurchaseResp:string;
   fScoresDeltaPurchaseResp:string;
   fScoresNewPurchaseResp:string;
   fTotalPurchaseResp:string;
   //
   fHTTPClient: TidHTTP;
   fSSLIOHandler: TIdSSLIOHandlerSocketOpenSSL;
   fIdCookieManager: TIdCookieManager;
   //
   fErrorStatus:string;
   ///
   procedure SetURL(const Value: string);
   procedure SetMainURL(const Value: string);
   procedure SetXApiKey(const Value: string);
   //
   function  GetCustomerObject: TStringList;
   procedure SetPromoKod(const Value: string);
   procedure SetIDCustomer(const Value: string);
   procedure SetPhoneCustomer(const Value: string);
   procedure SetLevelCustomer(const Value: string);
   procedure SetScoresCustomer(const Value: string);
   procedure SetDateCreatedCustomer(const Value: string);
   procedure SetIdCustomerResp(const Value: string);
   procedure SetSkypeCustomer(const Value: string);
   procedure SetNameCustomer(const Value: string);
   procedure SetGenderCustomer(const Value: string);
   procedure SetInstagramCustomer(const Value: string);
   procedure SetBirthDateCustomer(const Value: string);
   procedure SetSurnameCustomer(const Value: string);
   procedure SetParticipantCustomer(const Value: string);
   procedure SetDiscountRateCustomer(const Value: string);
   //
   function  GetCompanyObject: TStringList;
   procedure SetBaseDiscountPolicyCompany(const Value: string);
   procedure SetIDCompany(const Value: string);
   procedure SetDiscountBaseCompany(const Value: string);
   procedure SetDiscountLevel1Company(const Value: string);
   procedure SetDiscountLevel2Company(const Value: string);
   procedure SetDiscountLevel3Company(const Value: string);
   procedure SetMaxScoresDiscountCompany(const Value: string);
   procedure SetNameCompany(const Value: string);
   procedure SetPromoCodeCompany(const Value: string);
   //
   function  GetPurchaseObject: TStringList;
   procedure SetScoresPurchase(const Value: string);
   procedure SetTotalPurchase(const Value: string);
   procedure SetDiscontMaxScores(const Value: string);
   procedure SetCashPurchase(const Value: string);
   procedure SetCodePurchase(const Value: string);
   procedure SetInvoiceNumberPurchase(const Value: string);
   procedure SetCustomerIdPurchase(const Value: string);
   procedure SetCashierExternalIdPurchase(const Value: string);
   procedure SetStepScores(const Value: string);


   procedure SetCashPurchaseResp(const Value: string);
   procedure SetEmailCashierPurchaseResp(const Value: string);
   procedure SetExternalIdCashierPurchaseResp(const Value: string);
   procedure SetNameCashierPurchaseResp(const Value: string);
   procedure SetIdCustomerPurchaseResp(const Value: string);
   procedure SetNamePurchaseResp(const Value: string);
   procedure SetSurnamePurchaseResp(const Value: string);
   procedure SetDateCreatedPurchaseResp(const Value: string);
   procedure SetIdPurchaseResp(const Value: string);
   procedure SetDiscountBasePurchaseResp(const Value: string);
   procedure SetDiscountLevel1PurchaseResp(const Value: string);
   procedure SetDiscountLevel2PurchaseResp(const Value: string);
   procedure SetDiscountLevel3PurchaseResp(const Value: string);
   procedure SetMaxScoresDiscountPurchaseResp(const Value: string);
   procedure SetScoresDeltaPurchaseResp(const Value: string);
   procedure SetScoresNewPurchaseResp(const Value: string);
   procedure SetTotalPurchaseResp(const Value: string);
   //
   function  GetUUID: string;
   procedure SetUUID(const Value: string);
   function  GetDateInISO8601: string;
   procedure SetDateInISO8601(const Value: string);
   //
   procedure SetHTTPClient;
   procedure SetClearHTTPClient;
   procedure SetErrorStatus(const Value: string);
   ////

   ///
  public
   constructor Create;
   destructor Destroy; override;

   property URL: string read fURL write SetURL;
   property MainURL: string read fMainURL write SetMainURL;
   property XApiKey: string read fXApiKey write SetXApiKey;
   //
   property CustomerObject: TStringList read GetCustomerObject;
   property PromoKod: string read fPromoKod write SetPromoKod;
   property IDCustomer: string read fIDCustomer write SetIDCustomer;
   property PhoneCustomer: string read fPhoneCustomer write SetPhoneCustomer;
   property LevelCustomer: string read fLevelCustomer write SetLevelCustomer;
   property ScoresCustomer: string read fScoresCustomer write SetScoresCustomer;
   property DateCreatedCustomer: string read fDateCreatedCustomer write SetDateCreatedCustomer;
   property IdCustomerResp: string read fIdCustomerResp write SetIdCustomerResp;
   property SkypeCustomer: string read fSkypeCustomer write SetSkypeCustomer;
   property NameCustomer: string read fNameCustomer write SetNameCustomer;
   property GenderCustomer: string read fGenderCustomer write SetGenderCustomer;
   property InstagramCustomer: string read fInstagramCustomer write SetInstagramCustomer;
   property BirthDateCustomer: string read fBirthDateCustomer write SetBirthDateCustomer;
   property SurnameCustomer: string read fSurnameCustomer write SetSurnameCustomer;
   property ParticipantCustomer: string read fParticipantCustomer write SetParticipantCustomer;
   property DiscountRateCustomer: string read fDiscountRateCustomer write SetDiscountRateCustomer;

   //
   property CompanyObject: TStringList read GetCompanyObject;
   property BaseDiscountPolicyCompany: string read fBaseDiscountPolicyCompany write SetBaseDiscountPolicyCompany;
   property IDCompany: string read fIDCompany write SetIDCompany;
   property DiscountBaseCompany: string read fDiscountBaseCompany write SetDiscountBaseCompany;
   property DiscountLevel1Company: string read fDiscountLevel1Company write SetDiscountLevel1Company;
   property DiscountLevel2Company: string read fDiscountLevel2Company write SetDiscountLevel2Company;
   property DiscountLevel3Company: string read fDiscountLevel3Company write SetDiscountLevel3Company;
   property MaxScoresDiscountCompany: string read fMaxScoresDiscountCompany write SetMaxScoresDiscountCompany;
   property NameCompany: string read fNameCompany write SetNameCompany;
   property PromoCodeCompany: string read fPromoCodeCompany write SetPromoCodeCompany;
   //
   property PurchaseObject: TStringList read GetPurchaseObject;
   property ScoresPurchase: string read fScoresPurchase write SetScoresPurchase;
   property TotalPurchase: string read fTotalPurchase write SetTotalPurchase;
   property DiscontMaxScores: string read fDiscontMaxScores write SetDiscontMaxScores;
   property CashPurchase: string read fCashPurchase write SetCashPurchase;
   property CodePurchase: string read fCodePurchase write SetCodePurchase;
   property InvoiceNumberPurchase: string read fInvoiceNumberPurchase write SetInvoiceNumberPurchase;
   property CustomerIdPurchase: string read fCustomerIdPurchase write SetCustomerIdPurchase;
   property CashierExternalIdPurchase: string read fCashierExternalIdPurchase write SetCashierExternalIdPurchase;
   property StepScores: string read fStepScores write SetStepScores;


   property CashPurchaseResp: string read fCashPurchaseResp write SetCashPurchaseResp;
   property EmailCashierPurchaseResp: string read fEmailCashierPurchaseResp write SetEmailCashierPurchaseResp;
   property ExternalIdCashierPurchaseResp: string read fExternalIdCashierPurchaseResp write SetExternalIdCashierPurchaseResp;
   property NameCashierPurchaseResp: string read fNameCashierPurchaseResp write SetNameCashierPurchaseResp;
   property IdCustomerPurchaseResp: string read fIdCustomerPurchaseResp write SetIdCustomerPurchaseResp;
   property NamePurchaseResp: string read fNamePurchaseResp write SetNamePurchaseResp;
   property SurnamePurchaseResp: string read fSurnamePurchaseResp write SetSurnamePurchaseResp;
   property DateCreatedPurchaseResp: string read fDateCreatedPurchaseResp write SetDateCreatedPurchaseResp;
   property IdPurchaseResp: string read fIdPurchaseResp write SetIdPurchaseResp;
   property DiscountBasePurchaseResp: string read fDiscountBasePurchaseResp write SetDiscountBasePurchaseResp;
   property DiscountLevel1PurchaseResp: string read fDiscountLevel1PurchaseResp write SetDiscountLevel1PurchaseResp;
   property DiscountLevel2PurchaseResp: string read fDiscountLevel2PurchaseResp write SetDiscountLevel2PurchaseResp;
   property DiscountLevel3PurchaseResp: string read fDiscountLevel3PurchaseResp write SetDiscountLevel3PurchaseResp;
   property MaxScoresDiscountPurchaseResp: string read fMaxScoresDiscountPurchaseResp write SetMaxScoresDiscountPurchaseResp;
   property ScoresDeltaPurchaseResp: string read fScoresDeltaPurchaseResp write SetScoresDeltaPurchaseResp;
   property ScoresNewPurchaseResp: string read fScoresNewPurchaseResp write SetScoresNewPurchaseResp;
   property TotalPurchaseResp: string read fTotalPurchaseResp write SetTotalPurchaseResp;
   //
   property UUID: string read GetUUID write SetUUID;
   property DateInISO8601: string read GetDateInISO8601 write SetDateInISO8601;
   //
   property ErrorStatus: string read fErrorStatus write SetErrorStatus;
   ///
   function PostCustomerOperation:boolean;
   function ResponseCustomerOperation(Value: string): boolean;
   //
   function PostCompanyOperation:boolean;
   function ResponseCompanyOperation(Value: string): boolean;
   //
   function PostPurchaseOperation:boolean;
   function ResponsePurchaseOperation(Value: string): boolean;
   function CashPurchaseCalc(Value: string): boolean;
   procedure SetNull;
  end;

implementation

{ TMyJSONParser }

function TMyJSONParser.CashPurchaseCalc(Value: string): boolean;
var
   tempCash:real;
   ValueUserScores:integer;
   DiscontBaseTemp:Real;
   DiscontMaxTemp:Real;
 {  DiscontTemp:Real;
   MaxScoresDiscountCompanyTemp:Real;}

begin
 Result:=False;

 {Представитель UDS уверяет, что теперь механизм обработки данных реализован на стороне сервера,
  так же испралена ошибка - не баллы, а проценты}
 ValueUserScores:=StrToInt(Value);
 fScoresPurchase:='0';
 fStepScores:='1';
 tempCash:=StrToFloat(fTotalPurchase);
 DiscontBaseTemp:=(StrToFloat(fTotalPurchase)*StrToFloat(fDiscountRateCustomer))/100;
 if Value='0' then fStepScores:=FloatToStr(Round(tempCash/100));

 try
  StrToFloat(fMaxScoresDiscountCompany);
 except 
  fMaxScoresDiscountCompany:='0';
 end; 
 if fBaseDiscountPolicyCompany=APPLY_DISCOUNT then
  begin
   DiscontMaxTemp:=((StrToFloat(fTotalPurchase)-DiscontBaseTemp)*StrToFloat(fMaxScoresDiscountCompany))/100;
   fDiscontMaxScores:=inttostr(Round(DiscontMaxTemp));
   if strtoint(fDiscontMaxScores)>Round(StrToFloat(fScoresCustomer)) then fDiscontMaxScores:=IntToStr(Round(StrToFloat(fScoresCustomer)));
   if ValueUserScores>Round(DiscontMaxTemp) then ValueUserScores:=Round(DiscontMaxTemp);
   tempCash:=tempCash-DiscontBaseTemp-ValueUserScores;   
  end;

 if fBaseDiscountPolicyCompany=CHARGE_SCORES then
  begin
   DiscontMaxTemp:=((StrToFloat(fTotalPurchase))*StrToFloat(fMaxScoresDiscountCompany))/100;  
   fDiscontMaxScores:=inttostr(Trunc(DiscontMaxTemp));
   if strtoint(fDiscontMaxScores)>Round(StrToFloat(fScoresCustomer)) then fDiscontMaxScores:=IntToStr(Round(StrToFloat(fScoresCustomer)));
   if ValueUserScores>Round(DiscontMaxTemp) then ValueUserScores:=Round(DiscontMaxTemp);
   tempCash:=tempCash-ValueUserScores;
  end;

 if tempCash<0 then
  begin
    ValueUserScores:=ValueUserScores-Round(ABS(tempCash));
    tempCash:=0;
  end;

 fScoresPurchase:=IntToStr(ValueUserScores);   
 fCashPurchase:=FloatToStr(Round(tempCash));
 Result:=True;

{ if fBaseDiscountPolicyCompany=APPLY_DISCOUNT then
  begin
   DiscontTemp:=StrToFloat(fDiscountBaseCompany);
   ValueUserScores:=StrToInt(Value);
   fScoresPurchase:='0';
   if fLevelCustomer='1' then
    begin
      if ValueUserScores<>0 then
       begin
         if ValueUserScores>StrToFloat(fDiscountLevel1Company) then
                                ValueUserScores:=trunc(StrToFloat(fDiscountLevel1Company));
       //  DiscontTemp:=DiscontTemp+ValueUserScores;  //для % расскоментировать
         fScoresPurchase:=IntToStr(ValueUserScores);
       end;
    end;

   if fLevelCustomer='2' then
    begin
      if ValueUserScores<>0 then
       begin
         if ValueUserScores>StrToFloat(fDiscountLevel1Company)+StrToFloat(fDiscountLevel2Company) then
                                 ValueUserScores:=trunc(StrToFloat(fDiscountLevel1Company)+StrToFloat(fDiscountLevel2Company));
       //  DiscontTemp:=DiscontTemp+ValueUserScores;   //для % расскоментировать
         fScoresPurchase:=IntToStr(ValueUserScores);
       end;
    end;

   if fLevelCustomer='3' then
    begin
      if ValueUserScores<>0 then
       begin
         if ValueUserScores>StrToFloat(fDiscountLevel1Company)+StrToFloat(fDiscountLevel2Company)+StrToFloat(fDiscountLevel3Company) then
                                 ValueUserScores:=trunc(StrToFloat(fDiscountLevel1Company)+StrToFloat(fDiscountLevel2Company)+StrToFloat(fDiscountLevel3Company));
       //  DiscontTemp:=DiscontTemp+ValueUserScores;  //для % расскоментировать
         fScoresPurchase:=IntToStr(ValueUserScores);
       end;
    end;

   // этот кусок для расчётов в процентах
//   if (DiscontTemp>StrToFloat(fMaxScoresDiscountCompany))and(ValueUserScores<>0) then
//    begin
//      DiscontTemp:=StrToFloat(fDiscountBaseCompany);
//      ValueUserScores:=trunc(StrToFloat(fMaxScoresDiscountCompany));               //для % расскоментировать
//      DiscontTemp:=DiscontTemp+ValueUserScores;
//      fScoresPurchase:=IntToStr(ValueUserScores);
//    end;
   // этот кусок для расчётов в процентах

   tempCash:=StrToFloat(fTotalPurchase)-(StrToFloat(fTotalPurchase)*DiscontTemp)/100;
   tempCash:=round(tempCash * 100)/100;
   tempCash:=tempCash-ValueUserScores;  //!!!!!!!  для % -ValueUserScores; убрать
   // этот кусок для расчётов в процентах




   // этот кусок для минусовки баллов
   MaxScoresDiscountCompanyTemp:=(StrToFloat(fTotalPurchase)*StrToFloat(fMaxScoresDiscountCompany))/100;

   if (tempCash>MaxScoresDiscountCompanyTemp) then
    begin
      DiscontTemp:=StrToFloat(fDiscountBaseCompany);
      if ValueUserScores>0 then ValueUserScores:=ValueUserScores-1;
      fScoresPurchase:=IntToStr(ValueUserScores);
      tempCash:=StrToFloat(fTotalPurchase)-(StrToFloat(fTotalPurchase)*DiscontTemp)/100;
      tempCash:=round(tempCash * 100)/100;
      tempCash:=tempCash-ValueUserScores;
    end;
   // этот кусок для минусовки баллов

   fCashPurchase:=FloatToStr(tempCash);
   Result:=True;
  end;

 if fBaseDiscountPolicyCompany=CHARGE_SCORES then
  begin
   fCashPurchase:=fTotalPurchase;
   fScoresPurchase:='0';
   Result:=True;
  end;
   }
end;

constructor TMyJSONParser.Create;
begin
  inherited Create;
  fCustomerObject := TStringList.Create;
  fCompanyObject := TStringList.Create;
  fPurchaseObject := TStringList.Create;

  fSSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create;
  fSSLIOHandler.SSLOptions.Method:=sslvTLSv1_2;
//
  fHTTPClient := TidHTTP.Create;
  setHTTPClient;
//
  fIdCookieManager:=TIdCookieManager.Create;
end;

destructor TMyJSONParser.Destroy;
begin
 try
  fCustomerObject.Free;
  fCompanyObject.Free;
  fPurchaseObject.Free;

  fSSLIOHandler.Free;
  fHTTPClient.Free;
  fIdCookieManager.Free;
 except
 end;

 inherited Destroy;
end;


procedure TMyJSONParser.SetNull;
begin
 try
  fXApiKey:='';
  fMainURL:='';
  fErrorStatus:='';
  fCompanyObject.Clear;
  fCustomerObject.Clear;
  fPurchaseObject.Clear;
  SetBaseDiscountPolicyCompany('0');
  SetIDCompany('');
  SetDiscountBaseCompany('0');
  SetDiscountLevel1Company('0');
  SetDiscountLevel2Company('0');
  SetDiscountLevel3Company('0');
  SetMaxScoresDiscountCompany('0');
  SetNameCompany('');
  SetPromoCodeCompany('');
  SetIdCustomerResp('');
  SetNameCustomer('');
  SetSurnameCustomer('');
  SetDateCreatedCustomer('');
  SetBirthDateCustomer('');
  SetPhoneCustomer('');
  SetInstagramCustomer('');
  SetParticipantCustomer('');
  SetScoresCustomer('0');
  SetLevelCustomer('0');
  SetCashPurchaseResp('0');
  SetEmailCashierPurchaseResp('');
  SetExternalIdCashierPurchaseResp('');
  SetNameCashierPurchaseResp('');
  SetIdCustomerPurchaseResp('');
  SetNamePurchaseResp('');
  SetSurnamePurchaseResp('');
  SetDateCreatedPurchaseResp('');
  SetIdPurchaseResp('');
  SetDiscountBasePurchaseResp('0');
  SetDiscountLevel1PurchaseResp('0');
  SetDiscountLevel2PurchaseResp('0');
  SetDiscountLevel3PurchaseResp('0');
  SetMaxScoresDiscountPurchaseResp('0');
  SetScoresDeltaPurchaseResp('0');
  SetScoresNewPurchaseResp('0');
  SetTotalPurchaseResp('0');
  SetDiscontMaxScores('0');
 finally
 end;
end;

procedure TMyJSONParser.setHTTPClient;
begin
  fHTTPClient.ReadTimeout := 60000;
  fHTTPClient.Request.ContentEncoding:= 'utf-8';
  fHTTPClient.Request.UserAgent := 'Mozilla/3.0 (compatible; Indy Library)';
  fHTTPClient.IOHandler := FSSLIOHandler;
  fHTTPClient.HandleRedirects := True;
  fHTTPClient.CookieManager:=fIdCookieManager;
end;

procedure TMyJSONParser.setClearHTTPClient;
begin
  fHTTPClient.Request.CustomHeaders :=
     TIdHeaderList.Create(TIdHeaderQuotingType.QuoteHTTP);
end;

function TMyJSONParser.GetCompanyObject: TStringList;
begin
 try
   fCompanyObject.Clear;
   setClearHTTPClient;
   setHTTPClient;
   fHTTPClient.Request.CustomHeaders.AddValue(ShemaCompany.Accept,ShemaCompany.Appjs);
   fHTTPClient.Request.CustomHeaders.AddValue(ShemaCompany.XOrReqId,GetUUID);
   fHTTPClient.Request.CustomHeaders.AddValue(ShemaCompany.XTimeStamp,GetDateInISO8601);
   fHTTPClient.Request.CustomHeaders.AddValue(ShemaCompany.XApiKey,fXApiKey);
 finally
 end;

 fURL:=fMainURL+URLCompany;

end;

function TMyJSONParser.GetCustomerObject: TStringList;
begin
 try
   fCustomerObject.Clear;
   setClearHTTPClient;
   setHTTPClient;
   fHTTPClient.Request.CustomHeaders.AddValue(ShemaCustomer.Accept,ShemaCustomer.Appjs);
   fHTTPClient.Request.CustomHeaders.AddValue(ShemaCustomer.XOrReqId,GetUUID);
   fHTTPClient.Request.CustomHeaders.AddValue(ShemaCustomer.XTimeStamp,GetDateInISO8601);
   fHTTPClient.Request.CustomHeaders.AddValue(ShemaCustomer.XApiKey,fXApiKey);
 finally
 end;


 fURL:=fMainURL+URLCustomer;
 if (fPromoKod<>'') and (fIDCustomer='')  then fURL:=fURL+ShemaCustomer.Question+ShemaCustomer.Code+fPromoKod;
 if (fPromoKod='')  and (fIDCustomer<>'') then fURL:=fURL+ShemaCustomer.Question+ShemaCustomer.CustomerId+fIDCustomer;
 if (fPromoKod<>'') and (fIDCustomer<>'') then fURL:=fURL+ShemaCustomer.Question+ShemaCustomer.Code+fPromoKod+ShemaCustomer.Ampersand+ShemaCustomer.CustomerId+fIDCustomer;
 if (fPromoKod='')  and (fIDCustomer='')  then SetErrorStatus(E4);

end;

function TMyJSONParser.GetPurchaseObject: TStringList;
 var
  FJSONObject: TJSONObject;
  Pair,Pair2,Pair3,Pair4,Pair5,Pair6,Pair7 : TJSONPair;
  s:string;
begin
 try
   fPurchaseObject.Clear;
   setClearHTTPClient;
   setHTTPClient;
   fHTTPClient.Request.CustomHeaders.AddValue(ShemaPurchase.Accept,ShemaPurchase.Appjs);
   fHTTPClient.Request.CustomHeaders.AddValue(ShemaPurchase.ContType,ShemaPurchase.Appjs);
   fHTTPClient.Request.CustomHeaders.AddValue(ShemaPurchase.XOrReqId,GetUUID);
   fHTTPClient.Request.CustomHeaders.AddValue(ShemaPurchase.XTimeStamp,GetDateInISO8601);
   fHTTPClient.Request.CustomHeaders.AddValue(ShemaPurchase.XApiKey,fXApiKey);
 finally
 end;

  fURL:=fMainURL+URLPurchase;
 {"customerId":0,"code":"693848","total":100,"scores":0,"cash":90,"invoiceNumber":"1","cashierExternalId":"2"}
 try
  FJSONObject:=TJSONObject.Create;
  Pair:=TJSONPair.Create(ShemaPurchase.customerId,IdCustomerResp{fCustomerIdPurchase});
  FJSONObject.AddPair(Pair);
  Pair2:=TJSONPair.Create(ShemaPurchase.code,fCodePurchase);
  FJSONObject.AddPair(Pair2);
  if Pos(',',fTotalPurchase)<>0 then fTotalPurchase:=StringReplace(fTotalPurchase,',','.',[]);
  Pair3:=TJSONPair.Create(ShemaPurchase.total,fTotalPurchase);
  FJSONObject.AddPair(Pair3);
  Pair4:=TJSONPair.Create(ShemaPurchase.scores,fScoresPurchase+'.0');
  FJSONObject.AddPair(Pair4);
  if Pos(',',fCashPurchase)<>0 then fCashPurchase:=StringReplace(fCashPurchase,',','.',[]);
  Pair5:=TJSONPair.Create(ShemaPurchase.cash,fCashPurchase);
  FJSONObject.AddPair(Pair5);
  Pair6:=TJSONPair.Create(ShemaPurchase.invoiceNumber,fInvoiceNumberPurchase);
  FJSONObject.AddPair(Pair6);
  Pair7:=TJSONPair.Create(ShemaPurchase.cashierExternalId,fCashierExternalIdPurchase);
  FJSONObject.AddPair(Pair7);
  fPurchaseObject.Clear;
  fPurchaseObject.Add(FJSONObject.ToString);
//  fPurchaseObject.SaveToFile('1.txt');
 finally
   FJSONObject.Free;
 end;
end;

function TMyJSONParser.PostCompanyOperation: boolean;
var
  sResponse: string;
begin
  Result:=False;
  GetCompanyObject;
{  try
   fHTTPClient.Get(sURLTest);
  except
  // on e : Exception do
     begin
      SetErrorStatus(E7+sURLTest);
      exit;
     end;
  end; }
 try
   sResponse := fHTTPClient.Get(fURL);
   if ResponseCompanyOperation(sResponse) then Result:=True
                                          else SetErrorStatus(E6);
 except
   on e : EIDHttpProtocolException do
    begin
     if e.ErrorCode = 400 then
      begin
       SetErrorStatus(E400);
      end
       else if e.ErrorCode = 403 then
        begin
          SetErrorStatus(E403);
        end
         else if e.ErrorCode = 404 then
          begin
            SetErrorStatus(E404);
          end
           else
            begin
             SetErrorStatus(E6);
            end;
    end;
 end;

end;

function TMyJSONParser.PostCustomerOperation: boolean;
var
  sResponse: string;
begin
  Result:=False;
  GetCustomerObject;
{  try
   fHTTPClient.Get(sURLTest);
  except
      SetErrorStatus(E7+sURLTest);
      exit;
  end; }
 try
   sResponse := fHTTPClient.Get(fURL);
   if ResponseCustomerOperation(sResponse) then Result:=True
                                            else SetErrorStatus(E6);
 except
   on e : EIDHttpProtocolException do
    begin
     if e.ErrorCode = 400 then
      begin
       SetErrorStatus(E400);
      end
       else if e.ErrorCode = 403 then
        begin
          SetErrorStatus(E403);
        end
         else if e.ErrorCode = 404 then
          begin
            SetErrorStatus(E404);
          end
           else
            begin
             SetErrorStatus(E6);
            end;
    end;
 end;

end;

function TMyJSONParser.PostPurchaseOperation: boolean;
var
  sResponse: string;
  JsonToSend: TStringStream;
begin
  Result:=False;
  GetPurchaseObject;

 try
   JsonToSend := TStringStream.Create(fPurchaseObject.Text);
   sResponse := FHTTPClient.Post(fURL, JsonToSend);
   if ResponsePurchaseOperation(sResponse) then Result:=True
                                            else SetErrorStatus(E6);
 except
   on e : EIDHttpProtocolException do
    begin
     if e.ErrorCode = 400 then
      begin
       SetErrorStatus(E400);
      end
       else if e.ErrorCode = 403 then
        begin
          SetErrorStatus(E403);
        end
         else if e.ErrorCode = 404 then
          begin
            SetErrorStatus(E404);
          end
           else
            begin
             SetErrorStatus(E6);
            end;
    end;
 end;
  JsonToSend.Free;
end;

function TMyJSONParser.ResponseCompanyOperation(Value: string): boolean;
var
  JObject,JObjectData: TJSONobject;
  JPair: TJSONPair;
begin
 Result:=False;
  try
    JObject:=TJSONObject.ParseJSONValue(Value) as TJSONObject;
    if Assigned(JObject) then
        begin
          JPair:=JObject.Get(ShemaCompany.baseDiscountPolicy);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetBaseDiscountPolicyCompany(JPair.JsonValue.Value)
                                               else SetBaseDiscountPolicyCompany('');
              Result:=True;
           end;

          JPair:=JObject.Get(ShemaCompany.id);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetIDCompany(JPair.JsonValue.Value)
                                               else SetIDCompany('');
              Result:=True;
           end;

          JObjectData:=JObject.GetValue(ShemaCompany.marketingSettings) as TJSONObject;
          if Assigned(JObjectData) then
           begin

            JPair:=JObjectData.Get(ShemaCompany.discountBase);
             if Assigned(JPair) then
              begin
              if JPair.JsonValue.Value<>'null' then SetDiscountBaseCompany(JPair.JsonValue.Value)
                                               else SetDiscountBaseCompany('0');
               Result:=True;
              end;

            JPair:=JObjectData.Get(ShemaCompany.discountLevel1);
             if Assigned(JPair) then
              begin
              if JPair.JsonValue.Value<>'null' then SetDiscountLevel1Company(JPair.JsonValue.Value)
                                               else SetDiscountLevel1Company('1');
               Result:=True;
              end;

            JPair:=JObjectData.Get(ShemaCompany.discountLevel2);
             if Assigned(JPair) then
              begin
              if JPair.JsonValue.Value<>'null' then SetDiscountLevel2Company(JPair.JsonValue.Value)
                                               else SetDiscountLevel2Company('1');
               Result:=True;
              end;

            JPair:=JObjectData.Get(ShemaCompany.discountLevel3);
             if Assigned(JPair) then
              begin
              if JPair.JsonValue.Value<>'null' then SetDiscountLevel3Company(JPair.JsonValue.Value)
                                               else SetDiscountLevel3Company('1');
               Result:=True;
              end;

            JPair:=JObjectData.Get(ShemaCompany.maxScoresDiscount);
             if Assigned(JPair) then
              begin
              if JPair.JsonValue.Value<>'null' then SetMaxScoresDiscountCompany(JPair.JsonValue.Value)
                                                else SetMaxScoresDiscountCompany('0');
               Result:=True;
              end;
           end;

          JPair:=JObject.Get(ShemaCompany.name);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetNameCompany(JPair.JsonValue.Value)
                                                else SetNameCompany('');
              Result:=True;
           end;

          JPair:=JObject.Get(ShemaCompany.promoCode);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetPromoCodeCompany(JPair.JsonValue.Value)
                                                else SetPromoCodeCompany('');
              Result:=True;
           end;

        end;

  finally
   JObject.Destroy;
  end;
end;

function TMyJSONParser.ResponseCustomerOperation(Value: string): boolean;
var
  JObject: TJSONobject;
  JPair: TJSONPair;
begin
 Result:=False;
  try
    JObject:=TJSONObject.ParseJSONValue(Value) as TJSONObject;
    if Assigned(JObject) then
        begin
          JPair:=JObject.Get(ShemaCustomer.id);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetIdCustomerResp(JPair.JsonValue.Value)
                                               else SetIdCustomerResp('');
              Result:=True;
           end;

          JPair:=JObject.Get(ShemaCustomer.name);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetNameCustomer(JPair.JsonValue.Value)
                                               else SetNameCustomer('');
              Result:=True;
           end;

          JPair:=JObject.Get(ShemaCustomer.surname);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetSurnameCustomer(JPair.JsonValue.Value)
                                               else SetSurnameCustomer('');
              Result:=True;
           end;

          JPair:=JObject.Get(ShemaCustomer.dateCreated);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetDateCreatedCustomer(JPair.JsonValue.Value)
                                               else SetDateCreatedCustomer('');
              Result:=True;
           end;

          JPair:=JObject.Get(ShemaCustomer.birthDate);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetBirthDateCustomer(JPair.JsonValue.Value)
                                               else SetBirthDateCustomer('');
              Result:=True;
           end;

          JPair:=JObject.Get(ShemaCustomer.phone);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetPhoneCustomer(JPair.JsonValue.Value)
                                               else SetPhoneCustomer('');
              Result:=True;
           end;

          JPair:=JObject.Get(ShemaCustomer.skype);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetSkypeCustomer(JPair.JsonValue.Value)
                                               else SetSkypeCustomer('');
              Result:=True;
           end;

          JPair:=JObject.Get(ShemaCustomer.instagram);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetInstagramCustomer(JPair.JsonValue.Value)
                                               else SetInstagramCustomer('');
              Result:=True;
           end;

          JPair:=JObject.Get(ShemaCustomer.participant);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetParticipantCustomer(JPair.JsonValue.Value)
                                               else SetParticipantCustomer('');
              Result:=True;
           end;

          JPair:=JObject.Get(ShemaCustomer.scores);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetScoresCustomer(JPair.JsonValue.Value)
                                               else SetScoresCustomer('0');
              Result:=True;
           end;

          JPair:=JObject.Get(ShemaCustomer.level);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetLevelCustomer(JPair.JsonValue.Value)
                                               else SetLevelCustomer('');
              Result:=True;
           end;

          JPair:=JObject.Get(ShemaCustomer.discountRate);
          if Assigned(JPair) then
           begin
              if JPair.JsonValue.Value<>'null' then SetDiscountRateCustomer(JPair.JsonValue.Value)
                                               else SetDiscountRateCustomer('0');
              Result:=True;
           end;

        end;

  finally
   JObject.Destroy;
  end;
   /////
end;

function TMyJSONParser.ResponsePurchaseOperation(Value: string): boolean;
var
  JObject,JObjectOperation,JObjectCashier,JObjectCustomer,JObjectMarketing: TJSONobject;
  JPair: TJSONPair;
begin
 Result:=False;
  try
    JObject:=TJSONObject.ParseJSONValue(Value) as TJSONObject;
    if Assigned(JObject) then
        begin
         JObjectOperation:=JObject.GetValue(ShemaPurchase.Operation) as TJSONObject; //operation
         if Assigned(JObjectOperation) then
          begin

           JPair:=JObjectOperation.Get(ShemaPurchase.cash);
            if Assigned(JPair) then
             begin
              if JPair.JsonValue.Value<>'null' then SetCashPurchaseResp(JPair.JsonValue.Value) //cash
                                               else SetCashPurchaseResp('');
              Result:=True;
             end;

           JObjectCashier:=JObject.GetValue(ShemaPurchase.Cashier) as TJSONObject;  //cashier
            if Assigned(JObjectOperation) then
             begin

              JPair:=JObjectOperation.Get(ShemaPurchase.email);
              if Assigned(JPair) then
               begin
                 if JPair.JsonValue.Value<>'null' then SetEmailCashierPurchaseResp(JPair.JsonValue.Value) //email
                                                  else SetEmailCashierPurchaseResp('');
                Result:=True;
               end;

              JPair:=JObjectOperation.Get(ShemaPurchase.externalId);
              if Assigned(JPair) then
               begin
                 if JPair.JsonValue.Value<>'null' then SetExternalIdCashierPurchaseResp(JPair.JsonValue.Value) //externalId
                                                  else SetExternalIdCashierPurchaseResp('');
                Result:=True;
               end;

              JPair:=JObjectOperation.Get(ShemaPurchase.name);
              if Assigned(JPair) then
               begin
                 if JPair.JsonValue.Value<>'null' then SetNameCashierPurchaseResp(JPair.JsonValue.Value) //name
                                                  else SetNameCashierPurchaseResp('');
                Result:=True;
               end;

             end;

           JObjectCustomer:=JObject.GetValue(ShemaPurchase.customer) as TJSONObject;
           if Assigned(JObjectCustomer) then
            begin

              JPair:=JObjectCustomer.Get(ShemaPurchase.id);
              if Assigned(JPair) then
               begin
                 if JPair.JsonValue.Value<>'null' then SetIdCustomerPurchaseResp(JPair.JsonValue.Value) //id
                                                  else SetIdCustomerPurchaseResp('');
                Result:=True;
               end;

              JPair:=JObjectCustomer.Get(ShemaPurchase.name);
              if Assigned(JPair) then
               begin
                 if JPair.JsonValue.Value<>'null' then SetNamePurchaseResp(JPair.JsonValue.Value) //name
                                                  else SetNamePurchaseResp('');
                Result:=True;
               end;

              JPair:=JObjectCustomer.Get(ShemaPurchase.surname);
              if Assigned(JPair) then
               begin
                 if JPair.JsonValue.Value<>'null' then SetSurnamePurchaseResp(JPair.JsonValue.Value) //surname
                                                  else SetSurnamePurchaseResp('');
                Result:=True;
               end;

            end;

           JPair:=JObjectOperation.Get(ShemaPurchase.dateCreated);
            if Assigned(JPair) then
             begin
              if JPair.JsonValue.Value<>'null' then SetDateCreatedPurchaseResp(JPair.JsonValue.Value) //dateCreated
                                               else SetDateCreatedPurchaseResp('');
              Result:=True;
             end;

           JPair:=JObjectOperation.Get(ShemaPurchase.id);
            if Assigned(JPair) then
             begin
              if JPair.JsonValue.Value<>'null' then SetIdPurchaseResp(JPair.JsonValue.Value) //id
                                               else SetIdPurchaseResp('');
              Result:=True;
             end;

           JObjectMarketing:=JObject.GetValue(ShemaPurchase.marketingSettings) as TJSONObject;  //marketingSettings
           if Assigned(JObjectMarketing) then
            begin

              JPair:=JObjectCustomer.Get(ShemaPurchase.discountBase);
              if Assigned(JPair) then
               begin
                 if JPair.JsonValue.Value<>'null' then SetDiscountBasePurchaseResp(JPair.JsonValue.Value) //discountBase
                                                  else SetDiscountBasePurchaseResp('');
                Result:=True;
               end;

              JPair:=JObjectCustomer.Get(ShemaPurchase.discountLevel1);
              if Assigned(JPair) then
               begin
                 if JPair.JsonValue.Value<>'null' then SetDiscountLevel1PurchaseResp(JPair.JsonValue.Value)//discountLevel1
                                                  else SetDiscountLevel1PurchaseResp('');
                Result:=True;
               end;

              JPair:=JObjectCustomer.Get(ShemaPurchase.discountLevel2);
              if Assigned(JPair) then
               begin
                 if JPair.JsonValue.Value<>'null' then SetDiscountLevel2PurchaseResp(JPair.JsonValue.Value) //discountLevel2
                                                  else SetDiscountLevel2PurchaseResp('');
                Result:=True;
               end;

              JPair:=JObjectCustomer.Get(ShemaPurchase.discountLevel3);
              if Assigned(JPair) then
               begin
                 if JPair.JsonValue.Value<>'null' then SetDiscountLevel3PurchaseResp(JPair.JsonValue.Value) //discountLevel3
                                                  else SetDiscountLevel3PurchaseResp('');
                Result:=True;
               end;

              JPair:=JObjectCustomer.Get(ShemaPurchase.maxScoresDiscount);
              if Assigned(JPair) then
               begin
                 if JPair.JsonValue.Value<>'null' then SetMaxScoresDiscountPurchaseResp(JPair.JsonValue.Value) //maxScoresDiscount
                                                  else SetMaxScoresDiscountPurchaseResp('');
                Result:=True;
               end;

            end;

           JPair:=JObjectOperation.Get(ShemaPurchase.scoresDelta);
            if Assigned(JPair) then
             begin
              if JPair.JsonValue.Value<>'null' then SetScoresDeltaPurchaseResp(JPair.JsonValue.Value) //scoresDelta
                                               else SetScoresDeltaPurchaseResp('');
              Result:=True;
             end;

           JPair:=JObjectOperation.Get(ShemaPurchase.scoresNew);
            if Assigned(JPair) then
             begin
               if JPair.JsonValue.Value<>'null' then SetScoresNewPurchaseResp(JPair.JsonValue.Value) //scoresNew
                                                else SetScoresNewPurchaseResp('');
              Result:=True;
             end;

           JPair:=JObjectOperation.Get(ShemaPurchase.total);
            if Assigned(JPair) then
             begin
              if JPair.JsonValue.Value<>'null' then SetTotalPurchaseResp(JPair.JsonValue.Value) //total
                                               else SetTotalPurchaseResp('');
              Result:=True;
             end;

          end;

        end;
  finally
   JObject.Destroy;
  end;
end;

procedure TMyJSONParser.SetBaseDiscountPolicyCompany(const Value: string);
begin
  if Value <> fBaseDiscountPolicyCompany then
  begin
    fBaseDiscountPolicyCompany := Value;
  end;
end;

procedure TMyJSONParser.SetBirthDateCustomer(const Value: string);
begin
  if Value <> fBirthDateCustomer then
  begin
    fBirthDateCustomer := Value;
  end;
end;

procedure TMyJSONParser.SetCashierExternalIdPurchase(const Value: string);
begin
  if Value <> fCashierExternalIdPurchase then
  begin
    fCashierExternalIdPurchase := Value;
  end;
end;

procedure TMyJSONParser.SetCashPurchase(const Value: string);
begin
  if Value <> fCashPurchase then
  begin
    fCashPurchase := Value;
  end;
end;

procedure TMyJSONParser.SetCashPurchaseResp(const Value: string);
begin
  if Value <> fCashPurchaseResp then
  begin
    fCashPurchaseResp := Value;
  end;
end;

function TMyJSONParser.GetDateInISO8601: string;
begin
  Result:=DateToISO8601(Now(), false);
end;

function TMyJSONParser.GetUUID: string;
var
 Uid: TGuid;
 Res: HResult;
begin
 Res := CreateGuid(Uid);
 if Res = S_OK then Result:=GuidToString(Uid);
end;

procedure TMyJSONParser.SetCodePurchase(const Value: string);
begin
  if Value <> fCodePurchase then
  begin
    fCodePurchase := Value;
  end;
end;

procedure TMyJSONParser.SetCustomerIdPurchase(const Value: string);
begin
  if Value <> fCustomerIdPurchase then
  begin
    fCustomerIdPurchase := Value;
  end;
end;

procedure TMyJSONParser.SetDateCreatedCustomer(const Value: string);
begin
  if Value <> fDateCreatedCustomer then
  begin
    fDateCreatedCustomer := Value;
  end;
end;

procedure TMyJSONParser.SetDateCreatedPurchaseResp(const Value: string);
begin
  if Value <> fDateCreatedPurchaseResp then
  begin
    fDateCreatedPurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetDateInISO8601(const Value: string);
begin
  // read only property
end;

procedure TMyJSONParser.SetDiscontMaxScores(const Value: string);
begin
  if Value <> fDiscontMaxScores then
  begin
    fDiscontMaxScores := Value;
  end;
end;

procedure TMyJSONParser.SetDiscountBaseCompany(const Value: string);
begin
  if Value <> fDiscountBaseCompany then
  begin
    fDiscountBaseCompany := Value;
  end;
end;

procedure TMyJSONParser.SetDiscountBasePurchaseResp(const Value: string);
begin
  if Value <> fDiscountBasePurchaseResp then
  begin
    fDiscountBasePurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetDiscountLevel1Company(const Value: string);
begin
  if Value <> fDiscountLevel1Company then
  begin
    fDiscountLevel1Company := Value;
  end;
end;

procedure TMyJSONParser.SetDiscountLevel1PurchaseResp(const Value: string);
begin
  if Value <> fDiscountLevel1PurchaseResp then
  begin
    fDiscountLevel1PurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetDiscountLevel2Company(const Value: string);
begin
  if Value <> fDiscountLevel2Company then
  begin
    fDiscountLevel2Company := Value;
  end;
end;

procedure TMyJSONParser.SetDiscountLevel2PurchaseResp(const Value: string);
begin
  if Value <> fDiscountLevel2PurchaseResp then
  begin
    fDiscountLevel2PurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetDiscountLevel3Company(const Value: string);
begin
  if Value <> fDiscountLevel3Company then
  begin
    fDiscountLevel3Company := Value;
  end;
end;

procedure TMyJSONParser.SetDiscountLevel3PurchaseResp(const Value: string);
begin
  if Value <> fDiscountLevel3PurchaseResp then
  begin
    fDiscountLevel3PurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetDiscountRateCustomer(const Value: string);
begin
  if Value <> fDiscountRateCustomer then
  begin
    fDiscountRateCustomer := Value;
  end;
end;

procedure TMyJSONParser.SetEmailCashierPurchaseResp(const Value: string);
begin
  if Value <> fEmailCashierPurchaseResp then
  begin
    fEmailCashierPurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetErrorStatus(const Value: string);
begin
  if Value <> fErrorStatus then
  begin
    fErrorStatus := Value;
  end;
end;

procedure TMyJSONParser.SetExternalIdCashierPurchaseResp(const Value: string);
begin
  if Value <> fExternalIdCashierPurchaseResp then
  begin
    fExternalIdCashierPurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetGenderCustomer(const Value: string);
begin
  if Value <> fGenderCustomer then
  begin
    fGenderCustomer := Value;
  end;
end;

procedure TMyJSONParser.SetIDCompany(const Value: string);
begin
  if Value <> fIDCompany then
  begin
    fIDCompany := Value;
  end;
end;

procedure TMyJSONParser.SetIDCustomer(const Value: string);
begin
  if Value <> fIDCustomer then
  begin
    fIDCustomer := Value;
  end;
end;

procedure TMyJSONParser.SetIdCustomerPurchaseResp(const Value: string);
begin
  if Value <> fIdCustomerPurchaseResp then
  begin
    fIdCustomerPurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetIdCustomerResp(const Value: string);
begin
  if Value <> fIdCustomerResp then
  begin
    fIdCustomerResp := Value;
  end;
end;

procedure TMyJSONParser.SetIdPurchaseResp(const Value: string);
begin
  if Value <> fIdPurchaseResp then
  begin
    fIdPurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetInstagramCustomer(const Value: string);
begin
  if Value <> fInstagramCustomer then
  begin
    fInstagramCustomer := Value;
  end;
end;

procedure TMyJSONParser.SetInvoiceNumberPurchase(const Value: string);
begin
  if Value <> fInvoiceNumberPurchase then
  begin
    fInvoiceNumberPurchase := Value;
  end;
end;

procedure TMyJSONParser.SetLevelCustomer(const Value: string);
begin
  if Value <> fLevelCustomer then
  begin
    fLevelCustomer := Value;
  end;
end;

procedure TMyJSONParser.SetMainURL(const Value: string);
begin
  if Value <> fMainURL then
  begin
    fMainURL := Value;
  end;
end;

procedure TMyJSONParser.SetMaxScoresDiscountCompany(const Value: string);
begin
  if Value <> fMaxScoresDiscountCompany then
  begin
    fMaxScoresDiscountCompany := Value;
  end;
end;

procedure TMyJSONParser.SetMaxScoresDiscountPurchaseResp(const Value: string);
begin
  if Value <> fMaxScoresDiscountPurchaseResp then
  begin
    fMaxScoresDiscountPurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetNameCashierPurchaseResp(const Value: string);
begin
  if Value <> fNameCashierPurchaseResp then
  begin
    fNameCashierPurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetNameCompany(const Value: string);
begin
  if Value <> fNameCompany then
  begin
    fNameCompany := Value;
  end;
end;

procedure TMyJSONParser.SetNameCustomer(const Value: string);
begin
  if Value <> fNameCustomer then
  begin
    fNameCustomer := Value;
  end;
end;

procedure TMyJSONParser.SetNamePurchaseResp(const Value: string);
begin
  if Value <> fNamePurchaseResp then
  begin
    fNamePurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetParticipantCustomer(const Value: string);
begin
  if Value <> fParticipantCustomer then
  begin
    fParticipantCustomer := Value;
  end;
end;

procedure TMyJSONParser.SetPhoneCustomer(const Value: string);
begin
  if Value <> fPhoneCustomer then
  begin
    fPhoneCustomer := Value;
  end;
end;

procedure TMyJSONParser.SetPromoCodeCompany(const Value: string);
begin
  if Value <> fPromoCodeCompany then
  begin
    fPromoCodeCompany := Value;
  end;
end;

procedure TMyJSONParser.SetPromoKod(const Value: string);
begin
  if Value <> fPromoKod then
  begin
    fPromoKod := Value;
  end;
end;

procedure TMyJSONParser.SetScoresCustomer(const Value: string);
begin
  if Value <> fScoresCustomer then
  begin
    fScoresCustomer := Value;
  end;
end;

procedure TMyJSONParser.SetScoresDeltaPurchaseResp(const Value: string);
begin
  if Value <> fScoresDeltaPurchaseResp then
  begin
    fScoresDeltaPurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetScoresNewPurchaseResp(const Value: string);
begin
  if Value <> fScoresNewPurchaseResp then
  begin
    fScoresNewPurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetScoresPurchase(const Value: string);
begin
  if Value <> fScoresPurchase then
  begin
    fScoresPurchase := Value;
  end;
end;

procedure TMyJSONParser.SetSkypeCustomer(const Value: string);
begin
  if Value <> fSkypeCustomer then
  begin
    fSkypeCustomer := Value;
  end;
end;

procedure TMyJSONParser.SetStepScores(const Value: string);
begin
  if Value <> fStepScores then
  begin
    fStepScores := Value;
  end;
end;

procedure TMyJSONParser.SetSurnameCustomer(const Value: string);
begin
  if Value <> fSurnameCustomer then
  begin
    fSurnameCustomer := Value;
  end;
end;

procedure TMyJSONParser.SetSurnamePurchaseResp(const Value: string);
begin
  if Value <> fSurnamePurchaseResp then
  begin
    fSurnamePurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetTotalPurchase(const Value: string);
begin
  if Value <> fTotalPurchase then
  begin
    fTotalPurchase := Value;
  end;
end;

procedure TMyJSONParser.SetTotalPurchaseResp(const Value: string);
begin
  if Value <> fTotalPurchaseResp then
  begin
    fTotalPurchaseResp := Value;
  end;
end;

procedure TMyJSONParser.SetXApiKey(const Value: string);
begin
  if Value <> fXApiKey then
  begin
    fXApiKey := Value;
  end;
end;

procedure TMyJSONParser.SetURL(const Value: string);
begin
  if Value <> fURL then
  begin
    fURL := Value;
  end;
end;

procedure TMyJSONParser.SetUUID;
begin
  // read only property
end;

end.
