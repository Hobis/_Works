Imports System
Imports System.Windows.Forms
Imports Microsoft.VisualBasic
Imports AxShockwaveFlashObjects
Imports System.ComponentModel

Public NotInheritable Class FlaRoot : Inherits AxShockwaveFlash

    Private Const _WM_RBUTTONDOWN As Integer = &H204
    Private Const _WM_RBUTTONUP As Integer = &H205

    Protected Overrides Sub WndProc(ByRef m As Message)
        If (m.Msg = _WM_RBUTTONDOWN) OrElse _
            (m.Msg = _WM_RBUTTONUP) Then
            'm.Result = IntPtr.Zero
        Else
            MyBase.WndProc(m)
        End If
    End Sub

    Protected Overrides Function ProcessCmdKey(ByRef msg As Message, ByVal keyData As Keys) As Boolean
        'Dim keyPressed As Keys = CType(msg.WParam.ToInt32(), Keys)

        'Select Case keyPressed
        '    Case Keys.Tab
        '        Me.Parent.Focus()

        '    Case Keys.Apps
        '        Return True

        'End Select

        Select Case keyData
            Case Keys.Tab
                Me.Parent.Focus()

            Case Keys.Apps
                Return True
        End Select

        Return MyBase.ProcessCmdKey(msg, keyData)
    End Function

End Class
