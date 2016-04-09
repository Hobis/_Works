Imports System
Imports System.Windows.Forms
Imports AxShockwaveFlashObjects

Public NotInheritable Class FlaRoot : Inherits AxShockwaveFlash

    Private Const _WM_RBUTTONDOWN As Integer = &H204
    Private Const _WM_RBUTTONUP As Integer = &H205

    Protected Overrides Sub WndProc(ByRef m As Message)
        If (m.Msg = _WM_RBUTTONDOWN) OrElse _
            (m.Msg = _WM_RBUTTONUP) Then
            m.Result = IntPtr.Zero
        Else
            MyBase.WndProc(m)
        End If
    End Sub

End Class
