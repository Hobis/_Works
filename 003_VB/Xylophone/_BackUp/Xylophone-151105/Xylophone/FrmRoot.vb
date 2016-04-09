Imports System.IO
Imports System.Xml


Public NotInheritable Class FrmRoot

    ' ::
    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub


#Region "Case Init's"

    ' ::
    Private Sub p_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Me.Text = "Xylophone Ver 1.05"

        Dim t_url As String = Path.Combine(Application.StartupPath, "FlaRoot.swf")
        Me.flaRoot.LoadMovie(0, t_url)
        Me.flaRoot.Menu = False
        AddHandler Me.flaRoot.FlashCall, AddressOf p_Frm_CallBack

        Dim t_sb As Rectangle = Screen.PrimaryScreen.Bounds
        Dim t_ws As Size = Me.Size
        Dim t_lp As Point = New Point(t_sb.Width, t_sb.Height)
        t_lp.Offset(-(t_ws.Width + 40), -(t_ws.Height + 80))
        Me.Location = t_lp


        '//    this.flaObj.CallFunction
        '//    (
        '//        "<invoke name=\"Fla_TimeLoop\" returntype=\"xml\">" +
        '//            "<arguments>" +
        '//                "<string>" + t_v + "</string>" +
        '//            "</arguments>" +
        '//        "</invoke>"
        '//    );
        Dim t_xmlStr As String = p_XmlStrLoad()
        Try
            Dim t_callStr As String = _
                "<invoke name=""Fla_Init"" returntype=""xml"">" & _
                    "<arguments>" & _
                        "<string>" & t_xmlStr & "</string>" & _
                    "</arguments>" & _
                "</invoke>"
            Me.flaRoot.CallFunction(t_callStr)
        Catch
        End Try

    End Sub

    ' ::
    Private Function p_XmlStrLoad()
        Dim t_xd As XmlDocument = New XmlDocument()
        Dim t_url As String = Path.Combine(Application.StartupPath, "Data")
        t_url = Path.Combine(t_url, "Default.xml")
        t_xd.Load(t_url)
        Return t_xd.InnerXml
    End Function

#End Region


    ' ::
    Private Function p_flaObj_IsArgsEmpty(xargs As XmlNodeList) As Boolean
        If ((xargs IsNot Nothing) AndAlso (xargs.Count > 0)) Then
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
            Case "Frm_Exit"
                Application.Exit()

            Case "Frm_IsAwaysTop"
                If (Not p_flaObj_IsArgsEmpty(t_xprops)) Then
                    Dim t_v As String = t_xprops(0).InnerXml
                    If (t_v.IndexOf("<true />") > -1) Then
                        Me.TopMost = True
                    Else
                        Me.TopMost = False
                    End If
                End If
                'MessageBox.Show(t_xarg.InnerXml)
                'MessageBox.Show(t_xarr.InnerXml)
                'MessageBox.Show(t_xprops.Count)

        End Select
    End Sub

End Class
