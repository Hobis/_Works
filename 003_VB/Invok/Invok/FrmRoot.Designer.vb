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
        Me.TabControlRoot = New System.Windows.Forms.TabControl()
        Me.Tcp1 = New System.Windows.Forms.TabPage()
        Me.Txb4 = New System.Windows.Forms.TextBox()
        Me.Txb3 = New System.Windows.Forms.TextBox()
        Me.Txb2 = New System.Windows.Forms.TextBox()
        Me.Txb1 = New System.Windows.Forms.TextBox()
        Me.Tcp2 = New System.Windows.Forms.TabPage()
        Me.ListViewRoot = New System.Windows.Forms.ListView()
        Me.ComboBoxRoot = New System.Windows.Forms.ComboBox()
        Me.FlaRoot = New Invok.FlaRoot()
        Me.PanelRoot.SuspendLayout()
        Me.TabControlRoot.SuspendLayout()
        Me.Tcp1.SuspendLayout()
        CType(Me.FlaRoot, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'PanelRoot
        '
        Me.PanelRoot.Controls.Add(Me.TabControlRoot)
        Me.PanelRoot.Controls.Add(Me.ListViewRoot)
        Me.PanelRoot.Controls.Add(Me.ComboBoxRoot)
        Me.PanelRoot.Controls.Add(Me.FlaRoot)
        Me.PanelRoot.Dock = System.Windows.Forms.DockStyle.Fill
        Me.PanelRoot.Location = New System.Drawing.Point(0, 0)
        Me.PanelRoot.Name = "PanelRoot"
        Me.PanelRoot.Size = New System.Drawing.Size(800, 600)
        Me.PanelRoot.TabIndex = 0
        '
        'TabControlRoot
        '
        Me.TabControlRoot.Controls.Add(Me.Tcp1)
        Me.TabControlRoot.Controls.Add(Me.Tcp2)
        Me.TabControlRoot.Font = New System.Drawing.Font("Gulim", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(129, Byte))
        Me.TabControlRoot.Location = New System.Drawing.Point(318, 12)
        Me.TabControlRoot.Name = "TabControlRoot"
        Me.TabControlRoot.SelectedIndex = 0
        Me.TabControlRoot.Size = New System.Drawing.Size(472, 547)
        Me.TabControlRoot.TabIndex = 6
        '
        'Tcp1
        '
        Me.Tcp1.BackgroundImage = Global.Invok.My.Resources.Resources.Body01
        Me.Tcp1.Controls.Add(Me.Txb4)
        Me.Tcp1.Controls.Add(Me.Txb3)
        Me.Tcp1.Controls.Add(Me.Txb2)
        Me.Tcp1.Controls.Add(Me.Txb1)
        Me.Tcp1.Location = New System.Drawing.Point(4, 22)
        Me.Tcp1.Name = "Tcp1"
        Me.Tcp1.Padding = New System.Windows.Forms.Padding(3)
        Me.Tcp1.Size = New System.Drawing.Size(464, 521)
        Me.Tcp1.TabIndex = 0
        Me.Tcp1.Text = "1) 요약정보"
        Me.Tcp1.UseVisualStyleBackColor = True
        '
        'Txb4
        '
        Me.Txb4.BackColor = System.Drawing.SystemColors.MenuBar
        Me.Txb4.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.Txb4.Font = New System.Drawing.Font("Gulim", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(129, Byte))
        Me.Txb4.Location = New System.Drawing.Point(79, 97)
        Me.Txb4.Name = "Txb4"
        Me.Txb4.Size = New System.Drawing.Size(224, 14)
        Me.Txb4.TabIndex = 5
        '
        'Txb3
        '
        Me.Txb3.BackColor = System.Drawing.SystemColors.MenuBar
        Me.Txb3.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.Txb3.Font = New System.Drawing.Font("Gulim", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(129, Byte))
        Me.Txb3.Location = New System.Drawing.Point(79, 72)
        Me.Txb3.Name = "Txb3"
        Me.Txb3.Size = New System.Drawing.Size(314, 14)
        Me.Txb3.TabIndex = 4
        '
        'Txb2
        '
        Me.Txb2.BackColor = System.Drawing.SystemColors.MenuBar
        Me.Txb2.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.Txb2.Font = New System.Drawing.Font("Gulim", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(129, Byte))
        Me.Txb2.Location = New System.Drawing.Point(79, 46)
        Me.Txb2.Name = "Txb2"
        Me.Txb2.Size = New System.Drawing.Size(224, 14)
        Me.Txb2.TabIndex = 3
        '
        'Txb1
        '
        Me.Txb1.BackColor = System.Drawing.SystemColors.MenuBar
        Me.Txb1.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.Txb1.Font = New System.Drawing.Font("Gulim", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(129, Byte))
        Me.Txb1.Location = New System.Drawing.Point(79, 20)
        Me.Txb1.Name = "Txb1"
        Me.Txb1.Size = New System.Drawing.Size(224, 14)
        Me.Txb1.TabIndex = 2
        '
        'Tcp2
        '
        Me.Tcp2.Location = New System.Drawing.Point(4, 22)
        Me.Tcp2.Name = "Tcp2"
        Me.Tcp2.Padding = New System.Windows.Forms.Padding(3)
        Me.Tcp2.Size = New System.Drawing.Size(464, 521)
        Me.Tcp2.TabIndex = 1
        Me.Tcp2.Text = "2) 상세정보"
        Me.Tcp2.UseVisualStyleBackColor = True
        '
        'ListViewRoot
        '
        Me.ListViewRoot.Location = New System.Drawing.Point(12, 38)
        Me.ListViewRoot.Name = "ListViewRoot"
        Me.ListViewRoot.Size = New System.Drawing.Size(300, 520)
        Me.ListViewRoot.TabIndex = 5
        Me.ListViewRoot.UseCompatibleStateImageBehavior = False
        '
        'ComboBoxRoot
        '
        Me.ComboBoxRoot.CausesValidation = False
        Me.ComboBoxRoot.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.ComboBoxRoot.FormattingEnabled = True
        Me.ComboBoxRoot.Location = New System.Drawing.Point(12, 12)
        Me.ComboBoxRoot.Name = "ComboBoxRoot"
        Me.ComboBoxRoot.Size = New System.Drawing.Size(121, 20)
        Me.ComboBoxRoot.TabIndex = 3
        '
        'FlaRoot
        '
        Me.FlaRoot.Dock = System.Windows.Forms.DockStyle.Fill
        Me.FlaRoot.Enabled = True
        Me.FlaRoot.Location = New System.Drawing.Point(0, 0)
        Me.FlaRoot.Name = "FlaRoot"
        Me.FlaRoot.OcxState = CType(resources.GetObject("FlaRoot.OcxState"), System.Windows.Forms.AxHost.State)
        Me.FlaRoot.Size = New System.Drawing.Size(800, 600)
        Me.FlaRoot.TabIndex = 4
        Me.FlaRoot.TabStop = False
        '
        'FrmRoot
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(7.0!, 12.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink
        Me.ClientSize = New System.Drawing.Size(800, 600)
        Me.Controls.Add(Me.PanelRoot)
        Me.Location = New System.Drawing.Point(40, 40)
        Me.MaximizeBox = False
        Me.Name = "FrmRoot"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Form1"
        Me.PanelRoot.ResumeLayout(False)
        Me.TabControlRoot.ResumeLayout(False)
        Me.Tcp1.ResumeLayout(False)
        Me.Tcp1.PerformLayout()
        CType(Me.FlaRoot, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents PanelRoot As System.Windows.Forms.Panel
    Friend WithEvents TabControlRoot As System.Windows.Forms.TabControl
    Friend WithEvents Tcp1 As System.Windows.Forms.TabPage
    Friend WithEvents Txb4 As System.Windows.Forms.TextBox
    Friend WithEvents Txb3 As System.Windows.Forms.TextBox
    Friend WithEvents Txb2 As System.Windows.Forms.TextBox
    Friend WithEvents Txb1 As System.Windows.Forms.TextBox
    Friend WithEvents Tcp2 As System.Windows.Forms.TabPage
    Friend WithEvents ListViewRoot As System.Windows.Forms.ListView
    Friend WithEvents FlaRoot As Invok.FlaRoot
    Friend WithEvents ComboBoxRoot As System.Windows.Forms.ComboBox

End Class
