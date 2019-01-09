#include <a_samp>
#include <SII> // Include SII.inc

#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

new player_name[MAX_PLAYERS][MAX_PLAYER_NAME];
new bool: player_loggedin[MAX_PLAYERS];

main()
{

}

public OnGameModeInit()
{
    AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    return 1;
}

public OnPlayerConnect(playerid)
{
    GetPlayerName(playerid, player_name[playerid], MAX_PLAYER_NAME);
    return 1;
}

public OnPlayerDisconnect(playerid)
{
    player_loggedin[playerid] = false;
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    dcmd(register, 8, cmdtext);
    dcmd(login, 5, cmdtext);
    return 0;
}

dcmd_register(playerid, params[])
{
    if (player_loggedin[playerid]) // Player is already registered and logged in
    {
        SendClientMessage(playerid, 0x0040FFAA, "You are already registered and logged in.");
        return 1;
    }
    else if (!params[0]) // No password was specified
    {
        SendClientMessage(playerid, 0x0040FFAA, "Usage: /register [password]");
        return 1;
    }
    else if (INI_Open("Users.ini")) // Try open "Users.ini"
    {
        new password[128];
        if (INI_ReadString(password, player_name[playerid], MAX_PLAYER_NAME)) // Is player already registered?
        {
            SendClientMessage(playerid, 0x0040FFAA, "You are already registred, please /login.");
        }
        else // Register player
        {
            INI_WriteString(player_name[playerid], params);
            SendClientMessage(playerid, 0x0040FFAA, "Registration successful.");
        }
        INI_Save(); // Save all the data we have written to "Users.ini"
        INI_Close(); // Remember to close open files when finished
        return 1;
    }
    SendClientMessage(playerid, 0x0040FFAA, "Registration failed."); // There was an error opening "Users.ini"
    return 1;
}

dcmd_login(playerid, params[])
{
    if (player_loggedin[playerid]) // Player is already logged in
    {
        SendClientMessage(playerid, 0x0040FFAA, "You are already logged in.");
        return 1;
    }
    else if (!params[0]) // No password was specified
    {
        SendClientMessage(playerid, 0x0040FFAA, "Usage: /login [password]");
        return 1;
    }
    else if (INI_Open("Users.ini")) // Try open "Users.ini"
    {
        new password[128];
        if (INI_ReadString(password, player_name[playerid], MAX_PLAYER_NAME)) // Read players data (if it exists)
        {
            if (!strcmp(password, params, false)) // Login player
            {
                player_loggedin[playerid] = true;
                SendClientMessage(playerid, 0x0040FFAA, "Login successful.");
            }
            else // Incorrect password
            {
                SendClientMessage(playerid, 0x0040FFAA, "Incorrect Password.");
            }
        }
        else // No data was found for the player
        {
            SendClientMessage(playerid, 0x0040FFAA, "Please /register first.");
        }
        INI_Close(); // Remember to close open files when finished, no need to save this time
        return 1;
    }
    SendClientMessage(playerid, 0x0040FFAA, "Login failed."); // There was an error opening "Users.ini"
    return 1;
}

// Other functions include INI_Exists("filename"), INI_WriteInt("key", value), INI_WriteFloat("key", Float: value),
// value = INI_ReadInt("key"), Float: value = INI_ReadFloat("key"), INI_RemoveEntry("key") and INI_Remove("filename").