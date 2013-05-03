package
{
	
	public class Attack
	{
	 public var randNum:RandomGenerator = new RandomGenerator(); 
	 public var attacker:Territory;
	 public var defender:Territory;
	 public var wins:uint;
	 public var loses:uint;

		public function Attack()
		{
		
		}
		
		public function attack_territorys():void
		{
		 var attackRolls:Array = randNum.run_random_generator(3, 1, 6, true);
		 var defendRolls:Array = randNum.run_random_generator(2, 1, 6, true);
		 
		 attackRolls.sort(Array.DESCENDING);
		 defendRolls.sort(Array.DESCENDING);
		 
		 	for( var i = 0; i < defendRolls.length; ++i)
			{
			 	if(attackRolls[i] > defendRolls[i])
			 	{
		 	 	 wins++;
			 	} else {
			 	 loses++;
			 	}
			 
			}
		 attack_consequences();
		}
		
		private function attack_consequences():void
		{
		 	
		 	if(defender.military - wins <= 0 || attacker.military - loses <= 0)
			{
		 		if(defender.military - wins <= 0)
				{
				 trace("defeated");
				 defender.military = 0;
				 defender.update_military_field();
				 defender.set_owner(attacker.player);
				}
				
				if(attacker.military - loses <= 0)
				{
				 trace("defeated");
				 attacker.military = 0;
				 attacker.update_military_field();
				}
			} else {
			 attacker.military -= loses;
			 defender.military -= wins;
			 trace("militaryA", attacker.military);
		 	 trace("militaryD", defender.military);
			 attacker.update_military_field();
			 defender.update_military_field();
			}
		 
		wins = 0;
		loses = 0;
		}

	}
	
}
