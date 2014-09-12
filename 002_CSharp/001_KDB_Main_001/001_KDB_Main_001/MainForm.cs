using System;
using System.Collections.Specialized;
using System.Configuration;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Web;
using System.Windows.Forms;

namespace KDB_Edge2
{
    public sealed partial class MainForm : Form
    {
        // :: 생성자
        public MainForm()
        {
            InitializeComponent();
            this.p_InitOnce();
        }

        // :: 한번 초기화
        private void p_InitOnce()
        {
            //Utils.regCheck_ie();


            //string t_startPath = Path.Combine(Environment.CurrentDirectory, "root");
            //Environment.CurrentDirectory = t_startPath;

            // 타이틀 설정
            try
            {
                string t_v = ConfigurationManager.AppSettings.Get("Title");
                if (!string.IsNullOrEmpty(t_v))
                {
                    this.Text = t_v;
                }
            }
            catch (Exception)
            {
            }

            // 최대화 사이즈 설정
            try
            {
                string t_v = ConfigurationManager.AppSettings.Get("MaximumSize");
                if (!string.IsNullOrEmpty(t_v))
                {
                    string[] t_vs = t_v.Split(',');
                    Size t_s = new Size();
                    t_s.Width = int.Parse(t_vs[0]);
                    t_s.Height = int.Parse(t_vs[1]);
                    this.MaximumSize = t_s;
                }
            }
            catch (Exception)
            {
            }

            // 최소화 사이즈 설정
            try
            {
                string t_v = ConfigurationManager.AppSettings.Get("MinimumSize");
                if (!string.IsNullOrEmpty(t_v))
                {
                    string[] t_vs = t_v.Split(',');
                    Size t_s = new Size();
                    t_s.Width = int.Parse(t_vs[0]);
                    t_s.Height = int.Parse(t_vs[1]);
                    this.MinimumSize = t_s;
                }
            }
            catch (Exception)
            {
            }

            // 사이즈 설정
            try
            {
                string t_v = ConfigurationManager.AppSettings.Get("Size");
                if (!string.IsNullOrEmpty(t_v))
                {
                    string[] t_vs = t_v.Split(',');
                    Size t_s = new Size();
                    t_s.Width = int.Parse(t_vs[0]);
                    t_s.Height = int.Parse(t_vs[1]);
                    this.Size = t_s;
                }
            }
            catch (Exception)
            {
            }

            // 클라이언트 사이즈 설정
            try
            {
                string t_v = ConfigurationManager.AppSettings.Get("ClientSize");
                if (!string.IsNullOrEmpty(t_v))
                {
                    string[] t_vs = t_v.Split(',');
                    Size t_s = new Size();
                    t_s.Width = int.Parse(t_vs[0]);
                    t_s.Height = int.Parse(t_vs[1]);
                    this.ClientSize = t_s;
                }
            }
            catch (Exception)
            {
            }

            // 위치 설정
            try
            {
                string t_v = ConfigurationManager.AppSettings.Get("Location");
                if (!string.IsNullOrEmpty(t_v))
                {
                    string[] t_vs = t_v.Split(',');
                    Point t_p = new Point();
                    t_p.X = int.Parse(t_vs[0]);
                    t_p.Y = int.Parse(t_vs[1]);
                    this.StartPosition = FormStartPosition.Manual;
                    this.Location = t_p;
                }
            }
            catch (Exception)
            {
            }

            // 윈도우 상태 설정
            try
            {
                string t_v = ConfigurationManager.AppSettings.Get("WindowState");
                if (!string.IsNullOrEmpty(t_v))
                {
                    FormWindowState t_ev = (FormWindowState)Enum.Parse(typeof(FormWindowState), t_v);
                    this.WindowState = t_ev;
                }
            }
            catch (Exception)
            {
            }

            // 폼보더 스타일 설정
            try
            {
                string t_v = ConfigurationManager.AppSettings.Get("FormBorderStyle");
                if (!string.IsNullOrEmpty(t_v))
                {
                    FormBorderStyle t_ev = (FormBorderStyle)Enum.Parse(typeof(FormBorderStyle), t_v);
                    this.FormBorderStyle = t_ev;
                }
            }
            catch (Exception)
            {
            }

            // 시작 포지션 설정
            try
            {
                string t_v = ConfigurationManager.AppSettings.Get("StartPosition");
                if (!string.IsNullOrEmpty(t_v))
                {
                    FormStartPosition t_ev = (FormStartPosition)Enum.Parse(typeof(FormStartPosition), t_v);
                    this.StartPosition = t_ev;
                }
            }
            catch (Exception)
            {
            }

            // 윈도우 전체화 설정
            try
            {
                string t_v = ConfigurationManager.AppSettings.Get("WindowFullScreen");
                if (!string.IsNullOrEmpty(t_v))
                {
                    bool t_b = bool.Parse(t_v);
                    this.p_SetFullScreen(t_b);
                }
            }
            catch (Exception)
            {
            }

            // 녹음파일저장폴더이름
            try
            {
                string t_v = ConfigurationManager.AppSettings.Get("RecordSaveFolderName");
                if (!string.IsNullOrEmpty(t_v))
                {
                    this._saveFolderName = t_v;
                }
            }
            catch (Exception)
            {
            }


            //
            this.webBrowser1.ObjectForScripting = this;
            this.webBrowser1.IsWebBrowserContextMenuEnabled = false;
            this.webBrowser1.AllowWebBrowserDrop = false;
            this.webBrowser1.ScrollBarsEnabled = false;
            this.webBrowser1.ScriptErrorsSuppressed = false;
            this.webBrowser1.WebBrowserShortcutsEnabled = false;

            string t_name = Path.GetFileNameWithoutExtension(Application.ExecutablePath);
            string t_src = Path.Combine(Environment.CurrentDirectory, "root");
            t_src = Path.Combine(t_src, t_name + ".html" + _TakeOver);
            this.webBrowser1.Navigate(t_src);

            this._pucf = new CopyFolderForm();
        }

