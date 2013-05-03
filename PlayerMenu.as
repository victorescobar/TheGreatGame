package  {
	
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.display.Bitmap;
	
	public class PlayerMenu extends MovieClip implements ICollidable
	{
	 public var player:Player;
	 public var marker:Marker;
	 public var avatar:Avatar;
	 public var territory:Territory;
	 private var countryPic:Bitmap;
	 public var countryOver:String;
// ==================================================================================================================	 
		public function PlayerMenu(player:Player, marker:Marker)
		{
		 this.marker = marker as Marker;
		 this.player = player;
		 countryField.set_format(10, 0x000000, true, "Arial");		 
		 		 
		(stage == null) ? addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true) : init();
		}
// ------------------------------------------------------------------------------------------------------------------ 
		private function init(e:Event=null)
		{
		 this.addEventListener(Event.REMOVED_FROM_STAGE, clean, false, 0, true);
		 this.removeEventListener(Event.ADDED_TO_STAGE, init);
		 this.x	= marker.x;
		 this.y = marker.y;
		 avatar.menuOpen = true;
		 this.player.avatarCollider.add_object(this, "B");
		 
		 
		 //update_fields();
		 orient();
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function clean(e:Event=null):void
		{
		 this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		 this.removeEventListener(Event.REMOVED_FROM_STAGE, clean);
		 avatar.menuOpen = false;
		 this.player.avatarCollider.remove_object(this, "B");
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function accept_item(obj:Object):void
		{
		 	if(obj is Avatar)
			 avatar = obj as Avatar;
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function update_fields():void
		{
		 //gdpField.set_value(gdp.toString());
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function country_field(country:Territory, clearFields:Boolean):void
		{
		 var object = country as Territory;
		 trace(country);
		 
		 	if(clearFields)
			{
			 populationField.set_value("");
	 		 citiesField.set_value("");
	 		 gdpField.set_value("");
	 		 militaryField.set_value("");
	 		 defenceField.set_value("");
	 		 embassyField.set_value("");
	 		 happinessField.set_value("");
	 		 influenceField.set_value("");
	 		 goldField.set_value("");	
			 countryField.set_value("");
			 removeChild(countryPic);
			 countryPic = null;
			} else {
			 populationField.set_value(object.population);
	 		 citiesField.set_value(object.cities);
	 		 gdpField.set_value(object.gdp);
	 		 militaryField.set_value(object.military);
	 		 defenceField.set_value(object.defences);
	 		 embassyField.set_value(object.embassies);
	 		 happinessField.set_value(object.happiness);
	 		 influenceField.set_value(object.influence);
	 		 goldField.set_value(object.gold);	
			 countryField.set_value(object.countryName);
			 set_country_image(object.bd1);
			}
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function set_country_image(image):void
		{
		 var picWidth = 138;
		 var picHeight = 126;
		 
		 
		 	if(countryPic != null)
			{
			 removeChild(countryPic);
			 countryPic = new Bitmap(image);
			 addChild(countryPic);
			} else {
			 countryPic = new Bitmap(image);
			 addChild(countryPic);
			}
		 
		 	if(countryPic.width > picWidth || countryPic.height > picHeight)
			{
			 var extraWidth = countryPic.width - picWidth;
			 var extraHeight = countryPic.height - picHeight;
			 var wScale = picWidth / countryPic.width;
			 var hScale = picHeight / countryPic.height;
			 
			 	if(extraWidth >= extraHeight)
				{
				 countryPic.width = picWidth;
			 	 countryPic.height *= wScale;
				} else {
				 countryPic.height = picHeight;
			 	 countryPic.width *= hScale;
				}
			}
		 
		 var centerX = (picWidth - countryPic.width)/2;
		 var centerY = (picHeight - countryPic.height)/2;
		 
		 countryPic.x = -151 + centerX;
	 	 countryPic.y = -81 + centerY;	
		}
		
// ------------------------------------------------------------------------------------------------------------------ 
		private function orient():void
		{
		 this.x = marker.x;
		 this.y = marker.y;
		 
		 var pointX = player.orientationPoint.x;
		 var pointY = player.orientationPoint.y;
		 var opposite = Math.sqrt(Math.pow(this.y - pointY, 2));
		 var hypotenuse = Math.sqrt((Math.pow(this.y - pointY, 2))+ Math.pow(this.x - pointX, 2));
		 var angle = Math.asin(opposite/hypotenuse)/(Math.PI/180);
		 
			if(x > pointX && y >= pointY)
			 rotation = angle - 90;
			 
			if(x <= pointX && y > pointY)
			 rotation = 90 - angle;
		  
			if(y <= pointY && x < pointX)
			 rotation = angle + 90;
			 
			if(y < pointY && x > pointX)
			 rotation = 270 - angle;
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function collide(obj:DisplayObject):void 
		{
		 
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function un_collide(obj:DisplayObject):void 
		{
		 
		}
// ------------------------------------------------------------------------------------------------------------------ 
	}
}
