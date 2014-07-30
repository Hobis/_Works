package  
{
	import flash.net.FileFilter;
	/**
	 * ...
	 * @author HobisJung
	 */
	public final class MainProxy 
	{		
		public function MainProxy() 
		{
		}
				
		// - New Project Name
		public static const NEW_PROJECT_NAME:String = 'Default';
		// - New Title Name
		public static const NEW_TITLE_NAME:String = 'Begin Tournament';
		

		// - Name
		public static const NAME:String = 'TourLang';
		// - Info Name
		public static const INFO_NAME:String = NAME + ' Ver 1.22';
		// - Programmed By
		public static const INFO_PROGRAMMED_BY:String = 'HobisJung (http://blog.naver.com/jhb0b)';
		// - Comment
		public static const INFO_COMMENT:String =
			'	본 프로그램은 Adobe AIR로 만들어진 토너먼트 관리 프로그램입니다.\n' +
			'	TourLang은 Tournament Ranking을 약칭하여 만든 이름입니다.\n' +
			'	프로그램의 사용은 누구나 공개로 사용 할 수 있습니다.\n' +
			'	개선사항, 건의사항은 jhb0b@naver.com으로 문의 주세요.\n' +
			'	감사합니다. 제작자 올림.\n';
		
		
		// - File Save Extension
		public static const FILE_EX_NAME:String = 'tbd';
		// - File Use Type -> Open
		public static const FILE_USE_TYPE_OPEN:String = 'open';
		// - File Use Type -> Save
		public static const FILE_USE_TYPE_SAVE:String = 'save';
		// - File Filter
		public static const FILE_USE_FILTER:FileFilter = new FileFilter(NAME + ' Binary Data: ', '*.' + FILE_EX_NAME + ';');
		
		// - File Data Folder
		public static const FILE_DATA_FOLDER:String = '_Datas';
		// - File Default Name
		public static const FILE_DEFAULT_NAME:String = 'default.' + FILE_EX_NAME;
	}
}
