Imports System
Imports System.Drawing
Imports System.IO
Imports System.Windows.Forms
Imports Microsoft.VisualBasic


' ##
Public NotInheritable Class FrmSub

    ' ::
    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        'Me.Text = MConfig.GetTitleName() & MConfig.NowLesson
        '
        _WebBrowser1.ObjectForScripting = Me
        _WebBrowser1.IsWebBrowserContextMenuEnabled = False
        _WebBrowser1.AllowWebBrowserDrop = False
        _WebBrowser1.ScrollBarsEnabled = False
        _WebBrowser1.ScriptErrorsSuppressed = True
        _WebBrowser1.WebBrowserShortcutsEnabled = False
        AddHandler _WebBrowser1.PreviewKeyDown, AddressOf p_WebBrowser1_PreviewKeyDown
    End Sub

    ' ::
    Private Sub p_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        '
        Me.Text = MConfig.GetTitleName() & MConfig.NowLesson
    End Sub

    ' ::
    Private Sub p_Shown(sender As Object, e As EventArgs) Handles MyBase.Shown
        'p_SetFullScreen(True)
    End Sub

    ' ::
    Private Sub p_WebBrowser1_PreviewKeyDown( _
                    ByVal sender As Object, _
                    ByVal pkdea As PreviewKeyDownEventArgs)
        '
        Select Case pkdea.KeyCode
            Case Keys.Escape
                p_SetFullScreen(False)

            Case Keys.F5
                _WebBrowser1.Refresh()

            Case Keys.F11
                p_FullScreen_Toggle()
        End Select
    End Sub

    ' ::
    Public Sub fOpen(owner As IWin32Window, url As String)
        '_WebBrowser1.Navigate("https://www.youtube.com/watch?v=PBXEmfWRock")
        _WebBrowser1.Navigate(url)
        Me.ShowDialog(owner)
    End Sub

    ' ::
    Private Sub p_FormClosing(sender As Object, e As FormClosingEventArgs) _
                                Handles MyBase.FormClosing
        '
        _WebBrowser1.Navigate("about:blank")
    End Sub


#Region ">>>>>>>> WindowFullScreen"
    Private Const _WM_SYSCOMMAND As Integer = &H112
    Private Const _SC_MAXIMIZE As Integer = &HF030
    Protected Overrides Sub WndProc(ByRef m As Message)
        If (m.Msg.Equals(_WM_SYSCOMMAND)) Then
            If (m.WParam.ToInt32().Equals(_SC_MAXIMIZE)) Then
                Me.p_FullScreen_Toggle()
                Exit Sub
            End If
        End If
        '
        MyBase.WndProc(m)
    End Sub

    ' ::
    Private Sub p_FullScreen_Toggle()
        If (Me.TopMost) Then
            Me.p_SetFullScreen(False)
        Else
            Me.p_SetFullScreen(True)
        End If
    End Sub

    ' -
    Private _tempSize As Size = Size.Empty
    ' ::
    Private Sub p_SetFullScreen(ByVal b As Boolean)
        If (b) Then
            If (Not Me.TopMost) Then
                Me.TopMost = True
                Me._tempSize = Me.Size
                Me.FormBorderStyle = FormBorderStyle.None
                Me.WindowState = FormWindowState.Maximized
            End If
        Else
            If (Me.TopMost) Then
                Me.TopMost = False
                Me.WindowState = FormWindowState.Normal
                Me.FormBorderStyle = FormBorderStyle.Sizable
                Me.Size = Me._tempSize
                Me._tempSize = Size.Empty
            End If
        End If
    End Sub
#End Region


End Class