package hatstand 
{
	import flash.events.Event;
	
	import hatstand.models.Game;
	import hatstand.views.GameView;
	import hatstand.views.StartScreenView;
	
	import spark.components.Application;
	
	public class HatstandBase extends Application
	{
		[Bindable] public var newGame:Game;
		
		private var startScreen:StartScreenView;
		
		public function HatstandBase()
		{
			startScreen = new StartScreenView();
			startScreen.addEventListener("startGame", onStartGame);
			addElement(startScreen);
		}
		
		private function onStartGame(e:Event) : void
		{
			startScreen.removeEventListener("startGame", onStartGame);
			removeElement(startScreen);
			
			newGame = new Game();
			
			var gameView:GameView = new GameView();
			gameView.game = newGame;
			addElement(gameView);
		}
	}
}