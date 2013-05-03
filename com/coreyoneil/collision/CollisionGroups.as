package com.coreyoneil.collision
{	
	import flash.display.DisplayObject;
	
	public class CollisionGroups extends CDK
	{
	 public var objectArrayB:Array = [];

		public function CollisionGroups():void 
		{
		 	
		}
		
		public function checkCollisions():Array
		{
			clearArrays();
			
			var GROUPA_OBJS:uint = objectArray.length;
			var GROUPB_OBJS:uint = objectArrayB.length;
			var item1:DisplayObject;
			var item2:DisplayObject;
			
			for(var e:uint = 0; e < GROUPA_OBJS; e++)
			{
			  item1 = DisplayObject(objectArray[e]);
			  
				for(var j:uint = 0; j < GROUPB_OBJS; j++)
				{
				item2 = DisplayObject(objectArrayB[j]);
					
					if(item1.hitTestObject(item2))
					{
						if((item2.width * item2.height) > (item1.width * item1.height))
						{
						 objectCheckArray.push([item1,item2])
						} else {
						 objectCheckArray.push([item2,item1]);
						}
					}
				}
			}
			
			var NUM_OBJS:uint = objectCheckArray.length;
			for(var i = 0; i < NUM_OBJS; i++)
			{
				findCollisions(DisplayObject(objectCheckArray[i][0]), DisplayObject(objectCheckArray[i][1]));
			}
			
			return objectCollisionArray;
		}
		
		public function addGroupItem(obj, group:String):void 
		{
			if(group == "A")
			{
				if(obj is DisplayObject)
				{
				 objectArray.push(obj);
				} else {
				 throw new Error("Cannot add item: " + obj + " - item must be a Display Object.");
				}
			}

			if(group == "B")
			{
				if(obj is DisplayObject)
				{
				 objectArrayB.push(obj);
				} else {
				 throw new Error("Cannot add item: " + obj + " - item must be a Display Object.");
				}
			}
		}
		
		public function removeGroupItem(obj, group:String):void 
		{
		 var loc:int;
		
			if(group == "A")
			{
		 	 loc = objectArray.indexOf(obj);
			 objectArray.splice(loc, 1);
			}

			if(group == "B")
			{	
		 	 loc = objectArrayB.indexOf(obj);
			 objectArrayB.splice(loc, 1);
			}

		}
	}
}