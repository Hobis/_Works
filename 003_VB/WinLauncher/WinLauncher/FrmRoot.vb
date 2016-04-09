Imports System
Imports System.IO
Imports System.Windows.Forms
Imports System.Xml
Imports Microsoft.VisualBasic


' ##
Public NotInheritable Class FrmRoot

#Region ">>>>>>>> MainInits"
    ' :: 생성자
    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
    End Sub

    ' ::
    Private Sub p_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Me.Text = MConfig.GetTitleText()
        '
        MConfig.SetFrmRoot(Me)
        '
        _FlaRoot.Menu = False
        _FlaRoot.TabStop = False
        _FlaRoot.LoadMovie(0, Path.Combine(Application.StartupPath, "FlaRoot.swf"))
        AddHandler _FlaRoot.FlashCall, AddressOf p_Frm_CallBack
        '
        _FrmSub = New FrmSub()
        '_FrmSub.ShowInTaskbar = False
    End Sub
    Private _FrmSub As FrmSub = Nothing

    ' ::
    Private Sub p_FrmSubOpen(lns As String)
        Me.Hide()

        MConfig.NowLesson = " - " & lns & " 차시"
        _FrmSub.fOpen(Me, Path.Combine(Application.StartupPath, "root/" & lns & ".html"))

        'MConfig.NowLesson = " - 1차시 " & lessonStr
        '_FrmSub.fOpen(Me, "http://stackoverflow.com/questions/8135051/notify-modal-forms-parent-that-it-needs-to-action-something")
        Me.Show()
    End Sub

    ' ::
    Private Function p_FlaObj_IsArgsEmpty(xargs As XmlNodeList) As Boolean
        If (xargs IsNot Nothing) AndAlso (xargs.Count > 0) Then
            Return False
        Else
            Return True
        End If
    End Function

    ' ::
    Private Sub p_Frm_CallBack(sender As Object, e As AxShockwaveFlashObjects._IShockwaveFlashEvents_FlashCallEvent)
        Dim t_xd As XmlDocument = New XmlDocument()
        t_xd.LoadXml(e.request)

        Dim t_xac As XmlAttributeCollection = t_xd.FirstChild.Attributes
        Dim t_cn As String = t_xac.GetNamedItem("name").InnerText
        Dim t_xarg As XmlNode = t_xd.FirstChild
        Dim t_xarr As XmlNode = t_xarg.FirstChild
        Dim t_xprops As XmlNodeList = t_xarr.FirstChild.ChildNodes

        '
        '<invoke name="Frm_IsAwaysTop" returntype="xml">
        '	<arguments>
        '		<array>
        '			<property id="0">
        '				<string>1111</string>
        '			</property>
        '			<property id="1">
        '				<string>2222</string>
        '			</property>
        '			<property id="2">
        '				<true />
        '			</property>
        '		</array>
        '	</arguments>
        '</invoke>
        Select Case t_cn
            Case "Frm_Init"

            Case "Frm_Alert"
                If Not p_FlaObj_IsArgsEmpty(t_xprops) Then
                    MUtils.fMsgBox(Me, t_xprops(0).InnerText)
                End If

            Case "Frm_LessonOpen"
                If Not p_FlaObj_IsArgsEmpty(t_xprops) Then
                    p_FrmSubOpen(t_xprops(0).InnerText)
                End If

        End Select
    End Sub

#End Region

End Class

