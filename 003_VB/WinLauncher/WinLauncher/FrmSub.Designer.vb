<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FrmSub
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmSub))
        Me._WebBrowser1 = New System.Windows.Forms.WebBrowser()
        Me.SuspendLayout()
        '
        '_WebBrowser1
        '
        Me._WebBrowser1.Dock = System.Windows.Forms.DockStyle.Fill
        Me._WebBrowser1.Location = New System.Drawing.Point(0, 0)
        Me._WebBrowser1.MinimumSize = New System.Drawing.Size(20, 20)
        Me._WebBrowser1.Name = "_WebBrowser1"
        Me._WebBrowser1.Size = New System.Drawing.Size(1024, 576)
        Me._WebBrowser1.TabIndex = 0
        '
        'FrmSub
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(7.0!, 12.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(1024, 576)
        Me.Controls.Add(Me._WebBrowser1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MinimumSize = Me.Size
        Me.Name = "FrmSub"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "FrmSub"
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents _WebBrowser1 As System.Windows.Forms.WebBrowser
End Class
