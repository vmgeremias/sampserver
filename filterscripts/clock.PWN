/*
Clock & Date System
Made by: ZaBraNjeNi
		///////////////////
   	       /////       ///////
                         ///////
                       ///////
 		     ////////
		   ////////
                 ////////     //////
               ///////////////////
*/


#include <a_samp>
#define FILTERSCRIPT

new Text:Date;
new Text:Line1;
new Text:Line2;
new Text:Time;


public OnFilterScriptInit()
{
    print("\n---------------------------------------");
 	print("          Anti - Spawn Kill              ");
 	print("         Made by: ZaBraNjeNi            	");
 	print("            L O A D E D                  ");
 	print("---------------------------------------\n");

	Date = TextDrawCreate(35.000000, 312.000000, "06/04/2015");
	TextDrawBackgroundColor(Date, 255);
	TextDrawFont(Date, 3);
	TextDrawLetterSize(Date, 0.509999, 1.000000);
	TextDrawColor(Date, -1);
	TextDrawSetOutline(Date, 0);
	TextDrawSetProportional(Date, 1);
	TextDrawSetShadow(Date, 1);

	Line1 = TextDrawCreate(22.000000, 318.000000, "-");
	TextDrawBackgroundColor(Line1, 255);
	TextDrawFont(Line1, 1);
	TextDrawLetterSize(Line1, 6.699995, 1.000000);
	TextDrawColor(Line1, 16711935);
	TextDrawSetOutline(Line1, 0);
	TextDrawSetProportional(Line1, 1);
	TextDrawSetShadow(Line1, 1);

	Line2 = TextDrawCreate(22.000000, 304.000000, "-");
	TextDrawBackgroundColor(Line2, 255);
	TextDrawFont(Line2, 1);
	TextDrawLetterSize(Line2, 6.699995, 1.000000);
	TextDrawColor(Line2, 16711935);
	TextDrawSetOutline(Line2, 0);
	TextDrawSetProportional(Line2, 1);
	TextDrawSetShadow(Line2, 1);

	Time = TextDrawCreate(35.000000, 297.000000, "00:00:00");
	TextDrawBackgroundColor(Time, 255);
	TextDrawFont(Time, 1);
	TextDrawLetterSize(Time, 0.500000, 1.000000);
	TextDrawColor(Time, -1);
	TextDrawSetOutline(Time, 0);
	TextDrawSetProportional(Time, 1);
	TextDrawSetShadow(Time, 1);

	SetTimer("time", 1000, true);
	return 1;
}

public OnFilterScriptExit()
{
    print("\n---------------------------------------");
    print("          Anti - Spawn Kill              ");
    print("         Made by: ZaBraNjeNi             ");
    print("          U N - L O A D E D              ");
    print("---------------------------------------\n");

	return 1;
}

public OnPlayerSpawn(playerid)
{
	TextDrawShowForPlayer(playerid, Date);
	TextDrawShowForPlayer(playerid, Line1);
	TextDrawShowForPlayer(playerid, Line2);
	TextDrawShowForPlayer(playerid, Time);
}

public OnPlayerDisconnect(playerid, reason)
{
	TextDrawHideForPlayer(playerid, Date);
	TextDrawHideForPlayer(playerid, Line1);
	TextDrawHideForPlayer(playerid, Line2);
	TextDrawHideForPlayer(playerid, Time);
}

forward time();
public time()
{
	new string[256], year, month, day, hours, minutes, seconds;
	getdate(year, month, day), gettime(hours, minutes, seconds);
	format(string, sizeof string, "%s%d/%s%d/%s%d",((month < day) ? ("0") : ("")) ,day, ((month < 10) ? ("0") : ("")), month, (year < 10) ? ("0") : (""), year);
	TextDrawSetString(Date, string);
	format(string, sizeof string, "%s%d:%s%d:%s%d", (hours < 10) ? ("0") : (""), hours, (minutes < 10) ? ("0") : (""), minutes, (seconds < 10) ? ("0") : (""), seconds);
	TextDrawSetString(Time, string);
}
