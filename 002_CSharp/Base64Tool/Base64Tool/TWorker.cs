using System;
using System.IO;
using System.Text;
using System.Threading;


namespace HobisTools.Koster
{
    // #
    public enum TypeTo
    {
        None,
        BinaryDataToBase64String,
        Base64StringToBinaryData
    }

    // #
    public enum CallBackType
    {
        WorkEnd
    }

    // #
    internal static class IOUtils
    {
        public static void StreamDispose(IDisposable ido)
        {
            if (ido != null)
            {
                ido.Dispose();
            }
        }
    }

    // #
    public static class Debug
    {
        public static void Log(string msg)
        {
            Console.WriteLine("# [hb] " + msg);
        }
    }

    // #
    public static class TWorker
    {
        //-
        private static TypeTo _type = TypeTo.None;
        // -
        private static Action<object[]> _callBack = null;
        // -
        private static Thread _th = null;
        // -
        private static string[] _fps = null;

        // -
        private const int _Delay = 100;
        // -
        private const string _ExeName_Base64 = ".base64str";
        // -
        private const string _OutDir_Base64 = "_Out_Base64";
        // -
        private const string _OutDir_Binary = "_Out_Binary";


        // ::
        public static void Stop()
        {
            _th = null;
        }

        // ::
        public static void Start(string[] fps, TypeTo type, Action<object[]> callBack)
        {
            if (fps == null) return;

            if (_th == null)
            {
                _fps = fps;
                _type = type;
                _callBack = callBack;

                _th = new Thread(new ThreadStart(p_Work));
                _th.Start();
            }
        }
        
        // -
        const int _BUFF_SIZE = 3 * (1024 * 1);

