package hatstand.models
{
	import mx.collections.ArrayCollection;

	public class Rules
	{
		public static var _instance:Rules;
		
		public function Rules()
		{
		}
		
		public function getInstance() : Rules
		{
			if (_instance == null) {
				_instance = new Rules();
			}
			return _instance;
		}
		
		public function validateMoves(draughtPiece:IDraughtsPiece) : ArrayCollection
		{
			return new ArrayCollection();
		}
			
	}
}
