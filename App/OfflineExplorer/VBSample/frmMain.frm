VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmMain 
   Caption         =   "OLE Automation sample (Visual Basic)"
   ClientHeight    =   6525
   ClientLeft      =   1740
   ClientTop       =   2160
   ClientWidth     =   9840
   LinkTopic       =   "Form1"
   ScaleHeight     =   6525
   ScaleMode       =   0  'User
   ScaleWidth      =   9960
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   5880
      Top             =   2400
   End
   Begin VB.CommandButton btnStop 
      Caption         =   "Stop"
      Enabled         =   0   'False
      Height          =   375
      Left            =   6960
      TabIndex        =   9
      Top             =   1680
      Width           =   1335
   End
   Begin VB.CommandButton btnStart 
      Caption         =   "Start"
      Enabled         =   0   'False
      Height          =   375
      Left            =   5400
      TabIndex        =   8
      Top             =   1680
      Width           =   1335
   End
   Begin VB.ListBox List 
      Height          =   2010
      ItemData        =   "frmMain.frx":0000
      Left            =   120
      List            =   "frmMain.frx":0002
      TabIndex        =   4
      Top             =   4440
      Width           =   9615
   End
   Begin MSComctlLib.TreeView Tree 
      Height          =   3615
      Left            =   120
      TabIndex        =   3
      Top             =   600
      Width           =   5175
      _ExtentX        =   9128
      _ExtentY        =   6376
      _Version        =   393217
      HideSelection   =   0   'False
      LineStyle       =   1
      Style           =   7
      Appearance      =   1
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Destroy"
      Height          =   375
      Left            =   8400
      TabIndex        =   2
      Top             =   120
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Set persistent"
      Height          =   375
      Left            =   1440
      TabIndex        =   1
      Top             =   120
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Load OE"
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1095
   End
   Begin VB.Label Label3 
      Caption         =   "Level: "
      Height          =   255
      Left            =   5400
      TabIndex        =   7
      Top             =   1200
      Width           =   4335
   End
   Begin VB.Label Label2 
      Caption         =   "URL: "
      Height          =   495
      Left            =   5400
      TabIndex        =   6
      Top             =   600
      Width           =   4335
   End
   Begin VB.Label Label1 
      Caption         =   "Version:"
      Height          =   255
      Left            =   2760
      TabIndex        =   5
      Top             =   240
      Width           =   5535
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuFileExit 
         Caption         =   "E&xit"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim OE As New MainOE

Private Sub btnStart_Click()
  Dim V1 As OEProject
  
  If Tree.SelectedItem.Tag > 0 Then
    Set V1 = OE.GetProjectByIID(Tree.SelectedItem.Tag)
    V1.Start
  End If
End Sub

Private Sub btnStop_Click()
  Dim V1 As OEProject
  
  If Tree.SelectedItem.Tag > 0 Then
    Set V1 = OE.GetProjectByIID(Tree.SelectedItem.Tag)
    V1.Stop
  End If
End Sub

Private Sub Command1_Click()
  Dim Cnt As Integer
  Dim V As OEFolder
  Dim Nod As Node
  Dim V1 As OEProject
  Dim V2 As OEFolder
  Dim N1 As Node
  
  Label1.Caption = "Version: " + OE.Version
  Cnt = OE.FoldersCount
  For i = 0 To Cnt - 1
    Set V = OE.GetFolder(i)
    Set Nod = Tree.Nodes.Add(, , "N" & CStr(i), V.Caption)
    Nod.Tag = 0
    For j = 0 To V.ItemsCount - 1
      If V.ItemType(j) = OECT_Folder Then
        Set V2 = V.GetItem(j)
        Set N1 = Tree.Nodes.Add("N" & CStr(i), tvwChild, , V2.Caption)
        N1.Tag = 0
      Else
        Set V1 = V.GetItem(j)
        Set N1 = Tree.Nodes.Add("N" & CStr(i), tvwChild, , V1.Caption)
        N1.Tag = V1.IID
      End If
    Next
  Next
  Timer1.Enabled = True
End Sub

Private Sub Command2_Click()
  OE.Persistent = 1
End Sub

Private Sub Command3_Click()
  Timer1.Enabled = False
  Set OE = Nothing
End Sub

Private Sub Form_Load()
    'Me.Left = GetSetting(App.Title, "Settings", "MainLeft", 1000)
    'Me.Top = GetSetting(App.Title, "Settings", "MainTop", 1000)
    'Me.Width = GetSetting(App.Title, "Settings", "MainWidth", 6500)
    'Me.Height = GetSetting(App.Title, "Settings", "MainHeight", 6500)
End Sub


Private Sub Form_Unload(Cancel As Integer)
    Dim i As Integer


    'close all sub forms
    For i = Forms.Count - 1 To 1 Step -1
        Unload Forms(i)
    Next
    If Me.WindowState <> vbMinimized Then
        SaveSetting App.Title, "Settings", "MainLeft", Me.Left
        SaveSetting App.Title, "Settings", "MainTop", Me.Top
        SaveSetting App.Title, "Settings", "MainWidth", Me.Width
        SaveSetting App.Title, "Settings", "MainHeight", Me.Height
    End If
End Sub


Private Sub mnuFileExit_Click()
    'unload the form
    Unload Me

End Sub

Private Sub Timer1_Timer()
  Dim Cnt As Integer
  Dim V As OEConnection
  
  Cnt = OE.ConnectionsCount
  For i = 0 To Cnt - 1
    Set V = OE.Connection(i)
    If List.ListCount > i Then
      List.List(i) = "HTTP" & CStr(i) & ": " & V.MessageText
    Else
      List.AddItem ("HTTP" & CStr(i) & ": " & V.MessageText)
    End If
  Next
End Sub

Private Sub Tree_NodeClick(ByVal Node As MSComctlLib.Node)
  Dim V1 As OEProject
  
  btnStart.Enabled = False
  btnStop.Enabled = False
  If Node.Tag > 0 Then
    Set V1 = OE.GetProjectByIID(Node.Tag)
    Label2.Caption = "URL: " + V1.URL
    Label3.Caption = "Level: " & CStr(V1.Level)
    btnStart.Enabled = True
    btnStop.Enabled = True
  End If
End Sub