        // -
        private const string _TakeOver = "?type=!__%40%23%24takeOver";
        // :: 현재 폼 로드완료 (2빠따로 호출됨)
        private void p_This_Load(object sender, EventArgs ea)
        {
            //Utils.Log("p_This_Load");
        }

        // :: 웹브라우저 Document 로드완료 (1빠따로 호출됨)
        private void p_webBrowser1_DocumentCompleted(object sender, WebBrowserDocumentCompletedEventArgs ebdcea)
        {
            //Utils.Log("p_webBrowser1_DocumentCompleted");
        }

        // :: 웹브라우저 키다운 핸들러
        private void p_webBrowser1_PreviewKeyDown(object sender, PreviewKeyDownEventArgs pkdea)
        {
            switch (pkdea.KeyCode)
            {
            /*
            case Keys.Escape:
                {
                    this.p_SetFullScreen(false);

                    break;
                }*/

            case Keys.F5:
                {
                    NameValueCollection t_nvc = new NameValueCollection();
                    t_nvc.Add("type", "reload");
                    this.p_Web_Call(t_nvc);


                    break;
                }
            }
        }

        /*
        // -
        private const int _WM_SYSCOMMAND = 0x112;
        // -
        private const int _SC_MAXIMIZE = 0xf030;
        // ::
        protected override void WndProc(ref Message m)
        {
            if (m.Msg.Equals(_WM_SYSCOMMAND))
            {
                if (m.WParam.ToInt32().Equals(_SC_MAXIMIZE))
                {
                    this.p_FullScreen_Toggle();
                    return;
                }
            }

            base.WndProc(ref m);
        }*/

        /*
        private const int _CP_NOCLOSE_BUTTON = 0x200;
        protected override CreateParams CreateParams
        {
            get
            {
                CreateParams t_cp = base.CreateParams;
                t_cp.ClassStyle = t_cp.ClassStyle | _CP_NOCLOSE_BUTTON;
                return t_cp;
            }
        }*/

