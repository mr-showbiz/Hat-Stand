package hatstand.views
{
	import hatstand.models.Tile;
	
	import spark.components.supportClasses.ItemRenderer;
	
	public class GameboardTileItemRendererViewBase extends ItemRenderer
	{
		
		[Bindable] protected var tileColor:uint;
		[Bindable] protected var tile:Tile;
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if(data)
			{
				tile = data as Tile;
				tileColor = itemIndex%2 == 0 ? 0xC5A56E : 0x141318;
			}
		}
	}
}