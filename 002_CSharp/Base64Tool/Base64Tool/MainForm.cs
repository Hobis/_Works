using System;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows.Forms;

namespace HobisTools.Koster
{
    // #
    public partial class MainForm : Form
    {
        // ::
        public MainForm()
        {
            InitializeComponent();
        }

        // ::
        private void p_This_Load(object sender, EventArgs ea)
        {
            this.Text += " Ver 1.02 Programed By HobisJung";

            this.textBox_1.AllowDrop = true;
            this.textBox_1.DragEnter += this.p_textBox_1_DragEnter;
            this.textBox_1.DragDrop += this.p_textBox_1_DragDrop;

            this._popUp = new PopUpForm();
        }

        // -
        private PopUpForm _popUp = null;


        // ::
        private void p_textBox_1_DragEnter(object sender, DragEventArgs dea)
        {
            if (dea.Data.GetDataPresent(DataFormats.FileDrop))
            {
                dea.Effect = DragDropEffects.Copy;
            }
            else
            {
                dea.Effect = DragDropEffects.None;
            }
        }

        // ::
        private void p_textBox_1_DragDrop(object sender, DragEventArgs dea)
        {
            string[] t_fns = (string[])dea.Data.GetData(DataFormats.FileDrop);
            if (t_fns != null)
            {
                StringBuilder t_sb = new StringBuilder();

                foreach (string t_fn in t_fns)
                {
                    string t_nfn = t_fn;
                    if (t_nfn != null)
                    {
                        t_sb.AppendLine(t_nfn);
                    }
                }

                this.textBox_1.AppendText(t_sb.ToString());
            }
        }

        // ::
        private void p_TWorker_CallBack(object[] args)
        {
            CallBackType t_cbt = (CallBackType)args[0];
            if (t_cbt != null)
            {
                if (t_cbt.Equals(CallBackType.WorkEnd))
                {
                    this._popUp.Invoke((MethodInvoker)delegate()
                    {
                        this._popUp.Close();
                    });
                }
            }
        }

        // :: Binary To Base64String Save
        private void p_button_1_Click(object sender, EventArgs ea)
        {
            string t_text = this.textBox_1.Text;
            if (string.IsNullOrEmpty(t_text)) return;
            if (t_text.Length < 1) return;

            // FilePaths
            string[] t_fps = Regex.Split(t_text, "\r\n");
            TWorker.Start(t_fps, TypeTo.BinaryDataToBase64String, this.p_TWorker_CallBack);

            //
            this._popUp.ShowDialog(this);
        }

        // :: Base64String To Binary Save
        private void p_button_2_Click(object sender, EventArgs ea)
        {
            string t_text = this.textBox_1.Text;
            if (string.IsNullOrEmpty(t_text)) return;
            if (t_text.Length < 1) return;

            // FilePaths
            string[] t_fps = Regex.Split(t_text, "\r\n");
            TWorker.Start(t_fps, TypeTo.Base64StringToBinaryData, this.p_TWorker_CallBack);

            //
            this._popUp.ShowDialog(this);
        }

        // :: Clear
        private void p_button_3_Click(object sender, EventArgs ea)
        {
            this.textBox_1.Clear();
        }

        // ::



/*
        public static string Base64Encode(string src, System.Text.Encoding enc)
        {
            byte[] arr = enc.GetBytes(src);
            return Convert.ToBase64String(arr);
        }

        public static string Base64Decode(string src, System.Text.Encoding enc)
        {
            byte[] arr = Convert.FromBase64String(src);
            return enc.GetString(arr);
        }  */
    }
}