        // ::
        private static void p_Work()
        {
            foreach (string t_fp in _fps)
            {
                if (_th == null)
                {
                    //
                    break;
                }
                else
                {
                    // 파일이 있으면
                    if (File.Exists(t_fp))
                    {
                        switch (_type)
                        {
                            // 
                            case TypeTo.BinaryDataToBase64String:
                                {
                                    FileInfo t_fi = new FileInfo(t_fp);
                                    //
                                    if (!t_fi.Extension.Equals(_ExeName_Base64))
                                    {
                                        // 읽기전용 스트림
                                        FileStream t_rfs = null;

                                        // 쓰기전용 스트림
                                        FileStream t_wfs = null;

                                        try
                                        {
                                            t_rfs = File.OpenRead(t_fp);
                                        }
                                        catch (Exception) {}

                                        try
                                        {
                                            string t_outPath = Path.Combine(Directory.GetParent(t_fp).FullName, _OutDir_Base64);
                                            if (!Directory.Exists(t_outPath))
                                            {
                                                // 없으면 만들고
                                                Directory.CreateDirectory(t_outPath);
                                            }
                                            string t_outFile = Path.Combine(t_outPath, t_fi.Name + _ExeName_Base64);
                                            //Debug.Log("t_outFile: " + t_outFile);
                                            t_wfs = File.OpenWrite(t_outFile);
                                        }
                                        catch (Exception) {}

                                        //Debug.Log("t_rfs: " + t_rfs);
                                        //Debug.Log("t_wfs: " + t_wfs);
                                        if
                                        (
                                            (t_rfs != null) &&
                                            (t_wfs != null)
                                        )
                                        {
                                            StreamWriter t_sw = new StreamWriter(t_wfs);

                                            //
                                            byte[] t_buff = new byte[_BUFF_SIZE];
                                            //
                                            long t_totalCount = t_rfs.Length;
                                            long t_rpos = 0;
                                            long t_rest = 0;
                                            //
                                            int t_offset = 0;
                                            int t_count = t_buff.Length;
                                            //
                                            while (true)
                                            {
                                                if (t_rpos < t_totalCount)
                                                {
                                                    t_rest = t_totalCount - t_rpos;
                                                    if (t_rest < _BUFF_SIZE)
                                                    {
                                                        t_count = (int)t_rest;
                                                    }

                                                    t_rpos += t_rfs.Read(t_buff, t_offset, t_count);
                                                    t_sw.Write(Convert.ToBase64String(t_buff, t_offset, t_count));

                                                    //Console.WriteLine("t_totalCount: " + t_totalCount);
                                                    //Console.WriteLine("t_readPos: " + t_rpos);
                                                    //Console.WriteLine("t_rest: " + t_rest);
                                                    //Console.WriteLine("t_count: " + t_count);
                                                }
                                                else
                                                {
                                                    break;
                                                }
                                            }

                                            //
                                            IOUtils.StreamDispose(t_sw);
                                        }

                                        //
                                        IOUtils.StreamDispose(t_rfs);
                                        IOUtils.StreamDispose(t_wfs);
                                    }

                                    //
                                    break;
                                }

                            // 
                            case TypeTo.Base64StringToBinaryData:
                                {
                                    FileInfo t_fi = new FileInfo(t_fp);                                    
                                    //
                                    if (t_fi.Extension.Equals(_ExeName_Base64))
                                    {
                                        // 읽기전용 스트림
                                        FileStream t_rfs = null;

                                        // 쓰기전용 스트림
                                        FileStream t_wfs = null;

                                        try
                                        {
                                            t_rfs = File.OpenRead(t_fp);
                                        }
                                        catch (Exception) {}

                                        try
                                        {
                                            string t_outPath = Path.Combine(Directory.GetParent(t_fp).FullName, _OutDir_Binary);
                                            if (!Directory.Exists(t_outPath))
                                            {
                                                // 없으면 만들고
                                                Directory.CreateDirectory(t_outPath);
                                            }
                                            string t_fileName = t_fi.Name.Replace(_ExeName_Base64, "");
                                            string t_outFile = Path.Combine(t_outPath, t_fileName);
                                            //Debug.Log("t_outFile: " + t_outFile);
                                            t_wfs = File.OpenWrite(t_outFile);
                                        }
                                        catch (Exception) {}                                        

                                        //Debug.Log("t_rfs: " + t_rfs);
                                        //Debug.Log("t_wfs: " + t_wfs);
                                        if
                                        (
                                            (t_rfs != null) &&
                                            (t_wfs != null)
                                        )
                                        {
                                            byte[] t_buff = new byte[t_rfs.Length];
                                            t_rfs.Read(t_buff, 0, t_buff.Length);
                                            byte[] t_bytes = Convert.FromBase64String(Encoding.Default.GetString(t_buff));
                                            t_wfs.Write(t_bytes, 0, t_bytes.Length);

                                            /*
                                            //
                                            byte[] t_buff = new byte[_BUFF_SIZE];
                                            //
                                            long t_totalCount = t_rfs.Length;
                                            long t_rpos = 0;
                                            long t_rest = 0;
                                            //
                                            int t_offset = 0;
                                            int t_count = t_buff.Length;
                                            //
                                            while (true)
                                            {
                                                if (t_rpos < t_totalCount)
                                                {
                                                    t_rest = t_totalCount - t_rpos;
                                                    if (t_rest < _BUFF_SIZE)
                                                    {
                                                        t_count = (int)t_rest;
                                                    }

                                                    t_rpos += t_rfs.Read(t_buff, t_offset, t_count);
                                                    //
                                                    string t_str = Encoding.Default.GetString(t_buff);
                                                    byte[] t_bytes = Convert.FromBase64String(t_str);
                                                    t_wfs.Write(t_bytes, 0, t_bytes.Length);

                                                    Console.WriteLine("t_totalCount: " + t_totalCount);
                                                    Console.WriteLine("t_readPos: " + t_rpos);
                                                    Console.WriteLine("t_rest: " + t_rest);
                                                    Console.WriteLine("t_count: " + t_count);
                                                }
                                                else
                                                {
                                                    break;
                                                }
                                            }*/

                                        }

                                        //
                                        IOUtils.StreamDispose(t_rfs);
                                        IOUtils.StreamDispose(t_wfs);
                                    }

                                    //
                                    break;
                                }
                        }

                        //
                        Thread.Sleep(_Delay);
                    }
                }
            }

            _callBack(new object[] {CallBackType.WorkEnd});
            //
            p_Clear();
        }

        // ::
        private static void p_Clear()
        {
            if (_th != null)
            {
                _type = TypeTo.None;
                _callBack = null;
                _fps = null;

                _th = null;
            }
        }
    }
}
