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
        Me.PanelRoot = New System.Windows.Forms.Panel()
        Me.TextBox3 = New System.Windows.Forms.TextBox()
        Me.TextBox2 = New System.Windows.Forms.TextBox()
        Me.TextBox1 = New System.Windows.Forms.TextBox()
        Me.ListView1 = New System.Windows.Forms.ListView()
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog()
        Me.FlaRoot = New LoginBox.FlaRoot()
        Me.PanelRoot.SuspendLayout()
        CType(Me.FlaRoot, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'PanelRoot
        '
        Me.PanelRoot.Controls.Add(Me.TextBox3)
        Me.PanelRoot.Controls.Add(Me.TextBox2)
        Me.PanelRoot.Controls.Add(Me.TextBox1)
        Me.PanelRoot.Controls.Add(Me.ListView1)
        Me.PanelRoot.Controls.Add(Me.FlaRoot)
        Me.PanelRoot.Dock = System.Windows.Forms.DockStyle.Fill
        Me.PanelRoot.Location = New System.Drawing.Point(0, 0)
        Me.PanelRoot.Name = "PanelRoot"
        Me.PanelRoot.Size = New System.Drawing.Size(500, 400)
        Me.PanelRoot.TabIndex = 0
        '
        'TextBox3
        '
        Me.TextBox3.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.TextBox3.Font = New System.Drawing.Font("Gulim", 8.0!)
        Me.TextBox3.Location = New System.Drawing.Point(229, 345)
        Me.TextBox3.Name = "TextBox3"
        Me.TextBox3.Size = New System.Drawing.Size(159, 13)
        Me.TextBox3.TabIndex = 11
        '
        'TextBox2
        '
        Me.TextBox2.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.TextBox2.Font = New System.Drawing.Font("Gulim", 8.0!)
        Me.TextBox2.Location = New System.Drawing.Point(31, 345)
        Me.TextBox2.Name = "TextBox2"
        Me.TextBox2.Size = New System.Drawing.Size(165, 13)
        Me.TextBox2.TabIndex = 10
        '
        'TextBox1
        '
        Me.TextBox1.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.TextBox1.Font = New System.Drawing.Font("Gulim", 8.0!)
        Me.TextBox1.Location = New System.Drawing.Point(36, 322)
        Me.TextBox1.Name = "TextBox1"
        Me.TextBox1.Size = New System.Drawing.Size(349, 13)
        Me.TextBox1.TabIndex = 9
        '
        'ListView1
        '
        Me.ListView1.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.ListView1.HeaderStyle = System.Windows.Forms.ColumnHeaderStyle.Nonclickable
        Me.ListView1.Location = New System.Drawing.Point(12, 12)
        Me.ListView1.Name = "ListView1"
        Me.ListView1.Size = New System.Drawing.Size(476, 300)
        Me.ListView1.TabIndex = 1
        Me.ListView1.UseCompatibleStateImageBehavior = False
        '
        'OpenFileDialog1
        '
        Me.OpenFileDialog1.FileName = "OpenFileDialog1"
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
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
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
    Friend WithEvents PanelRoot As System.Windows.Forms.Panel
    Friend WithEvents TextBox3 As System.Windows.Forms.TextBox
    Friend WithEvents TextBox2 As System.Windows.Forms.TextBox
    Friend WithEvents TextBox1 As System.Windows.Forms.TextBox
    Friend WithEvents ListView1 As System.Windows.Forms.ListView
    Private WithEvents OpenFileDialog1 As System.Windows.Forms.OpenFileDialog

End Class
