//----------------------------------------------------------
//
//  BLUE VS GREEN
//
//----------------------------------------------------------

#include <a_samp>
#include <core>
#include <float>
#include "../include/I-ZCMD-master/original-zcmd.inc"
#include "../include/gl_common.inc"
#include "../include/gl_spawns.inc"
#include <sscanf2>
#include <Dini>
#include <FCNPC>


#pragma tabsize 0


//----------------------------------------------------------
//COLORS
#define COLOR_WHITE 		0xFFFFFFFF
#define COLOR_BLACK			0x00000000
#define COLOR_NORMAL_PLAYER 0xFFBB7777
#define COLOR_GREEN 		0x00FF0099
#define COLOR_BLUE  		0x2A77A1FF
#define COLOR_RED			0xFF0000AA
#define COLOR_YELLOW 		0xFFFF00FF
#define COLOR_PURPLE 		0x8700FFFF
#define COLOR_ORANGE 		0xFFA500FF
#define COLOR_GREY 			0xAFAFAFAA
#define COLOR_CONTROLDARK	0x696969FF
#define COLOR_AQUAMARINE 	0x7FFFD4FF
//-------

#define PLAYER_BLUE 1
#define PLAYER_GREEN 0

//MISC
#define TEMPO_PARTIDA 30
#define MAX_ACESSORIOS 3
#define ENTREGADOR_PIZZA 1
#define MECANICO 2
#define DialogInputEx 2
#define DialogBoxEx 1
#define MaxBlind 100

//GUNS
#define Brass_Knuckles 1
#define Golf_Club 2
#define Nightstick 3
#define Knife 4
#define Baseball_Bat 5
#define Shovel 6
#define Pool_Cue 7
#define Katana 8
#define Chainsaw 9
#define Double-ended Dildo 10
#define Dildo 11
#define Vibrator 12
#define Silver_Vibrator 13
#define Flowers 14
#define Cane 15
#define Grenade 16
#define Tear_Gas 17
#define Molotov Cocktail 18
#define Pistol 22
#define Sc-Pistol 23
#define Desert_Eagle 24
#define Shotgun 25
#define Sawnoff_Shotgun 26
#define Combat_Shotgun 27
#define Micro_SMG 28
#define MP5 29
#define AK-47 30
#define M4 31
#define Tec-9 32
#define Country_Rifle 33
#define Sniper_Rifle 34
#define RPG 35
#define HS_Rocket 36
#define Flamethrower 37
#define Minigun 38
#define Satchel Charge 39
#define Detonator 40
#define Spraycan 41
#define Fire_Extinguisher 42
#define Camera 43
#define Night_Vis_Goggles 44
#define Thermal_Goggles 45
#define Parachute 46
//-------


//----------------------------------------------------------

//new total_vehicles_from_files=0;

// Class selection globals
new gPlayerCitySelection[MAX_PLAYERS];
new gPlayerHasCitySelected[MAX_PLAYERS];
new gPlayerLastCitySelectionTick[MAX_PLAYERS];

new VehicleColoursTableRGBA[256] = {
// The existing colours from San Andreas
0x000000FF, 0xF5F5F5FF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0x000000FF,
// SA-MP extended colours (0.3x)
0x177517FF, 0x210606FF, 0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF,
0xB7B7B7FF, 0x464C8DFF, 0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF,
0x1E1D13FF, 0x1E1306FF, 0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF,
0x992E1EFF, 0x2C1E08FF, 0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF,
0x481A0EFF, 0x7A7399FF, 0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF,
0x7B3E7EFF, 0x3C1737FF, 0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF,
0x163012FF, 0x16301BFF, 0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF,
0x2B3C99FF, 0x3A3A0BFF, 0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF,
0x2C5089FF, 0x15426CFF, 0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF,
0x995C52FF, 0x99581EFF, 0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF,
0x96821DFF, 0x197F19FF, 0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF,
0x8A653AFF, 0x732617FF, 0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF,
0x561A28FF, 0x4E0E27FF, 0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
};



new Float:PlayerInfo[MAX_PLAYERS][1];
new Float:Profissoes[MAX_PLAYERS][2];
new PlayerCar[MAX_PLAYERS][1];

new house[MAX_PLAYERS];
new Bomb[MAX_PLAYERS];
new Money[MAX_PLAYERS];

new Float:velocidade[MAX_PLAYERS];
new TimerVelocimetro[MAX_PLAYERS];

new TimerLataria[MAX_PLAYERS];
new TimerCadeia[MAX_PLAYERS];

new Tempo = TEMPO_PARTIDA;
new cadeia[MAX_PLAYERS][2][512];
new Nivel[MAX_PLAYERS];
new Exp[MAX_PLAYERS];

new pizza[MAX_PLAYERS];
new Text:txtClassSelHelper;
new Blind[MAX_VEHICLES];

new Text:txtGreen;
new Text:txtBlue;

new Text:TDEditor_TD[MAX_PLAYERS][8];
new Text:Pontuacao[5];
new Text:TextCadeia[MAX_PLAYERS][4];
new PBlue;
new PGreen;

#define MINIGUNMODEL 362
#define FLAMETHMODEL 361
#define RPGMODEL 359
new EspecialGuns[3][2] = {{MINIGUNMODEL,Minigun},{FLAMETHMODEL,Flamethrower},{RPGMODEL,RPG}};
new EGun[2];


new check[MAX_PLAYERS] = 0;

new VBlue[6];
new VGreen[6];
new VPizza[2];
new VTowCar[2];

new Senha[MAX_PLAYERS][512];

new acessorios[MAX_ACESSORIOS][][] = {{"Chapeu de Bruxa",19528},{"Cartola",19352},{"Oculos Escuro",19138}};
new acessoriosP[MAX_PLAYERS][MAX_ACESSORIOS];

//Vehicle Names
new veehName[][] ={"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Whoopee","BF Injection",
"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider","Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3-50","Walton","Regina",
"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","Chopper","Rancher","FBI Rancher","Virgo","Greenwood","Jetmax","Hotring","Sandking","Blista","Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring","Hotring",
"Bloodring","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain","Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover","Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer","Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer","Emperor",
"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car","Police Car","Police Car","Police Ranger","Picador","S.W.A.T.","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer","Luggage Trailer",
"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};



//new thisanimid=0;
//new lastanimid=0;

//----------------------------------------------------------

main()
{
	print("\n---------------------------------------");
	print("BLUE VS GREEN\n");
	print("---------------------------------------\n");
}

//----------------------------------------------------------

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~MATA MATA EM EQUIPE",3000,4);
  	GameTextForPlayer(playerid,"~w~BEM VINDO AO ~b~BLUE ~w~VS ~g~GREEN",7000,4);

  	PlayAudioStreamForPlayer(playerid, "http://hcmaslov.d-real.sci-nnov.ru/public/mp3/Rammstein/Rammstein%20'Du%20Hast'.mp3");
  	
  	new file[128], pName[MAX_PLAYER_NAME]; // Recriamos as mesmas variaveis,só que em publics diferentes.
   	GetPlayerName(playerid, pName, MAX_PLAYER_NAME); // Pegamos o nome da pessoa e guardamos em pName.
   	format(file, sizeof(file), "contas/%s.ini", pName); // Formatamos o caminho para o dini dentro da var file
   	Senha[playerid] = dini_Get(file, "Senha");
    Profissoes[playerid][0] = dini_Int(file, "Profissoes");
    Nivel[playerid] = dini_Int(file, "Nivel");
    Money[playerid]= dini_Int(file, "Money");
    Exp[playerid] = dini_Int(file, "Exp");
   	if(!dini_Exists(file)){
        ShowPlayerDialog(playerid, 5, DIALOG_STYLE_PASSWORD, "Criar Conta", "Seja Bem Vindo,\n Digite a Sua Senha Para Registrar", "Registrar", "Sair");
	} else {
		ShowPlayerDialog(playerid, 4, DIALOG_STYLE_PASSWORD, "Login", "Por Favor,\nDigite a Sua Senha Abaixo!", "Logar", "Sair"); //mostrará o dialog
	}
	


	new stringini[512];
	stringini = dini_Get(file, "Itens");
    new stringLength = strlen(stringini);
    for(new i = 0;i < stringLength;i++){
		if(stringini[i] == 'a'){

		} else {
			new iValue = strval(stringini[i]);
			acessoriosP[playerid][iValue] = 1;
		}
	}
  	
  	
  	
  	// class selection init vars
  	gPlayerCitySelection[playerid] = -1;
	gPlayerHasCitySelected[playerid] = 0;
	gPlayerLastCitySelectionTick[playerid] = GetTickCount();

	SetPlayerMapIcon(playerid, 95, 2455.2834,-1461.1854,24.0000, 27, 0, 0);
	AddStaticPickup(3096, 1, 2455.2834,-1461.1854,24.0000, 0);
	Create3DTextLabel("{43BBDE}\n{FF7F00}Blindagem\n/blindar Para Blindar", COLOR_ORANGE, 2455.2834,-1461.1854,24.0000, 15.0, 0);
	
	SetPlayerMapIcon(playerid, 96, 2096.8438,-1806.5330,13.5529, 29, 0, 0);
	AddStaticPickup(1582, 1, 2116.9954,-1788.4574,13.5547, 0);
	Create3DTextLabel("{43BBDE}\n{FF7F00}Pizzas\n/trabalhar para pegar as pizzas", COLOR_ORANGE, 2116.9954,-1788.4574,13.5547, 15.0, 0);
	
	AddStaticPickup(1239, 1, 2096.8438,-1806.5330,13.5529, 0);
	Create3DTextLabel("{43BBDE}\n{FF7F00}Entregador de Pizzas\n/empregar para ser entregador", COLOR_ORANGE, 2096.8438,-1806.5330,13.5529, 15.0, 0);
	
	AddStaticPickup(1274, 1, 2487.5032,-1519.0341,23.9922, 0);
	Create3DTextLabel("{43BBDE}\n{FF7F00}Local de Entrega\nTraga os veiculos e digite /venderpecas", COLOR_ORANGE, 2487.5032,-1519.0341,23.9922, 15.0, 0);
	
	AddStaticPickup(1239, 1,2442.9648,-1550.4795,23.9976, 0);
	Create3DTextLabel("{43BBDE}\n{FF7F00}Mecanico\n/empregar Para Ser um Mecanico", COLOR_ORANGE, 2442.9648,-1550.4795,23.9976, 15.0, 0);



	//SetPlayerColor(playerid,COLOR_NORMAL_PLAYER);

	/*
	Removes vending machines
	RemoveBuildingForPlayer(playerid, 1302, 0.0, 0.0, 0.0, 6000.0);
	RemoveBuildingForPlayer(playerid, 1209, 0.0, 0.0, 0.0, 6000.0);
	RemoveBuildingForPlayer(playerid, 955, 0.0, 0.0, 0.0, 6000.0);
	RemoveBuildingForPlayer(playerid, 1775, 0.0, 0.0, 0.0, 6000.0);
	RemoveBuildingForPlayer(playerid, 1776, 0.0, 0.0, 0.0, 6000.0);
	*/
	
	/*
	new ClientVersion[32];
	GetPlayerVersion(playerid, ClientVersion, 32);
	printf("Player %d reports client version: %s", playerid, ClientVersion);*/
	
 	

 	return 1;
}

//----------------------------------------------------------

public OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	
	new randSpawn = 0;
	
	TogglePlayerClock(playerid, 0);
	SetPlayerInterior(playerid,0);
	
	

	if(PLAYER_GREEN == gPlayerCitySelection[playerid]) {
 	    randSpawn = random(sizeof(gRandomSpawns_LosSantos));
 	    StopAudioStreamForPlayer(playerid);
 	    SetPlayerPos(playerid,1847.3674,-1407.9164,13.3906);
 	    PlayerInfo[playerid][0] = PLAYER_GREEN;
 	    SetPlayerColor(playerid, COLOR_GREEN);
 	    SetPlayerTeam(playerid, 0);
		SetPlayerFacingAngle(playerid,gRandomSpawns_LosSantos[randSpawn][3]);
	}
	else if(PLAYER_BLUE == gPlayerCitySelection[playerid]) {
 	    randSpawn = random(sizeof(gRandomSpawns_SanFierro));
 	    StopAudioStreamForPlayer(playerid);
 	    SetPlayerPos(playerid,1987.1101,-1444.1313,13.3991);
 	    PlayerInfo[playerid][0] = PLAYER_BLUE;
 	    SetPlayerColor(playerid, COLOR_BLUE);
 	    SetPlayerTeam(playerid, 1);
		SetPlayerFacingAngle(playerid,gRandomSpawns_SanFierro[randSpawn][3]);
	}

  	new file[128], pName[MAX_PLAYER_NAME]; // Recriamos as mesmas variaveis,só que em publics diferentes.
   	GetPlayerName(playerid, pName, MAX_PLAYER_NAME); // Pegamos o nome da pessoa e guardamos em pName.
   	format(file, sizeof(file), "contas/%s.ini", pName); // Formatamos o caminho para o dini dentro da var file
   	if(!dini_Exists(file)) dini_Create(file);  // Checamos se o arquivo do player existe,se não existir,ele cria.
   	SetPlayerSkin(playerid, dini_Int(file, "Skin")); // Setamos a skin guardada na tag "Skin"
    
   	


	//SetPlayerColor(playerid,COLOR_NORMAL_PLAYER);
	
	/*
	SetPlayerSkillLevel(playerid,WEAPONSKILL_PISTOL,200);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_PISTOL_SILENCED,200);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_DESERT_EAGLE,200);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_SHOTGUN,200);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_SAWNOFF_SHOTGUN,200);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_SPAS12_SHOTGUN,200);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_MICRO_UZI,200);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_MP5,200);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_AK47,200);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_M4,200);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_SNIPERRIFLE,200);*/
    
    GivePlayerWeapon(playerid,WEAPON_DEAGLE,99999);
    GivePlayerWeapon(playerid,WEAPON_M4,99999);
    GivePlayerWeapon(playerid,WEAPON_SHOTGUN,99999);
	SetPlayerArmour(playerid,100);


	if(check[playerid] == 0){
		check[playerid] = 1;
		Money[playerid] = dini_Int(file, "Money");
		GivePlayerMoney(playerid,Money[playerid]);
		
		Pontuacao[0] = TextDrawCreate(0.833350, 200.888748, "_");
		TextDrawLetterSize(Pontuacao[0], 0.429165, 9.299992);
		TextDrawTextSize(Pontuacao[0], 151.000000, 0.000000);
		TextDrawAlignment(Pontuacao[0], 1);
		TextDrawColor(Pontuacao[0], -1);
		TextDrawUseBox(Pontuacao[0], 1);
		TextDrawBoxColor(Pontuacao[0], 1426063488);
		TextDrawSetShadow(Pontuacao[0], 0);
		TextDrawSetOutline(Pontuacao[0], 0);
		TextDrawBackgroundColor(Pontuacao[0], 255);
		TextDrawFont(Pontuacao[0], 1);
		TextDrawSetProportional(Pontuacao[0], 1);
		TextDrawSetShadow(Pontuacao[0], 0);
		
		Pontuacao[1] = TextDrawCreate(40.833351, 201.407363, "Pontuacao");
		TextDrawLetterSize(Pontuacao[1], 0.400000, 1.600000);
		TextDrawAlignment(Pontuacao[1], 1);
		TextDrawColor(Pontuacao[1], -1);
		TextDrawSetShadow(Pontuacao[1], 0);
		TextDrawSetOutline(Pontuacao[1], 0);
		TextDrawBackgroundColor(Pontuacao[1], 255);
		TextDrawFont(Pontuacao[1], 1);
		TextDrawSetProportional(Pontuacao[1], 1);
		TextDrawSetShadow(Pontuacao[1], 0);

		new stringG[128];
		format(stringG, sizeof(stringG), "Green: %d", PGreen);
		Pontuacao[2] = TextDrawCreate(1.666700, 218.000061, stringG);
		TextDrawLetterSize(Pontuacao[2], 0.400000, 1.600000);
		TextDrawAlignment(Pontuacao[2], 1);
		TextDrawColor(Pontuacao[2], COLOR_GREEN);
		TextDrawSetShadow(Pontuacao[2], 0);
		TextDrawSetOutline(Pontuacao[2], 0);
		TextDrawBackgroundColor(Pontuacao[2], 255);
		TextDrawFont(Pontuacao[2], 1);
		TextDrawSetProportional(Pontuacao[2], 1);
		TextDrawSetShadow(Pontuacao[2], 0);

	    new stringB[128];
		format(stringB, sizeof(stringB), "Blue: %d", PBlue);
		Pontuacao[3] = TextDrawCreate(-0.000021, 238.740722, stringB);
		TextDrawLetterSize(Pontuacao[3], 0.400000, 1.600000);
		TextDrawAlignment(Pontuacao[3], 1);
		TextDrawColor(Pontuacao[3], COLOR_BLUE);
		TextDrawSetShadow(Pontuacao[3], 0);
		TextDrawSetOutline(Pontuacao[3], 0);
		TextDrawBackgroundColor(Pontuacao[3], 255);
		TextDrawFont(Pontuacao[3], 1);
		TextDrawSetProportional(Pontuacao[3], 1);
		TextDrawSetShadow(Pontuacao[3], 0);

		Pontuacao[4] = TextDrawCreate(0.833332, 258.962982, "Tempo:");
		TextDrawLetterSize(Pontuacao[4], 0.400000, 1.600000);
		TextDrawAlignment(Pontuacao[4], 1);
		TextDrawColor(Pontuacao[4], -1);
		TextDrawSetShadow(Pontuacao[4], 0);
		TextDrawSetOutline(Pontuacao[4], 0);
		TextDrawBackgroundColor(Pontuacao[4], 255);
		TextDrawFont(Pontuacao[4], 1);
		TextDrawSetProportional(Pontuacao[4], 1);
		TextDrawSetShadow(Pontuacao[4], 0);
		
		new motivo[512];
		motivo = dini_Get(file, "Motivo_Cadeia");
		
		cadeia[playerid][0][0] = dini_Int(file, "Tempo_Cadeia");
    	cadeia[playerid][1] = motivo;
    	
    	if(cadeia[playerid][0][0] != 0){
    	    new str[300];
    	    format(str,sizeof(str),"Você Ainda Não Cumpriu a Sua Pena De [%i Segundos] e Pelo Motivo: %s",cadeia[playerid][0][0],cadeia[playerid][1]);
		    SendClientMessage(playerid, COLOR_RED, str);
		    SetPlayerHealth(playerid, Float:0x7F800000 );
		    ResetPlayerWeapons(playerid);

		    format(str,sizeof(str),"Tempo: %i Seg",cadeia[playerid][0]);
		    TextCadeia[playerid][0] = TextDrawCreate(470.249877, 311.333099, str);
			TextDrawLetterSize(TextCadeia[playerid][0], 0.400000, 1.600000);
			TextDrawAlignment(TextCadeia[playerid][0], 1);
			TextDrawColor(TextCadeia[playerid][0], -1);
			TextDrawSetShadow(TextCadeia[playerid][0], 0);
			TextDrawSetOutline(TextCadeia[playerid][0], 0);
			TextDrawBackgroundColor(TextCadeia[playerid][0], 255);
			TextDrawFont(TextCadeia[playerid][0], 1);
			TextDrawSetProportional(TextCadeia[playerid][0], 1);
			TextDrawSetShadow(TextCadeia[playerid][0], 0);

		    format(str,sizeof(str),"Prisioneiro: %s",pName);
		    TextCadeia[playerid][2] = TextDrawCreate(470.249877, 333.333099, str);
			TextDrawLetterSize(TextCadeia[playerid][2], 0.400000, 1.600000);
			TextDrawAlignment(TextCadeia[playerid][2], 1);
			TextDrawColor(TextCadeia[playerid][2], -1);
			TextDrawSetShadow(TextCadeia[playerid][2], 0);
			TextDrawSetOutline(TextCadeia[playerid][2], 0);
			TextDrawBackgroundColor(TextCadeia[playerid][2], 255);
			TextDrawFont(TextCadeia[playerid][2], 1);
			TextDrawSetProportional(TextCadeia[playerid][2], 1);
			TextDrawSetShadow(TextCadeia[playerid][2], 0);

		 	format(str,sizeof(str),"Motivo: %s",cadeia[playerid][1]);
		    TextCadeia[playerid][3] = TextDrawCreate(470.249877, 353.333099, str);
			TextDrawLetterSize(TextCadeia[playerid][3], 0.400000, 1.600000);
			TextDrawAlignment(TextCadeia[playerid][3], 1);
			TextDrawColor(TextCadeia[playerid][3], -1);
			TextDrawSetShadow(TextCadeia[playerid][3], 0);
			TextDrawSetOutline(TextCadeia[playerid][3], 0);
			TextDrawBackgroundColor(TextCadeia[playerid][3], 255);
			TextDrawFont(TextCadeia[playerid][3], 1);
			TextDrawSetProportional(TextCadeia[playerid][3], 1);
			TextDrawSetShadow(TextCadeia[playerid][3], 0);

			TextCadeia[playerid][1] = TextDrawCreate(457.916748, 306.666687, "_");
			TextDrawLetterSize(TextCadeia[playerid][1], 0.541666, 11.659254);
			TextDrawTextSize(TextCadeia[playerid][1], 644.000000, 3.759996);
			TextDrawAlignment(TextCadeia[playerid][1], 1);
			TextDrawColor(TextCadeia[playerid][1], -1);
			TextDrawUseBox(TextCadeia[playerid][1], 1);
			TextDrawBoxColor(TextCadeia[playerid][1], 120);
			TextDrawSetShadow(TextCadeia[playerid][1], 19);
			TextDrawSetOutline(TextCadeia[playerid][1], -1);
			TextDrawBackgroundColor(TextCadeia[playerid][1], 255);
			TextDrawFont(TextCadeia[playerid][1], 1);
			TextDrawSetProportional(TextCadeia[playerid][1], 1);
			TextDrawSetShadow(TextCadeia[playerid][1], 19);

			for(new i = 0;i < 4;i++){
				TextDrawShowForPlayer(playerid,TextCadeia[playerid][i]);
			}

		    SetPlayerInterior(playerid,10);
		    SetPlayerPos(playerid,214.1204,110.8148,998.5909);
		    TimerCadeia[playerid] = SetTimer("CadeiaFunc", 1000, true);
		    return 1;
		}
	}
	for(new i = 0;i <= 5;i++){
		TextDrawShowForPlayer(playerid, Pontuacao[i]);
	}

	//GivePlayerWeapon(playerid,WEAPON_MP5,100);

	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	new Float:health;
 	GetPlayerHealth(damagedid, health);
	if((PlayerInfo[playerid][0] == PLAYER_BLUE && PlayerInfo[damagedid][0] == PLAYER_BLUE) || (PlayerInfo[playerid][0] == PLAYER_GREEN && PlayerInfo[damagedid][0] == PLAYER_GREEN)){
	    SetPlayerHealth(damagedid,health);
    	SendClientMessage(playerid, COLOR_RED, "Voce não pode causar dano em um companheiro de equipe!");
    	return 0;
	} else {
		return 1;
	}
}

