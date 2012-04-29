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
			
			newGame = new Game();
			newGame.addEventListener("gameOver", onGameOver);
			
			
			gameView = new GameView();
			gameView.game = newGame;
			addElement(gameView);
		}
		
		private function onGameOver(e:Event) : void
		{
			newGame.removeEventListener("gameOver", onGameOver);
			removeElement(gameView);
			
			showStartScreen();
		}
		
	}
}