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
        Me.Pnl1 = New System.Windows.Forms.Panel()
        Me.Dgv1 = New System.Windows.Forms.DataGridView()
        Me.Txb1 = New System.Windows.Forms.TextBox()
        Me.FlaRoot = New AxShockwaveFlashObjects.AxShockwaveFlash()
        Me.Pnl1.SuspendLayout()
        CType(Me.Dgv1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FlaRoot, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Pnl1
        '
        Me.Pnl1.Controls.Add(Me.Dgv1)
        Me.Pnl1.Controls.Add(Me.Txb1)
        Me.Pnl1.Controls.Add(Me.FlaRoot)
        Me.Pnl1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.Pnl1.Location = New System.Drawing.Point(0, 0)
        Me.Pnl1.Name = "Pnl1"
        Me.Pnl1.Size = New System.Drawing.Size(800, 600)
        Me.Pnl1.TabIndex = 1
        '
        'Dgv1
        '
        Me.Dgv1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.Dgv1.Location = New System.Drawing.Point(12, 12)
        Me.Dgv1.Name = "Dgv1"
        Me.Dgv1.RowTemplate.Height = 23
        Me.Dgv1.Size = New System.Drawing.Size(776, 490)
        Me.Dgv1.TabIndex = 4
        '
        'Txb1
        '
        Me.Txb1.Location = New System.Drawing.Point(12, 508)
        Me.Txb1.Multiline = True
        Me.Txb1.Name = "Txb1"
        Me.Txb1.ReadOnly = True
        Me.Txb1.ScrollBars = System.Windows.Forms.ScrollBars.Both
        Me.Txb1.Size = New System.Drawing.Size(400, 80)
        Me.Txb1.TabIndex = 2
        '
        'FlaRoot
        '
        Me.FlaRoot.Dock = System.Windows.Forms.DockStyle.Fill
        Me.FlaRoot.Enabled = True
        Me.FlaRoot.Location = New System.Drawing.Point(0, 0)
        Me.FlaRoot.Name = "FlaRoot"
        Me.FlaRoot.OcxState = CType(resources.GetObject("FlaRoot.OcxState"), System.Windows.Forms.AxHost.State)
        Me.FlaRoot.Size = New System.Drawing.Size(800, 600)
        Me.FlaRoot.TabIndex = 3
        '
        'FrmRoot
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(7.0!, 12.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(800, 600)
        Me.Controls.Add(Me.Pnl1)
        Me.Location = New System.Drawing.Point(10, 10)
        Me.MaximizeBox = False
        Me.Name = "FrmRoot"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "FrmRoot"
        Me.Pnl1.ResumeLayout(False)
        Me.Pnl1.PerformLayout()
        CType(Me.Dgv1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FlaRoot, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents Pnl1 As System.Windows.Forms.Panel
    Friend WithEvents Txb1 As System.Windows.Forms.TextBox
    Friend WithEvents FlaRoot As AxShockwaveFlashObjects.AxShockwaveFlash
    Friend WithEvents Dgv1 As System.Windows.Forms.DataGridView

End Class
