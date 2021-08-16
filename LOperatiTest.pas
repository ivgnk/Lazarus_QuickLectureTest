Unit LOperatiTest;
{-------------------------------------------------------------------}
                            INTERFACE
{-------------------------------------------------------------------}
 Uses
   Forms, SysUtils, FileUtil, Messages, LazUtf8, Dialogs, classes,
   extctrls, graphics, LazFileUtils,
   LStringsN;

Type
 TSudent=record
           Name:String;
           Tested:Boolean;
           Ball:Integer;
 end;


Var
 WorkDir, NameQF, NameSF :String;
 NumStudents, NumQuestions,
 CurrStudent, CurrWStudent, CurrBall : Integer;
 IsInputQ, IsInputS:boolean;


 TheStudents: Array of TSudent;
 TheQuestions: Array of TSudent;

Function OpenQuestionsDialog:Boolean;
Procedure TheOpenQuestions;
Procedure OpenQuestions(FName:String);

Function OpenStudentsDialog:Boolean;
Procedure TheOpenStudentsList;
Procedure OpenStudentsList(FName:String);

Procedure TheWork;
Procedure ResultView;
Procedure ResultOut;

Procedure GetStudent (n:integer; var st:String; var currw: integer);
Procedure GetQuestion(n:integer; var qe:String);

{-------------------------------------------------------------------}
                          IMPLEMENTATION
{-------------------------------------------------------------------}
 Uses Unit1 ;
//   Var   LogFile:TextFile;


 Function OpenQuestionsDialog:Boolean;
  Var SavDir, FiniN1:String;
         TempB:Boolean;
  begin
    GetDir(0,SavDir);
    WorkDir:=SavDir;
    Form1.OpenDialog1Qstns.InitialDir:=SavDir;
    TempB:=Form1.OpenDialog1Qstns.Execute;
    If  TempB then
     begin //--------If TempB
      FiniN1:=Form1.OpenDialog1Qstns.FileName;
      NameQF:=ExtractFileName(FiniN1);
      Form1.StatusBar1.Panels[0].Text:=NameQF;
      OpenQuestions(FiniN1);
      IsInputQ:=True;
     end;  //--------If TempB
   OpenQuestionsDialog:=TempB;
  end;

 Function OpenStudentsDialog:Boolean;
   Var SavDir, FiniN1:String;
         TempB:Boolean;
  begin
    GetDir(0,SavDir);
    WorkDir:=SavDir;
    Form1.OpenDialog2Stdnts.InitialDir:=SavDir;
    TempB:=Form1.OpenDialog2Stdnts.Execute;
    If  TempB then
     begin //--------If TempB
      FiniN1:=Form1.OpenDialog2Stdnts.FileName;
      NameSF:=ExtractFileName(FiniN1);
      Form1.StatusBar1.Panels[1].Text:=NameSF;
//    Form1.Label2Stdnts.Caption:=NameSF;
      OpenStudentsList(FiniN1);
      IsInputS:=True;
     end;  //--------If TempB
   OpenStudentsDialog:=TempB;
  end;

 Procedure TheOpenQuestions;
  begin
   OpenQuestionsDialog
  end;

 Procedure OpenQuestions(FName:String);
   Var
    i:integer;
    FT:TextFile;
    list : TStringList;
   begin
    list := TstringList.Create;
    list.LoadFromFile(FName);
    NumQuestions:=list.count;
    list.free;
    SetLength(TheQuestions,NumQuestions+1);
    AssignFile(FT,FName);
    Reset(FT);
    For i:=1 to NumQuestions do
     begin
      Readln(FT, TheQuestions[i].Name);
      TheQuestions[i].Tested:=False;
     end;
    CloseFile(FT);
  end;

 Procedure TheOpenStudentsList;
  begin
   OpenStudentsDialog;
   CurrStudent:=0;
   Randomize;
//   AssignFile(LogFile,'C:\tem.txt');
//   Rewrite(LogFile);
  end;

  Procedure OpenStudentsList(FName:String);
   Var
    i:integer;
    FT:TextFile;
    list : TStringList;
   begin