public OnPlayerDisconnect(playerid,reason)
{
	new string[512];
	for(new i = 0;i < MAX_ACESSORIOS;i++){
	    if(acessoriosP[playerid][i] == 1){
			format(string, sizeof(string), "%sa%i",string,i);
		} 
	}
	
 	new file[128], pName[MAX_PLAYER_NAME]; // Cria duas variaveis para armazenamento.
   	GetPlayerName(playerid, pName, MAX_PLAYER_NAME); // Armazenamos o nome do jogador na pName
   	format(file, sizeof(file), "contas/%s.ini", pName); // Formatamos a var file com o nome do jogador
   	dini_Set(file, "Nome", pName); // Setamos no arquivo formatado o a tag "Nome" com o nome do jogador
   	dini_IntSet(file, "Skin", GetPlayerSkin(playerid)); // Setamos a id da skin do player na tag "Skin"
   	dini_Set(file, "Itens", string);
   	dini_IntSet(file, "Nivel", Nivel[playerid]);
 	dini_IntSet(file, "Exp", Exp[playerid]);
 	dini_IntSet(file, "Money", GetPlayerMoney(playerid));
   	dini_IntSet(file, "Tempo_Cadeia", cadeia[playerid][0][0]);
   	dini_Set(file, "Motivo_Cadeia", cadeia[playerid][1]);
   	
    KillTimer(TimerCadeia[playerid]);
	Bomb[playerid] = 0;
	check[playerid] = 0;
	Nivel[playerid] = 0;
	Exp[playerid] = 0;
	cadeia[playerid][0][0] = 0;
	cadeia[playerid][1] = "";
	Money[playerid] = 0;
    
   	return 1; // Retornamos ao jogo que tudo foi executado com sucesso.
}



//----------------------------------------------------------

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
     if(!success)
     {
            SendClientMessage(playerid, COLOR_YELLOW, "TU TA DE BRINCANCION WITH ME CARA? ESSE COMANDO NÃO EXISTE!");
            return 1;
     }
     return 1;
}

CMD:carro(playerid, params[])
{
	new type,str[24];
    if (sscanf(params, "i", type) || type > 609 || type < 400)
	{
    	return SendClientMessage(playerid, COLOR_RED, "Use: /carro [400 - 609]");
	}
 	if(cadeia[playerid][0][0] != 0){
        return SendClientMessage(playerid, COLOR_RED, "Você Não Pode Usar Esse Comando Na Cadeia");
	}
 	
	if(IsPlayerInAnyVehicle(playerid) == 0) {
		if(PlayerCar[playerid][0] != 0){
	        DestroyVehicle(PlayerCar[playerid][0]);
	        PlayerCar[playerid][0] = 0;
		}
		new Float:x, Float:y, Float:z,Float:rot,color;
	    GetPlayerPos(playerid, x, y, z);
	    GetPlayerFacingAngle(playerid,rot);
	    if(PlayerInfo[playerid][0] == PLAYER_GREEN){
			color = COLOR_GREEN;
		} else {
            color = COLOR_BLUE;
		}
	    PlayerCar[playerid][0] = CreateVehicle(type, x, y, z, rot, color, COLOR_BLACK, -1);
	    format(str,sizeof(str),"ID-%i",PlayerCar[playerid][0]);
	    SetVehicleNumberPlate(PlayerCar[playerid][0], str);
	    PutPlayerInVehicle(playerid, PlayerCar[playerid][0], 0);
	    SendClientMessage(playerid,COLOR_GREEN ,"Carro criado!");
		Blind[PlayerCar[playerid][0]] = 100;
		AddVehicleComponent(PlayerCar[playerid][0], 1010);
  	} else {
        SendClientMessage(playerid,COLOR_RED ,"Você Já Está em um Veiculo!");
	}
    return 1;
}

CMD:colour(playerid,params[])
{
    new colourID;
    if(!sscanf(params,"d",colourID))
    {
        new string[128];
        format(string,sizeof(string),"this is colour %d.",colourID);
        SendClientMessage(playerid, VehicleColoursTableRGBA[colourID], string);
    }
    return 1;
}

CMD:venderpecas(playerid,params[])
{
    new carid = GetVehicleTrailer(GetPlayerVehicleID(playerid));
    
    if(Profissoes[playerid][0] != MECANICO){
        return SendClientMessage(playerid, COLOR_RED, "Você Não é um Mecanico");
	}

	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 525 ){
        return SendClientMessage(playerid, COLOR_RED, "Você Não Está em um Carro Guincho");
	}
	
	if(GetVehicleModel(GetVehicleTrailer(GetPlayerVehicleID(playerid))) == 525){
 		return SendClientMessage(playerid, COLOR_RED, "Não é Possivel Vendar Peças dos Guinchos");
	}
	
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 2487.5032,-1519.0341,23.9922)){
 		return SendClientMessage(playerid, COLOR_RED, "Você Não Está No Local de Entrega");
	}
	
	if(carid == 0){
 		return SendClientMessage(playerid, COLOR_RED, "Você Não Possuí um Veiculo no Guincho");
	}
	
 	SetVehicleToRespawn(carid);
 	GivePlayerMoney(playerid,10000);
 	return SendClientMessage(playerid, COLOR_GREEN, "Você Recebeu $10000 Pelas Peças");
}

CMD:guinchar(playerid,params[])
{
	new idcar,Float:vehx, Float:vehy, Float:vehz;
    if(sscanf(params,"i",idcar)){
        return SendClientMessage(playerid, COLOR_RED, "Use: /guinchar [ID do CARRO]");
	}

    if(Profissoes[playerid][0] != MECANICO){
        return SendClientMessage(playerid, COLOR_RED, "Você Não é um Mecanico");
	}

	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 525 ){
        return SendClientMessage(playerid, COLOR_RED, "Você Não Está em um Carro Guincho");
	}

 	GetVehiclePos(idcar, vehx, vehy, vehz);
 	if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))){
		if(IsPlayerInRangeOfPoint(playerid, 8.0, vehx,vehy,vehz)){
			AttachTrailerToVehicle(idcar,GetPlayerVehicleID(playerid));
			return SendClientMessage(playerid, COLOR_WHITE, "Veiculo Guinchado");
		} else {
			return SendClientMessage(playerid, COLOR_RED, "O Veiculo Não Está Perto");
		}
	} else {
        DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
        return 1;
	}
	
}

CMD:perfil(playerid,params[]){
	new str[300],name[300];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
 	format(str,sizeof(str),"Perfil de %s:",name);
 	SendClientMessage(playerid, COLOR_AQUAMARINE,str);
	format(str,sizeof(str),"Nível: %i || Experiencia: %i/10 || Money: $%i",Nivel[playerid],Exp[playerid],GetPlayerMoney(playerid));
    SendClientMessage(playerid, COLOR_AQUAMARINE, str);
    return 1;
}

CMD:verperfil(playerid,params[]){
	new str[300],id,name[300];
	
	if(sscanf(params,"i",id)){
        return SendClientMessage(playerid, COLOR_RED, "Use: /verperfil [ID]");
	}
	if(!IsPlayerConnected(id)){
        return SendClientMessage(playerid, COLOR_RED, "O ID Não Está Online");
	}
	GetPlayerName(id, name, MAX_PLAYER_NAME);
 	format(str,sizeof(str),"Perfil de %s:",name);
 	SendClientMessage(playerid, COLOR_AQUAMARINE,str);
	format(str,sizeof(str),"Nível: %i || Experiencia: %i/10 || Money: $%i",Nivel[id],Exp[id],GetPlayerMoney(id));
    SendClientMessage(playerid, COLOR_AQUAMARINE, str);
    return 1;
}

CMD:setnivel(playerid,params[]){
	new str[300],id,name[300],valor;

	if(sscanf(params,"ii",id,valor)){
        return SendClientMessage(playerid, COLOR_RED, "Use: /setnivel [ID][Valor]");
	}
	if(!IsPlayerConnected(id)){
        return SendClientMessage(playerid, COLOR_RED, "O ID Não Está Online");
	}
	Nivel[id] = valor;
	GetPlayerName(id, name, MAX_PLAYER_NAME);
 	format(str,sizeof(str),"%s Foi Setado Para o Nível: %i",name,valor);
 	SendClientMessage(playerid, COLOR_GREEN,str);
    SendClientMessage(id, COLOR_GREEN, str);
    return 1;
}

CMD:setexp(playerid,params[]){
	new str[300],id,name[300],valor;

	if(sscanf(params,"ii",id,valor)){
        return SendClientMessage(playerid, COLOR_RED, "Use: /setexp [ID][Valor]");
	}
	if(!IsPlayerConnected(id)){
        return SendClientMessage(playerid, COLOR_RED, "O ID Não Está Online");
	}
	Exp[id] = valor;
	GetPlayerName(id, name, MAX_PLAYER_NAME);
 	format(str,sizeof(str),"%s Foi Setado Para o Exp: %i",name,valor);
 	SendClientMessage(playerid, COLOR_GREEN,str);
    SendClientMessage(id, COLOR_GREEN, str);
    
    if(Exp[id] >= 10){
        Exp[id] = 0;
        Nivel[id]++;
        SendClientMessage(id,COLOR_GREEN ,"Parabens Você Passou de Nível");
	}
    return 1;
}

CMD:localentrega(playerid,params[])
{
    if(cadeia[playerid][0][0] != 0){
        return SendClientMessage(playerid, COLOR_RED, "Você Não Pode Usar Esse Comando Na Cadeia");
	}
	
    if(Profissoes[playerid][0] == MECANICO){
        SetPlayerCheckpoint(playerid,2487.5032,-1519.0341,23.9922, 3.0);
        return SendClientMessage(playerid, COLOR_WHITE, "Local de Entrega Marcado!");
	} else {
       return SendClientMessage(playerid, COLOR_RED, "Você Não é um Mecanico");
	}
}


CMD:criarzombie(playerid,params[])
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x, y, z);
    new zombie = FCNPC_Create("zombie");
    FCNPC_Spawn(zombie, 230, x+20,y,z);
    return 1;
}

CMD:retirarcadeia(playerid,params[])
{
	new id,motivo[128];
	if(sscanf(params,"is",id,motivo)){
        return SendClientMessage(playerid, COLOR_RED, "Use: /retirarcadeia [ID][Motivo]");
	}
	if(!IsPlayerConnected(id)){
        return SendClientMessage(playerid, COLOR_RED, "O ID Não Está Online");
	}
	format(motivo,sizeof(motivo),"Você Foi Retirado da Cadeia Pelo Motivo: %s",motivo);
	SendClientMessage(playerid, COLOR_GREEN, "Player Retirado da Cadeia");
	cadeia[id][0][0] = 1;
	cadeia[id][1] = "";
	return SendClientMessage(playerid, COLOR_GREEN, motivo);
}

CMD:presos(playerid,params[])
{
	new str[300],name[300];
	SendClientMessage(playerid, COLOR_CONTROLDARK, "Presos:");
	for(new i = 0; i < MAX_PLAYERS;i++){
		if(cadeia[i][0][0] != 0){
		    GetPlayerName(i, name, sizeof(name));
			format(str,sizeof(str),"Presidiário: %s; Tempo: %i; Motivo: %s",name,cadeia[i][0],cadeia[i][1]);
            SendClientMessage(playerid, COLOR_GREY, str);
		}
	}
	return 1;
}

