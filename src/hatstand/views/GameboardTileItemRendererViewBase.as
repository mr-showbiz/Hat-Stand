package hatstand.views
{
	import spark.components.supportClasses.ItemRenderer;
	
	public class GameboardTileItemRendererViewBase extends ItemRenderer
	{
		
		[Bindable] protected var tileColor:uint; 
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if(data)
			{
				tileColor = itemIndex%2 == 0 ? 0xC5A56E : 0x141318;
			}
		}
	}
}