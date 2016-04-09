Public Module MConfig

    ' -
    Private _FrmRoot As FrmRoot = Nothing
    Public Sub SetFrmRoot(FrmRoot As FrmRoot)
        _FrmRoot = FrmRoot
    End Sub
    Public Function GetFrmRoot() As FrmRoot
        Return _FrmRoot
    End Function

    ' -
    Private Const _Version As String = "Ver 1.02"

    ' -
    '"Window Launcher Ver 1.02 >> EBS Touch-Mong"
    Private Const _TitleName As String = "EBS 터치몽"
    Public Function GetTitleName() As String
        Return _TitleName
    End Function

    ' -
    Private Const _TitleText As String = _TitleName & " 윈도우 런처 " & _Version
    Public Function GetTitleText() As String
        Return _TitleText
    End Function

    Public NowLesson As String = ""

End Module
