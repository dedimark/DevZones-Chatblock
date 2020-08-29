// ------ #include ------ //

#include <sourcemod>
#include <devzones>
#include <multicolors>

// ------ int ------ //

int Allblock[MAXPLAYERS + 1];
int Publicblock[MAXPLAYERS + 1];
int Teamblock[MAXPLAYERS + 1];

// ------ #pragma ------ //

#pragma semicolon 1
#pragma newdecls required

// ------ myinfo ------ //

public Plugin myinfo = 
{
	name = "SM DEV ZONES - Chat Block",
	author = "ByDexter",
	description = "",
	version = "1.0",
	url = "https://steamcommunity.com/id/ByDexterTR/"
};

public void OnPluginStart()
{
	AddCommandListener(OnClientSay, "say");
	AddCommandListener(OnClientSayT, "say_team");	
}

public void OnClientDisconnect(int client)
{
	if (Publicblock[client] == 1 || Teamblock[client] == 1 || Allblock[client] == 1)
	{
		Publicblock[client] = 0;
		Teamblock[client] = 0;
		Allblock[client] = 0;
	}
}
	

public void Zone_OnClientEntry(int client, const char[] zone)
{
	if(client < 1 || client > MaxClients || !IsClientInGame(client) ||!IsPlayerAlive(client)) 
		return;
		
	if(StrContains(zone, "pblock", false) == 0)
	{
		Publicblock[client] = 1;
		CPrintToChat(client, "{darkred}[ByDexter] {green}pblock Bölgesine {default}girdiniz.");
	}
	if(StrContains(zone, "tblock", false) == 0)
	{
		Teamblock[client] = 1;
		CPrintToChat(client, "{darkred}[ByDexter] {green}tblock Bölgesine {default}girdiniz.");
	}
	if(StrContains(zone, "ablock", false) == 0)
	{
		Allblock[client] = 1;
		CPrintToChat(client, "{darkred}[ByDexter] {green}ablock Bölgesine {default}girdiniz.");
	}
}

public void Zone_OnClientLeave(int client, const char[] zone)
{
	if(client < 1 || client > MaxClients || !IsClientInGame(client) ||!IsPlayerAlive(client)) 
		return;
		
	if(StrContains(zone, "pblock", false) == 0)
	{
		Publicblock[client] = 0;
		CPrintToChat(client, "{darkred}[ByDexter] {green}pblock Bölgesinden {default}ayrıldınız.");
	}
	if(StrContains(zone, "tblock", false) == 0)
	{
		Teamblock[client] = 0;
		CPrintToChat(client, "{darkred}[ByDexter] {green}tblock Bölgesinden {default}ayrıldınız.");
	}
	if(StrContains(zone, "ablock", false) == 0)
	{
		Allblock[client] = 0;
		CPrintToChat(client, "{darkred}[ByDexter] {green}ablock Bölgesinden {default}ayrıldınız.");
	}
}

public Action OnClientSay(int client, const char[] command, int argc)
{
	if (Publicblock[client] == 1)
	{
		CPrintToChat(client, "{darkred}[ByDexter] {green}pblock bölgesinde {default}Genel sohbete yazı yazamazsınız.");
		return Plugin_Handled;
	}
	if (Allblock[client] == 1)
	{
		CPrintToChat(client, "{darkred}[ByDexter] {green}ablock bölgesinde {default}Sohbete yazı yazamazsınız.");
		return Plugin_Handled;
	}
	return Plugin_Continue;
}

public Action OnClientSayT(int client, const char[] command, int argc)
{
	if (Teamblock[client] == 1)
	{
		CPrintToChat(client, "{darkred}[ByDexter] {green}tblock bölgesinde {default}Takım sohbete yazı yazamazsınız.");
		return Plugin_Handled;
	}
	if (Allblock[client] == 1)
	{
		CPrintToChat(client, "{darkred}[ByDexter] {green}ablock bölgesinde {default}Sohbete yazı yazamazsınız.");
		return Plugin_Handled;
	}
	return Plugin_Continue;
}