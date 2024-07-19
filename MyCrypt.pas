unit MyCrypt;

interface

uses Windows, Classes,System.SysUtils;

  function xebi(const text, passwd:string):string;



implementation

function xebi(const text, passwd:string):string;
const
  szBuffer = SizeOf(LongWord);
  szByteBuffer = SizeOf(Byte);

var
  HashPasswd, buffer, i, byteBuffer: LongWord;
  StreamOut, StreamIn: TStringStream;

function Murmur2(const S: String; const Seed: LongWord=$9747b28c): LongWord;
var
  hash, len, k: LongWord;
	StrAsBytes:TBytes;
  data: Integer;
const
  m = $5bd1e995;
  r = 24;
begin
  StrAsBytes:=TEncoding.UTF8.GetBytes(S);
  len:=Length(StrAsBytes);
  hash:=seed xor len;
  data:=0;

  while(len >= 4) do
  begin
    k := PLongWord(@StrAsBytes[data])^;
    k := k*m;
    k := k xor (k shr r);
    k := k*m;
    hash := hash*m;
    hash := hash xor k;
    inc(data,4);
    dec(len,4);
  end;

  Assert(len <= 3);
  if len = 3 then hash := hash xor (LongWord(StrAsBytes[data+2]) shl 16);
  if len >= 2 then hash := hash xor (LongWord(StrAsBytes[data+1]) shl 8);
  if len >= 1 then
  begin
    hash := hash xor (LongWord(StrAsBytes[data])); hash := hash * m;
  end;
  hash := hash xor (hash shr 13);
  hash := hash * m;
  hash := hash xor (hash shr 15);
  Result := hash;
end;
begin
  StreamIn:=TStringStream.Create(text);
  StreamOut:=TStringStream.Create('');
  try
    StreamIn.Position:=0;
    StreamOut.Position:=0;

    HashPasswd:=Murmur2(passwd);

    while (StreamIn.Position<StreamIn.Size) and ((StreamIn.Size-StreamIn.Position)>=szBuffer) do
    begin
      StreamIn.ReadBuffer(buffer, szBuffer);
      buffer := buffer xor HashPasswd;
      buffer := buffer xor $E0F;
      StreamOut.WriteBuffer(buffer, szBuffer);
    end;

    if (StreamIn.Size-StreamIn.Position)>=1 then
      for i:=StreamIn.Position to StreamIn.Size-1 do
      begin
        StreamIn.ReadBuffer(byteBuffer, szByteBuffer);
        byteBuffer:=byteBuffer xor $F;
        StreamOut.WriteBuffer(byteBuffer, szByteBuffer);
      end;

    StreamOut.Position:=0;
    Result:=StreamOut.ReadString(StreamOut.Size);
  finally
    StreamOut.Free;
    StreamIn.Free;
  end;
end;

end.