        // :: 풀스크린 토글
        private void p_FullScreen_Toggle()
        {
            if (this.TopMost)
            {
                this.p_SetFullScreen(false);
            }
            else
            {
                this.p_SetFullScreen(true);
            }
        }

        //-
        private Size _tempSize = Size.Empty;
        // :: 풀스크린 설정
        private void p_SetFullScreen(bool b)
        {
            if (b)
            {
                if (!this.TopMost)
                {
                    this.TopMost = true;
                    this._tempSize = this.Size;
                    this.FormBorderStyle = FormBorderStyle.None;
                    this.WindowState = FormWindowState.Maximized;
                    this.webBrowser1.Focus();
                }
            }
            else
            {
                if (this.TopMost)
                {
                    this.TopMost = false;
                    this.WindowState = FormWindowState.Normal;
                    this.FormBorderStyle = FormBorderStyle.Sizable;
                    this.Size = this._tempSize;
                    this._tempSize = Size.Empty;
                }
            }
        }

        // -
        private const string _Web_CallName = "p_web_callBack";
        // :: Web 호출
        private void p_Web_Call(NameValueCollection nvc)
        {
            string t_qStr = Utils.convert_qStr(nvc);

            try
            {
                this.webBrowser1.Document.InvokeScript(_Web_CallName, new object[] {t_qStr});
            }
            catch (Exception)
            {
            }
        }


        // -
        private string _saveFolderName = "KDB_녹음파일저장";


        // -
        private CopyFolderForm _pucf = null;


