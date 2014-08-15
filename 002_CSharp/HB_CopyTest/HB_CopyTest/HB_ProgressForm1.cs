using System;
using System.Threading;
using System.Windows.Forms;

namespace HB_CopyTest
{
    // #
    public sealed partial class HB_ProgressForm1 : Form
    {
        public HB_ProgressForm1()
        {
            InitializeComponent();
        }

        // ::
        private void p_This_Load(object sender, EventArgs ea)
        {
            this._lb1.Text = "복사가 진행중 입니다.";

            this._pb1.Minimum = 0;
            this._pb1.Maximum = 10;
            this._pb1.Step = 1;
            this._pb1.Value = 0;


            HB_FIOUtil.FolderCopy(this._pb1, "D:\\_Test", "D:\\_Test2", true, true);
        }

        // ::
        private void p_This_FormClosed(object sender, FormClosedEventArgs fcea)
        {
            HB_FIOUtil.FolderCopy_stop();
        }

        // ::
        private void p_bt1_Click(object sender, EventArgs ea)
        {            
            this.Close();
        }
    }


    // #
    public static class HB_FIOUtil
    {
        private static Thread _th = null;
        private static bool _bLoop = false;

        private static ProgressBar _progressBar;
        private static string _targetPath = null;
        private static string _purposePath = null;
        private static bool _bOverwrite = false;
        private static bool _bShortcut = false;        

        // ::
        public static void FolderCopy(ProgressBar progressBar, string targetPath, string purposePath, bool bOverwrite, bool bShortcut)
        {
            if (_th == null)
            {
                _progressBar = progressBar;
                _targetPath = targetPath;
                _purposePath = purposePath;
                _bOverwrite = bOverwrite;
                _bShortcut = bShortcut;

                ThreadStart t_ts = new ThreadStart(p_FolderCopy);
                _th = new Thread(t_ts);
                _bLoop = true;
                _th.Start();
            }
        }

        // ::
        private static void p_FolderCopy()
        {
            while (_bLoop)
            {
                Thread.Sleep(1000);

                if (_progressBar.Value >= _progressBar.Maximum)
                {
                    HB_Starter._pf.Close();

                    break;
                }
                else
                {
                    _progressBar.PerformStep();
                }
            }

            // DeadWork
            _targetPath = null;
            _purposePath = null;
            _bOverwrite = false;
            _bShortcut = false;
            _th = null;
            _bLoop = false;
        }

        // ::
        private static int p_GetFileCount()
        {
            return 1;
        }

        // ::
        public static void FolderCopy_stop()
        {
            if (_th != null)
            {
                _bLoop = false;
            }
        }
    }
}
