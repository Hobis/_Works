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
        Me.ListView1 = New System.Windows.Forms.ListView()
        Me.ListView2 = New System.Windows.Forms.ListView()
        Me.TextBox1 = New System.Windows.Forms.TextBox()
        Me.TextBox2 = New System.Windows.Forms.TextBox()
        Me.TextBox3 = New System.Windows.Forms.TextBox()
        Me.PanelRoot = New System.Windows.Forms.Panel()
        Me.FlaRoot = New LoginBox.FlaRoot()
        Me.PanelRoot.SuspendLayout()
        CType(Me.FlaRoot, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'ListView1
        '
        Me.ListView1.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.Nonclickable
        Me.ListView1.Location = New System.Drawing.Point(12, 12)
        Me.ListView1.Name = "ListView1"
        Me.ListView1.Size = New System.Drawing.Size(200, 240)
        Me.ListView1.TabIndex = 1
        Me.ListView1.UseCompatibleStateImageBehavior = False
        '
        'ListView2
        '
        Me.ListView2.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.Nonclickable
        Me.ListView2.Location = New System.Drawing.Point(218, 12)
        Me.ListView2.Name = "ListView2"
        Me.ListView2.Size = New System.Drawing.Size(270, 240)
        Me.ListView2.TabIndex = 7
        Me.ListView2.UseCompatibleStateImageBehavior = False
        '
        'TextBox1
        '
        Me.TextBox1.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.TextBox1.Location = New System.Drawing.Point(44, 263)
        Me.TextBox1.Name = "TextBox1"
        Me.TextBox1.Size = New System.Drawing.Size(164, 14)
        Me.TextBox1.TabIndex = 9
        '
        'TextBox2
        '
        Me.TextBox2.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.TextBox2.Location = New System.Drawing.Point(244, 263)
        Me.TextBox2.Name = "TextBox2"
        Me.TextBox2.Size = New System.Drawing.Size(156, 14)
        Me.TextBox2.TabIndex = 13
        '
        'TextBox3
        '
        Me.TextBox3.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.TextBox3.Location = New System.Drawing.Point(251, 290)
        Me.TextBox3.Name = "TextBox3"
        Me.TextBox3.Size = New System.Drawing.Size(148, 14)
        Me.TextBox3.TabIndex = 14
        '
        'PanelRoot
        '
        Me.PanelRoot.Controls.Add(Me.TextBox3)
        Me.PanelRoot.Controls.Add(Me.TextBox2)
        Me.PanelRoot.Controls.Add(Me.TextBox1)
        Me.PanelRoot.Controls.Add(Me.ListView2)
        Me.PanelRoot.Controls.Add(Me.ListView1)
        Me.PanelRoot.Controls.Add(Me.FlaRoot)
        Me.PanelRoot.Dock = System.Windows.Forms.DockStyle.Fill
        Me.PanelRoot.Location = New System.Drawing.Point(0, 0)
        Me.PanelRoot.Name = "PanelRoot"
        Me.PanelRoot.Size = New System.Drawing.Size(500, 400)
        Me.PanelRoot.TabIndex = 0
        '
        'FlaRoot
        '
        Me.FlaRoot.Dock = System.Windows.Forms.DockStyle.Fill
        Me.FlaRoot.Enabled = True
        Me.FlaRoot.Location = New System.Drawing.Point(0, 0)
        Me.FlaRoot.Name = "FlaRoot"
        Me.FlaRoot.OcxState = CType(resources.GetObject("FlaRoot.OcxState"), System.Windows.Forms.AxHost.State)
        Me.FlaRoot.Size = New System.Drawing.Size(500, 400)
        Me.FlaRoot.TabIndex = 0
        '
        'FrmRoot
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(7.0!, 12.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink
        Me.ClientSize = New System.Drawing.Size(500, 400)
        Me.Controls.Add(Me.PanelRoot)
        Me.Location = New System.Drawing.Point(80, 80)
        Me.MaximizeBox = False
        Me.Name = "FrmRoot"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Form1"
        Me.PanelRoot.ResumeLayout(False)
        Me.PanelRoot.PerformLayout()
        CType(Me.FlaRoot, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents FlaRoot As LoginBox.FlaRoot
    Friend WithEvents ListView1 As System.Windows.Forms.ListView
    Friend WithEvents ListView2 As System.Windows.Forms.ListView
    Friend WithEvents TextBox1 As System.Windows.Forms.TextBox
    Friend WithEvents TextBox2 As System.Windows.Forms.TextBox
    Friend WithEvents TextBox3 As System.Windows.Forms.TextBox
    Friend WithEvents PanelRoot As System.Windows.Forms.Panel

End Class
