using System;
using System.Windows.Forms;


namespace HB_CopyTest
{
    public static class MainStarter
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        public static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            MainForm t_f = new MainForm();
            Application.Run(t_f);
        }
    }
}
