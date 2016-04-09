Imports System
Imports System.Windows.Forms
Imports Microsoft.VisualBasic


Public NotInheritable Class FrmLogin

    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub

    Private Sub p_Load(sender As Object, e As System.EventArgs) Handles MyBase.Load
        Me.Text = "관리자 로그인"
        Me.TextBox1.MaxLength = 12
        Me.TextBox2.MaxLength = 12
        Me.TextBox2.PasswordChar = "*"c
        Me.Label3.Text = "아이디/암호를 입력하세요"

        AddHandler Me.TextBox1.GotFocus, AddressOf p_TextBox1_GotFocus
        AddHandler Me.TextBox2.GotFocus, AddressOf p_TextBox1_GotFocus

        Me.KeyPreview = True
        AddHandler Me.KeyDown, AddressOf p_KeyDown
        AddHandler Me.KeyUp, AddressOf p_KeyUp
    End Sub

    Private Sub p_Button2_Click(sender As Object, e As System.EventArgs) Handles Button2.Click
        Dim t_id As String = Me.TextBox1.Text
        Dim t_pw As String = Me.TextBox2.Text

        If (String.IsNullOrEmpty(t_id) OrElse _
            String.IsNullOrEmpty(t_pw)) Then
            Beep()
            Me.TextBox1.Focus()
        Else
            If (t_id.Equals("qwe") AndAlso _
                t_pw.Equals("123")) Then
                Me.DialogResult = DialogResult.Yes
                Me.Close()
            Else
                Beep()
                Me.TextBox1.Focus()
                Me.TextBox1.SelectAll()
            End If
        End If
    End Sub

    Private Sub p_Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        Me.DialogResult = DialogResult.No
        Me.Close()
    End Sub



    Private Sub p_KeyDown(sender As Object, e As KeyEventArgs)
        If (e.KeyCode = Keys.Enter) Then
            e.SuppressKeyPress = True
        End If
    End Sub

    Private Sub p_KeyUp(sender As Object, e As KeyEventArgs)
        If (e.KeyCode = Keys.Enter) Then
            p_Button2_Click(Nothing, Nothing)
        End If
    End Sub

    Private Sub p_TextBox1_GotFocus(sender As Object, e As EventArgs)
        Dim t_tb As TextBox = DirectCast(sender, TextBox)
        If (TypeOf t_tb Is TextBox) Then
            t_tb.SelectAll()
        End If
    End Sub





End Class