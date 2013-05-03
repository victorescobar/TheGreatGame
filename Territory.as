package 
{
 import flash.display.Stage;
 import flash.display.Bitmap;
 import flash.display.BitmapData;
 import flash.display.MovieClip;
 import flash.display.DisplayObject;
 import flash.filters.DisplacementMapFilter;
 import flash.events.Event;
 import flash.display.Sprite;
 import flash.geom.ColorTransform;
 import flash.text.TextFormat;
 import flash.text.TextField;
 import flash.display.Shape;

	public class Territory extends MovieClip implements ICollidable
	{
	 public var player:Player;
	 public var attack:Attack = new Attack();
	 public var economy:Economy = new Economy(313933954);
	 public var bitmap1:Bitmap;
	 public var countryName:String;
// ================================================================================================================== 
	 private var avatar:Avatar;
	 private var marker:Marker;
	 private var attackArrow:Shape = new Shape();
	 public var bd1:BitmapData;
	 private var militaryField = new DynText();
	 private var colorTransformer = new ColorTransform();
	 private var textFormat:TextFormat = new TextFormat();
// ------------------------------------------------------------------------------------------------------------------ 
	 private var avatarOver:Array = [];
	 private var attackX:Number;
	 private var attackY:Number;
// ================================================================================================================== 
	 public var population:uint = 1000;
	 public var cities:uint = 1;
	 public var gdp:Number = 50;
	 public var military:uint = 2;
	 public var defences:Number = 1;
	 public var embassies:uint = 0;
	 public var happiness:uint = 100;
	 public var influence:uint = 1;
	 public var gold:uint = 1000;
	 
	 public var iteration:uint = 0;
		
		public function Territory()
		{	 	 
		 militaryField.set_format(14, 0x000000, true, "Arial");
		(stage == null) ? addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true) : init();
		}
// ------------------------------------------------------------------------------------------------------------------		
		private function init(e:Event=null):void 
		{
		 this.addEventListener(Event.REMOVED_FROM_STAGE, clean, false, 0, true);
		 this.removeEventListener(Event.ADDED_TO_STAGE, init); 
		 create_mask();
		 addChild(bitmap1);
        }
// ------------------------------------------------------------------------------------------------------------------ 
		private function clean(e:Event):void
		{
		 this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		 this.removeEventListener(Event.REMOVED_FROM_STAGE, clean);
		}	
// ------------------------------------------------------------------------------------------------------------------ 
		public function create_military_field():void
		{
		 militaryField.x = militaryField.x + this.x;
		 militaryField.y = militaryField.y + this.y;
		 stage.addChild(militaryField);
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function update_military_field():void
		{
		 militaryField.set_value(military.toString());
		}	
		
// ------------------------------------------------------------------------------------------------------------------ 
		private function create_mask():void
		{
		 bd1  						= new BitmapData(this.width, this.height, true, 0xFF0000);
		 bitmap1  					= new Bitmap(bd1);
		 bitmap1.alpha 				= 0;
		 bd1.draw(this)
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function set_values(xPos:uint, yPos:uint, fieldX:Number, fieldY:Number, countryName:String):void
		{
		 var shiftX = -35.8;
		 var shiftY = -49.3;
		 this.x = xPos + shiftX;
		 this.y = yPos + shiftY;
		 this.countryName = countryName;
		 militaryField.x = fieldX;
		 militaryField.y = fieldY;
		 militaryField.set_value(military.toString());
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function set_owner(player:Player):void
		{
		 this.player = player;
		 colorTransformer.color = player.playerColor;
		 bitmap1.transform.colorTransform = colorTransformer;
		 bitmap1.alpha = 0.34;
		 population += 4000;
		 gdp += 10;
		 military += 10;
		 defences += 2;
		 influence += 2;
		 gold += 500;
		 militaryField.set_value(military.toString());
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function start_attack(e:Event):void
		{
		 this.player.attack.attacker = this as Territory;
		 attackX = avatar.x;
		 attackY = avatar.y;
		 stage.addChild(attackArrow);
		 stage.addEventListener(Event.ENTER_FRAME, draw_attack_line, false, 0, true);
		 avatar.addEventListener(Avatar.UNGRAB, stop_attack, false, 0, true);
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function draw_attack_line(e:Event)
		{
		 attackArrow.graphics.clear();
		 attackArrow.graphics.lineStyle(1, player.playerColor);
		 attackArrow.graphics.moveTo(attackX, attackY);
		 attackArrow.graphics.lineTo(avatar.x, avatar.y);
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function stop_attack(e:Event)
		{
		 attackArrow.graphics.clear();
		 stage.removeEventListener(Event.ENTER_FRAME, draw_attack_line);
		 avatar.removeEventListener(Avatar.UNGRAB, stop_attack);
		 	if(this.player.avatar.tempTerritory != null)
			{
			 this.player.attack.defender = this.player.avatar.tempTerritory as Territory;
			 trace("attacker", this.player.attack.attacker);
		 	 trace("defender", this.player.attack.defender);
			 	if(this.player.attack.defender.player != this.player.attack.attacker.player)
				{
				 this.player.attack.attack_territorys();
				}
			}
		 economy.population_growth();
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function collide(obj:DisplayObject):void 
		{
		 var object:Object;
		 
			 if(obj is Avatar)
			{
			 avatarOver.push(obj);
			 object = obj as Avatar;
				
				if(object.player == this.player)
				{
				 avatar = obj as Avatar; 
				 avatar.addEventListener(Avatar.GRAB, start_attack, false, 0, true);
				}

				if(avatarOver.length == 1) // When first avatar enters.
				{
				 bitmap1.alpha = 0.2;
				}
			}
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function un_collide(obj:DisplayObject):void 
		{
		 var object:Object;
		 
			if(obj is Avatar)
			{
			 avatarOver.splice(avatarOver.indexOf(obj), 1);
			 object = obj as Avatar;
			 
			 	if(object.player == this.player)
				{
				 avatar = obj as Avatar; 
				 avatar.removeEventListener(Avatar.GRAB, start_attack);
				}
			 
				if(!avatarOver.length) // When last avatar leaves.
				{
				 bitmap1.alpha = 0.3;
				} 
			}
		}
// ------------------------------------------------------------------------------------------------------------------ 
	}
}