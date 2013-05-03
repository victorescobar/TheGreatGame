package 
{
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	public class DText extends MovieClip
	{
	 public var currentValue:String;
	 public var format:TextFormat = new TextFormat();
		
		public function DText()
		{
		 format.size = 20;
		 format.color = 0x000000;
		 format.bold = true;
		 fieldValue.defaultTextFormat = format;
		}
		
		public function set_format(tSize:uint=8, tColor:uint=0x000000, tBold:Boolean=false, tFont:String="Arial"):void
		{
		 format.size = tSize;
		 format.color = tColor;
		 format.bold = tBold;
		 fieldValue.defaultTextFormat = format;
		}
		
		public function set_value(fieldValue:String):void
		{
		 currentValue = fieldValue;
		 update_display();
		}

		
		public function add_value(amountAdded:Number):void
		{
		 var newNumber = Number(currentValue) + amountAdded;
		 currentValue = newNumber.toString();
		 update_display();
		}
		
		public function subtract_value(amountSubtracted:Number)
		{
		 var newNumber = Number(currentValue) - amountSubtracted;
		 currentValue = newNumber.toString();
		 update_display();
		}
		
		public function reset():void
		{
		 currentValue = null;
		 update_display();
		}
		
		private function update_display():void
		{
		 	if(currentValue is String)
			{
			 fieldValue.text = currentValue;
			} else {
			 fieldValue.text = currentValue.toString();
			}
		}

	}
	
}
