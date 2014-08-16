using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using System.Windows.Forms;

namespace HB_CopyTest
{
    // #
    public sealed partial class HB_CopyFolderForm : Form
    {
        public HB_CopyFolderForm()
        {
            InitializeComponent();
        }

        // ::
        private void p_This_Load(object sender, EventArgs ea)
        {
            this._lb1.Text = "복사가 진행중 입니다.";
        }

        // ::
        private void p_This_FormClosed(object sender, FormClosedEventArgs fcea)
        {
            HB_CopyFolder.Stop();
        }

        // ::
        private void p_bt1_Click(object sender, EventArgs ea)
        {
            this.Close();
        }

        // ::
        private void p_CopyFolder_CallBack(object[] args)
        {
            this.Close();
        }

        // ::
        public void OpenDialog(Form owner, string purposePath)
        {
            string t_tp = Directory.GetCurrentDirectory();
            string t_pp = Path.Combine(purposePath, owner.Text);
            //MessageBox.Show("t_tp: " + t_tp);
            //MessageBox.Show("t_pp: " + t_pp);

            HB_CopyFolder.Start(this._pb1, t_tp, t_pp, true, true, this.p_CopyFolder_CallBack);
            

            this.ShowDialog(owner);
        }

    }


    // #
    public static class HB_CopyFolder
    {
        // ::
        public static void Start(
                            ProgressBar progressBar,
                            string targetPath,
                            string purposePath,
                            bool bSub,
                            bool bShortcut,
                            Action<object[]> callBack)
        {
            if (Directory.Exists(targetPath))
            {
                if (_th == null)
                {
                    _progressBar = progressBar;
                    _targetPath = targetPath;
                    _purposePath = purposePath;
                    _bSub = bSub;
                    _bShortcut = bShortcut;
                    _callBack = callBack;

                    _th = new Thread(new ThreadStart(p_Start));
                    _th.Start();
                }
            }
        }

        private static Thread _th = null;

        private static ProgressBar _progressBar = null;
        private static string _targetPath = null;
        private static string _purposePath = null;
        private static bool _bSub = false;
        private static bool _bShortcut = false;
        private static Action<object[]> _callBack = null;

        private static List<string> _fps = null;



        // ::
        private static void p_Start()
        {
            p_AddFilePaths(_targetPath);
            if (_fps != null)
            {
                if (_progressBar != null)
                {
                    _progressBar.Minimum = 0;
                    _progressBar.Maximum = _fps.Count;
                    _progressBar.Step = 1;
                    _progressBar.Value = 0;
                }

                p_CopyFiles();
            }
        }

        // ::
        public static void Stop()
        {
            _th = null;
        }

        // ::
        private static void p_WorkClear()
        {
            if (_th != null)
            {
                _progressBar = null;
                _targetPath = null;
                _purposePath = null;
                _bSub = false;
                _bShortcut = false;
                _callBack = null;
                if (_fps != null)
                {
                    _fps.Clear();
                    _fps = null;
                }

                _th = null;
            }
        }

        // ::
        private static void p_AddFilePaths(string path)
        {
            string[] t_fps = Directory.GetFiles(path);

            foreach (string t_fp in t_fps)
            {
                if (_fps == null)
                {
                    _fps = new List<string>();
                }

                _fps.Add(t_fp);
            }

            if (_bSub)
            {
                string[] t_paths = Directory.GetDirectories(path);

                foreach (string t_path in t_paths)
                {
                    p_AddFilePaths(t_path);
                }
            }
        }

        // ::
        private static void p_CopyFiles()
        {
            foreach (string t_fp in _fps)
            {
                if (_th == null)
                {
                    break;
                }
                else
                {
                    string t_tp = t_fp.Replace(_targetPath, _purposePath);
                    //Console.WriteLine("t_fp: " + t_fp);
                    //Console.WriteLine("t_tp: " + t_tp);
                    p_CopyFile(t_fp, t_tp);

                    if (_progressBar != null)
                    {
                        _progressBar.PerformStep();                        
                    }
                }
            }

            Thread.Sleep(1000);
            if (_callBack != null)
            {
                _callBack(new object[] { "End" });
            }


            p_WorkClear();
        }

        // ::
        private static void p_CopyFile(string tp, string pp)
        {
            // PurposePath
            string t_pp = Path.GetDirectoryName(pp);

            if (!Directory.Exists(t_pp))
            {
                Directory.CreateDirectory(t_pp);
            }

            try
            {
                File.Copy(tp, pp, true);
            }
            catch (Exception)
            {
                //Console.WriteLine("e: " + e);
            }
        }
    }
}
