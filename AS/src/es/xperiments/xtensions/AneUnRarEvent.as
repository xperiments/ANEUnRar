package es.xperiments.xtensions
{
	import flash.events.Event;

	/**
	 * @author xperiments
	 */
	public class AneUnRarEvent extends Event
	{
		public static const ON_EXTRACT_RAR_COMPLETE:String ="on_extract_rar_complete";
		public static const ON_EXTRACT_FILE_COMPLETE:String ="on_extract_file_complete";
		public static const ON_GET_FILES:String ="on_get_files";
		
		public var rarFiles:Array;
		
		public function AneUnRarEvent( type:String, files:Array = null )
		{
			super( type );
			rarFiles = files;
		}
	}
}
