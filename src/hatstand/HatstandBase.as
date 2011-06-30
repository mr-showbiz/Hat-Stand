package hatstand 
{
	import hatstand.models.Game;
	
	import spark.components.Application;
	
	public class HatstandBase extends Application
	{
		public function HatstandBase()
		{
			super();
			
			var newGame:Game = new Game();
		}
	}
}