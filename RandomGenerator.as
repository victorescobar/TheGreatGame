package  
{
 import flash.display.Stage;
 import flash.display.MovieClip;
 import flash.events.Event;
 import flash.display.DisplayObject;
 
	public class RandomGenerator extends MovieClip
	{
	 public var diceRolls:Array  = [];

		public function RandomGenerator() 
		{	 
		 
		}
// ------------------------------------------------------------------------------------------------------------------
		public function run_random_generator(iterationsNum:uint, min:uint, max:uint, duplicates:Boolean=true):Array
		{
		 diceRolls = []; // Clear "DiceRolls"
		 for(var i = 0; i < iterationsNum; ++i) // Populate "DiceRolls" with as many Random Numbers as "iterationsNum" dictates
			{
			 random_number(min, max, duplicates); // Generate Random Number based on parameters
			}
		 return diceRolls; // After "DiceRolls" has been populated return all values
		 diceRolls = []; // Clear "DiceRolls"
		}
// ------------------------------------------------------------------------------------------------------------------
		private function random_number(min:Number, max:Number, duplicates:Boolean):void
		{
		 var randNum:Number = Math.floor(Math.random() * (1 + max - min)) + min; // Create Random Number
		 var unique:Boolean; // Will determine if number is a duplicate, if "duplicates" are NOT desired
		 
			if(duplicates) // If Duplicates are desired...
			{
			 diceRolls.push(randNum); // add the Random Number to "DiceRolls"
			} else { // If Duplicates are NOT desired...
				if(diceRolls.length) // check to see if there are any numbers already in "DiceRolls"...
				{
				 unique = check_duplicates(randNum); // if "DiceRolls" has numbers, check to see if "randNum" is unique...
				 	if(unique == false) // If it is not unique...
					{
					 random_number(min, max, duplicates); // start over (END)
					} else { // If it is Unique...
					 diceRolls.push(randNum); // add the Random Number to "DiceRolls" (END)
					}
				} else { // If there are no numbers in "DiceRolls"...
				 diceRolls.push(randNum); // add the Random Number to "DiceRolls" (END)
				}
			}
		}
// ------------------------------------------------------------------------------------------------------------------
		private function check_duplicates(num:uint):Boolean
		{
		 var unique:Boolean = true; // Start by assuming that the Random Number is unique
		 
				for (var i = 0; i < diceRolls.length; ++i) // Iterate through each number in diceRolls
				{
				 	if(diceRolls[i] == num) // Check to see if the Random Number matches with the current value of "DiceRolls"
				 	{
					 unique = false; // If Random Number matches the current value of "DiceRolls", set unique as false
					 i = diceRolls.length; // End the Loop
					}
				}
		 return unique; // If after all diceRolls have been checked and no duplicates were found than return unique as still being true
		}
// ------------------------------------------------------------------------------------------------------------------
	}	
}