        // :: Form 콜백받음
        /*
        Form_Init
        Form_Close
        Form_Set_Title
        Form_Set_Visible
        Form_Set_Location
        Form_Center_Location
        Form_Resize_FullScreen
        Form_Resize_Min
        Form_Resize_Normal
        Form_Resize
        Form_File_Open
        Form_File_Base64ToBinarySave
        Form_Folder_Copy
        Form_Folder_Open_SoundSave
        */
        public void Form_CallBack(string qStr)
        {
            NameValueCollection t_nvc = HttpUtility.ParseQueryString(qStr);
            string t_type = t_nvc["type"];
            //Utils.MsgBox("t_type: " + t_type);

            switch (t_type)
            {
                // Form 초기화
                case "Form_Init":
                    {
                        //
                        break;
                    }

                // Form 닫기
                case "Form_Close":
                    {
                        this.Close();
                        //
                        break;
                    }

                // Form 타이틀 변경
                case "Form_Set_Title":
                    {
                        string t_title = t_nvc["title"];
                        this.Text = t_title;
                        //
                        break;
                    }

                // Form 보이기 변경
                case "Form_Set_Visible":
                    {
                        bool t_b = bool.Parse(t_nvc["b"]);
                        this.Visible = t_b;
                        //
                        break;
                    }
 
                // Form 위치 변경
                case "Form_Set_Location":
                    {
                        this.WindowState = FormWindowState.Normal;
                        Point t_p = this.Location;
                        t_p.X = int.Parse(t_nvc["x"]);
                        t_p.Y = int.Parse(t_nvc["y"]);
                        this.Location = t_p;
                        //
                        break;
                    }

                // Form 위치 가운데로
                case "Form_Center_Location":
                    {
                        this.CenterToScreen();
                        //
                        break;
                    }

                // Form 사이즈 풀스크린
                case "Form_Resize_FullScreen":
                    {
                        bool t_b = bool.Parse(t_nvc["b"]);
                        this.p_SetFullScreen(t_b);
                        //
                        break;
                    }

                // Form 사이즈 최대화
                case "Form_Resize_Max":
                    {
                        this.WindowState = FormWindowState.Maximized;
                        //
                        break;
                    }

                // Form 사이즈 최소화
                case "Form_Resize_Min":
                    {
                        this.WindowState = FormWindowState.Minimized;                        
                        //
                        break;
                    }

                // Form 사이즈 노멀
                case "Form_Resize_Normal":
                    {
                        this.WindowState = FormWindowState.Normal;
                        //
                        break;
                    }

                // Form 사이즈 변경
                case "Form_Resize":
                    {
                        this.WindowState = FormWindowState.Normal;
                        Size t_s = this.Size;
                        t_s.Width = int.Parse(t_nvc["w"]);
                        t_s.Height = int.Parse(t_nvc["h"]);
                        this.ClientSize = t_s;
                        //
                        break;
                    }

                // Form 파일 열기
                case "Form_File_Open":
                    {
                        string t_path = t_nvc["filePath"];
                        //Utils.Log("t_path: " + t_path);

                        if (string.IsNullOrEmpty(t_path)) return;

                        //
                        ProcessStartInfo t_psi = new ProcessStartInfo();
                        t_psi.WorkingDirectory = Path.GetDirectoryName(t_path);
                        //Utils.Log("t_psi.WorkingDirectory: " + t_psi.WorkingDirectory);

                        t_psi.FileName = Path.GetFileName(t_path);
                        //Utils.Log("t_psi.FileName: " + t_psi.FileName);

                        Process.Start(t_psi);
                        //
                        break;
                    }

                // Form Base64String을 Binary로 저장
                case "Form_File_Base64ToBinarySave":
                    {
                        string t_base64Str = t_nvc["base64Str"];
                        string t_saveName = t_nvc["saveName"];

                        if (string.IsNullOrEmpty(t_base64Str) ||
                            string.IsNullOrEmpty(t_saveName)) return;

                        //
                        this.Enabled = false;
                        
                        byte[] t_bytes = null;
                        FileStream t_wfs = null;

                        try
                        {
                            t_bytes = Convert.FromBase64String(t_base64Str);
                        }
                        catch (Exception)
                        {
                        }

                        if (t_bytes != null)
                        {
                            try
                            {
                                string t_basePath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
                                t_basePath = Path.Combine(t_basePath, this._saveFolderName);
                                if (!Directory.Exists(t_basePath))
                                {
                                    Directory.CreateDirectory(t_basePath);
                                }

                                string t_saveFile = Path.Combine(t_basePath, t_saveName);
                                //Util.MegBox("대체 위치가 어디여? " + t_saveFile);
                                //
                                t_wfs = File.OpenWrite(t_saveFile);
                                t_wfs.Write(t_bytes, 0, t_bytes.Length);

                                Utils.MsgBox("녹음이 저장되었습니다.");
                            }
                            catch (Exception)
                            {
                            }
                        }

                        if (t_wfs != null)
                            t_wfs.Close();


                        this.Enabled = true;
                        //
                        break;
                    }

                // Form 폴더 카피
                case "Form_Folder_Copy":
                    {
                        DialogResult t_dr = this.folderBrowserDialog1.ShowDialog();
                        if (t_dr.Equals(DialogResult.OK))
                        {
                            string t_scn = this.Text;
                            string t_tp = Environment.CurrentDirectory;
                            string t_pp = Path.Combine(this.folderBrowserDialog1.SelectedPath, t_scn);
                            //MessageBox.Show("t_tp: " + t_tp);
                            //MessageBox.Show("t_pp: " + t_pp);

                            this._pucf.OpenDialog(this, t_tp, t_pp, true, t_scn);
                        }
                        //
                        break;
                    }

                // Form 녹음 사운드 저장 폴더 열기
                case "Form_Folder_Open_SoundSave":
                    {
                        string t_basePath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
                        //string t_saveFolder = this.Text;
                        string t_saveFolder = this._saveFolderName;
                        t_basePath = Path.Combine(t_basePath, t_saveFolder);
                        if (Directory.Exists(t_basePath))
                        {
                            Process.Start(t_basePath);
                        }
                        //
                        break;
                    }
            }

        }
    }
}
