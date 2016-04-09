package works
{
	import utils.ComUtil;

	/**
	 * ...
	 * @author Hobis
	 */
	public final class UrlWorkHelper
	{
		// ::
		public function UrlWorkHelper()
		{
		}

		// ::
		public static function get_domain(url:String):String
		{
			var t_ms:Array = url.match(/^https?:\/\/[^\/]+\/?/i);
			if (ComUtil.arr_get_isEmpty(t_ms))
			{
				return null;
			}
			else
			{
				var t_m:String = t_ms[0];
				if (t_m.lastIndexOf('/') < (t_m.length - 1))
				{
					t_m += '/';
				}
				return t_m;
			}
		}

		// ::
		public static function get_pathName(url:String):String
		{
			var t_ms:Array = url.match(/[^\/]+$/i);
			if (ComUtil.arr_get_isEmpty(t_ms))
			{
				return url;
			}
			else
			{
				var t_m:String = t_ms[0];
				return url.replace(t_m, '');
			}
		}

		// ::
		public static function get_fileName(url:String):String
		{
			var t_ms:Array = url.match(/[^\/]+$/i);
			if (ComUtil.arr_get_isEmpty(t_ms))
			{
				return null;
			}
			else
			{
				var t_m:String = t_ms[0];
				t_m = escape(t_m);
				return t_m;
			}
		}

		// ::
		public static function get_imgUrl(domain:String, img:String):String
		{
			var t_ms:Array = img.match(/\ssrc\s*=\s*((["'][^"']+["'])|([^>\s]+))/i);
			if (ComUtil.arr_get_isEmpty(t_ms))
			{
				return null;
			}
			else
			{
				var t_m:String = t_ms[0];
				var t_v:String = t_m.split(/^\ssrc\s*=\s*["']?/i)[1];
				t_v = t_v.replace(/["']$/i, '')
				var t_url:String = p_get_imgUrlCheck(domain, t_v);
				if (t_url != null) {
					return t_url;
				}
			}

			return null;
		}

		// ::
		private static function p_get_imgUrlCheck(domain:String, v:String):String
		{
			var t_ms:Array = v.match(/^https?:\/\//i);
			//var t_ms:Array = v.match(/(^https?:\/\/)|(^\/\/)/i);
			if (ComUtil.arr_get_isEmpty(t_ms))
			{
				// 여기서 v이 /로시작인지, ./로시작인지, ../로시작인지 조건넣기
				//^\/
				v = v.replace(/^\/+/, '');
				return domain + v;
			}

			return v;
		}


		// ::
		public static function get_dateTimeStr():String
		{
			var t_d:Date = new Date();
			var t_rv:String =
				t_d.getFullYear().toString() +
				(t_d.getMonth() + 1).toString() +
				t_d.getDate().toString() +
				t_d.getHours().toString() +
				t_d.getMinutes().toString() +
				t_d.getSeconds().toString() +
				t_d.getMilliseconds().toString();
			return t_rv;
		}
	}

}