//    NumStudents:=NumLineInTextFnotSp(FName);
    list := TstringList.Create;
    list.LoadFromFile(FName);
    NumStudents:=list.count;
    list.free;

    SetLength(TheStudents,NumStudents+1);
    AssignFile(FT,FName);
    Reset(FT);
    For i:=1 to NumStudents do
     begin
      Readln(FT, TheStudents[i].Name);
      TheStudents[i].Ball:=0;
      TheStudents[i].Tested:=False;
     end;
    CloseFile(FT);
   end;


 Procedure TheWork;
   Const
     NMax=23;
   Var St, Qu, Qu1, S: String;
       RestOfStrung:String;
       i:integer;
  begin
    If not IsInputQ  then      begin
        MessageDlg ('Вопросы не введены',mtInformation,[mbOk], 0);        Exit;
      end;
  If not IsInputS  then    begin
      MessageDlg ('Список студентов не введен',mtInformation,[mbOk], 0);      Exit;
     end;
    i:=1;
    If CurrStudent<NumStudents
     then
       begin //--------------
     Inc(CurrStudent);
     CurrBall:=0;
     GetStudent(CurrStudent,St,CurrWStudent);
     GetQuestion(CurrStudent,Qu);
     Qu1:=Qu;
     Form1.Label3WSt.Caption:=WinCPToUTF8(St);
     Form1.Label3WSt.Font.Color:=clRed;
     Form1.Label3WSt.Font.Size:=35;


     If Utf8Length(Qu) > NMax
       then
         begin
//       S:=StringNoMore(Qu,' ',WD, NMax , RestOfStrung);
//       S:=S+Chr(13)+Chr(10)+RestOfStrung;
       S:=StringNoMore2(Qu,' ',WD, NMax);
       S:=WinCPToUTF8(S);
//     '1'+Chr(13)+Chr(10)+
//       S:='Qu';
         end
       else S:=WinCPToUTF8(Qu);
//     Writeln(LogFile,CurrStudent:2,' ',S);
     Form1.Label4WQ.Caption :=S;
     Form1.Label4WQ.Font.Color:=clGreen;
     Form1.Label4WQ.Font.Size:=30;
//     Form1.Label5N.Caption:=IntToStr(CurrStudent)+' / '+IntToStr(NumStudents);
     Form1.StatusBar1.Panels[2].Text:=IntToStr(CurrStudent)+' / '+IntToStr(NumStudents);
//     Writeln(LogFile,CurrStudent,' ',Qu1);
       end  //--------------
    else
     begin
       MessageDlg (('Тестирование окончено'),mtInformation,[mbOk], 0);
       ResultOut;  // WinCPToUTF8
       Form1.StatusBar1.Panels[0].Text:='';
       Form1.StatusBar1.Panels[1].Text:='';
//     Form1.Label2Stdnts.Caption:='';
       Form1.Label3WSt.Caption:='';
       Form1.Label4WQ.Caption:='';
       Form1.StatusBar1.Panels[2].Text:='';
       IsInputQ:=False;
       IsInputS:=False;
       ResultView;
//       CloseFile(LogFile);
     end;
  end;

 Procedure ResultOut;
   Var FT, FT2:TextFile;
       i,p:Integer; S,S2,S3,S4,DateS:String;
       dt: TDateTime;
  begin
   dt:= Date;
   DateS:=FormatDateTime('YYYY-MM-DD',dt);
   p:=2;
   S3:=ExtractFileNameOnly(NameQF);
   S4:=ExtractFileNameOnly(NameSF);
    S:=WorkDir+'\'+S3+'-'+S4+'_res.dat';
//   S2:=   'd:'+'\'+S3+DateS+'_res.dat';
   AssignFile(FT,S);   // AssignFile(FT2,S2);
   Rewrite(FT);        //    Rewrite(FT2);
   For i:=1 to NumStudents do
     begin
      Writeln(FT ,TheStudents[i].Name,'  ',TheStudents[i].Ball:p);
//      Writeln(FT2,TheStudents[i].Name,'  ',TheStudents[i].Ball:p);
     end;
   CloseFile(FT);
//   CloseFile(FT2);
  end;

  Procedure ResultView;
    Var i:integer;
        fmt,S,S2,S3:string;
   begin
    S:='';
    fmt:='%0:-39s';
    For i:=1 to NumStudents do
      begin
       S3:=TheStudents[i].Name;
       S2:=Format(fmt,[S3]);
       S:=S+WinCPToUTF8(S2)+'  '+IntToStr(TheStudents[i].Ball)+Chr(13)+Chr(10);
      end;
    MessageDlg ( S ,  mtInformation , [mbOk] , 0 ) ;
   end;

 Procedure GetStudent (n:integer; var st:String; var currw: integer);
   Label 1;
   Var i:integer;
  begin
   1:
    i:=Random(NumStudents)+1;
    If TheStudents[i].Tested then goto 1;
    TheStudents[i].Tested:=True;

    st:=TheStudents[i].Name;
    currw:=i
  end;

Procedure GetQuestion(n:integer; var qe:String);
 Label 1;
   Var i:integer;
 begin
  1:
   i:=Random(NumQuestions)+1;
   If TheQuestions[i].Tested then goto 1;
   TheQuestions[i].Tested:=True;
   qe:=TheQuestions[i].Name;
 end;

begin
//  AssignFile(LogFile,'D:\1.txt');
//  Rewrite(LogFile);
end.
