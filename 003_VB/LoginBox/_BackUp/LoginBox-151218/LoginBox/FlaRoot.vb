Imports System
Imports System.Windows.Forms
Imports AxShockwaveFlashObjects

Public NotInheritable Class FlaRoot : Inherits AxShockwaveFlash

    Private Const _WM_RBUTTONDOWN As Integer = &H204
    Private Const _WM_RBUTTONUP As Integer = &H205

    Protected Overrides Sub wndproc(ByRef m As Message)
        If (m.msg = _wm_rbuttondown) OrElse _
            (m.msg = _wm_rbuttonup) Then
            m.result = intptr.zero
        Else
            MyBase.wndproc(m)
        End If
    End Sub

End Class
