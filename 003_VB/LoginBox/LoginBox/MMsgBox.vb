Imports System
Imports System.Drawing
Imports System.Runtime.InteropServices
Imports System.Windows.Forms
Imports System.Threading

Public Module MMsgBox

#Region "Initalize"

    Private Const _Kernel32dll As String = "kernel32.dll"
    Private Const _User32dll As String = "user32.dll"


    Private Const _WH_CALLWNDPROCRET As Integer = 12

    Private Const _HCBT_ACTIVATE As Integer = 5

    Private Delegate Function _HookProc(ByVal nCode As Integer, _
                                        ByVal wParam As IntPtr, _
                                        ByVal lParam As IntPtr) As Integer


    ' ::
    <DllImportAttribute(_Kernel32dll, _
        EntryPoint:="GetCurrentThreadId", _
        CharSet:=CharSet.Auto,
        CallingConvention:=CallingConvention.StdCall, _
        SetLastError:=True)> _
    Public Function p_GetCurrentThreadId() As Integer
    End Function

    ' ::
    <DllImportAttribute(_User32dll, _
        EntryPoint:="SetWindowsHookEx", _
        CharSet:=CharSet.Auto,
        CallingConvention:=CallingConvention.StdCall, _
        SetLastError:=True)> _
    Private Function p_SetWindowsHookEx(ByVal idHook As Integer, _
                                        ByVal lpfn As _HookProc, _
                                        ByVal hMod As IntPtr, _
                                        ByVal dwThreadId As UInteger) As IntPtr
    End Function

    ' ::
    <DllImportAttribute(_User32dll, _
        EntryPoint:="UnhookWindowsHookEx", _
        CharSet:=CharSet.Auto,
        CallingConvention:=CallingConvention.StdCall, _
        SetLastError:=True)> _
    Private Function p_UnhookWindowsHookEx(ByVal hHook As IntPtr) As Boolean
    End Function

    ' ::
    <DllImportAttribute(_User32dll, _
        EntryPoint:="CallNextHookEx", _
        CharSet:=CharSet.Auto,
        CallingConvention:=CallingConvention.StdCall, _
        SetLastError:=True)> _
    Private Function p_CallNextHookEx(ByVal hHook As IntPtr, _
                                      ByVal nCode As Integer, _
                                      ByVal wParam As IntPtr, _
                                      ByVal lParam As IntPtr) As IntPtr
    End Function

    ' ::
    <DllImportAttribute(_User32dll, _
        EntryPoint:="GetWindowRect", _
        CharSet:=CharSet.Auto,
        CallingConvention:=CallingConvention.StdCall, _
        SetLastError:=True)> _
    Private Function p_GetWindowRect(ByVal hWnd As IntPtr, _
                                     ByRef lpRect As Rectangle) As Boolean
    End Function

    ' ::
    <DllImportAttribute(_User32dll, _
        EntryPoint:="MoveWindow", _
        CharSet:=CharSet.Auto,
        CallingConvention:=CallingConvention.StdCall, _
        SetLastError:=True)> _
    Private Function p_MoveWindow(ByVal hWnd As IntPtr, _
                                  ByVal x As Integer, ByVal y As Integer, _
                                  ByVal w As Integer, ByVal h As Integer, _
                                  ByVal redraw As Boolean) As Boolean
    End Function


    <StructLayout(LayoutKind.Sequential)> _
    Private Structure _CWPRETSTRUCT
        Public lResult As IntPtr
        Public lParam As IntPtr
        Public wParam As IntPtr
        Public message As UInteger
        Public hwnd As IntPtr
    End Structure

#End Region



    Private _Owner As IWin32Window = Nothing
    Private _HookProcDelegate As _HookProc = Nothing
    Private _hHook As IntPtr = IntPtr.Zero

    ' ::
    Public Function Show(ByVal owner As IWin32Window, _
                         ByVal msg As String, _
                         ByVal caption As String) As DialogResult
        _Owner = owner
        p_Ready()
        '
        Return MessageBox.Show(owner, msg, caption)
    End Function

    ' ::
    Private Sub p_Ready()
        If (_HookProcDelegate Is Nothing) Then
            _HookProcDelegate = AddressOf p_HookProc
        End If

        If (Not _Owner Is Nothing) Then
            _hHook = p_SetWindowsHookEx(_WH_CALLWNDPROCRET, _HookProcDelegate, IntPtr.Zero, p_GetCurrentThreadId())
        End If
    End Sub

    ' ::
    Private Function p_HookProc(ByVal nCode As Integer, _
                                ByVal wParam As IntPtr, _
                                ByVal lParam As IntPtr) As Integer
        If (nCode < 0) Then
            Return p_CallNextHookEx(_hHook, nCode, wParam, lParam)
        End If

        '
        Dim t_msg As _CWPRETSTRUCT = _
            CType(Marshal.PtrToStructure(lParam, GetType(_CWPRETSTRUCT)), _CWPRETSTRUCT)
        Dim t_hh As IntPtr = _hHook

        If (t_msg.message = _HCBT_ACTIVATE) Then
            Try
                p_CenterWindow(t_msg.hwnd)
            Finally
                p_UnhookWindowsHookEx(_hHook)
                _hHook = IntPtr.Zero
            End Try
        End If

        Return p_CallNextHookEx(t_hh, nCode, wParam, lParam)
    End Function

    ' ::
    Private Sub p_CenterWindow(ByVal hChildWnd As IntPtr)
        Dim t_recChild As New Rectangle(0, 0, 0, 0)
        Dim t_success As Boolean = p_GetWindowRect(hChildWnd, t_recChild)

        Dim t_width As Integer = t_recChild.Width - t_recChild.X
        Dim t_height As Integer = t_recChild.Height - t_recChild.Y

        Dim t_recParent As New Rectangle(0, 0, 0, 0)
        t_success = p_GetWindowRect(_Owner.Handle, t_recParent)

        Dim t_ptCenter As New Point(0, 0)
        t_ptCenter.X = t_recParent.X + ((t_recParent.Width - t_recParent.X) / 2)
        t_ptCenter.Y = t_recParent.Y + ((t_recParent.Height - t_recParent.Y) / 2)


        Dim t_ptStart As New Point(0, 0)
        t_ptStart.X = (t_ptCenter.X - (t_width / 2))
        t_ptStart.Y = (t_ptCenter.Y - (t_height / 2))

        t_ptStart.X = If((t_ptStart.X < 0), 0, t_ptStart.X)
        t_ptStart.Y = If((t_ptStart.Y < 0), 0, t_ptStart.Y)

        Dim t_result As Integer = p_MoveWindow(hChildWnd, t_ptStart.X, t_ptStart.Y, t_width, t_height, False)
    End Sub

End Module
