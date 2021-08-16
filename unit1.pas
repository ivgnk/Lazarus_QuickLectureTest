unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, ExtCtrls, Buttons, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button0: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label4WQ: TLabel;
    Label3WSt: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MFExit: TMenuItem;
    MFile: TMenuItem;
    MWork: TMenuItem;
    MenuItem3: TMenuItem;
    MFOpenQ: TMenuItem;
    MFOpenStL: TMenuItem;
    MFL: TMenuItem;
    OpenDialog2Stdnts: TOpenDialog;
    OpenDialog1Qstns: TOpenDialog;
    Panel1: TPanel;
    SB_Q: TSpeedButton;
    SB_S: TSpeedButton;
    SB_R: TSpeedButton;
    StatusBar1: TStatusBar;
    procedure Button0Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ButtonNextClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label4WQClick(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MFExitClick(Sender: TObject);
    procedure MFOpenStLClick(Sender: TObject);
    procedure MFOpenQClick(Sender: TObject);
    procedure MWorkClick(Sender: TObject);
    procedure SB_QClick(Sender: TObject);
    procedure SB_RClick(Sender: TObject);
    procedure SB_SClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
Uses LOPeratiTest, LazUtf8;

procedure TForm1.FormCreate(Sender: TObject);
begin
  IsInputQ:=False;
  IsInputS:=False;
  StatusBar1.Panels[0].Text:='';
  StatusBar1.Panels[1].Text:='';

   Label3WSt.Caption:='';
   Label4WQ.Caption :='';
   StatusBar1.Panels[0].Text:='';
   StatusBar1.Panels[1].Text:='';
   StatusBar1.Panels[2].Text:='';
end;

procedure TForm1.Label4WQClick(Sender: TObject);
begin

end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
 ResultView;
end;

procedure TForm1.Button0Click(Sender: TObject);
begin
  CurrBall:=0;
  TheStudents[CurrWStudent].Ball:=CurrBall
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  CurrBall:=1;
  TheStudents[CurrWStudent].Ball:=CurrBall
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  CurrBall:=2;
  TheStudents[CurrWStudent].Ball:=CurrBall
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 CurrBall:=3;
 TheStudents[CurrWStudent].Ball:=CurrBall
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  CurrBall:=4;
  TheStudents[CurrWStudent].Ball:=CurrBall
end;

procedure TForm1.ButtonNextClick(Sender: TObject);
begin
  TheWork;
end;

procedure TForm1.MFExitClick(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TForm1.MFOpenStLClick(Sender: TObject);
begin
 TheOpenStudentsList;
end;

procedure TForm1.MFOpenQClick(Sender: TObject);
begin
  TheOpenQuestions;
end;

procedure TForm1.MWorkClick(Sender: TObject);
begin
  TheWork
end;

procedure TForm1.SB_QClick(Sender: TObject);
begin
  TheOpenQuestions;
end;

procedure TForm1.SB_RClick(Sender: TObject);
begin
  TheWork
end;

procedure TForm1.SB_SClick(Sender: TObject);
begin
  TheOpenStudentsList;
end;

end.

