Imports System.IO
Imports System.Threading
Imports System.Xml

Public NotInheritable Class FrmRoot

    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        p_Init()
    End Sub

    Private Sub p_Init()
    End Sub

    Private Const _TitleName = "Transactor"
    Private Sub p_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Me.Text = _TitleName & " Ver 1.02"

        Me.Txb1.TabStop = False
        Me.FlaRoot.Menu = False
        Me.FlaRoot.LoadMovie(0, Path.Combine(Application.StartupPath, "FlaRoot.swf"))
        AddHandler Me.FlaRoot.FlashCall, AddressOf p_Frm_CallBack
        p_DgvSetting()
    End Sub

    ' ::
    Private Function p_FlaObj_IsArgsEmpty(xargs As XmlNodeList) As Boolean
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
                If (MessageBox.Show(Me, "정말로 닫을껴?", _TitleName, _
                                    MessageBoxButtons.YesNo).Equals(DialogResult.Yes)) Then
                    Application.Exit()
                End If

            Case "Frm_Listing"
                p_GoGo_Listing(True)

            Case "Frm_Clear"
                p_GoGo_Listing(False)

        End Select
    End Sub

    ' ::
    Private Sub p_ResultLog(v As String)
        If (Me.Txb1.Lines.Length() > 100) Then
            Me.Txb1.Clear()
        End If
        Me.Txb1.AppendText(v & vbNewLine)
        Me.Txb1.SelectionStart = Me.Txb1.Text.Length
        Me.Txb1.ScrollToCaret()
    End Sub

    ' ::
    Private Sub p_GoGo_Listing(b As Boolean)
        Me.Pnl1.Enabled = False
        If (_SWatch Is Nothing) Then
            _SWatch = New Stopwatch()
        End If
        _SWatch.Reset()
        '
        _RCalling.BeginInvoke(b, Nothing, Nothing)
    End Sub

    Private _SWatch As Stopwatch = Nothing

    ' ::
    Private Delegate Sub CallingInvoker(b As Boolean)
    Private _RCalling As CallingInvoker = _
        Sub(b As Boolean)
            If (b) Then
                _SWatch.Start()
                p_DgvListing()
                _SWatch.Stop()
                'DateTime.Now.ToString("yyMMddHHmmss")
                p_ResultLog(String.Format("# 목록리스팅(시작: {0}, 소요: {1}ms)", _
                                          DateTime.Now.ToString("HHmmss"), _
                                          _SWatch.ElapsedMilliseconds.ToString()))
            Else
                _SWatch.Start()
                p_DgvClear()
                _SWatch.Stop()
                p_ResultLog(String.Format("# 목록클리어(시작: {0}, 소요: {1}ms)", _
                                          DateTime.Now.ToString("HHmmss"), _
                                          _SWatch.ElapsedMilliseconds.ToString()))
            End If
            '
            Me.Pnl1.Enabled = True
        End Sub

    ' ::
    Private Sub p_DgvSetting()
        Me.Dgv1.ColumnCount = 5
        Me.Dgv1.ColumnHeadersVisible = True
        '
        Dim t_dgvcs As DataGridViewCellStyle = New DataGridViewCellStyle()
        t_dgvcs.BackColor = Color.Beige
        t_dgvcs.Font = New Font("Verdana", 8, FontStyle.Bold)
        Me.Dgv1.ColumnHeadersDefaultCellStyle = t_dgvcs
        Me.Dgv1.Columns(0).Name = "게임명"
        Me.Dgv1.Columns(1).Name = "퍼블리셔"
        Me.Dgv1.Columns(2).Name = "제작사"
        Me.Dgv1.Columns(3).Name = "출시일"
        Me.Dgv1.Columns(4).Name = "플랫폼"
        '
        Me.Dgv1.AutoResizeColumns()
        Me.Dgv1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.None
    End Sub

    ' ::
    Private Sub p_DgvListing()
        For i As Integer = 0 To 300
            Me.Dgv1.Rows.Add(New String() {"바이오하자드 5", "Capcom", "Capcom Japan", "2008/02/16", "PS3, PS4, XBOX360, PC-Steam"})
        Next
        Me.Dgv1.AutoResizeColumns()
        Me.Dgv1.PerformLayout()
    End Sub

    Private Sub p_DgvClear()
        Me.Dgv1.Rows.Clear()
        Me.Dgv1.DataSource = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

End Class
