#include <sourcemod>
#include <devzones>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "SM DEV ZONES - Chat Block", 
	author = "ByDexter", 
	description = "", 
	version = "1.1", 
	url = "https://steamcommunity.com/id/ByDexterTR/"
};

public void OnPluginStart()
{
	LoadTranslations("devzones_chatblock.phrases");
}

public Action OnClientSayCommand(int client, const char[] command, const char[] sArgs)
{
	if (IsValidClient(client))
	{
		if (Zone_IsClientInZone(client, "bchatblock"))
		{
			ReplyToCommand(client, "[SM] %T", "bchatblock");
			return Plugin_Handled;
		}
		if (StrContains(command, "_", false) != -1)
		{
			if (Zone_IsClientInZone(client, "tchatblock"))
			{
				ReplyToCommand(client, "[SM] %T", "tchatblock");
				return Plugin_Handled;
			}
		}
		else
		{
			if (Zone_IsClientInZone(client, "achatblock"))
			{
				ReplyToCommand(client, "[SM] %T", "achatblock");
				return Plugin_Handled;
			}
		}
	}
	return Plugin_Continue;
}

bool IsValidClient(int client, bool nobots = true)
{
	if (client <= 0 || client > MaxClients || !IsClientConnected(client) || (nobots && IsFakeClient(client)))
	{
		return false;
	}
	return IsClientInGame(client);
} 