CMD:cadeia(playerid,params[])
{
	new id,tempo,str[300],name[128],motivo[128];
	GetPlayerName(playerid, name, sizeof(name));
	if(sscanf(params,"iis",id,tempo,motivo)){
        return SendClientMessage(playerid, COLOR_RED, "Use: /cadeia [ID][Tempo][Motivo]");
	}
	if(cadeia[id][0][0] != 0){
        return SendClientMessage(playerid, COLOR_RED, "Esse Jogador Já Está na Cadeia");
	}
	
	if(!IsPlayerConnected(id)){
        return SendClientMessage(playerid, COLOR_RED, "Esse ID Não Está Online");
	}
	cadeia[id][0][0] = tempo;
    cadeia[id][1] = motivo;
	format(str,sizeof(str),"Você Foi Preso Pelo ADM: %s, Por[%i Segundos] e Pelo Motivo: %s",name,tempo,motivo);
    SendClientMessage(id, COLOR_RED, str);
    SetPlayerHealth(id, Float:0x7F800000 );
    ResetPlayerWeapons(id);
    
    format(str,sizeof(str),"Tempo: %i Seg",cadeia[id][0]);
    TextCadeia[id][0] = TextDrawCreate(470.249877, 311.333099, str);
	TextDrawLetterSize(TextCadeia[id][0], 0.400000, 1.600000);
	TextDrawAlignment(TextCadeia[id][0], 1);
	TextDrawColor(TextCadeia[id][0], -1);
	TextDrawSetShadow(TextCadeia[id][0], 0);
	TextDrawSetOutline(TextCadeia[id][0], 0);
	TextDrawBackgroundColor(TextCadeia[id][0], 255);
	TextDrawFont(TextCadeia[id][0], 1);
	TextDrawSetProportional(TextCadeia[id][0], 1);
	TextDrawSetShadow(TextCadeia[id][0], 0);

    format(str,sizeof(str),"Prisioneiro: %s",name);
    TextCadeia[id][2] = TextDrawCreate(470.249877, 333.333099, str);
	TextDrawLetterSize(TextCadeia[id][2], 0.400000, 1.600000);
	TextDrawAlignment(TextCadeia[id][2], 1);
	TextDrawColor(TextCadeia[id][2], -1);
	TextDrawSetShadow(TextCadeia[id][2], 0);
	TextDrawSetOutline(TextCadeia[id][2], 0);
	TextDrawBackgroundColor(TextCadeia[id][2], 255);
	TextDrawFont(TextCadeia[id][2], 1);
	TextDrawSetProportional(TextCadeia[id][2], 1);
	TextDrawSetShadow(TextCadeia[id][2], 0);
	
 	format(str,sizeof(str),"Motivo: %s",cadeia[id][1]);
    TextCadeia[id][3] = TextDrawCreate(470.249877, 353.333099, str);
	TextDrawLetterSize(TextCadeia[id][3], 0.400000, 1.600000);
	TextDrawAlignment(TextCadeia[id][3], 1);
	TextDrawColor(TextCadeia[id][3], -1);
	TextDrawSetShadow(TextCadeia[id][3], 0);
	TextDrawSetOutline(TextCadeia[id][3], 0);
	TextDrawBackgroundColor(TextCadeia[id][3], 255);
	TextDrawFont(TextCadeia[id][3], 1);
	TextDrawSetProportional(TextCadeia[id][3], 1);
	TextDrawSetShadow(TextCadeia[id][3], 0);

	TextCadeia[id][1] = TextDrawCreate(457.916748, 306.666687, "_");
	TextDrawLetterSize(TextCadeia[id][1], 0.541666, 11.659254);
	TextDrawTextSize(TextCadeia[id][1], 644.000000, 3.759996);
	TextDrawAlignment(TextCadeia[id][1], 1);
	TextDrawColor(TextCadeia[id][1], -1);
	TextDrawUseBox(TextCadeia[id][1], 1);
	TextDrawBoxColor(TextCadeia[id][1], 120);
	TextDrawSetShadow(TextCadeia[id][1], 19);
	TextDrawSetOutline(TextCadeia[id][1], -1);
	TextDrawBackgroundColor(TextCadeia[id][1], 255);
	TextDrawFont(TextCadeia[id][1], 1);
	TextDrawSetProportional(TextCadeia[id][1], 1);
	TextDrawSetShadow(TextCadeia[id][1], 19);
	
	for(new i = 0;i < 4;i++){
		TextDrawShowForPlayer(playerid,TextCadeia[id][i]);
	}
	
    SetPlayerInterior(id,10);
    SetPlayerPos(id,214.1204,110.8148,998.5909);
    TimerCadeia[id] = SetTimer("CadeiaFunc", 1000, true);
    return 1;
}


CMD:armaid(playerid, params[]){
	new type,id,ammo;
	if (sscanf(params, "iii", id,type,ammo))
	{
    	return SendClientMessage(playerid, COLOR_RED, "Use: /armaid [id][1 - 46][Quantidade]");
	}
	
	if(cadeia[playerid][0][0] != 0){
        return SendClientMessage(playerid, COLOR_RED, "Você Não Pode Usar Esse Comando Na Cadeia");
	}
	
	if(IsPlayerConnected(id))
	{
		GivePlayerWeapon(id,type,ammo);
		new str[128];
		format(str,sizeof(str),"Arma: %i, Enviada Pelo ID[%i], Com %i Munições",type,playerid,ammo);
	 	SendClientMessage(playerid, COLOR_GREEN, str);
	 	SendClientMessage(playerid, COLOR_GREEN, "Armas Enviadas!");
		return 1;
	} else {
        return SendClientMessage(playerid, COLOR_RED, "O Jogador Não Está Online");
	}
}

CMD:armas(playerid, params[]){
	new type;
	if (sscanf(params, "i", type))
	{
    	return SendClientMessage(playerid, COLOR_RED, "Use: /armas [1,2,3]");
	}
	
	if(cadeia[playerid][0][0] != 0){
        return SendClientMessage(playerid, COLOR_RED, "Você Não Pode Usar Esse Comando Na Cadeia");
	}

	if(type == 1){
        SendClientMessage(playerid,COLOR_GREEN ,"Você Recebeu o Pacote 1!");
		GivePlayerWeapon(playerid,Desert_Eagle,99999);
		GivePlayerWeapon(playerid,M4,99999);
		GivePlayerWeapon(playerid,MP5,99999);
		GivePlayerWeapon(playerid,Sniper_Rifle,99999);
		GivePlayerWeapon(playerid,Knife,1);
	}
	if(type == 2){
        SendClientMessage(playerid,COLOR_GREEN ,"Você Recebeu o Pacote 2!");
		GivePlayerWeapon(playerid,Pistol,99999);
		GivePlayerWeapon(playerid,Sawnoff_Shotgun,99999);
		GivePlayerWeapon(playerid,Micro_SMG,99999);
		GivePlayerWeapon(playerid,Grenade,99999);
		GivePlayerWeapon(playerid,Baseball_Bat,1);
	}
	return 1;
}

CMD:skin(playerid, params[]){
	new type;
	if (sscanf(params, "i", type) || type > 311 || type < 0)
	{
    	return SendClientMessage(playerid, COLOR_RED, "Use: /skin [0-311]");
	}
 	SetPlayerSkin(playerid,type);
 	new file[128], pName[MAX_PLAYER_NAME]; // Cria duas variaveis para armazenamento.
   	GetPlayerName(playerid, pName, MAX_PLAYER_NAME); // Armazenamos o nome do jogador na pName
   	format(file, sizeof(file), "contas/%s.ini", pName); // Formatamos a var file com o nome do jogador
   	dini_IntSet(file, "Skin", GetPlayerSkin(playerid)); // Setamos a id da skin do player na tag "Skin"
	return 1;
}

CMD:daritem(playerid, params[]){
	new id,item;
	if (sscanf(params, "ii", id,item) || item > MAX_ACESSORIOS || item < 0)
	{
    	return SendClientMessage(playerid, COLOR_RED, "Use: /daritem [id][item]");
	}
	if(IsPlayerConnected(id)){
		acessoriosP[id][item] = 1;
		return SendClientMessage(id, COLOR_GREEN, "Item Adquerido");
	} else {
		return SendClientMessage(playerid, COLOR_RED, "O Id Não Está Online");
	}
}

CMD:equiparitem(playerid, params[]){
	new item;
	if (sscanf(params, "i", item) || item > MAX_ACESSORIOS || item < 0)
	{
    	return SendClientMessage(playerid, COLOR_RED, "Use: /equiparitem [id]");
	}
	if(acessoriosP[playerid][item] == 1){
	    new flag = 0;
	    for(new i=0; i < 9; i++)
	    {
   			if(IsPlayerAttachedObjectSlotUsed(playerid, i) == 0 && flag == 0){
                SetPlayerAttachedObject(playerid, i, acessorios[item][1][0], 2,0.1,0.0,0.0);
				EditAttachedObject(playerid, i);
				flag = 1;
			}
	    }
	    if(flag == 0){
            SendClientMessage(playerid, COLOR_RED, "Sem Slots Disponiveis, /removeritem");
		}
	
	} else {
        return SendClientMessage(playerid, COLOR_RED, "Você Não Possui Esse Item");
	}
	
	return 1;
}

CMD:removeritem(playerid, params[]){
	new item;
	if (sscanf(params, "i", item))
	{
    	return SendClientMessage(playerid, COLOR_RED, "Use: /removeritem [ID]");
	}
	if(IsPlayerAttachedObjectSlotUsed(playerid, item)){
        RemovePlayerAttachedObject(playerid, item);
	} else {
        return SendClientMessage(playerid, COLOR_RED, "Voce não possui um item equipado nesse local");
	}

	return 1;
}

CMD:excluiritem(playerid, params[]){
	new id,item;
	if (sscanf(params, "ii", id,item) || item > MAX_ACESSORIOS || item < 0)
	{
    	return SendClientMessage(playerid, COLOR_RED, "Use: /excluiritem [id][item]");
	}
	if(IsPlayerConnected(id)){
		acessoriosP[id][item] = 0;
		new str[128];
		format(str,sizeof(str),"Item:[%i] removido pelo do ID: %i",item,id);
		SendClientMessage(playerid, COLOR_GREEN, str);
		format(str,sizeof(str),"Item:[%i] removido pelo ADM",item);
		return SendClientMessage(id, COLOR_RED, str);
	} else {
		return SendClientMessage(playerid, COLOR_RED, "O id nao esta online");
	}
}

CMD:equipadositem(playerid, params[]){
	new str[512];
	for(new i = 0; i < 9; i++)
    {
        if(IsPlayerAttachedObjectSlotUsed(playerid, i)){
			format(str, sizeof(str), "%i) - EQUIPADO", i);
			SendClientMessage(playerid,COLOR_GREEN ,str);
		} else {
            format(str, sizeof(str), "%i) - NAO EQUIPADO", i);
            SendClientMessage(playerid, COLOR_RED, str);

		}
    }

	return 1;
}

CMD:tps(playerid, params[]){
	if(cadeia[playerid][0][0] != 0){
        return SendClientMessage(playerid, COLOR_RED, "Você Não Pode Usar Esse Comando Na Cadeia");
	}
	
	new str[128] = "Aeroporto-LS\nHQ Blue\nHQ Green\nPizzaria\nOficina de Blindagem\nPrédio Alto-LS";
	ShowPlayerDialog(playerid, 3, 2, "Teletransporte", str, "Ir", "Cancelar"); //mostrará o dialog
	return 1;
}

