using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace HobisTools.Koster
{
    public partial class PopUpForm : Form
    {
        public PopUpForm()
        {
            InitializeComponent();
        }

        // ::
        private void p_This_Load(object sender, EventArgs ea)
        {
        }

        // ::
        private void p_button_1_Click(object sender, EventArgs ea)
        {
            this.Close();
        }
    }
}
