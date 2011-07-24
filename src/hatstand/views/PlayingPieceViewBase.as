package hatstand.views
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import hatstand.models.DraughtsPiece;
	import hatstand.models.IDraughtsPiece;
	
	import mx.events.FlexEvent;
	
	import spark.components.Group;
	import spark.filters.GlowFilter;

	public class PlayingPieceViewBase extends Group
	{
		private var _draughtsPiece:DraughtsPiece;
		
		[Bindable] public var playingPieceColor:uint;
		
		[Bindable]
		public function set draughtsPiece(value:DraughtsPiece) : void
		{
			_draughtsPiece = value;
			
//			addEventListener(MouseEvent.CLICK, onMouseClick);
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		
		public function get draughtsPiece() : DraughtsPiece
		{
			return _draughtsPiece;
		}
		
//		private function onMouseClick(e:MouseEvent) : void
//		{
//			dispatchEvent(e);
//		}
//		
		private function onRollOver(e:MouseEvent) : void
		{
			this.filters = [ new GlowFilter(0xdd2222, 0.6, 5, 5, 2) ];
		}
		
		private function onRollOut(e:MouseEvent) : void
		{
			this.filters = [ ];
		}
	}
}