CMD:empregar(playerid, params[]){
 	if(Profissoes[playerid][0] == 0) {
 	    new str[512];
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 2096.8438,-1806.5330,13.5529)) {
			format(str, sizeof(str), "ID[%d], você realmente deseja ser um \n ENTREGADOR DE PIZZA?", playerid);
			ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "Entregador de Pizza", str, "Ok", "Cancelar");
		}
		
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2442.9648,-1550.4795,23.9976)) {
			format(str, sizeof(str), "ID[%d], você realmente deseja ser um \n MECANICO?", playerid);
			ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, "Mecanico", str, "Ok", "Cancelar");
		}
	} else {
        SendClientMessage(playerid,COLOR_RED ,"Voce Ja Possui Um Emprego, /sairemprego");
	}
	return 1;
}


CMD:nitro(playerid, params[]){
	new actcar = GetPlayerVehicleID(playerid);
 	AddVehicleComponent(actcar, 1010);
 	SendClientMessage(playerid,COLOR_GREEN ,"NITRADO!");
	return 1;
}

CMD:kill(playerid, params[]){

	if(cadeia[playerid][0][0] != 0){
        return SendClientMessage(playerid, COLOR_RED, "Você Não Pode Usar Esse Comando Na Cadeia");
	}
	
	SetPlayerHealth(playerid,0);
	return 1;
}

CMD:trabalhar(playerid, params[]){
 	if(Profissoes[playerid][0] == 0) {
        SendClientMessage(playerid, COLOR_RED ,"Você Não Possui um Emprego");
	}
	if(Profissoes[playerid][0] == ENTREGADOR_PIZZA) {
 		if(Profissoes[playerid][1] == 0){
		    if(pizza[playerid] == 0){
	        	if(IsPlayerInRangeOfPoint(playerid, 3.0, 2116.9954,-1788.4574,13.5547)) {
	        		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 448)
		    		{
						pizza[playerid] = 3;
						new value = random(3);
						new Float:randowP[3][3] = {{2062.8569,-1820.7913,13.5469},{2089.3984,-1905.5582,13.5469},{2151.2695,-1902.4280,13.5507}};
						house[playerid] = SetPlayerCheckpoint(playerid, randowP[value][0], randowP[value][1],randowP[value][2], 3.0);
	                    Profissoes[playerid][1] = 1;
						SendClientMessage(playerid, COLOR_WHITE ,"Casa Marcada!");
						SendClientMessage(playerid, COLOR_WHITE ,"Use /trabalhar Novamente Para Parar de Trabalhar");
						
					} else {
		                SendClientMessage(playerid, COLOR_RED ,"Você Não Está Usando a Lambreta das Pizzas");
					}
				} else {
		            SendClientMessage(playerid, COLOR_RED ,"Você Não Está na Pizzaria");
				}
			} else {
	            SendClientMessage(playerid, COLOR_RED ,"Você Ainda Possui Pizzas para Entregar");
			}
		} else {
			DisablePlayerCheckpoint(playerid);
			pizza[playerid] = 0;
			Profissoes[playerid][1] = 0;
			SendClientMessage(playerid, COLOR_GREEN,"Você Parou de Trabalhar");
		}
	}
	return 1;
}


CMD:heal(playerid, params[]){
	SetPlayerArmour(playerid, 100.0);
	SetPlayerHealth(playerid, 100.0);
	return 1;
}

CMD:homembomba(playerid, params[]){
	if(cadeia[playerid][0][0] != 0){
        return SendClientMessage(playerid, COLOR_RED, "Você Não Pode Usar Esse Comando Na Cadeia");
	}
	
	SendClientMessage(playerid, COLOR_BLUE ,"Use /detonar para se explodir");
	SetPlayerAttachedObject(playerid, 3, 1252, 3);
	SetPlayerAttachedObject(playerid, 4, 1252, 4);
	SetPlayerAttachedObject(playerid, 7, 1252, 7);
	SetPlayerAttachedObject(playerid, 8, 1252, 8);
	Bomb[playerid] = 1;
	return 1;
}

CMD:detonar(playerid, params[]){
    if(cadeia[playerid][0][0] != 0){
        return SendClientMessage(playerid, COLOR_RED, "Você Não Pode Usar Esse Comando Na Cadeia");
	}
	
	if(Bomb[playerid] == 1){
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid, x, y, z);
		CreateExplosion(x, y, z, 6, 30.0);
		CreateExplosion(x, y, z, 6, 30.0);
		CreateExplosion(x, y, z, 6, 30.0);
		CreateExplosion(x, y, z, 6, 30.0);
        if(IsPlayerInAnyVehicle(playerid)) {
            new vehicleid = GetPlayerVehicleID(playerid);
    		SetVehicleHealth(vehicleid, 0);
		}
	    RemovePlayerAttachedObject(playerid, 3);
	    RemovePlayerAttachedObject(playerid, 4);
	    RemovePlayerAttachedObject(playerid, 7);
	    RemovePlayerAttachedObject(playerid, 8);
	    SendClientMessage(playerid, COLOR_GREEN ,"BOOM!");
     	Bomb[playerid] = 0;
		SetPlayerHealth(playerid,0);
	} else {
        SendClientMessage(playerid, COLOR_RED ,"Voce não possui uma bomba!");
	}
	return 1;
}

CMD:mijar(playerid, params[]){
	SetPlayerSpecialAction(playerid,68);
	return 1;
}

CMD:inventario(playerid, params[]){
	SendClientMessage(playerid, COLOR_BLUE ,"Seus Itens:");
	for(new i;i < MAX_ACESSORIOS;i++){
		if(acessoriosP[playerid][i] == 1){
		    new string[128];
			format(string, sizeof(string), "ID:%i - %s", i,acessorios[i][0][0]);
	        SendClientMessage(playerid, COLOR_BLUE ,string);
   		}
	}
	return 1;
}

CMD:jetpack(playerid, params[]){
	if(cadeia[playerid][0][0] != 0){
        return SendClientMessage(playerid, COLOR_RED, "Você Não Pode Usar Esse Comando Na Cadeia");
	}
	
	SetPlayerSpecialAction(playerid,2);
	return 1;
}

CMD:sairemprego(playerid, params[]){
	SendClientMessage(playerid, COLOR_WHITE, "Agora Você Está Desempregado");
	Profissoes[playerid][0] = 0;
	new file[128], pName[MAX_PLAYER_NAME]; // Recriamos as mesmas variaveis,só que em publics diferentes.
   	GetPlayerName(playerid, pName, MAX_PLAYER_NAME); // Pegamos o nome da pessoa e guardamos em pName.
   	format(file, sizeof(file), "contas/%s.ini", pName); // Formatamos o caminho para o dini dentro da var file
	dini_IntSet(file, "Profissoes",0);
	return 1;
}

CMD:blindar(playerid, params[]){
	if(IsPlayerInAnyVehicle(playerid) == 1) {
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2455.2834,-1461.1854,24.0000)) {
	        new string[128];
	        new veh = GetPlayerVehicleID(playerid);
	        Blind[veh] = 100;
	        RepairVehicle(veh);
			SendClientMessage(playerid,COLOR_GREEN ,"Veiculo Blindado!");
			format(string,sizeof(string), "    %i%",Blind[veh]);
			TextDrawSetString(TDEditor_TD[playerid][6], string);
			return 1;
        } else {
			SendClientMessage(playerid, COLOR_RED, "Você não está na Oficina de Blindagem");
			return 1;
		}
  	} else {
        SendClientMessage(playerid,COLOR_RED ,"Você não esta em um veiculo!");
		return 1;
	}
}



//----------------------------------------------------------
forward FCNPC_OnSpawn(npcid);
public FCNPC_OnSpawn(npcid){
	FCNPC_GoToPlayer(npcid, 0,FCNPC_MOVE_TYPE_SPRINT, FCNPC_MOVE_SPEED_SPRINT,FCNPC_MOVE_MODE_AUTO,FCNPC_MOVE_PATHFINDING_AUTO,0.0,true,0.0,1.5,250);
}

/*forward FCNPC_OnDeath(npcid, killerid, reason);
public FCNPC_OnDeath(npcid, killerid, reason){
    FCNPC_Destroy(npcid);
}
*/

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == 2)//identifica o id do dialog.
    {
        if(response)//Caso ele clique no primeiro botão
        {
        	SendClientMessage(playerid, COLOR_GREEN, "Agora Você Entrega Pizzas, /trabalhar");
        	Profissoes[playerid][0] = ENTREGADOR_PIZZA;
        	SetPlayerSkin(playerid,155);
        	new file[128], pName[MAX_PLAYER_NAME]; // Cria duas variaveis para armazenamento.
		   	GetPlayerName(playerid, pName, MAX_PLAYER_NAME); // Armazenamos o nome do jogador na pName
		   	format(file, sizeof(file), "contas/%s.ini", pName); // Formatamos a var file com o nome do jogador
		    if(!dini_Exists(file)){
		 		dini_Create(file);
			}
		   	dini_IntSet(file, "Skin", GetPlayerSkin(playerid)); // Setamos a id da skin do player na tag "Skin"
		   	dini_IntSet(file, "Profissoes",ENTREGADOR_PIZZA);

        }
    }
    
    if(dialogid == 1)//identifica o id do dialog.
    {
        if(response)//Caso ele clique no primeiro botão
        {
        	SendClientMessage(playerid, COLOR_GREEN, "Agora Você é Um Mecanico, Use o Guincho Para o /localentrega");
        	Profissoes[playerid][0] = MECANICO;
        	SetPlayerSkin(playerid,50);
        	new file[128], pName[MAX_PLAYER_NAME]; // Cria duas variaveis para armazenamento.
		   	GetPlayerName(playerid, pName, MAX_PLAYER_NAME); // Armazenamos o nome do jogador na pName
		   	format(file, sizeof(file), "contas/%s.ini", pName); // Formatamos a var file com o nome do jogador
		    if(!dini_Exists(file)){
		 		dini_Create(file);
			}
		   	dini_IntSet(file, "Skin", GetPlayerSkin(playerid)); // Setamos a id da skin do player na tag "Skin"
		   	dini_IntSet(file, "Profissoes",MECANICO);

        }
    }

    if(dialogid == 3)
    {
        if(response)//botão 1
        {
          	if(listitem == 0)//aeroporto-ls
          	{
                SetPlayerPos(playerid, 1882.1689,-2404.8511,13.5547);
          	}

          	else if(listitem == 1)//hq blue
          	{
               SetPlayerPos(playerid,1987.1101,-1444.1313,13.3991);
			}

			else if(listitem == 2)// hq green
			{
                SetPlayerPos(playerid,1847.3674,-1407.9164,13.3906);
			}

			else if(listitem == 3)// pizarria
   			{
                SetPlayerPos(playerid,2096.8438,-1806.5330,13.5529);
			}
			else if(listitem == 4)// blindar
   			{
   			    SetPlayerPos(playerid,2455.2834,-1461.1854,24.0000);
		    }
		    else if(listitem == 5)// alto predio
   			{
   			    SetPlayerPos(playerid,1544.4136,-1353.3580,329.4742);
				GivePlayerWeapon(playerid,Parachute,1);
		    }
   		}
    }
    
    if(dialogid == 4)//identifica o id do dialog.
    {
		if(response)//botão 1
        {
			if(!strcmp(inputtext,Senha[playerid]))//Caso ele clique no primeiro botão
	        {
	            SendClientMessage(playerid, COLOR_GREEN, "Login Efetuado");
	        } else {
	            SendClientMessage(playerid, COLOR_RED, "Senha errada, tente novamente");
	            ShowPlayerDialog(playerid, 4, DIALOG_STYLE_PASSWORD, "Login", "Por Favor,\nDigite a Sua Senha Abaixo!", "Logar", "Sair");
			}
		} else {
            Kick(playerid);
		}
    }
    
    if(dialogid == 5)//identifica o id do dialog.
    {
		if(response)//botão 1
        {
            SendClientMessage(playerid, COLOR_GREEN, "Conta Criada!");
            new file[128], pName[MAX_PLAYER_NAME]; // Recriamos as mesmas variaveis,só que em publics diferentes.
   			GetPlayerName(playerid, pName, MAX_PLAYER_NAME); // Pegamos o nome da pessoa e guardamos em pName.
   			format(file, sizeof(file), "contas/%s.ini", pName); // Formatamos o caminho para o dini dentro da var file
   			dini_Create(file);
   			dini_Set(file, "Senha",inputtext);
   			dini_IntSet(file, "Nivel",1);
   			dini_IntSet(file, "Exp",0);
   			dini_IntSet(file, "Money",10000);
   			Nivel[playerid] = 1;
   			Exp[playerid] = 0;
   			dini_IntSet(file, "Profissoes",0);
   			Senha[playerid] = dini_Get(file, "Senha");
  			ShowPlayerDialog(playerid, 4, DIALOG_STYLE_PASSWORD, "Login", "Por Favor,\nDigite a Sua Senha Abaixo!", "Logar", "Sair");
		} else {
            Kick(playerid);
		}
    }
    return 1;
}


