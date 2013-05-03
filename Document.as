package
{
 import flash.display.Stage;
 import flash.display.StageDisplayState;
 import flash.display.StageAlign;
 import flash.display.StageScaleMode;
 import flash.display.MovieClip;
 import flash.system.Capabilities;
 import flash.events.Event;
 import flash.events.MouseEvent;
 import flash.display.DisplayObject;
 import flash.sensors.Accelerometer;
	
	
	public class Document extends MovieClip
	{
	 private var gameType:GameType = new GameType(stage);
	 private var randNum:RandomGenerator = new RandomGenerator();
	 
		public function Document()
		{
		 //                  (numOfPlayers, territoriesEach, stage)
		 gameType.create_game(     2,             6,        stage);
		}
// -----------------------------------------------------------------------	

		
	}
}
