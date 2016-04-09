Imports System
Imports System.Drawing
Imports System.Runtime.InteropServices
Imports System.Windows.Forms
Imports System.Threading

Public Module MMsgBox

	Private Const _Kernel32dll As String = "kernel32.dll"
	Private Const _User32dll As String = "user32.dll"

    Private Enum _HookType As Integer
        WH_CBT = 5
    End Enum

    Private Delegate Function _HookProc(ByVal nCode As Integer, _
										ByVal wParam As IntPtr, _
										ByVal lParam As IntPtr) As Integer


	' ::
    <DllImportAttribute("kernel32.dll", _
        EntryPoint:="GetCurrentThreadId", _
        CharSet:=CharSet.Auto,
        CallingConvention:=CallingConvention.StdCall, _
        SetLastError:=True)> _
    Public Function p_GetCurrentThreadId() As Integer
    End Function

	' ::
    <DllImportAttribute("user32.dll", _
        EntryPoint:="SetWindowsHookEx", _
        CharSet:=CharSet.Auto,
        CallingConvention:=CallingConvention.StdCall, _
        SetLastError:=True)> _
    Private Function p_SetWindowsHookEx(ByVal hookType As _HookType, _
										ByVal lpfn As _HookProc, _
										ByVal hMod As IntPtr, _
										ByVal dwThreadId As UInteger) As IntPtr
    End Function

	' ::
    <DllImportAttribute("user32.dll", _
        EntryPoint:="UnhookWindowsHookEx", _
        CharSet:=CharSet.Auto,
        CallingConvention:=CallingConvention.StdCall, _
        SetLastError:=True)> _
    Private Function p_UnhookWindowsHookEx(ByVal hHook As IntPtr) As Boolean
    End Function

	' ::
    <DllImportAttribute("user32.dll", _
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
    <DllImportAttribute("user32.dll", _
        EntryPoint:="GetWindowRect", _
        CharSet:=CharSet.Auto,
        CallingConvention:=CallingConvention.StdCall, _
        SetLastError:=True)> _
    Private Function p_GetWindowRect(ByVal hWnd As IntPtr, _
									 ByRef lpRect As Rectangle) As Boolean
    End Function

    ' ::
    <DllImportAttribute("user32.dll", _
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



	' ::
    Public Function Show(ByVal owner As IWin32Window, _
						 ByVal msg As String, _
						 ByVal caption As String) As DialogResult
        _HookProcDelegate = AddressOf p_HookProc
        _msg = msg
        _caption = caption
        _hHook = p_SetWindowsHookEx(_HookType.WH_CBT, _HookProcDelegate, IntPtr.Zero, p_GetCurrentThreadId())
        '
        MessageBox.Show(owner, _msg, _caption)
        '
        Return Nothing
    End Function



    Private _HookProcDelegate As _HookProc = Nothing
    Private _hHook As IntPtr = IntPtr.Zero
    Private _msg As String = Nothing
    Private _caption As String = Nothing


	' ::
    Private Function p_HookProc(ByVal nCode As Integer, _
								ByVal wParam As IntPtr, _
								ByVal lParam As IntPtr) As Integer
		If (nCode < 0) Then
			Return p_CallNextHookEx(_hHook, nCode, wParam, lParam)
		End If
		
		Dim t_msg As _CWPRETSTRUCT = _
			CType(Marshal.PtrToStructure(lParam, GetType(_CWPRETSTRUCT)), _CWPRETSTRUCT)

		If (msg.message = _HookType.WH_CBT) Then
			Try
				p_CenterWindow(msg.hwnd)
			Finally
				UnhookWindowsHookEx(_hHook)
				_hHook = IntPtr.Zero
			End Try
		End If

		Return CallNextHookEx(hook, nCode, wParam, lParam)
    End Function

	' ::
	Private Shared Sub p_CenterWindow(ByVal hChildWnd As IntPtr)
	End Sub

End Module
