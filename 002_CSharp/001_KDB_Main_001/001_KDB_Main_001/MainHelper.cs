using Cyotek.ApplicationServices.Windows.Forms;
using IWshRuntimeLibrary;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Threading;
using System.Web;
using System.Windows.Forms;

namespace KDB_Edge2
{
    // # 유틸리티 모음
    public static class Utils
    {
        // :: pObj -> qStr
        public static string convert_qStr(NameValueCollection nvc)
        {
            string t_rv = null;

            List<string> t_list = new List<string>();
            foreach (string t_name in nvc)
            {
                string t_value = nvc[t_name];
                t_value = HttpUtility.UrlEncode(t_value);
                string t_str = string.Concat(t_name, "=", t_value);
                t_list.Add(t_str);
            }

            if (t_list.Count > 0)
            {
                t_rv = string.Join("&", t_list.ToArray());
            }

            return t_rv;
        }

        // ::
        public static void regCheck_ie()
        {
/*
            if (InternetExplorerBrowserEmulation.GetBrowserEmulationVersion() != version)
            {
                // apply the new emulation version
                if (!InternetExplorerBrowserEmulation.SetBrowserEmulationVersion(version))
                {
                    MessageBox.Show("Failed to update browser emulation version.", this.Text, MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
                else
                {
                    // now destroy and recreate the WebBrowser control
                    Application.Restart();
                    Environment.Exit(-1);
                }
            }*/

            InternetExplorerBrowserEmulation.SetBrowserEmulationVersion(BrowserEmulationVersion.Version8);
        }


        private const string _Caption = "# 알림";
        // ::
        public static void MsgBox(string str)
        {
            MessageBox.Show(str, _Caption);
        }
    }

    // # File Input Output Util
    public static class FIO_Util
    {
        public static void DirectoryCopy(string sourcePath, string destPath, bool bSub, string shortcutName)
        {
            if (_t == null)
            {
                _t = new Thread(new ThreadStart(delegate()
                {
                    p_DirectoryCopy_Core(sourcePath, destPath, bSub, shortcutName);
                }));
                _t.Start();

                //MessageBox.Show("카피가 진행중 입니다. 잠시만 기다려 주세요.", "# 알림");
            }
            else
            {
                Utils.MsgBox("이미 복사가가 진행중 입니다. 잠시후 다시 시도하여 주세요.");
            }
        }

        private static Thread _t = null;

        private static void p_DirectoryCopy_Core(string sourcePath, string destPath, bool bSub, string shortcutName)
        {
            // Get the subdirectories for the specified directory.
            DirectoryInfo t_dir = new DirectoryInfo(sourcePath);
            DirectoryInfo[] t_dirs = t_dir.GetDirectories();

            if (!t_dir.Exists)
            {
                throw new DirectoryNotFoundException(
                    "Source directory does not exist or could not be found: "
                    + sourcePath);
            }

            // If the destination directory doesn't exist, create it. 
            if (!Directory.Exists(destPath))
            {
                try
                {
                    Directory.CreateDirectory(destPath);
                }
                catch (Exception) { }
            }

            // Get the files in the directory and copy them to the new location.
            FileInfo[] t_files = t_dir.GetFiles();
            foreach (FileInfo t_file in t_files)
            {
                string t_path = Path.Combine(destPath, t_file.Name);
                try
                {
                    t_file.CopyTo(t_path, false);
                }
                catch (Exception) { }
            }
            
            // If copying subdirectories, copy them and their contents to new location. 
            if (bSub)
            {
                foreach (DirectoryInfo t_subdir in t_dirs)
                {
                    string t_path = Path.Combine(destPath, t_subdir.Name);
                    try
                    {
                        p_DirectoryCopy_Core(t_subdir.FullName, t_path, bSub, null);
                    }
                    catch (Exception) { }
                }
            }

            if (shortcutName != null)
            {
                string t_name = Path.GetFileName(Application.ExecutablePath);
                string t_targetPath = Path.Combine(destPath, t_name);
                //Utils.MsgBox("t_targetPath: " + t_targetPath);

                try
                {
                    p_CreateShortcut(t_targetPath, shortcutName);
                }
                catch (Exception)
                {
                }

                _t = null;
            }
        }

        private static void p_CreateShortcut(string filePath, string shortchutName)
        {
            object t_dto = (object)"Desktop";
            WshShell t_ws = new WshShell();
            string t_sca = (string)t_ws.SpecialFolders.Item(ref t_dto) + "\\" + shortchutName + ".lnk";
            IWshShortcut t_wsc = (IWshShortcut)t_ws.CreateShortcut(t_sca);
            //t_wsc.Description = shortchutName;
            //t_wsc.Hotkey = "Ctrl+Shift+N";
            t_wsc.TargetPath = filePath;
            t_wsc.WorkingDirectory = Path.GetDirectoryName(filePath);
            t_wsc.Save();
        }





/*
        private static void p_createShortcutToDesktop(string linkName)
        {
            string t_deskPath = Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory);
            string t_filePath = t_deskPath + "\\" + linkName + ".url";
            string t_exePath = @"C:\Users\Hobis\Desktop\__test\main1.exe";
            using (StreamWriter writer = new StreamWriter(t_filePath, true, Encoding.ASCII))
            {
                writer.WriteLine("[InternetShortcut]");
                writer.WriteLine("URL=file:///" + t_exePath);
                writer.WriteLine("IconIndex=0");
                string icon = t_exePath.Replace('\\', '/');
                writer.WriteLine("IconFile=" + icon);
                writer.Flush();
            }
        }*/
    }
}