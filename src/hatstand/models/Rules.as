package hatstand.models
{
	import mx.collections.ArrayCollection;

	public class Rules
	{
		public static var _instance:Rules;
		
		public function Rules()
		{
		}
		
		public static function getInstance() : Rules
		{
			return _instance ? _instance : _instance = new Rules();
		}
		
		public function validateMoves(draughtPiece:IDraughtsPiece) : ArrayCollection
		{
			return new ArrayCollection();
		}
		
		private function rule1() : void
		{
			
		}
	}
}
