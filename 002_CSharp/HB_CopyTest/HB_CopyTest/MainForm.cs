using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace HB_CopyTest
{
    public sealed partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }

        private HB_CopyFolderForm _cff = null;
        

        // ::
        private void p_This_Load(object sender, EventArgs ea)
        {
            this._cff = new HB_CopyFolderForm();
        }

        // ::
        private void bt1_Click(object sender, EventArgs ea)
        {
            DialogResult t_dr = this.folderBrowserDialog1.ShowDialog(this);
            if (t_dr.Equals(DialogResult.OK))
            {
                this._cff.OpenDialog(this, this.folderBrowserDialog1.SelectedPath);
            }
        }
    }
}