forward VerificarVeiculo(playerid);
public VerificarVeiculo(playerid)
{
    for(new c = 0; c < 6; c++)
    {
        if(IsPlayerInVehicle(playerid, VGreen[c]) && PlayerInfo[playerid][0] == PLAYER_BLUE)
        {
            SendClientMessage(playerid, COLOR_GREEN, "Você Não É um Green");
            RemovePlayerFromVehicle(playerid);
            return 1;
            
        }
    }
    
    for(new c = 0; c < 6; c++)
    {
        if(IsPlayerInVehicle(playerid, VBlue[c]) && PlayerInfo[playerid][0] == PLAYER_GREEN)
        {
            SendClientMessage(playerid, COLOR_BLUE, "Você Não É um Blue");
            RemovePlayerFromVehicle(playerid);
            return 1;
        }
    }

	for(new c = 0; c < 2; c++)
    {
        if(IsPlayerInVehicle(playerid, VPizza[c]) && Profissoes[playerid][0] != ENTREGADOR_PIZZA)
        {
            SendClientMessage(playerid, COLOR_RED, "Você Não É um Entregador de Pizza");
            RemovePlayerFromVehicle(playerid);
            return 1;
        }
    }
    
    for(new c = 0; c < 2; c++)
    {
        if(IsPlayerInVehicle(playerid, VTowCar[c]) && Profissoes[playerid][0] != MECANICO)
        {
            SendClientMessage(playerid, COLOR_RED, "Você Não É um Mecanico");
            RemovePlayerFromVehicle(playerid);
            return 1;
        }
    }
    
    return 1;
}
forward VelocimetroFunc(playerid);
public VelocimetroFunc(playerid){
    new string[128];
    new Float:vX,Float:vY,Float:vZ;
    new vehid = GetPlayerVehicleID(playerid);
    GetVehicleVelocity(vehid,vX,vY,vZ);
    velocidade[playerid] = floatsqroot((vX*vX) + (vY*vY) + (vZ*vZ)) * 180.13;
	format(string, sizeof(string), "Velocidade: %.0f KM/H", velocidade[playerid]);
	TextDrawSetString(TDEditor_TD[playerid][7],string);
}

forward CadeiaFunc(playerid);
public CadeiaFunc(playerid){
	cadeia[playerid][0][0]--;
	new str[128];
	format(str,sizeof(str),"Tempo: %i Seg",cadeia[playerid][0]);
	TextDrawSetString(TextCadeia[playerid][0],str);
	if(cadeia[playerid][0][0] == 0){
		cadeia[playerid][0][0] = 0;
		for(new i = 0;i < 4;i++){
			TextDrawHideForPlayer(playerid,TextCadeia[playerid][i]);
		}
		SendClientMessage(playerid, COLOR_WHITE, "Você Está Livre!");
		SetPlayerInterior(playerid,0);
		SetPlayerHealth(playerid,0);
		KillTimer(TimerCadeia[playerid]);
	}
}

forward LatariaFunc(playerid);
public LatariaFunc(playerid){
 	new Float:health;
    new veh = GetPlayerVehicleID(playerid);
    GetVehicleHealth(veh, health);
    health = health / 10;
    new result[128];
	format(result,sizeof(result),"Lataria: %.0f%",health);
	TextDrawSetString(TDEditor_TD[playerid][5], result);
}


public OnPlayerStateChange(playerid, newstate, oldstate) {
 if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER){

    VerificarVeiculo(playerid);

    TimerVelocimetro[playerid] = SetTimer("VelocimetroFunc", 100, true);
    TimerLataria[playerid] = SetTimer("LatariaFunc", 2000, true);
    
    TDEditor_TD[playerid][0] = TextDrawCreate(511.249877, 311.333099, "INFO_VEICULO");
	TextDrawLetterSize(TDEditor_TD[playerid][0], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[playerid][0], 1);
	TextDrawColor(TDEditor_TD[playerid][0], -1);
	TextDrawSetShadow(TDEditor_TD[playerid][0], 0);
	TextDrawSetOutline(TDEditor_TD[playerid][0], 0);
	TextDrawBackgroundColor(TDEditor_TD[playerid][0], 255);
	TextDrawFont(TDEditor_TD[playerid][0], 1);
	TextDrawSetProportional(TDEditor_TD[playerid][0], 1);
	TextDrawSetShadow(TDEditor_TD[playerid][0], 0);

	TDEditor_TD[playerid][1] = TextDrawCreate(457.916748, 306.666687, "_");
	TextDrawLetterSize(TDEditor_TD[playerid][1], 0.541666, 11.659254);
	TextDrawTextSize(TDEditor_TD[playerid][1], 644.000000, 3.759996);
	TextDrawAlignment(TDEditor_TD[playerid][1], 1);
	TextDrawColor(TDEditor_TD[playerid][1], -1);
	TextDrawUseBox(TDEditor_TD[playerid][1], 1);
	TextDrawBoxColor(TDEditor_TD[playerid][1], 120);
	TextDrawSetShadow(TDEditor_TD[playerid][1], 19);
	TextDrawSetOutline(TDEditor_TD[playerid][1], -1);
	TextDrawBackgroundColor(TDEditor_TD[playerid][1], 255);
	TextDrawFont(TDEditor_TD[playerid][1], 1);
	TextDrawSetProportional(TDEditor_TD[playerid][1], 1);
	TextDrawSetShadow(TDEditor_TD[playerid][1], 19);

	TDEditor_TD[playerid][2] = TextDrawCreate(488.750091, 338.296325, "Veiculo:");
	TextDrawLetterSize(TDEditor_TD[playerid][2], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[playerid][2], 2);
	TextDrawColor(TDEditor_TD[playerid][2], -1);
	TextDrawSetShadow(TDEditor_TD[playerid][2], 0);
	TextDrawSetOutline(TDEditor_TD[playerid][2], 0);
	TextDrawBackgroundColor(TDEditor_TD[playerid][2], 255);
	TextDrawFont(TDEditor_TD[playerid][2], 1);
	TextDrawSetProportional(TDEditor_TD[playerid][2], 1);
	TextDrawSetShadow(TDEditor_TD[playerid][2], 0);


	new vehdesc[128];
 	new model = GetVehicleModel(GetPlayerVehicleID(playerid)) - 400;
	format(vehdesc,sizeof(vehdesc),"%s",veehName[model]);
	TDEditor_TD[playerid][3] = TextDrawCreate(520.000122, 338.296295, vehdesc);
	TextDrawLetterSize(TDEditor_TD[playerid][3], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[playerid][3], 1);
	TextDrawColor(TDEditor_TD[playerid][3], -1);
	TextDrawSetShadow(TDEditor_TD[playerid][3], 0);
	TextDrawSetOutline(TDEditor_TD[playerid][3], 0);
	TextDrawBackgroundColor(TDEditor_TD[playerid][3], 255);
	TextDrawFont(TDEditor_TD[playerid][3], 1);
	TextDrawSetProportional(TDEditor_TD[playerid][3], 1);
	TextDrawSetShadow(TDEditor_TD[playerid][3], 0);

	TDEditor_TD[playerid][4] = TextDrawCreate(463.333282, 359.555633, "Blindagem:");
	TextDrawLetterSize(TDEditor_TD[playerid][4], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[playerid][4], 1);
	TextDrawColor(TDEditor_TD[playerid][4], -1);
	TextDrawSetShadow(TDEditor_TD[playerid][4], 0);
	TextDrawSetOutline(TDEditor_TD[playerid][4], 0);
	TextDrawBackgroundColor(TDEditor_TD[playerid][4], 255);
	TextDrawFont(TDEditor_TD[playerid][4], 1);
	TextDrawSetProportional(TDEditor_TD[playerid][4], 1);
	TextDrawSetShadow(TDEditor_TD[playerid][4], 0);

	new lat[128];
	new Float:health;
	new vehx = GetPlayerVehicleID(playerid);
	GetVehicleHealth(vehx, health);
    health = health / 10;
	format(lat,sizeof(lat),"Lataria: %.0f%",health);
	TDEditor_TD[playerid][5] = TextDrawCreate(464.166656, 379.777862, lat);
	TextDrawLetterSize(TDEditor_TD[playerid][5], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[playerid][5], 1);
	TextDrawColor(TDEditor_TD[playerid][5], -1);
	TextDrawSetShadow(TDEditor_TD[playerid][5], 0);
	TextDrawSetOutline(TDEditor_TD[playerid][5], 0);
	TextDrawBackgroundColor(TDEditor_TD[playerid][5], 255);
	TextDrawFont(TDEditor_TD[playerid][5], 1);
	TextDrawSetProportional(TDEditor_TD[playerid][5], 1);
	TextDrawSetShadow(TDEditor_TD[playerid][5], 0);

	new result[128];
    new veh = GetPlayerVehicleID(playerid);
	format(result,sizeof(result), "    %i%",Blind[veh]);
	TDEditor_TD[playerid][6] = TextDrawCreate(523.333251, 360.074035, result);
	TextDrawLetterSize(TDEditor_TD[playerid][6], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[playerid][6], 1);
	TextDrawColor(TDEditor_TD[playerid][6], -1);
	TextDrawSetShadow(TDEditor_TD[playerid][6], 0);
	TextDrawSetOutline(TDEditor_TD[playerid][6], 0);
	TextDrawBackgroundColor(TDEditor_TD[playerid][6], 255);
	TextDrawFont(TDEditor_TD[playerid][6], 1);
	TextDrawSetProportional(TDEditor_TD[playerid][6], 1);
	TextDrawSetShadow(TDEditor_TD[playerid][6], 0);
	
	TDEditor_TD[playerid][7] = TextDrawCreate(463.333374, 397.407470, "Velocidade: 0KM/H");
	TextDrawLetterSize(TDEditor_TD[playerid][7], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[playerid][7], 1);
	TextDrawColor(TDEditor_TD[playerid][7], -1);
	TextDrawSetShadow(TDEditor_TD[playerid][7], 0);
	TextDrawSetOutline(TDEditor_TD[playerid][7], 0);
	TextDrawBackgroundColor(TDEditor_TD[playerid][7], 255);
	TextDrawFont(TDEditor_TD[playerid][7], 1);
	TextDrawSetProportional(TDEditor_TD[playerid][7], 1);
	TextDrawSetShadow(TDEditor_TD[playerid][7], 0);

	

	new i;
	for(i = 0;i <= 8;i++){
		TextDrawShowForPlayer(playerid, TDEditor_TD[playerid][i]);
	}
	
  } if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT){
	  	new j;
		for(j = 0;j < 8;j++){
			TextDrawHideForPlayer(playerid, TDEditor_TD[playerid][j]);
		}
  		KillTimer(TimerVelocimetro[playerid]);
	}
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid) {
	new string[50];
 	new Float:health;
    new veh = GetPlayerVehicleID(playerid);
    GetVehicleHealth(veh, health);
    health = health / 10;
    new result[128];
	format(result,sizeof(result),"Lataria: %.0f%",health);
	TextDrawSetString(TDEditor_TD[playerid][5], result);
	format(string, sizeof(string), "    %d%", Blind[veh]);
	TextDrawSetString(TDEditor_TD[playerid][6], string);
	if(Blind[veh] > 0) {
		Blind[veh] --;
		format(string, sizeof(string), "    %d%", Blind[veh]);
		TextDrawSetString(TDEditor_TD[playerid][6], string);
		RepairVehicle(veh);
	}
}

