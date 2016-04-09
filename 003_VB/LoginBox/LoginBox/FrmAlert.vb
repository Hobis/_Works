Imports System
Imports System.Windows.Forms

Public NotInheritable Class FrmAlert
    Public Sub New()
        ' This call is required by the designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
    End Sub

    Private _Owner As FrmRoot = Nothing
    Public Sub SetOwner(o As FrmRoot)
        _Owner = o
    End Sub

    Private Sub p_Load(sender As Object, e As System.EventArgs) Handles MyBase.Load
        Me.Text = "Alert~~!!"
    End Sub

    Public Sub fShow(msg As String)
        Me.TextBox1.Text = msg
        Me.ShowDialog(_Owner)
    End Sub

    Private Sub p_Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Me.TextBox1.Clear()
        Me.Close()
    End Sub
End Class