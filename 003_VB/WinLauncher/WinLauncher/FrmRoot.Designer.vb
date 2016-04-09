<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FrmRoot
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmRoot))
        Me._FlaRoot = New AxShockwaveFlashObjects.AxShockwaveFlash()
        CType(Me._FlaRoot, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        '_FlaRoot
        '
        Me._FlaRoot.Dock = System.Windows.Forms.DockStyle.Fill
        Me._FlaRoot.Enabled = True
        Me._FlaRoot.Location = New System.Drawing.Point(0, 0)
        Me._FlaRoot.Name = "_FlaRoot"
        Me._FlaRoot.OcxState = CType(resources.GetObject("_FlaRoot.OcxState"), System.Windows.Forms.AxHost.State)
        Me._FlaRoot.Size = New System.Drawing.Size(1024, 576)
        Me._FlaRoot.TabIndex = 0
        '
        'FrmRoot
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(7.0!, 12.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink
        Me.ClientSize = New System.Drawing.Size(1024, 576)
        Me.Controls.Add(Me._FlaRoot)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.MinimumSize = Me.Size
        Me.Name = "FrmRoot"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "FrmRoot"
        CType(Me._FlaRoot, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents _FlaRoot As AxShockwaveFlashObjects.AxShockwaveFlash

End Class
