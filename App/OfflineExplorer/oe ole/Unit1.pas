unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComObj, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    List: TListBox;
    Timer1: TTimer;
    Tree: TTreeView;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnStart: TButton;
    btnStop: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure TreeChange(Sender: TObject; Node: TTreeNode);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    { Private declarations }
  public
    OE: Variant;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  I  : Integer;
  J  : Integer;
  Cnt: Integer;
  N  : TTreeNode;
  V  : Variant;
  V1 : Variant;
begin
  try
    OE      := CreateOleObject('OE.MainOE');
  except
    MessageBox(Handle, 'OLE Automation object not found. Please run Offline Explorer Enterprise once to register.',
      'Error', MB_OK or MB_ICONEXCLAMATION);
    Exit;
  end;
  Caption := 'OE Automation sample: ' + OE.Version;
  Cnt     := OE.FoldersCount;
  For I := 0 to Cnt - 1 do
  begin
    V := OE.GetFolder(I);
    if not VarIsEmpty(V) then
    begin
      N := Tree.Items.Add(nil, V.Caption);
      For J := 0 to V.ItemsCount - 1 do
      begin
        V1 := V.GetItem(J);
        if V1.IType = 0 then //Project
          Tree.Items.AddChildObject(N, V1.Caption, Pointer(Integer(V1.IID)))
        else
          Tree.Items.AddChild(N, V1.Caption);
      end;
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  OE := Unassigned;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  OE.Persistent := Integer(101);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  V: Variant;
  I: Integer;
  J: Integer;
begin
  if VarIsEmpty(OE) then
    Exit;
  I := OE.ConnectionsCount;
  if I < 0 then
    Exit;
  For J := 0 to I - 1 do
  begin
    V := OE.Connection(J);
    if not VarIsEmpty(V) then
    begin
      if List.Items.Count > J then
        List.Items[J] := 'HTTP' + IntToStr(J) + ': ' + V.MessageText
      else
        List.Items.Add('HTTP' + IntToStr(J) + ': ' + V.MessageText);
    end;
  end;
end;

procedure TForm1.TreeChange(Sender: TObject; Node: TTreeNode);
var
  V: Variant;
begin
  btnStart.Enabled := False;
  btnStop.Enabled  := False;
  if Node = nil then
    Exit;
  if Node.Data <> nil then
  begin
    V := OE.GetProjectByIID(Integer(Node.Data));
    if not VarIsEmpty(V) then
    begin
      Label2.Caption   := V.URL;
      Label4.Caption   := IntToStr(V.Level);
      btnStart.Enabled := True;
      btnStop.Enabled  := True;
    end;
  end;
end;

procedure TForm1.btnStartClick(Sender: TObject);
var
  V: Variant;
begin
  if Tree.Selected = nil then
    Exit;
  if Tree.Selected.Data <> nil then
  begin
    V := OE.GetProjectByIID(Integer(Tree.Selected.Data));
    if not VarIsEmpty(V) then
      V.Start;
  end;
end;

procedure TForm1.btnStopClick(Sender: TObject);
var
  V: Variant;
begin
  if Tree.Selected = nil then
    Exit;
  if Tree.Selected.Data <> nil then
  begin
    V := OE.GetProjectByIID(Integer(Tree.Selected.Data));
    if not VarIsEmpty(V) then
      V.Stop;
  end;
end;

end.
