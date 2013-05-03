package 
{
 import com.coreyoneil.collision.CollisionGroup;
 import com.coreyoneil.collision.CDK;
 import flash.display.Sprite;
 import flash.display.DisplayObject;
 import flash.display.Stage;
 import flash.events.Event;


	public class BucketCollider extends Sprite
	{
	 private var collisionBucket = new CollisionGroup();
	 private var collisionBucketHistory:Array = [];

		public function BucketCollider()
		{
		 init();
		}

		private function init(e:Event=null):void
		{
		 addEventListener(Event.ENTER_FRAME, check_collisions, false, 0, true);
		 addEventListener(Event.REMOVED_FROM_STAGE, clean, false, 0, true);
		}

		private function clean(e:Event):void
		{
		 removeEventListener(Event.ENTER_FRAME, check_collisions);
		}
		
		public function add_object(obj:Object):void
		{
		 add_item(obj);
		}
		
		public function remove_object(obj:Object):void
		{
		 remove_item(obj);
		}
		
		private function add_item(obj:Object):void
		{
			if ( obj is Array )
			{
				for each (var dispObj:DisplayObject in obj)
				 collisionBucket.addItem(dispObj);
			} else {
			 collisionBucket.addItem(obj);
			}
		}
		
		private function remove_item(obj:Object):void
		{
			if ( obj is Array )
			{
				for each (var dispObj:DisplayObject in obj)
				 collisionBucket.removeItem(dispObj);
			} else {
			 collisionBucket.removeItem(obj);
			}
		}
		
		public function check_collisions(e:Event=null):void
		{
		 var allCollisions:Array = collisionBucket.checkCollisions();
		 var history:Array = collisionBucketHistory;
		 var currentCollisions:Array = [];
			if (allCollisions.length)
			{
				for each (var collision:Object in allCollisions)
				{
				 var collisionPair:Array = [collision.object1, collision.object2];
				 
				 currentCollisions.push(collisionPair);
					
					if (! collision_in_set(collisionPair, history))
					{
					 history.push(collisionPair);
					 collision.object1.collide(collision.object2);
					 collision.object2.collide(collision.object1);
					}
				}
			}
			
			for each (var oldCollision:Array in history)
			{
				if (! collision_in_set(oldCollision, currentCollisions))
				{
				 oldCollision[0].un_collide(oldCollision[1]);
				 oldCollision[1].un_collide(oldCollision[0]);
				 history.splice(history.indexOf(oldCollision), 1);
				}
			}
			
		}
		
		private function collision_in_set(testCollision:Array, collisionSet:Array)
		{
			for each (var collision:Array in collisionSet)
			{
				if (compare_collision_set(collision, testCollision))
				{
				 return true;
				}
			}
		 return false;
		}
		
		private function compare_collision_set(collision1:Array, collision2:Array)
		{
		 return collision1[0] == collision2[0] && collision1[1] == collision2[1];
		}
	}
}