using System;
using System.Windows.Forms;


namespace HB_CopyTest
{
    public static class HB_Starter
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        public static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            HB_ProgressForm1 t_pf = new HB_ProgressForm1();
            _pf = t_pf;
            Application.Run(t_pf);
        }

        internal static HB_ProgressForm1 _pf = null;
    }
}
