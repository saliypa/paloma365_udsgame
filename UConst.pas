unit UConst;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
   ComCtrls, ToolWin, ExtCtrls;

 type
   TMyResultStrings = Array of WideString;

 type
   TVersionInfo = record
     dwSignature,
     dwStrucVersion,
     dwFileVersionMS,
     dwFileVersionLS,
     dwProductVersionMS,
     dwProductVersionLS,
     dwFileFlagsMask,
     dwFileFlags,
     dwFileOS,
     dwFileType,
     dwFileSubtype,
     dwFileDateMS,
     dwFileDateLS: DWORD;
   end;



type
   TMoneyCheckSum=Record
     Sum:string;
     CheckPaymentType:string
   end;

type
    TArrayOfString = array of String;

var
 MoneyCheckSumArray:array of TMoneyCheckSum;

resourcestring
    ReallyClose = 'Действительно закончить работу?';
    sSaveOK='Сохранение завершено';
    TestLoginStart = 'Тест соединения';
    TestLoginGood = 'Соединение установленно';
    TestLoginError = 'Ошибка соединения!';
    sFirstRun = 'Обнаружен первый запуск';
    sError   = 'Errors';
    sOK   = 'OK';
    sNoMoney = 'Не верно задана денежная сумма';
    sMyVersion='API UDSGame';
    sCustomer='Покупатель. ';
    sCompany='.';
    SRegPath='\Software\Paloma365\API UDSGame';
    sURLConst='https://udsgame.com/v1/partner';
    sRegLogin='Login';
    sRegPas='Pas';
    sRegAPIKey='APIKey';
    sRegURL='URL';
    FileKey='udsgame.com';

    sLabMain1='№  ';
    sLabMain2='Дата рождения:  ';
    sLabMain3='Телефон:  ';
    sLabMain4='Skype:  ';
    sLabMain5='Instagram:  ';
    sLabMain6='Баллов';

    sLabMain7='Базовая скидка: ';
    sLabMain8='Скидка 1 уровня: ';
    sLabMain9='Скидка 2 уровня: ';
    sLabMain10='Скидка 3 уровня: ';
    sLabMain11='Доступно к списанию: ';



/////////////////////////////////////////////////////////


var
    VarAPIKey:string;
    VarURLMain:string;
    MyDBHandle: Pointer;




implementation





end.


