namespace HB_CopyTest
{
    partial class HB_ProgressForm1
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
            this._lb1 = new System.Windows.Forms.Label();
            this._pb1 = new System.Windows.Forms.ProgressBar();
            this._bt1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // _lb1
            // 
            this._lb1.AutoSize = true;
            this._lb1.Font = new System.Drawing.Font("Gulim", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(129)));
            this._lb1.Location = new System.Drawing.Point(12, 9);
            this._lb1.Name = "_lb1";
            this._lb1.Size = new System.Drawing.Size(157, 16);
            this._lb1.TabIndex = 0;
            this._lb1.Text = "카피가 진행중입니다";
            // 
            // _pb1
            // 
            this._pb1.Location = new System.Drawing.Point(15, 65);
            this._pb1.Name = "_pb1";
            this._pb1.Size = new System.Drawing.Size(115, 23);
            this._pb1.TabIndex = 1;
            // 
            // _bt1
            // 
            this._bt1.Location = new System.Drawing.Point(136, 65);
            this._bt1.Name = "_bt1";
            this._bt1.Padding = new System.Windows.Forms.Padding(0, 2, 0, 0);
            this._bt1.Size = new System.Drawing.Size(52, 23);
            this._bt1.TabIndex = 2;
            this._bt1.Text = "취소";
            this._bt1.UseVisualStyleBackColor = true;
            this._bt1.Click += new System.EventHandler(this.p_bt1_Click);
            // 
            // HB_ProgressForm1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.ClientSize = new System.Drawing.Size(200, 100);
            this.ControlBox = false;
            this.Controls.Add(this._bt1);
            this.Controls.Add(this._pb1);
            this.Controls.Add(this._lb1);
            this.Name = "HB_ProgressForm1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "확인창";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.p_This_FormClosed);
            this.Load += new System.EventHandler(this.p_This_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label _lb1;
        private System.Windows.Forms.ProgressBar _pb1;
        private System.Windows.Forms.Button _bt1;
    }
}

