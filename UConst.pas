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
    ReallyClose = '������������� ��������� ������?';
    sSaveOK='���������� ���������';
    TestLoginStart = '���� ����������';
    TestLoginGood = '���������� ������������';
    TestLoginError = '������ ����������!';
    sFirstRun = '��������� ������ ������';
    sError   = 'Errors';
    sOK   = 'OK';
    sNoMoney = '�� ����� ������ �������� �����';
    sMyVersion='API UDSGame';
    sCustomer='����������. ';
    sCompany='.';
    SRegPath='\Software\Paloma365\API UDSGame';
    sURLConst='https://udsgame.com/v1/partner';
    sRegLogin='Login';
    sRegPas='Pas';
    sRegAPIKey='APIKey';
    sRegURL='URL';
    FileKey='udsgame.com';

    sLabMain1='�  ';
    sLabMain2='���� ��������:  ';
    sLabMain3='�������:  ';
    sLabMain4='Skype:  ';
    sLabMain5='Instagram:  ';
    sLabMain6='������';

    sLabMain7='������� ������: ';
    sLabMain8='������ 1 ������: ';
    sLabMain9='������ 2 ������: ';
    sLabMain10='������ 3 ������: ';
    sLabMain11='�������� � ��������: ';



/////////////////////////////////////////////////////////


var
    VarAPIKey:string;
    VarURLMain:string;
    MyDBHandle: Pointer;




implementation





end.


