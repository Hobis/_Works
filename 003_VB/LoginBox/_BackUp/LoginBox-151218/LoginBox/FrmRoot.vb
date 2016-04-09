Imports System.Xml
Imports System.IO

Public NotInheritable Class FrmRoot

    ' ::
    Public Sub New()

        ' This call is required by the designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub

    ' ::
    Private Sub p_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Me.Text = "LoginBox  Ver 1.02"
        '
        Me.FlaRoot.Menu = False
        Me.FlaRoot.LoadMovie(0, Path.Combine(Application.StartupPath, "FlaRoot.swf"))
        AddHandler Me.FlaRoot.FlashCall, AddressOf p_Frm_CallBack
        '
        p_ListView1_InitOnce()
        p_ListView2_InitOnce()
        p_XmlLoad()
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
                Application.Exit()

            Case "Frm_Load"

            Case "Frm_LItem_Edit"
                p_ListView1_Edit()

            Case "Frm_LItem_Add"
                p_ListView1_Add()

            Case "Frm_LItem_Del"
                p_ListView1_Del()

        End Select
    End Sub

    ' -
    Private _XmlRoot As XmlNode = Nothing

    ' ::
    Private Shared Sub p_MsgBox(msg As String)
        MsgBox(msg, MsgBoxStyle.OkOnly, "테스팅~!!")
    End Sub

    ' ::
    Private Sub p_XmlLoad()
        Dim t_XmlPath As String = _
            My.Application.Info.DirectoryPath & "/Data/Save.xml"
        If (File.Exists(t_XmlPath)) Then
            Dim t_XmlDoc As New XmlDocument()
            't_XmlDoc.PreserveWhitespace = False
            t_XmlDoc.Load(t_XmlPath)
            Dim t_XmlRoot As XmlNode = t_XmlDoc.SelectSingleNode("Root")
            'p_MsgBox(t_XmlRoot.SelectNodes("Item")(0).InnerXml)
            _XmlRoot = t_XmlRoot
            p_ListView1_Create()
        End If
    End Sub

    ' ::
    Private Shared Sub p_ListView_Clear(Lv As ListView)
        Lv.BeginUpdate()
        Lv.Items.Clear()
        'Lv.Columns.Clear()
        Lv.EndUpdate()
    End Sub





    ' ::
    Private Sub p_ListView1_InitOnce()
        Me.ListView1.View = View.Details
        Me.ListView1.TabStop = False
        Me.ListView1.FullRowSelect = True
        Me.ListView1.HideSelection = False
        Me.ListView1.BeginUpdate()
        Me.ListView1.Columns.Add("No")
        Me.ListView1.Columns.Add("Url")
        Me.ListView1.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize)
        Me.ListView1.EndUpdate()
        AddHandler Me.ListView1.ColumnWidthChanging, AddressOf p_ListView_ColumnWidthChanging
        AddHandler Me.ListView1.SelectedIndexChanged, AddressOf p_ListView1_SelectedIndexChanged

        'AddHandler Me.ListView1.LostFocus, AddressOf p_ListView_LostFocus
    End Sub

    ' ::
    Private Sub p_ListView1_Clear()
        p_ListView_Clear(Me.ListView1)
        _LItem = Nothing
    End Sub

    ' ::
    Private Shared Sub p_ListView_LostFocus(sender As Object, e As EventArgs)
    End Sub

    ' ::
    Private Shared Sub p_ListView_ColumnWidthChanging(sender As Object, e As ColumnWidthChangingEventArgs)
        e.Cancel = True
        e.NewWidth = CType(sender, ListView).Columns(e.ColumnIndex).Width
    End Sub

    ' ::
    Private _LItem As XmlNode = Nothing
    Private Sub p_ListView1_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim t_sic As ListView.SelectedIndexCollection = Me.ListView1.SelectedIndices
        If (t_sic.Count = 1) Then
            Dim t_i As Integer = t_sic(0)
            Dim t_LItems As XmlNodeList = _XmlRoot.SelectNodes("LItem")
            Dim t_LItem As XmlNode = t_LItems(t_i)
            If (Not t_LItem Is _LItem) Then
                _LItem = t_LItem
                p_ListView2_Create(_LItem)
                Me.TextBox1.Text = _LItem.SelectSingleNode("Url").InnerText
            End If
        End If
    End Sub

    ' ::
    Private Sub p_ListView1_Create()
        p_ListView1_Clear()

        Me.ListView1.BeginUpdate()
        Dim t_LItems As XmlNodeList = _XmlRoot.SelectNodes("LItem")
        Dim t_La, i As Integer
        t_La = t_LItems.Count
        i = 0
        While (i < t_La)
            Dim t_LItem As XmlNode = t_LItems(i)
            Dim t_lvi As New ListViewItem((i + 1).ToString("000"))
            t_lvi.SubItems.Add(t_LItem.SelectSingleNode("Url").InnerText)
            Me.ListView1.Items.Add(t_lvi)
            'p_MsgBox(t_Item.InnerXml)
            i += 1
        End While
        Me.ListView1.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize)
        Me.ListView1.EndUpdate()
    End Sub

    ' ::
    Private Sub p_ListView1_Add()
        Dim t_Url As String = Me.TextBox1.Text
        If (Not String.IsNullOrEmpty(t_Url)) Then
            Dim t_XmlLItem As XmlElement = _XmlRoot.OwnerDocument.CreateElement("LItem")
            Dim t_XmlUrl As XmlElement = _XmlRoot.OwnerDocument.CreateElement("Url")
            Dim t_XmlAccounts As XmlElement = _XmlRoot.OwnerDocument.CreateElement("Accounts")
            t_XmlUrl.InnerText = t_Url
            t_XmlLItem.AppendChild(t_XmlUrl)
            t_XmlLItem.AppendChild(t_XmlAccounts)
            _XmlRoot.AppendChild(t_XmlLItem)
            '
            Me.ListView1.BeginUpdate()
            Dim t_lvi As New ListViewItem((Me.ListView1.Items.Count + 1).ToString("000"))
            t_lvi.SubItems.Add(t_Url)
            Me.ListView1.Items.Add(t_lvi)
            Me.ListView1.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize)
            Me.ListView1.EndUpdate()
            Dim t_Count As Integer = Me.ListView1.Items.Count
            If (t_Count > 0) Then
                Me.ListView1.SelectedIndices.Clear()
                Me.ListView1.Items(t_Count - 1).Selected = True
                Me.ListView1.SelectedItems(0).EnsureVisible()
            End If
            'Me.TextBox1.Clear()
        End If
    End Sub

    ' ::
    Private Sub p_ListView1_Edit()
        If (Me.ListView1.SelectedIndices.Count = 1) Then
            Dim t_Url As String = Me.TextBox1.Text
            If (Not String.IsNullOrEmpty(t_Url)) Then
                Dim t_i As Integer = Me.ListView1.SelectedIndices(0)
                Dim t_XmlLItem As XmlNode = _XmlRoot.SelectNodes("LItem")(t_i)
                Dim t_XmlUrl As XmlNode = t_XmlLItem.SelectSingleNode("Url")
                t_XmlUrl.InnerText = t_Url
                Me.ListView1.BeginUpdate()
                Me.ListView1.Items(t_i).SubItems(1).Text = t_Url
                Me.ListView1.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize)
                Me.ListView1.EndUpdate()
                'p_MsgBox(t_XmlLItem.OuterXml)
            End If
        End If
    End Sub

    ' ::
    Private Sub p_ListView1_Del()
        If (Me.ListView1.SelectedIndices.Count = 1) Then
            p_ListView2_Clear()
            Dim t_i As Integer = Me.ListView1.SelectedIndices(0)
            Me.ListView1.SelectedItems.Clear()
            Return
            Dim t_XmlLItem As XmlNode = _XmlRoot.SelectNodes("LItem")(t_i)
            _XmlRoot.RemoveChild(t_XmlLItem)
            Dim t_SelectedItem As ListViewItem = Me.ListView1.SelectedItems(0)
            t_SelectedItem.SubItems.Clear()
            t_SelectedItem.Remove()
            'p_MsgBox(_XmlRoot.OuterXml)
        End If
    End Sub





    Private Sub p_ListView2_InitOnce()
        Me.ListView2.View = View.Details
        Me.ListView2.TabStop = False
        Me.ListView2.FullRowSelect = True
        Me.ListView2.HideSelection = False
        Me.ListView2.BeginUpdate()
        Me.ListView2.Columns.Add("No")
        Me.ListView2.Columns.Add("Id")
        Me.ListView2.Columns.Add("Pw")
        Me.ListView2.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize)
        Me.ListView2.EndUpdate()
        AddHandler Me.ListView2.ColumnWidthChanging, AddressOf p_ListView_ColumnWidthChanging
        AddHandler Me.ListView2.SelectedIndexChanged, AddressOf p_ListView2_SelectedIndexChanged
    End Sub

    Private Sub p_ListView2_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim t_sic As ListView.SelectedIndexCollection = Me.ListView2.SelectedIndices
        If (t_sic.Count = 1) Then
            Dim t_i As Integer = t_sic(0)
            Dim t_AItem As XmlNode = _LItem.SelectSingleNode("Accounts").SelectNodes("AItem")(t_i)
            Me.TextBox2.Text = t_AItem.SelectSingleNode("Id").InnerText
            Me.TextBox3.Text = t_AItem.SelectSingleNode("Pw").InnerText
        End If
    End Sub

    Private Sub p_ListView2_Clear()
        p_ListView_Clear(Me.ListView2)

        Me.TextBox2.Clear()
        Me.TextBox3.Clear()
    End Sub

    Private Sub p_ListView2_Create(LItem As XmlNode)
        p_ListView2_Clear()

        Me.ListView2.BeginUpdate()
        Dim t_Accounts As XmlNode = LItem.SelectSingleNode("Accounts")
        Dim t_AItems As XmlNodeList = t_Accounts.SelectNodes("AItem")
        Dim t_La As Integer = t_AItems.Count
        Dim i As Integer = 0
        While (i < t_La)
            Dim t_AItem As XmlNode = t_AItems(i)
            Dim t_lvi As New ListViewItem((i + 1).ToString("000"))
            t_lvi.SubItems.Add(t_AItem.SelectSingleNode("Id").InnerText)
            t_lvi.SubItems.Add(t_AItem.SelectSingleNode("Pw").InnerText)
            Me.ListView2.Items.Add(t_lvi)
            i += 1
        End While
        Me.ListView2.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize)
        Me.ListView2.EndUpdate()
    End Sub




End Class
