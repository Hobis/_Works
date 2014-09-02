namespace HobisTools.Koster
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.textBox_1 = new System.Windows.Forms.TextBox();
            this.button_2 = new System.Windows.Forms.Button();
            this.button_1 = new System.Windows.Forms.Button();
            this.button_3 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // textBox_1
            // 
            this.textBox_1.Location = new System.Drawing.Point(12, 12);
            this.textBox_1.MaxLength = 999999;
            this.textBox_1.Multiline = true;
            this.textBox_1.Name = "textBox_1";
            this.textBox_1.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.textBox_1.Size = new System.Drawing.Size(476, 500);
            this.textBox_1.TabIndex = 0;
            this.textBox_1.WordWrap = false;
            // 
            // button_2
            // 
            this.button_2.Location = new System.Drawing.Point(248, 565);
            this.button_2.Name = "button_2";
            this.button_2.Padding = new System.Windows.Forms.Padding(0, 2, 0, 0);
            this.button_2.Size = new System.Drawing.Size(240, 23);
            this.button_2.TabIndex = 1;
            this.button_2.Text = "Base64String To Binary Save";
            this.button_2.UseVisualStyleBackColor = true;
            this.button_2.Click += new System.EventHandler(this.p_button_2_Click);
            // 
            // button_1
            // 
            this.button_1.Location = new System.Drawing.Point(248, 536);
            this.button_1.Name = "button_1";
            this.button_1.Padding = new System.Windows.Forms.Padding(0, 2, 0, 0);
            this.button_1.Size = new System.Drawing.Size(240, 23);
            this.button_1.TabIndex = 2;
            this.button_1.Text = "Binary To Base64String Save";
            this.button_1.UseVisualStyleBackColor = true;
            this.button_1.Click += new System.EventHandler(this.p_button_1_Click);
            // 
            // button_3
            // 
            this.button_3.Location = new System.Drawing.Point(142, 565);
            this.button_3.Name = "button_3";
            this.button_3.Padding = new System.Windows.Forms.Padding(0, 2, 0, 0);
            this.button_3.Size = new System.Drawing.Size(100, 23);
            this.button_3.TabIndex = 3;
            this.button_3.Text = "Clear";
            this.button_3.UseVisualStyleBackColor = true;
            this.button_3.Click += new System.EventHandler(this.p_button_3_Click);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.ClientSize = new System.Drawing.Size(500, 600);
            this.Controls.Add(this.button_3);
            this.Controls.Add(this.button_1);
            this.Controls.Add(this.button_2);
            this.Controls.Add(this.textBox_1);
            this.Location = new System.Drawing.Point(40, 40);
            this.MaximizeBox = false;
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
            this.Text = "Base64Tool";
            this.Load += new System.EventHandler(this.p_This_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox textBox_1;
        private System.Windows.Forms.Button button_2;
        private System.Windows.Forms.Button button_1;
        private System.Windows.Forms.Button button_3;
    }
}

