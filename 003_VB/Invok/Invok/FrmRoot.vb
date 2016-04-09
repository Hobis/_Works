Imports System
Imports System.Collections.Generic
Imports System.IO
Imports System.Runtime.CompilerServices
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
        Me.Text = "회원정보관리  Ver 1.19"
        Me.PanelRoot.Visible = False
        Me.PanelRoot.Enabled = False
        Me.FlaRoot.Menu = False
        Me.FlaRoot.LoadMovie(0, Path.Combine(Application.StartupPath, "FlaRoot.swf"))
        AddHandler Me.FlaRoot.FlashCall, AddressOf p_Frm_CallBack

        p_lvUser_Init()
        p_lvUser_ItemListing()
    End Sub

    ' ::
    Private Sub p_Frm_CallBack(sender As Object, e As AxShockwaveFlashObjects._IShockwaveFlashEvents_FlashCallEvent)
        'Throw New NotImplementedException
    End Sub


    Private Sub p_Shown(sender As Object, e As EventArgs) Handles MyBase.Shown
        _frmLogin = New FrmLogin()
        Dim t_dr As DialogResult = _frmLogin.ShowDialog(Me)
        If (t_dr.Equals(DialogResult.Yes)) Then
            Me.PanelRoot.Visible = True
            Me.PanelRoot.Enabled = True
        Else
            Application.Exit()
        End If
    End Sub
    ' -
    Private _frmLogin As FrmLogin = Nothing


    ' ::
    Private _UserItems As List(Of SUserItem) = Nothing
    Private Sub p_UserItems_Clear()
        _UserItems.Clear()
        _UserItems = Nothing
    End Sub

    Private Sub p_UserItems_Load()
        '_UserItems = New List(Of SUserItem)
        '_UserItems.Add(New SUserItem("정희범", "jhb0b@naver.com"))
        '_UserItems.Add(New SUserItem("박종명", "pook61@naver.com"))
        '_UserItems.Add(New SUserItem("임헌진", "inoff79@naver.com"))
        _UserItems = New List(Of SUserItem)
        For i As Integer = 0 To 0
            Dim t_ui As SUserItem
            t_ui = New SUserItem("정희범", "jhb0b@naver.com", _
                                 "서울시 송파구 석촌동 297-28 월드아파트 202호", _
                                 DateTime.Now)
            _UserItems.Add(t_ui)
            t_ui = New SUserItem("박종명", "pook61@naver.com", _
                                 "서울시 송파구 석촌동 297-28 월드아파트 202호", _
                                 DateTime.Now)
            _UserItems.Add(t_ui)
            t_ui = New SUserItem("임헌진", "inoff79@naver.com", _
                                 "서울시 송파구 석촌동 297-28 월드아파트 202호", _
                                 DateTime.Now)
            _UserItems.Add(t_ui)
        Next

    End Sub

    Private Sub p_lvUser_Init()
        ListViewRoot.BeginUpdate()
        ListViewRoot.View = View.Details
        ListViewRoot.TabStop = False
        ListViewRoot.FullRowSelect = True
        ListViewRoot.Columns.Add("번호")
        ListViewRoot.Columns.Add("이름")
        ListViewRoot.Columns.Add("e메일")
        ListViewRoot.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize)
        AddHandler Me.ListViewRoot.ColumnWidthChanging, AddressOf p_lvUser_ColumnWidthChanging
        AddHandler Me.ListViewRoot.SelectedIndexChanged, AddressOf p_lvUser_SelectedIndexChanged
        ListViewRoot.EndUpdate()
    End Sub

    Private Sub p_lvUser_ColumnWidthChanging(sender As Object, e As ColumnWidthChangingEventArgs)
        e.Cancel = True
        e.NewWidth = ListViewRoot.Columns(e.ColumnIndex).Width
    End Sub

    Private Sub p_lvUser_ItemClear()
        If (Not _UserItems Is Nothing) Then
            ListViewRoot.BeginUpdate()
            ListViewRoot.Items.Clear()
            ListViewRoot.EndUpdate()
            p_UserItems_Clear()
        End If
    End Sub

    Private Sub p_lvUser_ItemListing()
        p_lvUser_ItemClear()
        p_UserItems_Load()
        ListViewRoot.BeginUpdate()
        p_lvUser_ItemListingCore()
        ListViewRoot.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize)
        ListViewRoot.EndUpdate()
    End Sub

    Private Sub p_lvUser_ItemListingCore()
        If (Not _UserItems Is Nothing) Then
            Dim i As Integer = 1
            For Each t_ui As SUserItem In _UserItems
                Dim t_lvi As ListViewItem = Nothing
                t_lvi = New ListViewItem(i.ToString("000"))
                i += 1
                t_lvi.SubItems.Add(t_ui.GetName())
                t_lvi.SubItems.Add(t_ui.GetEMail())
                ListViewRoot.Items.Add(t_lvi)
            Next
        End If
    End Sub



    Private Sub p_lvUser_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim t_sic As ListView.SelectedIndexCollection = ListViewRoot.SelectedIndices
        If (t_sic.Count = 1) Then
            Dim t_i As Integer = t_sic(0)
            Dim t_ui As SUserItem = _UserItems(t_i)
            Me.Txb1.Text = t_ui.GetName()
            Me.Txb2.Text = t_ui.GetEMail()
            Me.Txb3.Text = t_ui.GetAddress()
            Me.Txb4.Text = t_ui.GetBirthDay()
        End If
    End Sub









End Class


'
'
'
' # 유저정보 구조체 ----------------------------------------------------------------------
Public Structure SUserItem

    Public Sub New(Name As String, EMail As String, _
                   Address As String, BirthDay As DateTime)
        Me._Name = Name
        Me._EMail = EMail
        Me._Address = Address
        Me._BirthDay = BirthDay
    End Sub

    Private _Name As String
    Public Function GetName()
        Return _Name
    End Function

    Private _EMail As String
    Public Function GetEMail()
        Return _EMail
    End Function

    Private _Address As String
    Public Function GetAddress()
        Return _Address
    End Function

    Private _BirthDay As DateTime
    Public Function GetBirthDay()
        Return _BirthDay
    End Function

End Structure