public OnPlayerDeath(playerid, killerid, reason)
{
 	Bomb[playerid] = 0;
    new j;
	for(j = 0;j < 8;j++){
		TextDrawHideForPlayer(playerid, TDEditor_TD[playerid][j]);
	}

	if(PlayerInfo[playerid][0] == PLAYER_GREEN && PlayerInfo[killerid][0] == PLAYER_BLUE){
		PBlue++;
		Money[killerid] = Money[killerid] + 5000;
		new string[128];
		format(string, sizeof(string), "Blue: %d", PBlue);
		TextDrawSetString(Pontuacao[3], string);
	}
	
	if(PlayerInfo[playerid][0] == PLAYER_BLUE && PlayerInfo[killerid][0] == PLAYER_GREEN){
		PGreen++;
		Money[killerid] = Money[killerid] + 5000;
		new string[128];
		format(string, sizeof(string), "Green: %d", PGreen);
		TextDrawSetString(Pontuacao[2], string);
	}
    
    // if they ever return to class selection make them city
	// select again first
	gPlayerHasCitySelected[playerid] = 0;
    

   	return 1;
}

//----------------------------------------------------------

ClassSel_SetupCharSelection(playerid)
{
   	if(gPlayerCitySelection[playerid] == PLAYER_GREEN) {
		SetPlayerInterior(playerid,3);
		SetPlayerPos(playerid,-2673.8381,1399.7424,918.3516);
		SetPlayerColor(playerid,COLOR_GREEN);
		SetPlayerFacingAngle(playerid,181.0);
    	SetPlayerCameraPos(playerid,-2673.2776,1394.3859,918.3516);
		SetPlayerCameraLookAt(playerid,-2673.8381,1399.7424,918.3516);
	}
	else if(gPlayerCitySelection[playerid] == PLAYER_BLUE) {
		SetPlayerInterior(playerid,3);
		SetPlayerPos(playerid,-2673.8381,1399.7424,918.3516);
		SetPlayerColor(playerid,COLOR_BLUE);
		SetPlayerFacingAngle(playerid,181.0);
    	SetPlayerCameraPos(playerid,-2673.2776,1394.3859,918.3516);
		SetPlayerCameraLookAt(playerid,-2673.8381,1399.7424,918.3516);
	}

	
}

//----------------------------------------------------------
// Used to init textdraws of city names

ClassSel_InitCityNameText(Text:txtInit)
{
  	TextDrawUseBox(txtInit, 0);
	TextDrawLetterSize(txtInit,1.25,3.0);
	TextDrawFont(txtInit, 0);
	TextDrawSetShadow(txtInit,0);
    TextDrawSetOutline(txtInit,1);
    TextDrawColor(txtInit,0xEEEEEEFF);
    TextDrawBackgroundColor(txtClassSelHelper,0x000000FF);
}

//----------------------------------------------------------

ClassSel_InitTextDraws()
{
    // Init our observer helper text display
	txtGreen = TextDrawCreate(10.0, 380.0, "~g~Green");
	ClassSel_InitCityNameText(txtGreen);
	txtBlue = TextDrawCreate(10.0, 380.0, "~b~Blue");
	ClassSel_InitCityNameText(txtBlue);

    // Init our observer helper text display
	txtClassSelHelper = TextDrawCreate(10.0, 415.0,
	   " Aperte ~b~~k~~GO_LEFT~ ~w~ou ~b~~k~~GO_RIGHT~ ~w~para mudar de time.~n~ aperte ~r~~k~~PED_FIREWEAPON~ ~w~para escolher.");
	TextDrawUseBox(txtClassSelHelper, 1);
	TextDrawBoxColor(txtClassSelHelper,0x222222BB);
	TextDrawLetterSize(txtClassSelHelper,0.3,1.0);
	TextDrawTextSize(txtClassSelHelper,400.0,40.0);
	TextDrawFont(txtClassSelHelper, 2);
	TextDrawSetShadow(txtClassSelHelper,0);
    TextDrawSetOutline(txtClassSelHelper,1);
    TextDrawBackgroundColor(txtClassSelHelper,0x000000FF);
    TextDrawColor(txtClassSelHelper,0xFFFFFFFF);
}

//----------------------------------------------------------

ClassSel_SetupSelectedCity(playerid)
{
	if(gPlayerCitySelection[playerid] == -1) {
		gPlayerCitySelection[playerid] = PLAYER_GREEN;
	}
	
	if(gPlayerCitySelection[playerid] == PLAYER_GREEN) {
		SetPlayerInterior(playerid,0);
   		SetPlayerCameraPos(playerid,1630.6136,-2286.0298,110.0);
		SetPlayerCameraLookAt(playerid,1887.6034,-1682.1442,47.6167);
		
		TextDrawShowForPlayer(playerid,txtGreen);
		TextDrawHideForPlayer(playerid,txtBlue);
	}
	else if(gPlayerCitySelection[playerid] == PLAYER_BLUE) {
		SetPlayerInterior(playerid,0);
   		SetPlayerCameraPos(playerid,-1300.8754,68.0546,129.4823);
		SetPlayerCameraLookAt(playerid,-1817.9412,769.3878,132.6589);
		
		TextDrawHideForPlayer(playerid,txtGreen);
		TextDrawShowForPlayer(playerid,txtBlue);
	}
}

//----------------------------------------------------------

ClassSel_SwitchToNextCity(playerid)
{
    gPlayerCitySelection[playerid]++;
	if(gPlayerCitySelection[playerid] > PLAYER_BLUE) {
	    gPlayerCitySelection[playerid] = PLAYER_GREEN;
	}
	PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
	gPlayerLastCitySelectionTick[playerid] = GetTickCount();
	ClassSel_SetupSelectedCity(playerid);
}

//----------------------------------------------------------

ClassSel_SwitchToPreviousCity(playerid)
{
    gPlayerCitySelection[playerid]--;
	if(gPlayerCitySelection[playerid] < PLAYER_GREEN) {
	    gPlayerCitySelection[playerid] = PLAYER_BLUE;
	}
	PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
	gPlayerLastCitySelectionTick[playerid] = GetTickCount();
	ClassSel_SetupSelectedCity(playerid);
}

//----------------------------------------------------------

ClassSel_HandleCitySelection(playerid)
{
	new Keys,ud,lr;
    GetPlayerKeys(playerid,Keys,ud,lr);
    
    if(gPlayerCitySelection[playerid] == -1) {
		ClassSel_SwitchToNextCity(playerid);
		return;
	}

	// only allow new selection every ~100 ms
	if( (GetTickCount() - gPlayerLastCitySelectionTick[playerid]) < 100 ) return;
	
	if(Keys & KEY_FIRE) {
	    gPlayerHasCitySelected[playerid] = 1;
	    TextDrawHideForPlayer(playerid,txtClassSelHelper);
		TextDrawHideForPlayer(playerid,txtGreen);
		TextDrawHideForPlayer(playerid,txtBlue);
	    TogglePlayerSpectating(playerid,0);
	    return;
	}
	
	if(lr > 0) {
	   ClassSel_SwitchToNextCity(playerid);
	}
	else if(lr < 0) {
	   ClassSel_SwitchToPreviousCity(playerid);
	}
}

//----------------------------------------------------------

public OnPlayerRequestClass(playerid, classid)
{
	if(IsPlayerNPC(playerid)) return 1;

	if(gPlayerHasCitySelected[playerid]) {
		//ClassSel_SetupCharSelection(playerid);
		return 1;
	} else {
		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING) {
			TogglePlayerSpectating(playerid,1);
    		TextDrawShowForPlayer(playerid, txtClassSelHelper);
    		gPlayerCitySelection[playerid] = -1;
		}
  	}
    
	return 0;
}

//----------------------------------------------------------

