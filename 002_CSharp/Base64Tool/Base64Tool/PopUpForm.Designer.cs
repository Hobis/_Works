namespace HobisTools.Koster
{
    partial class PopUpForm
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
            this.label_1 = new System.Windows.Forms.Label();
            this.button_1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label_1
            // 
            this.label_1.AutoSize = true;
            this.label_1.Font = new System.Drawing.Font("Gulim", 22F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(129)));
            this.label_1.Location = new System.Drawing.Point(12, 9);
            this.label_1.Name = "label_1";
            this.label_1.Size = new System.Drawing.Size(156, 30);
            this.label_1.TabIndex = 0;
            this.label_1.Text = "Process...";
            // 
            // button_1
            // 
            this.button_1.Location = new System.Drawing.Point(213, 165);
            this.button_1.Name = "button_1";
            this.button_1.Padding = new System.Windows.Forms.Padding(0, 2, 0, 0);
            this.button_1.Size = new System.Drawing.Size(75, 23);
            this.button_1.TabIndex = 1;
            this.button_1.Text = "Cancel";
            this.button_1.UseVisualStyleBackColor = true;
            this.button_1.Click += new System.EventHandler(this.p_button_1_Click);
            // 
            // PopUpForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(300, 200);
            this.Controls.Add(this.button_1);
            this.Controls.Add(this.label_1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "PopUpForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Progress";
            this.Load += new System.EventHandler(this.p_This_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label_1;
        private System.Windows.Forms.Button button_1;
    }
}