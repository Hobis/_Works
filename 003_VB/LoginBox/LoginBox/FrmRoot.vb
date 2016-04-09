Imports System
Imports System.IO
Imports System.Xml
Imports Microsoft.VisualBasic
Imports System.Windows.Forms

Public NotInheritable Class FrmRoot

    ' ::
    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub

    ' ::
    Private Sub p_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Me.Text = "LoginBox  Ver 1.27"
        '
        Me.FlaRoot.Menu = False
        Me.FlaRoot.TabStop = False
        Me.FlaRoot.LoadMovie(0, Path.Combine(Application.StartupPath, "FlaRoot.swf"))
        AddHandler Me.FlaRoot.FlashCall, AddressOf p_Frm_CallBack

        p_ListView1_InitOnce()
        p_XmlInit()

        '_FrmAlert = New FrmAlert()
        '_FrmAlert.SetOwner(Me)
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
            Case "Frm_Save"
                Try
                    p_XmlSave()
                Catch ex As Exception
                    p_MsgBox(ex.ToString())
                End Try

            Case "Frm_Load"
                Try
                    p_XmlLoad()
                Catch ex As Exception
                    p_MsgBox(ex.ToString())
                End Try

            Case "Frm_Close"
                Try
                    p_XmlClose()
                Catch ex As Exception
                    p_MsgBox(ex.ToString())
                End Try

            Case "Frm_Vacate"
                Try
                    p_Vacate()
                Catch ex As Exception
                    p_MsgBox(ex.ToString())
                End Try

            Case "Frm_Del"
                Try
                    p_Del()
                Catch ex As Exception
                    p_MsgBox(ex.ToString())
                End Try

            Case "Frm_Update"
                Try
                    p_Update()
                Catch ex As Exception
                    p_MsgBox(ex.ToString())
                End Try

            Case "Frm_Add"
                Try
                    p_Add()
                Catch ex As Exception
                    p_MsgBox(ex.ToString())
                End Try

        End Select
    End Sub

    ' -
    'Private _FrmAlert As FrmAlert = Nothing
    ' ::
    Private Sub p_MsgBox(msg As String)
        'MsgBox(msg, MsgBoxStyle.OkOnly, "테스팅~!!")
        '_FrmAlert.fShow(msg)
        MMsgBox.Show(Me, msg, "테스팅~!!")
    End Sub

    ' -
    Private _XmlDoc As XmlDocument = Nothing
    ' -
    Private _XmlRoot As XmlNode = Nothing

    ' ::
    Private Sub p_XmlInit()
        Me.OpenFileDialog1.RestoreDirectory = True
        Me.OpenFileDialog1.Filter = "XmlFile|*.xml"
        Me.OpenFileDialog1.InitialDirectory = _
            My.Computer.FileSystem.CurrentDirectory & "\Data"
    End Sub

    ' ::
    Private Sub p_XmlSave()
        If (Not _XmlDoc Is Nothing) Then
            Dim t_xp As String = Me.OpenFileDialog1.FileName
            _XmlDoc.Save(t_xp)
            p_MsgBox(String.Format("{0} 저장했어요.", Path.GetFileName(t_xp)))
        Else
            p_MsgBox(String.Format("저장 할것이 없어요."))
        End If
    End Sub

    ' ::
    Private Sub p_XmlLoad()
        Dim t_dr As DialogResult = Me.OpenFileDialog1.ShowDialog(Me)
        If (t_dr = DialogResult.OK) Then
            Dim t_xp As String = Me.OpenFileDialog1.FileName
            If (File.Exists(t_xp)) Then
                _XmlDoc = New XmlDocument()
                '_XmlDoc.PreserveWhitespace = False
                _XmlDoc.Load(t_xp)
                _XmlRoot = _XmlDoc.SelectSingleNode("Root")
                'p_MsgBox(_XmlRoot.OuterXml)
                p_ListView1_Listing()
            End If
        End If
    End Sub

    ' ::
    Private Sub p_XmlClose()
        If (Not _XmlDoc Is Nothing) Then
            p_ListView1_Clear()
            _XmlRoot = Nothing
            _XmlDoc = Nothing
        End If
        Try
            GC.Collect()
            GC.WaitForPendingFinalizers()
        Catch
        End Try
    End Sub












































    ' ::
    Private Sub p_ListView1_InitOnce()
        Me.ListView1.View = View.Details
        Me.ListView1.TabIndex = 0
        Me.ListView1.TabStop = False
        Me.ListView1.FullRowSelect = True
        Me.ListView1.HideSelection = False
        Me.ListView1.BeginUpdate()
        Me.ListView1.Columns.Add("No")
        Me.ListView1.Columns.Add("Url")
        Me.ListView1.Columns.Add("Id")
        Me.ListView1.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize)
        Me.ListView1.EndUpdate()
        AddHandler Me.ListView1.ColumnWidthChanging, AddressOf p_ListView_ColumnWidthChanging
        AddHandler Me.ListView1.SelectedIndexChanged, AddressOf p_ListView1_SelectedIndexChanged
    End Sub

    ' ::
    Private Shared Sub p_ListView_ColumnWidthChanging(sender As Object, e As ColumnWidthChangingEventArgs)
        e.Cancel = True
        e.NewWidth = CType(sender, ListView).Columns(e.ColumnIndex).Width
    End Sub

    ' ::
    Private Sub p_ListView1_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim t_sis As ListView.SelectedIndexCollection = Me.ListView1.SelectedIndices
        If (t_sis.Count = 1) Then
            Dim t_i As Integer = t_sis(0)
            Dim t_XItems As XmlNodeList = _XmlRoot.SelectNodes("Item")
            Dim t_XItem As XmlNode = t_XItems(t_i)
            Me.TextBox1.Text = t_XItem.SelectSingleNode("Url").InnerText
            Me.TextBox2.Text = t_XItem.SelectSingleNode("Id").InnerText
            Me.TextBox3.Text = t_XItem.SelectSingleNode("Pw").InnerText
        End If
    End Sub

    ' ::
    Private Sub p_ListView1_Clear()
        Me.ListView1.BeginUpdate()
        Me.ListView1.Items.Clear()
        'Me.ListView1.Columns.Clear()
        Me.ListView1.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize)
        Me.ListView1.EndUpdate()
    End Sub

    ' ::
    Private Sub p_ListView1_Listing()
        p_ListView1_Clear()
        '
        Me.ListView1.BeginUpdate()
        Dim t_XItems As XmlNodeList = _XmlRoot.SelectNodes("Item")
        Dim t_la As Integer = t_XItems.Count
        Dim i As Integer = 0
        While (i < t_la)
            Dim t_XItem As XmlNode = t_XItems(i)
            Dim t_LvItem As New ListViewItem((i + 1).ToString("000"))
            t_LvItem.SubItems.Add(t_XItem.SelectSingleNode("Url").InnerText)
            t_LvItem.SubItems.Add(t_XItem.SelectSingleNode("Id").InnerText)
            Me.ListView1.Items.Add(t_LvItem)
            '
            i += 1
        End While
        Me.ListView1.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize)
        Me.ListView1.EndUpdate()
    End Sub

    ' ::
    Private Sub p_ListView1_NoUpdate()
        Dim t_LvItems As ListView.ListViewItemCollection = Me.ListView1.Items
        Dim t_la As Integer = t_LvItems.Count
        Dim i As Integer = 0
        While (i < t_la)
            t_LvItems(i).SubItems(0).Text = (i + 1).ToString("000")
            '
            i += 1
        End While
    End Sub



    ' ::
    Private Sub p_Vacate()
        If (_XmlDoc Is Nothing) Then Exit Sub
        '
        Dim t_sis As ListView.SelectedListViewItemCollection = Me.ListView1.SelectedItems
        If (t_sis.Count > 0) Then
            For Each t_si As ListViewItem In t_sis
                t_si.Selected = False
            Next
        End If
        Me.TextBox1.Clear()
        Me.TextBox2.Clear()
        Me.TextBox3.Clear()
    End Sub

    ' ::
    Private Sub p_Del()
        If (_XmlDoc Is Nothing) Then Exit Sub
        '
        Dim t_sis As ListView.SelectedIndexCollection = Me.ListView1.SelectedIndices
        If (t_sis.Count = 1) Then
            Dim t_i As Integer = t_sis(0)
            Me.ListView1.Items(t_i).Remove()
            Me.TextBox1.Clear()
            Me.TextBox2.Clear()
            Me.TextBox3.Clear()
            '
            Dim t_XItem As XmlNode = _XmlRoot.SelectNodes("Item")(t_i)
            _XmlRoot.RemoveChild(t_XItem)
            '
            p_ListView1_NoUpdate()
        End If
    End Sub

    ' ::
    Private Sub p_Update()
        If (_XmlDoc Is Nothing) Then Exit Sub
        '
        Dim t_sis As ListView.SelectedIndexCollection = Me.ListView1.SelectedIndices
        If (t_sis.Count = 1) Then
            Dim t_url As String = Me.TextBox1.Text
            Dim t_id As String = Me.TextBox2.Text
            Dim t_pw As String = Me.TextBox3.Text
            '
            Dim t_i As Integer = t_sis(0)
            Dim t_LvItem As ListViewItem = Me.ListView1.Items(t_i)
            t_LvItem.SubItems(1).Text = t_url
            t_LvItem.SubItems(2).Text = t_id
            Me.ListView1.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize)
            '
            Dim t_XItem As XmlNode = _XmlRoot.SelectNodes("Item")(t_i)
            t_XItem.SelectSingleNode("Url").InnerText = t_url
            t_XItem.SelectSingleNode("Id").InnerText = t_id
            t_XItem.SelectSingleNode("Pw").InnerText = t_pw
        End If
    End Sub

    ' ::
    Private Sub p_Add()
        If (_XmlDoc Is Nothing) Then Exit Sub
        '
        Dim t_Url As String = Me.TextBox1.Text
        Dim t_Id As String = Me.TextBox2.Text
        Dim t_Pw As String = Me.TextBox3.Text
        '
        If (String.IsNullOrEmpty(t_Url) OrElse _
            String.IsNullOrEmpty(t_Id) OrElse _
            String.IsNullOrEmpty(t_Pw)) Then
        Else
            Dim t_LvItems As ListView.ListViewItemCollection = Me.ListView1.Items
            Dim t_i As Integer = t_LvItems.Count
            Dim t_LvItem As New ListViewItem(t_i.ToString("000"))
            t_LvItem.SubItems.Add(t_Url)
            t_LvItem.SubItems.Add(t_Id)
            t_LvItems.Add(t_LvItem)
            Me.ListView1.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize)
            '
            Dim t_XItem As XmlElement = _XmlDoc.CreateElement("Item")
            Dim t_XUrl As XmlElement = _XmlDoc.CreateElement("Url")
            Dim t_XId As XmlElement = _XmlDoc.CreateElement("Id")
            Dim t_XPw As XmlElement = _XmlDoc.CreateElement("Pw")
            t_XItem.AppendChild(t_XUrl)
            t_XItem.AppendChild(t_XId)
            t_XItem.AppendChild(t_XPw)
            t_XUrl.InnerText = t_Url
            t_XId.InnerText = t_Id
            t_XPw.InnerText = t_Pw
            _XmlRoot.AppendChild(t_XItem)
        End If
    End Sub

End Class
