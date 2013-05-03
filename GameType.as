package 
{
 import flash.display.Stage;
 import flash.display.MovieClip;
 import flash.events.Event;
 import flash.display.DisplayObject;
 import flash.sensors.Accelerometer;
	
	public class GameType
	{
	 private var _avatarCollider:GroupCollider		= new GroupCollider();
	 private var _countryCollider:GroupCollider 	= new GroupCollider();
	 private var _markerCollider:BucketCollider		= new BucketCollider();
	 
	 private var _generator:RandomGenerator 		= new RandomGenerator();	
	 
	 private var _world:World1;
	 
	 private var _nAmerica1:Alaska					= new Alaska();
	 private var _nAmerica2:NorthwestTerritories 	= new NorthwestTerritories();
	 private var _nAmerica3:Nunavut 				= new Nunavut();
	 private var _nAmerica4:Greenland 				= new Greenland();
	 private var _nAmerica5:BritishColumbia 		= new BritishColumbia();
	 private var _nAmerica6:Saskatchewan 			= new Saskatchewan();
	 private var _nAmerica7:Ontario 				= new Ontario();
	 private var _nAmerica8:Quebec 					= new Quebec();
	 private var _nAmerica9:WesternUnitedStates 	= new WesternUnitedStates();
	 private var _nAmerica10:NorthernUnitedStates 	= new NorthernUnitedStates();
	 private var _nAmerica11:SouthernUnitedStates 	= new SouthernUnitedStates();
	 private var _nAmerica12:Hawaii 				= new Hawaii();
	 private var _nAmerica13:Mexico 				= new Mexico();
	 private var _nAmerica14:Cuba 					= new Cuba();
	 private var _nAmerica:Array 		= [_nAmerica1, _nAmerica2, _nAmerica3, _nAmerica4, _nAmerica5, _nAmerica6, _nAmerica7, _nAmerica8, _nAmerica9, _nAmerica10, _nAmerica11, _nAmerica12, _nAmerica13, _nAmerica14];
	 private var _nAmericaNames:Array	= ["Alaska", "Northwest Territories", "Nunavut", "Greenland", "British Columbia", "Saskatchewan", "Ontario", "Quebec", "Western United States", "Northern United States", "Southern United States", "Hawaii", "Mexico", "Cuba"];
	 private var _nAmericaX:Array 		= [  111.85,     190.2,      232.15,     378.65,     196.45,     276.7,      318.05,     359.55,      235.55,      293.1,	  286.5, 	    135.9,       256.3,       347.4   ];
	 private var _nAmericaY:Array 		= [  292.9,      299.2,      141.3,      130.55,     367.95, 	 367.95,     384.25,     352.95,      418.75,      417.45,    462.75,       508.1,       476.65,      493.2   ];
	 private var _nAmericaFieldX:Array  = [51.85,42.85,84.85,89.85,53.85,21.85,19.85,31.35,32.6,44.2,44.1,10.85,46.35,47.85];
	 private var _nAmericaFieldY:Array  = [44.5,43.5,192,113,25.5,25,23.75,46,27.85,29.7,12.35,-6.5,36,15.5];
	 
	 //14
	 
	 private var _sAmerica1:Colombia 	= new Colombia();
	 private var _sAmerica2:Venezuela 	= new Venezuela();
	 private var _sAmerica3:Peru 		= new Peru();
	 private var _sAmerica4:Bolivia 	= new Bolivia();
	 private var _sAmerica5:Brazil 		= new Brazil();
	 private var _sAmerica6:Chile 		= new Chile();
	 private var _sAmerica7:Argentina 	= new Argentina();
	 private var _sAmerica:Array 	= [_sAmerica1, _sAmerica2, _sAmerica3, _sAmerica4, _sAmerica5, _sAmerica6, _sAmerica7];
	 private var _sAmericaNames:Array 	= ["Colombia", "Venezuela", "Peru", "Bolivia", "Brazil", "Chile", "Argentina"];
	 private var _sAmericaX:Array 	= [  363.25,     379.15,     327.55,     389.5,      377.2,        372,       378.25 ];
	 private var _sAmericaY:Array 	= [  537.4,      535.15,     564.9 ,     594.75,     555.05,     615.15,      628.05 ];
	 private var _sAmericaFieldX:Array  = [16.1,25.95,43.8,16.35,66.1,9.35,25.85];
	 private var _sAmericaFieldY:Array  = [21.6,15.1,27.1,22.35,40.35,64.35,40.85];
	 //7
	 
	 private var _europe1:Iceland 			= new Iceland();
	 private var _europe2:Svalbard 			= new Svalbard();
	 private var _europe3:Scandinavia 		= new Scandinavia();
	 private var _europe4:GreatBritain 		= new GreatBritain();
	 private var _europe5:NorthernEurope 	= new NorthernEurope();
	 private var _europe6:Belarus 			= new Belarus();
	 private var _europe7:WesternEurope 	= new WesternEurope();
	 private var _europe8:SouthernEurope 	= new SouthernEurope();
	 private var _europe9:Ukraine 			= new Ukraine();
	 private var _europe:Array 		= [_europe1,   _europe2,   _europe3,         _europe4,       _europe5,       _europe6,     _europe7,        _europe8,        _europe9 ];
	 private var _europeNames:Array = ["Iceland", "Svalbard", "Scandinavia", "Great Britain", "Northern Europe", "Belarus", "Western Europe", "Southern Europe", "Ukraine"];
	 private var _europeX:Array 	= [ 515.05,    612.6,       596.05,            553.6,           590.2,        641.55,       557.45,          600.55,          640.15  ];
	 private var _europeY:Array 	= [ 329.05,    167.45,       294.6,            355.1,          391.55,        370.05,       410.45,          419.15,           404.7  ];
	 private var _europeFieldX:Array  = [15.35,16.35,46.35,15.85,35.35,15.85,32.85,18.85,28.85];
	 private var _europeFieldY:Array  = [11,49.5,31.5,42.5,17.5,24.5,21.5,13.15,14.5];
	 //9
	 
	 private var _africa1:Algeria 		= new Algeria();
	 private var _africa2:Libya 		= new Libya();
	 private var _africa3:Egypt 		= new Egypt();
	 private var _africa4:Mali 			= new Mali();
	 private var _africa5:Nigeria 		= new Nigeria();
	 private var _africa6:Sudan 		= new Sudan();
	 private var _africa7:Ethiopia 		= new Ethiopia();
	 private var _africa8:Congo 		= new Congo();
	 private var _africa9:Angola 		= new Angola();
	 private var _africa10:Tanzania 	= new Tanzania();
	 private var _africa11:Madagascar 	= new Madagascar();
	 private var _africa12:SouthAfrica 	= new SouthAfrica();
	 private var _africa:Array 				= [_africa1, _africa2, _africa3, _africa4, _africa5, _africa6,  _africa7, _africa8, _africa9, _africa10,  _africa11,     _africa12];
	 private var _africaNames:Array			= ["Algeria", "Libya", "Egypt",    "Mali", "Nigeria", "Sudan", "Ehtiopia", "Congo", "Angola", "Tanzania", "Madagascar", "South Africa"];
	 private var _africaX:Array 			= [ 536.6,   610.15,    652.95,    535.75,   584.55,   644.9,    666.5,    615.2,    616.45,   645.35,      704.7,         629.95 ];
	 private var _africaY:Array 			= [ 462.2,   475.35,    480.15,    493.3,    504.45,   508.8,    519.95,   539.35,   584.25,   571.6,       601.6,         629.1  ];
	 private var _africaFieldX:Array		= [ 52.95,    24.95,       13,      29.95,    35.45,   21.95,     31.45,    30.95,    16.45,   34.45,       12.45,          23.95 ];                                     
	 private var _africaFieldY:Array		= [ 26.75,    19.25,     16.25,     34.75,    25.75,   21.75,     32.75,    30.75,    32.25,   33.25,       19.45,          22.25 ];                                   
	 //12
	 
	 private var _midEast1:Turkey 			= new Turkey();
	 private var _midEast2:Turkmenistan 	= new Turkmenistan();
	 private var _midEast3:Iraq 			= new Iraq();
	 private var _midEast4:Iran 			= new Iran();
	 private var _midEast5:Afghanistan 		= new Afghanistan();
	 private var _midEast6:SaudiArabia		= new SaudiArabia();
	 private var _midEast:Array 		= [_midEast1,   _midEast2,   _midEast3, _midEast4,  _midEast5,    _midEast6   ];
	 private var _midEastNames:Array 	= [ "Turkey", "Turkmenistan",  "Iraq",    "Iran", "Afghanistan", "SaudiArabia"];
	 private var _midEastX:Array 		= [   656,        729.65,      692.35,    706.85,     752.85,        679.7    ];
	 private var _midEastY:Array 		= [  445.05,      431.85,      461.55,     453.5,      458.3,        470.35   ];
	 private var _midEastFieldX:Array  = [25.85,26.35,12.85,29.35,21.85,30.85];
	 private var _midEastFieldY:Array  = [11.5,18.5,14.5,24,19.5,35];
	 //6
	 
	 private var _asia1:NorthWesternRussia 	= new NorthWesternRussia();
	 private var _asia2:Ural 				= new Ural();
	 private var _asia3:CentralRussia 		= new CentralRussia();
	 private var _asia4:Volga 				= new Volga();
	 private var _asia5:Tomsk 				= new Tomsk();
	 private var _asia6:SouthernRussia 		= new SouthernRussia();
	 private var _asia7:Kazakhstan 			= new Kazakhstan();
	 private var _asia8:Siberia 			= new Siberia();
	 private var _asia9:Yakutsk 			= new Yakutsk();
	 private var _asia10:Irkutsk 			= new Irkutsk();
	 private var _asia11:Khabarovsk 		= new Khabarovsk();
	 private var _asia12:Kamchatka 			= new Kamchatka();
	 private var _asia13:Mongolia 			= new Mongolia();
	 private var _asia14:China 				= new China();
	 private var _asia15:Japan 				= new Japan();
	 private var _asia16:India 				= new India();
	 private var _asia17:Siam 				= new Siam();
	 private var _asia18:Indonesia 			= new Indonesia();
	 private var _asiaFieldX:Array  = [56.95,39.45,18.45,26.35,32.95,16.5,62.95,54.95,65.95,56.45,44.45,44.45,41.35,81.45,37.4,30.45,26.35,53.35];
	 private var _asiaFieldY:Array  = [109.75,75.75,23.75,31,27.25,22.25,30.25,140.75,95.75,47.25,48.25,46.75,22.5,72.75,37.4,30.75,32.5,48.5];
	 
	 private var _asia:Array 		= [         _asia1,        _asia2,      _asia3,      _asia4,  _asia5,        _asia6,        _asia7,      _asia8,     _asia9,   _asia10,   _asia11,     _asia12,    _asia13,   _asia14, _asia15, _asia16, _asia17,  _asia18  ];
	 private var _asiaNames:Array 	= ["North Western Russia", "Ural", "Central Russia", "Volga", "Tomsk", "Southern Russia", "Kazakhstan", "Siberia", "Yakutsk", "Irkutsk","Khabarovsk","Kamchatka", "Mongolia", "China", "Japan", "India", "Siam", "Indonesia"]
	 private var _asiaX:Array 		= [        659.95,          743.1,        669,        700.2,  780.25,        686.55,         713.5,        796,       878.5,    831.95,     918,       1015.35,     828.7,     789.05,  928.7,   774.25,  841.1,    848.8   ];
	 private var _asiaY:Array 		= [         238,           274.55,       369.4,       358.1,   361.9,         408.6,         390.7,      178.35,      236.2,    343.05,    330.95,      291.5,      405.35,    398.85,   424,    474.95,   489,     518.5   ];
	 //18
	 
	 private var _australia1:WesternAustralia 	= new WesternAustralia();
	 private var _australia2:Queensland 		= new Queensland();
	 private var _australia3:NewGuinea 			= new NewGuinea();
	 private var _australia4:NewSouthWales 		= new NewSouthWales();
	 private var _australia5:NewZealand 		= new NewZealand();
	 private var _australia:Array 		= [   _australia1,      _australia2,  _australia3,    _australia4,      _australia5 ];
	 private var _australiaNames:Array 	= ["Western Australia", "Queensland", "New Guinea", "New South Wales", "New Zealand"];
	 private var _australiaX:Array 		= [      900.1,            943.9,        978.2,          977.1,           1047.05   ];
	 private var _australiaY:Array 		= [      606.1,            597.6,        573.2,          646.85,           666.6    ];
	 private var _australiaFieldX:Array  = [26.35,31.85,43.3,13.85,16.8];
	 private var _australiaFieldY:Array  = [35,31,26.45,16.5,30.15];
	 //5
	 
	 private var _p1:Player;
	 private var _p2:Player;
     private var _p3:Player;
	 private var _p4:Player;
	 private var _p5:Player;
	 private var _p6:Player;            //   RED       BLUE      GREEN     YELLOW    ORANGE    PURPLE
	 private var _allPlayers:Array 		= [  _p1,      _p2,      _p3,       _p4,      _p5,      _p6   ]; 
	 private var _colorArray:Array 		= [0xFF0000, 0xFFFFFF, 0x00FF00,  0xFFFF00, 0xFF8300, 0x800080];
	 									
	 private var _twoPlayersX:Array		= [  616,      616];
	 private var _twoPlayersY:Array 	= [  750,       30];
	 
	 private var _threePlayersX:Array	= [  308,      616,      924];
	 private var _threePlayersY:Array 	= [  750,       30,      750];
	 
	 private var _fourPlayersX:Array	= [  308,      308,      924,        924];
	 private var _fourPlayersY:Array 	= [  750,       30,       30,        750];
	 
	 private var _fivePlayersX:Array	= [  410,       30,      616,        1202,      820];
	 private var _fivePlayersY:Array 	= [  750,      350,       30,        350,       750];
	 
	 private var _sixPlayersX:Array	 	= [  410,       30,      410,        820,       1202,   820  ];
	 private var _sixPlayersY:Array 	= [  750,      450,       30,         30,       450,    750  ];
	               
	 private var _twoPlayersPos:Array	= [_twoPlayersX, _twoPlayersY];
	 private var _threePlayersPos:Array	= [_threePlayersX, _threePlayersY];
	 private var _fourPlayersPos:Array	= [_fourPlayersX, _fourPlayersY];
	 private var _fivePlayersPos:Array	= [_fivePlayersX, _fivePlayersY];
	 private var _sixPlayersPos:Array	= [_sixPlayersX, _sixPlayersY]; 
	 private var allPlayerPositions:Array 	= [_twoPlayersPos, _threePlayersPos, _fourPlayersPos, _fivePlayersPos, _sixPlayersPos];
	 private var allFieldsX:Array 			= [_nAmericaFieldX, _sAmericaFieldX, _europeFieldX, _africaFieldX, _midEastFieldX, _asiaFieldX, _australiaFieldX];
	 private var allFieldsY:Array			= [_nAmericaFieldY, _sAmericaFieldY, _europeFieldY, _africaFieldY, _midEastFieldY, _asiaFieldY, _australiaFieldY];
	 private var allTerritories:Array 		= [_nAmerica,  _sAmerica,  _europe,  _africa,  _midEast,  _asia,  _australia];
	 private var allTerritoriesX:Array 		= [_nAmericaX, _sAmericaX, _europeX, _africaX, _midEastX, _asiaX, _australiaX];
	 private var allTerritoriesY:Array		= [_nAmericaY, _sAmericaY, _europeY, _africaY, _midEastY, _asiaY, _australiaY];
	 private var allTerritoriesNames:Array 	= [_nAmericaNames, _sAmericaNames, _europeNames, _africaNames, _midEastNames, _asiaNames, _australiaNames];
	 
		public function GameType(stage:Stage)
		{		
		 _world = new World1();
		 stage.addChild(_world);
		}
// -----------------------------------------------------------------------		
		public function create_game(numOfPlayers:Number, countriesEach:Number, stage:Stage):void
		{
		 load_countries(stage);
		 load_players(numOfPlayers, allPlayerPositions[numOfPlayers - 2], stage);
		 assign_country_owners(numOfPlayers, countriesEach); 
		}
// -----------------------------------------------------------------------		
		private function load_countries(stage:Stage):void
		{
		 var country:Territory;
		 var e:uint = 0; // (E)Represents each different continent
		 
		 	for each (var continent in allTerritories) //Cycle through each continent
			{
				for (var i = 0; i < continent.length; ++i) // Iterate through each country(I) in continent(E)
				{
				 country = allTerritories[e][i] as Territory; // Set(I) as country
				 
				 _countryCollider.add_object(country, "A"); // Add country to "Country Group Collider A"
				 _avatarCollider.add_object(country, "B"); // Add country to "Avatar Group Collider B"
				 //                  Country X Position     Country Y Position    Army Field X Position  Army Field Y Position        Country Name
				 country.set_values(allTerritoriesX[e][i], allTerritoriesY[e][i],    allFieldsX[e][i],      allFieldsY[e][i],    allTerritoriesNames[e][i]);
				 stage.addChild(country);
				}
			 e++; // Move to next continent
			}
			
			for each (var continent2 in allTerritories) //must be done again.. seperate from above (child index)
			{
				for (var a = 0; a < continent2.length; ++a)// Cycle again through every country(A) in each continent
				{
				 country = continent2[a] as Territory; // Set(A) as country
				 country.create_military_field(); // Create above each country the army field
				}
			}
		}
// -----------------------------------------------------------------------		
		private function load_players(totalPlayers:Number, playerPositions:Array, stage:Stage):void
		{
			for(var i = 0; i < totalPlayers; i++)
			{
			//                            Player Number  # Of Players    Player Color        Player X              Player Y            |-------------------Colliders--------------------|  Stage                              
			 _allPlayers[i] = new Player(     i + 1,     totalPlayers,  _colorArray[i], playerPositions[0][i], playerPositions[1][i], _avatarCollider, _countryCollider, _markerCollider,  stage);
			}
		}
// -----------------------------------------------------------------------	
		private function assign_country_owners(totalPlayers:Number, territoriesEach:Number):void
		{
		 var playersArray:Array = []; // Will contain a random arrangment of "Player Numbers" based upon the number of territories each player will posess
		 var totalCountries:Array = []; // Will contain all territories within one Array
		 var countriesArray:Array = []; // Will contain a random arrangment of numbers between 1 - "totalCountries.length" (no duplicates)
		 
		 	for (var e = 0; e < territoriesEach; e++) // Iterate and Populate playersArray with each players "Player Number" equaling "territoriesEach"
			{
			 var tempArray:Array = _generator.run_random_generator(totalPlayers, 1, totalPlayers, false); // Populate "tempArray" with each players "Player Number" randomly arranged
			 	
				for each(var num in tempArray) // Cycle through "tempAray"
				{
				 playersArray.push(num); // Push each element to "playersArray"
				}
			 tempArray = []; // Clear "tempArray" for next iteration 
			}
		 
			for each(var continent in allTerritories) // Cycle through every array in "allTerritories"
			{
				for each (var country in continent) // Cycle through every country in "Continent"
				{
				 totalCountries.push(country); // Add every country in the game to the array "totalCountries"
				}
			}
		 
		 countriesArray = _generator.run_random_generator(totalCountries.length, 1, totalCountries.length, false); // After the length of "totalCountries" is determined create "countriesArray"
		 
		 	for(var i = 0; i < (playersArray.length); i++) // Cycle through every randomly arranged "Player Number" and assign a randomly arranged Territory to that player
			{
			 // Pick A Player
			 var tempPlayer:Player = _allPlayers[playersArray[i] - 1] as Player; // Cycle through "playersArray" and Set "tempPlayer" as Player from "_allPlayers" at the index of the value of "playersArray" at the current iteration (minus 1 to account for 0 being the first index of an array)
			 // Pick A Territory
			 var tempCountry:Territory = totalCountries[countriesArray[i] - 1] as Territory; // Cycle through "countriesArray" and Set "tempCountry" as Territory from "totalCountries" at the index of the value of "countriesArray" at the current iteration (minus 1 to account for 0 being the first index of an array)
			 // Set Territory to Player
			 tempCountry.set_owner(tempPlayer);
			}
		}
	}
}
