package
{
 import flash.display.Stage;
 import flash.display.DisplayObject;
 import flash.geom.Point;
 import flash.events.Event;
	
	public class Player
	{
	 public var generator:RandomGenerator = new RandomGenerator();
	 public var orientationPoint:Point = new Point();
	 
	 public var avatarCollider:GroupCollider;
	 public var countryCollider:GroupCollider;
	 public var markerCollider:BucketCollider;
	 public var attack:Attack = new Attack();
// ------------------------------------------------------------------------------------------------------------------
	 public var avatar:Avatar;
	 public var marker:Marker;
	 public var playerMenu:PlayerMenu;
// ------------------------------------------------------------------------------------------------------------------	 
	 public var territoriesOwned:Array = [];
	 public var playerNumber:uint;
	 private var numOfPlayers:Number;
	 private var nonPlayerObjects:Number;
// ================================================================================================================== 
	 public var playerColor:uint;	 
// ================================================================================================================== 	 
		public function Player(playerNumber:uint, numOfPlayers:uint, playerColor:uint, xPos:uint, yPos:uint, colliderA:GroupCollider, colliderC:GroupCollider, colliderM:BucketCollider, stage:Stage)
		{
		 nonPlayerObjects				= stage.numChildren - (2 * numOfPlayers);

		 this.avatarCollider 			= colliderA as GroupCollider;
		 this.countryCollider 			= colliderC as GroupCollider;
		 this.markerCollider 			= colliderM as BucketCollider;

		 this.playerNumber 				= playerNumber;
		 this.playerColor 				= playerColor;
		 this.numOfPlayers 				= numOfPlayers;
		 this.orientationPoint.x 		= stage.stageWidth/2;
		 this.orientationPoint.y 		= stage.stageHeight/2;
		 
		 marker 						= new Marker(this, playerColor, xPos, yPos);
		 playerMenu 					= new PlayerMenu(this, marker);
		 avatar 						= new Avatar(this, marker, playerMenu, xPos, yPos, Avatar.KEYMAPS[playerNumber - 1], playerColor);
		 
		 marker.accept_item(avatar);
		 playerMenu.accept_item(avatar);
		 stage.addChildAt(marker, nonPlayerObjects);
		 stage.addChild(avatar);
		}		
// ------------------------------------------------------------------------------------------------------------------		
		public function add_to_stage(obj:DisplayObject, stage:Stage):void
		{
		 var numOfMenus = 0;
		 
		 	if (obj is PlayerMenu || obj is Marker)
			{
				for (var i = nonPlayerObjects; i < stage.numChildren; i++)
				{
					if(stage.getChildAt(i) is PlayerMenu)
					 numOfMenus++;
				}
			 stage.addChildAt(obj, nonPlayerObjects + numOfMenus);
			} else {
			 stage.addChildAt(obj, nonPlayerObjects); 
			}
		}
// ------------------------------------------------------------------------------------------------------------------		
		public function remove_from_stage(obj:DisplayObject, stage:Stage):void
		{			
		 stage.removeChild(obj);
		}
// ------------------------------------------------------------------------------------------------------------------		
	}
}
