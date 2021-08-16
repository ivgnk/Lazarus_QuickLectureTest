unit LStringsN;
{---------------------------------------------------------------------------}
                                       INTERFACE
{---------------------------------------------------------------------------}
  Uses
       SysUtils,
       StrUtils,
       Classes, LazUtf8;

  Type
   CharSet = set of Char;
  Const
   WD  :CharSet=[' '];
   MDlm:CharSet=['-'];
   CD  :CharSet=[','];
   SCD :CharSet=[';'];
   StarD  :CharSet=['*'];
   EqD  :CharSet=['='];
   PodD :CharSet=['_'];
   NumbersCh  : CharSet=['0'..'9'];
   LeftKSD :CharSet=['('];
   GeodD1:CharSet=['±'];
   ColonD:CharSet=[':'];

   rpw=15;
   rpp=7;
//LeftPad example - Format('%4d' , [C_D]))
  Var
   SubstrNew,SubstrOld:String;  //----Для Dfile.WorkInCycleWithFile

 Function IsEmptyStr(S:String):Boolean;
 Function IsNumDataS(S:String):Boolean;
 Function IsNumDataS2(S:String):Boolean;  // IsNumDataS + ',' - in bln
 Function IsIntegerS(S:String):Boolean;
 Function IsNaturalS(S:String):Boolean;


 function MWC(S : string; WordDelims : CharSet) : Integer;
 function MEW(N : Integer; S : string; WordDelims : CharSet) : string;
 function MEL2(N : Integer; const S : string; WordDelims : CharSet) : Integer;
 function MER2(N : Integer; const S : string; WordDelims : CharSet) : extended;
 Function SWLZ(w,NumNul : Word) : String;

 Function Pos_AntiCase(SubS,S:String):Byte;

