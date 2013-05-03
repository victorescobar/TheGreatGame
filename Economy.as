package  
{
	
	public class Economy 
	{
	 public var generator:RandomGenerator = new RandomGenerator();
	 public var population:Number;
	 public var count:Number = 0;
	 
	 public var male:Number;
	 public var m_18:Array = [];
	 public var m_36:Array = [];
	 public var m_54:Array = [];
	 public var m_55plus:Number;
	 
	 public var female:Number;
	 public var f_18:Array = [];
	 public var f_36:Array = [];
	 public var f_54:Array = [];
	 public var f_55plus:Number;
	 
	 public var female_population:Array = [f_18, f_36, f_54];
	 public var male_population:Array = [m_18, m_36, m_54];
	 
	 public var health:Number = 0.96;
	 public var crime:Number = 0.077;
	 public var unemployment:Number;
	 public var t_terminated:Number = 0.25;
	 public var a_terminated:Number = 0.30;
	 public var t_pregRate:Number = 0.18;
	 public var a_pregRate:Number = 0.32;
	 
	 // 13.68 % Birth Rate
	 // 8.39 % Death Rate
	 // 
	 
		public function Economy(population:Number) 
		{
		 this.population = population;
		 init();
		 }
		
		public function init():void
		{
		 male = population/2;
		 female = population/2;
		 
		 var all_18 = Math.floor((male * .30)/18), extra18 = Math.floor(male * .30) - (all_18 * 18);
		 var all_36 = Math.floor((male * .25)/18), extra36 = Math.floor(male * .25) - (all_36 * 18);
		 var all_54 = Math.floor((male * .20)/18), extra54 = Math.floor(male * .20) - (all_54 * 18);

		 trace("e18", extra18);
		 trace("e36", extra36);
		 trace("e54", extra54);
		 
		 var rest_18 = generator.run_random_generator(extra18, 0, 17, false);
		 var rest_36 = generator.run_random_generator(extra36, 0, 17, false);
		 var rest_54 = generator.run_random_generator(extra54, 0, 17, false);
		 var extra:Array =[rest_18, rest_36, rest_54];
		 
		 trace("r18", rest_18);
		 trace("r36", rest_36);
		 trace("r54", rest_54);

			for(var p = 0; p < 18; ++p)
			{
			 female_population[0][p] = all_18;
			 female_population[1][p] = all_36;
			 female_population[2][p] = all_54;
			 male_population[0][p] = all_18;
			 male_population[1][p] = all_36;
			 male_population[2][p] = all_54;
			}

			for each(var a in rest_18)
			{
			 female_population[0][a] += 1;
			 male_population[0][a] += 1;
			}
			 
			for each(var b in rest_36)
			{
			 female_population[1][b] += 1;
			 male_population[1][b] += 1;
			}
			 
			for each(var c in rest_54)
			{
			 female_population[2][c] += 1;
			 male_population[2][c] += 1;
			}
		 	
			for(var g = 0; g < 18; ++g)
			{
			 count += (female_population[0][g] + female_population[1][g] + female_population[2][g] + male_population[0][g] + male_population[1][g] + male_population[2][g]);
			}
		 m_55plus = f_55plus = population - count;
		}

		
		public function population_growth():void
		{
		 var teens:uint = 0;
		 var adults:uint = 0;
		 
		 trace("m18", m_18);
		 trace("m36", m_36);
		 trace("m54", m_54);
		 trace("f55+", m_55plus);
		 trace("f18", f_18);
		 trace("f36", f_36);
		 trace("f54", f_54);
		 trace("f55+", f_55plus);
		 trace("count", count);
		 
		 	for(var t = 14; t < f_18.length; ++t)
			{
			 teens += f_18[t];
			}
			
			for(var a = 0; a < f_36.length; ++a)
			{
			 adults += f_36[a];
			 
			 	if(a <= 10) 
				{
				 adults += f_54[a];
				}
			}
		 
		 var totalfertal:Number = teens + adults;
		 var teensPregnant:Number = Math.round(teens * t_pregRate);
		 var adultsPregnant:Number = Math.round(adults * a_pregRate);
		 var totalpregnant:Number = teensPregnant + adultsPregnant;
		 var teenBirths:Number = Math.round(((teensPregnant - (teensPregnant * t_terminated))* health));
		 var adultBirths:Number = Math.round(((adultsPregnant - (adultsPregnant * a_terminated))* health));
		 var totalbirths:Number = teenBirths + adultBirths;
		 var percentageincrease:Number = (teenBirths + adultBirths)/population * 100;
		 
		 trace("teens", teens);
		 trace("adults", adults);
		 trace("total fertile", totalfertal)
		 trace("teens pregnant", teensPregnant);
		 trace("adults pregnant", adultsPregnant);
		 trace("total pregnant", totalpregnant)
		 trace("teens births", teenBirths);
		 trace("adults births", adultBirths);
		 trace("total births", totalbirths)
		 trace("percentage increase", percentageincrease, " %");
		}
	}
}
