Imports System.Windows.Forms
Imports System.Collections.Specialized
Imports System.Collections.Generic
Imports System.Web


Public Module MUtils
    Private Const _Caption As String = "# 알림~!"

    Public Sub fMsgBox(ByVal owner As IWin32Window, _
                        ByVal msg As String)
        MMsgBox.Show(owner, msg, _Caption)
    End Sub

    ' :: pObj -> qStr
    Public Function fConvert_qStr(ByVal nvc As NameValueCollection) As String
        Dim t_rv As String = Nothing

        Dim t_list As List(Of String) = New List(Of String)()
        Dim t_name As String

        For Each t_name In nvc
            Dim t_value As String = nvc(t_name)
            t_value = HttpUtility.UrlEncode(t_value)
            Dim t_str = String.Concat(t_name, "=", t_value)
            t_list.Add(t_str)
        Next

        If (t_list.Count > 0) Then
            t_rv = String.Join("&", t_list.ToArray())
        End If

        t_list.Clear()

        Return t_rv
    End Function

    ' :: qStr -> pObj
    Public Function fConvert_pObj(ByVal qStr As String) As NameValueCollection
        Dim t_nvc As NameValueCollection = HttpUtility.ParseQueryString(qStr)

        If (t_nvc.Count > 0) Then
            Return t_nvc
        End If

        Return Nothing
    End Function
End Module