public OnGameModeInit()
{
	SetGameModeText("TDM");
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
	ShowNameTags(1);
	SetNameTagDrawDistance(100.0);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	SetWeather(2);
	SetWorldTime(11);
	UsePlayerPedAnims();
 	SetTeamCount(2);
 	EnableVehicleFriendlyFire();
	//SetObjectsDefaultCameraCol(true);
	//UsePlayerPedAnims();
	//ManualVehicleEngineAndLights();
	//LimitGlobalChatRadius(300.0);
	
	//car green
	VGreen[0] = CreateVehicle(560, 1841.7278,-1361.8839,13.5625,359.2195, COLOR_GREEN, COLOR_BLACK, -1); //Veiculo numero 0
	VGreen[1] = CreateVehicle(560, 1841.6176,-1393.9387,13.5625,0.1596, COLOR_GREEN, COLOR_BLACK, -1); //Veiculo numero 1
	VGreen[2] = CreateVehicle(560, 1842.1024,-1417.0206,13.3906,0.1596, COLOR_GREEN, COLOR_BLACK, -1); //Veiculo numero 2
	VGreen[3] = CreateVehicle(560, 1857.0681,-1412.5815,13.5625,0.1596, COLOR_GREEN, COLOR_BLACK, -1); //Veiculo numero 3
	VGreen[4] = CreateVehicle(560, 1856.8329,-1387.7483,13.3906,0.1596, COLOR_GREEN, COLOR_BLACK, -1); //Veiculo numero 4
	VGreen[5] = CreateVehicle(447, 1825.9741,-1372.9065,14.4219,268.6653, COLOR_GREEN, COLOR_BLACK, -1); //Veiculo numero 5
	
	new str[24];
	for(new i = 0;i < 5;i++){
		format(str,sizeof(str),"GREEN-%i",VGreen[i]);
		SetVehicleNumberPlate(VGreen[i], str);
	}
	
	
	
	
	//car blue
	VBlue[0] = CreateVehicle(560, 1981.9463,-1443.1526,13.5669,180.2304, COLOR_BLUE, COLOR_BLACK , -1); //Veiculo numero 0
	VBlue[1] = CreateVehicle(560, 1981.7795,-1432.0066,15.0192,1.1704, COLOR_BLUE, COLOR_BLACK , -1); //Veiculo numero 1
	VBlue[2] = CreateVehicle(560, 1981.9878,-1418.2051,17.5064,1.1704, COLOR_BLUE, COLOR_BLACK , -1); //Veiculo numero 2
	VBlue[3] = CreateVehicle(560, 1992.2061,-1446.2509,13.5647,181.1704,COLOR_BLUE, COLOR_BLACK , -1); //Veiculo numero 3
	VBlue[4] = CreateVehicle(560, 1991.9059,-1416.8298,17.6119,181.1704, COLOR_BLUE, COLOR_BLACK , -1); //Veiculo numero 4
	VBlue[5] = CreateVehicle(447, 2002.5551,-1445.0525,13.5616,139.1833, COLOR_BLUE, COLOR_BLACK , -1); //Veiculo numero 5
	
	for(new i = 0;i < 5;i++){
		format(str,sizeof(str),"BLUE-%i",VBlue[i]);
		SetVehicleNumberPlate(VBlue[i], str);
	}
	
	new objectidL[5];
 	new objectidM[5];
	
	for(new k = 0;k < 5;k++){
        objectidL[k] = CreateObject(19419, 1981.9463,-1443.1526,13.5669, 0.0,0.0,0.0,0.0);
		AttachObjectToVehicle(objectidL[k], VGreen[k], 0.0, 0.0, 0.8, 0.0, 0.0, 0.0);
	}
	
	for(new k = 0;k < 5;k++){
        objectidM[k] = CreateObject(19419, 1981.9463,-1443.1526,13.5669, 0.0,0.0,0.0,0.0);
		AttachObjectToVehicle(objectidM[k], VBlue[k], 0.0, 0.0, 0.8, 0.0, 0.0, 0.0);
	}
	
	//pizza bikes
	VPizza[0] = CreateVehicle(448, 2095.3394,-1816.4541,13.3828,271.3947, -1, -1 , -1); //Veiculo numero 0
	VPizza[1] = CreateVehicle(448, 2095.2988,-1814.0470,13.3828,271.3947, -1,-1, -1); //Veiculo numero 1
	
	for(new i = 0;i < 2;i++){
		format(str,sizeof(str),"PIZZA-%i",VPizza[i]);
		SetVehicleNumberPlate(VPizza[i], str);
	}
	
	//pizza bikes
	VTowCar[0] = CreateVehicle(525,2446.3567,-1556.3132,23.8738,0.1234, -1, -1 , -1); //Veiculo numero 0
	VTowCar[1] = CreateVehicle(525,2456.3567,-1556.3132,23.8738,0.1234, -1,-1, -1); //Veiculo numero 1
	
	for(new i = 0;i < 2;i++){
		format(str,sizeof(str),"MEC-%i",VTowCar[i]);
		SetVehicleNumberPlate(VTowCar[i], str);
	}

	SetTimer("TimeP", 1000, true);
	SetTimer("TimerClock", 1000, true);
    

	
	ClassSel_InitTextDraws();

	// Player Class
	AddPlayerClass(298,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(299,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(300,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(301,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(302,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(303,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(304,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(305,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(280,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(281,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(282,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(283,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(284,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(285,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(286,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(287,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(288,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(289,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(265,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(266,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(267,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(268,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(269,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(270,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(1,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(2,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(3,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(4,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(5,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(6,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(8,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(42,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(65,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	//AddPlayerClass(74,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(86,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(119,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
 	AddPlayerClass(149,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(208,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(273,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(289,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	
	AddPlayerClass(47,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(48,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(49,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(50,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(51,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(52,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(53,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(54,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(55,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(56,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(57,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(58,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
   	AddPlayerClass(68,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(69,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(70,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(71,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(72,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(73,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(75,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(76,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(78,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(79,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(80,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(81,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(82,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(83,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(84,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(85,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(87,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(88,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(89,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(91,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(92,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(93,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(95,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(96,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(97,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(98,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(99,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);

	// SPECIAL
	/*total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/trains.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/pilots.txt");

   	// LAS VENTURAS
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lv_law.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lv_airport.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lv_gen.txt");
    
    // SAN FIERRO
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/sf_law.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/sf_airport.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/sf_gen.txt");
    
    // LOS SANTOS
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/ls_law.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/ls_airport.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/ls_gen_inner.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/ls_gen_outer.txt");
    
    // OTHER AREAS
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/whetstone.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/bone.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/flint.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/tierra.txt");
    total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/red_county.txt");

    printf("Total vehicles from files: %d",total_vehicles_from_files);*/

	return 1;
}

public OnGameModeExit()
{
 	for(new i = 0;i < MAX_PLAYERS;i++){
 	
 	    new string[512];
		for(new j = 0;j < MAX_ACESSORIOS;j++){
		    if(acessoriosP[i][j] == 1){
				format(string, sizeof(string), "%sa%i",string,j);
			}
		}
		
        new file[128], pName[MAX_PLAYER_NAME]; // Cria duas variaveis para armazenamento.
	   	GetPlayerName(i, pName, MAX_PLAYER_NAME); // Armazenamos o nome do jogador na pName
	   	format(file, sizeof(file), "contas/%s.ini", pName); // Formatamos a var file com o nome do jogador
	   	dini_Set(file, "Nome", pName); // Setamos no arquivo formatado o a tag "Nome" com o nome do jogador
	   	dini_IntSet(file, "Skin", GetPlayerSkin(i)); // Setamos a id da skin do player na tag "Skin"
	   	dini_Set(file, "Itens", string);
	   	dini_IntSet(file, "Nivel", Nivel[i]);
	 	dini_IntSet(file, "Exp", Exp[i]);
	 	dini_IntSet(file, "Money", Money[i]);
	   	dini_IntSet(file, "Tempo_Cadeia", cadeia[i][0][0]);
	   	dini_Set(file, "Motivo_Cadeia", cadeia[i][1]);
	}
    print("Gamemode ended.");
    return 1;
}

forward TimeP();
public TimeP(){
	if(Tempo == (TEMPO_PARTIDA/2)){
        SendClientMessageToAll(COLOR_PURPLE, "Uma Arma Especial Foi Spawnada No Meio do Território!");
        new value = random(3);
        EGun[0] = CreatePickup(EspecialGuns[value][0], 1, 1917.7200,-1418.3640,16.3594, 0);
        EGun[1] = EspecialGuns[value][1];
	}

	if(Tempo == 0) {
		if(PBlue > PGreen){
            SendClientMessageToAll(COLOR_BLUE ,"Os BLUE Ganharam!");
		}
		if(PBlue < PGreen){
            SendClientMessageToAll(COLOR_GREEN ,"Os GREEN Ganharam!");
		}
		if(PBlue == PGreen){
            SendClientMessageToAll(COLOR_YELLOW ,"Aconteceu um Empate");
		}
		DestroyPickup(EGun[0]);
		Tempo = TEMPO_PARTIDA;
		PBlue = 0;
		PGreen = 0;
	}
	Tempo--;
 	new string[128];
 	format(string, sizeof(string), "Tempo: %d", Tempo);
	TextDrawSetString(Pontuacao[4], string);
	format(string, sizeof(string), "Blue: %d", PBlue);
	TextDrawSetString(Pontuacao[3], string);
	format(string, sizeof(string), "Green: %d", PGreen);
	TextDrawSetString(Pontuacao[2], string);
	
}

forward TimerClock();
public TimerClock(){
	new year, month, day, hours, minutes, seconds;
	getdate(year, month, day), gettime(hours, minutes, seconds);
 	if(minutes == 0 && seconds == 0){
		SendClientMessageToAll(COLOR_GREEN ,"Payday: +1 de Exp");
		for(new i = 0;i < MAX_PLAYERS;i++){
			Exp[i]++;
			if(Exp[i] >= 10){
                Exp[i] = 0;
                Nivel[i]++;
                SendClientMessage(i,COLOR_GREEN ,"Parabens Você Passou de Nível");
			}
		}
	}
}

//----------------------------------------------------------

public OnPlayerEnterCheckpoint(playerid)
{
    DisablePlayerCheckpoint(playerid);
	if(Profissoes[playerid][0] == ENTREGADOR_PIZZA && Profissoes[playerid][1] == 1){
		if(pizza[playerid] > 1){
			SendClientMessage(playerid,COLOR_GREEN ,"Você Recebeu 1000$ Pela Pizza!");
			PlayerPlaySound(playerid, 1150, 0.0, 0.0, 10.0);
	  		GivePlayerMoney(playerid, 1000);
			new value = random(3);
			new Float:randowP[3][3] = {{2062.8569,-1820.7913,13.5469},{2089.3984,-1905.5582,13.5469},{2151.2695,-1902.4280,13.5507}};
			house[playerid] = SetPlayerCheckpoint(playerid, randowP[value][0], randowP[value][1],randowP[value][2], 3.0);
			SendClientMessage(playerid, COLOR_WHITE ,"Nova Casa Marcada!");
			new str[128];
			format(str, sizeof(str), "Pizzas: %i", pizza[playerid]-1);
			SendClientMessage(playerid, -1 ,str);
			pizza[playerid]--;
		} else {
	 		SendClientMessage(playerid,COLOR_GREEN ,"Você Recebeu 1000$ Pela Pizza!");
	   		GivePlayerMoney(playerid, 1000);
			pizza[playerid] = 0;
			Profissoes[playerid][1] = 0;
			new str[128];
			format(str, sizeof(str), "Pizzas: %i", pizza[playerid]);
			SendClientMessage(playerid, COLOR_WHITE ,str);
			SendClientMessage(playerid, COLOR_RED ,"Suas Pizzas Acabaram, Volte na Pizzaria Para Pegar Mais");
			PlayerPlaySound(playerid, 1150, 0.0, 0.0, 10.0);
			DisablePlayerCheckpoint(playerid);
		}
	}
    return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    if(pickupid == EGun[0]){
    	PlayerPlaySound(playerid, 1150, 0.0, 0.0, 10.0);
        new str[128],name[128];
        GetPlayerName(playerid, name, sizeof(name));
        format(str,sizeof(str),"O Player %s Pegou a Arma Especial",name);
    	SendClientMessageToAll(COLOR_ORANGE ,str);
    	GivePlayerWeapon(playerid,EGun[1],500);
        DestroyPickup(EGun[0]);
	}

    return 1;
}

public OnPlayerUpdate(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(IsPlayerNPC(playerid)) return 1;

	// changing cities by inputs
	if( !gPlayerHasCitySelected[playerid] &&
	    GetPlayerState(playerid) == PLAYER_STATE_SPECTATING ) {
	    ClassSel_HandleCitySelection(playerid);
	    return 1;
	}
	
	// No weapons in interiors
	//if(GetPlayerInterior(playerid) != 0 && GetPlayerWeapon(playerid) != 0) {
	    //SetPlayerArmedWeapon(playerid,0); // fists
	    //return 0; // no syncing until they change their weapon
	//}
	
	/* No jetpacks allowed
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK) {
	    Kick(playerid);
	    return 0;
	}*/

	/* For testing animations
    new msg[128+1];
	new animlib[32+1];
	new animname[32+1];

	thisanimid = GetPlayerAnimationIndex(playerid);
	if(lastanimid != thisanimid)
	{
		GetAnimationName(thisanimid,animlib,32,animname,32);
		format(msg, 128, "anim(%d,%d): %s %s", lastanimid, thisanimid, animlib, animname);
		lastanimid = thisanimid;
		SendClientMessage(playerid, 0xFFFFFFFF, msg);
	}*/

	return 1;
}


//----------------------------------------------------------
