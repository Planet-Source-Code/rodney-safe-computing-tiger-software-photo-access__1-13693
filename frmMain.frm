VERSION 5.00
Object = "{34F97535-D255-11D4-9505-0050DA35D4A9}#3.0#0"; "Photo.ocx"
Begin VB.Form frmMain 
   BackColor       =   &H8000000A&
   Caption         =   "Photo Access Test Application"
   ClientHeight    =   3105
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6630
   LinkTopic       =   "Form1"
   ScaleHeight     =   3105
   ScaleWidth      =   6630
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox txtName 
      Height          =   315
      Left            =   990
      TabIndex        =   5
      Text            =   "Combo1"
      Top             =   450
      Width           =   2355
   End
   Begin proPhoto.Photo Photo1 
      Height          =   2715
      Left            =   3915
      TabIndex        =   4
      Top             =   315
      Width           =   2670
      _ExtentX        =   4710
      _ExtentY        =   4789
      BorderColor     =   9
      BorderColor     =   9
      BackStyle       =   0
   End
   Begin VB.CommandButton cmdOpenPhoto 
      Caption         =   "..."
      Height          =   375
      Left            =   3375
      TabIndex        =   3
      Top             =   450
      Width           =   375
   End
   Begin VB.CommandButton cmdRetrieve 
      Caption         =   "Retrieve"
      Height          =   420
      Left            =   945
      TabIndex        =   2
      Top             =   1530
      Width           =   1050
   End
   Begin VB.CommandButton cmdSave 
      Caption         =   "Save"
      Height          =   420
      Left            =   2070
      TabIndex        =   1
      Top             =   1530
      Width           =   1050
   End
   Begin VB.Label Label1 
      Caption         =   "Name"
      Height          =   330
      Left            =   135
      TabIndex        =   0
      Top             =   450
      Width           =   735
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Rs As New ADODB.Recordset
Dim Con As New ADODB.Connection

Private Sub cmdOpenPhoto_Click()
Photo1.OpenPhotoFile
End Sub

Private Sub cmdRetrieve_Click()
Dim Rs As New ADODB.Recordset
Rs.Open "Select * from tblPhoto where name='" & txtName & "'", Con, adOpenKeyset, adLockOptimistic
Do While Not Rs.EOF
    If Len(Rs!photo) > 0 Then Photo1.LoadPhoto Rs!photo 'Load the saved photo iamge from the database
Rs.MoveNext
Loop
Rs.Close
Fillup txtName.ListIndex
End Sub

Private Sub cmdSave_Click()

Dim Rs As New ADODB.Recordset
Rs.Open "Select * from tblPhoto where name='" & txtName & "'", Con, adOpenKeyset, adLockOptimistic
Rs.AddNew
Rs!Name = txtName
Photo1.SavePhoto Rs!photo  'Save the photo iamge to the database
Rs.Update
Rs.Close
End Sub

Private Sub Form_Load()
 Con.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & App.Path & "\Photo.mdb" & ";Jet OLEDB:Database Password=admin"
 Con.Open
 Fillup
End Sub

Sub Fillup(Optional I As Integer)

txtName.Clear

Rs.Open "Select * from tblPhoto", Con, adOpenKeyset, adLockOptimistic
Do While Not Rs.EOF
    txtName.AddItem Rs!Name
Rs.MoveNext
Loop
Rs.Close
If I < txtName.ListIndex Then txtName.ListIndex = I
End Sub