{Recomended Len=9}
Function    PackReal(X,Y:Extended;rpw,rpp:Integer):String;
Procedure UnPackReal(S:String;Var X,Y:Extended);
{//---------Alias}
 Function RT(S:String):String; //------- Замена tab=Chr(9) на пробел
 Procedure RT2(var S:String); //------- Замена tab=Chr(9) на пробел
 Function RS(SubstrNew,SubstrOld, s : string): string;
 Function AUC(S:String):String;
 Function PR(X,Y:Extended;rpw,rpp:Integer):String;


 // строка длиной не более N, разбитая по словам, разделенным WordDelims
 // WD : string; WordDelims: CharSet - дуюлируют, т.к. не знаю перевод из CharSet d String;
 function StringNoMore(S, WD : string; WordDelims : CharSet; N : Integer; var RestOfStrung:String):string;
 // строка разбивается на строки длиной не более N , после которых - Возврат Краетки и Перевод Строки
 // WD : string; WordDelims: CharSet - дублируют, т.к. не знаю перевод из CharSet в String;
 function StringNoMore2(S, WD : string; WordDelims : CharSet; N : Integer):string;
{---------------------------------------------------------------------------}
                                    IMPLEMENTATION
{---------------------------------------------------------------------------}
Function IsEmptyStr(S:String):Boolean;
     begin
      IsEmptyStr:=Length(Trim(S))=0;
     end;

Function IsNumDataS(S:String):Boolean;
 Var TempB:Boolean; i:Integer;
 begin
  TempB:=True;
  For I:=1 to Length(S) do
   TempB:=TempB and (
   (S[i]='0') or (S[i]='1') or (S[i]='2') or  (S[i]='3') or
   (S[i]='4') or (S[i]='5') or (S[i]='6') or  (S[i]='7') or
   (S[i]='8') or (S[i]='9') or (S[i]='-') or  (S[i]='+') or
   (S[i]='e') or (S[i]='E') or (S[i]=' ') or  (S[i]='.')
   );
   IsNumDataS:=TempB
 end;

Function IsNumDataS2(S:String):Boolean;      // IsNumDataS + ',' - in bln
 Var TempB:Boolean; i:Integer;
 begin
  TempB:=True;
  For I:=1 to Length(S) do
   TempB:=TempB and (
   (S[i]='0') or (S[i]='1') or (S[i]='2') or  (S[i]='3') or
   (S[i]='4') or (S[i]='5') or (S[i]='6') or  (S[i]='7') or
   (S[i]='8') or (S[i]='9') or (S[i]='-') or  (S[i]='+') or
   (S[i]='e') or (S[i]='E') or (S[i]=' ') or  (S[i]='.') or  (S[i]=',')
   );
   IsNumDataS2:=TempB
 end;

Function IsIntegerS(S:String):Boolean;
   Var TempB:Boolean; i:Integer;
  begin
   TempB:=True;
   For I:=1 to Length(S) do
    TempB:=TempB and (
    (S[i]='0') or (S[i]='1') or (S[i]='2') or  (S[i]='3') or
    (S[i]='4') or (S[i]='5') or (S[i]='6') or  (S[i]='7') or
    (S[i]='8') or (S[i]='9') or (S[i]='-'));
   IsIntegerS:=TempB
  end;

Function IsNaturalS(S:String):Boolean;
   Var TempB:Boolean; i:Integer;
  begin
   TempB:=True;
   For I:=1 to Length(S) do
    TempB:=TempB and (
    (S[i]='0') or (S[i]='1') or (S[i]='2') or  (S[i]='3') or
    (S[i]='4') or (S[i]='5') or (S[i]='6') or  (S[i]='7') or
    (S[i]='8') or (S[i]='9'));
   IsNaturalS:=TempB
  end;




 function MWC(S : string; WordDelims : CharSet) : Integer;
   var sl: TStringList;
  begin
    sl := TStringList.Create;
    MWC:=ExtractStrings(WordDelims, [], PChar(S), sl);
    sl.Destroy;
  end;

 function MEW(N : Integer; S : string; WordDelims : CharSet) : string;
  var sl: TStringList;
      N1:Integer;
 begin
   sl := TStringList.Create;
   N1:=ExtractStrings(WordDelims, [], PChar(S), sl);
   MEW:=sl.Strings[N-1];
   sl.Destroy;
 end;

 // строка длиной не более N, разбитая по словам, разделенным WordDelims
 // WD : string; WordDelims: CharSet - дуюлируют, т.к. не знаю перевод из CharSet d String;
 function StringNoMore(S, WD : string; WordDelims : CharSet; N : Integer; var RestOfStrung:String):string;
   var sl: TStringList;
       i, NWord:Integer;
       Sc, S1: String;
  begin
    sl := TStringList.Create;
    NWord:=ExtractStrings(WordDelims, [], PChar(S), sl);
    Sc:='';
    For i:=1 to NWord do
     begin
      S1:=sl.Strings[i-1];
      If UTF8Length(Sc+S1)<=N
       then Sc:=Sc+S1+WD
       else Break;
     end;
    Sc:=Trim(Sc);
//    RestOfStrung:=UTF8StringReplace(S,Sc,'',[]);
    RestOfStrung:=StringReplace(S,Sc,'',[]);
    StringNoMore:=Sc;
    sl.Destroy;
  end;
  
 function MEL2(N : Integer; const S : string; WordDelims : CharSet) : Integer;
    //-Given a set of word delimiters, return the N'th word in S
  Var TempS:String;
    var sl: TStringList;
        N1, Data, Code :Integer;
        Temp:extended;
        Sextr: String;
   begin
     sl := TStringList.Create;
     N1:=ExtractStrings(WordDelims, [], PChar(S), sl);
     Sextr:=Trim(sl.Strings[N-1]);
     sl.Destroy;
     Val(Sextr,Temp,Code);
     // if Code=0 then MEL2:=Round(Temp);
     MEL2:=StrToInt(Sextr);
  end;   //--------function

 function MER2(N : Integer; const S : string; WordDelims : CharSet) : extended;
  Var TempS:String;  Code:Integer;
    var sl: TStringList;
        N1, Data :Integer;
        Sextr: String;
        Temp:Extended;
   begin
     sl := TStringList.Create;
     N1:=ExtractStrings(WordDelims, [], PChar(S), sl);
     Sextr:=sl.Strings[N-1];
     sl.Destroy;
     Val(Sextr,Temp,Code);
     if Code=0 then MER2:=Temp;
  end;   //--------function



 // строка разбивается на строки длиной не более N , после которых - Возврат Краетки и Перевод Строки
 // WD : string; WordDelims: CharSet - дублируют, т.к. не знаю перевод из CharSet в String;
 function StringNoMore2(S, WD : string; WordDelims : CharSet; N : Integer):string;
 var sl: TStringList;
     i,j, NWord:Integer;
     Sc, S1: String;
begin
  sl := TStringList.Create;
  NWord:=ExtractStrings(WordDelims, [], PChar(S), sl);
  Sc:='';
  j:=1;
  For i:=1 to NWord do
   begin
    S1:=sl.Strings[i-1];
    If UTF8Length(Sc+S1)<=N*j
     then Sc:=Sc+S1+WD
     else
       begin
        Inc(j);
        Sc:=Sc+S1+Chr(13)+Chr(10);
       end;
   end;
  Sc:=Trim(Sc);
//    RestOfStrung:=UTF8StringReplace(S,Sc,'',[]);
  StringNoMore2:=Sc;
  sl.Destroy;
end;


 Function    PackReal(X,Y:Extended;rpw,rpp:Integer):String;
   Var TempS1:String;
  begin
//           TempS1:=GDFuF(X,Len)+','+GDFuF(Y,Len);
   TempS1:=RS('.',',',FloatToStrF(X,ffFixed,rpw,rpp))+','+
           RS('.',',',FloatToStrF(Y,ffFixed,rpw,rpp));
   PackReal:='('+TempS1+')';
  end;

 Procedure UnPackReal(S:String;Var X,Y:Extended);
  begin
   S:=RS('','(',S);
   S:=RS('',')',S);
   X:=MER2(1,S,CD);
   Y:=MER2(2,S,CD);
  end;

 Function SWLZ(w,NumNul : Word) : String;
   Var I:LongInt;Var EmptyString:String;
    begin
     Str(w,EmptyString);
     If Length(EmptyString)>NumNul
      then
       begin
        SWLZ := EmptyString;
        exit;
       end;
     I:=NumNul-Length(EmptyString);
     if i>0 then
             while I>0 do
              begin
               EmptyString := '0' + EmptyString;
               Dec(i);
              end;
     SWLZ := EmptyString;
    end;


 Procedure RT2(var S:String); //------- Замена tab=Chr(9) на пробел
 Var T:String;
begin
//   RS:=AnsiReplaceText(S, SubstrOld, SubstrNew);
 T:=AnsiReplaceText(S,Chr(9),' ');
 S:=T;
end;

 Function RT(S:String):String; //------- Замена tab=Chr(9) на пробел
     Var T:String;
    begin
 //   RS:=AnsiReplaceText(S, SubstrOld, SubstrNew);
     T:=AnsiReplaceText(S,Chr(9),' ');
     RT:=T;
    end;

 Function RS(SubstrNew,SubstrOld, s : string): string;
 Var T:String;
  begin
   T:=AnsiReplaceText(S,SubstrOld,SubstrNew);
   RS:=T;
  end;

 Function AUC(S:String):String;
   begin
    AUC:=AnsiUpperCase(S);
   end;

 Function Pos_AntiCase(SubS,S:String):Byte;
   Var p,Count:Byte;
       SubS1,S1:String;
  begin {- Function -}
    SubS1:=AUC(SubS);
    S1:=AUC(S);
    Count:=0;
    repeat
        p:=Pos(SubS1,S1);
        Inc(Count);
        Delete(S1,1,p);
    until p=0;
    Dec(Count);
    Pos_AntiCase:=Count;
   end; {- Function -}

 Function    PR(X,Y:Extended;rpw,rpp:Integer):String;
  begin
   PR:=PackReal(X,Y,rpw,rpp);
  end;

 {---------------------------------------------------------------------------}
end.
