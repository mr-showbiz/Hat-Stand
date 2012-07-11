package hatstand 
{
	import flash.events.Event;
	
	import hatstand.views.GameView;
	import hatstand.views.StartScreenView;
	
	import spark.components.Application;
	
	public class HatstandBase extends Application
	{
		private var startScreen:StartScreenView;
		public var gameView:GameView;
		
		public function HatstandBase()
		{
			showStartScreen();
		}
		
		private function showStartScreen() : void
		{
			startScreen = new StartScreenView();
			startScreen.addEventListener("startGame", onStartGame);
			addElement(startScreen);
		}
				
		private function onStartGame(e:Event) : void
		{
			startScreen.removeEventListener("startGame", onStartGame);
			removeElement(startScreen);
			
			gameView = new GameView();
			gameView.addEventListener("gameOver", onGameOver);
			
			addElement(gameView);
		}
		
		private function onGameOver(e:Event) : void
		{
			gameView.removeEventListener("gameOver", onGameOver);
			removeElement(gameView);
			
			showStartScreen();
		}
		
	}
}