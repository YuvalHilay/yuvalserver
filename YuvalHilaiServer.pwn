//all credits for YUVAL HILAI
//all credits for YUVAL HILAI
//all credits for YUVAL HILAI
//all credits for YUVAL HILAI
//all credits for YUVAL HILAI
//all credits for YUVAL HILAI
#define ServerName     "Israel Official Server"
#define Forum           ""
#define Version        "V1.0"
#define ModeMap        "San Fierro"
//==============================================================================
#include <DOF2>
#include <a_samp>
#include <core>
#include <float>
#include <cpstream>
#include <Vehicleex>
#include <Streamer>
#include <a_npc>
#include <DUDB>
#pragma tabsize 0
//==============================================================================

#include <mailer>
#define SetEmailDialog 10000
#define ResetPassDialog 10001
#define MSGBoxDialog 10002
#define BugDialog 10003
//==============================================================================
new Text:Textdraw1[MAX_PLAYERS];
new bool:Ignore[MAX_PLAYERS][MAX_PLAYERS];
#define MONEYSHIPTIME 5
#define MONEYSHIPMONEY 100
forward MoneyShip();
new xStuntsMission,xMoneyMission,SeePm[MAX_PLAYERS],SeeDisconnect[MAX_PLAYERS],SeeLp[MAX_PLAYERS],SeeBomb[MAX_PLAYERS],NeedHelp[MAX_PLAYERS];
#define COLOR_GRAY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_AQUA 0x7CFC00AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_LIGHTBLUE 0x6DC5F3FF
#define COLOR_KRED 0xFF0000FF
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_LIGHTGREEN 0x24FF0AB9
new Logged[MAX_PLAYERS];
new InAfk[MAX_PLAYERS];
//==============================================================================
new RulesTimer[MAX_PLAYERS];
forward Rules(playerid, num);
#define RulesDialog1 3
#define RulesDialog2 4
#define RulesDialog3 5
#define RulesDialog4 6
#define RulesDialog5 7
#define RulesDialog6 8
#define RulesDialog7 9
#define RulesDialog8 10
#define RulesDialog9 11
#define RulesDialog10 12
#define RulesDialog11 13
#define RulesDialog12 14
#define RulesDialog13 15
#define RulesDialog14 16
#define RulesDialog15 17
#define RulesDialog16 18
//==============================================================================
new Float:TanksSpawns[][3] = {
{1413.7982,2731.3555,10.8326},
{1408.2289,2857.4973,10.8544},
{1370.4822,2855.2178,10.8352},
{1380.8894,2728.8687,10.8591},
{1351.9580,2855.9988,10.8600},
{1339.5459,2855.7754,10.8344},
{1302.0045,2856.5449,10.9496},
{1295.6407,2729.0681,10.8328},
{1253.4745,2729.8147,10.8305},
{1253.5457,2856.3137,10.8346},
{1208.0388,2730.0757,10.8607},
{1160.5857,2728.0645,10.8513},
{1119.9977,2751.4248,10.8479},
{1120.3873,2834.4373,10.8317},
{1193.1290,2776.5942,10.8144},
{1192.4077,2826.0403,10.8326},
{1244.6815,2821.0576,10.8320},
{1276.6238,2812.5798,10.8356},
{1331.6498,2792.0667,10.8362},
{1411.5238,2786.6067,10.8600}
};
#define MinTanksPlayers 2
forward TanksCheck();
forward TanksCD();
forward TanksEnd(status);
forward TeleportToTanks();
forward TanksUnFreeze();
new TanksCountFuc;
new Tanksknoob;
new TanksCount;
new TanksOn;
new TanksCar[MAX_PLAYERS];
new InTanks[MAX_PLAYERS];
new TanksPlayers;
new TanksWinnerCheck;
new TanksWinner;
new TanksReward;
new TanksStarted;
//==============================================================================
#define MInSwarPlayers 2
new Float:Position[200][3];
new InSwar[200];
new knob[256];
new Adminname[MAX_PLAYER_NAME];
new Swar[MAX_PLAYERS];
new SwarPlayers;
new Float:Spawns[][4] = {
	{-10.0781,-2099.4202,16.8332},
	{-38.9886,-2100.4568,16.8340},
	{-42.8477,-2079.7532,16.8340},
	{-30.5962,-2059.4946,16.8331},
    {93.5906,-2042.8031,32.0342},
	{78.9815,-2040.1637,32.0340},
	{53.3125,-2018.9677,32.0340},
	{15.8119,-1998.5403,32.0341},
	{10.9026,-2037.5785,32.0340},
	{11.2369,-2042.8976,32.0328},
	{14.0204,-2115.6125,32.0342},
    {14.9609,-2146.9138,32.0341}
};

new SwarOn;
new SwarReward;
new CountTimer;
forward SwarStart();
forward Countdowns(Time,Num);
forward TeleportPlayersToSwar();
forward SwarEnd(Num,Winner);
forward Unfreeze();
forward CheckPlayers(PlayersNumber);
//==============================================================================
/*new Logox = 1;
new Text:Timex;
forward settimeLogoEx(playerid);
forward settimeLogo(playerid);
new Text:Logo;*/
//==============================================================================
new AmmoString[2265];
new Text1[] = "01.{04C3C3}Golf Club{ffffff}\tPrice:$800\tAmmu:1";
new Text2[] = "02.{04C3C3}Baseball Bat{ffffff}\tPrice:$300\tAmmu:1";
new Text3[] = "03.{04C3C3}Knife{ffffff}\tPrice:$400\tAmmu:1";
new Text4[] = "04.{04C3C3}Chainsaw{ffffff}\tPrice:$2,600\tAmmu:1";
new Text5[] = "05.{29A228}Pistol{ffffff}\tPrice:$3,400\tAmmu:50";
new Text6[] = "06.{29A228}Silenced Pistol{ffffff}\tPrice:$3,300\tAmmu:60";
new Text7[] = "07.{29A228}Desert Eagle{ffffff}\tPrice:$3,600\tAmmu:30";
new Text8[] = "08.{F89500}Shoutgun{ffffff}\tPrice:$1,100\tAmmu:70";
new Text9[] = "09.{F89500}Combat Shoutgun{ffffff}\tPrice:$1,600\tAmmu:70";
new Text10[] = "10.{F89500}Sawn Of Shoutgun{ffffff}\tPrice:$5,500\tAmmu:100";
new Text11[] = "11.{FFFF00}Mp5{ffffff}\tPrice:$1,900\tAmmu:300";
new Text12[] = "12.{FFFF00}Mirco Uzi{ffffff}\tPrice:$1,300\tAmmu:400";
new Text13[] = "13.{FFFF00}Tec9{ffffff}\tPrice:$1,500\tAmmu:400";
new Text14[] = "14.{A1173A}M4{ffffff}\tPrice:$4,600\tAmmu:200";
new Text15[] = "15.{A1173A}AK47{ffffff}\tPrice:$4,100\tAmmu:200";
new Text16[] = "16.{A1173A}Rilfe{ffffff}\tPrice:$2,300\tAmmu:30";
new Text17[] = "17.{A1173A}Sniper Rilfe{ffffff}\tPrice:$6,200\tAmmu:20";
//==============================================================================
enum battlelist{ InBattle,IDInvite,IDJoin,InviteMe,MoneyBattle,InviteAnyOne,TimerBattle,CountBattle,TimerCountBattle,sstring2[128],joiner,Inviter}
new battle[MAX_PLAYERS][battlelist];
#define Color_GMX 0x00bbbbAA
new CarGM[MAX_VEHICLES],IdInvite;
new HqAviran[3],HqCpT[3],SultanA;
new CP_StuntStart,StuntMissionDo,StuntCar,Hqq,Hqq1,MoneyMissionPickup,CP_MoneyMission,MoneyMissionTimer;
new TriviaOn,EndTrivia,PizzaCar[6];
new Float:SawnTeleports[3][4] = {
{1038.3416,1335.3308,10.8203,247.0594},
{1082.7727,1225.5695,10.8203,5.1638},
{1087.7124,1360.6074,10.8203,175.6187}
};
new InSawn[MAX_PLAYERS];
new VipHq,Vip;
#define DIALOG_BANK 5699
#define DIALOG_BankDeposit 6699
#define DIALOG_BankWithdraw 7699
new BankCP;
new ArmourSur,HpSur,SCar[39];
new SBomb[MAX_PLAYERS],UseBomb[MAX_PLAYERS];
new Text:txtTimeDisp;
new shour, sminute;
new timestr[32];
forward UpdateTimeAndWeather();
new engine, lights, alarm, doors, bonnet, boot, objective;
new AID,Text:Textdraw0,SpySystem[MAX_PLAYERS];
new GetAName[MAX_PLAYERS][MAX_PLAYER_NAME];
new ActNumber,stimer,atime;
#define MAX_CLANS 10
#define Color_BB 0x2FE3EEAA
new SString[256],GMXOn,SKills[MAX_PLAYERS], Deaths[MAX_PLAYERS];
#define SendFormatMessage(%0,%1,%2,%3) format(SString, sizeof(SString),%2,%3) && SendClientMessage(%0, %1, SString)
#define SendFormatMessageToAll(%0,%1,%2) format(SString, sizeof(SString),%1,%2) && SendClientMessageToAll(%0, SString)
#define MAX_FAILURE_LOGINS 3
new CarSystem,CustomStats,FailureLogin[MAX_PLAYERS];
new CodeMoney,CodeQuestion[256],CodeOn,EndCode,anim[MAX_PLAYERS],Drinked[MAX_PLAYERS],str[225],Honor,Remington,Elegy,Elegy2,JaSOpenMain1,JaSOpenMain2,JaSOpen2;
new TDMTimer,Question[256],Answer[256],pFPS[MAX_PLAYERS],pDrunkLevelLast[MAX_PLAYERS],Autonitro[MAX_PLAYERS],Autojump[MAX_PLAYERS],Autopjump[MAX_PLAYERS],CarDisco[MAX_PLAYERS],levelname[27],SupportersLevel[40];
#define COLOR_SATLA 0x00FF00FF // ��� ���� ��� ;)
#define Random(%0,%1) random(%1 - %0) + %0
enum lottoInfo{ on,pay,satla,choose[200],LottoTimer,winners}
enum playerInfo{ nnumber,participant}
new lotto[lottoInfo], pInfo[MAX_PLAYERS][playerInfo];
new GunGameOn,GunGame[MAX_PLAYERS],InGunGame[MAX_PLAYERS],GunGameSpawn1[MAX_PLAYERS],GunGameWeapon1[MAX_PLAYERS],GunGameTime;
new HelpPlz[MAX_PLAYERS],Spec[MAX_PLAYERS];
new InWeapons[MAX_PLAYERS],WeaponsOn,WeaponsPlayers,WeaponsWinnerCheck,WeaponsWinner,WeaponsStarted,WeaponsMoney,WeaponsWeapon;
new Float:WeaponsSpawns[][] = {
{-1280.9884,999.0562,1037.3086,358.7467},{-1291.0841,1027.4156,1037.7930,126.2745},{-1302.1292,1034.1848,1037.9336,97.1342},{-1303.6318,1029.9680,1037.8656,166.0682},{-1315.8005,1040.1653,1038.0515,64.2339},{-1323.6263,1052.1239,1038.2721,63.9206},{-1334.9299,1046.5376,1038.1884,100.8943},{-1345.9055,1051.7235,1038.3009,102.7743},
{-1351.0457,1059.6046,1038.4368,112.4877},{-1360.0516,1059.8513,1038.4625,128.1545},{-1370.0803,1060.4854,1038.4895,87.4208},{-1382.9357,1060.6093,1038.5135,267.5892},{-1382.3278,1063.2585,1038.5500,266.9625},{-1381.5656,1055.7671,1038.4312,266.9625},
{-1392.4849,1052.6279,1038.3563,84.9141},{-1406.4917,1058.6942,1038.5183,87.4208},{-1407.5913,1055.4302,1038.4652,87.4208},{-1407.2091,1062.9432,1038.5817,267.4208},{-1427.9569,1058.9222,1038.5583,138.4946},{-1433.8094,1054.5378,1038.4968,221.2154},
{-1437.8975,1052.0786,1038.4672,257.5623},{-1454.2251,1051.1917,1038.4701,108.1009},{-1460.6445,1053.6796,1038.5269,67.3672},{-1459.6775,1057.9238,1038.5999,31.9602},{-1470.2233,1051.3120,1038.5090,80.8406},{-1473.0555,1045.3329,1038.4133,159.1747},
{-1467.5713,1045.7045,1038.4047,207.4285},{-1489.8840,1045.2695,1038.4391,100.8941},{-1494.2562,1041.7061,1038.3837,131.6011},{-1487.2426,1041.9550,1038.3813,125.6477},{-1485.4590,1038.6289,1038.3242,125.6477},{-1485.8860,1034.1542,1038.2517,125.6477},
{-1497.4528,1031.8185,1038.2303,333.3663},{-1494.3334,1032.6367,1038.2368,283.2325},{-1500.3853,1022.4764,1038.0773,157.2713},{-1504.0308,1022.7319,1038.0881,91.7840},{-1511.7321,1013.4008,1037.9413,331.1496},{-1518.3239,1015.8851,1037.9983,327.0762},
{-1517.4929,1008.9797,1037.8822,327.0762},{-1514.2611,1007.7655,1037.8558,327.0762},{-1511.3030,1006.5167,1037.8292,327.0762},{-1513.7682,996.0344,1037.6638,171.0581},{-1516.4122,980.4163,1037.4093,201.1384},{-1507.6355,961.0233,1037.0721,228.9628},
{-1500.2330,969.6501,1037.2024,48.7120},{-1482.6986,954.3869,1036.9188,247.1989},{-1484.0433,945.2527,1036.7521,339.9464},{-1462.2280,937.8966,1036.6046,346.8398},{-1467.6158,945.4490,1036.7317,249.3197},{-1453.2017,939.6082,1036.5985,301.4060}};
new UserID,Clanss,Banned;
#define Rules_Dialog1  39 // /Rules
#define Rules_Dialog2  40 // /Rules
#define Rules_Dialog3  41 // /Rules
#define Rules_Dialog4  42 // /Rules
#define Rules_Dialog5  43 // /Rules
#define Rules_Dialog6  44 // /Rules
#define Rules_Dialog7  45 // /Rules
#define Rules_Dialog8  46 // /Rules
#define Rules_Dialog9  47 // /Rules
#define Rules_Dialog10 48 // /Rules
#define Rules_Dialog11 49 // /Rules
#define Rules_Dialog12 50 // /Rules
#define Rules_Dialog13 51 // /Rules
#define Rules_Dialog14 52 // /Rules

#define Hq1 "JaS"
#define Hq2 "None"
#define Hq3 "VoLuMe"
#define Hq4 "SuiT"
#define Hq5 "None"
#define Hq6 "None"
#define Hq7 "None"
/*#define MAX_GANGS 50
#define MAX_GANG_MEMBERS 15
#define MAX_GANG_NAME 15
forward PlayerLeaveGang(playerid);*/
#define Honor_color 0xFFFF00AA
#define color_white 0xFFFFFFAA
#define color_main 0x33CCFFAA
#define color_bg 0x46BBAA00
#define color_r 0xAA3333AA
#define color_v 0x0FFDD349
new OldInfo[200][2];
new Text:gText;
new BlockPm[MAX_PLAYERS];
new BlockChat[MAX_PLAYERS];
new doublekills;
new tripelkills;
new Float:PlayerPos[MAX_PLAYERS][3];
#define Level2 150
#define Level3 250
#define Level4 400
#define Level5 600
#define Level6 800
#define Level7 1000
#define Level8 1250
#define Level9 1500
#define Level10 1720
#define Level11 2000
#define Level12 2500
#define Level13 3000
#define Level14 3500
#define Level15 4500
#define Level16 5250
#define Level17 6000
#define Level18 6750
#define Level19 7250
#define Level20 8000
#define Level21 9000
#define Level22 10000
#define Level23 11000
#define Level24 12500
#define Level25 14000
#define Level26 16000
#define Level27 18000
#define Level28 20000
#define Level29 25000
#define Level30 30000
#define Level31 40000
#define Level32 40000
//==============================================================================
new PlayerColors[200] = {
0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,
0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,
0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,
0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,0x3D0A4FFF,
0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,0x057F94FF,
0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,
0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,
0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,
0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,
0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,0xDCDE3DFF,
0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
0xD8C762FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,
0xF4A460FF,0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,
0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,
0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,
0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,
0x18F71FFF,0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,
0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,
0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,
0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,
0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,
0xD8C762FF,0xD8C762FF
};
//==============================================================================
new RandomMSG[][] = {
"[Auto Message]: /Ap - ? ������� ���� ������� ���� �� ���� �����",
"[Auto Message]: /ChangeNick - ? ������� ����� ��� ����",
"[Auto Message]: /Commands - ? �� ���� �� ������� ����",
"[Auto Message]: /ClanHelp - ? ���� ���� ������ �������",
"[Auto Message]: /Dice - ? ���� ���� �� ���� ����� ������",
"[Auto Message]: /Forum - ? ������� ������ ������ �� ������",
"[Auto Message]: /GetRC - ? ���� ������� �������/����/���� �� ���",
"[Auto Message]: /Rules - ? ����� �� ���� �� ���� ����",
"[Auto Message]: /S - ? ������� ����� �� ������ ����� ���",
"[Auto Message]: /Sawn - ���� ���� ��� � 2-2 ? ��� ����� �� ����",
"[Auto Message]: /ServerStats - ? ������� ����� ����� �� ����",
"[Auto Message]: /SetPrice - ? ������� ����� �� ���� ������",
"[Auto Message]: /Pm - ? ������� ����� ����� ����� �����",
"[Auto Message]: /Sp - ? ������� ����� ����",
"[Auto Message]: /Clear - ? ������� ����� �� ��'�� ����� ���",
"[Auto Message]: /Tower - ? ������� ������ ������ ����� ��� �����",
"[Auto Message]: /CarEject - ? ������� ����� ���� ����� ��� ��� ����",
"[Auto Message]: /Call - ? ������� ������ ������� ����",
"[Auto Message]: /Gang - ? ���� ���� ������ �������",
"[Auto Message]: /Bomb - ? ������� ������ ����",
"[Auto Message]: /Credits - ������ ������ ������ ��� ���� ����",
"[Auto Message]: /Ramp - ������� ���� ������ ������ ? ��� �� ������ ����� ������",
"[Auto Message]: /FightStyle - ? ������� ����� ������� �����",
"[Auto Message]: /SaveSkin - ? ������� ����� �� ����� ���",
"[Auto Message]: /DelSkin - ? ������� ����� �� ����� ���",
"[Auto Message]: /SetPass - ? ������� ����� �����",
"[Auto Message]: /Dance - ? ������� ����� ��� ���� �����",
"[Auto Message]: /T - ������ �������� ����"};
//==============================================================================
main() { }
new Danced[MAX_PLAYERS];
new Stoned[MAX_PLAYERS];
#define neondialog1 8132
new id;
//Dm
new InDM[MAX_PLAYERS];
new Float:DMSpawns[8][4] = {
{1382.4082,2186.0706,11.0234}, // dm1b1
{1395.1263,2169.2266,9.7578}, // dm2b2
{1344.7491,2176.7605,11.0234}, // dm3b3
{1312.4448,2180.2861,11.0234}, // dm4b4
{1305.7913,2109.1995,11.0156}, // dm5r1
{1330.8894,2111.9644,11.0156},// dm6r2
{1328.2018,2129.2742,11.0156}, // dm7r3
{1376.1110,2135.8643,11.0156} // dm7r4
};

//clans
new ClanMute[MAX_PLAYERS];
//Mini Activity
new Float:MiniSpawns[44][4] = {
{2604.6140,2726.2878,23.8222,355.6701},
{2653.8049,2774.0933,19.3222,179.9585},
{2618.6670,2778.8477,23.8222,185.8886},
{2616.3787,2705.8723,25.8222,355.3801},
{2634.3743,2803.4150,32.3222,91.5978},
{2672.1074,2724.4912,10.8203,98.8277},
{2618.6755,2721.1313,36.5386,267.9827},
{2652.9082,2702.1216,19.3222,358.8735},
{2631.4331,2718.9329,25.8222,357.2603},
{2668.6575,2742.3167,10.8203,88.4875},
{2619.5764,2690.0969,10.8203,90.0543},
{2585.5068,2720.8059,12.8249,184.3452},
{2647.9392,2730.0769,10.8203,314.3797},
{2668.2075,2756.6853,10.8203,89.1143},
{2670.7139,2747.7412,10.8203,82.5342},
{2669.5078,2765.5908,10.8203,90.9708},
{2636.1218,2801.0378,10.8203,91.5506},
{2599.2458,2799.7822,10.8203,272.9723},
{2667.5557,2791.9995,10.8203,89.6706},
{2672.2437,2774.3911,10.8203,53.0337},
{2511.1289,2850.1997,14.8222,182.7547},
{2504.4229,2843.5659,10.8203,269.2356},
{2503.2739,2807.7886,14.8222,269.8389},
{2502.2551,2787.5139,10.8203,266.3921},
{2605.2432,2717.0891,25.8222,1.3101},
{2625.4578,2821.3157,10.8203,188.0815},
{2615.3225,2848.9077,10.8203,176.1981},
{2626.5403,2839.7957,10.8203,84.9705},
{2592.0403,2848.9517,10.8203,180.2480},
{2605.5596,2806.3218,10.8203,5.4298},
{2586.8479,2849.1650,10.8203,165.1845},
{2559.2275,2845.7656,10.8203,176.1513},
{2588.8110,2800.9763,10.8203,91.5504},
{2543.5283,2806.1743,10.8203,270.7788},
{2573.9880,2807.5754,10.8203,0.3930},
{2501.6790,2823.7109,10.8203,264.3670},
{2531.7720,2855.5098,10.8203,182.1281},
{2596.0439,2805.2261,10.8203,356.6563},
{2587.9111,2723.8335,10.9844,270.4420},
{2593.0474,2790.3704,10.8203,84.3437},
{2643.7407,2779.9990,23.8222,133.8273},
{2559.3926,2708.9524,12.8249,2.8996},
{2545.9009,2837.4092,10.8203,1.9363},
{2632.2483,2726.6716,23.8222,347.5227}
};
//Mini Activity
#define MinMiniPlayers 2
forward MiniCheck();
forward MiniCD();
forward MiniEnd(status);
forward TeleportToMini();
forward MiniUnFreeze();
new MiniCountFuc;
new Miniknoob;
new MiniCount;
new MiniOn;
new InMini[MAX_PLAYERS];
new MiniPlayers;
new MiniWinnerCheck;
new MiniWinner;
new MiniReward;
new MiniStarted;
//War Activity
new Float:WarSpawns[20][3] = {
{-1085.3271,1019.7804,1342.7926},
{-1132.9607,1028.6680,1345.7377},
{-1128.3600,1095.9415,1345.7709},
{-1098.6946,1098.4323,1341.1632},
{-1071.4646,1088.1956,1346.0206},
{-1039.4835,1100.4468,1343.1393},
{-1043.1943,1041.5938,1341.3516},
{-1020.2195,1051.2196,1345.9545},
{-973.8190,1060.5537,1345.6772},
{-973.6674,1027.6255,1345.0448},
{-974.3493,1089.1172,1344.9795},
{-1009.8291,1080.3978,1341.0828},
{-1019.2279,1071.8867,1347.4093},
{-1046.0696,1023.0779,1343.0669},
{-1072.4380,1031.8779,1342.9623},
{-1104.6825,1097.2749,1341.8513},
{-1129.6497,1019.8154,1345.6614},
{-1064.0248,1032.7473,1344.5297},
{-1054.4865,1058.6794,1341.3516},
{-1025.9915,1066.3752,1343.8276} };
#define MinWarPlayers 2
new WarWeapons[] = {27,26,25,30,31,32,33,29,28};
forward WarCheck();
forward WarCD();
forward WarEnd(status);
forward TeleportToWar();
forward WarUnFreeze();
new WarCountFuc;
new Warknoob;
new WarCount;
new WarOn;
new InWar[MAX_PLAYERS];
new WarPlayers;
new WarWinnerCheck;
new WarWinner;
new WarReward;
new WarStarted;
//Monster Activity
new Float:MonsterSpawns[20][3] = {
{-1357.0161,931.2582,1036.6643},
{-1343.6912,934.0681,1036.7025},
{-1330.5449,937.6356,1036.7488},
{-1316.8219,943.2984,1036.8187},
{-1332.9574,1054.4888,1038.6896},
{-1345.4888,1057.4803,1038.7576},
{-1358.0347,1060.0735,1038.7892},
{-1372.1941,1061.0094,1038.8458},
{-1522.8307,994.4011,1038.0225},
{-1518.8556,980.0945,1037.7429},
{-1510.2579,964.9072,1037.5181},
{-1497.1700,953.8842,1037.3064},
{-1286.4662,966.0399,1037.1390},
{-1280.0394,976.1766,1037.2983},
{-1276.6190,988.4240,1037.5009},
{-1275.5780,999.8536,1037.6750},
{-1438.1656,1060.5125,1038.9670},
{-1449.7637,1058.6412,1038.9576},
{-1462.7793,1055.4187,1038.9321},
{-1477.3243,1049.9865,1038.8765}
};
#define MinMonsterPlayers 2
forward MonsterCheck();
forward MonsterCD();
forward MonsterEnd(status);
forward TeleportToMonster();
forward MonsterUnFreeze();
new MonsterCountFuc;
new Monsterknoob;
new MonsterCount;
new MonsterOn;
new MonsterCar[MAX_PLAYERS];
new InMonster[MAX_PLAYERS];
new MonsterPlayers;
new MonsterWinnerCheck;
new MonsterWinner;
new MonsterReward;
new MonsterStarted;

//Boom Activity
new Float:BoomSpawns[47][3] = {
{-2731.1997,639.9362,66.0938},{-2731.0012,646.6679,66.0938},{-2730.6279,651.3655,66.0938},{-2730.3491,658.5228,66.0938},{-2729.7852,668.9708,66.0938},
{-2730.6526,678.1556,66.0938},{-2732.9092,688.2010,66.0938},{-2725.6624,689.4337,66.0938},{-2717.7927,683.7516,66.0938},{-2711.2971,673.3215,66.0938},
{-2680.3264,681.4426,66.0938},{-2684.9109,674.6225,66.0938},{-2691.8982,664.9766,66.0938},{-2698.4871,667.1775,66.0938},{-2705.3972,663.7802,66.0938},
{-2669.6951,685.5577,66.0938},{-2660.8220,684.3322,66.0938},{-2654.8040,680.4359,66.0938},{-2646.6228,684.9301,66.0938},{-2638.9631,687.7316,66.0938},
{-2630.4653,662.3051,66.0938},{-2627.6938,668.8162,66.0938},{-2629.6167,677.0067,66.0938},{-2628.5369,684.6174,66.0938},{-2633.5217,688.1223,66.0938},
{-2658.0984,645.0074,66.0938},{-2652.7036,648.4404,66.0938},{-2645.6445,652.9910,66.0938},{-2642.1921,657.3383,66.0938},{-2641.2915,662.4249,66.0938},
{-2642.3308,622.2553,66.0938},{-2647.8691,625.3318,66.0938},{-2648.6931,632.2518,66.0938},{-2654.9272,637.4998,66.0938},{-2659.4839,641.1058,66.0938},
{-2659.9011,603.7661,66.0938},{-2652.6958,606.9073,66.0938},{-2645.3416,607.2343,66.0938},{-2639.5632,609.4852,66.0938},{-2637.7483,616.9645,66.0938},
{-2686.3052,599.9067,66.0938},{-2685.3481,594.7262,66.0938},{-2677.7798,592.8014,66.0938},{-2669.2539,592.9364,66.0938},{-2661.5488,597.7986,66.0938},
{-2686.0981,615.9853,66.0938},{-2685.1807,608.4542,66.0938}};
#define MinBoomPlayers 2
forward BoomCheck();
forward BoomCD();
forward BoomEnd(status);
forward TeleportToBoom();
forward BoomUnFreeze();
forward BoomExp();
new BoomCountFuc;
new BoomEx;
new Boomknoob;
new BoomCount;
new BoomOn;
new InBoom[MAX_PLAYERS];
new BoomPlayers;
new BoomWinnerCheck;
new BoomWinner;
new BoomReward;
new BoomStarted;

//Wang================================
#define MAX_WANGEXPORTVEHICLES	20		// Maximum Wang Export vehicles
new wantedWangExportVehicle;			// Wanted Wang Export vehicle model id
new wantedWangExportVehicles[MAX_WANGEXPORTVEHICLES] =
{				// Wanted Wang Exports modelid's
411,451,541,522,463,468,471,539,510,
402,437,597,565,588,485,470,595,409,560,
412

};
new wantedWangExportVehicleNames[MAX_WANGEXPORTVEHICLES][32] =
{		// Wanted Wang Exports vehicle names (match modelid's)
"Infernus","Turismo","Bullet","NRG-500","FreeWay","Sanchez","Quad","Vortex","Mountain Bike",
"Buffalo","Coach","Police Car(SF)","Flash","Hotdog","Baggage","Patriot","Sandking","Stretch","Sultan",
"Voodoo"

};
new CP_Wang;
forward SellWangExportVehicle(playerid);
forward TimeUpdate();
new Sell[MAX_PLAYERS]; //Wang Exports
new Wangcar[256];
//==================================================
new bool:active = false;
new Float:RandSpawn[] [] = {
{-2564.538,1092.589,55.664,337.096},
{-2356.0573,995.4032,50.8984,182.0485},
{-1382.105224,-230.142044,14.148437,313.913299},
{-2396.605468,-617.606628,132.737396,36.312511},
{1867.630493,-1442.807006,13.540561,317.000457},
{-2128.956298,925.477416,79.966804,93.446701},
{2192.915283,1670.262939,12.367187,89.400100},
{366.690490,2557.363281,16.856082,181.276748},
{-2929.666992,453.267517,4.914062,270.580932},
{-2422.023437,286.051605,35.257869,71.032470},
{2495.416748,-1687.549682,13.516131,2.144218},
{-1508.722045,1019.904846,7.187500,179.759155},
{-1499.821166,715.792602,7.212387,89.336952},
{-1619.134155,681.706298,7.190120,89.963623},
{-1410.905273,456.152038,7.187500,1.245707},
{-2408.289794,-2175.717285,33.289062,270.799926},
{-1631.521606,-2239.001220,31.476562,91.180885},
{-90.911148,-1159.593139,2.067930,58.911594},
{-2246.060791,2284.073486,4.970916,359.469268},
{-2543.482177,1216.352905,37.421875,3.426709},
{-2650.885742,1361.723266,12.250000,179.712753},
{-2841.463378,1301.068481,7.101562,181.569442},
{-2899.006591,1063.880126,32.132812,266.714843},
{-2758.178955,376.006683,4.333554,271.460571},
{-2654.040527,206.110565,4.335937,0.469989},
{-2026.803344,156.846771,29.039062,269.686340},
{-1969.536743,159.899826,27.687500,180.095474},
{-1959.827880,293.920349,35.468750,90.191314},
{-2039.647705,-81.948585,35.320312,1.408744},
{-1828.319213,108.475776,15.117187,264.632873},
{-1710.443725,399.048828,7.187244,225.592437},
{-1617.258666,1286.358520,7.184526,85.461174},
{-2063.862304,1381.531005,7.100666,180.327468},
{-2476.466308,1266.988769,28.159187,271.818572},
{-2280.303710,1022.978637,83.932350,271.810791},
{-2269.722900,535.506103,35.015625,268.893798},
{-2212.083251,307.103424,35.117187,179.338928},
{-2286.310546,150.778594,35.312500,270.636749},
{-2656.270263,-278.185577,7.495392,43.365280},
{-2721.727050,-317.288574,7.843750,45.895351},
{708.769714,1926.467773,5.582498,358.166961},
{-2540.925537,-596.941040,132.710937,268.919036},
{-1995.975708,-859.088928,32.171875,94.306816},
{-2136.151855,-388.964965,35.343013,359.299926},
{-1421.252319,-514.835449,14.177608,203.312210},
{-3102.738037,477.210845,35.113548,269.079071},
{-2483.815429,1069.525390,55.766624,355.448913},
{-2407.970703,722.858520,38.273437,91.772735},
{-2445.706054,516.771789,30.108627,271.580230},
{-2571.287597,556.769042,14.460937,359.057678},
{-1658.594116,1207.322875,7.250000,19.374435},
{-2660.122802,878.268493,79.773796,2.053548},
{-2300.773437,1100.437500,79.993370,93.170181},
{-2314.582031,1064.930664,65.585937,85.336761},
{-2572.343017,1156.694091,63.390625,159.725082},
{-2800.076416,1184.888183,20.273437,128.795059},
{-2090.675537,2314.161621,25.914062,116.540672},
{-2387.207519,2446.915283,10.169355,159.660369},
{-2062.444824,1095.738037,55.614360,178.901611},
{-1699.265380,1351.616210,7.179687,135.997940},
{-2018.340576,952.518920,45.802761,269.142486},
{-2304.288574,1544.356811,18.773437,90.848190},
{-2646.972,1400.710,24.765,198.280},
{}
};

//VEHICLES
new playername[MAX_PLAYER_NAME];
new String[265];
//==============================================================================
/*//---- �������� ----
new NRG500[1][0] = {{522}};
#define NrgPrice 1200000
new FCR600[1][0] = {{521}};
#define FCRPrice 450000
new BF400[1][0] = {{581}};
#define BFPrice 350000
new PCJ600[1][0] = {{461}};
#define PCJPrice 200000
new Freeway[1][0] = {{463}};
#define FWPrice 500000
new Sanchez[1][0] = {{468}};
#define SanPrice 250000
new Quad[1][0] = {{471}};
#define QuadPrice 100000
//---- ������� ----
new Bmx[1][0] = {{481}};
#define BmxPrice 40000
new MBike[1][0] = {{509}};
#define MBikePrice 65000
//---- ���� ��� ----
new BF[1][0] = {{424}};
#define BFFPrice 300000
new Band[1][0] = {{568}};
#define BandPrice 250000
new Barr[1][0] = {{433}};
#define BarrPrice 150000
//---- ���� ����� ----
new Sabre[1][0] = {{475}};
#define SabrePrice 500000*/
//==============================================================================
new Low[4][0] = {{427}, {490}, {407}, {544}};
new	VGood[15][0] = {{593}, {548}, {581}, {461}, {523}, {446}, {452}, {493}, {587}, {494}, {502}, {503}, {603}, {587}, {559}};
new Good1[3][0] = {{454}, {453}, {484}};
new Likely1[11][0] = {{602}, {541}, {506}, {477}, {513}, {487}, {563}, {460}, {521}, {463}, {586}};
new ALot1[2][0] = {{451}, {415}};
new Expensive1[8][0] = {{522}, {432}, {601}, {519}, {597}, {488}, {411}, {429}};
new VExpensive[2][0] = {{577}, {592}};
new VVexpensive[2][0] = {{425}, {520}};
new VCount,ModCount = 0,CreateCount = 0;
#define NormPrice 80000
#define LowPrice 150000
#define VeryGoodPrice 250000
#define GoodPrice 300000
#define Likely 400000
#define ALot 450000
#define Expensive 500000
#define VeryExpensive 1000000
#define VeryVeryExpensive 3000000
#define neondialog 8131
new VehNames[212][] =
{
"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster",
"Stretch","Manana","Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto",
"Taxi","Washington","Bobcat","Mr Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee",
"Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo",
"RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer",
"Turismo","Speeder","Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer",
"Pcj - 600","Faggio","Freeway","RC Baron","RC Raider","Glendale","Oceanic","Sanchez","Sparrow","Patriot",
"Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","Zr 350","Walton","Regina","Comet","Bmx",
"Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo",
"Greenwood","Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa",
"RC Goblin","Hotring Racer A","Hotring Racer B","Bloodring Banger","Rancher","Super GT","Elegant",
"Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain","Nebula","Majestic",
"Buccaneer","Shamal","Hydra","FCR-900","Nrg-500","Hpv-1000","Cement Truck","Tow Truck","Fortune","Cadrona",
"FBI Truck","Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight",
"Streak","Vortex","Vincent","Bullet","Clover","Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob",
"Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A","Monster B","Uranus",
"Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight",
"Trailer","Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford",
"BF-400","Newsvan","Tug","Trailer A","Emperor","Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C",
"Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)","Police Car (LVPD)","Police Ranger",
"Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};
enum VehInfo
{
CarID,
CarName[30],
CarModel,
CarOwned,
CarOwner[MAX_PLAYER_NAME],
CarLocked,
Buyable,
Price,
Nitro,
Neon,
Disco,
Hyd,
Wheels,
WheelsOn,
carname1,
Colour1,
Colour2

};

enum VReplace{
Inviter,
IDInviter,
IDInviter1,
Money,
Invite};
new Float:Pos[MAX_PLAYERS][4];
new tCount[MAX_VEHICLES];
new VehicleInfo[MAX_VEHICLES][VehInfo];
new Text3D:CarMsg[MAX_VEHICLES];
new HaveReplace[MAX_PLAYERS][VReplace];
forward UpdateCar(vehicleid);
forward PayCarTax();
//======================
new IsKick[MAX_PLAYERS];
new ClanInvite[MAX_PLAYERS];
new ClanInviteName[MAX_PLAYERS][256];
//TDM==================================================

#define TeamA 1572
#define TeamB 4872
new bool:CantUseTDM;
new Text:CopsPoints;
new teamaplayers;
new teambplayers;
forward TDM12();
forward CloseTdm();
new Text:GangPoints;
new InTDM[MAX_PLAYERS];
new InTeamA[MAX_PLAYERS];
new InTeamB[MAX_PLAYERS];
new TDMCopsSkin[] = {280,281,282,285,286};
new TDMGangSkin[] = {102,104,106,107,116};
new Float:TDMCopsSpawn[][3] =
{
{4108.4600,-23.5896,634.7368},
{4107.9331,-27.2884,634.7368},
{4107.5024,-31.9361,634.7368},
{4107.6689,-36.6615,634.7368},
{4107.8286,-41.1726,634.7368},
{4108.0200,-46.5982,634.7368},
{4108.1606,-50.5715,634.7368},
{4108.2563,-53.2903,634.7368},
{4110.8984,-53.5554,634.7368},
{4111.6475,-50.4254,634.7368},
{4111.4302,-47.1298,634.7368},
{4111.2056,-43.7199,634.7368},
{4110.9619,-40.0287,634.7368},
{4110.6821,-35.8082,634.7368},
{4110.4849,-32.8006,634.7368},
{4110.2979,-29.9449,634.7368},
{4110.1387,-27.5153,634.7368},
{4109.9082,-24.0077,634.7368},
{4109.7290,-21.2799,634.7368},
{4119.5317,-35.6180,634.7368}
};
new Float:TDMGangSpawn[][3] =
{
{3935.7092,-40.3158,634.7323},
{3936.4260,-37.6804,634.7323},
{3937.1318,-34.3190,634.7323},
{3938.8218,-33.0605,634.7323},
{3936.6160,-32.6321,634.7323},
{3933.3918,-33.0522,634.7323},
{3933.3496,-34.5562,634.7323},
{3933.3420,-37.5070,634.7323},
{3933.3337,-40.4217,634.7323},
{3929.9890,-41.3457,634.7323},
{3928.2832,-41.0122,634.7323},
{3926.8118,-41.0035,634.7323},
{3924.3286,-40.8087,634.7323},
{3921.2317,-40.5658,634.7323},
{3920.8499,-37.1482,634.7323},
{3920.7671,-33.2960,634.7323},
{3922.2825,-32.9921,634.7323},
{3924.1086,-33.0005,634.7323},
{3924.2549,-34.4057,634.7323},
{3925.9165,-34.9036,634.7323}
};

new RC[MAX_PLAYERS];
//Colors
#define green	0x16EB43FF
#define green2	0x008D00AA
#define green3	0x006400AA
#define blue	0x005EECAA
#define cblue	0x6495EDAA
#define red		0xFF0000AA
#define Red		0xFF0000AA
#define orange	0xFF9900AA
#define lblue	0x00FFFFAA
#define yellow	0xFFFF00AA
#define green	0x16EB43FF
#define green2	0x008D00AA
#define green3	0x006400AA
#define lgreen	0x2CCC99FF
#define red		0xFF0000AA
#define darkred	0x800000FF
#define white	0xFFFFFFAA
#define blue	0x005EECAA
#define pink	0xCCFF00FFAA
#define purple	0x8B00A0FF
#define grey	0xC0C0C0AA
#define ppmsc	0xA448FFFF
#define COLOR_RRPINK 0xFF66FFAA
#define COLOR_RRBLUE 0x7CFC00AA
#define COLOR_LIGHTBLUEGREEN 0x0FFDD349
#define BLD 0x46BBAA00
#define COLOR_BLUE2 0x0B6F6FF
#define RED 0xFF0000AA
#define WHITE 0xFFFFFFAA
#define YELLOW 0xFFFF00AA
#define ORANGE 0xFF9900AA
#define LIGHTBLUE 0x33CCFFAA
#define LIGHTGREENS 0x0F66AFF
//Defines
#define SpawnMoney 500
#define Dialog_Weapons 1155
#define Dialog_Weapons2 1154
//============Weapons==============
#define GolfP 300
#define BaseBallP 300
#define KnifeP 500
#define SawP 2600
#define PistolP 3400
#define SPistolP 3300
#define EagleP 3600
#define ShoutGunP 1100
#define CombatP 1600
#define SawnP 5500
#define MP5P 1900
#define UziP 1300
#define Tec9P 1500
#define M4P 4600
#define AK47P 4100
#define CountryP 2300
#define SniperP 6200
//============Weapons2==============
#define PistolA 50
#define SPistolA 60
#define EagleA 30
#define ShoutGunA 70
#define CombatA 70
#define SawnA 100
#define MP5A 300
#define UziA 400
#define Tec9A 400
#define M4A 200
#define AK47A 200
#define CountryA 30
#define SniperA 20
//=======================================
//==============ammu + bank===============
new CP_Ammu;
new CP_CBank;
new BankEnter;
new BankExit;
//==============================================================================
new InCall[MAX_PLAYERS];
new IsDead[MAX_PLAYERS];
new Tallking[MAX_PLAYERS];
new TallkingID[MAX_PLAYERS];
new IsCalling[MAX_PLAYERS];
new EndTimer[MAX_PLAYERS];
//==============================================================================
public OnGameModeExit()
{
 DOF2_SaveFile();
  DOF2_Exit();
    return 1;
}
//==============================================================================
public OnGameModeInit()
{
new d,m,y; getdate(y,m,d);
format(SString,sizeof(SString),"%d/%d/%d",d,m,y);
DOF2_SetString(ServerStats(),"UpTime",SString);
SendRconCommand("hostname "ServerName"");
SendRconCommand("rcon_password "RconPass"");
SetGameModeText(ModeName);
SendRconCommand("weburl "Weburl"");
SendRconCommand("mapname "ModeMap"");
print("Version: "Version"");
//======================================
/*SetTimer("settimeLogoEx",1000,true);
TextDrawBackgroundColor(Logo, 255);
TextDrawFont(Logo, 2);
TextDrawLetterSize(Logo, 0.349999, 1.700000);
TextDrawColor(Logo,0xffffffff);
TextDrawSetOutline(Logo, 1);
TextDrawSetProportional(Logo, 1);
TextDrawSetSelectable(Logo, 1);*/
//======================================
ConnectNPC("[Bot]Weapons","Weapons");
SendRconCommand("reloadbans");
SendRconCommand("loadfs Objects");
//======================================
if(!DOF2_FileExists(ServerStats()))
{
    DOF2_CreateFile(ServerStats());
    DOF2_SetInt(ServerStats(),"Users",10000);
    DOF2_SetInt(ServerStats(),"Clans",0);
    DOF2_SetInt(ServerStats(),"Banned",0);
}
    UserID = DOF2_GetInt(ServerStats(),"Users");
    Clanss = DOF2_GetInt(ServerStats(),"Clans");
    Banned = DOF2_GetInt(ServerStats(),"Banned");
//======================================
Honor = GangZoneCreate(1876.9946,642.8045, 1977.1577,762.8664);
Vip = GangZoneCreate(1072.8423,-1416.3911,1186.4501,-1562.4573);
//=====================================
txtTimeDisp = TextDrawCreate(605.0,25.0,"00:00");
TextDrawUseBox(txtTimeDisp, 0);
TextDrawFont(txtTimeDisp, 3);
TextDrawSetShadow(txtTimeDisp,0); // no shadow
TextDrawSetOutline(txtTimeDisp,2); // thickness 1
TextDrawBackgroundColor(txtTimeDisp,0x000000FF);
TextDrawColor(txtTimeDisp,0xFFFFFFFF);
TextDrawAlignment(txtTimeDisp,3);
TextDrawLetterSize(txtTimeDisp,0.5,1.5);
UpdateTimeAndWeather();
SetTimer("UpdateTimeAndWeather",1000*30,1);
//=====================================
gText = TextDrawCreate(4.000000, 432.000000, " DeathMatch V1.1");
TextDrawBackgroundColor(gText, -1);
TextDrawFont(gText, 1);
TextDrawLetterSize(gText, 0.440000, 1.500000);
TextDrawColor(gText, 255);
TextDrawSetOutline(gText, 0);
TextDrawSetProportional(gText, 1);
TextDrawSetShadow(gText, 0);
TextDrawSetSelectable(gText, 0);
//=====================================
new Days,Months,Years;
getdate(Years, Months, Days);
format(SString,sizeof(SString),"%d/%d/%d",Days,Months,Years);
Textdraw0 = TextDrawCreate(632.000000, 436.000000, SString);
TextDrawAlignment(Textdraw0, 3);
TextDrawBackgroundColor(Textdraw0, 255);
TextDrawFont(Textdraw0, 1);
TextDrawLetterSize(Textdraw0, 0.310000, 1.200000);
TextDrawColor(Textdraw0, 16711935);
TextDrawSetOutline(Textdraw0, 1);
TextDrawSetProportional(Textdraw0, 0);
TextDrawSetSelectable(Textdraw0, 0);
//=====================================
CP_MoneyMission = CPS_AddCheckpoint(-1621.4843,668.1238,-4.9063,2.5,100),MoneyMissionPickup = CreatePickup(1550 , 2, -2667.6865,732.2017,27.9531, 0);
StuntMissionDo = 0,CP_StuntStart = CPS_AddCheckpoint(1926.1753,-1414.1008,13.5703,2.0,100);
CantUseTDM=true;
//timers
SetTimer("MoneyShip", MONEYSHIPTIME*1000, true);
SetTimer("CarGodMod", 1000, 1);
SetTimer("WhatIsNowTime",60*1000, 1);
SetTimer("SendMSG",2*60*1000,1);
SetTimer("Active", 500, 1);
SetTimer("CheckP",500,1);
SetTimer("LoadFiles",4000,0);
TimeUpdate();
SetTimer("TimeUpdate",10*60*1000, 1);
WhatIsNowTime();
UsePlayerPedAnims();
EnableStuntBonusForAll(false);
SetWeather(2);
for(new i = 0; i < 299; i++) AddPlayerClass(i, 2043.7101,820.3539,7.1846, 269.1425, 0, 0, 0, 0, 0, 0);
//TDM
DOF2_CreateFile("TeamAS.txt");
DOF2_CreateFile("TeamBS.txt");
DOF2_SetInt("TeamAS.txt", "Score",0000);
DOF2_SetInt("TeamBS.txt", "Score",0000);

format(str, sizeof(str), "Cops:%d", DOF2_GetInt("TeamAS.txt", "Score"));
CopsPoints = TextDrawCreate(458, 415, str);

new str2[256];
format(str2, sizeof(str2), "Gang:%d", DOF2_GetInt("TeamBS.txt", "Score"));
GangPoints = TextDrawCreate(458, 401, str2);

SetTimer("TDM12",10,1);
TextDrawAlignment(CopsPoints, 1);
TextDrawFont(CopsPoints, 3);
TextDrawLetterSize(CopsPoints, 0.75, 1.75);
TextDrawColor(CopsPoints, 0x00008BFF);
TextDrawSetShadow(CopsPoints, 1);
TextDrawSetShadow(CopsPoints,1);
TextDrawSetOutline(CopsPoints,1);

TextDrawAlignment(GangPoints, 1);
TextDrawFont(GangPoints, 3);
TextDrawLetterSize(GangPoints, 0.75, 1.75);
TextDrawColor(GangPoints, 0xFF0000FF);
TextDrawSetShadow(GangPoints,1);
TextDrawSetOutline(GangPoints,1);
//==================================Hq==========================================
// JaS Obejct
JaSOpenMain1 = CreateObject(971,2517.29980469,1827.50000000,13.50000000,0.00000000,0.00000000,89.49462891); //Object(subwaygate) (1)
JaSOpenMain2 = CreateObject(971,2517.30004883,1818.69995117,13.50000000,0.00000000,0.00000000,270.49465942); //Object(subwaygate) (3)
JaSOpen2 = CreateObject(972,2586.89990234,1691.59997559,8.10000038,0.00000000,0.00000000,0.00000000); //Object(tunnelentrance) (1)
AddStaticPickup(1242,2,2565.482177,1700.889648,10.820312);
AddStaticPickup(1240,2,2565.631835,1704.023071,10.820312);
AddStaticPickup(338,2,2574.427246,1682.674682,10.820312);
AddStaticPickup(372,2,2578.475830,1703.081909,10.820312);
AddStaticPickup(356,2,2582.422851,1703.296142,10.820312);
Create3DTextLabel("JaS Clan HQ",COLOR_YELLOW,2517.8860,1823.0233,14.0811,50.0,0);
// Jas Object
//==================================Hq==========================================
CPS_AddCheckpoint(1926.2852,-1413.8141,13.5703,2.5,25);
//==============================================================================
AddStaticVehicle(451,-2593.4509,1126.7991,55.3572,241.7393,229,229); //
//==============================================================================
Hq(AddStaticVehicleEx(425,1887.09997559,750.50000000,20.20000076,180.00000000,-1,-1,15)); //Hunter
Hq(AddStaticVehicleEx(469,1905.50000000,751.40002441,19.39999962,180.00000000,3,1,15)); //Sparrow
Hq(AddStaticVehicleEx(417,1929.30004883,751.20001221,19.50000000,178.00000000,-1,-1,15)); //Leviathan
Hq(AddStaticVehicleEx(487,1948.69995117,749.00000000,19.60000038,179.99963379,6,1,15)); //Maverick
Hq(AddStaticVehicleEx(451,1941.90002441,708.70001221,10.60000038,0.00000000,6,1,15)); //Turismo
Hq(AddStaticVehicleEx(451,1939.00000000,708.70001221,10.60000038,0.00000000,-1,1,15)); //Turismo
Hq(AddStaticVehicleEx(560,1935.59997559,708.59997559,10.60000038,0.00000000,6,1,15)); //Sultan
Hq(AddStaticVehicleEx(560,1932.40002441,708.59997559,10.60000038,0.00000000,-1,1,15)); //Sultan
Hq(AddStaticVehicleEx(541,1929.09997559,708.59997559,10.50000000,0.00000000,6,-1,15)); //Bullet
Hq(AddStaticVehicleEx(541,1926.00000000,708.59997559,10.50000000,0.00000000,-1,6,15)); //Bullet
Hq(AddStaticVehicleEx(411,1922.69995117,708.90002441,10.60000038,0.00000000,6,1,15)); //Infernus
Hq(AddStaticVehicleEx(411,1919.59997559,708.90002441,10.60000038,0.00000000,-1,1,15)); //Infernus
Hq(AddStaticVehicleEx(506,1916.19995117,708.90002441,10.60000038,0.00000000,6,1,15)); //Super GT
Hq(AddStaticVehicleEx(506,1913.19995117,708.79998779,10.60000038,0.00000000,-1,1,15)); //Super GT
Hq(AddStaticVehicleEx(402,1942.00000000,698.00000000,10.80000019,180.00000000,-1,1,15)); //Buffalo
Hq(AddStaticVehicleEx(402,1938.69995117,697.90002441,10.80000019,180.00000000,6,1,15)); //Buffalo
Hq(AddStaticVehicleEx(415,1935.59997559,698.29998779,10.69999981,180.00000000,-1,1,15)); //Cheetah
Hq(AddStaticVehicleEx(415,1932.30004883,698.40002441,10.69999981,180.00000000,6,1,15)); //Cheetah
Hq(AddStaticVehicleEx(429,1929.09997559,698.40002441,10.50000000,177.99963379,-1,6,15)); //Banshee
Hq(AddStaticVehicleEx(429,1926.30004883,698.50000000,10.60000038,177.99499512,6,-1,15)); //Banshee
Hq(AddStaticVehicleEx(480,1922.80004883,698.50000000,10.60000038,177.99963379,-1,6,15)); //Comet
Hq(AddStaticVehicleEx(480,1919.59997559,698.29998779,10.69999981,177.99499512,6,-1,15)); //Comet
Hq(AddStaticVehicleEx(565,1916.30004883,698.29998779,10.50000000,180.00000000,-1,1,15)); //Flash
Hq(AddStaticVehicleEx(565,1913.30004883,698.29998779,10.50000000,180.00000000,6,1,15)); //Flash
//==============================================================================
AddStaticVehicle(437,1388.9032,1665.0558,10.9536,180.3909,402,0); //MagicBus
//==================================Dm Area=====================================
CP_Ammu = CPS_AddCheckpoint(850.6033,-2110.0813,8.2473,2.0,25);
CP_Wang = CPS_AddCheckpoint(-1920.6711,303.1555,41.0469,3.0,100);
//Bank
Create3DTextLabel("Bank",0xFF000080,-1953.7374,1344.8314,7.1875,40.0,0);
BankCP = CPS_AddCheckpoint(2144.2175,1639.7628,993.5761,2.0,25);
CP_CBank = CPS_AddCheckpoint(-28.1746,-89.1984,1003.5469,2.0,25);
BankEnter = CreatePickup(1559,21,-1953.7374,1344.8314,7.1875);
BankExit = CreatePickup(1559,21,2144.3083,1627.5544,993.6882);
//=============
Create3DTextLabel("Bank",0xFF0000FF,2144.2175,1639.7628,993.5761,20.0,0);
Create3DTextLabel("����� ������",0xFF0000FF,1926.1753,-1414.1008,13.5703,20.0,0);
Create3DTextLabel("���� �����",0xFF0000FF,-1920.7850,303.0250,41.0469,20.0,0);
//=============
ArmourSur = CreateDynamicPickup(1242,2,1437.7280,2647.8408,11.3926,55,-1,-1,100.0);
HpSur = CreateDynamicPickup(1240,2,1437.7369,2645.9055,11.3926,55,-1,-1,100.0);
CreateVehicle(522,1971.8605,-1428.8035,13.1356,79.3676,-1,-1, 10);//StuntMissions
//=====================================Tower====================================
AddStaticVehicle(522,1538.2095,-1364.9811,329.0168,0.6456,151,0); // NRG-500
AddStaticVehicle(481,1552.1090,-1365.5723,328.9769,359.5831,126,126); // BMX
//====================================Near Wang=================================
AddStaticVehicle(514,-1850.7347,162.6599,15.6092,260.8360,3,83); //
AddStaticVehicle(514,-1850.5103,169.7438,15.6102,265.5587,93,93); //
AddStaticVehicle(522,-1707.2539,66.3844,6.2523,136.0109,0,184); // NRG-500
AddStaticVehicle(554,-1707.1772,11.9813,3.5583,315.5552,15,32); //
AddStaticVehicle(429,-1689.6919,-104.5055,3.2793,224.4527,54,7); // Banshee
AddStaticVehicle(461,-1814.0703,-196.6904,14.0607,273.1516,244,244); //
//======================================Lv======================================
AddStaticVehicle(527,2673.0176,1971.2750,10.5360,91.6090,0,63); //
AddStaticVehicle(480,2672.2412,1974.5364,10.6130,269.6988,6,6); //
AddStaticVehicle(529,2673.0818,1977.9902,10.4205,268.2712,0,0); //
AddStaticVehicle(602,2672.1006,1980.9915,10.5651,89.4698,147,154); //
AddStaticVehicle(517,2673.0195,1984.3584,10.6900,269.0464,36,36); //
AddStaticVehicle(507,2672.5820,1987.6652,10.6262,90.2098,97,2); //
AddStaticVehicle(426,2672.8223,1991.1388,10.5939,269.3303,53,53); //
AddStaticVehicle(489,2672.0352,1994.4153,10.9107,268.7123,3,3); //
AddStaticVehicle(429,2671.9292,1997.5526,10.5494,91.1774,2,3); //
AddStaticVehicle(602,2671.9673,2001.1017,10.6499,270.2253,105,105); //
AddStaticVehicle(527,2646.5864,2008.3057,10.5726,179.7786,3,3); //
AddStaticVehicle(535,2643.3015,2009.4792,10.5912,0.0798,0,0); //
AddStaticVehicle(467,2639.9717,2008.2639,10.5852,180.0122,3,0); //
AddStaticVehicle(458,2636.5808,2009.9235,10.7305,0.2474,0,0); //
AddStaticVehicle(529,2633.3425,2009.0535,10.4744,359.5605,0,0); //
AddStaticVehicle(521,2630.1167,2009.6025,10.3825,180.3511,0,0); //
AddStaticVehicle(489,2623.0955,2009.3579,10.8964,358.3258,3,0); //
AddStaticVehicle(462,2619.7046,2010.1379,10.4093,359.6400,6,84); //
AddStaticVehicle(405,2626.9111,1989.6689,10.7272,0.7263,0,0); //
AddStaticVehicle(463,2630.2087,1988.6847,10.3596,178.2058,0,3); //
AddStaticVehicle(463,2633.9270,1988.6829,10.3591,178.3053,0,0); //
AddStaticVehicle(463,2636.9697,1988.6461,10.3536,179.3263,6,79); //
AddStaticVehicle(445,2643.5505,1988.8431,10.6333,0.5011,37,37); //
AddStaticVehicle(517,2646.7356,1988.4459,10.6111,1.3936,0,1); //
AddStaticVehicle(436,2650.1768,1988.3108,10.6063,179.3802,92,1); //
AddStaticVehicle(507,2653.6377,1988.1141,10.6674,359.5599,0,0); //
AddStaticVehicle(424,2657.0352,1987.0638,10.5817,359.8854,1,40); //
AddStaticVehicle(609,2605.1565,2017.8617,11.1101,0.0625,0,0); //
AddStaticVehicle(445,2607.6226,2041.8523,10.7074,90.6331,0,0); //
AddStaticVehicle(471,2607.6108,2045.1465,10.2541,268.5261,103,111); //
AddStaticVehicle(405,2606.3088,2048.2654,10.6326,89.5778,1,1); //
AddStaticVehicle(482,2606.9402,2051.7097,10.9747,270.2980,48,48); //
AddStaticVehicle(426,2607.1565,2055.1309,10.5818,269.5740,62,62); //
AddStaticVehicle(467,2607.2319,2058.3645,10.4798,88.8832,0,6); //
AddStaticVehicle(462,2606.8528,2065.4722,10.4113,269.2903,0,0); //
AddStaticVehicle(424,2607.4160,2068.5635,10.5772,269.8488,6,6); //
AddStaticVehicle(436,2606.0603,2072.2517,10.6078,91.9295,95,1); //
AddStaticVehicle(603,2502.9556,2129.2937,10.5585,270.3420,0,1); //
AddStaticVehicle(477,2506.7915,2157.3713,10.6114,270.0487,79,79); //
AddStaticVehicle(481,2541.7739,2175.1091,10.3355,87.5716,6,6); //
AddStaticVehicle(577,1477.3655,1811.1654,10.7151,179.1586,8,10); //
AddStaticVehicle(602,2613.4761,1431.0765,10.5641,90.0828,69,69); //
AddStaticVehicle(521,2692.4199,1307.5474,7.8290,176.6473,0,0); //
AddStaticVehicle(602,2493.5042,1232.1210,10.6437,94.1922,0,0); //
AddStaticVehicle(581,2637.0176,1065.6714,10.4165,90.8973,0,0); //
AddStaticVehicle(561,2481.7075,1043.5382,57.2775,90.0661,1,6); //
AddStaticVehicle(522,1579.1840,673.0911,10.3882,182.0682,0,6); //
AddStaticVehicle(522,1628.2437,578.0726,1.3175,0.1459,3,10); //
AddStaticVehicle(505,597.1192,876.9013,-42.9977,185.0234,1,0); //
AddStaticVehicle(468,638.2973,832.8057,-43.2948,87.0716,93,93); //
AddStaticVehicle(485,1640.25109863,1293.25427246,10.52031231,269.25000000,-1,-1); //Baggage
AddStaticVehicle(485,1640.24328613,1296.23083496,10.52031231,269.49755859,-1,-1); //Baggage
AddStaticVehicle(485,1640.25329590,1299.20678711,10.52031231,269.24755859,-1,-1); //Baggage
AddStaticVehicle(485,1640.19335938,1302.15698242,10.52031231,268.99755859,-1,-1); //Baggage
AddStaticVehicle(485,1640.11120605,1305.15368652,10.52031231,269.49755859,-1,-1); //Baggage
AddStaticVehicle(485,1640.12915039,1308.08239746,10.52031231,269.49755859,-1,-1); //Baggage
AddStaticVehicle(485,1640.13452148,1311.05981445,10.52031231,269.49755859,-1,-1); //Baggage
AddStaticVehicle(485,1640.15563965,1313.93872070,10.52031231,269.49755859,-1,-1); //Baggage
AddStaticVehicle(519,1378.35998535,1770.25463867,11.82038498,181.00000000,-1,-1); //Shamal
AddStaticVehicle(519,1398.80834961,1770.60192871,11.82038498,180.99975586,-1,-1); //Shamal
AddStaticVehicle(513,1332.70202637,1735.14501953,11.60506916,269.50000000,1,86); //Stunt
AddStaticVehicle(513,1278.66674805,1342.79138184,11.60506916,269.50000000,3,86); //Stunt
AddStaticVehicle(485,1306.26611328,1278.77893066,10.52031231,0.00000000,-1,-1); //Baggage
AddStaticVehicle(485,1309.45324707,1278.77697754,10.52031231,0.00000000,-1,-1); //Baggage
AddStaticVehicle(485,1312.70288086,1278.77148438,10.52031231,0.00000000,-1,-1); //Baggage
AddStaticVehicle(485,1315.87841797,1278.74414062,10.52031231,0.00000000,-1,-1); //Baggage
AddStaticVehicle(485,1319.10607910,1278.79003906,10.52031231,0.00000000,-1,-1); //Baggage
AddStaticVehicle(485,1322.34790039,1278.78662109,10.52031231,0.00000000,-1,-1); //Baggage
AddStaticVehicle(485,1325.44799805,1278.78247070,10.52031231,0.00000000,-1,-1); //Baggage
AddStaticVehicle(485,1328.75402832,1278.80017090,10.52031231,0.00000000,-1,-1); //Baggage
AddStaticVehicle(592,1569.27429199,1447.98632812,11.98416519,90.75000000,1,-1); //Andromada
AddStaticVehicle(416,1592.07763672,1818.18432617,11.11988831,0.00000000,1,3); //Ambulance
AddStaticVehicle(416,1624.03955078,1818.11206055,11.11988831,0.00000000,1,3); //Ambulance
AddStaticVehicle(487,2092.26000977,2414.85327148,74.84359741,269.75000000,1,6); //Maverick
AddStaticVehicle(560,2377.45214844,2171.12866211,26.71435165,130.25006104,79,1); //Sultan
AddStaticVehicle(560,2508.81079102,2169.05004883,26.71435165,208.49841309,79,1); //Sultan
AddStaticVehicle(522,2509.85571289,2225.72729492,18.64354706,90.50000000,3,2); //NRG-500
AddStaticVehicle(451,2327.13940430,1388.03479004,42.58468628,0.00000000,6,1); //Turismo
AddStaticVehicle(541,2262.96386719,1398.45874023,42.52031326,269.25000000,1,-1); //Bullet
AddStaticVehicle(522,2264.90991211,1388.60522461,49.42115784,0.00000000,65,2); //NRG-500
AddStaticVehicle(522,2350.10815430,1388.57373047,49.42115784,0.00000000,2,-1); //NRG-500
AddStaticVehicle(522,2350.31787109,1518.51037598,49.42115021,179.50000000,126,-1); //NRG-500
AddStaticVehicle(522,2265.01782227,1518.41967773,49.49614716,178.75000000,79,6); //NRG-500
AddStaticVehicle(451,2137.28295898,1504.16064453,30.86124802,179.24993896,86,1); //Turismo
AddStaticVehicle(451,2137.69653320,1460.14648438,30.86124802,0.24731445,86,1); //Turismo
AddStaticVehicle(411,-360.71243286,1199.44714355,19.52142525,179.24993896,65,1); //Infernus
AddStaticVehicle(553,1663.03222656,1556.82482910,13.03981113,93.50000000,-1,1); //Nevada
//===================================Ls=========================================
AddStaticVehicle(522,2516.6660,-1671.9407,13.4866,63.9721,0,7); //
AddStaticVehicle(411,2527.5513,-1669.6857,14.8091,89.3745,147,0); //
AddStaticVehicle(419,2472.9783,-1700.6132,13.1960,0.3687,0,3); //
AddStaticVehicle(522,2505.6978,-1692.4340,13.1146,1.8071,151,2); //
AddStaticVehicle(521,2174.0342,-1788.5273,13.0914,269.0193,5,0); //
AddStaticVehicle(575,2068.8977,-1694.4845,13.1278,269.3320,1,1); //
AddStaticVehicle(522,2044.7180,-1635.9973,13.1155,356.4927,165,79); //
PizzaCar[0] = Pizza(AddStaticVehicle(448,2102.2363,-1809.7272,13.1527,90.4164,3,6)); //
AddStaticVehicle(478,2017.5984,-1804.8386,13.4482,270.1967,25,25); //
AddStaticVehicle(451,2105.8306,-1938.6405,13.2811,315.4622,125,0); //
AddStaticVehicle(494,2129.9968,-1938.9563,13.4725,50.3441,42,33); //
AddStaticVehicle(456,2215.5967,-2052.2068,13.7617,224.8928,110,93); //
AddStaticVehicle(581,2096.1243,-2074.8921,13.1426,181.1404,130,14); //
AddStaticVehicle(521,1938.5950,-2086.4563,13.1306,271.1387,115,118); //
AddStaticVehicle(411,1837.9839,-1870.8937,13.1066,359.6526,0,0); //
AddStaticVehicle(461,1796.9521,-1867.2946,13.1585,3.6575,252,3); //
AddStaticVehicle(475,1623.4440,-1855.2567,13.3357,179.4737,0,0); //
AddStaticVehicle(522,1670.0338,-1716.1669,15.1809,85.2826,0,1); //
AddStaticVehicle(571,1673.5391,-1715.0151,19.7056,90.5157,2,35); //
AddStaticVehicle(571,1673.4607,-1709.8801,19.7419,85.3771,0,0); //
AddStaticVehicle(571,1673.6090,-1705.4031,19.7088,88.0818,44,44); //
AddStaticVehicle(436,1515.5078,-1727.5123,13.2543,91.3967,119,45); //
AddStaticVehicle(581,1503.9150,-1747.7957,13.1433,0.2165,3,3); //
AddStaticVehicle(517,1450.7434,-1738.5153,13.4214,271.2491,43,41); //
AddStaticVehicle(490,1534.6862,-1645.0416,5.9510,180.6167,93,6); //
AddStaticVehicle(603,1095.7900,-1706.5743,13.2145,90.0880,1,0); //
AddStaticVehicle(565,1062.1974,-1740.1959,13.1011,269.9197,6,6); //
AddStaticVehicle(581,1078.8896,-1746.5724,13.0425,3.8810,101,1); //
AddStaticVehicle(586,1086.2457,-1746.3973,12.9515,354.1376,122,1); //
AddStaticVehicle(562,1080.4458,-1757.8556,13.0701,269.4508,7,7); //
AddStaticVehicle(579,1081.6959,-1763.8125,13.1709,89.3344,0,0); //
AddStaticVehicle(560,1098.9390,-1775.6149,13.0725,89.9971,0,0); //
AddStaticVehicle(522,874.6099,-1658.9104,13.1078,178.2187,186,0); //
AddStaticVehicle(567,883.5812,-1658.6022,13.2817,181.2745,145,0); //
AddStaticVehicle(521,892.6594,-1657.7616,13.1181,179.9448,0,126); //
AddStaticVehicle(504,888.1857,-1669.2106,13.2281,358.6906,86,86); //
AddStaticVehicle(481,883.6207,-1669.3823,13.0611,1.8352,0,0); //
AddStaticVehicle(480,879.1403,-1669.3157,13.3340,1.5175,6,0); //
AddStaticVehicle(461,655.8163,-1655.4742,14.0897,91.4700,15,15); //
AddStaticVehicle(429,322.6314,-1765.4795,4.3115,178.5656,3,6); //
AddStaticVehicle(526,337.6037,-1788.6219,4.6365,180.8809,0,1); //
AddStaticVehicle(439,334.4227,-1788.5641,4.8248,0.1593,2,2); //
AddStaticVehicle(536,331.2997,-1788.2245,4.5911,358.4613,7,7); //
AddStaticVehicle(560,328.0169,-1788.0251,4.4809,179.3080,46,46); //
AddStaticVehicle(471,324.6040,-1788.2965,4.2741,2.1717,4,6); //
AddStaticVehicle(479,321.3165,-1788.8812,4.5424,359.1531,59,36); //
AddStaticVehicle(491,318.1228,-1788.7291,4.3511,0.4543,0,161); //
AddStaticVehicle(500,315.0320,-1788.2600,4.6681,179.2884,0,69); //
AddStaticVehicle(540,311.6095,-1788.6011,4.4951,0.0057,53,53); //
AddStaticVehicle(540,311.5736,-1809.9779,4.3737,183.2359,0,0); //
AddStaticVehicle(474,314.8169,-1809.2097,4.2512,0.2895,79,79); //
AddStaticVehicle(429,318.0439,-1810.1328,4.1829,0.1650,0,1); //
AddStaticVehicle(560,321.1923,-1809.9478,4.1938,0.6707,6,6); //
AddStaticVehicle(535,327.6945,-1810.0282,4.2446,181.1415,6,6); //
AddStaticVehicle(496,330.9081,-1808.8502,4.2429,181.7273,0,65); //
AddStaticVehicle(479,334.1794,-1809.5577,4.3025,359.7935,0,9); //
AddStaticVehicle(526,337.3784,-1809.9009,4.2878,1.7263,1,1); //
AddStaticVehicle(467,340.6978,-1809.5116,4.2742,359.9327,153,1); //
AddStaticVehicle(468,344.2080,-1810.3470,4.1588,180.5003,3,3); //
AddStaticVehicle(491,347.0967,-1809.6429,4.1897,180.8259,0,1); //
AddStaticVehicle(500,350.2749,-1809.3048,4.5615,179.9490,0,0); //
AddStaticVehicle(496,353.7310,-1809.9576,4.2585,1.1097,1,63); //
AddStaticVehicle(436,356.6816,-1809.5265,4.2288,359.6846,51,51); //
AddStaticVehicle(481,308.1567,-1822.6556,3.6205,173.4673,3,3); //
AddStaticVehicle(500,374.6177,-1885.3273,2.1573,268.5927,2,2); //
AddStaticVehicle(458,374.8698,-2033.4413,7.6497,0.2460,101,1); //
AddStaticVehicle(560,364.5312,-2027.2848,7.3932,0.7161,0,0); //
AddStaticVehicle(529,375.0634,-2022.6050,7.3312,0.2634,0,0); //
AddStaticVehicle(483,364.8516,-2012.3125,7.7842,0.0253,0,1); //
AddStaticVehicle(481,380.2262,-1892.2239,7.3479,90.5614,3,3); //
AddStaticVehicle(461,280.9572,-1768.5664,4.0992,177.7358,15,15); //
AddStaticVehicle(554,384.5170,-1485.8395,31.9774,127.4392,3,0); //
AddStaticVehicle(457,686.9509,-1222.4694,15.9482,119.9926,100,100); //
AddStaticVehicle(457,681.9224,-1225.5704,15.5781,119.5993,63,1); //
AddStaticVehicle(457,687.5590,-1234.3430,15.6546,117.2018,18,1); //
AddStaticVehicle(582,1145.0321,-928.3705,43.1284,183.2180,3,6); //
AddStaticVehicle(581,1280.5234,-1061.1135,29.1050,92.0223,111,111); //
AddStaticVehicle(581,1311.1648,-965.9725,148.2418,359.0469,79,3); //
AddStaticVehicle(468,1316.3634,-969.4241,146.4597,356.3076,0,0); //
AddStaticVehicle(521,1321.9238,-965.5552,148.2107,0.1331,1,1); //
AddStaticVehicle(407,1749.05700684,-1455.57116699,13.79187679,268.50000000,3,-1); //Firetruck
AddStaticVehicle(487,1728.62390137,-1461.81726074,33.28843689,268.75000000,3,-1); //Maverick
AddStaticVehicle(425,1497.92028809,-1568.79553223,68.06193542,180.00000000,-1,-1); //Hunter
AddStaticVehicle(596,1530.52075195,-1645.30627441,5.71062469,179.75000000,-1,1); //Police Car (LSPD)
AddStaticVehicle(596,1574.50952148,-1710.35900879,5.71062469,359.49731445,-1,1); //Police Car (LSPD)
AddStaticVehicle(596,1585.15588379,-1671.72045898,5.71062469,268.74462891,-1,1); //Police Car (LSPD)
AddStaticVehicle(599,1601.99682617,-1695.95336914,6.05075073,90.50000000,-1,-1); //Police Ranger
AddStaticVehicle(427,1595.51855469,-1710.42297363,6.13862514,0.00000000,-1,1); //Enforcer
AddStaticVehicle(523,1544.92956543,-1680.20654297,5.55100250,90.50000000,-1,-1); //HPV1000
AddStaticVehicle(523,1545.13818359,-1658.97119141,5.55100250,89.99987793,-1,-1); //HPV1000
AddStaticVehicle(522,1498.00646973,-1664.83996582,33.63224792,181.48901367,-1,-1); //NRG-500
AddStaticVehicle(541,2267.03344727,-1029.00732422,58.98486710,45.75000000,86,3); //Bullet
AddStaticVehicle(522,1987.35534668,-1115.03857422,35.21037292,179.00000000,-1,-1); //NRG-500
AddStaticVehicle(451,1678.80969238,-1460.30541992,13.31124687,269.50000000,126,1); //Turismo
AddStaticVehicle(443,1588.86535645,-1414.58129883,14.37189293,269.50000000,6,1); //Packer
AddStaticVehicle(416,1179.45751953,-1338.92724609,14.15720654,269.00000000,1,3); //Ambulance
AddStaticVehicle(487,1180.88000488,-1376.49047852,24.18880272,269.25000000,1,3); //Maverick
AddStaticVehicle(409,736.65527344,-1337.49206543,13.40987110,270.25000000,1,1); //Stretch
AddStaticVehicle(473,723.00799561,-1499.60986328,0.00000000,178.75000000,-1,-1); //Dinghy
AddStaticVehicle(425,573.14996338,-1373.81738281,53.28850174,191.00000000,-1,-1); //Hunter
AddStaticVehicle(522,542.05780029,-1297.90539551,32.20093918,0.00000000,126,-1); //NRG-500
AddStaticVehicle(451,1171.87145996,-1654.54626465,23.94872856,180.00000000,93,1); //Turismo
AddStaticVehicle(415,1650.61596680,-1079.99938965,23.74795914,89.50000000,86,1); //Cheetah
AddStaticVehicle(541,1650.77087402,-1102.58068848,23.60625076,89.00000000,1,65); //Bullet
AddStaticVehicle(559,1657.23339844,-1111.56201172,23.66031265,90.00000000,103,1); //Jester
AddStaticVehicle(560,1676.01391602,-1124.75085449,23.71122551,89.25000000,7,1); //Sultan
AddStaticVehicle(477,1676.58251953,-1106.84997559,23.75625038,90.00000000,65,1); //ZR-350
AddStaticVehicle(429,1657.43969727,-1136.53442383,23.65625000,0.00000000,1,-1); //Banshee
AddStaticVehicle(451,1695.76391602,-1069.29235840,23.67062187,0.00000000,-1,-1); //Turismo
AddStaticVehicle(411,1713.64794922,-1069.60437012,23.70624924,0.00000000,6,1); //Infernus
AddStaticVehicle(562,1712.58886719,-1006.52844238,23.66758728,172.75000000,3,1); //Elegy
AddStaticVehicle(533,1748.64440918,-1012.84918213,23.76093674,167.75000000,79,1); //Feltzer
AddStaticVehicle(534,1757.34509277,-1046.23107910,23.78381538,0.00000000,106,1); //Remington
AddStaticVehicle(567,1775.47131348,-1060.94372559,23.93927956,0.00000000,2,1); //Savanna
AddStaticVehicle(575,1788.88183594,-1070.27319336,23.70093727,180.00000000,108,1); //Broadway
AddStaticVehicle(542,1761.85766602,-1070.25061035,23.80433655,180.25000000,3,6); //Clover
AddStaticVehicle(412,1753.64819336,-1084.83496094,23.91093826,0.00000000,-1,-1); //Voodoo
AddStaticVehicle(549,1735.64990234,-1085.42944336,23.82241440,0.00000000,1,86); //Tampa
AddStaticVehicle(565,1798.81213379,-1085.63586426,23.65286827,0.00000000,44,1); //Flash
//==================================Race========================================
UnBuyAble(AddStaticVehicle(451,-2573.9131,1098.7020,55.3219,333.5837,-1,-1)); //
UnBuyAble(AddStaticVehicle(451,-2570.8674,1097.3384,55.3608,337.8633,-1,-1)); //
UnBuyAble(AddStaticVehicle(451,-2567.5996,1095.9580,55.3871,337.5224,-1,-1)); //
UnBuyAble(AddStaticVehicle(451,-2564.2163,1094.5239,55.3986,336.4937,-1,-1)); //
UnBuyAble(AddStaticVehicle(451,-2561.2961,1093.3438,55.3915,339.1119,-1,-1)); //
UnBuyAble(AddStaticVehicle(411,-2597.7627,1110.5394,55.3130,331.7933,-1,-1)); //
UnBuyAble(AddStaticVehicle(411,-2601.2410,1112.4441,55.3121,330.7758,-1,-1)); //
UnBuyAble(AddStaticVehicle(411,-2604.1416,1114.2126,55.2872,330.8163,-1,-1)); //
UnBuyAble(AddStaticVehicle(411,-2607.4775,1116.1013,55.3052,330.1451,-1,-1)); //
UnBuyAble(AddStaticVehicle(411,-2610.2664,1117.7063,55.3052,330.4449,-1,-11)); //
UnBuyAble(AddStaticVehicle(522,-2599.8835,1145.2300,55.1393,145.2196,8,82)); //
UnBuyAble(AddStaticVehicle(522,-2602.1062,1147.0060,55.1369,149.1831,36,105)); //
UnBuyAble(AddStaticVehicle(522,-2604.7600,1148.8412,55.1417,149.1478,39,106)); //
UnBuyAble(AddStaticVehicle(522,-2607.2708,1150.4386,55.1438,149.1827,51,118)); //
UnBuyAble(AddStaticVehicle(522,-2609.6553,1152.1394,55.1491,149.1831,3,3)); //
UnBuyAble(AddStaticVehicle(494,-2568.3936,1133.9634,55.5803,160.4193,92,101)); //
UnBuyAble(AddStaticVehicle(494,-2571.7446,1135.2205,55.5546,155.4106,75,79)); //
UnBuyAble(AddStaticVehicle(494,-2578.8413,1137.8748,55.5155,159.9922,42,33)); //
UnBuyAble(AddStaticVehicle(494,-2575.3047,1136.6743,55.5477,158.1151,54,36)); //
UnBuyAble(AddStaticVehicle(494,-2564.7092,1132.7183,55.6241,159.9945,98,109)); //
Remington = AddStaticVehicle(534,-2601.4041,1130.8190,55.3111,240.6856,-1,-1); //
ChangeVehiclePaintjob(Remington,2);
Special(AddStaticVehicle(522,-2564.8733,1114.3038,55.3915,72.2037,-1,-1)); //
Special(AddStaticVehicle(522,-2578.7737,1100.4091,55.1424,329.7576,-1,-1)); //
Special(AddStaticVehicle(522,-2592.9578,1108.8701,55.1202,308.9228,-1,-1)); //
AddStaticVehicle(541,-2556.8225,1144.6182,55.3602,163.3099,1,2); //
AddStaticVehicle(451,-2546.1912,1142.3156,55.3577,168.6496,0,0); //
AddStaticVehicle(411,-2541.8074,1142.0144,55.4471,169.9836,151,151); //
AddStaticVehicle(603,-2531.2092,1140.7799,55.4972,174.0673,13,0); //
AddStaticVehicle(415,-2514.0559,1139.0364,55.5151,176.0092,6,6); //
AddStaticVehicle(402,-2499.5107,1138.8870,55.4899,0.2022,30,30); //
AddStaticVehicle(560,-2465.2766,1139.0151,55.4500,180.7813,3,3); //
AddStaticVehicle(439,-2444.4985,1138.7941,55.6469,176.1807,57,8); //
AddStaticVehicle(477,-2363.6558,1116.7059,55.5185,157.0549,92,1); //
AddStaticVehicle(535,-2457.7190,1069.7610,55.5542,359.7596,0,0); //
AddStaticVehicle(477,-2465.3904,1070.1888,55.5772,356.1669,74,74); //
AddStaticVehicle(579,-2472.9272,1069.9729,55.7144,358.6719,79,0); //
AddStaticVehicle(411,-2480.5098,1069.9713,55.4461,0.1910,2,2); //
AddStaticVehicle(522,-2470.2261,1060.6570,60.1484,359.3331,79,3); //
AddStaticVehicle(522,-2498.6724,1004.2665,77.9175,176.3154,0,146); //
AddStaticVehicle(522,-2569.5640,988.6837,77.8324,357.1535,93,0); //
AddStaticVehicle(522,-2539.6692,987.9591,77.8600,271.5240,-1,-1); //
AddStaticVehicle(522,-2562.7036,822.0730,49.5512,180.2180,0,79); //
AddStaticVehicle(539,-2513.2720,1209.5614,36.7819,267.0948,75,75); //
AddStaticVehicle(560,-2491.4636,1214.4020,37.0619,141.9498,151,151); //
AddStaticVehicle(560,-2494.6184,1217.1012,37.1104,142.6800,6,6); //
AddStaticVehicle(560,-2498.0356,1219.8402,37.0738,143.5081,165,165); //
AddStaticVehicle(560,-2501.4063,1222.5923,37.0672,143.2545,6,6); //
AddStaticVehicle(562,-2517.3596,1229.5659,37.0619,211.0483,7,7); //
AddStaticVehicle(480,-2521.2861,1228.9810,37.2145,209.5977,3,3); //
AddStaticVehicle(461,-2526.0115,1229.1895,37.0004,210.1417,6,6); //
AddStaticVehicle(461,-2530.0476,1229.2537,37.0098,206.3344,184,184); //
AddStaticVehicle(461,-2535.0049,1229.8575,37.0055,213.4842,45,45); //
AddStaticVehicle(506,-2538.7996,1228.9198,37.0900,212.2744,3,3); //
AddStaticVehicle(411,-2620.7822,1341.0933,6.9735,45.2363,0,0); //
AddStaticVehicle(411,-2624.6238,1337.3324,6.9727,45.3653,6,6); //
AddStaticVehicle(581,-2627.9421,1333.6160,6.7861,29.4656,66,1); //
AddStaticVehicle(581,-2632.2446,1332.2201,6.7915,2.5819,0,0); //
AddStaticVehicle(402,-2637.0344,1333.1409,6.9630,1.7658,10,10); //
AddStaticVehicle(451,-2642.8142,1333.0863,6.9154,358.6958,6,6); //
AddStaticVehicle(477,-2647.0684,1333.1743,6.9492,0.1858,0,0); //
AddStaticVehicle(409,-2644.1008,1379.0925,6.8553,270.9055,0,0); //
AddStaticVehicle(587,-2618.4778,1379.1970,6.8036,269.8230,36,1); //
AddStaticVehicle(468,-2707.5505,1357.1395,6.7423,140.2712,46,46); //
AddStaticVehicle(559,-2658.7048,1184.3704,55.2956,213.5207,1,1); //
AddStaticVehicle(411,-2671.6060,1210.1891,55.3837,19.2380,0,0); //
AddStaticVehicle(522,-2676.6587,1274.9224,60.7736,94.3914,0,6); //
AddStaticVehicle(411,-2339.3882,1043.3225,55.4039,1.3433,112,1); //
AddStaticVehicle(451,-2343.7559,1023.8945,55.6057,0.1846,-1,-1); //
AddStaticVehicle(543,-2647.1431,817.3772,49.6202,266.2509,0,0); //
AddStaticVehicle(555,-2667.2056,805.3467,49.6407,177.9348,6,6); //
AddStaticVehicle(541,-2672.0947,823.4990,49.5347,177.6651,0,0); //
AddStaticVehicle(533,-2694.6772,805.4572,49.6428,0.1191,74,1); //
AddStaticVehicle(506,-2696.1563,825.0488,49.6591,180.0281,7,7); //
AddStaticVehicle(522,-2740.0530,833.0432,55.3287,90.1378,36,105); //
AddStaticVehicle(414,-2785.8618,769.5034,50.5581,270.3277,28,1); //
AddStaticVehicle(506,-2745.2551,769.6832,53.9695,0.4610,6,6); //
AddStaticVehicle(417,-2726.0051,602.4812,33.2752,178.5789,0,0); //
AddStaticVehicle(429,-2469.0234,741.5986,34.6062,179.3619,6,79); //
AddStaticVehicle(429,-2460.4531,740.9267,34.7364,179.4910,2,1); //
AddStaticVehicle(402,-2447.3284,741.2919,34.7784,179.4708,39,39); //
AddStaticVehicle(451,-2433.7515,741.8072,34.6424,178.9003,0,0); //
//===================================Ap=========================================
AddStaticVehicle(511,-1572.8491,-270.3145,15.5219,34.8194,3,1); //
AddStaticVehicle(511,-1549.8407,-257.4956,15.4662,25.3979,3,1); //
AddStaticVehicle(519,-1499.3141,-246.1460,15.0640,2.3762,1,1); //
AddStaticVehicle(519,-1468.8002,-202.8649,15.0653,347.3410,1,1); //
AddStaticVehicle(519,-1378.0177,-206.6290,15.0719,337.4792,1,1); //
AddStaticVehicle(519,-1398.2152,-218.6772,15.0683,326.6669,1,1); //
AddStaticVehicle(462,-1397.4740,-241.4233,13.7473,330.4485,3,3); //
AddStaticVehicle(462,-1394.6379,-243.3943,13.7501,329.8594,2,2); //
AddStaticVehicle(462,-1391.7162,-245.9816,13.7297,323.3116,2,2); //
AddStaticVehicle(462,-1388.9435,-248.2370,13.7457,319.1622,0,0); //
AddStaticVehicle(462,-1386.1094,-250.4217,13.7431,319.3045,13,13); //
AddStaticVehicle(519,-1203.8344,-141.1667,15.0564,134.9104,1,1); //
AddStaticVehicle(519,-1243.4166,-91.8895,15.0635,136.1605,1,1); //
AddStaticVehicle(593,-1169.9938,-148.1412,14.6069,133.9165,1,1); //
AddStaticVehicle(513,-1104.5293,-170.9784,14.6956,113.5440,75,1); //
AddStaticVehicle(513,-1099.6859,-182.5389,14.6718,115.3181,0,175); //
AddStaticVehicle(487,-1088.4430,-219.7470,14.2945,21.3306,25,0); //
AddStaticVehicle(553,-1244.1184,-175.1415,15.5073,44.3994,0,1); //
AddStaticVehicle(512,-1171.1217,-385.1264,14.3958,5.3282,3,44); //
AddStaticVehicle(520,-1353.2094,-469.9438,14.8952,204.6816,110,110); //
AddStaticVehicle(520,-1370.7339,-477.6527,14.9030,206.0657,0,0); //
AddStaticVehicle(520,-1387.2209,-485.5781,14.9020,204.6810,0,0); //
AddStaticVehicle(476,-1448.9733,-515.8196,14.8518,208.8339,103,102); //
AddStaticVehicle(476,-1438.2454,-510.4076,14.8747,204.1393,119,117); //
AddStaticVehicle(487,-1123.1102,-233.9460,14.3094,22.9199,0,0); //
AddStaticVehicle(487,-1111.3824,-229.2242,14.3259,21.5016,0,1); //
AddStaticVehicle(487,-1099.3450,-224.4765,14.3161,20.9281,6,0); //
AddStaticVehicle(593,-1160.0237,-158.1685,14.5848,134.4907,60,1); //
AddStaticVehicle(447,-1283.5007,-94.2059,14.1694,134.6121,75,2); //
AddStaticVehicle(417,-1223.2076,-11.4312,14.2863,44.8127,0,0); //
AddStaticVehicle(563,-1190.5403,53.7621,14.8531,135.4108,1,6); //
AddStaticVehicle(563,-1204.6238,67.5202,14.8273,135.3869,1,6); //
AddStaticVehicle(544,-1255.2712,24.7542,14.4032,134.1424,3,1); //
AddStaticVehicle(544,-1265.0065,34.6252,14.3971,131.9442,3,1); //
AddStaticVehicle(519,-1310.6172,-273.5580,15.0624,309.1476,1,1); //
AddStaticVehicle(519,-1335.2933,-283.4064,15.0671,308.4312,1,1); //
AddStaticVehicle(417,-1185.2722,25.1172,14.2815,44.8145,0,0); //
AddStaticVehicle(485,-1365.2977,-270.4810,13.7927,308.7103,0,0); //
AddStaticVehicle(485,-1367.9432,-267.0099,13.8068,307.8505,1,74); //
AddStaticVehicle(476,-1640.2017,-147.6786,14.8380,314.6217,119,117); //
AddStaticVehicle(433,-1428.8246,458.9282,7.5700,358.0105,43,0); //
AddStaticVehicle(433,-1436.1089,459.0514,7.5668,356.9133,43,0); //
AddStaticVehicle(470,-1452.5668,455.1203,7.1094,359.3076,43,0); //
AddStaticVehicle(470,-1458.6285,455.2437,7.0935,359.0378,1,1); //
AddStaticVehicle(470,-1464.9028,455.3954,7.2022,359.7503,43,0); //
AddStaticVehicle(470,-1471.0847,455.4293,7.0673,359.9733,0,0); //
AddStaticVehicle(520,-1456.6565,501.3925,18.9913,270.1087,0,0); //
AddStaticVehicle(520,-1434.2251,491.2705,18.9553,358.2201,0,0); //
AddStaticVehicle(520,-1419.5461,490.8678,18.9583,358.2220,0,0); //
AddStaticVehicle(520,-1404.5989,490.3468,18.9520,358.8922,0,0); //
AddStaticVehicle(520,-1308.2847,490.7219,18.9598,359.6003,0,0); //
AddStaticVehicle(520,-1293.5208,490.6185,18.9597,359.6003,0,0); //
AddStaticVehicle(520,-1278.7655,490.5147,18.9564,359.6003,0,0); //
AddStaticVehicle(407,-1259.53637695,61.10678482,14.51843739,45.50000000,3,3); //Firetruck
AddStaticVehicle(407,-1255.70019531,64.97780609,14.51843739,45.49987793,3,3); //Firetruck
AddStaticVehicle(487,-1251.06713867,56.61374283,20.25718689,44.50000000,3,0); //Maverick
AddStaticVehicle(519,-1319.50891113,-348.52868652,15.14850998,283.50000000,1,1); //Shamal
AddStaticVehicle(592,-1684.02050781,-325.02566528,15.27343941,314.75000000,0,65); //Andromada
//===================================Swamp======================================
AddStaticVehicle(471,-843.3577,-1997.8479,18.6953,107.8654,0,3); //
AddStaticVehicle(471,-844.2544,-1995.4727,18.4496,112.2703,66,71); //
AddStaticVehicle(471,-845.4319,-1993.2562,18.2084,110.3415,120,113); //
AddStaticVehicle(471,-846.2372,-1990.9073,17.9416,109.8008,74,83); //
AddStaticVehicle(568,-860.8280,-2001.9711,19.9340,286.4610,17,1); //
AddStaticVehicle(568,-862.2355,-1997.4280,19.4622,286.8441,9,39); //
AddStaticVehicle(568,-849.4747,-1982.5248,17.2943,109.7879,21,1); //
AddStaticVehicle(568,-850.7596,-1979.0770,16.9598,109.8972,33,0); //
AddStaticVehicle(471,-868.0652,-1989.7767,18.3651,288.4386,103,111); //
AddStaticVehicle(471,-868.6868,-1987.8792,18.1802,287.3921,120,113); //
AddStaticVehicle(471,-869.3892,-1986.2303,18.0202,292.4661,1,0); //
AddStaticVehicle(471,-870.4658,-1984.3352,17.8300,294.0116,74,91); //
AddStaticVehicle(468,-849.2405,-1916.3059,14.1325,225.0527,3,3); //
AddStaticVehicle(468,-847.3870,-1914.8053,13.9243,226.0322,0,0); //
AddStaticVehicle(468,-845.8251,-1912.8087,13.7878,229.6012,46,46); //
AddStaticVehicle(468,-844.1894,-1911.1653,13.6220,230.5559,53,53); //
AddStaticVehicle(468,-842.6167,-1909.3198,13.4768,229.7622,0,0); //
AddStaticVehicle(495,-834.1252,-1902.4709,13.1326,224.0588,93,0); //
AddStaticVehicle(495,-829.7873,-1897.9680,12.7011,225.1553,118,117); //
AddStaticVehicle(495,-825.7837,-1893.3501,12.3229,228.5939,0,0); //
AddStaticVehicle(495,-821.9271,-1888.9120,11.9200,224.0651,0,2); //
//==================================Farm========================================
AddStaticVehicle(530,-89.7834,-10.5276,2.8385,251.9183,114,1); //
AddStaticVehicle(530,-82.3213,8.9720,2.8453,251.4233,112,1); //
AddStaticVehicle(531,-56.9847,-22.6492,3.0991,72.7621,126,0); //
AddStaticVehicle(486,-29.3239,-22.0915,3.2969,154.5743,1,1); //
AddStaticVehicle(411,-70.1120,37.7054,2.8241,340.6895,0,0); //
AddStaticVehicle(522,-61.0710,33.3398,2.6490,338.5071,0,65); //
AddStaticVehicle(471,-38.4648,56.1803,2.5432,342.2285,124,124); //
AddStaticVehicle(471,-28.6849,62.3626,2.5981,68.2982,120,113); //
AddStaticVehicle(471,-21.2570,82.1249,2.5924,68.9307,74,83); //
AddStaticVehicle(535,-57.2279,88.6694,2.8983,337.9800,0,0); //
AddStaticVehicle(581,-62.0627,76.0644,2.6734,253.4367,72,1); //
AddStaticVehicle(406,-104.6924,86.2357,4.5907,160.8971,1,1); //
AddStaticVehicle(468,-84.6645,101.9756,2.7430,158.8770,0,1); //
AddStaticVehicle(532,-124.8026,68.4206,4.1092,157.9218,1,1); //
AddStaticVehicle(532,-137.2832,73.7147,4.1047,158.2399,0,0); //
AddStaticVehicle(486,-92.9399,-90.7727,3.2890,80.0362,1,1); //
//==================================CarPark=====================================
AddStaticVehicle(411,-1888.1539,-927.5546,31.7567,269.6959,6,6); //
AddStaticVehicle(411,-1887.9626,-930.4878,31.7355,269.2359,79,79); //
AddStaticVehicle(411,-1887.9572,-933.5776,31.7355,270.3260,106,1); //
AddStaticVehicle(560,-1888.1284,-939.5436,31.6995,269.9556,37,0); //
AddStaticVehicle(560,-1888.0133,-942.3798,31.6880,269.5416,1,1); //
AddStaticVehicle(560,-1888.0742,-945.8380,31.6691,269.7702,6,6); //
AddStaticVehicle(500,-1888.6012,-951.7952,32.1562,266.6596,28,119); //
AddStaticVehicle(500,-1888.4590,-957.8126,32.0891,270.8200,40,84); //
AddStaticVehicle(500,-1888.3998,-954.7518,32.1568,269.9589,40,110); //
AddStaticVehicle(602,-1871.3142,-957.7874,31.7824,90.3844,0,0); //
AddStaticVehicle(602,-1872.1292,-954.5709,31.7703,88.3161,6,6); //
AddStaticVehicle(602,-1871.9844,-951.6387,31.7715,87.5286,126,126); //
AddStaticVehicle(434,-1871.3065,-945.5536,32.0054,89.0033,6,6); //
AddStaticVehicle(434,-1871.0303,-942.4711,32.0082,90.9699,4,4); //
AddStaticVehicle(434,-1870.9713,-939.6754,31.9302,89.9098,126,126); //
AddStaticVehicle(603,-1871.3036,-933.5742,31.8281,89.9510,79,0); //
AddStaticVehicle(603,-1871.1355,-930.3575,31.8802,89.2837,58,1); //
AddStaticVehicle(603,-1871.1674,-927.1483,31.8803,89.6125,69,1); //
AddStaticVehicle(406,-2130.1985,254.7214,37.0421,269.8816,1,1); //
AddStaticVehicle(486,-2062.8435,228.8904,35.9627,1.3795,3,3); //
AddStaticVehicle(496,-2266.0208,188.5693,34.8769,270.3724,66,72); //
AddStaticVehicle(438,-2320.2366,-160.4280,35.6069,177.8359,6,6); //
AddStaticVehicle(429,-2149.5193,-965.2304,31.6988,270.1640,1,2); //
AddStaticVehicle(429,-2149.5269,-962.2772,31.6709,270.1644,2,1); //
AddStaticVehicle(429,-2149.5317,-959.2140,31.6431,270.1644,6,1); //
AddStaticVehicle(429,-2149.5515,-956.3995,31.6408,269.6801,3,1); //
AddStaticVehicle(560,-2133.2986,-965.1106,31.6657,89.5411,0,0); //
AddStaticVehicle(560,-2133.2742,-962.2067,31.6666,89.5407,21,1); //
AddStaticVehicle(560,-2133.2515,-959.2272,31.7455,89.5408,0,0); //
AddStaticVehicle(560,-2133.2273,-956.2504,31.6875,89.5406,6,6); //
AddStaticVehicle(506,-2133.4768,-938.1638,31.7585,90.5033,3,3); //
AddStaticVehicle(506,-2133.5020,-935.2814,31.7585,90.5033,7,7); //
AddStaticVehicle(506,-2133.5293,-932.2518,31.7155,90.5031,0,0); //
AddStaticVehicle(506,-2133.5557,-929.2985,31.7585,90.5031,76,76); //
AddStaticVehicle(556,-2149.0220,-932.2527,32.4292,269.4152,1,1); //
AddStaticVehicle(556,-2149.1421,-944.1431,32.4331,269.4152,1,1); //
AddStaticVehicle(556,-2149.1077,-938.0679,32.3910,269.7223,1,1); //
AddStaticVehicle(522,-2134.5247,-923.2232,31.5574,90.0530,7,79); //
AddStaticVehicle(522,-2134.5273,-920.1465,31.5574,90.0530,0,0); //
AddStaticVehicle(522,-2134.5295,-917.3887,31.5785,90.0530,3,8); //
AddStaticVehicle(451,-2149.4634,-917.0935,31.7471,270.8252,6,6); //
AddStaticVehicle(451,-2149.5042,-914.2611,31.7258,270.8251,6,6); //
AddStaticVehicle(411,-2149.4404,-908.1303,31.7296,269.4268,0,0); //
AddStaticVehicle(411,-2149.4697,-911.0605,31.7325,269.4268,0,0); //
AddStaticVehicle(535,-2149.4155,-898.5273,31.7150,270.6487,0,0); //
AddStaticVehicle(535,-2149.4519,-895.3272,31.7151,270.6497,3,2); //
AddStaticVehicle(535,-2149.4946,-892.1301,31.8011,270.6507,97,1); //
AddStaticVehicle(559,-2133.4856,-895.2673,31.6967,90.0102,126,126); //
AddStaticVehicle(559,-2133.4758,-898.6729,31.7085,89.5011,60,1); //
AddStaticVehicle(559,-2133.4871,-901.8786,31.7104,89.7352,58,8); //
AddStaticVehicle(567,-2149.4431,-882.3782,31.9263,270.2726,88,64); //
AddStaticVehicle(567,-2149.4707,-875.7866,31.9264,270.2726,93,64); //
AddStaticVehicle(567,-2149.4551,-879.2785,31.9167,270.2727,90,96); //
AddStaticVehicle(539,-2002.5000,-868.5262,31.5319,360.0000,86,70); //
AddStaticVehicle(539,-2002.3463,-853.2512,31.5319,177.8221,96,67); //
AddStaticVehicle(539,-2044.7338,-850.9473,31.5319,178.7325,70,86); //
AddStaticVehicle(539,-2044.4374,-870.7659,31.5319,360.0000,79,74); //
//===================================Ramp=======================================
UnBuyAble(AddStaticVehicle(522,1927.5164,-1437.5206,13.1102,180.4843,161,0)); //
UnBuyAble(AddStaticVehicle(522,1925.5026,-1437.5996,13.1102,179.6380,161,0)); //
UnBuyAble(AddStaticVehicle(522,1923.6023,-1437.6384,13.1095,180.3134,161,0)); //
UnBuyAble(AddStaticVehicle(522,1921.6108,-1437.6787,13.1102,181.3620,161,0)); //
UnBuyAble(AddStaticVehicle(522,1919.6727,-1437.7008,13.1105,181.7954,161,0)); //
UnBuyAble(AddStaticVehicle(522,1912.9532,-1437.7544,13.1099,180.4856,7,0)); //
UnBuyAble(AddStaticVehicle(522,1910.9510,-1437.8134,13.1122,180.9084,7,0)); //
UnBuyAble(AddStaticVehicle(522,1904.5935,-1437.9994,13.1076,181.8873,7,0)); //
UnBuyAble(AddStaticVehicle(522,1906.9956,-1437.9668,13.1107,180.8500,7,0)); //
UnBuyAble(AddStaticVehicle(522,1909.0054,-1437.8789,13.1115,183.6379,7,0)); //
UnBuyAble(AddStaticVehicle(481,1863.6906,-1391.1036,13.0001,271.8551,147,147)); //
UnBuyAble(AddStaticVehicle(481,1863.7244,-1393.2109,12.9982,269.1978,39,39)); //
UnBuyAble(AddStaticVehicle(481,1863.6852,-1395.7813,12.9951,270.0794,6,6)); //
UnBuyAble(AddStaticVehicle(481,1863.8022,-1398.0277,12.9943,269.0684,16,16)); //
UnBuyAble(AddStaticVehicle(481,1863.8485,-1400.2561,12.9943,271.2113,161,161)); //
UnBuyAble(AddStaticVehicle(481,1863.7008,-1402.3867,12.9909,272.2477,5,5)); //
UnBuyAble(AddStaticVehicle(481,1863.7684,-1404.4585,12.9911,272.2025,0,0)); //
UnBuyAble(AddStaticVehicle(490,1976.6759,-1306.4758,20.9193,270.2005,0,0)); //
//=================================Chiliad======================================
AddStaticVehicle(468,-2329.2942,-1604.7324,483.4205,187.2765,6,6); //
AddStaticVehicle(468,-2327.7769,-1604.4204,483.4381,187.6925,46,46); //
AddStaticVehicle(468,-2324.6619,-1603.4634,483.4726,195.6618,3,3); //
AddStaticVehicle(468,-2326.3040,-1604.0344,483.4521,191.5855,0,0); //
AddStaticVehicle(495,-2335.3306,-1600.4806,483.9228,220.1620,93,0); //
AddStaticVehicle(444,-2340.2393,-1608.6672,484.0456,218.2831,32,14); //
AddStaticVehicle(444,-2343.0947,-1614.8398,484.0249,252.9039,3,0); //
AddStaticVehicle(444,-2344.4548,-1624.0627,484.0325,250.6934,32,32); //
AddStaticVehicle(444,-2346.9448,-1631.2499,484.0438,230.0681,0,3); //
AddStaticVehicle(444,-2350.4495,-1637.2681,484.0584,235.4800,3,3); //
AddStaticVehicle(539,-2344.4539,-1657.0259,483.0632,307.6514,96,67); //
AddStaticVehicle(539,-2337.8625,-1664.8289,482.9582,312.5508,61,98); //
AddStaticVehicle(539,-2340.1875,-1662.3212,483.0632,308.7845,0,0); //
AddStaticVehicle(539,-2342.3635,-1659.7311,483.0632,308.7662,75,91); //
//=================================Drift========================================
UnBuyAble(AddStaticVehicle(480,-2416.5032,-589.4266,132.3758,216.0995,-1,-1)); //
UnBuyAble(AddStaticVehicle(480,-2413.9856,-587.5714,132.3712,214.8830,-1,-1)); //
UnBuyAble(AddStaticVehicle(477,-2411.5691,-585.6343,132.4300,215.3871,-1,-1)); //
UnBuyAble(AddStaticVehicle(477,-2408.9756,-583.7319,132.4296,216.4200,-1,-1)); //
UnBuyAble(AddStaticVehicle(411,-2403.0107,-584.8933,132.3895,125.2709,-1,-1)); //
UnBuyAble(AddStaticVehicle(411,-2401.4253,-587.1811,132.3860,124.1363,-1,-1)); //
UnBuyAble(AddStaticVehicle(411,-2399.6155,-589.6254,132.3849,125.9522,-1,-1)); //
UnBuyAble(AddStaticVehicle(429,-2396.3123,-594.6348,132.3682,124.2965,-1,-1)); //
UnBuyAble(AddStaticVehicle(429,-2394.5920,-596.9071,132.3719,126.0261,-1,-1)); //
UnBuyAble(AddStaticVehicle(429,-2392.8613,-599.3526,132.3281,125.3373,-1,-1)); //
UnBuyAble(AddStaticVehicle(451,-2392.1113,-607.9438,132.3736,35.7297,-1,-1)); //
UnBuyAble(AddStaticVehicle(451,-2394.2981,-610.0475,132.3547,35.1966,-1,-1)); //
UnBuyAble(AddStaticVehicle(541,-2397.2327,-611.3199,132.2168,33.9903,-1,-1)); //
UnBuyAble(AddStaticVehicle(541,-2399.7148,-613.0877,132.2251,35.8647,-1,-1)); //
//==================================Police======================================
UnBuyAble(AddStaticVehicle(523,-1587.7782,650.3602,6.7417,358.3603,0,0)); //
UnBuyAble(AddStaticVehicle(523,-1593.2261,650.3727,6.7343,1.5801,0,0)); //
UnBuyAble(AddStaticVehicle(599,-1599.8932,650.4103,7.3159,358.6060,0,1)); //
UnBuyAble(AddStaticVehicle(599,-1605.0925,650.6741,7.4110,359.6737,0,1)); //
UnBuyAble(AddStaticVehicle(599,-1610.4594,650.8972,7.3556,1.0530,0,1)); //
UnBuyAble(AddStaticVehicle(599,-1616.4788,650.8622,7.4152,359.1494,0,1)); //
UnBuyAble(AddStaticVehicle(599,-1622.8579,651.1893,7.3471,359.7455,0,1)); //
UnBuyAble(AddStaticVehicle(523,-1628.3961,650.9490,6.7504,0.1638,0,0)); //
UnBuyAble(AddStaticVehicle(523,-1617.3604,674.0561,6.7448,177.3778,0,0)); //
UnBuyAble(AddStaticVehicle(597,-1611.8483,673.1419,6.9128,178.9445,0,1)); //
UnBuyAble(AddStaticVehicle(597,-1606.0708,673.0208,6.9125,179.5914,0,1)); //
UnBuyAble(AddStaticVehicle(597,-1599.9326,673.0031,6.9294,178.7519,0,1)); //
UnBuyAble(AddStaticVehicle(597,-1594.1533,672.9005,6.9127,179.5787,0,1)); //
UnBuyAble(AddStaticVehicle(523,-1588.3662,673.5247,6.7429,173.4102,0,0)); //
UnBuyAble(AddStaticVehicle(427,-1638.5529,653.7833,-5.0990,269.7304,0,1)); //
UnBuyAble(AddStaticVehicle(427,-1623.4629,653.9400,-5.0990,91.4497,0,1)); //
UnBuyAble(AddStaticVehicle(523,-1640.3042,666.1432,-5.7014,269.2207,0,0)); //
UnBuyAble(AddStaticVehicle(523,-1640.0803,661.9228,-5.6889,270.9948,0,0)); //
UnBuyAble(AddStaticVehicle(497,-1679.1294,706.0899,30.7215,88.3651,0,1)); //
//===================================Sf=========================================
AddStaticVehicle(581,-1913.2061,874.1618,34.8526,268.9501,87,1); //
AddStaticVehicle(411,-1906.5695,868.9958,34.7927,179.2276,106,1); //
AddStaticVehicle(581,-1913.1205,892.6075,34.8835,274.7524,66,1); //
AddStaticVehicle(603,-1818.4229,938.4212,24.8733,269.1343,18,1); //
AddStaticVehicle(409,-1754.2048,956.2113,24.5976,270.4798,86,86); //
AddStaticVehicle(429,-1707.4486,1030.8280,44.8069,177.8210,0,1); //
AddStaticVehicle(518,-1658.2604,452.4178,6.8148,223.0193,0,0); //
AddStaticVehicle(581,-1714.5779,398.9946,6.7765,225.4230,58,1); //
AddStaticVehicle(521,-1550.9458,771.2421,6.8182,176.4854,89,89); //
AddStaticVehicle(429,-1455.3180,1142.8295,6.8132,91.6142,3,1); //
AddStaticVehicle(535,-1645.2820,1268.4771,6.8877,224.4091,0,0); //
AddStaticVehicle(556,-1633.9352,1293.3038,7.4044,133.4600,1,1); //
AddStaticVehicle(556,-1637.8131,1296.9207,7.4064,134.9865,1,1); //
AddStaticVehicle(556,-1641.3455,1300.5961,7.3921,134.3327,1,1); //
AddStaticVehicle(556,-1645.0261,1304.1212,7.3867,134.9720,1,1); //
AddStaticVehicle(556,-1648.2906,1307.8110,7.3864,134.1681,1,1); //
AddStaticVehicle(556,-1651.7559,1311.6740,7.4026,133.7146,0,0); //
AddStaticVehicle(560,-1697.8960,1270.1930,6.8018,224.8454,56,29); //
AddStaticVehicle(560,-1665.4069,1215.3218,6.9519,256.0462,9,39); //
AddStaticVehicle(463,-1660.4792,1210.6116,13.2062,334.8750,0,0); //
AddStaticVehicle(463,-1662.5940,1213.2437,13.2008,278.7897,0,0); //
AddStaticVehicle(541,-1661.2271,1214.3411,20.7917,319.2591,1,0); //
AddStaticVehicle(451,-1657.2440,1205.8842,20.8289,289.0464,0,0); //
AddStaticVehicle(541,-1810.4370,1312.3120,59.3289,185.9738,1,0); //
AddStaticVehicle(500,-1790.2372,1426.6506,7.3199,179.2313,4,119); //
AddStaticVehicle(535,-1834.9916,1425.3336,6.9623,181.4995,1,1); //
AddStaticVehicle(602,-1870.0641,1366.6595,6.9239,127.2109,69,1); //
AddStaticVehicle(495,-1972.0292,1225.0743,31.8990,89.7259,93,0); //
AddStaticVehicle(428,-1968.1685,1316.3474,7.2270,271.1194,0,0); //
AddStaticVehicle(428,-1949.5985,1316.2362,7.2777,91.7129,0,0); //
AddStaticVehicle(581,-1984.5007,1106.2134,52.7457,273.3328,7,7); //
AddStaticVehicle(522,-1984.4825,1130.2163,52.7656,274.2757,6,0); //
AddStaticVehicle(439,-1831.8710,1096.1995,45.1993,89.5605,0,0); //
AddStaticVehicle(560,-1770.0524,1195.6499,24.7119,90.8117,0,0); //
AddStaticVehicle(579,-1789.7727,1205.0908,24.9630,179.7773,0,0); //
AddStaticVehicle(522,-1784.4069,1227.8596,32.1935,128.3321,1,1); //
AddStaticVehicle(477,-1753.9298,1178.7368,24.7320,89.0193,0,0); //
AddStaticVehicle(411,-1696.4562,1211.5894,32.6320,90.9482,6,0); //
AddStaticVehicle(411,-1648.5381,1205.6975,32.6239,251.5503,0,0); //
AddStaticVehicle(541,-1885.0680,1307.3317,6.7613,314.0513,0,1); //
AddStaticVehicle(449,-1899.8107,848.8750,35.4973,90.0000,1,74); //
AddStaticVehicle(560,-1996.8379,873.7386,45.0340,181.1502,0,75); //
AddStaticVehicle(587,-1996.5339,813.0338,45.1098,181.9131,40,1); //
AddStaticVehicle(535,-1970.1749,738.6042,45.1364,271.8756,31,1); //
AddStaticVehicle(603,-1927.8022,723.9745,45.1695,91.3129,0,1); //
AddStaticVehicle(477,-2011.6273,542.9892,34.7755,181.1810,0,0); //
AddStaticVehicle(402,-1996.5448,418.0875,34.8690,179.5255,1,1); //
AddStaticVehicle(588,-2033.1659,422.9353,35.0267,0.0141,1,1); //
AddStaticVehicle(455,-2128.2351,288.4987,35.4053,267.8111,6,6); //
AddStaticVehicle(406,-2117.8308,276.8789,36.8628,271.6655,1,1); //
AddStaticVehicle(531,-2126.4531,237.6418,37.1853,306.1182,3,3); //
AddStaticVehicle(524,-2063.1968,179.2488,29.7362,179.4660,0,0); //
AddStaticVehicle(530,-2133.5645,172.9437,35.0231,269.9873,119,1); //
AddStaticVehicle(530,-2133.8206,182.3444,34.9776,268.3526,3,3); //
AddStaticVehicle(578,-2162.9851,292.4433,35.8494,358.5107,6,6); //
AddStaticVehicle(541,-2184.4238,305.6870,34.7720,0.3733,13,8); //
AddStaticVehicle(477,-2197.0408,293.4789,34.9007,180.0793,121,1); //
AddStaticVehicle(500,-2212.0486,324.9749,35.3025,88.7101,1,1); //
AddStaticVehicle(451,-2222.9028,293.7422,34.8547,180.3706,0,0); //
AddStaticVehicle(439,-2265.2051,149.1124,35.0636,90.1824,43,21); //
AddStaticVehicle(505,-2266.0222,105.2717,35.2680,268.6276,14,123); //
AddStaticVehicle(516,-2267.6777,77.5388,35.0309,89.3107,119,1); //
AddStaticVehicle(411,-2187.0657,44.5413,35.0569,269.6486,12,1); //
AddStaticVehicle(404,-2206.7952,-20.2472,35.0697,179.2951,101,101); //
AddStaticVehicle(471,-2032.0873,-58.5630,34.8116,176.3952,120,114); //
AddStaticVehicle(415,-2038.9075,-65.9044,34.9968,271.7662,125,125); //
AddStaticVehicle(447,-1646.9548,251.5751,0.8320,96.4850,2,2); //
AddStaticVehicle(425,-1521.9757,320.7838,54.0423,180.1081,43,0); //
AddStaticVehicle(461,-1528.5247,359.9005,6.7747,356.5332,57,57); //
AddStaticVehicle(560,-2319.2061,-123.2607,35.0063,180.1423,0,0); //
AddStaticVehicle(560,-2322.6204,-123.1839,34.9560,178.5316,3,0); //
AddStaticVehicle(603,-2329.9563,-124.2013,35.1682,177.8442,58,1); //
AddStaticVehicle(541,-2333.9373,-123.9966,34.8704,181.1996,1,79); //
AddStaticVehicle(494,-2341.1213,-124.9117,35.2262,179.0239,42,30); //
AddStaticVehicle(402,-2351.9634,-123.8845,35.0863,179.2360,6,6); //
AddStaticVehicle(451,-2356.1492,-124.1450,34.9872,179.1757,3,3); //
AddStaticVehicle(477,-2376.8689,-115.5475,35.0318,359.5086,121,1); //
AddStaticVehicle(488,-2035.6241,441.7619,139.9418,93.8319,2,29); //
AddStaticVehicle(544,-2055.94653320,92.78965759,28.66062737,89.25000000,3,3);
AddStaticVehicle(544,-2055.95043945,84.17321014,28.66062737,89.24743652,3,3);
AddStaticVehicle(544,-2056.08886719,75.68820190,28.66062737,89.24743652,3,3);
//==================================Wang========================================
AddStaticVehicle(556,-1928.6740,273.4246,41.4074,179.0954,1,1); //
Special(AddStaticVehicle(556,-1936.4418,273.0993,41.4145,180.2067,0,3)); //
Special(AddStaticVehicle(559,-1947.1974,273.6057,40.6537,79.6707,86,86)); //
Special(AddStaticVehicle(411,-1947.1412,267.7658,40.7901,116.9343,0,0)); //
Special(AddStaticVehicle(522,-1946.4642,261.6481,40.5980,84.9104,0,6)); //
AddStaticVehicle(506,-1948.6754,257.9066,40.7104,66.9989,10,10); //
AddStaticVehicle(429,-1954.7881,305.2672,35.1131,89.8971,161,1); //
AddStaticVehicle(541,-1946.1765,274.2907,35.1093,90.3477,1,28); //
AddStaticVehicle(541,-1946.1439,269.4329,35.0690,90.3466,6,0); //
AddStaticVehicle(429,-1945.9962,263.1033,35.1323,88.8423,8,0); //
AddStaticVehicle(429,-1946.0610,258.9952,35.1400,87.2770,1,2); //
AddStaticVehicle(429,-1946.1346,255.2660,35.1398,88.2929,6,79); //
AddStaticVehicle(602,-1992.2296,252.1217,34.9872,263.5534,69,1); //
AddStaticVehicle(603,-1989.6106,275.7693,35.0285,266.7985,1,109); //
AddStaticVehicle(429,-1988.1456,307.2786,34.8436,268.5019,14,14); //
AddStaticVehicle(541,-1988.7167,301.1601,34.8165,269.8279,0,1); //
AddStaticVehicle(471,-1979.7396,308.1754,34.6611,178.3656,120,114); //
AddStaticVehicle(471,-1974.9532,308.2091,34.6593,179.5426,74,91); //
AddStaticVehicle(471,-1969.2377,308.2219,34.6613,178.9082,3,0); //
//==================================BusTrip=====================================
UnBuyAble(AddStaticVehicle(437,-247.0922,1891.6843,42.4540,151.5856,3,3)); //
UnBuyAble(AddStaticVehicle(437,-250.4888,1898.8481,42.4541,149.6969,0,0)); //
UnBuyAble(AddStaticVehicle(437,-256.5625,1902.2019,42.4540,148.4915,0,0)); //
UnBuyAble(AddStaticVehicle(437,-262.3110,1905.8865,42.4541,148.3482,0,0)); //
UnBuyAble(AddStaticVehicle(437,-269.8942,1905.8737,42.4540,147.6273,3,3)); //
//====================================Jeeps=====================================
UnBuyAble(AddStaticVehicle(500,-289.1720,1778.0601,42.8507,90.0415,40,84)); //
UnBuyAble(AddStaticVehicle(500,-289.1561,1775.4856,42.8432,90.0754,40,110)); //
UnBuyAble(AddStaticVehicle(500,-289.3204,1772.6793,42.8350,90.6097,0,1)); //
UnBuyAble(AddStaticVehicle(500,-289.7960,1767.5902,42.7901,90.2624,25,119)); //
UnBuyAble(AddStaticVehicle(500,-289.5667,1761.5337,42.8194,87.4815,13,119)); //
UnBuyAble(AddStaticVehicle(500,-289.6246,1764.7023,42.8221,90.4867,99,99)); //
UnBuyAble(AddStaticVehicle(424,-290.3598,1749.0972,42.4516,89.2006,1,0)); //
UnBuyAble(AddStaticVehicle(424,-290.2513,1751.5679,42.4596,90.3209,1,0)); //
UnBuyAble(AddStaticVehicle(424,-290.4114,1754.1252,42.4494,89.4977,1,0)); //
UnBuyAble(AddStaticVehicle(424,-290.6798,1756.7410,42.4608,89.2056,1,0)); //
UnBuyAble(AddStaticVehicle(568,-303.0730,1755.2976,42.5629,268.7963,2,39)); //
UnBuyAble(AddStaticVehicle(568,-302.8908,1757.8967,42.5530,269.1893,56,29)); //
UnBuyAble(AddStaticVehicle(568,-302.8831,1760.4995,42.5536,271.0013,41,29)); //
UnBuyAble(AddStaticVehicle(568,-303.2080,1763.1812,42.5461,266.8701,37,0)); //
UnBuyAble(AddStaticVehicle(568,-302.4836,1770.0629,42.5507,269.9705,33,0)); //
UnBuyAble(AddStaticVehicle(568,-302.6206,1772.6088,42.5263,269.2188,21,1)); //
UnBuyAble(AddStaticVehicle(568,-302.6462,1775.1218,42.5317,268.3875,17,1)); //
UnBuyAble(AddStaticVehicle(568,-302.4629,1777.6445,42.5658,269.0535,9,39)); //
//===================================ShipTrip===================================
UnBuyAble(AddStaticVehicle(446,2103.1462,-32.8769,-0.5368,65.7795,3,3));
UnBuyAble(AddStaticVehicle(446,2097.9075,-40.7367,-0.5417,70.3948,1,5));
UnBuyAble(AddStaticVehicle(446,2093.2026,-48.6592,-0.5754,73.3482,0,0));
UnBuyAble(AddStaticVehicle(446,2090.4976,-57.8372,-0.5638,85.2306,1,57));
UnBuyAble(AddStaticVehicle(446,2085.2500,-66.5218,-0.5117,91.5918,3,3));
UnBuyAble(AddStaticVehicle(446,2083.6614,-75.9501,-0.5444,89.6813,1,5));
UnBuyAble(AddStaticVehicle(446,2082.7229,-84.3778,-0.5358,93.5046,0,0));
UnBuyAble(AddStaticVehicle(446,2083.6431,-93.5478,-0.5408,111.6346,1,57));
UnBuyAble(AddStaticVehicle(484,2086.4985,-114.1090,0.2142,123.0218,50,32));
UnBuyAble(AddStaticVehicle(446,2100.4358,-126.5323,-0.5387,128.5555,1,44));
UnBuyAble(AddStaticVehicle(446,2113.5593,-132.0242,-0.5368,132.3101,1,53));
UnBuyAble(AddStaticVehicle(446,2126.1025,-134.7409,-0.5754,137.5509,1,5));
UnBuyAble(AddStaticVehicle(446,2134.6711,-142.3154,-0.5202,145.1387,3,3));
UnBuyAble(AddStaticVehicle(446,2148.4487,-143.6273,-0.5535,148.5610,1,22));
UnBuyAble(AddStaticVehicle(446,2157.0149,-151.4726,-0.5598,151.5721,1,35));
UnBuyAble(AddStaticVehicle(446,2169.3167,-153.3668,-0.5611,164.0103,1,44));
UnBuyAble(AddStaticVehicle(446,2180.7847,-156.5506,-0.5581,164.4087,1,22));
UnBuyAble(AddStaticVehicle(446,2190.9558,-155.5159,-0.5691,175.2109,1,35));
UnBuyAble(AddStaticVehicle(473,1953.8485,-258.6856,-0.3123,358.2724,56,53));
UnBuyAble(AddStaticVehicle(473,1947.4432,-258.6354,-0.2742,352.3560,56,15));
UnBuyAble(AddStaticVehicle(473,1940.6747,-257.2292,-0.2816,341.9010,56,53));
UnBuyAble(AddStaticVehicle(473,1935.0416,-252.5730,-0.2669,326.1270,56,15));
UnBuyAble(AddStaticVehicle(473,1927.5369,-249.5473,-0.2658,316.8051,1,3));
UnBuyAble(AddStaticVehicle(473,1922.4053,-245.0264,-0.2495,319.8250,1,3));
UnBuyAble(AddStaticVehicle(473,1917.8579,-241.3291,-0.2377,315.9566,1,3));
UnBuyAble(AddStaticVehicle(473,1913.7484,-235.9723,-0.2939,309.6558,56,15));
UnBuyAble(AddStaticVehicle(473,1909.0323,-231.7034,-0.2556,300.7171,56,53));
UnBuyAble(AddStaticVehicle(473,1906.2128,-226.2856,-0.2699,303.1229,56,15));
UnBuyAble(AddStaticVehicle(473,1903.2531,-223.3725,-0.2664,304.6407,56,53));
AddStaticVehicle(504,-2900.59765625,1104.51660156,26.98142052,270.00000000,1,9); //Bloodring Banger
AddStaticVehicle(468,-2818.69433594,1125.69238281,25.55012703,0.00000000,1,1); //Sanchez
AddStaticVehicle(471,-2858.31054688,960.72167969,43.61825562,294.99938965,20,1); //Quad
Special(AddStaticVehicle(411,-2842.33300781,925.43066406,43.85468674,272.99926758,1,2)); //Infernus
Special(AddStaticVehicle(429,-2838.35205078,880.73944092,43.80468750,270.00000000,7,1)); //Banshee
AddStaticVehicle(416,-2679.80908203,582.67413330,14.75270081,270.00000000,-1,-1); //Ambulance
AddStaticVehicle(416,-2654.00610352,583.02526855,14.75270081,94.50000000,-1,-1); //Ambulance
Special(AddStaticVehicle(559,-2214.07617188,-215.52343750,35.07437515,0.00000000,113,8)); //Jester
AddStaticVehicle(522,-1807.11218262,560.67077637,34.82444000,0.00000000,3,1); //NRG-500
AddStaticVehicle(451,-1686.06250000,1020.20520020,17.35030937,90.00000000,-1,1); //Turismo
AddStaticVehicle(429,-2457.04028320,153.08125305,34.71093750,0.00000000,116,1); //Banshee
AddStaticVehicle(420,-2273.95776367,541.42108154,34.86562347,1.00000000,-1,-1); //Taxi
AddStaticVehicle(407,-2023.61364746,92.67195892,28.54216385,270.00000000,3,1); //Firetruck
AddStaticVehicle(407,-2023.51342773,84.03302765,28.54216385,270.00000000,3,1); //Firetruck
AddStaticVehicle(407,-2023.53625488,75.35976410,28.54216385,270.00000000,3,1); //Firetruck
Special(AddStaticVehicle(522,2183.5857,1285.5590,42.5583,86.4145,7,79)); //NRG-500
Special(AddStaticVehicle(429,1285.1224,1151.3729,18.6093,90.3083,6,1)); // Banshee
AddStaticVehicle(575,2899.8870,2506.6003,10.4690,130.5117,31,64); //
AddStaticVehicle(576,2895.3020,2510.8511,10.3824,135.3568,72,1); //
AddStaticVehicle(604,2890.2205,2515.9863,10.5752,138.1614,16,76); //
AddStaticVehicle(605,2884.6187,2521.5042,10.6564,136.3423,67,8); //
AddStaticVehicle(404,2891.2371,2446.8755,10.5722,227.0786,123,92); //
AddStaticVehicle(546,2879.1987,2436.2891,10.5855,224.0620,2,62); //
AddStaticVehicle(429,2863.8643,2421.4568,10.4937,225.0280,93,126); //
AddStaticVehicle(412,2845.6340,2402.0884,10.5511,223.9154,6,6); //
AddStaticVehicle(521,2872.6035,2376.5012,10.6206,0.2624,0,0); //
AddStaticVehicle(426,2891.2202,2364.6082,10.5095,89.3379,0,0); //
AddStaticVehicle(500,2891.1614,2353.3770,10.8529,88.4072,6,6); //
AddStaticVehicle(419,2878.4751,2345.6008,10.5881,269.2943,33,75); //
AddStaticVehicle(603,2878.3765,2338.3643,10.6683,268.7602,32,1); //
AddStaticVehicle(439,2880.1060,2309.7139,10.6539,359.7332,0,0); //
AddStaticVehicle(402,2860.6411,2309.6775,10.6533,359.6702,90,90); //
AddStaticVehicle(445,2866.7439,2330.7322,10.6998,87.9756,0,0); //
AddStaticVehicle(560,2852.8594,2334.5249,10.5297,269.6885,6,6); //
AddStaticVehicle(545,2852.9143,2360.8096,10.5909,270.4090,3,3); //
AddStaticVehicle(405,2866.5432,2360.8726,10.7284,90.2897,6,7); //
AddStaticVehicle(436,2852.6257,2379.6086,10.6106,270.1663,0,0); //
AddStaticVehicle(581,2847.6968,2376.2488,10.6596,359.9790,87,1); //
AddStaticVehicle(415,2841.0234,2353.2327,10.5569,90.4982,0,0); //
AddStaticVehicle(602,2840.8523,2334.6353,10.6336,91.5193,32,1); //
AddStaticVehicle(411,2833.6482,2310.0461,10.5520,0.5286,0,0); //
AddStaticVehicle(458,2827.3462,2375.8303,10.7222,270.0732,109,1); //
Special(AddStaticVehicle(522,2820.8975,2376.8398,10.6202,354.4484,2,3)); //
AddStaticVehicle(451,2815.7678,2379.5083,10.4632,89.3031,1,1); //
AddStaticVehicle(506,2815.0764,2357.1082,10.4969,90.1877,52,52); //
AddStaticVehicle(421,2815.2856,2345.6609,10.6687,89.6664,30,1); //
AddStaticVehicle(409,2805.0667,2414.4102,10.5990,134.3429,26,57); //
AddStaticVehicle(442,2788.3098,2431.3538,10.6709,135.0977,0,0); //
AddStaticVehicle(504,2780.1294,2439.7966,10.5883,133.4806,45,29); //
PizzaCar[1] = Pizza(AddStaticVehicle(448,2751.8679,2481.4490,10.6550,222.7800,3,6)); //
AddStaticVehicle(514,2785.1877,2577.2122,11.3318,46.4486,6,6); //
AddStaticVehicle(456,2795.6042,2574.9453,11.0266,46.0739,91,63); //
AddStaticVehicle(414,2811.5913,2589.6768,10.3175,44.5235,28,1); //
AddStaticVehicle(440,2826.3354,2601.3315,10.9063,46.1628,32,32); //
AddStaticVehicle(431,2791.7200,2635.6238,10.8992,206.7143,85,93); //
AddStaticVehicle(522,1757.2601,-1350.2267,15.1632,269.8121,0,6); //
AddStaticVehicle(471,-661.6643,2302.5608,135.4994,91.5964,103,111); //
AddStaticVehicle(471,-661.6714,2300.0879,135.5022,90.9490,120,114); //
AddStaticVehicle(471,-661.6478,2298.1404,135.5009,89.5786,0,3); //
AddStaticVehicle(495,-661.3630,2319.5984,139.1091,83.7379,119,122); //
AddStaticVehicle(495,-660.9938,2323.4204,138.9945,82.7109,118,117); //
AddStaticVehicle(424,-660.8054,2327.2859,138.4812,85.6081,15,30); //
AddStaticVehicle(424,-660.4392,2330.5115,138.4551,87.4501,24,53); //
AddStaticVehicle(522,-662.5603,2316.0439,138.3786,83.1028,0,1); //
AddStaticVehicle(468,-804.6092,2428.0107,156.6902,156.5501,6,4); //
AddStaticVehicle(451,-809.4683,2428.9678,156.6884,339.7581,0,0); //
AddStaticVehicle(530,-771.4196,2422.8435,156.8310,87.3949,6,6); //
AddStaticVehicle(531,-771.6932,2411.7461,157.0262,178.0939,6,0); //
Special(AddStaticVehicle(411,2177.8484,1822.3932,10.5352,180.9588,151,151)); //
AddStaticVehicle(409,2034.1836,1902.7249,11.9934,3.0481,0,1); //
AddStaticVehicle(409,2033.6785,1914.4023,12.0207,0.0919,0,1); //
AddStaticVehicle(409,2034.0762,1925.6224,12.0174,355.8943,0,1); //
AddStaticVehicle(409,2038.1368,1009.2969,10.5120,179.7516,1,1); //
Special(AddStaticVehicle(522,2040.5260,1026.2172,10.2250,318.3978,126,0)); //
AddStaticVehicle(475,1887.9916,1078.4884,10.5672,180.2905,93,93); //
AddStaticVehicle(500,1880.7996,1002.8376,10.8514,269.7292,0,0); //
AddStaticVehicle(507,1881.9694,991.7225,10.6721,270.2629,0,0); //
AddStaticVehicle(526,1881.4879,978.8182,10.6107,89.8814,1,1); //
AddStaticVehicle(408,-1852.7205,-1699.3075,41.4518,33.4410,26,26);
AddStaticVehicle(597,-42.90000153,2321.50000000,24.10000038,0.00000000,-1,-1); //Police Car (SFPD)
AddStaticVehicle(597,-45.79999924,2323.50000000,23.70000076,0.00000000,-1,-1); //Police Car (SFPD)
AddStaticVehicle(599,-39.79999924,2321.69995117,24.60000038,0.00000000,-1,-1); //Police Ranger
AddStaticVehicle(599,-49.29999924,2325.69995117,23.60000038,0.00000000,-1,-1); //Police Ranger
AddStaticVehicle(461,700.9470,1948.4100,5.1226,176.9294,43,1); //
AddStaticVehicle(492,686.4139,1945.8939,5.2579,180.3683,5,5); //
AddStaticVehicle(477,716.7361,1947.2822,5.3230,180.7968,0,0); //
AddStaticVehicle(480,721.4733,1948.0623,5.3305,181.2913,0,0); //
PizzaCar[2] = Pizza(AddStaticVehicle(448,-1805.2234,952.5329,24.4856,269.7288,3,6)); //
PizzaCar[3] = Pizza(AddStaticVehicle(448,-1805.2081,955.8533,24.4854,269.7288,3,6)); //
PizzaCar[4] = Pizza(AddStaticVehicle(448,-1805.1782,962.1057,24.4854,269.7288,3,6)); //
PizzaCar[5] = Pizza(AddStaticVehicle(448,-1805.1930,959.0081,24.4846,269.7288,3,6)); //
AddStaticVehicle(432,200.7728,1885.8760,17.6304,1.3243,0,0); //
AddStaticVehicle(548,225.1118,1887.8987,19.3713,358.6188,1,1); //
AddStaticVehicle(451,1098.2959,1439.0918,5.4998,179.6217,0,0); //
Elegy = AddStaticVehicle(562,1142.8966,1529.4530,51.9956,270.3023,1,1); //
ChangeVehiclePaintjob(Elegy,2);
AddStaticVehicle(522,288.7875,-556.7485,16.8530,0.0001,0,182); //
Special(AddStaticVehicle(522,1132.2634,-2040.8055,68.5637,300.5269,2,3)); //
AddStaticVehicle(411,1132.8544,-2037.5270,68.6636,269.5025,0,0); //
Special(AddStaticVehicle(522,1132.4019,-2034.0626,68.5680,243.8986,126,0)); //
AddStaticVehicle(506,1245.9216,-2021.0623,59.4980,269.9893,6,6); //
AddStaticVehicle(451,1246.3348,-2011.4833,59.5293,270.9407,6,6); //
AddStaticVehicle(556,-2413.8203,537.9196,30.3334,263.0284,1,1); //
AddStaticVehicle(556,-2416.4583,530.3226,30.3350,241.7369,1,1); //
AddStaticVehicle(434,-2422.8323,521.8962,29.8359,224.8952,0,1); //
AddStaticVehicle(434,-2419.5298,525.3444,29.8444,230.7523,46,46); //
AddStaticVehicle(602,-2425.9333,518.3016,29.7210,220.9237,0,0); //
AddStaticVehicle(602,-2429.4485,515.4302,29.7463,214.0811,0,0); //
AddStaticVehicle(424,-2805.3445,-1540.3225,139.2560,180.9374,0,0); //
AddStaticVehicle(468,-2813.2444,-1512.2283,138.9554,275.1522,53,53); //
AddStaticVehicle(510,-2837.4482,-1428.0657,135.9099,214.5863,44,44); //
AddStaticVehicle(461,-715.2207,2063.4111,59.9545,276.8533,79,1); //
AddStaticVehicle(521,-656.0335,2096.0264,59.9533,145.2384,87,118); //
AddStaticVehicle(533,1727.9105,1816.0657,10.5608,180.7208,0,3); //
AddStaticVehicle(480,-814.3839,1818.5692,6.7894,279.7219,0,93); //
AddStaticVehicle(461,-2085.4297,1432.8958,6.6741,149.6292,43,1); //
AddStaticVehicle(522,-2087.0364,1433.0127,6.6733,146.0660,39,106); //
AddStaticVehicle(443,-2068.3770,1426.5850,7.6856,181.1665,1,1); //
AddStaticVehicle(604,-2680.1716,868.0626,76.1181,356.4536,0,0); //
AddStaticVehicle(411,2015.1248,2262.7341,23.6263,131.1014,126,126); //
AddStaticVehicle(522,2058.0649,2368.0447,150.0381,182.8209,0,3); //
AddStaticVehicle(541,2427.0852,2225.7324,18.6146,270.0598,3,1); //
AddStaticVehicle(522,2976.2195,2531.1353,19.5407,173.0914,126,1); //
AddStaticVehicle(559,-2660.7454,236.2152,4.0072,90.8213,3,3); //
AddStaticVehicle(560,-2690.5083,236.2442,4.0025,178.8479,0,0); //
AddStaticVehicle(522,-2789.8513,319.7009,4.0784,269.2494,0,86); //
AddStaticVehicle(429,-2769.1343,325.1485,4.0787,178.4848,6,3); //
AddStaticVehicle(494,-2753.9983,368.6707,4.0810,180.7830,36,117); //
AddStaticVehicle(415,-2714.1938,403.6179,4.1011,0.5519,75,1); //
AddStaticVehicle(603,-2698.7385,404.0229,4.2236,0.5883,69,1); //
AddStaticVehicle(429,-2666.9529,427.3833,3.9912,177.8504,1,3); //
AddStaticVehicle(451,-2658.2878,376.1750,3.9487,358.4549,0,0); //
AddStaticVehicle(522,-2584.3008,441.1953,32.2705,177.2594,0,3); //
AddStaticVehicle(576,-2516.3784,329.6273,27.2856,68.7090,72,1); //
AddStaticVehicle(404,-2508.6633,332.8490,34.7760,65.5807,123,92); //
AddStaticVehicle(568,-2626.7546,-55.7891,4.1348,358.9463,17,1); //
AddStaticVehicle(568,-2630.1685,-55.5916,4.1306,358.5558,9,39); //
AddStaticVehicle(535,-2636.7893,-55.0658,4.1188,359.7391,3,1); //
AddStaticVehicle(477,-2646.8333,-54.7022,4.1300,0.7783,121,1); //
AddStaticVehicle(415,-2650.3013,-55.1704,4.0744,1.1634,20,1); //
AddStaticVehicle(451,-2656.7375,-55.0452,4.0626,0.0884,46,46); //
AddStaticVehicle(402,-2660.2217,-55.1658,4.1121,357.0700,13,13); //
AddStaticVehicle(541,-2663.6123,-55.5668,3.9745,0.0030,0,2); //
AddStaticVehicle(587,-2673.1565,-55.2842,4.0677,358.8630,43,1); //
AddStaticVehicle(587,-2676.5906,-55.2693,4.0678,358.6793,40,1); //
AddStaticVehicle(603,-2686.2961,-22.2144,4.1918,179.5374,32,1); //
AddStaticVehicle(409,-2676.2100,-23.5065,4.2005,179.7514,1,1); //
AddStaticVehicle(522,-2663.4492,-34.1647,3.8765,175.1819,1,1); //
AddStaticVehicle(581,-2633.2869,-35.2052,3.9263,180.7736,66,1); //
AddStaticVehicle(603,-2630.4282,-35.3955,4.0852,179.3312,45,45); //
AddStaticVehicle(522,-2681.3896,1933.9219,216.8426,179.2175,144,157); //
AddStaticVehicle(451,-2388.2983,2216.0610,4.6846,89.0034,157,157); //
AddStaticVehicle(411,1632.8427,-1339.8291,17.1376,89.6780,151,151); //
AddStaticVehicle(411,1632.8298,-1352.2388,17.1513,88.5716,151,151); //
AddStaticVehicle(470,220.48869324,1920.82531738,17.70063782,181.00000000,-1,-1); //Patriot
AddStaticVehicle(470,211.61337280,1920.85192871,17.70063782,179.99694824,-1,-1); //Patriot
AddStaticVehicle(470,202.49136353,1920.77795410,17.70063782,181.74694824,-1,-1); //Patriot
AddStaticVehicle(470,193.33993530,1920.85351562,17.70063782,180.99694824,-1,-1); //Patriot
AddStaticVehicle(425,205.36523438,1931.38537598,24.04318810,90.25000000,-1,-1); //Hunter
AddStaticVehicle(433,280.48394775,1821.47534180,18.21062469,90.00000000,-1,-1); //Barracks
AddStaticVehicle(476,315.55526733,2054.73193359,18.81077766,179.50000000,65,-1); //Rustler
AddStaticVehicle(476,301.10757446,2054.79638672,18.73577881,179.49462891,65,-1); //Rustler
AddStaticVehicle(433,271.66564941,2032.82897949,18.21062469,271.50000000,-1,-1); //Barracks
AddStaticVehicle(433,271.68402100,2023.59667969,18.21062469,271.49963379,-1,-1); //Barracks
AddStaticVehicle(433,271.72467041,2015.23962402,18.21062469,271.49963379,-1,-1); //Barracks
AddStaticVehicle(433,271.68826294,1997.82629395,18.21062469,271.99963379,-1,-1); //Barracks
AddStaticVehicle(433,271.65435791,1989.23742676,18.21062469,271.49963379,-1,-1); //Barracks
AddStaticVehicle(433,271.58743286,1980.94738770,18.21062469,271.49963379,-1,-1); //Barracks
AddStaticVehicle(433,271.70379639,1963.37365723,18.21062469,271.49963379,-1,-1); //Barracks
AddStaticVehicle(433,271.66836548,1955.10021973,18.21062469,271.49963379,-1,-1); //Barracks
AddStaticVehicle(433,271.69076538,1946.86608887,18.21062469,271.49963379,-1,-1); //Barracks
AddStaticVehicle(470,143.75221252,1932.22192383,19.27565956,180.99426270,-1,-1); //Patriot
AddStaticVehicle(470,137.92655945,1932.24816895,19.27565956,180.99426270,-1,-1); //Patriot
AddStaticVehicle(470,132.07794189,1932.18298340,19.27565956,180.99426270,-1,-1); //Patriot
AddStaticVehicle(470,126.84346008,1932.09057617,19.27565956,180.99426270,-1,-1); //Patriot
AddStaticVehicle(407,1769.95141602,2078.18041992,11.19031239,179.75000000,3,1); //Firetruck
AddStaticVehicle(407,1763.45349121,2078.34692383,11.19031239,179.74731445,3,1); //Firetruck
AddStaticVehicle(544,1757.00085449,2074.61621094,11.19031239,179.00000000,3,1); //Firetruck LA
AddStaticVehicle(544,1750.65222168,2074.63452148,11.19031239,178.99475098,3,1); //Firetruck LA
Elegy2 = AddStaticVehicle(562,2737.5215,-1760.1002,43.7681,245.4829,1,1); //
ChangeVehiclePaintjob(Elegy2,2);
//=====================================Hq Car===================================
Hq(AddStaticVehicle(522,2665.3999,1631.8151,10.3824,0.0000,65,0)); // NRG-500 - Hq JaS
Hq(AddStaticVehicle(520,2646.89990234,1771.40002441,19.60000038,0.00000000,-1,-1)); //Hydra - Hq JaS
Hq(AddStaticVehicle(487,2644.89990234,1913.30004883,19.10000038,89.25000000,65,1)); //Maverick - Hq JaS
Hq(AddStaticVehicle(425,2647.00000000,1885.90002441,19.70000076,359.75000000,65,65)); //Hunter - Hq JaS
Hq(AddStaticVehicle(522,2529.69995117,1806.09997559,10.60000038,90.00000000,65,1)); //NRG-500 - Hq JaS
Hq(AddStaticVehicle(522,2529.60009766,1840.40002441,10.60000038,90.00000000,65,0)); //NRG-500 - Hq JaS
Hq(AddStaticVehicle(451,2603.00000000,1786.30004883,10.60000038,90.25000000,65,1)); //Turismo - Hq JaS
Hq(AddStaticVehicle(429,2602.80004883,1802.30004883,10.60000038,90.00000000,65,1)); //Banshee - Hq JaS
Hq(AddStaticVehicle(541,2591.89990234,1811.90002441,10.39999962,270.50000000,1,65)); //Bullet - Hq JaS
Hq(AddStaticVehicle(560,2591.80004883,1795.90002441,10.60000038,270.50000000,65,65)); //Sultan - Hq JaS
Hq(AddStaticVehicle(411,2591.89990234,1840.19995117,10.60000038,269.75000000,65,65)); //Infernus - Hq JaS
Hq(AddStaticVehicle(475,2592.00000000,1859.40002441,10.69999981,270.25000000,65,1)); //Sabre - Hq JaS
Hq(AddStaticVehicle(549,2602.69995117,1843.40002441,10.69999981,90.25000000,1,65)); //Tampa - Hq JaS
Hq(AddStaticVehicle(437,2573.30004883,1894.80004883,11.10000038,178.25000000,65,65)); //Coach - Hq JaS
//==============================================================================
VipHq = CreateObject(980,1130.1999500,-1424.5999800,17.6000000,0.0000000,0.0000000,0.0000000); //object(airportgate) (1)
//==============================================================================
Hq(AddStaticVehicle(451,1100.9000200,-1481.1999500,15.6000000,268.0000000,32,32)); //Turismo
Hq(AddStaticVehicle(451,1100.9000200,-1478.4000200,15.6000000,267.9950000,32,32)); //Turismo
Hq(AddStaticVehicle(451,1100.9000200,-1475.4000200,15.6000000,267.9950000,32,32)); //Turismo
Hq(AddStaticVehicle(411,1105.0000000,-1451.6999500,15.6000000,270.0000000,114,42)); //Infernus
Hq(AddStaticVehicle(411,1105.0000000,-1456.4000200,15.6000000,272.0000000,114,42)); //Infernus
Hq(AddStaticVehicle(411,1104.8000500,-1460.5999800,15.6000000,270.0000000,114,42)); //Infernus
Hq(AddStaticVehicle(437,1118.0999800,-1487.6999500,16.0000000,0.0000000,57,90)); //Coach
Hq(AddStaticVehicle(437,1139.6999500,-1487.6999500,16.0000000,0.0000000,57,90)); //Coach
Hq(AddStaticVehicle(520,1079.4000200,-1477.0000000,30.8000000,0.0000000,-1,-1)); //Hydra
Hq(AddStaticVehicle(520,1080.9000200,-1451.0000000,30.8000000,0.0000000,-1,-1)); //Hydra
Hq(AddStaticVehicle(520,1175.0999800,-1444.8000500,30.8000000,0.0000000,-1,-1)); //Hydra
Hq(AddStaticVehicle(520,1175.0999800,-1466.8000500,30.8000000,0.0000000,-1,-1)); //Hydra
Hq(AddStaticVehicle(451,1162.1999500,-1492.8000500,15.3000000,90.0000000,32,32)); //Turismo
Hq(AddStaticVehicle(451,1162.1999500,-1488.0000000,15.3000000,90.0000000,32,32)); //Turismo
Hq(AddStaticVehicle(522,1158.5000000,-1478.5999800,15.5000000,100.0000000,76,117)); //NRG-500
Hq(AddStaticVehicle(522,1157.5000000,-1476.0999800,15.5000000,99.9980000,76,117)); //NRG-500
Hq(AddStaticVehicle(522,1156.5000000,-1473.8000500,15.5000000,99.9980000,76,117)); //NRG-500
Hq(AddStaticVehicle(522,1155.8000500,-1471.3000500,15.5000000,99.9980000,76,117)); //NRG-500
Hq(AddStaticVehicle(522,1155.0000000,-1468.8000500,15.5000000,99.9980000,76,117)); //NRG-500
Hq(AddStaticVehicle(522,1154.3000500,-1466.5000000,15.5000000,99.9980000,76,117)); //NRG-500
Hq(AddStaticVehicle(522,1153.8000500,-1464.3000500,15.5000000,99.9980000,76,117)); //NRG-500
//==============================================================================Survivel
SCar[0] = AddStaticVehicle(522,1363.4000200,2697.6001000,10.5000000,178.0000000,132,4); //NRG-500
SCar[1] = AddStaticVehicle(522,1358.4000200,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[2] = AddStaticVehicle(522,1352.5999800,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[3] = AddStaticVehicle(522,1347.3000500,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[4] = AddStaticVehicle(522,1341.8000500,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[5] = AddStaticVehicle(522,1336.0000000,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[6] = AddStaticVehicle(522,1329.5000000,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[7] = AddStaticVehicle(522,1324.5000000,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[8] = AddStaticVehicle(522,1319.5000000,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[9] = AddStaticVehicle(522,1314.5000000,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[10] = AddStaticVehicle(522,1308.5000000,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[11] = AddStaticVehicle(522,1303.5000000,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[12] = AddStaticVehicle(522,1298.0000000,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[13] = AddStaticVehicle(522,1292.3000500,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[14] = AddStaticVehicle(522,1285.8000500,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[15] = AddStaticVehicle(522,1281.0000000,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[16] = AddStaticVehicle(522,1276.3000500,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[17] = AddStaticVehicle(522,1270.3000500,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[18] = AddStaticVehicle(522,1265.5000000,2697.6001000,10.5000000,177.9950000,132,4); //NRG-500
SCar[19] = AddStaticVehicle(522,1363.9000200,2646.6999500,10.5000000,357.9950000,132,4); //NRG-500
SCar[20] = AddStaticVehicle(522,1358.1999500,2646.6999500,10.5000000,357.9950000,132,4); //NRG-500
SCar[21] = AddStaticVehicle(522,1352.9000200,2646.6999500,10.5000000,357.9900000,132,4); //NRG-500
SCar[22] = AddStaticVehicle(522,1346.9000200,2646.6999500,10.5000000,357.9900000,132,4); //NRG-500
SCar[23] = AddStaticVehicle(522,1341.4000200,2646.6999500,10.5000000,357.9900000,132,4); //NRG-500
SCar[24] = AddStaticVehicle(522,1335.5999800,2646.6999500,10.5000000,357.9900000,132,4); //NRG-500
SCar[25] = AddStaticVehicle(522,1330.3000500,2646.6999500,10.5000000,357.9900000,132,4); //NRG-500
SCar[26] = AddStaticVehicle(522,1325.0000000,2646.6999500,10.5000000,357.9900000,132,4); //NRG-500
SCar[27] = AddStaticVehicle(522,1319.3000500,2646.6999500,10.5000000,357.9900000,132,4); //NRG-500
SCar[28] = AddStaticVehicle(522,1312.5000000,2646.6999500,10.5000000,357.9900000,132,4); //NRG-500
SCar[29] = AddStaticVehicle(522,1308.0000000,2646.6999500,10.5000000,357.9900000,132,4); //NRG-500
SCar[30] = AddStaticVehicle(522,1302.3000500,2646.6999500,10.5000000,357.9900000,132,4); //NRG-500
SCar[31] = AddStaticVehicle(411,1296.5000000,2647.0000000,10.6000000,0.0000000,16,80); //Infernus
SCar[32] = AddStaticVehicle(411,1291.5000000,2647.0000000,10.6000000,0.0000000,16,80); //Infernus
SCar[33] = AddStaticVehicle(411,1285.8000500,2647.0000000,10.6000000,0.0000000,16,80); //Infernus
SCar[34] = AddStaticVehicle(411,1280.0999800,2647.0000000,10.6000000,0.0000000,16,80); //Infernus
SCar[35] = AddStaticVehicle(411,1275.3000500,2647.0000000,10.6000000,0.0000000,16,80); //Infernus
SCar[36] = AddStaticVehicle(411,1270.5000000,2647.0000000,10.6000000,0.0000000,16,80); //Infernus
SCar[37] = AddStaticVehicle(411,1265.5000000,2647.0000000,10.6000000,0.0000000,16,80); //Infernus
for(new vid = SCar[0]; vid < SCar[37]; vid++)
{
SetVehicleVirtualWorld(vid, 55);
}
//==============================================================================
Hqq = CreateObject(980,2798.0000000,1312.9000244,12.6999998,0.0000000,0.0000000,270.0000000); //object(airportgate) (1)
Hqq1 = CreateObject(980,2842.5000000,1290.9000244,13.1999998,0.0000000,0.0000000,92.0000000); //object(airportgate) (2)
//------------------------------------------------------------------------------
Hq(AddStaticVehicle(451,2804.0000000,1364.5000000,10.5000000,270.0000000,137,0)); //Turismo
Hq(AddStaticVehicle(411,2804.1999500,1367.6999500,10.5000000,269.9950000,137,0)); //Infernus
Hq(AddStaticVehicle(522,2804.3000500,1361.1999500,10.4000000,272.0000000,137,0)); //NRG-500
Hq(AddStaticVehicle(571,2803.8000500,1358.3000500,10.1000000,270.0000000,137,0)); //Kart
Hq(AddStaticVehicle(444,2804.6001000,1354.9000200,10.9000000,270.0000000,137,0)); //Monster
Hq(AddStaticVehicle(541,2803.8999000,1351.5999800,10.5000000,268.0000000,137,0)); //Bullet
Hq(AddStaticVehicle(560,2804.1999500,1348.5000000,10.6000000,268.0000000,137,0)); //Sultan
Hq(AddStaticVehicle(402,2804.1999500,1345.1999500,10.7000000,270.0000000,137,0)); //Buffalo
Hq(AddStaticVehicle(429,2804.3999000,1342.0999800,10.5000000,270.0000000,137,0)); //Banshee
Hq(AddStaticVehicle(490,2804.5000000,1338.9000200,10.8000000,270.0000000,137,0)); //FBI Rancher
Hq(AddStaticVehicle(495,2804.1999500,1335.8000500,11.3000000,268.0000000,137,0)); //Sandking
Hq(AddStaticVehicle(603,2804.0000000,1332.5999800,10.8000000,270.0000000,137,0)); //Phoenix
Hq(AddStaticVehicle(494,2804.3000500,1329.4000200,10.7000000,270.0000000,137,0)); //Hotring
Hq(AddStaticVehicle(406,2806.0000000,1375.0999800,11.8000000,272.0000000,137,0)); //Dumper
Hq(AddStaticVehicle(567,2804.1999500,1326.0000000,10.7000000,272.0000000,137,0)); //Savanna
Hq(AddStaticVehicle(520,2848.3999000,1369.0999800,14.1000000,0.0000000,137,0)); //Hydra
Hq(AddStaticVehicle(425,2835.3999000,1361.1999500,14.1000000,0.0000000,137,0)); //Hunter
//==============================================================================
HqAviran[0] = CreateDynamicObject(980,1447.1999500,663.0000000,12.4000000,0.0000000,0.0000000,0.0000000); //object(airportgate) (1)
HqAviran[1] = CreateDynamicObject(974,1533.9000200,744.2999900,12.1000000,0.0000000,0.0000000,0.0000000); //object(tall_fence) (2)
HqAviran[2] = CreateDynamicObject(2669,1515.8000500,773.2999900,11.1000000,0.0000000,0.0000000,178.0000000); //object(cj_chris_crate) (1)
//------------------------------------------------------------------------------
Hq(AddStaticVehicle(451,1412.0999800,716.2999900,10.6000000,270.0000000,145,115)); //Turismo
Hq(AddStaticVehicle(451,1412.0999800,719.5000000,10.6000000,270.0000000,145,115)); //Turismo
Hq(AddStaticVehicle(451,1412.3000500,713.0000000,10.6000000,270.0000000,145,115)); //Turismo
Hq(AddStaticVehicle(411,1413.4000200,707.5999800,10.6000000,270.0000000,114,42)); //Infernus
Hq(AddStaticVehicle(411,1413.4000200,703.2999900,10.6000000,270.0000000,114,42)); //Infernus
Hq(AddStaticVehicle(411,1413.4000200,698.7999900,10.6000000,270.0000000,114,42)); //Infernus
Hq(AddStaticVehicle(522,1413.0000000,692.2000100,10.5000000,270.0000000,132,4)); //NRG-500
Hq(AddStaticVehicle(522,1413.0000000,688.9000200,10.5000000,270.0000000,132,4)); //NRG-500
Hq(AddStaticVehicle(522,1413.0000000,685.9000200,10.5000000,270.0000000,132,4)); //NRG-500
Hq(AddStaticVehicle(522,1413.0000000,682.9000200,10.5000000,270.0000000,132,4)); //NRG-500
Hq(AddStaticVehicle(481,1412.6999500,676.5000000,10.4000000,274.0000000,157,152)); //BMX
Hq(AddStaticVehicle(481,1412.6999500,673.0000000,10.4000000,273.9990000,157,152)); //BMX
Hq(AddStaticVehicle(481,1412.6999500,679.5000000,10.4000000,273.9990000,157,152)); //BMX
Hq(AddStaticVehicle(520,1419.4000200,776.0000000,46.7000000,0.0000000,-1,-1)); //Hydra
Hq(AddStaticVehicle(520,1537.4000200,777.0000000,46.7000000,0.0000000,-1,-1)); //Hydra
Hq(AddStaticVehicle(425,1462.1999500,798.7999900,47.2000000,0.0000000,95,10)); //Hunter
Hq(AddStaticVehicle(425,1486.8000500,798.7999900,47.2000000,0.0000000,95,10)); //Hunter
Hq(AddStaticVehicle(425,1512.0999800,798.7999900,47.2000000,0.0000000,95,10)); //Hunter
Hq(AddStaticVehicle(541,1413.9000200,743.2000100,10.5000000,270.0000000,42,119)); //Bullet
Hq(AddStaticVehicle(541,1413.9000200,746.4000200,10.5000000,270.0000000,42,119)); //Bullet
Hq(AddStaticVehicle(541,1413.9000200,749.5999800,10.5000000,270.0000000,42,119)); //Bullet
Hq(AddStaticVehicle(556,1550.5000000,692.2000100,11.3000000,90.0000000,245,245)); //Monster A
Hq(AddStaticVehicle(556,1550.5000000,696.9000200,11.3000000,90.0000000,245,245)); //Monster A
Hq(AddStaticVehicle(560,1452.0999800,787.7000100,10.6000000,180.0000000,251,254)); //Sultan
Hq(AddStaticVehicle(560,1457.0000000,787.7000100,10.6000000,180.0000000,255,254)); //Sultan
Hq(AddStaticVehicle(560,1464.5000000,787.7000100,10.6000000,180.0000000,255,254)); //Sultan
Hq(AddStaticVehicle(560,1472.0000000,787.7000100,10.6000000,180.0000000,255,254)); //Sultan
Hq(AddStaticVehicle(560,1477.5000000,787.7000100,10.6000000,180.0000000,255,254)); //Sultan
//================================= [Hq 4] =====================================
HqCpT[0] = CreateDynamicObject(980,2316.6001000,2402.8999000,12.4000000,0.0000000,0.0000000,0.0000000); //object(airportgate) (1)
HqCpT[2] = CreateDynamicObject(16409,2377.6001000,2324.1001000,7.2000000,0.0000000,0.0000000,90.0000000); //object(by_weehangr) (1)
HqCpT[1] = CreateDynamicObject(972,2365.3999000,2259.1999500,25.5000000,0.0000000,0.0000000,0.0000000); //object(tunnelentrance) (1)
//------------------------------------------------------------------------------
Hq(AddStaticVehicle(425,2393.1001000,2268.8000500,30.8000000,0.0000000,95,10)); //Hunter
Hq(AddStaticVehicle(425,2356.0000000,2289.6999500,30.8000000,0.0000000,95,10)); //Hunter
Hq(AddStaticVehicle(520,2372.8999000,2377.6001000,28.8000000,270.0000000,-1,-1)); //Hydra
Hq(AddStaticVehicle(447,2399.3999000,2372.1001000,28.0000000,270.0000000,32,32)); //Seasparrow
Hq(AddStaticVehicle(447,2399.3999000,2386.8000500,28.0000000,270.0000000,32,32)); //Seasparrow
Hq(AddStaticVehicle(451,2406.1001000,2345.8000500,10.6000000,90.0000000,123,10)); //Turismo
Hq(AddStaticVehicle(451,2397.3000500,2345.8000500,10.6000000,90.0000000,123,10)); //Turismo
Hq(AddStaticVehicle(451,2388.3000500,2345.8000500,10.6000000,90.0000000,123,10)); //Turismo
Hq(AddStaticVehicle(411,2377.8999000,2346.3999000,10.6000000,88.0000000,114,42)); //Infernus
Hq(AddStaticVehicle(411,2369.8999000,2346.8999000,10.6000000,87.9950000,114,42)); //Infernus
Hq(AddStaticVehicle(411,2359.8999000,2347.1001000,10.6000000,87.9950000,114,42)); //Infernus
Hq(AddStaticVehicle(560,2400.0000000,2358.5000000,10.6000000,90.0000000,118,123)); //Sultan
Hq(AddStaticVehicle(560,2390.8000500,2358.5000000,10.6000000,90.0000000,118,123)); //Sultan
Hq(AddStaticVehicle(560,2382.5000000,2358.5000000,10.6000000,90.0000000,118,123)); //Sultan
Hq(AddStaticVehicle(560,2373.5000000,2358.5000000,10.6000000,90.0000000,118,123)); //Sultan
Hq(AddStaticVehicle(437,2312.1001000,2296.1001000,11.1000000,0.0000000,14,49)); //Coach
Hq(AddStaticVehicle(437,2321.6001000,2296.1001000,11.1000000,0.0000000,14,49)); //Coach
Hq(AddStaticVehicle(409,2321.0000000,2378.1001000,10.7000000,0.0000000,245,245)); //Stretch
Hq(AddStaticVehicle(409,2312.5000000,2378.1001000,10.7000000,0.0000000,245,245)); //Stretch
Hq(AddStaticVehicle(541,2321.8999000,2250.8999000,10.5000000,0.0000000,156,156)); //Bullet
Hq(AddStaticVehicle(541,2312.3999000,2250.8999000,10.5000000,0.0000000,156,156)); //Bullet
Hq(AddStaticVehicle(495,2312.3999000,2262.1999500,11.4000000,0.0000000,98,68)); //Sandking
Hq(AddStaticVehicle(495,2321.3999000,2262.1999500,11.4000000,0.0000000,98,68)); //Sandking
//==============================================================================
SultanA = AddStaticVehicle(560,1043.5781,1012.5724,55.0222,314.8542,1,1);//Aviran
ChangeVehiclePaintjob(SultanA,1);
Special(AddStaticVehicle(451,-2091.2830,2313.9182,25.5689,108.8531,1,1)); // Speen
//==============================================================================
//==============================================================================
return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
SetPlayerPos(playerid,2005.6895,1668.7119,12.6697); // ����� �����
SetPlayerFacingAngle(playerid, 249.1138); // ����� �� �����
SetPlayerCameraPos(playerid,2017.8354,1668.3250,17.1633); // ����� ������
SetPlayerCameraLookAt(playerid,2005.6895,1668.7119,12.6697); // ����� ������� �����
SetPlayerTime(playerid,00,0); // ���� �� ���� ���� ����� ����� ����� ������
return 1;
}
public OnPlayerRequestSpawn(playerid)
{
     if(IsPlayerNPC(playerid)) return 1;
	if(!Logged[playerid]) return SendClientMessage(playerid, red, "�����, �� ��� ���� ������ �� ��� ������ �������");
   return 1;
}
public OnPlayerConnect(playerid)
{
ResetIgnoreList(playerid);
if(InClan(playerid)){
new file[256];
format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
format(String,sizeof(String),"Clan Message: %s",DOF2_GetString(file,"Msg"));
}
SetPVarInt(playerid,"TDStats",0);
GetPlayerName(playerid, GetAName[playerid] ,MAX_PLAYER_NAME);
SetPVarInt(playerid, "Skin",-1),SetPVarInt(playerid,"ASpam",0),SetPVarInt(playerid,"ReturnPM",-1);
if(DOF2_GetInt(SFile(playerid),"Spy") == 1){ SpySystem[playerid] = 1; }
UseBomb[playerid] = 0;
InGunGame[playerid] = 0;
InWeapons[playerid] = 0;
HelpPlz[playerid] = 0;
NeedHelp[playerid] = 0;
pDrunkLevelLast[playerid] = 0;
pFPS[playerid] = 0;
TextDrawShowForPlayer(playerid, gText);

new Text:PlayerN[MAX_PLAYERS];
new name[MAX_PLAYER_NAME];
GetPlayerName(playerid,name,MAX_PLAYER_NAME);
PlayerN[playerid] = TextDrawCreate(115,416,name);
TextDrawSetOutline(PlayerN[playerid],1);
TextDrawColor(PlayerN[playerid],0xFFFFFFff);
TextDrawFont(PlayerN[playerid],1);
TextDrawSetString(PlayerN[playerid], name);
TextDrawShowForPlayer(playerid, PlayerN[playerid]);

Textdraw1[playerid] = TextDrawCreate(180.000000, 410.000000, "LEVEL: 1  KILLS: 1/10  NEXTLEVEL: 2");
TextDrawBackgroundColor(Textdraw1[playerid], 255);
TextDrawFont(Textdraw1[playerid], 3);
TextDrawLetterSize(Textdraw1[playerid], 0.500000, 2.100000);
TextDrawColor(Textdraw1[playerid], -1);
TextDrawSetOutline(Textdraw1[playerid], 0);
TextDrawSetProportional(Textdraw1[playerid], 1);
TextDrawSetShadow(Textdraw1[playerid], 1);
TextDrawSetSelectable(Textdraw1[playerid], 0);

TextDrawShowForPlayer(playerid, Textdraw0);
BlockPm[playerid] = 0;
BlockChat[playerid] = 0;
InCall[playerid] = 0;
IsDead[playerid] = 0;
IsCalling[playerid] = 0;
TallkingID[playerid] = -1;
IsKick[playerid] = 0;
new playerip[16];
new string[256];
   if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None",true))
   {
	SetPlayerColor(playerid, PlayerColors[random(200)]);
   }
 GetPlayerIp(playerid, playerip, 16);
SendClientMessage(playerid, COLOR_WHITE, "{00C8C8}Welcome to DeathMatch{00C8C8}, Mode Version: {FFFFFF}"Version"{00C8C8} By YUVAL HILAI � {FFFFFF}SINCE 2011");
if(!DOF2_FileExists(SFile(playerid))) return SendFormatMessage(playerid, COLOR_SATLA, "! %s ���� ���",GetName(playerid)),format(string, sizeof(string), "{FF6600}%s {FFFFFF}���� ��\n\n�� �� ������ ������ ���� ���� ����\n:�� ��� ������ ���� ��� ���� �� ������ �������", GetName(playerid)),ShowPlayerDialog(playerid, 0, DIALOG_STYLE_PASSWORD,"{FF0000}���� ����", string, "����", "��"),BlockChat[playerid] = 1;
else if(DOF2_FileExists(SFile(playerid)) && DOF2_GetInt(SFile(playerid),"AutoLogin") == 1 && !strcmp(DOF2_GetString(SFile(playerid),"IP"),playerip,true)) return format(string, sizeof(string),"{FFFFFF}! %s ���� ����\n\n{083F6F}������ �������� ��� ����� ������ ���", GetName(playerid)),ShowPlayerDialog(playerid, 20, DIALOG_STYLE_MSGBOX, "������� ��������", string, "�����", ""),Logged[playerid] = 2,SendFormatMessageToAll(0x00FF00FF, "����� ���� %s �����", GetName(playerid));
//TDM===========

TextDrawHideForPlayer(playerid, CopsPoints);
TextDrawHideForPlayer(playerid, GangPoints);

//====Mini Activity====
InMini[playerid] = 0;
InWar[playerid] = 0;
InMonster[playerid] = 0;
InSwar[playerid] = 0;
InTanks[playerid] = 0;
InBoom[playerid] =0;
Danced[playerid] = 0;
Stoned[playerid] = 0;
Autonitro[playerid] = 0;
Autojump[playerid] = 0;
Autopjump[playerid] = 0;
InTDM[playerid] = 0;
InTeamA[playerid] = 0;
InTeamB[playerid] = 0;
InDM[playerid] = 0;
InSawn[playerid] = 0;
ClanInvite[playerid] = 0;
SeeBomb[playerid] = 0;
SeePm[playerid] = 0;
SeeLp[playerid] = 0;
SeeDisconnect[playerid] = 0;
new string2[256];
format(string2, sizeof(string2), "MaxPlayersRecord.ini");
if(!DOF2_FileExists("MaxPlayersRecord.ini"))
{
DOF2_CreateFile(string2);
return 1;
}
if(DOF2_IsSet(SFile(playerid),"ConnectMsg"))
{
DOF2_Unset(SFile(playerid),"ConnectMsg");
}
return 1;
}


public OnPlayerDisconnect(playerid, reason)
{
new Reason[256];
switch(reason) { case 0: Reason = "Timed Out"; case 1: Reason = "Leaving"; case 2: Reason = "Kick/Ban"; }
format(SString,256,"%s has left the server (%s) [IP: %s].",GetName(playerid),Reason,GetIP(playerid));
SendMessageDisconnectAdmin(grey,SString);

if(battle[playerid][InviteAnyOne] == 1)
{
new ID = battle[playerid][IDJoin];
battle[ID][InviteMe] = 0;
battle[playerid][InviteAnyOne] = 0;
battle[ID][MoneyBattle] = 0;
battle[playerid][MoneyBattle] = 0;
format(String, sizeof(String), "[Battle] >> .��� ����� ���� ����� ���� ������ ''%s'' �����", GetName(playerid));
SendClientMessage(id,COLOR_ORANGE,String);
}
if(InSwar[playerid] == 1)
{
SwarPlayers --;
InSwar[playerid] = 0;
SendClientMessageToAll(COLOR_LIGHTBLUEGREEN,"/Swar - ����� ��� ���� �������, ���� ������ ���/�");
return 1;
}
else if(InSwar[playerid] >= 2)
{
SwarPlayers --;
InSwar[playerid] = 0;
CallRemoteFunction("CheckPlayers","i",SwarPlayers);
DestroyVehicle(Swar[playerid]);
return 1;
}
if(battle[playerid][InBattle]) PlayerLozzeBattle(playerid);
Autopjump[playerid] = 0;
DOF2_SaveFile();
DOF2_Exit();
if(HaveReplace[playerid][Inviter] == 1){
IdInvite = HaveReplace[playerid][IDInviter1];
SendFormatMessage(IdInvite,yellow,"����� ����� ��� ������ ����� %s",GetName(playerid));
HaveReplace[playerid][Inviter] = 0;}
if(	HaveReplace[playerid][Invite] == 1){
IdInvite = HaveReplace[playerid][IDInviter];
SendFormatMessage(IdInvite,yellow,"����� ����� ��� ������ ����� %s",GetName(playerid));
HaveReplace[playerid][Invite] = 0;
HaveReplace[playerid][Money] = 0;}
if(InCall[playerid] && !Tallking[playerid] && IsCalling[playerid]) KillTimer(EndTimer[TallkingID[playerid]]);
if(InCall[playerid] && !Tallking[playerid] && !IsCalling[playerid]) KillTimer(EndTimer[playerid]);
if(Tallking[playerid] == 1 && TallkingID[playerid] > -1 && IsPlayerConnected(TallkingID[playerid]) && Tallking[TallkingID[playerid]] == 1)
{
SendFormatMessage(TallkingID[playerid],ORANGE,".��� ����� ���� ������ ������� \"%s\" �����",GetName(playerid));
EndCall(TallkingID[playerid],playerid,3);
}
if(InMini[playerid] == 1) InMini[playerid] = 0,MiniPlayers --;
if(InWar[playerid] == 1) InWar[playerid] = 0,WarPlayers --;
if(InMonster[playerid] == 1) InMonster[playerid] = 0,MonsterPlayers --;
if(InTanks[playerid] == 1) InTanks[playerid] = 0,TanksPlayers --;
if(InBoom[playerid] == 1) InBoom[playerid] = 0,BoomPlayers --;
if(InWeapons[playerid] == 1) return WeaponsPlayers--,InWeapons[playerid] = 0;
SetPlayerTeam(playerid,playerid);
return 1;
}
AntiDeAMX(){
new a[][] =
{
"Unarmed (Fist)",
"Brass K"
};
#pragma unused a
}


public OnPlayerSpawn(playerid)
{
if(IsPlayerNPC(playerid)) return SetPlayerPos(playerid,853.5230,-2109.8289,8.2422),SetPlayerFacingAngle(playerid,91.1675),SetPlayerVirtualWorld(playerid,25),SetPlayerSkin(playerid,179),TogglePlayerControllable(playerid,0);
SetPlayerTime(playerid,12,0);
//TextDrawShowForPlayer(playerid, Logo);
TextDrawShowForPlayer(playerid,txtTimeDisp);
if(IsDead[playerid] == 1 && InCall[playerid] == 1 && Tallking[playerid] == 1) IsDead[playerid] = 0;
GangZoneShowForPlayer(playerid, Honor, 0xFFFF0096);
GangZoneShowForPlayer(playerid, Vip, 0x16EB43FF);
AntiDeAMX();
   if(strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None",true))
   {
   new r = DOF2_GetInt(GetClanFile(DOF2_GetString(SFile(playerid),"Clan")),"R");
   new g = DOF2_GetInt(GetClanFile(DOF2_GetString(SFile(playerid),"Clan")),"G");
   new b = DOF2_GetInt(GetClanFile(DOF2_GetString(SFile(playerid),"Clan")),"B");
   if(r != -1 && g != -1 && b != -1)SetPlayerColor(playerid,rgba2hex(r,g,b,100));
   new file[256];
   format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
   }
//==============================================================================
if(InGunGame[playerid] == 1){
GunGameSpawn1[playerid] = SetTimerEx("GunGameSpawn", 2, 0, "d", playerid);
GunGameWeapon1[playerid] = SetTimerEx("GunGameWeapon", 2, 0, "d", playerid);}

if (InTeamA[playerid] == 1)
{
new rand = random(sizeof(TDMCopsSpawn));
SetPlayerPos(playerid,TDMCopsSpawn[rand][0],TDMCopsSpawn[rand][1],TDMCopsSpawn[rand][2]);
SetPlayerHealth(playerid, 100),SetPlayerArmour(playerid, 100.00),ResetPlayerWeapons(playerid);
TogglePlayerControllable(playerid, 0);
SetTimerEx("UnFreeze11",700,0,"i",playerid);
new rand2 = random(sizeof(TDMCopsSkin));
SetPlayerSkin(playerid,TDMCopsSkin[rand2]);
GivePlayerWeapon(playerid,24,1000);
GivePlayerWeapon(playerid,27,1000);
GivePlayerWeapon(playerid,31,1000);
GivePlayerWeapon(playerid,29,1000);
GivePlayerWeapon(playerid,34,1000);
GivePlayerWeapon(playerid,16,3);
return 1; }
if (InTeamB[playerid] == 1)
{
new rand = random(sizeof(TDMGangSpawn));
SetPlayerPos(playerid,TDMGangSpawn[rand][0],TDMGangSpawn[rand][1],TDMGangSpawn[rand][2]);
SetPlayerHealth(playerid, 100),SetPlayerArmour(playerid, 100.00),ResetPlayerWeapons(playerid);
TogglePlayerControllable(playerid, 0);
SetTimerEx("UnFreeze11",700,0,"i",playerid);
new rand2 = random(sizeof(TDMGangSkin));
SetPlayerSkin(playerid,TDMGangSkin[rand2]);
GivePlayerWeapon(playerid,24,1000);
GivePlayerWeapon(playerid,25,1000);
GivePlayerWeapon(playerid,30,1000);
GivePlayerWeapon(playerid,32,1000);
GivePlayerWeapon(playerid,34,1000);
GivePlayerWeapon(playerid,18,3);
return 1; }

if(InDM[playerid] == 1){
new rand = random(sizeof(DMSpawns));
SetPlayerPos(playerid, DMSpawns[rand][0], DMSpawns[rand][1], DMSpawns[rand][2]),SetPlayerInterior(playerid,0),SetPlayerHealth(playerid, 100),SetPlayerArmour(playerid, 100.00),ResetPlayerWeapons(playerid);
SetPlayerVirtualWorld(playerid,7);
GivePlayerWeapon(playerid,27,5000);
GivePlayerWeapon(playerid,24,5000);
GivePlayerWeapon(playerid,31,5000);
SetPlayerSkin(playerid,GetPVarInt(playerid,"Skin"));
return 1;}

if(InSawn[playerid] == 1){
new rand = random(sizeof(SawnTeleports));
SetPlayerPos(playerid, SawnTeleports[rand][0], SawnTeleports[rand][1], SawnTeleports[rand][2]),SetPlayerInterior(playerid,0),SetPlayerHealth(playerid, 100),SetPlayerArmour(playerid, 100.00),ResetPlayerWeapons(playerid);
SetPlayerVirtualWorld(playerid,8);
GivePlayerWeapon(playerid,26,99999);
GivePlayerWeapon(playerid,22,99999);
GivePlayerWeapon(playerid,22,99999);
SetPlayerSkin(playerid,GetPVarInt(playerid,"Skin"));
}
//==============================================================================
if(InGunGame[playerid] == 0 || InDM[playerid] == 0 || InTeamA[playerid] == 0 || InTeamB[playerid] == 0 || InSawn[playerid] == 0)return SetPlayerRandomSpawn(playerid);
if(InMini[playerid] == 1 && MiniStarted == 1){
MiniPlayers --;
InMini[playerid] = 0;
}

if(InWar[playerid] == 1 && WarStarted == 1){
WarPlayers --;
InWar[playerid] = 0;
}

if(InMonster[playerid] == 1 && MonsterStarted == 1){
MonsterPlayers --;
InMonster[playerid] = 0;
}
if(InTanks[playerid] == 1 && TanksStarted == 1){
TanksPlayers --;
InTanks[playerid] = 0;
}

if(InBoom[playerid] == 1 && BoomStarted == 1){
BoomPlayers --;
InBoom[playerid] = 0;
}
if(InWeapons[playerid] && WeaponsStarted == 1){
WeaponsPlayers--,InWeapons[playerid] = 0;}

return 1;
}


public OnPlayerDeath(playerid, killerid, reason)
{
if(InSwar[playerid] == 2)
{
SwarPlayers --;
InSwar[playerid] = 0;
DestroyVehicle(Swar[playerid]);
SetPlayerVirtualWorld(playerid,0);
CallRemoteFunction("CheckPlayers","i",SwarPlayers);
SendClientMessage(playerid,COLOR_LIGHTBLUEGREEN,"! ����� �������, ������ ���� ����");
return 1;
}
if(IsPlayerInAnyVehicle(killerid))return 1;
TextDrawHideForPlayer(playerid,txtTimeDisp);
if(battle[playerid][InBattle]) PlayerLozzeBattle(playerid);
if(DOF2_GetInt(SFile(killerid),"Armour") == 2){ SetPlayerArmour(killerid,100);}
SKills[killerid]++;
Deaths[playerid]++;
SetPlayerVirtualWorld(playerid,0);
DOF2_SetInt(SFile(killerid), "Kills", DOF2_GetInt(SFile(killerid), "Kills") +1);
if(doublekills) DOF2_SetInt(SFile(killerid), "Kills",DOF2_GetInt(SFile(killerid),"Kills") +1);
if(tripelkills) DOF2_SetInt(SFile(killerid), "Kills",DOF2_GetInt(SFile(killerid),"Kills") +2);
GivePlayerMoney(killerid,800);
SendDeathMessage(killerid,playerid, reason);
if(GunGameOn || InGunGame[playerid] == 1){
if(GunGame[killerid] == 1) SendClientMessage(killerid, COLOR_WHITE, "[Gun-Game] - 1/2");
if(GunGame[killerid] == 2) ResetPlayerWeapons(killerid),GivePlayerWeapon(killerid, 22, 999),SendClientMessage(killerid, COLOR_LIGHTGREEN, "[Gun-Game] >> .9mm :������ �� ���� GunGame ��� ���! ���� ��� ����� �"),SendClientMessage(killerid, COLOR_LIGHTBLUE, "[Gun-Game] >> .1 :���� ���� ��� GunGame ���� ��� ����� �");
if(GunGame[killerid] == 3) SendClientMessage(killerid, COLOR_WHITE, "[Gun-Game] - 1/2");
if(GunGame[killerid] == 4) ResetPlayerWeapons(killerid),GivePlayerWeapon(killerid, 24, 999),SendClientMessage(killerid, COLOR_LIGHTGREEN, "[Gun-Game] >> .Desert Eagle :������ �� ���� GunGame ��� ���! ���� ��� ����� �"),SendClientMessage(killerid, COLOR_LIGHTBLUE, ".2 :���� ���� ��� GunGame ���� ��� ����� �");
if(GunGame[killerid] == 5) SendClientMessage(killerid, COLOR_WHITE, "[Gun-Game] - 1/2");
if(GunGame[killerid] == 6) ResetPlayerWeapons(killerid),GivePlayerWeapon(killerid, 25, 999),SendClientMessage(killerid, COLOR_LIGHTGREEN, "[Gun-Game] >> .Shotgun :������ �� ���� GunGame ��� ���! ���� ��� ����� �"),SendClientMessage(killerid, COLOR_LIGHTBLUE, "[Gun-Game] >> .3 :���� ���� ��� GunGame ���� ��� ����� �");
if(GunGame[killerid] == 7) SendClientMessage(killerid, COLOR_WHITE, "[Gun-Game] - 1/2");
if(GunGame[killerid] == 8) ResetPlayerWeapons(killerid),GivePlayerWeapon(killerid, 26, 999),SendClientMessage(killerid, COLOR_LIGHTGREEN, "[Gun-Game] >> .Sawn-off Shotgun :������ �� ���� GunGame ��� ���! ���� ��� ����� �"),SendClientMessage(killerid, COLOR_LIGHTBLUE, "[Gun-Game] >> .4 :���� ���� ��� GunGame ���� ��� ����� �");
if(GunGame[killerid] == 9) SendClientMessage(killerid, COLOR_WHITE, "[Gun-Game] - 1/2");
if(GunGame[killerid] == 10) ResetPlayerWeapons(killerid),GivePlayerWeapon(killerid, 28, 999),SendClientMessage(killerid, COLOR_LIGHTGREEN, "[Gun-Game] >> .Uzi :������ �� ���� GunGame ��� ���! ���� ��� ����� �"),SendClientMessage(killerid, COLOR_LIGHTBLUE, "[Gun-Game] >> .5 :���� ���� ��� GunGame ���� ��� ����� �");
if(GunGame[killerid] == 11) SendClientMessage(killerid, COLOR_WHITE, "[Gun-Game] - 1/2");
if(GunGame[killerid] == 12) ResetPlayerWeapons(killerid),GivePlayerWeapon(killerid, 29, 999),SendClientMessage(killerid, COLOR_LIGHTGREEN, "[Gun-Game] >> .MP5 :������ �� ���� GunGame ��� ���! ���� ��� ����� �"),SendClientMessage(killerid, COLOR_LIGHTBLUE, "[Gun-Game] >> .6 :���� ���� ��� GunGame ���� ��� ����� �");
if(GunGame[killerid] == 13) SendClientMessage(killerid, COLOR_WHITE, "[Gun-Game] - 1/2");
if(GunGame[killerid] == 14) ResetPlayerWeapons(killerid),GivePlayerWeapon(killerid, 30, 999),SendClientMessage(killerid, COLOR_LIGHTGREEN, "[Gun-Game] >> .AK-47 :������ �� ���� GunGame ��� ���! ���� ��� ����� �"),SendClientMessage(killerid, COLOR_LIGHTBLUE, "[Gun-Game] >> .7 :���� ���� ��� GunGame ���� ��� ����� �");
if(GunGame[killerid] == 15) SendClientMessage(killerid, COLOR_WHITE, "[Gun-Game] - 1/2");
if(GunGame[killerid] == 16) ResetPlayerWeapons(killerid),GivePlayerWeapon(killerid, 31, 999),SendClientMessage(killerid, COLOR_LIGHTGREEN, "[Gun-Game] >> .M4 :������ �� ���� GunGame ��� ���! ���� ��� ����� �"),SendClientMessage(killerid, COLOR_LIGHTBLUE, "[Gun-Game] >> .8 :���� ���� ��� GunGame ���� ��� ����� �");
if(GunGame[killerid] == 17) SendClientMessage(killerid, COLOR_WHITE, "[Gun-Game] - 1/2");
if(GunGame[killerid] == 18) ResetPlayerWeapons(killerid),GivePlayerWeapon(killerid, 33, 999),SendClientMessage(killerid, COLOR_LIGHTGREEN, "[Gun-Game] >> .Country Rifle :������ �� ���� GunGame ��� ���! ���� ��� ����� �"),SendClientMessage(killerid, COLOR_LIGHTBLUE, "[Gun-Game] >> .9 :���� ���� ��� GunGame ���� ��� ����� �");
if(GunGame[killerid] == 19) SendClientMessage(killerid, COLOR_WHITE, "[Gun-Game] - 1/2");
if(GunGame[killerid] == 20) ResetPlayerWeapons(killerid),GivePlayerWeapon(killerid, 34, 999),SendClientMessage(killerid, COLOR_LIGHTGREEN, "[Gun-Game] >> .Sniper Rifle :������ �� ���� GunGame ��� ���! ���� ��� ����� �"),SendClientMessage(killerid, COLOR_LIGHTBLUE, "[Gun-Game] >> .10 :���� ���� ��� GunGame ���� ��� ����� �");
if(GunGame[killerid] == 21) SendClientMessage(killerid, COLOR_WHITE, "[Gun-Game] - 1/2");
if(GunGame[killerid] == 22) ResetPlayerWeapons(killerid),GivePlayerWeapon(killerid, 16, 999),SendClientMessage(killerid, COLOR_LIGHTGREEN, "[Gun-Game] >> .Grenade :������ �� ���� GunGame ��� ���! ���� ��� ����� �"),SendClientMessage(killerid, COLOR_LIGHTBLUE, "[Gun-Game] >> .11 :���� ���� ��� GunGame ���� ��� ����� �"),SendClientMessage(killerid, COLOR_WHITE, "[Gun-Game] - 1/2");
if(GunGame[killerid] == 23) SendClientMessage(killerid, COLOR_WHITE, "[Gun-Game] - 1/2");
if(GunGame[killerid] == 24){
ResetPlayerWeapons(killerid),GunGameOn = 0,InGunGame[killerid] = 0;
for(new i = 0; i < MAX_PLAYERS; i++) if(InGunGame[i] == 1) SpawnPlayer(i),SetPlayerVirtualWorld(i,0),KillTimer(GunGameTime),ResetPlayerWeapons(i);
SendClientMessage(killerid, COLOR_LIGHTBLUE, "[Gun-Game] >> .12 :���� ���� ��� GunGame ���� ��� ����� �"),format(String, sizeof(String), "[Gun-Game] >> .$���� �� ����� ���� � 20,000 ''%s'' �����", GetName(killerid)),SendClientMessageToAll(COLOR_LIGHTGREEN,String);}
GunGame[killerid] += 1;}

if(InMini[playerid] == 1 && MiniStarted == 1){
MiniPlayers --;
InMini[playerid] = 0;
SendClientMessage(playerid,COLOR_KRED,"���� �������� ������ ����");}

if(InWar[playerid] == 1 && WarStarted == 1){
WarPlayers --;
InWar[playerid] = 0;
SendClientMessage(playerid,COLOR_KRED,"���� �������� ������ ����");}

if(InMonster[playerid] == 1 && MonsterStarted == 1){
MonsterPlayers --;
InMonster[playerid] = 0;
SendClientMessage(playerid,COLOR_KRED,"���� �������� ������ ����");}

if(InTanks[playerid] == 1 && TanksStarted == 1){
TanksPlayers --;
InTanks[playerid] = 0;
SendClientMessage(playerid,COLOR_KRED,"���� �������� ������ ����");}

if(InBoom[playerid] == 1 && BoomStarted == 1){
BoomPlayers --;
InBoom[playerid] = 0;
SendClientMessage(playerid,COLOR_KRED,"���� �������� ������ ����");}
if(InWeapons[playerid] && WeaponsStarted == 1){
WeaponsPlayers--,InWeapons[playerid] = 0,SendClientMessage(playerid,COLOR_KRED, ".���� ��������");}

//==============================================================================
if(GetPVarInt(playerid,"InMoneyMission")) format(String, sizeof(String), "[Money Mission] << .���� ������ ���� ����� %s", GetName(playerid)),MoneyCd(0,0),SendClientMessageToAll(COLOR_ORANGE, String),SetPVarInt(playerid,"InMoneyMission",0),SetPlayerHealth(playerid,0),MoneyMissionPickup = CreatePickup(1550 , 2, -2667.6865,732.2017,27.9531, 0),KillTimer(MoneyMissionTimer);
	for(new i;i<GetMaxPlayers();i++) if(IsPlayerConnected(i) && GetPVarInt(playerid,"InStuntMission") && GetPVarInt(playerid,"InStuntMission") == 1)
	{
		format(String, sizeof(String), "[Stunt Mission] << .���� ������ ������ %s", GetName(i));
		SendClientMessageToAll(COLOR_ORANGE, String);
		SetPVarInt(playerid,"InStuntMission",0);
		SetPlayerHealth(i,0),StuntMissionDo = 0;
		KillTimer(StuntMissionTime(i));
		DestroyVehicle(StuntCar);
		DisablePlayerRaceCheckpoint(i);
	}
	    if(GetPVarInt(playerid,"InMoneyMission") == 1)
	{
        format(String,256,"[Money Mission] << ! $���� ��� ������ ���� ����� ����� 3,000 ''%s'' ��� �� ''%s''",GetName(playerid),GetName(killerid));
        SendClientMessageToAll(COLOR_ORANGE,String);
        GivePlayerMoney(killerid,3000);
	}
if(IsDead[playerid] == 1 && InCall[playerid] == 1 && Tallking[playerid] == 1) IsDead[playerid] = 1;
//==============================================================================
if(InTeamB[playerid] == 1) DOF2_SetInt("TeamAS.txt", "Score", DOF2_GetInt("TeamAS.txt", "Score") + 1);
if(InTeamA[playerid] == 1) DOF2_SetInt("TeamBS.txt", "Score", DOF2_GetInt("TeamBS.txt", "Score") + 1);
///=============================================================================
if(DOF2_GetInt(SFile(killerid),"Kills") == Level2) return PlayerUpLevel(killerid);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level3) return PlayerUpLevel(killerid);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level4) return PlayerUpLevel(killerid);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level5) return PlayerUpLevel(killerid);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level6) return PlayerUpLevel(killerid);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level7) return PlayerUpLevel(killerid);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level8) return PlayerUpLevel(killerid);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level9) return PlayerUpLevel(killerid);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level10) return PlayerUpLevel(killerid);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level11) return PlayerUpLevel(killerid),DOF2_SetInt(SFile(killerid), "Bank",DOF2_GetInt(SFile(killerid),"Bank")+200000),SendClientMessage(killerid,COLOR_LIGHTGREEN,".������ ����� ���� 10 ����� $200,000 ������ ����");
if(DOF2_GetInt(SFile(killerid),"Kills") == Level12) return PlayerUpLevel(killerid);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level13) return PlayerUpLevel(killerid);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level14) return PlayerUpLevel(killerid);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level15) return PlayerUpLevel(killerid);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level16) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Above Average"),DOF2_SetInt(SFile(killerid), "TagOn", 1);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level17) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Destinguished"),DOF2_SetInt(SFile(killerid), "TagOn", 1);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level18) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Idol"),DOF2_SetInt(SFile(killerid), "TagOn", 1);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level19) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Legendary"),DOF2_SetInt(SFile(killerid), "TagOn", 1);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level20) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Swordman"),DOF2_SetInt(SFile(killerid), "TagOn", 1);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level21) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Gunslinger"),DOF2_SetInt(SFile(killerid), "TagOn", 1),DOF2_SetInt(SFile(killerid), "Bank",DOF2_GetInt(SFile(killerid),"Bank")+400000),SendClientMessage(killerid,COLOR_LIGHTGREEN,".������ ����� ���� 20 ����� $400,000 ������ ����");
if(DOF2_GetInt(SFile(killerid),"Kills") == Level22) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Professional"),DOF2_SetInt(SFile(killerid), "TagOn", 1);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level23) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Master Pro"),DOF2_SetInt(SFile(killerid), "TagOn", 1);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level24) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Hitman"),DOF2_SetInt(SFile(killerid), "TagOn", 1);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level25) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Veteran"),DOF2_SetInt(SFile(killerid), "TagOn", 1);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level26) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Hardcore"),DOF2_SetInt(SFile(killerid), "TagOn", 1),DOF2_SetInt(SFile(killerid), "Bank",DOF2_GetInt(SFile(killerid),"Bank")+600000),SendClientMessage(killerid,COLOR_LIGHTGREEN,".������ ����� ���� 25 ����� $600,000 ������ ����");
if(DOF2_GetInt(SFile(killerid),"Kills") == Level27) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Marksman"),DOF2_SetInt(SFile(killerid), "TagOn", 1);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level28) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Vicious"),DOF2_SetInt(SFile(killerid), "TagOn", 1);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level29) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Insane"),DOF2_SetInt(SFile(killerid), "TagOn", 1);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level30) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Gladiator"),DOF2_SetInt(SFile(killerid), "TagOn", 1);
if(DOF2_GetInt(SFile(killerid),"Kills") == Level31) return PlayerUpLevel(killerid),DOF2_SetString(SFile(killerid),"Tag","Vip"),DOF2_SetInt(SFile(killerid), "TagOn", 1),DOF2_SetInt(SFile(killerid),"Vip",1);
return 1;
}
//==============================================================================
public OnVehicleDeath(vehicleid, killerid)
{
if(GetVehicleModel(GetPlayerVehicleID(vehicleid)) == 501) return DestroyVehicle(vehicleid);
if(GetVehicleModel(GetPlayerVehicleID(vehicleid)) == 465) return DestroyVehicle(vehicleid);
if(GetVehicleModel(GetPlayerVehicleID(vehicleid)) == 564) return DestroyVehicle(vehicleid);
if(GetVehicleModel(GetPlayerVehicleID(vehicleid)) == 441) return DestroyVehicle(vehicleid);
if(GetVehicleModel(GetPlayerVehicleID(vehicleid)) == 464) return DestroyVehicle(vehicleid);
if(GetVehicleModel(GetPlayerVehicleID(vehicleid)) == 594) return DestroyVehicle(vehicleid);
return 1;
}
public PayCarTax()
{
new file[50]; new Vtime; new year,month,day;	getdate(year, month, day);
VCount =CreateVehicle(411,0,0,0,0,0,0,-1);
DestroyVehicle(VCount);
for (new car=1; car < VCount; car++)
{
format(file,sizeof(file),"Car/car%d.txt",car);
if(DOF2_FileExists(file) && DOF2_GetInt(file,"CarOwned") == 1)DOF2_SetInt(file,"PayTaxTime",DOF2_GetInt(file,"PayTaxTime")-1);
if(DOF2_FileExists(file) && DOF2_GetInt(file,"CarOwned") == 1 && DOF2_GetInt(file,"PayTaxTime") <= 0){
DOF2_SetInt(file,"CarOwned",0);
DOF2_SetInt(SFile1(DOF2_GetString(file,"CarOwner")),"OwnCar",0);
DOF2_SetInt(SFile1(DOF2_GetString(file,"CarOwner")),"CarId",0);
DOF2_SetString(file,"CarOwner","none");
DOF2_SetInt(file,"SetPrice",0);
DOF2_SetInt(file,"Hydraulics",0);
DOF2_SetInt(file,"Nitro",0);
DOF2_SetInt(file,"Neon",0);
DOF2_SetInt(file,"Disco",0);
DOF2_SetInt(file,"Wheels",0);
SetTimerEx("UpdateCar",500,0,"d",car);
Vtime++;
}
}
SendClientMessageToAll(COLOR_WHITE,"|_____________ ����� _____________|");
SendClientMessageToAll(Color_GMX,"! �� ������ �����");
SendFormatMessageToAll(Color_GMX,".%d :����� ������ ������",Vtime);
SendClientMessageToAll(Color_GMX,"���� ������ ���-������, ���� �� ��� �� ���� ���� ����");
SendClientMessageToAll(COLOR_WHITE,"|_________________________________|");
printf("Car Tax Update!");
return 1;
}



public OnVehicleSpawn(vehicleid)
{
ChangeVehiclePaintjob(Elegy,2),ChangeVehiclePaintjob(SultanA,1),ChangeVehiclePaintjob(Elegy2,2),ChangeVehiclePaintjob(Remington,2);
SetTimerEx("UpdateCar",2000,0,"d",vehicleid);
tCount[vehicleid] = false;
if(vehicleid >= VCount) return 1;
return 1;
}

public OnPlayerText(playerid, text[])
{
if(!Logged[playerid]) return SendClientMessage(playerid, red, "�����, �� ��� ���� ������ �� ��� ������ �������"),0;
if(InAfk[playerid] == 1)
{
InAfk[playerid] = 0;
SetPlayerVirtualWorld(playerid,0);
SetPlayerRandomSpawn(playerid);
SendClientMessage(playerid,0x00FF00FF, "AFK ���� ����");
TogglePlayerControllable(playerid, 1);
BlockChat[playerid] = 0;
}
if(BlockChat[playerid] == 1)return SendClientMessage(playerid,0x00FF00FF, "���� �� ����"), 0;
if(!IsPlayerXAdmin(playerid) && !IsPlayerSupporter(playerid) && !IsPlayerNightTeam(playerid) && !IsPlayerHonor(playerid) && !IsPlayerVip(playerid))
{
if(GetPVarInt(playerid,"ASpam") == 1)return SendClientMessage(playerid, COLOR_KRED,"[Anti-Flood] - �����/����� ��� ��� 2 �����"), 0;
SetPVarInt(playerid,"ASpam",GetPVarInt(playerid,"ASpam")+1),SetTimerEx("SpamUpdate",2000,0,"d",playerid);
}
if(InTeamA[playerid])
{
GetPlayerName(playerid,playername,24);
format(String,sizeof(String),"[TDM] %s: %s [id:%d|Cop]",playername, text,playerid);
SendTeamMessage("Cops",String);
return 0;
}

if(InTeamB[playerid])
{
GetPlayerName(playerid,playername,24);
format(String,sizeof(String),"[TDM] %s: %s [id:%d|Gang]",playername, text,playerid);
SendTeamMessage("Gang",String);
return 0;
}
if(text[0]== '^' && IsPlayerHonor(playerid))
{
new HonorMsg[256];
format(HonorMsg,sizeof(HonorMsg),"[Honor] - %s (%d): %s",GetName(playerid),playerid,text[1]);
return SendClientMessageToHonor(COLOR_YELLOW,HonorMsg),0;
}
if(text[0]== '~' && IsPlayerSupporter(playerid))
{
format(SString,sizeof(SString),"[Support] - %s (%d): %s",GetName(playerid),playerid,text[1]);
return SendMessageToSupporters(yellow,SString),0;
}
if(text[0]== '&' && IsPlayerNightTeam(playerid))
{
format(SString,sizeof(SString),"[NightTeam] - %s (%d): %s",GetName(playerid),playerid,text[1]);
return SendMessageToNightTeam(yellow,SString),0;
}
if(text[0] == '@')
{
new iname[MAX_PLAYER_NAME];
new playerip[16];
GetPlayerIp(playerid, playerip, 16);
if(DOF2_GetInt(SFile(playerid),"ClanLevel") == 1) levelname = "Member";
if(DOF2_GetInt(SFile(playerid),"ClanLevel") == 2) levelname = "Honor";
if(DOF2_GetInt(SFile(playerid),"ClanLevel") == 3) levelname = "Tester";
if(DOF2_GetInt(SFile(playerid),"ClanLevel") == 4) levelname = "Sub-Leader";
if(DOF2_GetInt(SFile(playerid),"ClanLevel") == 5) levelname = "Leader";
if(DOF2_GetInt(SFile(playerid),"ClanLevel") == 6) levelname = "Founder";
if((!DOF2_FileExists(SFile(playerid))) || (!strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None",true)))return 0;
format(String,sizeof(String),"[Clan] - %s (%d | %s): %s",GetName(playerid),playerid,levelname,text[1]);
for(new i = 0; i < GetMaxPlayers() ; i++){
if(IsPlayerConnected(i)){
GetPlayerName(i,iname, sizeof(iname));
if(DOF2_FileExists(SFile(i)) && !strcmp(DOF2_GetString(SFile(playerid),"Clan"),DOF2_GetString(SFile(i),"Clan"),true)){
new file[256];
format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
if(ClanMute[playerid] == 1) return SendClientMessage(playerid,red,"��� �����");
if(DOF2_GetInt(file,"Chat") == 0 && DOF2_GetInt(SFile(playerid),"ClanLevel") < 4)return SendClientMessage(playerid, COLOR_KRED,"�'�� ����� ���� ���"),0;
SendClientMessage(i,COLOR_AQUA,String);
}}}
format(String,sizeof(String),"\r\n[IP: %s][Clan: %s] %s (id:%d): %s",playerip,DOF2_GetString(SFile(playerid),"Clan"),GetName(playerid),playerid,text[1]);
WriteToServerLog("Clans",String);
return 0;
}
if(InCall[playerid] == 1)
{
if(IsPlayerConnected(TallkingID[playerid]) && Tallking[playerid] == 1 && TallkingID[playerid] > -1 && Tallking[TallkingID[playerid]] == 1)
{
format(str, sizeof(str),"[Phone] >> From %s (id: %d): %s", GetName(playerid), playerid, text);
SendClientMessage(TallkingID[playerid], YELLOW, str);
format(str, sizeof(str),"[Phone] >> To %s (id: %d): %s", GetName(TallkingID[playerid]), TallkingID[playerid], text);
SendClientMessage(playerid, LIGHTBLUE, str);
new playerip[16];
GetPlayerIp(playerid, playerip, 16);
format(String,sizeof(String),"\r\n[IP: %s] %s (id:%d): %s",playerip,playername,playerid,text);
WriteToServerLog("Phone",String);
return 0;
}
}
new Chat[256];
if(DOF2_GetInt(SFile(playerid), "PlayerHaveTag") == 0)
{
format(Chat, sizeof (Chat), "%s: {FFFFFF}%s (ID: %d)", GetName(playerid), text, playerid);
SendChatMessageToAll(GetPlayerColor(playerid), Chat);
}
else
{
format(Chat, sizeof (Chat), "%s: {FFFFFF}%s (ID: %d | %s {FFFFFF})", GetName(playerid), text, playerid, ColouredText(DOF2_GetString(SFile(playerid), "PlayerTag")));
SendChatMessageToAll(GetPlayerColor(playerid), Chat);
}
if(!strcmp("$", text, true))return OnPlayerCommandText(playerid,"/Bank"),0;
if(!strcmp("$$", text, true))return OnPlayerCommandText(playerid,"/PBank"),0;
if(!strcmp("$$$", text, true))return OnPlayerCommandText(playerid,"/ClanBank"),0;
return 0;
}


public OnPlayerCommandText(playerid, cmdtext[])
{
printf("%s[%d] Command: %s",GetName(playerid),playerid,cmdtext);
GetPlayerName(playerid,playername,24);
new playerip[16];
GetPlayerIp(playerid, playerip, sizeof(playerip));
format(String,sizeof(String),"\r\n[IP: %s] %s (id:%d): %s",playerip,playername,playerid,cmdtext);
WriteToServerLog("Commands",String);
if(!Logged[playerid]) return SendClientMessage(playerid, red, "�����, �� ��� ���� ������ �� ��� ������ �������");
if(!IsPlayerXAdmin(playerid) && !IsPlayerSupporter(playerid) && !IsPlayerNightTeam(playerid) && !IsPlayerHonor(playerid) && !IsPlayerVip(playerid) && !IsPlayerAntiFlood(playerid))
{
if(GetPVarInt(playerid,"ASpam") == 1)return SendClientMessage(playerid, COLOR_KRED,"[Anti-Flood] - �����/����� ��� ��� 2 �����");
SetPVarInt(playerid,"ASpam",GetPVarInt(playerid,"ASpam")+1),SetTimerEx("SpamUpdate",2000,0,"d",playerid);
}
if(InAfk[playerid] == 1)
{
InAfk[playerid] = 0;
SetPlayerVirtualWorld(playerid,0);
SetPlayerRandomSpawn(playerid);
SendClientMessage(playerid,0x00FF00FF, "AFK ���� ����");
TogglePlayerControllable(playerid, 1);
BlockChat[playerid] = 0;
}
new cmd[256], tmp[256], tmp2[256], string[256], idx, file[50];
cmd = strtok(cmdtext, idx);
if(!strcmp(cmd, "/Kill", true)) return SetPlayerHealth(playerid,0);
if(InMini[playerid] == 1 && !IsPlayerXAdmin(playerid) || InWar[playerid] == 1 && !IsPlayerXAdmin(playerid) || InBoom[playerid] == 1 && !IsPlayerXAdmin(playerid) || InWeapons[playerid] == 1 && !IsPlayerXAdmin(playerid) || InMonster[playerid] == 1 && !IsPlayerXAdmin(playerid)
|| InSwar[playerid] == 1 && !IsPlayerXAdmin(playerid) || InTanks[playerid] == 1 && !IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,COLOR_KRED, ".���� ���� ����� ������ �������");
if(GetPVarInt(playerid,"InMoneyMission") == 1 || GetPVarInt(playerid,"InStuntMission") == 1)return SendClientMessage(playerid,COLOR_KRED,"! ���� ���� ���� ������ ���� ��� ������");
//==============================================================================
if(!strcmp(cmd, "/Afk", true)){
if(!InAfk[playerid]){
InAfk[playerid] = 1;
BlockChat[playerid] = 1;
SendClientMessage(playerid,COLOR_WHITE, "{F59300}AFK ����� ����");
SetPlayerVirtualWorld(playerid,playerid+1);
SetPlayerPos(playerid,1117.6194,-2037.0128,78.7500);
TogglePlayerControllable(playerid,0);
}else{
InAfk[playerid] = 0;
SetPlayerVirtualWorld(playerid,0);
SetPlayerRandomSpawn(playerid);
SendClientMessage(playerid,0x00FF00FF, "AFK ���� ����");
TogglePlayerControllable(playerid, 1);
BlockChat[playerid] = 0;
}
return 1;}
if(InAfk[playerid] == 1) return SendClientMessage(playerid,COLOR_KRED, "AFK ���� ���� ����� ������ ����");
//==============================================================================
if(!strcmp(cmdtext, "/Dm", true)){
if(DOF2_GetInt(SFile(playerid), "Level") <2 && !IsPlayerHonor(playerid))return LevelError(playerid,2);
if(!InDM[playerid]){
new rand = random(sizeof(DMSpawns));
SetPlayerPos(playerid, DMSpawns[rand][0], DMSpawns[rand][1], DMSpawns[rand][2]),SetPlayerInterior(playerid,0),SetPlayerHealth(playerid, 100),SetPlayerArmour(playerid, 100.00),ResetPlayerWeapons(playerid);
SetPlayerVirtualWorld(playerid,7),InDM[playerid] = 1;
GivePlayerWeapon(playerid,27,5000),GivePlayerWeapon(playerid,24,5000),GivePlayerWeapon(playerid,31,5000),SendClientMessage(playerid,green,"! [DeathMatch] ���� ��� ����� ������");
SetPVarInt(playerid, "Skin", GetPlayerSkin(playerid));
}else{
SetPlayerRandomSpawn(playerid);
SendClientMessage(playerid,0xff0033ff,"���� ����� �����, ����� ���� �� ������ ���");
ResetPlayerWeapons(playerid),SetPlayerVirtualWorld(playerid,0),InDM[playerid] = 0;} return 1;}
if(InDM[playerid] == 1) return SendClientMessage(playerid,COLOR_KRED,"���� ���� ����� ������ ����� ��");
//==============================================================================
if(!strcmp(cmdtext, "/TDM", true)){
if(CantUseTDM) return SendClientMessage(playerid, Red, "����� ����");
if(!InTDM[playerid]){
ShowPlayerDialog(playerid,1872,DIALOG_STYLE_LIST,"{ff0033}Choose Team","{0000ff}Cop Team\r\n{ff0000}Gang Team","�����","�����");
}else{
SetPlayerRandomSpawn(playerid);
SendClientMessage(playerid,0xff0033ff,"[{ffffff}/TDM{ff0033}] ����� ����� �� ���� �� ������ {ffffff}Team Deathmatch {ff0033}���� �����");
ResetPlayerWeapons(playerid),SetPlayerSkin(playerid,OldInfo[playerid][1]),SetPlayerColor(playerid,OldInfo[playerid][0]);
InTDM[playerid] = 0,InTeamA[playerid] = 0,InTeamB[playerid] = 0,teamaplayers --,teambplayers --,SetPlayerTeam(playerid, playerid),TextDrawHideForPlayer(playerid, CopsPoints),TextDrawHideForPlayer(playerid, GangPoints);} return 1;}
if(InTDM[playerid] == 1) return SendClientMessage(playerid,COLOR_KRED,"���� ���� ����� ������ ����� ��");
//==============================================================================
if(!strcmp(cmdtext, "/Sawn", true)){
if(!InSawn[playerid]){
new rand = random(sizeof(SawnTeleports));
SetPlayerPos(playerid, SawnTeleports[rand][0], SawnTeleports[rand][1], SawnTeleports[rand][2]),SetPlayerInterior(playerid,0),SetPlayerHealth(playerid, 100),SetPlayerArmour(playerid, 100.00),ResetPlayerWeapons(playerid);
SetPlayerVirtualWorld(playerid,8);
InSawn[playerid] = 1;
GivePlayerWeapon(playerid,26,99999),GivePlayerWeapon(playerid,22,99999),GivePlayerWeapon(playerid,22,99999);
SendClientMessage(playerid,green,"! ���� ��� ����� ������ �����");}
else{
SetPlayerRandomSpawn(playerid);
SendClientMessage(playerid,0xff0033ff,"! ���� ����� �����");
ResetPlayerWeapons(playerid),SetPlayerVirtualWorld(playerid,0),InSawn[playerid] = 0;}
return 1;}
if(InSawn[playerid] == 1) return SendClientMessage(playerid,COLOR_KRED,"���� ���� ����� ������ ����� ��");
//==============================================================================
if(strcmp(cmd, "/ExitRc", true) == 0)
{
new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
switch(Model) { case 501,465,564,441,464,594: return RemovePlayerFromVehicle(playerid) ,DestroyVehicle(GetPlayerVehicleID(playerid));}
SendClientMessage(playerid,COLOR_WHITE,"RC ��� �� ����");
return 1;}
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 501) return SendClientMessage(playerid, red, "/ExitRc ���� ���� ����� ������ ���� ���� ���, ���� ���� ����");
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 465) return SendClientMessage(playerid, red, "/ExitRc ���� ���� ����� ������ ���� ���� ���, ���� ���� ����");
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 564) return SendClientMessage(playerid, red, "/ExitRc ���� ���� ����� ������ ���� ���� ���, ���� ���� ����");
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 441) return SendClientMessage(playerid, red, "/ExitRc ���� ���� ����� ������ ���� ���� ���, ���� ���� ����");
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 464) return SendClientMessage(playerid, red, "/ExitRc ���� ���� ����� ������ ���� ���� ���, ���� ���� ����");
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 594)return SendClientMessage(playerid, red, "/ExitRc ���� ���� ����� ������ ���� ���� ���, ���� ���� ����");
if(!strcmp(cmd,"/GunGame",true) || !strcmp(cmd,"/GG",true)){
if(GunGameOn == 0) return SendClientMessage(playerid, COLOR_WHITE, ".����� �� ��� ����, ��� ���� �� ������ ����");
if(InGunGame[playerid] == 0) return SendClientMessage(playerid,COLOR_GRAY,"! Gun-Game -���� ��� ����� �"),SendClientMessage(playerid,COLOR_WHITE,".��� ���� ����� ��, ����/� �� ������ ���"),InGunGame[playerid] = 1,ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 24, 999),SetPlayerVirtualWorld(playerid, 12),GunGameWeapon(playerid),GunGameSpawn(playerid);
else if(InGunGame[playerid] == 1) return InGunGame[playerid] = 0,SetPlayerVirtualWorld(playerid, 0),SpawnPlayer(playerid),ResetPlayerWeapons(playerid);
return 1;}
if(InGunGame[playerid] == 1) return SendClientMessage(playerid,COLOR_ORANGE,"/GunGame :���� ���� ������ ����/� ,GunGame ���� ���� ������ ���� ��� �");
if(!strcmp(cmd,"/Os",true))
{
tmp = strtok(cmdtext, idx);
if(!strlen(tmp))return ShowStats(playerid,playerid);
if(!IsPlayerConnected(strval(tmp)))return SendClientMessage(playerid,COLOR_WHITE, ".������ ���� �����");
return ShowStats(strval(tmp),playerid);
}

if(!strcmp(cmd,"/Stats",true))
{
tmp = strtok(cmdtext, idx);
if(!strlen(tmp))return NewShowStats(playerid,playerid);
if(!IsPlayerConnected(strval(tmp)))return SendClientMessage(playerid,COLOR_WHITE, ".������ ���� �����");
//if(IsXLevel(strval(tmp)) >= 14)return SendClientMessage(playerid,COLOR_KRED,"! �� ���� ����� ������ �� ���� ��");
return NewShowStats(strval(tmp),playerid);
}
if(DOF2_GetInt(SFile(playerid),"ClanLevel") == 1) levelname = "Member";
if(DOF2_GetInt(SFile(playerid),"ClanLevel") == 2) levelname = "{FFFF00}Honor{ffbe00}";
if(DOF2_GetInt(SFile(playerid),"ClanLevel") == 3) levelname = "{4DCE03}Tester{ffbe00}";
if(DOF2_GetInt(SFile(playerid),"ClanLevel") == 4) levelname = "{1BA5FE}Sub-Leader{ffbe00}";
if(DOF2_GetInt(SFile(playerid),"ClanLevel") == 5) levelname = "{FF2400}Leader{ffbe00}";
if(DOF2_GetInt(SFile(playerid),"ClanLevel") == 6) levelname = "{FF2400}Founder{ffbe00}";
    if(!strcmp(cmd,"/Details",true) || !strcmp(cmd,"/D",true))

    {
            tmp = strtok(cmdtext, idx);
            if(!strlen(tmp))
            {
            new Sstring[5500],Sstr[2000];
            format(Sstring,sizeof(Sstring),"{FFFFFF}// Account info:\n {ffbe00}User: %d | Warning: 0/7 | Spy: %s\nRegistration Date: %s",DOF2_GetInt(SFile(playerid),"UserID"),DOF2_GetInt(SFile(playerid),"Spy") == 1 ? ("Yes"):("No"),DOF2_GetString(SFile(playerid),"Date"));
            strcat(Sstr, Sstring);

            format(Sstring,sizeof(Sstring)," \nEmail: %s",DOF2_GetString(SFile(playerid),"Email"));
            strcat(Sstr, Sstring);

            format(Sstring,sizeof(Sstring)," \n\n{FFFFFF}// Personal info:\n{ffbe00}Name: %s | Forum: %s\n",DOF2_GetString(SFile(playerid),"PName"),DOF2_GetString(SFile(playerid),"PForum"));
            strcat(Sstr, Sstring);

            format(Sstring,sizeof(Sstring),"City: %s | Skype: %s\n",DOF2_GetString(SFile(playerid),"PCity"),DOF2_GetString(SFile(playerid),"PSkype"));
            strcat(Sstr, Sstring);

            format(Sstring,sizeof(Sstring),"Messanger: %s",DOF2_GetString(SFile(playerid),"PMsn"));
            strcat(Sstr, Sstring);

            if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None",true))
            {
            format(Sstring, sizeof(Sstring), "\n\n {FFFFFF}// Clan info :\n {ff3410}��� �� ���� �����",DOF2_GetString(SFile(playerid),"Clan"),DOF2_GetString(SFile(playerid),"ClanLevel"));
            strcat(Sstr, Sstring);
            }else{
            format(Sstring, sizeof(Sstring), "\n\n {FFFFFF}// Clan info :{ffbe00}\n {ffbe00}Name: %s | Level: %d [%s]",DOF2_GetString(SFile(playerid),"Clan"),DOF2_GetInt(SFile(playerid),"ClanLevel"),levelname);
            strcat(Sstr, Sstring);
            }

            if(DOF2_GetInt(SFile(playerid),"OwnCar") == 1)
            {
           	new scfile[256];
    		format(scfile,sizeof(scfile),"Car/car%d.txt",DOF2_GetInt(SFile(playerid),"CarID"));
            format(Sstring,sizeof(Sstring),"\n\n{FFFFFF}// Car info{ffbe00}\n ID: %d | Name: %s %s{FFFFFF}\n\n{FFFFFF}// Activities:",DOF2_GetInt(SFile(playerid),"CarID"),VehicleInfo[DOF2_GetInt(SFile(playerid),"CarID")][CarName],DOF2_GetInt(scfile,"Buyable") == 2 ? ("{ffbe00}[{FF66FF}Special{ffbe00}]"):(""));
            strcat(Sstr, Sstring);
            }else{
            format(Sstring,sizeof(Sstring),"\n\n{FFFFFF}// Car info: \n {ff3410}! ��� �� ���\n\n{FFFFFF}// Activities:");
            strcat(Sstr, Sstring);
            }
            format(Sstring,sizeof(Sstring),"\n{ffbe00}War: %d |",DOF2_GetInt(SFile(playerid),"War"));
            strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  {ffbe00}Mini: %d |",DOF2_GetInt(SFile(playerid),"Mini"));
            strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  {ffbe00}Weapons: %d |",DOF2_GetInt(SFile(playerid),"Weapons"));
            strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  {ffbe00}Boom: %d",DOF2_GetInt(SFile(playerid),"Boom"));
            strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  \n{ffbe00}Monster: %d |",DOF2_GetInt(SFile(playerid),"Monster"));
        	strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  {ffbe00}Karting: %d |",DOF2_GetInt(SFile(playerid),"Karting"));
        	strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  {ffbe00}Racing: %d",DOF2_GetInt(SFile(playerid),"Racing"));
        	strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  \n{ffbe00}Tanks: %d |",DOF2_GetInt(SFile(playerid),"Tanks"));
            strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  {ffbe00}Lotto: %d\n\n",DOF2_GetInt(SFile(playerid),"Lotto"));
            strcat(Sstr, Sstring);
            new Hours,Minutes,Days,Months,Years,Seconds;
			gettime(Hours, Minutes,Seconds),getdate(Years, Months, Days);
            format(Sstring,sizeof(Sstring),"{31cbff}Last Update :{bbbbbb} %02d:%02d:%02d - %d/%d/%d\n",Hours,Minutes,Seconds,Days,Months,Years);
            strcat(Sstr, Sstring);
        	format(Sstring,sizeof(Sstring), "Details for: %s ", GetName(playerid));
            return ShowPlayerDialog(playerid, 1191,DIALOG_STYLE_MSGBOX, Sstring, Sstr, "�����", "");
            }
            new Sstring[5500],Sstr[2000];
            new idz = strval(tmp);
            if(!IsPlayerConnected(idz)) return SendClientMessage(playerid, -1, "����� �� �����");
   	        if(SpySystem[idz] == 1 && playerid != idz){
			SendFormatMessage(idz,COLOR_ORANGE,"[SpySystem] >> ��� Details ���� � (id: %d) ''%s'' �����",playerid,GetName(playerid));
			}
            if(DOF2_GetInt(SFile(idz),"ClanLevel") == 1) levelname = "Member";
			if(DOF2_GetInt(SFile(idz),"ClanLevel") == 2) levelname = "{FFFF00}Honor{ffbe00}";
			if(DOF2_GetInt(SFile(idz),"ClanLevel") == 3) levelname = "{4DCE03}Tester{ffbe00}";
			if(DOF2_GetInt(SFile(idz),"ClanLevel") == 4) levelname = "{1BA5FE}Sub-Leader{ffbe00}";
			if(DOF2_GetInt(SFile(idz),"ClanLevel") == 5) levelname = "{FF2400}Leader{ffbe00}";
			if(DOF2_GetInt(SFile(idz),"ClanLevel") == 6) levelname = "{FF2400}Founder{ffbe00}";
			format(Sstring,sizeof(Sstring),"{FFFFFF}// Account info:\n {ffbe00}User: %d | Warning: 0/7 | Spy: %s\nRegistration Date: %s",DOF2_GetInt(SFile(idz),"UserID"),DOF2_GetInt(SFile(idz),"Spy") == 1 ? ("Yes"):("No"),DOF2_GetString(SFile(idz),"Date"));
            strcat(Sstr, Sstring);

			format(Sstring,sizeof(Sstring)," \n\n{FFFFFF}// Personal info:\n{ffbe00}Name: %s | Forum: %s\n",DOF2_GetString(SFile(idz),"PName"),DOF2_GetString(SFile(idz),"PForum"));
            strcat(Sstr, Sstring);

            format(Sstring,sizeof(Sstring),"City: %s | Skype: %s\n",DOF2_GetString(SFile(idz),"PCity"),DOF2_GetString(SFile(idz),"PSkype"));
            strcat(Sstr, Sstring);

            format(Sstring,sizeof(Sstring),"Messanger: %s",DOF2_GetString(SFile(playerid),"PMsn"));
            strcat(Sstr, Sstring);

			if(!strcmp(DOF2_GetString(SFile(idz),"Clan"),"None",true))
            {
            format(Sstring, sizeof(Sstring), "\n\n {FFFFFF}// Clan info :\n {ff3410}����� �� �����",DOF2_GetString(SFile(idz),"Clan"),DOF2_GetString(SFile(idz),"ClanLevel"));
            strcat(Sstr, Sstring);
            }else{
            format(Sstring, sizeof(Sstring), "\n\n {FFFFFF}// Clan info :{ffbe00}\n {ffbe00}Name: %s | Level: %d [%s]",DOF2_GetString(SFile(idz),"Clan"),DOF2_GetInt(SFile(idz),"ClanLevel"),levelname);
            strcat(Sstr, Sstring);
            }

            if(DOF2_GetInt(SFile(idz),"OwnCar") == 1)
            {
           	new scfile[256];
    		format(scfile,sizeof(scfile),"Car/car%d.txt",DOF2_GetInt(SFile(idz),"CarID"));
             format(Sstring,sizeof(Sstring),"\n\n{FFFFFF}// Car info{ffbe00}\n ID: %d | Name: %s %s{FFFFFF}\n\n{FFFFFF}// Activities:",DOF2_GetInt(SFile(idz),"CarID"),VehicleInfo[DOF2_GetInt(SFile(idz),"CarID")][CarName],DOF2_GetInt(scfile,"Buyable") == 2 ? ("{ffbe00}[{FF66FF}Special{ffbe00}]"):(""));
            strcat(Sstr, Sstring);
            }else{
            format(Sstring,sizeof(Sstring),"\n\n{FFFFFF}// Car info: \n {ff3410}! ��� ����� ���\n\n{FFFFFF}// Activities:");
            strcat(Sstr, Sstring);
            }
            format(Sstring,sizeof(Sstring),"\n{ffbe00}War: %d |",DOF2_GetInt(SFile(idz),"War"));
            strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  {ffbe00}Mini: %d |",DOF2_GetInt(SFile(idz),"Mini"));
            strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  {ffbe00}Weapons: %d |",DOF2_GetInt(SFile(idz),"Weapons"));
            strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  {ffbe00}Boom: %d",DOF2_GetInt(SFile(idz),"Boom"));
            strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  \n{ffbe00}Monster: %d |",DOF2_GetInt(SFile(idz),"Monster"));
        	strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  {ffbe00}Karting: %d |",DOF2_GetInt(SFile(idz),"Karting"));
        	strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  {ffbe00}Racing: %d",DOF2_GetInt(SFile(idz),"Racing"));
        	strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  \n{ffbe00}Tanks: %d |",DOF2_GetInt(SFile(idz),"Tanks"));
            strcat(Sstr, Sstring);
            format(Sstring,sizeof(Sstring),"  {ffbe00}Lotto: %d\n\n",DOF2_GetInt(SFile(idz),"Lotto"));
            strcat(Sstr, Sstring);
            new Hours,Minutes,Days,Months,Years,Seconds;
			gettime(Hours, Minutes,Seconds),getdate(Years, Months, Days);
            format(Sstring,sizeof(Sstring),"{31cbff}Last Update :{bbbbbb} %02d:%02d:%02d - %d/%d/%d\n",Hours,Minutes,Seconds,Days,Months,Years);
            strcat(Sstr, Sstring);
        	format(Sstring,sizeof(Sstring), "Details for: %s ", GetName(idz));
        	ShowPlayerDialog(playerid, 1191,DIALOG_STYLE_MSGBOX, Sstring, Sstr, "�����", "");
            return 1;
    }

//========================================Admin=================================
if(!strcmp(cmd,"/xHelp",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
new Sstring[5500],xHelpString[2000];
format(Sstring,sizeof(Sstring),"/xGmx /xCarSystem /xSetPlayer /xText /xCmd /xSayDialog /Spawn /xGiveCarPlayer /xEditPayTax\n");
strcat(xHelpString, Sstring);
format(Sstring,sizeof(Sstring),"/xPayTax /xSellCar /xSetPrice /xSetKills /xSetLevel /xSetBank /xResetBank /xAddBank /xSetKills /xSetClan\n");
strcat(xHelpString, Sstring);
format(Sstring,sizeof(Sstring),"/xSetLevelClan /TdmOpen /TdmClose /EditPointsA /EditPointsB /GGOpen /GGClose /EditMoneyLotto /EditNumberLotto /DoubleKill\n");
strcat(xHelpString, Sstring);
format(Sstring,sizeof(Sstring),"/TripelKill /Ask /StartCode /ECode /BuyAble /UnBuyAble /Hqcar /SCar /UnLockallcars /Lockallcars\n");
strcat(xHelpString, Sstring);
format(Sstring,sizeof(Sstring),"/ClanCreatePlayer /DelClan /AutoMsg /SetTag /DelTag /xLotto /xActive /xEndActive /xNeon /xCarDisco\n");
strcat(xHelpString, Sstring);
ShowPlayerDialog(playerid, 1191,DIALOG_STYLE_MSGBOX,"Admin Commands", xHelpString, "�����", "");
return 1;
}
if(!strcmp("/xActive", cmd, true)) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
ShowPlayerDialog(playerid, 1192,DIALOG_STYLE_LIST,"Active","Mini\nWar\nWeapons\nMonster\nBoom\nSwar\nKart\nRacing\n\nEnd Active", "�����", "�����");
return 1;
}
if(!strcmp("/xEndActive", cmd, true)) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
ShowPlayerDialog(playerid, 1193,DIALOG_STYLE_LIST,"End Active","Mini\nWar\nWeapons\nMonster\nBoom\nSwar\nKart\nRacing", "�����", "�����");
return 1;
}
//------------------------------------------------------------------------------
if(!strcmp("/xGoPos", cmd, true)) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,-1,"/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, white, "/xGoPos [X] [Y] [Z] :���� ������");
new x22 = strval(cmd);
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, white, "/xGoPos [X] [Y] [Z] :���� ������");
new y22 = strval(cmd);
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, white, "/xGoPos [X] [Y] [Z] :���� ������");
new z22 = strval(cmd);
SetPlayerPos(playerid,x22,y22,z22);
format(string, sizeof(string), "����� ������");
SendClientMessage(playerid, yellow, string);
return 1;}
if(strcmp(cmd, "/xGotoCar", true) == 0){
if(!IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,white,"/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
tmp = strtok(cmdtext, idx);
new vehid = strval(tmp);
if(!strlen(tmp)) return SendClientMessage(playerid, -1, "/xGotoCar [playerid] - �����");
new Float:Xv, Float:Yv, Float:Zv;
GetVehiclePos(vehid, Xv, Yv, Zv);
SetPlayerPos(playerid, Xv+1, Yv, Zv);
format(String, sizeof(String), "You teleported to vehicle %d!", vehid);
SendClientMessage(playerid,yellow, String);
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd,"/xsee",true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 4)return SendClientMessage(playerid,red,"4 - ��� �� ���");
if(SeeDisconnect[playerid] == 0) SeeDisconnect[playerid] = 1,SendClientMessage(playerid, yellow, ".��� ��� ���� ������ ������� �����");
else SeeDisconnect[playerid] =0,SendClientMessage(playerid, yellow, ".��� ��� �� ���� ������ ������� �����");
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd,"/ppms",true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 4)return SendClientMessage(playerid,red,"4 - ��� �� ���");
if(SeePm[playerid] == 0) SeePm[playerid] = 1,SendClientMessage(playerid, yellow, ".��� ��� ���� ����");
else SeePm[playerid] =0,SendClientMessage(playerid, yellow, ".��� ��� �� ���� ����");
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd,"/pbomb",true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 5)return SendClientMessage(playerid,red,"5 - ��� �� ���");
if(SeeBomb[playerid] == 0) SeeBomb[playerid] = 1,SendClientMessage(playerid, yellow, ".��� ��� ���� ������");
else SeeBomb[playerid] =0,SendClientMessage(playerid, yellow, ".��� ��� �� ���� ������");
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd,"/plp",true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 5)return SendClientMessage(playerid,red,"5 - ��� �� ���");
if(SeeLp[playerid] == 0) SeeLp[playerid] = 1,SendClientMessage(playerid, yellow, "./LP - ��� ��� ���� ������ �������� �");
else SeeLp[playerid] =0,SendClientMessage(playerid, yellow, "./LP - ��� ��� �� ���� ������ �������� �");
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd,"/xAutoMSG",true) == 0)
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
tmp = strrest(cmdtext,idx);
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE, "Usage: /xAutoMSG [Message]");
SendFormatMessageToAll(Color_BB,"[Auto Message]: %s",tmp);
return 1;
}
//------------------------------------------------------------------------------
if(strcmp(cmd,"/xStunts",true) == 0){{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!xStuntsMission){
xStuntsMission=1;
format(String,100,"[Stunts Mission] >> ��� �� ����� ������ %s ������",GetName(playerid));
} else {
xStuntsMission=0;
format(String,100,"[Stunts Mission] >> ��� �� ����� ������ %s ������",GetName(playerid));}
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd,"/xMoney",true) == 0){{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!xMoneyMission){
xMoneyMission=1;
format(String,100,"[Money Mission] >> ��� �� ����� ���� %s ������",GetName(playerid));
} else {
xMoneyMission=0;
format(String,100,"[Money Mission] >> ��� �� ����� ���� %s ������",GetName(playerid));}
SendClientMessageToAll(COLOR_SATLA,String);}
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd,"/xCustomStats",true) == 0){{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!CustomStats){
CustomStats=1;
format(String,100,"[Stats System] >> ��� �� ������ ����� ��� %s ������",GetName(playerid));
} else {
CustomStats=0;
format(String,100,"[Stats System] >> ��� �� ������ ����� ��� %s ������",GetName(playerid));}
SendClientMessageToAll(COLOR_SATLA,String);}
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xRules", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
tmp = strtok(cmdtext, idx);
new Rulesid = strval(tmp);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "/xRules [playerid] - �����");
if(!IsPlayerConnected(Rulesid)) return SendClientMessage(playerid, COLOR_WHITE, ".����� �� ���� �����");
SendFormatMessage(Rulesid,-1,"����� �� �� ������ %s",GetName(playerid));
DOF2_SetInt(SFile(Rulesid),"ReadRules",1);
return 1;}
//------------------------------------------------------------------------------
if(!strcmp(cmd,"/XGw",true))
{
if(!IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,white,"/Help - ����� �� ���� �����,����� ���");
tmp = strtok(cmdtext, idx);
tmp2 = strtok(cmdtext, idx);
if(!strlen(tmp)) return SendClientMessage(playerid, red, "/XGW [Weapon ID] [Ammo]");
if(!strlen(tmp2)) return SendClientMessage(playerid, red, "/XGW [Weapon ID] [Ammo]");
new WeaponID = strval(tmp);
if(WeaponID==-1||WeaponID==19||WeaponID==20||WeaponID==21||WeaponID==0||WeaponID==44||WeaponID==45) return SendClientMessage(playerid,red,"ERROR: You have selected an invalid weapon ID.");
new Ammo = strval(tmp2);
new Float:P[3];
new WeaponName[24];
GetWeaponName(WeaponID,WeaponName,24); if(WeaponID == 18) WeaponName = "Molotov";
GetPlayerPos(playerid,P[0],P[1],P[2]);
for(new i = 0; i < MAX_PLAYERS; i++)
if(IsPlayerConnected(i) && i != playerid && IsPlayerInRangeOfPoint(i,GetRad(playerid),P[0],P[1],P[2]))
{
GivePlayerWeapon(i,WeaponID,Ammo);
format(string,sizeof(string),"Admin {ff0000}%s{fff000} has given you %d %s",GetName(playerid),Ammo,WeaponName);
SendClientMessage(i,yellow,string);
}
format(string,sizeof(string),"You have given %d %s all in Radius %d",Ammo,WeaponName,GetRad(playerid));
SendClientMessage(playerid,yellow,string);
return 1;}
if(!strcmp(cmd,"/XSS",true) || !strcmp(cmd,"/XSetSkin",true))
{
if(!IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,white,"/Help - ����� �� ���� �����,����� ���");
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) return SendClientMessage(playerid, red, "/XSS [SkinID]");
new Skin = strval(tmp);
if(!IsSkinValid(Skin)) return SendClientMessage(playerid,red,"ERROR: You have selected an invalid Skin ID.");
new Float:P[3];
GetPlayerPos(playerid,P[0],P[1],P[2]);
for(new i = 0; i < MAX_PLAYERS; i++)
if(IsPlayerConnected(i) && i != playerid && IsPlayerInRangeOfPoint(i,GetRad(playerid),P[0],P[1],P[2]))
{
SetPlayerSkin(i,Skin);
format(string,sizeof(string),"Admin {ff0000}%s{fff000} has Set your Skin to %d",GetName(playerid),Skin);
SendClientMessage(i,yellow,string);
}
format(string,sizeof(string),"You have Set All Skin's in Radius %d to %d",GetRad(playerid),Skin);
SendClientMessage(playerid,yellow,string);
return 1;}
if(!strcmp(cmd,"/xFull",true))
{
if(!IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,white,"/Help - ����� �� ���� �����,����� ���");
new Float:P[3];
GetPlayerPos(playerid,P[0],P[1],P[2]);
for(new i = 0; i < MAX_PLAYERS; i++)
if(IsPlayerConnected(i) && i != playerid && IsPlayerInRangeOfPoint(i,GetRad(playerid),P[0],P[1],P[2]))
{
SetPlayerHealth(i,100);
SetPlayerArmour(i,100);
format(string,sizeof(string),"Admin {ff0000}%s{fff000} has set your health and armor to 100 percent",GetName(playerid));
SendClientMessage(i,yellow,string);
}
format(string,sizeof(string),"You have set health and armour to 100 to all in Radius %d",GetRad(playerid));
SendClientMessage(playerid,yellow,string);
return 1;}
if(!strcmp(cmd,"/XCS",true))
{
if(!IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,white,"/Help - ����� �� ���� �����,����� ���");
tmp = strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,white,"/XCS [1 - 200]");
new Num = strval(tmp);
if(Num > 200 || Num < 1) return SendClientMessage(playerid,white,"/XCS [{FF2400}1{FFFFFF} - {FF2400}200{FFFFFF}]");
format(string,sizeof(string),"you have been Changed your Radius to %d",Num);
SendClientMessage(playerid,yellow,string);
DOF2_SetInt(SFile(playerid), "Radius",Num);
return 1;}
if(!strcmp(cmd,"/xVRa",true))
{
if(!IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,white,"/Help - ����� �� ���� �����,����� ���");
new Float:P[3];
GetPlayerPos(playerid,P[0],P[1],P[2]);
for(new i = 0; i < MAX_VEHICLES; i++)
if(i != playerid && IsCarInRangeOfPoint(i,GetRad(playerid),P[0],P[1],P[2]))
{
SetVehicleHealth(GetPlayerVehicleID(i),1000);
RepairVehicle(GetPlayerVehicleID(i));
format(string,sizeof(string),"Admin {ff0000}%s{fff000} has been successfully repaired your vehicle! ",GetName(playerid));
SendClientMessage(i,yellow,string);
}
format(string,sizeof(string),"You have been Rapired all Vehicles in Radius %d",GetRad(playerid));
SendClientMessage(playerid,yellow,string);
return 1;}
if(!strcmp(cmd,"/xSpawn",true))
{
if(!IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,white,"/Help - ����� �� ���� �����,����� ���");
new Float:P[3];
GetPlayerPos(playerid,P[0],P[1],P[2]);
for(new i = 0; i < MAX_PLAYERS; i++)
if(IsPlayerConnected(i) && i != playerid && IsPlayerInRangeOfPoint(i,GetRad(playerid),P[0],P[1],P[2]))
{
SpawnPlayer(i);
format(string,sizeof(string),"Admin {ff0000}%s{fff000} has been spawned you",GetName(playerid));
SendClientMessage(i,yellow,string);
}
format(string,sizeof(string),"You have been spawned all in Radius %d",GetRad(playerid));
SendClientMessage(playerid,yellow,string);
return 1;}
if(!strcmp(cmd,"/xFreeze",true) || !strcmp(cmd,"/XF",true))
{
if(!IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,white,"/Help - ����� �� ���� �����,����� ���");
new Float:P[3];
GetPlayerPos(playerid,P[0],P[1],P[2]);
for(new i = 0; i < MAX_PLAYERS; i++)
if(IsPlayerConnected(i) && i != playerid && IsPlayerInRangeOfPoint(i,GetRad(playerid),P[0],P[1],P[2]))
{
TogglePlayerControllable(i,false);
format(string,sizeof(string),"Admin {ff0000}%s{fff000} has frozen %s",GetName(playerid),GetName(i));
SendClientMessage(i,yellow,string);
}
format(string,sizeof(string),"You have frozen all in Radius %d",GetRad(playerid));
SendClientMessage(playerid,yellow,string);
return 1;}
if(!strcmp(cmd,"/xUnFreeze",true) || !strcmp(cmd,"/XUnF",true))
{
if(!IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,white,"/Help - ����� �� ���� �����,����� ���");
new Float:P[3];
GetPlayerPos(playerid,P[0],P[1],P[2]);
for(new i = 0; i < MAX_PLAYERS; i++)
if(IsPlayerConnected(i) && i != playerid && IsPlayerInRangeOfPoint(i,GetRad(playerid),P[0],P[1],P[2]))
{
TogglePlayerControllable(i,true);
format(string,sizeof(string),"Admin {ff0000}%s{fff000} has unfrozen %s",GetName(playerid),GetName(i));
SendClientMessage(i,yellow,string);
}
format(string,sizeof(string),"You have unfrozen all in Radius %d",GetRad(playerid));
SendClientMessage(playerid,yellow,string);
return 1;}
if(!strcmp(cmd,"/xRes",true))
{
if(!IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,white,"/Help - ����� �� ���� �����,����� ���");
new Float:P[3];
GetPlayerPos(playerid,P[0],P[1],P[2]);
for(new i = 0; i < MAX_VEHICLES; i++)
if(IsCarInRangeOfPoint(i,GetRad(playerid),P[0],P[1],P[2]) && i != playerid)
{
SetVehicleToRespawn(i);
format(string,sizeof(string),"Admin {ff0000}%s{fff000} has Spawned your vehicle!",GetName(playerid));
SendClientMessage(i,yellow,string);
}
format(string,sizeof(string),"You have been Spawned all Vehicles in Radius %d",GetRad(playerid));
SendClientMessage(playerid,yellow,string);
return 1;}
if(!strcmp(cmd,"/xRaw",true))
{
if(!IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,white,"/Help - ����� �� ���� �����,����� ���");
new Float:P[3];
GetPlayerPos(playerid,P[0],P[1],P[2]);
for(new i = 0; i < MAX_PLAYERS; i++)
if(IsPlayerConnected(i) && i != playerid && IsPlayerInRangeOfPoint(i,GetRad(playerid),P[0],P[1],P[2]))
{
ResetPlayerWeapons(i);
format(string,sizeof(string),"Admin {ff0000}%s{fff000} has reset your Weapons!",GetName(playerid));
SendClientMessage(i,yellow,string);
}
format(string,sizeof(string),"You have been Reset all Weapons in Radius %d",GetRad(playerid));
SendClientMessage(playerid,yellow,string);
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xAccess", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
DOF2_SetInt(SFile(playerid),"Honor",3),DOF2_SetInt(SFile(playerid),"Vip",3),DOF2_SetInt(SFile(playerid),"Supporters",4),DOF2_SetInt(SFile(playerid),"Nightteam",4);
SendClientMessage(playerid,COLOR_SATLA, "����� ����� ��� ������� ����");
return 1;
}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xRespawn", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
for(new i = 1; i <= MAX_VEHICLES; i++)
{
SetVehicleToRespawn(i);
}
return 1;
}
if(strcmp(cmd, "/xGodV", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, ".��� ���� ����� ����");
if(CarGM[GetPlayerVehicleID(playerid)]==0) CarGM[GetPlayerVehicleID(playerid)]=1,SendClientMessage(playerid, -1, ".����� �� ���� ���");
else CarGM[GetPlayerVehicleID(playerid)]=0,SendClientMessage(playerid, -1, ".���� �� ���� ��� ����");
return 1;
}
if(strcmp(cmd, "/xNeon", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
ShowPlayerDialog(playerid, neondialog1, DIALOG_STYLE_LIST, "Neon Color", "Blue\nRed\nGreen\nWhite\nPink\nYellow\nDelete Neon", "Select", "Cancel");
return 1;
}
if(strcmp(cmd, "/xCarDisco", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
CarDisco[playerid] = 1,SetTimerEx("CarDiscoO",200,1,"%d", playerid);
return 1;
}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xSetCarColor", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
tmp = strtok(cmdtext, idx);tmp2 = strtok(cmdtext, idx);
if(!strcmp(tmp,"Normal",true))return DOF2_SetInt(file,"Color1",-1),DOF2_SetInt(file,"Color2",-1),SendClientMessage(playerid,COLOR_WHITE,".���� ����� ���� , ���� ����");
if(!strlen(tmp)||!(strval(tmp) >= 0 && strval(tmp) <= 255)||!IsNumeric(tmp)||!IsNumeric(tmp2)) return SendClientMessage(playerid,COLOR_WHITE,"/SetCarColor [0-255 / Normal] [0-225] - �����");
if(!strlen(tmp2)) tmp2 = tmp;
format(String,256,".[%d,%d] ����� �� ��� ���� �",strval(tmp),strval(tmp2)),SendClientMessage(playerid,COLOR_WHITE,String),ChangeVehicleColor(GetPlayerVehicleID(playerid),strval(tmp),strval(tmp2)),DOF2_SetString(file,"Color1",tmp),DOF2_SetString(file,"Color2",tmp2);
return 1;
}
//------------------------------------------------------------------------------
if(!strcmp(cmd,"/xGMX",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(GMXOn == 1) return SendClientMessage(playerid,0xFF0000FF,"�� ����� �����");
new Reason[256];
tmp = strtok(cmdtext,idx);
if(!strlen(tmp))
{
GMXCD(0);
SendFormatMessageToAll(Color_GMX,"[GMX] ���� ����� ���� %s ������",GetName(playerid));
GMXOn = 1;
return 1;
}
new Num = strval(tmp);
Reason = strrest(cmdtext,idx);
if(!strlen(Reason))
{
GMXCD(Num);
SendFormatMessageToAll(Color_GMX,"[GMX] ���� %d ����� ����� ����� ����",Num);
GMXOn = 1;
return 1;
}
GMXCD(Num);
SendFormatMessageToAll(Color_GMX,"[GMX] ���� %d ����� ����� ����� ����",Num);
SendFormatMessageToAll(Color_GMX,"�����: %s",Reason);
GMXOn = 1;
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd,"/xCarSystem",true) == 0){{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!CarSystem){
CarSystem=1;
format(String,100,"[Car System] >> ��� �� ������ ����� ������ %s ������",GetName(playerid));
} else {
CarSystem=0;
format(String,100,"[Car System] >> ��� �� ������ ����� ������ %s ������",GetName(playerid));}
SendClientMessageToAll(COLOR_SATLA,String);}
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xSetPlayer", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
new pName[24];
GetPlayerName(playerid,pName,24);
new tmp3[256],tmp4[256],FileToChange[70];
tmp = strtok(cmdtext, idx),tmp2 = strtok(cmdtext, idx),tmp3 = strtok(cmdtext, idx),tmp4 = strtok(cmdtext, idx);
if(!strlen(tmp) || !strlen(tmp2) || !strlen(tmp3) || !strlen(tmp4)) return SendClientMessage(playerid,red,"Syntax Error: \"/xSetPlayer <NICK OR ID> <Player> <VAR NAME> <VALUE>\".");
if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
//if(!IsPlayerConnected(id) || id == INVALID_PLAYER_ID)return SendClientMessage(playerid,COLOR_KRED,"! ����� �� �����");
if(!strcmp(tmp2,"Player",true))format(FileToChange,70,"Users/%s.txt",GetName(id));
if(!strcmp(tmp2,"Car",true))format(FileToChange,70,"Car/car%d.txt",id);
if(!strcmp(tmp2,"Clans",true))format(FileToChange,70,"Clans/%s.ini",id);
if(!IsNumeric(tmp4))DOF2_SetString(FileToChange, tmp3, tmp4); else DOF2_SetInt(FileToChange, tmp3, strval(tmp4));
format(String,256,"You have set \"%s's\" Var \"%s\" to \"%s\"", GetName(id), tmp3, tmp4),SendClientMessage(playerid,yellow,String);
return 1;}
//------------------------------------------------------------------------------
if(!strcmp(cmd, "/xText", true)) {
new FID,fake[256],cfake[256];
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
new pName[24];
GetPlayerName(playerid,pName,24);
fake = strtok(cmdtext, idx);
if(!strlen(fake)) return SendClientMessage(playerid, COLOR_WHITE, "Usage:/xText [playerid] [Text]");
FID = strval(fake);
cfake = strrest(cmdtext, idx);
if(!strlen(fake)) return SendClientMessage(playerid, COLOR_WHITE, "Usage:/xText [playerid] [Text]");
if (!IsPlayerConnected(FID)) return SendClientMessage(playerid,COLOR_YELLOW,"����� �� �����");
OnPlayerText(FID,cfake);
return 1;}
//------------------------------------------------------------------------------
if(!strcmp("/xCmd", cmd, true)) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
new pName[24];
GetPlayerName(playerid,pName,24);
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, white, "/xCmd [id] [/cmd] :���� ������");
id = strval(cmd);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, Red, "����� �� �����");
tmp2 = strrest(cmdtext, idx);
if(!strlen(tmp2)) return SendClientMessage(playerid, white, "/xCmd [id] [/cmd] :���� ������");
SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(id,tmp2);
return 1;}
//------------------------------------------------------------------------------
if(!strcmp("/da", cmd, true) || !strcmp("/dialog", cmd, true)) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 3)return SendClientMessage(playerid,red,"3 - ��� �� ���");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, white, "/dialog [id] [Text] :���� ������");
id = strval(cmd);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, Red, "����� �� �����");
tmp2 = strrest(cmdtext, idx);
if(!strlen(tmp2)) return SendClientMessage(playerid, white, "/dialog [id] [Text] :���� ������");
format(SString, sizeof(SString), "Admin %s", GetName(playerid));
format(String, sizeof(String), "{FFFFFF}%s",tmp2);
ShowPlayerDialog(id,689,DIALOG_STYLE_MSGBOX,SString,String,"�����","");
return 1;}
//------------------------------------------------------------------------------
if(!strcmp("/xSayDialog", cmd, true)) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
tmp2 = strrest(cmdtext, idx);
if(!strlen(tmp2)) return SendClientMessage(playerid, white, "/xSayDialog [text] :���� ������");
id = strval(cmd);
format(SString, sizeof(SString), "Admin %s [id:%d]", GetName(playerid), playerid);
format(String, sizeof(String), "{FFFFFF}%s",tmp2);
for(new i; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) ShowPlayerDialog(i,689,DIALOG_STYLE_MSGBOX,SString,String,"�����","");
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/Spawn", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 3)return SendClientMessage(playerid,red,"3 - ��� �� ���");
tmp = strtok(cmdtext, idx);
new playerspawn = strval(tmp);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "/Spawn [playerid] - �����");
if(!IsPlayerConnected(playerspawn)) return SendClientMessage(playerid, COLOR_WHITE, ".����� �� ���� �����");
SetPlayerRandomSpawn(playerspawn);
SetPlayerVirtualWorld(playerspawn,0);
SetPlayerInterior(playerspawn,0);
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xGiveCarPlayer", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
tmp = strtok(cmdtext, idx);
new CarPlayer = strval(tmp);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "/xGiveCarPlayer [playerid] - �����");
if(!IsPlayerConnected(CarPlayer)) return SendClientMessage(playerid, COLOR_WHITE, ".����� �� ���� �����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
DOF2_SetInt(file,"CarOwned",1);
DOF2_SetString(file,"CarOwner",GetName(CarPlayer));
DOF2_SetInt(SFile(CarPlayer),"CarID",GetPlayerVehicleID(playerid));
DOF2_SetInt(SFile(CarPlayer),"OwnCar",1);
DOF2_SetInt(file,"PayTaxTime",30);
SetTimerEx("UpdateCar",1000,0,"d",GetPlayerVehicleID(playerid));
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xEditPayTax", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
tmp = strtok(cmdtext, idx);
new PayTax = strval(tmp);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "/xEditPayTax [Number] - �����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
DOF2_SetInt(file,"PayTaxTime",PayTax);
format(String,sizeof(String),".%s - ����� �� ��� ��� �",strval_fix(tmp)),SendClientMessage(playerid,COLOR_YELLOW,String);
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xPayTax", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(!DOF2_FileExists(file)){
SendClientMessage(playerid,red,"��� �� ���� ��� �� �����");
}else{
DOF2_SetInt(file,"PayTaxTime",99999999);
SendClientMessage(playerid,red,"!����� ���� �� �� ���, ����");
}
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xSellCar", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
new pName[24];
GetPlayerName(playerid,pName,24);
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
new vehicleid = GetPlayerVehicleID(playerid);
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(!DOF2_FileExists(file)){
SendClientMessage(playerid,red,"��� �� ���� ��� �� �����");
}else{
for	(new i=0;i<GetMaxPlayers();i++) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
DOF2_SetInt(SFile1(DOF2_GetString(file,"CarOwner")),"OwnCar",0);
DOF2_SetInt(SFile1(DOF2_GetString(file,"CarOwner")),"CarId",0);
DOF2_SetInt(file,"CarOwned",0);
DOF2_SetString(file,"CarOwner","none");
DOF2_SetInt(file,"SetPrice",0);
DOF2_SetString(file,"carname1",GetVehicleName(vehicleid));
strmid(DOF2_GetString(file,"CarOwner"), DOF2_GetString(file,"CarOwner"), 0, strlen(DOF2_GetString(file,"CarOwner")), 255);
printf("[Admin] %s Sold His Car, A %s ID %d",playername,GetVehicleName(GetPlayerVehicleID(playerid)),GetPlayerVehicleID(playerid));
UpdateCar(GetPlayerVehicleID(playerid));}
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xSetPrice", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
tmp = strtok(cmdtext, idx);
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE,"/xSetPrice [1-10,000,000] - �����");
if(!IsNumber(tmp))return SendClientMessage(playerid,COLOR_WHITE,"/xSetPrice [1-10,000,000] - �����");
if(strval_fix(tmp) < 1 || strval_fix(tmp) > 10000000)return SendClientMessage(playerid,COLOR_WHITE,"/xSetPrice [1-10,000,000] - �����");
DOF2_SetInt(file,"Price",strval_fix(tmp));
format(String,sizeof(String),".%s - ���� �� ���� �����",GetNum(strval_fix(tmp))),SendClientMessage(playerid,COLOR_LIGHTBLUE,String);
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xSetLevel", true) == 0) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
new PlayerLevel;
tmp = strtok(cmdtext,idx),id = strval(tmp);
if(!strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,"/xSetLevel [PlayerID] [Level] :�����");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid,COLOR_KRED,"! ����� �� �����");
tmp = strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,"/xSetLevel [PlayerID] [Level] :�����");
PlayerLevel = strval(tmp);
if(PlayerLevel < 1 || PlayerLevel > 32) return SendClientMessage(playerid,COLOR_KRED,"! ���� ���� ��� ����� � 1 �� 32");
DOF2_SetInt(SFile(id),"Level",PlayerLevel);
format(string,sizeof(string),"! %d �� ���� � ,\"%s\" ����� �����",PlayerLevel,GetName(id)),SendClientMessage(playerid,COLOR_YELLOW,string);
format(string,sizeof(string),"! %d ���� �� ���� ��� � ,\"%s\" ������",PlayerLevel,GetName(playerid)),SendClientMessage(id,COLOR_YELLOW,string);
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xSetBank", true) == 0) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
new PlayerBank;
tmp = strtok(cmdtext,idx),id = strval(tmp);
if(!strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,"/xSetBank [PlayerID] [Level] :�����");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid,COLOR_KRED,"! ����� �� �����");
tmp = strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,"/xSetBank [PlayerID] [Level] :�����");
PlayerBank = strval(tmp);
DOF2_SetInt(SFile(id),"Bank",PlayerBank);
format(string,sizeof(string),"! %s �� ���� ���� � ,\"%s\" ����� �����",GetNum(PlayerBank),GetName(id)),SendClientMessage(playerid,COLOR_YELLOW,string);
format(string,sizeof(string),"! %s ���� �� ���� ��� ���� � ,\"%s\" ������",GetNum(PlayerBank),GetName(playerid)),SendClientMessage(id,COLOR_YELLOW,string);
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xResetBank", true) == 0) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
tmp = strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "/xResetBank [PlayerID] :�����");
id = strval(tmp);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid,COLOR_KRED,"! ����� �� �����");
DOF2_SetInt(SFile(id),"Bank",0);
format(string,sizeof(string),"! �� ���� ���� \"%s\" ����� �����",GetName(id)),SendClientMessage(playerid,COLOR_YELLOW,string);
format(string,sizeof(string),"! ���� �� �� ���� ���� \"%s\" ������",GetName(playerid)),SendClientMessage(id,COLOR_YELLOW,string);
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xAddBank", true) == 0) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
new AddedMoneyInBank;
tmp = strtok(cmdtext,idx),id = strval(tmp);
if(!strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,"/xAddBank [PlayerID] [Money] :�����");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid,COLOR_KRED,"! ����� �� �����");
tmp = strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,"/xAddBank [PlayerID] [Money] :�����");
AddedMoneyInBank = strval(tmp);
DOF2_SetInt(SFile(id),"Bank",DOF2_GetInt(SFile(id),"Bank") + AddedMoneyInBank);
format(string,sizeof(string),"! %s :����� ���� \"%s\" ����� �����",GetNum(AddedMoneyInBank),GetName(id)),SendClientMessage(playerid,COLOR_ORANGE,string);
format(string,sizeof(string),"! %s :����� ����� ���� ��� \"%s\" ������",GetNum(AddedMoneyInBank),GetName(playerid)),SendClientMessage(id,COLOR_GREEN,string);
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xSetClan", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
tmp = strtok(cmdtext, idx);
new idname[24],ids = strval(tmp);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "/xSetClan [playerid] [ClanName] - �����");
if(!IsPlayerConnected(ids)) return SendClientMessage(playerid, COLOR_WHITE, "����� ���� �����");
GetPlayerName(ids,idname,24);
tmp2 = strrest(cmdtext, idx);
if(!strlen(tmp2))return SendClientMessage(playerid,COLOR_WHITE,"/xSetClan [playerid] [ClanName]");
DOF2_SetString(SFile(ids), "Clan",tmp2),DOF2_SetInt(SFile(ids),"ClanLevel",1);
ClanInvite[playerid] = 0;
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xSetLevelClan", true) == 0) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
new Killsid,Killsname[MAX_PLAYER_NAME],KillsNum;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE,"/xSetLevelClan [playerid] [LevelClan]");
if(!IsNumber(tmp))return SendClientMessage(playerid,COLOR_WHITE,"/xSetLevelClan [playerid] [LevelClan]");
Killsid = strval(tmp);
if(!IsPlayerConnected(Killsid))return SendClientMessage(playerid,COLOR_WHITE,"����� ���� �����");
GetPlayerName(Killsid,Killsname,sizeof(Killsname));
tmp = strtok(cmdtext, idx);
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE,"/xSetLevelClan [playerid] [LevelClan]");
KillsNum = strval(tmp);
format(String,sizeof(String), "��� �� �� ���� ����� %s ������",Killsname),SendClientMessage(Killsid,COLOR_YELLOW,String);
format(String,sizeof(String), "%d - �� ���� ����� � %s ���� �",KillsNum,Killsname),SendClientMessage(playerid,COLOR_YELLOW,String);
DOF2_SetInt(SFile(Killsid),"ClanLevel",KillsNum);
return 1;}
//------------------------------------------------------------------------------
if(strcmp(cmd, "/xSetKills", true) == 0) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
new Killsid,Killsname[MAX_PLAYER_NAME],KillsNum;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE,"/xSetKills [playerid] [Kills] - �����");
if(!IsNumber(tmp))return SendClientMessage(playerid,COLOR_WHITE,"/xSetKills [playerid] [Kills] - �����");
Killsid = strval(tmp);
if(!IsPlayerConnected(Killsid))return SendClientMessage(playerid,COLOR_WHITE,".����� ���� �����");
GetPlayerName(Killsid,Killsname,sizeof(Killsname));
tmp = strtok(cmdtext, idx);
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE,"/xSetKills [playerid] [Kills] - �����");
KillsNum = strval(tmp);
if(KillsNum < 0 || KillsNum > 80000)return SendClientMessage(playerid,COLOR_WHITE,"[Kills]0 - 80000");
format(String,sizeof(String), "��� �� �� ������� %s ������",Killsname),SendClientMessage(Killsid,COLOR_YELLOW,String);
format(String,sizeof(String), "%d - �� ������� � %s ���� �",KillsNum,Killsname),SendClientMessage(playerid,COLOR_YELLOW,String);
DOF2_SetInt(SFile(Killsid),"Kills",KillsNum);
return 1;}
//==============================================================================
if(!strcmp("/EditPointsA", cmd, true)) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
new any;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) return SendClientMessage(playerid, 0xFFFFFFFF, "/EditPointsA [Points]");
any = strval(tmp);
DOF2_SetInt("TeamAS.txt", "Score",any);
format(String,sizeof(String),"{FFFFFF}.%s {2E83EA}- ���� �� ������� �",tmp),SendClientMessage(playerid, COLOR_WHITE,String); return 1;}
//==============================================================================
if(!strcmp("/EditPointsB", cmd, true)) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
new any;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) return SendClientMessage(playerid, 0xFFFFFFFF, "/EditPointsB [Points]");
any = strval(tmp);
DOF2_SetInt("TeamBS.txt", "Score",any);
format(String,sizeof(String),"{FFFFFF}.%s {2E83EA}- ���� �� ������� �",tmp),SendClientMessage(playerid, COLOR_WHITE,String); return 1;}
//==============================================================================
if(!strcmp(cmd,"/TdmOpen",true)){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 2)return SendClientMessage(playerid,red,"2 - ��� �� ���");
tmp2 = strtok(cmdtext, idx);
new tdmtime = strval(tmp2);
if(!strlen(tmp2) || tdmtime < 1 || tdmtime > 1000) return SendClientMessage(playerid,COLOR_WHITE,"Usage: /TdmOpen [Time]");
if(!CantUseTDM) return SendClientMessage(playerid, COLOR_KRED, "! ����� ��� ����");
CantUseTDM=false,format(tmp,256,".� %d ���� TDM -��� �� ������ � %s ������",tdmtime,GetName(playerid)),SendClientMessageToAll(COLOR_LIGHTGREEN,tmp),SendClientMessageToAll(COLOR_LIGHTGREEN,"/TDM - ������ ����/�"),TDMTimer = SetTimer("TdmClose",tdmtime*100000,0);
return 1;}
//==============================================================================
if(strcmp(cmd, "/TdmClose", true) == 0){
new dname[MAX_PLAYER_NAME];
GetPlayerName(playerid,dname,MAX_PLAYER_NAME);
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 2)return SendClientMessage(playerid,red,"2 - ��� �� ���");
if(CantUseTDM)return SendClientMessage(playerid,Red,".����� ��� ����");
for(new i = 0; i < GetMaxPlayers(); i++){
if(IsPlayerConnected(i) && InTDM[i] == 1){
SetPlayerRandomSpawn(i);
ResetPlayerWeapons(playerid),SetPlayerSkin(playerid,OldInfo[playerid][1]),SetPlayerColor(playerid,OldInfo[playerid][0]);
InTDM[playerid] = 0,InTeamA[playerid] = 0,InTeamB[playerid] = 0,teamaplayers --,teambplayers --,SetPlayerTeam(playerid, playerid),TextDrawHideForPlayer(playerid, CopsPoints),TextDrawHideForPlayer(playerid, GangPoints);} }
CantUseTDM=true;
format(String, sizeof(String), ".TDM -��� �� ���� � %s ������", GetName(playerid)),SendClientMessageToAll(COLOR_KRED, String);
DOF2_RemoveFile("TeamAS.txt"),DOF2_RemoveFile("TeamBS.txt"),KillTimer(TDMTimer),ResetPlayerWeapons(playerid),InTDM[playerid] = 0,SetPlayerTeam(playerid,playerid); return 1;}
//==============================================================================
if(!strcmp(cmd,"/GunGameOpen",true) || !strcmp(cmd,"/GGOpen",true)){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 3)return SendClientMessage(playerid,red,"3 - ��� �� ���");
if(GunGameOn == 1) return SendClientMessage(playerid, COLOR_KRED, "! ����� ��� ����");
tmp2 = strtok(cmdtext, idx);
GunGameTime = strval(tmp2);
if(!strlen(tmp2) || GunGameTime < 1 || GunGameTime > 1000) return SendClientMessage(playerid,COLOR_WHITE,"Usage: /GunGameOpen [Time]");
GunGameOn = 1,format(tmp,256,".� %d ���� Gun-Game -��� �� ������ � %s ������",GunGameTime,GetName(playerid)),SendClientMessageToAll(COLOR_LIGHTGREEN,tmp),SendClientMessageToAll(COLOR_LIGHTGREEN,"/GG - ������ ����/�"),GunGameTime = SetTimer("GunGameClose",GunGameTime*100000,0);
return 1;}
//==============================================================================
if(!strcmp(cmd,"/GunGameClose",true) || !strcmp(cmd,"/GGClose",true)){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 3)return SendClientMessage(playerid,red,"3 - ��� �� ���");
if(GunGameOn == 0) return SendClientMessage(playerid, COLOR_KRED, "! ����� ��� ����");
for(new i = 0; i < MAX_PLAYERS; i++) if(InGunGame[i] == 1) SpawnPlayer(i),SetPlayerVirtualWorld(i,0),KillTimer(GunGameTime),ResetPlayerWeapons(i);
GunGameOn = 0,format(String, sizeof(String), ".Gun-Game -��� �� ���� � %s ������", GetName(playerid)),SendClientMessageToAll(COLOR_KRED, String);
return 1;}
if(!strcmp("/Lotto", cmd, true)){
if(!lotto[on]) return SendClientMessage(playerid, -1, "��� ���� ����");
if(GetPlayerMoney(playerid) < 2000) return SendClientMessage(playerid, 0xFF0000FF, ".$2,000 ��� ��");
if(pInfo[playerid][participant] == 1) return SendClientMessage(playerid, -1, "����� ��� �����");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd) || strval(cmd) > 50 || strval(cmd) < 1) return SendClientMessage(playerid, -1, "Usage: /Lotto [1-50]");
pInfo[playerid][participant] = 1;
pInfo[playerid][nnumber] = strval(cmd);
GivePlayerMoney(playerid, -2000);
lotto[pay] += 2000;
if(strval(cmd) == lotto[satla]) lotto[winners]++;
format(String, sizeof(String), "!%d ����� �� �����", pInfo[playerid][nnumber]);
SendClientMessage(playerid, 0x24FF0AB9, String);
return 1;}
//==============================================================================
if(!strcmp("/EditMoneyLotto", cmd, true)){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!lotto[on]) return SendClientMessage(playerid, COLOR_KRED, "! ��� ���� ����");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd) || strval(cmd) > 1000000 || strval(cmd) < 1) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /EditMoneyLotto [1-1,000,000]");
lotto[pay] = strval(cmd);
return 1;}
if(!strcmp("/EditNumberLotto", cmd, true)){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!lotto[on]) return SendClientMessage(playerid, COLOR_KRED, "! ��� ���� ����");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd) || strval(cmd) > 50 || strval(cmd) < 1) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /EditNumberLotto [1-50]");
lotto[satla] = strval(cmd),format(String, sizeof(String), ".%d :����� ���",lotto[satla]),SendClientMessage(playerid,COLOR_LIGHTBLUE, String);
return 1;}
//==============================================================================
if(strcmp(cmd,"/xLotto",true)==0){
tmp=strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/XLotto [Start | Stop]");
if(!strcmp(tmp,"Start",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(lotto[on]) return SendClientMessage(playerid, COLOR_KRED, "! �� ���� ����");
LottoCount(1),lotto[satla] = Random(1,50),format(String, sizeof(String), ".%d :����� ���",lotto[satla]),SendClientMessage(playerid,COLOR_LIGHTBLUE, String);
return 1;}
if(!strcmp(tmp,"Stop",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(lotto[on] == 0) return SendClientMessage(playerid, COLOR_KRED, "! ��� ���� ����");
for(new i; i < MAX_PLAYERS; i++) pInfo[i][participant] = 0;
lotto[satla] = 0,lotto[on] = 0,lotto[choose][lotto[satla]] = -1,lotto[pay] = 0,KillTimer(lotto[LottoTimer]);
format(String, sizeof(String), ".Lotto ���� �� � %s ������", GetName(playerid)),SendClientMessageToAll(COLOR_KRED,String);
return 1;}
return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/XLotto [Start | Stop]");}
//==============================================================================
if(!strcmp(cmd,"/xSwar",true))
{
cmd = strtok(cmdtext,idx);
if(!strlen(cmd)) return SendClientMessage(playerid,COLOR_WHITE,"Usage:/XSWar [Start | End]");
if(!strcmp(cmd,"start",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(SwarOn) return SendClientMessage(playerid,COLOR_WHITE,".������� ��� �����");
cmd = strtok(cmdtext,idx);
if(!strlen(cmd)) return SendClientMessage(playerid,COLOR_WHITE,"Usage:/xSwar Start <Reward>");
SwarReward = strval(cmd);
CallRemoteFunction("SwarStart","");
AID = playerid;
return 1;
}
else if(!strcmp(cmd,"end",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(!SwarOn) return SendClientMessage(playerid,COLOR_WHITE,".������� �� ����� ���");
if(SwarOn == 2) return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� ������ �� ������� ���");
GetPlayerName(playerid, Adminname, sizeof(Adminname));
CallRemoteFunction("SwarEnd","ii",1,-1);
return 1;
}
return 1;
}
//==============================================================================
if(!strcmp("/SWar", cmd, true)) {
new cmd2[256];
cmd2 = strtok(cmdtext, idx);
if(!SwarOn) return SendClientMessage(playerid,COLOR_WHITE,".��� ������ ���");
if(InSwar[playerid]) return SendClientMessage(playerid,COLOR_WHITE,".��� ����� �������, ��� ��� �������");
if(SwarPlayers == sizeof(Spawns)) return SendClientMessage(playerid,COLOR_WHITE,".�� ������� �����");
if(!strlen(cmd2)) return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: /SWar [Number]");
if(strval(cmd2) != ActNumber) return SendClientMessage(playerid, 0xFFFFFFFF, "! ����� �� ����");
InSwar[playerid] = 1;
SwarPlayers ++;
if(SwarPlayers == 20) SendClientMessageToAll(0xFF0000FF, "�� ������� ������� �����");
InWar[playerid] = 1;
SendFormatMessage(playerid,COLOR_LIGHTBLUEGREEN,"[20/%d] - ������, ���� ����� ���� Swar ����� �������",SwarPlayers);
ShowPlayerDialog(playerid,66661,DIALOG_STYLE_MSGBOX,"Sultan War","!\"Sultan War \" ����� ������ �������\n ����� ������� �� ��� ����� ������ �� ��� �������\n\n .�� ����� ���� �� ����� - ���� ��������\n !������","����","");
return 1;}
//==============================================================================
if(strcmp(cmd,"/xMini",true)==0){
tmp=strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/XMini [Start | End]");
if(!strcmp(tmp,"Start",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(MiniOn == 1)return SendClientMessage(playerid,red,"�� ������ �����");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, white, "/XMini Start [Reward] :���� ������");
MiniReward = strval(cmd);
ActNumber = 5 + random(28);
atime = gettime();
AID = playerid;
for(new i = 0; i < GetMaxPlayers(); i++)
if(IsPlayerConnected(i)){InMini[i] = 0; PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);}
SendClientMessageToAll(0x0EBFDEC8, " --- Minigun System ---");
SendClientMessageToAll(COLOR_WHITE, "! ������ ������� ����");
SendFormatMessageToAll(COLOR_WHITE,"/Mini %d - ���� ������  ���/�",ActNumber);
format(String,sizeof(String),"{A0D911}$%s{FFFFFF} ��� �����",GetNum(MiniReward));
SendClientMessageToAll(COLOR_WHITE,String);
SendClientMessageToAll(COLOR_WHITE," ������ �����");
SendClientMessageToAll(0x0EBFDEC8, "--------------------------------");
MiniOn = 1,MiniPlayers = 0,MiniStarted = 0,MiniCount = 25,MiniCountFuc = 1,MiniCD();
return 1;}
if(!strcmp(tmp,"End",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(MiniOn == 0)return SendClientMessage(playerid,red,"��� ������ �����");
MiniEnd(2);
if(MiniStarted == 1){
for(new i = 0; i < GetMaxPlayers(); i++){
if(InMini[i] == 1)SetPlayerRandomSpawn(i);}}
MiniOn = 0,MiniPlayers = 0,MiniStarted = 0,format(String,sizeof(String),"���� �� ������� %s ������",GetName(playerid)),SendClientMessageToAll(yellow,String);
for(new i = 0; i < GetMaxPlayers(); i++)InMini[i] =0;
KillTimer(MiniWinnerCheck),MiniCount = -1;
return 1;}
return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/XMini [Start | End]");}
//==============================================================================
if(!strcmp(cmd, "/Mini", true))
{
new cmd2[256];
cmd2 = strtok(cmdtext, idx);
if(MiniOn == 0) return SendClientMessage(playerid,0xFFFFFFFF, ".��� ������ ���");
if(MiniStarted == 1) return SendClientMessage(playerid,COLOR_WHITE, ".������� ��� ����, �������");
if(InMini[playerid] == 1) return SendClientMessage(playerid,0xFFFFFFFF, ".��� ����� �������, ��� ���� �������");
if(!strlen(cmd2)) return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: /Mini [Number]");
if(strval(cmd2) != ActNumber) return SendClientMessage(playerid, 0xFFFFFFFF, "! ����� �� ����");
if(MiniPlayers >= 40) return SendClientMessage(playerid,COLOR_WHITE, "! �������, �� ������� �����");
MiniPlayers ++;
if(MiniPlayers == 40) SendClientMessageToAll(0xFF0000FF, "! ����� Mini �� ������� ������� �");
InMini[playerid] = 1;
format(String, sizeof(String), "[40/%d] - ������, ���� ����� ���� Mini ����� �������",MiniPlayers);
SendClientMessage(playerid,0x0F66AFF, String);
ShowPlayerDialog(playerid,66661,DIALOG_STYLE_MSGBOX,"���� �������","{FFFFFF}:���� �������\n - ���� ����� ��� ����\n - ESC ���� ����� ����� �������\n - ���� ���� ������ �� �������\n - ���� ���� ����� ������� �� ������ ��� �� ���� ����� ���\n\n������","�����","");
return 1;}
//==============================================================================
if(strcmp(cmd,"/xWeapons",true)==0){
tmp=strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/XWeapons [Start | End]");
if(!strcmp(tmp,"Start",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
WeaponsMoney = strval(strtok(cmdtext, idx));
WeaponsWeapon = strval(strtok(cmdtext, idx));
if(!WeaponsMoney || !WeaponsWeapon) return SendClientMessage(playerid,COLOR_WHITE,"Usage: /XWeapons Start [Reward] [Weapon]");
if(WeaponsWeapon < 1 || WeaponsWeapon > 46) return SendClientMessage(playerid,COLOR_WHITE,"Usage: /XWeapons [Weapon: 1-46]");
ActNumber = 5 + random(28);
atime = gettime();
AID = playerid;
SendClientMessageToAll(0x0EBFDEC8, " --- Weapons System ---");
SendClientMessageToAll(COLOR_WHITE, "! ������ ������� ����");
SendFormatMessageToAll(COLOR_WHITE,"/Weapons %d - ���� ������  ���/�",ActNumber);
format(String,sizeof(String),"{A0D911}$%s{FFFFFF} ��� �����",GetNum(WeaponsMoney));
SendClientMessageToAll(-1,String);
SendClientMessageToAll(COLOR_WHITE," ������ �����");
SendClientMessageToAll(0x0EBFDEC8, "--------------------------------");
WeaponsOn = 1,WeaponsPlayers = 0,WeaponsStarted = 0,WeaponsCd(30,1);
return 1;}
if(!strcmp(tmp,"End",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(WeaponsOn == 0) return SendClientMessage(playerid,COLOR_KRED, ".��� ������ ���");
WeaponsOn = 0,WeaponsPlayers = 0,WeaponsStarted = 0,KillTimer(WeaponsWinnerCheck);
format(String, sizeof(String), ".Weapons ���� �� ������� � %s ������", GetName(playerid)),SendClientMessageToAll(COLOR_KRED,String);
return 1;}
return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/XWeapons [Start | End]");}
//==============================================================================
if(!strcmp(cmd, "/Weapons", true))
{
new cmd2[256];
cmd2 = strtok(cmdtext, idx);
if(WeaponsOn == 0) return SendClientMessage(playerid,0xFFFFFFFF, ".��� ������ ���");
if(WeaponsStarted == 1) return SendClientMessage(playerid,COLOR_WHITE, ".������� ��� ����, �������");
if(InWeapons[playerid] == 1) return SendClientMessage(playerid,0xFFFFFFFF, ".��� ����� �������, ��� ���� �������");
if(!strlen(cmd2)) return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: /Weapons [Number]");
if(strval(cmd2) != ActNumber) return SendClientMessage(playerid, 0xFFFFFFFF, "! ����� �� ����");
if(WeaponsPlayers >= 50) return SendClientMessage(playerid,COLOR_WHITE, "! �������, �� ������� �����");
WeaponsPlayers ++;
if(WeaponsPlayers == 50) SendClientMessageToAll(0xFF0000FF, "! ����� Weapons �� ������� ������� �");
InWeapons[playerid] = 1;
format(String, sizeof(String), "[50/%d] - ������, ���� ����� ���� Weapons ����� �������",WeaponsPlayers);
SendClientMessage(playerid,0x0F66AFF, String);
return 1;}
//==============================================================================
if(strcmp(cmd,"/XWar",true)==0){
tmp=strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/XWar [Start | End]");
if(!strcmp(tmp,"Start",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(WarOn == 1)return SendClientMessage(playerid,red,"�� ������ �����");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, white, "/XWar Start [Reward] :���� ������");
WarReward = strval(cmd);
ActNumber = 5 + random(28);
atime = gettime();
AID = playerid;
for(new i = 0; i < GetMaxPlayers(); i++)
if(IsPlayerConnected(i)){InMini[i] = 0; PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);}
SendClientMessageToAll(0x0EBFDEC8, " --- War System ---");
SendClientMessageToAll(COLOR_WHITE, "! ������ ������� ����");
SendFormatMessageToAll(COLOR_WHITE,"/War %d - ���� ������  ���/�",ActNumber);
format(String,sizeof(String),"{A0D911}$%s{FFFFFF} ��� �����",GetNum(WarReward));
SendClientMessageToAll(-1,String);
SendClientMessageToAll(COLOR_WHITE," ������ �����");
SendClientMessageToAll(0x0EBFDEC8, "--------------------------------");
WarOn = 1,WarPlayers = 0,WarStarted = 0,WarCount = 25,WarCountFuc = 1,WarCD();
return 1;}
if(!strcmp(tmp,"End",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(WarOn == 0)return SendClientMessage(playerid,red,"��� ������ �����");
if(WarStarted == 1){
for(new i = 0; i < GetMaxPlayers(); i++){
if(InWar[i] ==1)SetPlayerRandomSpawn(i);}}
WarOn = 0,WarPlayers = 0,WarStarted = 0,format(String,sizeof(String),"���� �� ������� %s ������",GetName(playerid)),SendClientMessageToAll(yellow,String);
for(new i = 0; i < GetMaxPlayers(); i++)InWar[i] =0;
KillTimer(WarWinnerCheck),WarCount = -1;
return 1;}
return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/XWar [Start | End]");}
//==============================================================================
if(!strcmp("/War", cmd, true)) {
new cmd2[256];
cmd2 = strtok(cmdtext, idx);
if(WarOn == 0) return SendClientMessage(playerid,0xFFFFFFFF, ".��� ������ ���");
if(WarStarted == 1) return SendClientMessage(playerid,COLOR_WHITE, ".������� ��� ����, �������");
if(InWar[playerid] == 1) return SendClientMessage(playerid,0xFFFFFFFF, ".��� ����� �������, ��� ���� �������");
if(!strlen(cmd2)) return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: /War [Number]");
if(strval(cmd2) != ActNumber) return SendClientMessage(playerid, 0xFFFFFFFF, "! ����� �� ����");
if(MiniPlayers >= 20) return SendClientMessage(playerid,COLOR_WHITE, "! �������, �� ������� �����");
WarPlayers ++;
if(WarPlayers == 20) SendClientMessageToAll(0xFF0000FF, "! ����� War �� ������� ������� �");
InWar[playerid] = 1;
format(String, sizeof(String), "[20/%d] - ������, ���� ����� ���� War ����� �������",WarPlayers);
SendClientMessage(playerid,0x0F66AFF, String);
return 1;}
//==============================================================================
if(strcmp(cmd,"/XMonster",true)==0){
tmp=strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/XMonster [Start | End]");
if(!strcmp(tmp,"Start",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(MonsterOn == 1)return SendClientMessage(playerid,red,"�� ������ �����");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, white, "/XMonster Start [Reward] :���� ������");
MonsterReward = strval(cmd);
ActNumber = 5 + random(28);
atime = gettime();
AID = playerid;
for(new i = 0; i < GetMaxPlayers(); i++)
if(IsPlayerConnected(i)){InMini[i] = 0; PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);}
SendClientMessageToAll(0x0EBFDEC8, " --- Monster System ---");
SendClientMessageToAll(COLOR_WHITE, "! ������ ������� ����");
SendFormatMessageToAll(COLOR_WHITE,"/Monster %d - ���� ������  ���/�",ActNumber);
format(String,sizeof(String),"{A0D911}$%s{FFFFFF} ��� �����",GetNum(MonsterReward));
SendClientMessageToAll(-1,String);
SendClientMessageToAll(COLOR_WHITE," ������ �����");
SendClientMessageToAll(0x0EBFDEC8, "--------------------------------");
MonsterOn = 1,MonsterPlayers = 0,MonsterStarted = 0,MonsterCount = 25,MonsterCountFuc = 1,MonsterCD();
return 1;}
if(!strcmp(tmp,"End",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(MonsterOn == 0)return SendClientMessage(playerid,red,"��� ������ �����");
if(MonsterStarted == 1){
for(new i = 0; i < GetMaxPlayers(); i++){
if(InMonster[i] == 1)SetPlayerRandomSpawn(i);}}
MonsterOn = 0,MonsterPlayers = 0,MonsterStarted = 0;
format(String,sizeof(String),"���� �� ������� %s ������",GetName(playerid)),SendClientMessageToAll(yellow,String);
for(new i = 0; i < GetMaxPlayers(); i++)InMonster[i] =0;
KillTimer(MonsterWinnerCheck);
MonsterCount = -1;
return 1;}
return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/XMonster [Start | End]");}
//==============================================================================
if(!strcmp("/Monster", cmd, true)) {
new cmd2[256];
cmd2 = strtok(cmdtext, idx);
if(MonsterOn == 0) return SendClientMessage(playerid,0xFFFFFFFF, ".��� ������ ���");
if(MonsterStarted == 1) return SendClientMessage(playerid,COLOR_WHITE, ".������� ��� ����, �������");
if(InMonster[playerid] == 1) return SendClientMessage(playerid,0xFFFFFFFF, ".��� ����� �������, ��� ���� �������");
if(!strlen(cmd2)) return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: /Monster [Number]");
if(strval(cmd2) != ActNumber) return SendClientMessage(playerid, 0xFFFFFFFF, "! ����� �� ����");
if(MonsterPlayers >= 20) return SendClientMessage(playerid,COLOR_WHITE, "! �������, �� ������� �����");
MonsterPlayers ++;
if(MonsterPlayers == 20) SendClientMessageToAll(0xFF0000FF, "! ����� Monster �� ������� ������� �");
InMonster[playerid] = 1;
format(String, sizeof(String), "[20/%d] - ������, ���� ����� ���� Monster ����� �������",MonsterPlayers);
SendClientMessage(playerid,0x0F66AFF, String);
return 1;}
//==============================================================================
if(strcmp(cmd,"/XTanks",true)==0){
tmp=strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/XTanks [Start | End]");
if(!strcmp(tmp,"Start",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(TanksOn == 1)return SendClientMessage(playerid,red,"�� ������ �����");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, white, "/XTanks Start [Reward] :���� ������");
TanksReward = strval(cmd);
ActNumber = 5 + random(28);
atime = gettime();
AID = playerid;
for(new i = 0; i < GetMaxPlayers(); i++)
if(IsPlayerConnected(i)){InMini[i] = 0; PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);}
SendClientMessageToAll(0x0EBFDEC8, " --- Tanks System ---");
SendClientMessageToAll(COLOR_WHITE, "! ������ ������� ����");
SendFormatMessageToAll(COLOR_WHITE,"/Tanks %d - ���� ������  ���/�",ActNumber);
format(String,sizeof(String),"{A0D911}$%s{FFFFFF} ��� �����",GetNum(TanksReward));
SendClientMessageToAll(-1,String);
SendClientMessageToAll(COLOR_WHITE," ������ �����");
SendClientMessageToAll(0x0EBFDEC8, "--------------------------------");
TanksOn = 1,TanksPlayers = 0,TanksStarted = 0,TanksCount = 25,TanksCountFuc = 1,TanksCD();
return 1;}
if(!strcmp(tmp,"End",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(TanksOn == 0)return SendClientMessage(playerid,red,"��� ������ �����");
if(TanksStarted == 1){
for(new i = 0; i < GetMaxPlayers(); i++){
if(InTanks[i] == 1)SetPlayerRandomSpawn(i);}}
TanksOn = 0,TanksPlayers = 0,TanksStarted = 0;
format(String,sizeof(String),"���� �� ������� %s ������",GetName(playerid)),SendClientMessageToAll(yellow,String);
for(new i = 0; i < GetMaxPlayers(); i++)InTanks[i] =0;
KillTimer(TanksWinnerCheck);
TanksCount = -1;
return 1;}
return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/XTanks [Start | End]");}
//==============================================================================
if(!strcmp("/Tanks", cmd, true)) {
new cmd2[256];
cmd2 = strtok(cmdtext, idx);
if(TanksOn == 0) return SendClientMessage(playerid,0xFFFFFFFF, ".��� ������ ���");
if(TanksStarted == 1) return SendClientMessage(playerid,COLOR_WHITE, ".������� ��� ����, �������");
if(InTanks[playerid] == 1) return SendClientMessage(playerid,0xFFFFFFFF, ".��� ����� �������, ��� ���� �������");
if(!strlen(cmd2)) return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: /Tanks [Number]");
if(strval(cmd2) != ActNumber) return SendClientMessage(playerid, 0xFFFFFFFF, "! ����� �� ����");
if(TanksPlayers >= 20) return SendClientMessage(playerid,COLOR_WHITE, "! �������, �� ������� �����");
TanksPlayers ++;
if(TanksPlayers == 20) SendClientMessageToAll(0xFF0000FF, "! ����� Tanks �� ������� ������� �");
InTanks[playerid] = 1;
format(String, sizeof(String), "[20/%d] - ������, ���� ����� ���� Tanks ����� �������",TanksPlayers);
SendClientMessage(playerid,0x0F66AFF, String);
return 1;}
//==============================================================================
if(strcmp(cmd,"/XBoom",true)==0){
tmp=strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/XBoom [Start | End]");
if(!strcmp(tmp,"Start",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(BoomOn == 1)return SendClientMessage(playerid,red,"�� ������ �����");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, white, "/XBoom Start [Reward] :���� ������");
BoomReward = strval(cmd);
ActNumber = 5 + random(28);
atime = gettime();
AID = playerid;
for(new i = 0; i < GetMaxPlayers(); i++)
if(IsPlayerConnected(i)){InMini[i] = 0; PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);}
SendClientMessageToAll(0x0EBFDEC8, " --- Boom System ---");
SendClientMessageToAll(COLOR_WHITE, "! ������ ������� ����");
SendFormatMessageToAll(COLOR_WHITE,"/Boom %d - ���� ������  ���/�",ActNumber);
format(String,sizeof(String),"{A0D911}$%s{FFFFFF} ��� �����",GetNum(BoomReward));
SendClientMessageToAll(-1,String);
SendClientMessageToAll(COLOR_WHITE," ������ �����");
SendClientMessageToAll(0x0EBFDEC8, "--------------------------------");
BoomOn = 1,BoomPlayers = 0,BoomStarted = 0,BoomCount = 25,BoomCountFuc = 1,BoomCD();
return 1;}
if(!strcmp(tmp,"End",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(BoomOn == 0)return SendClientMessage(playerid,red,"��� ������ �����");
if(BoomStarted == 1){
for(new i = 0; i < GetMaxPlayers(); i++){
if(InBoom[i] == 1)SetPlayerRandomSpawn(i);}}
BoomOn = 0,BoomPlayers = 0,BoomStarted = 0;
format(String,sizeof(String),"���� �� ������� %s ������",GetName(playerid)),SendClientMessageToAll(yellow,String),KillTimer(BoomWinnerCheck);
for(new i = 0; i < GetMaxPlayers(); i++)InBoom[i] =0;
BoomCount = -1;
return 1;}
return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/XBoom [Start | End]");}
//==============================================================================
if(!strcmp(cmd, "/Boom", true))
{
new cmd2[256];
cmd2 = strtok(cmdtext, idx);
if(BoomOn == 0)return SendClientMessage(playerid,COLOR_WHITE,"��� ������ �����");
if(BoomStarted == 1) return SendClientMessage(playerid,COLOR_WHITE,"������� ��� ������");
if(InBoom[playerid] == 1) return SendClientMessage(playerid,0xFFFFFFFF, ".��� ����� �������, ��� ���� �������");
if(!strlen(cmd2)) return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: /Boom [Number]");
if(strval(cmd2) != ActNumber) return SendClientMessage(playerid, 0xFFFFFFFF, "! ����� �� ����");
if(BoomPlayers >= 40) return SendClientMessage(playerid,COLOR_WHITE, "! �������, �� ������� �����");
BoomPlayers ++;
if(BoomPlayers == 40) SendClientMessageToAll(0xFF0000FF, "! ����� Mini �� ������� ������� �");
InBoom[playerid] = 1;
format(String, sizeof(String), "[40/%d] - ������, ���� ����� ���� Boom ����� �������",BoomPlayers);
SendClientMessage(playerid,0x0F66AFF, String);
return 1;}
//==============================================================================
if(strcmp(cmd, "/ExitRc", true) == 0)
{
new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
switch(Model) { case 501,465,564,441,464,594: return RemovePlayerFromVehicle(playerid) ,DestroyVehicle(GetPlayerVehicleID(playerid));}
SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� RC ");
return 1;}
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 501) return SendClientMessage(playerid, red, "�� ���� ������ ������� ���� �� ��� ���� ���: /exitrc");
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 465) return SendClientMessage(playerid, red, "�� ���� ������ ������� ���� �� ��� ���� ���: /exitrc");
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 564) return SendClientMessage(playerid, red, "�� ���� ������ ������� ���� �� ��� ���� ���: /exitrc");
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 441) return SendClientMessage(playerid, red, "�� ���� ������ ������� ���� �� ��� ���� ���: /exitrc");
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 464) return SendClientMessage(playerid, red, "�� ���� ������ ������� ���� �� ��� ���� ���: /exitrc");
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 594) return SendClientMessage(playerid, red, "�� ���� ������ ������� ���� �� ��� ���� ���: /exitrc");
//-------------------------------------------------------------------------------------------
if(strcmp(cmd, "/AnimList", true) == 0) return ShowPlayerDialog(playerid,5887,DIALOG_STYLE_MSGBOX,"��������","/Surrender\n/Drunk\n/SWalk\n/MTalk\n/WD\n/Arrest\n/Laugh\n/Lookout\n/Rob\n/Wankin\n/Coparrest\n/Wankout\n/Arrested\n/Injured\n/Sled\n/Fsmoking\n/Coplook\n/Lay\n/Vomit\n/Eat\n/Wave\n/Slapass\n/Death\n/Deal\n/Kiss\n/Crack\n/Piss\n/Smoke\n/Sit\n/Fu\n/Strip\n/Pee\n/Drink\n/Dance","�����","�����");
if(strcmp(cmd, "/Surrender", true) == 0) return (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)? SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP):1;
if(strcmp(cmd, "/Drunk", true) == 0) if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) return ApplyAnimation(playerid,"PED", "WALK_DRUNK",4.0,0,1,0,0,0),SendClientMessage(playerid, 0xFF0000FF, "You are now walking like a drunk man");
if(strcmp(cmd, "/SWalk", true) == 0) if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) return ApplyAnimation(playerid,"PED","WOMAN_walksexy", 4.0,1,1,1,1,0),SendClientMessage(playerid, 0xFF0000FF, "����� �����"),anim[playerid] = 1;
if(strcmp(cmd, "/MTalk", true) == 0) if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) return ApplyAnimation(playerid,"PED","IDLE_CHAT",4.0,1,0,0,1,1),SendClientMessage(playerid, 0xFF0000FF, "����� �����");
if(strcmp(cmd, "/Wd", true) == 0) if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) return ApplyAnimation(playerid,"PED","WALK_drunk",4.0,1,1,1,1,0),SendClientMessage(playerid, 0xFF0000FF, "����� �����"),anim[playerid] = 1;
if(strcmp("/Arrest", cmdtext, true, 7) == 0) return ApplyAnimation( playerid,"ped", "ARRESTgun", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Laugh", cmdtext, true) == 0) return ApplyAnimation(playerid, "RING", "Laugh_01", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Lookout", cmdtext, true) == 0) return ApplyAnimation(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Rob", cmdtext, true) == 0) return ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Wankin", cmdtext, true) == 0) return ApplyAnimation(playerid, "PAULNMAC", "wank_loop", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/CopArrest", cmdtext, true) == 0) return ApplyAnimation(playerid, "POLICE", "plc_drgbst_01", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Wankout", cmdtext, true) == 0) return ApplyAnimation(playerid, "PAULNMAC", "wank_out", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Arrested", cmdtext, true) == 0) return ApplyAnimation(playerid, "POLICE", "crm_drgbst_01", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Injured", cmdtext, true) == 0) return ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Sled", cmdtext, true) == 0) return ApplyAnimation(playerid, "SWEET", "ho_ass_sled", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Fsmoking", cmdtext, true) == 0) return ApplyAnimation(playerid, "SMOKING", "F_smklean_loop", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Coplook", cmdtext, true) == 0) return ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Lay", cmdtext, true, 6) == 0) return ApplyAnimation(playerid,"BEACH", "bather", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Vomit", cmdtext, true) == 0) return ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0);
if(strcmp("/Eat", cmdtext, true) == 0) return ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.00, 0, 0, 0, 0, 0);
if(strcmp("/Wave", cmdtext, true) == 0) return ApplyAnimation(playerid, "KISSING", "BD_GF_Wave", 3.0, 0, 0, 0, 0, 0);
if(strcmp("/Slapass", cmdtext, true) == 0) return ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Death", cmdtext, true) == 0) return ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Deal", cmdtext, true) == 0) return ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Kiss", cmdtext, true, 5) == 0) return ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 3.0, 0, 0, 0, 0, 0);
if(strcmp("/Crack", cmdtext, true, 6) == 0) return ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 0, 0, 0, 0, 0);
if(strcmp("/Piss", cmdtext, true) == 0) return ApplyAnimation(playerid, "PAULNMAC", "Piss_in", 3.0, 0, 0, 0, 0, 0);
if(strcmp(cmdtext, "/Smoke", true) == 0) if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) return ApplyAnimation(playerid,"SMOKING","M_smklean_loop",4.1,1,1,1,1,1);
if(strcmp("/Sit", cmdtext, true, 4) == 0) return ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 4.0,1,1,1,1,0),anim[playerid] = 1;
if(strcmp("/Fu", cmdtext, true) == 0) return ApplyAnimation( playerid,"ped", "fucku", 4.1, 0, 1, 1, 1, 1 );
if(strcmp(cmd, "/pee", true) == 0) return SetPlayerSpecialAction(playerid,68);
if(strcmp("/Strip", cmdtext, true, 6) == 0){
switch(cmdtext[7]){
case 'a','A':ApplyAnimation(playerid,"STRIP", "strip_A", 4.1, 0, 1, 1, 1, 1);
case 'b','B':ApplyAnimation(playerid,"STRIP", "strip_B", 4.1, 0, 1, 1, 1, 1);
case 'c','C':ApplyAnimation(playerid,"STRIP", "strip_C", 4.1, 0, 1, 1, 1, 1);
case 'd','D':ApplyAnimation(playerid,"STRIP", "strip_D", 4.1, 0, 1, 1, 1, 1);
case 'e','E':ApplyAnimation(playerid,"STRIP", "strip_E", 4.1, 0, 1, 1, 1, 1);
case 'f','F':ApplyAnimation(playerid,"STRIP", "strip_F", 4.1, 0, 1, 1, 1, 1);
case 'g','G':ApplyAnimation(playerid,"STRIP", "strip_G", 4.1, 0, 1, 1, 1, 1);}
return 1;}
if(strcmp(cmd, "/Drink", true) == 0){
new DrinkStyle;
tmp = strtok(cmdtext, idx);
if(!strlen(tmp) || DrinkStyle < 1 || DrinkStyle > 3)return SendClientMessage(playerid,COLOR_WHITE,"Usage: /Drink [1-3]");
DrinkStyle = strval(tmp);
if(!strcmp(tmp,"off",true))StopLoopingAnim(playerid);
if(DrinkStyle == 1)SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
else if(DrinkStyle == 2)SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
else if(DrinkStyle == 3)SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
Drinked[playerid] = 1;
return 1;}
//==============================================================================
if(strcmp(cmdtext,"/phonehelp",true) == 0){
SendClientMessage(playerid, 0x1E90FFFF,"--- ����� ����� ---");
SendClientMessage(playerid,COLOR_WHITE,"/Call [ID] - ����� ���� ����");
SendClientMessage(playerid,COLOR_WHITE,"/Answer - ����� �����");
SendClientMessage(playerid,COLOR_WHITE,"/Hangup - ���� �� �����");
SendClientMessage(playerid,COLOR_WHITE,"/IgnoreCall - ���� ������ ������");
SendClientMessage(playerid, 0x1E90FFFF,"------------------");
return 1;}
//==============================================================================
if(strcmp(cmd,"/call",true) == 0)
{
cmd = strtok(cmdtext, idx);
id = strval(cmd);
if(!strlen(cmd)) return SendClientMessage(playerid,RED,"Usage: /Call [ID]");
if(Tallking[playerid] == 1) return SendClientMessage(playerid, RED,".��� ��� �����");
if(id == playerid) return SendClientMessage(playerid,RED,".���� ���� ������ �����");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED,".�����/�� �� �����/�");
if(Ignore[playerid][id])return SendClientMessage(playerid,RED,"���� �� ����� ���"),0;
if(Ignore[id][playerid])return SendClientMessage(playerid,RED,"����� ��� ����"),0;
if(InCall[id] == 1)
{
SendClientMessage(playerid,RED,".����� ��� �����... ����� �� �� ������ ���� ���� ��� ����� ����");
format(str,sizeof(str),".���� ����� ���� (%d) ����� \"%s\"",playerid,GetName(playerid));
SendClientMessage(id,ORANGE,str);
return 1;
}
format(str,sizeof(str),"...\"%s\" ����� �� ",GetName(id));
SendClientMessage(playerid,YELLOW,str);
format(str,sizeof(str),".����� ����� \"%s\" �����",GetName(playerid));
SendClientMessage(id,ORANGE,str);
SendClientMessage(id,ORANGE,"/Answer :���� ����� ���/� | /IgnoreCall :���� ������ ������ ���/�");
EndTimer[id] = SetTimerEx("EndCall",30000,0,"iii",playerid,id,1);
PlayerPlaySound(id,1056,0.0,0.0,0.0);
TallkingID[playerid] = id;
TallkingID[id] = playerid;
IsCalling[playerid] = 1;
InCall[playerid] = 1;
InCall[id] = 1;
return 1;
}
//==============================================================================
if(strcmp(cmdtext,"/answer",true) == 0)
{
if(IsCalling[playerid] == 1) return SendClientMessage(playerid, RED,".��� �����, ���� ���� �����");
if(Tallking[playerid] == 1) return SendClientMessage(playerid, RED,".��� ��� �����");
if(InCall[playerid] == 0) return SendClientMessage(playerid, RED,".����� �� ����� �����");
KillTimer(EndTimer[playerid]);
format(str,sizeof(str),".��� ��� ������ ���� ,\"%s\" ���� ����� ���",GetName(TallkingID[playerid]));
SendClientMessage(playerid,LIGHTBLUE,str);
format(str,sizeof(str),".��� ������, ��� ��� ������ ���� \"%s\"",GetName(playerid));
SendClientMessage(TallkingID[playerid],LIGHTBLUE,str);
SendClientMessage(TallkingID[playerid],WHITE,"/Hangup - ���� ���� �� �����, ���/�");
Tallking[TallkingID[playerid]] = 1;
Tallking[playerid] = 1;
InCall[playerid] = 1;
return 1;
}
//==============================================================================
if(strcmp(cmdtext,"/hangup",true) == 0)
{
if(Tallking[playerid] == 0) return SendClientMessage(playerid, RED,".��� �� �����");
if(IsPlayerConnected(TallkingID[playerid]) && Tallking[playerid] == 1 && TallkingID[playerid] > -1 && Tallking[TallkingID[playerid]] == 1)
{
format(str,sizeof(str),".���� ���� ����� ���� ������� \"%s\"",GetName(playerid));
SendClientMessage(TallkingID[playerid],ORANGE,str);
if(IsCalling[playerid] == 0)
{
SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
SetPlayerSpecialAction(TallkingID[playerid],SPECIAL_ACTION_STOPUSECELLPHONE);
format(str,sizeof(str),".������� \"%s\" ����� ��",GetName(TallkingID[playerid]));
SendClientMessage(playerid,RED,str);
EndCall(TallkingID[playerid],playerid,3);
}
else
{
SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
SetPlayerSpecialAction(TallkingID[playerid],SPECIAL_ACTION_STOPUSECELLPHONE);
format(str,sizeof(str),".������� \"%s\" ����� ��",GetName(TallkingID[playerid]));
SendClientMessage(playerid,RED,str);
EndCall(playerid,TallkingID[playerid],3);
}
}
return 1;
}
//==============================================================================
if(strcmp(cmdtext,"/IgnoreCall",true) == 0){
if(Tallking[playerid] == 1) return SendClientMessage(playerid, RED,".��� ��� �����");
if(InCall[playerid] == 0) return SendClientMessage(playerid, RED,".����� �� ����� �����");
format(str,sizeof(str),".\"%s\" ���� ������ ������ ��",GetName(TallkingID[playerid]));
SendClientMessage(playerid,RED,str);
EndCall(TallkingID[playerid],playerid,1);
return 1;
}
//==============================================================================
if(!strcmp(cmd, "/Forum", true)) return GameTextForPlayer(playerid, "~W~ ] ~B~ Www.~W~"Forum".~R~Co.~Y~iL ~W~ ]", 6000, 4);
if(!strcmp(cmd, "/TeamSpeak", true) || !strcmp(cmd, "/TS", true)) return ShowPlayerDialog(playerid,681,DIALOG_STYLE_MSGBOX,"TeamSpeak ���� ��",".����� ������ ����� ��� ������ ���� ������� ���� ��� ����TeamSpeak ������\n.��� �� ����� ������ �����Ventrilo ���� ���� � TeamSpeak\n\n���� TS ���� ��� �\n212.150.176.22:�����\n9987:����\n\n���� ����, ���� ������ ����","�����","");
if (strcmp("/Wang", cmdtext, true, 10) == 0){
format(String, sizeof(String), ".\"%s\" ����� ������ ��� �� ����",Wangcar),SendClientMessage(playerid, COLOR_WHITE, String);
return 1;}
if(!strcmp(cmdtext, "/Bomb", true)) {
if(!IsPlayerXAdmin(playerid) && DOF2_GetInt(SFile(playerid), "Level") < 15 && !IsPlayerHonor(playerid))return SendClientMessage(playerid, COLOR_KRED, "���� ��� 15");
if(GetPlayerInterior(playerid) != 0 && IsXLevel(playerid) < 15 || GetPlayerVirtualWorld(playerid) != 0 && IsXLevel(playerid) < 15)return SendClientMessage(playerid,COLOR_KRED,"! �� ���� ������ ���� ����� ��");
if(UseBomb[playerid] == 1) return SendClientMessage(playerid,COLOR_KRED,"���� ���� ����� ���� ����� ���");
SetTimerEx("Bomb",5000,0,"%d",playerid),ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0),UseBomb[playerid] = 1,SendClientMessage(playerid,0x00ffffff,"����� �� �����"),GetPlayerPos(playerid,Float:PlayerPos[playerid][0],Float:PlayerPos[playerid][1],Float:PlayerPos[playerid][2]);
SBomb[playerid] = CreateObject(1252,Float:PlayerPos[playerid][0],Float:PlayerPos[playerid][1],Float:PlayerPos[playerid][2],0,0,0);

format(String,sizeof(String),"[UseBomb] %s (ID:%d)",GetName(playerid),playerid);
SendMessageBombAdmin(yellow,String);

return 1; }
if(strcmp(cmd, "/CarJump", true) == 0){
if(!IsPlayerXAdmin(playerid) && DOF2_GetInt(SFile(playerid), "Level") < 20 && !IsPlayerHonor(playerid))return SendClientMessage(playerid, COLOR_KRED, "���� ��� 20");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,COLOR_WHITE,".���� ����/� ����");
new Float:x,Float:y,Float:z;
new vehicle = GetPlayerVehicleID(playerid);
GetVehicleVelocity(vehicle,x,y,z),SetVehicleVelocity(vehicle,x,y,z+0.2);
return 1;}
if(!strcmp(cmdtext,"/PlayerJump",true))
{
if(!IsPlayerXAdmin(playerid) && DOF2_GetInt(SFile(playerid), "Level") < 20 && !IsPlayerHonor(playerid))return SendClientMessage(playerid, COLOR_KRED, "���� ��� 20");
if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_KRED,"�� �����");
new Float:x,Float:y,Float:z;
GetPlayerVelocity(playerid,x,y,z),SetPlayerVelocity(playerid,x,y,z+0.4);
return 1;}
if(!strcmp(cmdtext, "/AutoJump", true)){
if(!IsPlayerXAdmin(playerid) && DOF2_GetInt(SFile(playerid), "Level") < 30 && !IsPlayerHonor(playerid))return SendClientMessage(playerid, COLOR_KRED, "���� ��� 20");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,COLOR_WHITE,".���� ����/� ����");
if(!Autojump[playerid]) return Autojump[playerid] = 1,SendClientMessage(playerid,0x00FF00FF,"AutoJump: On");
else Autojump[playerid] = 0,SendClientMessage(playerid,0x00FF00FF,"AutoJump: Off");
return 1;}
if(!strcmp(cmdtext, "/AutoNitro", true)){
if(!IsPlayerXAdmin(playerid) && DOF2_GetInt(SFile(playerid), "Level") < 30 && !IsPlayerHonor(playerid))return SendClientMessage(playerid, COLOR_KRED, "���� ��� 20");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,COLOR_WHITE,".���� ����/� ����");
if(!Autonitro[playerid]) return Autonitro[playerid] = 1,SendClientMessage(playerid,0x00FF00FF,"AutoNitro: On");
else Autonitro[playerid] = 0,SendClientMessage(playerid,0x00FF00FF,"AutoNitro: Off");
return 1;}
if(!strcmp(cmdtext, "/AutopJump", true)){
if(!IsPlayerXAdmin(playerid) && DOF2_GetInt(SFile(playerid), "Level") < 30 && !IsPlayerHonor(playerid))return SendClientMessage(playerid, COLOR_KRED, "���� ��� 20");
if((IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,"�� �����");
if(!Autopjump[playerid]) return Autopjump[playerid] = 1,SendClientMessage(playerid,0x00FF00FF,"AutoPlayerJump: On");
else Autopjump[playerid] = 0,SendClientMessage(playerid,0x00FF00FF,"AutoPlayerJump: Off");
return 1;}
if(!strcmp("/spin", cmdtext, true)){
if(!IsPlayerXAdmin(playerid) && DOF2_GetInt(SFile(playerid), "Level") < 20 && !IsPlayerHonor(playerid))return SendClientMessage(playerid, COLOR_KRED, "���� ��� 20");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
SetVehicleAngularVelocity(GetPlayerVehicleID(playerid), 0.0, 0.0, 2.0);
return 1;}
if( strcmp(cmdtext,"/Fly", true ) == 0 ){
new Float:PlayerPoos[3];
GetPlayerPos(playerid,PlayerPoos[0],PlayerPoos[1],PlayerPoos[2]);
SetPlayerPos(playerid,PlayerPoos[0],PlayerPoos[1],PlayerPoos[2]+1000);
GivePlayerWeapon(playerid,46,1),SendClientMessage(playerid,yellow,"��� ������ ������ ����");
return 1;}
if(strcmp(cmdtext,"/Clear",true) == 0){
for(new C; C < 100; C++) SendClientMessage(playerid,COLOR_WHITE," ");
SendClientMessage(playerid,0x00FF00FF,"����� ����� �� ����");
return 1;}
if(strcmp("/P",cmdtext,true) == 0) return GivePlayerWeapon(playerid,46,1),SendClientMessage(playerid,yellow,"����� ����");
if(!strcmp(cmd, "/Tmp", true)){
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)){
format(string,sizeof(string),"Kills: [%d] Death: [%d]",SKills[playerid],Deaths[playerid]),SendClientMessage(playerid,COLOR_YELLOW,string);
return 1;}
id = strval(cmd);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, 0xFF0000FF, "������ �� �����");
format(string, sizeof(string), "Kills: [%d] Death: [%d]",SKills[id],Deaths[id]),SendClientMessage(playerid,COLOR_YELLOW, string);
return 1;}
if(!strcmp(cmd, "/Fps", true)){
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)){
format(string,sizeof(string),"Your Fps is: %d",pFPS[playerid]),SendClientMessage(playerid,COLOR_YELLOW,string);
return 1;}
id = strval(cmd);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, 0xFF0000FF, "������ �� �����");
format(string, sizeof(string), "\"%s\" Fps: %d", GetName(id),pFPS[id]),SendClientMessage(playerid,0x00FF00FF, string);
return 1;}
if(strcmp(cmd,"/DoubleKill",true) == 0){{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
new dstr[100],dname[MAX_PLAYER_NAME];
GetPlayerName(playerid,dname,MAX_PLAYER_NAME);
if(!doublekills){
doublekills=1;
tripelkills=0;
format(dstr,100,"����� �� ����� ��� %s ������",dname);
} else {
doublekills=0;
format(dstr,100,"��� �� ����� ��� %s ������",dname);}
SendClientMessageToAll(COLOR_SATLA,dstr);}
return 1;}
if(strcmp(cmd,"/TripelKill",true) == 0){{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
new dstr[100],dname[MAX_PLAYER_NAME];
GetPlayerName(playerid,dname,MAX_PLAYER_NAME);
if(!tripelkills){
tripelkills=1;
doublekills=0;
format(dstr,100,"����� �� ������ ��� %s ������",dname);
} else {
tripelkills=0;
format(dstr,100,"��� �� ������ ��� %s ������",dname);}
SendClientMessageToAll(COLOR_SATLA,dstr);}
return 1;}
if(strcmp(cmdtext, "/NextLevel", true)==0){
new Kills;
switch(GetPlayerLevel(playerid)){
case 0:Kills = Level2; case 1:Kills = Level2; case 2:Kills = Level3;
case 3:Kills = Level4; case 4:Kills = Level5; case 5:Kills = Level6;
case 6:Kills = Level7; case 7:Kills = Level8; case 8:Kills = Level9;
case 9:Kills = Level10; case 10:Kills = Level11; case 11:Kills = Level12;
case 12:Kills = Level13; case 13:Kills = Level14; case 14:Kills = Level15;
case 15:Kills = Level16; case 16:Kills = Level17; case 17:Kills = Level18;
case 18:Kills = Level19; case 19:Kills = Level20; case 20:Kills = Level21;
case 21:Kills = Level22; case 22:Kills = Level23; case 23:Kills = Level24;
case 24:Kills = Level25; case 25:Kills = Level26; case 26:Kills = Level27;
case 27:Kills = Level28; case 28:Kills = Level29; case 29:Kills = Level30;
case 30:Kills = Level31; case 31:Kills = Level32;
default:Kills = 0;
}
if(GetPlayerLevel(playerid) == 32)return SendClientMessage(playerid,yellow,"��� ���� ��� ���� �������");
SendFormatMessage(playerid,yellow,".%d - ��� ���� ��� %d ������ ���� ���� ����",GetPlayerLevel(playerid) + 1,Kills - DOF2_GetInt(SFile(playerid),"Kills"));
return 1;}

//==============================================================================
if(strcmp("/TDStats",cmdtext,true) == 0){
if(GetPVarInt(playerid,"TDStats") == 1){
SetPVarInt(playerid,"TDStats",0);
TextDrawHideForPlayer(playerid, Textdraw1[playerid]);
}
if(GetPVarInt(playerid,"TDStats") == 0){
new Kills;
switch(GetPlayerLevel(playerid)){
case 0:Kills = Level2; case 1:Kills = Level2; case 2:Kills = Level3;
case 3:Kills = Level4; case 4:Kills = Level5; case 5:Kills = Level6;
case 6:Kills = Level7; case 7:Kills = Level8; case 8:Kills = Level9;
case 9:Kills = Level10; case 10:Kills = Level11; case 11:Kills = Level12;
case 12:Kills = Level13; case 13:Kills = Level14; case 14:Kills = Level15;
case 15:Kills = Level16; case 16:Kills = Level17; case 17:Kills = Level18;
case 18:Kills = Level19; case 19:Kills = Level20; case 20:Kills = Level21;
case 21:Kills = Level22; case 22:Kills = Level23; case 23:Kills = Level24;
case 24:Kills = Level25; case 25:Kills = Level26; case 26:Kills = Level27;
case 27:Kills = Level28; case 28:Kills = Level29; case 29:Kills = Level30;
case 30:Kills = Level31; case 31:Kills = Level32; case 32:Kills = DOF2_GetInt(SFile(playerid), "Kills");
default:Kills = 0;
}
format(SString,sizeof(SString),"~h~~r~LEVEL:~w~~h~%d ~r~KIILS:~w~%d/%d~h~~r~ NEXTLEVEL:~w~~h~%d",DOF2_GetInt(SFile(playerid), "Level"),DOF2_GetInt(SFile(playerid), "Kills"),Kills,DOF2_GetInt(SFile(playerid), "Level") + 1);
TextDrawSetString(Textdraw1[playerid],SString);
TextDrawShowForPlayer(playerid, Textdraw1[playerid]);
SetPVarInt(playerid,"TDStats",1);
}
return 1;
}
//==============================================================================
if (strcmp("/Act", cmdtext, true, 10) == 0){
if(MiniOn == 0 && WarOn == 0 && MonsterOn == 0 && BoomOn == 0 && TanksOn == 0 && SwarOn == 0)return SendClientMessage(playerid,red,"��� ������ �����");
new ActString[256],AString[256];
if(SwarOn == 1){
	new time2 = gettime()-atime, hour, minute, second;
	second = time2 % 60;
	time2 /= 60;
	minute = time2 % 60;
	time2 /= 60;
	format(ActString,sizeof(ActString),"{FFFFFF}[ {FFA500}Swar {FFFFFF}]\n %02d:%02d:%02d :������ %s :����� �� ���,Swar �������\n",hour,minute,second,GetAName[AID]);
	strcat(AString, ActString);
}
if(TanksOn == 1){
	new time2 = gettime()-atime, hour, minute, second;
	second = time2 % 60;
	time2 /= 60;
	minute = time2 % 60;
	time2 /= 60;
	format(ActString,sizeof(ActString),"{FFFFFF}[ {FFA500}Tanks {FFFFFF}]\n %02d:%02d:%02d :������ %s :����� �� ���,Tanks �������\n",hour,minute,second,GetAName[AID]);
	strcat(AString, ActString);
}
if(MiniOn == 1){
	new time2 = gettime()-atime, hour, minute, second;
	second = time2 % 60;
	time2 /= 60;
	minute = time2 % 60;
	time2 /= 60;
	format(ActString,sizeof(ActString),"{FFFFFF}[ {FFA500}Mini {FFFFFF}]\n %02d:%02d:%02d :������ %s :����� �� ���,Mini �������\n",hour,minute,second,GetAName[AID]);
	strcat(AString, ActString);
}
if(WarOn == 1){
	new time2 = gettime()-atime, hour, minute, second;
	second = time2 % 60;
	time2 /= 60;
	minute = time2 % 60;
	time2 /= 60;
	format(ActString,sizeof(ActString),"{FFFFFF}[ {FFA500}War {FFFFFF}]\n %02d:%02d:%02d :������ %s :����� �� ���,War �������\n",hour,minute,second,GetAName[AID]);
	strcat(AString, ActString);
	}
if(MonsterOn == 1){
	new time2 = gettime()-atime, hour, minute, second;
	second = time2 % 60;
	time2 /= 60;
	minute = time2 % 60;
	time2 /= 60;
	format(ActString,sizeof(ActString),"{FFFFFF}[ {FFA500}Monster {FFFFFF}]\n %02d:%02d:%02d :������ %s :����� �� ���,Monster �������\n",hour,minute,second,GetAName[AID]);
	strcat(AString, ActString);
}
if(WeaponsOn == 1){
	new time2 = gettime()-atime, hour, minute, second;
	second = time2 % 60;
	time2 /= 60;
	minute = time2 % 60;
	time2 /= 60;
	format(ActString,sizeof(ActString),"{FFFFFF}[ {FFA500}Weapons {FFFFFF}]\n %02d:%02d:%02d :������ %s :����� �� ���,Weapons �������\n",hour,minute,second,GetAName[AID]);
	strcat(AString, ActString);
}
if(BoomOn == 1){
	new time2 = gettime()-atime, hour, minute, second;
	second = time2 % 60;
	time2 /= 60;
	minute = time2 % 60;
	time2 /= 60;
	format(ActString,sizeof(ActString),"{FFFFFF}[ {FFA500}Boom {FFFFFF}]\n %02d:%02d:%02d :������ %s :����� �� ���,Boom �������\n",hour,minute,second,GetAName[AID]);
	strcat(AString, ActString);
	}
	ShowPlayerDialog(playerid, 4518, DIALOG_STYLE_MSGBOX,"��� ��������� ����",AString, "�����", "");
return 1;}
//==============================================================================
if(!strcmp(cmd, "/MiniPlayers", true)){
if(MiniOn == 0) return SendClientMessage(playerid,COLOR_WHITE, "��� ������ ���� ����");
new count;
SendClientMessage(playerid, -1, "Mini Players List:");
for(new i, Mini = GetMaxPlayers(); i < Mini; i++){
if(InMini[i] == 1){
count++;
format(String, 256, "%d. %s [id: %d]",count,GetName(i), i);
SendClientMessage(playerid,0x00bbffff, String);
}}
return 1;
}
if(!strcmp(cmd, "/WarPlayers", true)){
if(WarOn == 0) return SendClientMessage(playerid,COLOR_WHITE, "��� ������ ���� ����");
new count;
SendClientMessage(playerid, -1, "War Players List:");
for(new i, War = GetMaxPlayers(); i < War; i++){
if(InWar[i] == 1){
count++;
format(String, 256, "%d. %s [id: %d] [%s]",count,GetName(i), i,GetWName(i));
SendClientMessage(playerid,0x00bbffff, String);
}}
return 1;
}
if(!strcmp(cmd, "/MonsterPlayers", true)){
if(MonsterOn == 0) return SendClientMessage(playerid,COLOR_WHITE, "��� ������ ������ ����");
new count;
SendClientMessage(playerid, -1, "Monster Players List:");
for(new i, Monster = GetMaxPlayers(); i < Monster; i++){
if(InMonster[i] == 1){
count++;
format(String, 256, "%d. %s [id: %d]",count,GetName(i), i);
SendClientMessage(playerid,0x00bbffff, String);
}}
return 1;
}
if(!strcmp(cmd, "/WeaponsPlayers", true)){
if(WeaponsOn == 0) return SendClientMessage(playerid,COLOR_WHITE, "��� ������ ������� ����");
new count;
SendClientMessage(playerid, -1, "Weapons Players List:");
SendFormatMessage(playerid, -1, "%s :����",GetWName(WeaponsWeapon));
for(new i, Weapons = GetMaxPlayers(); i < Weapons; i++){
if(InWeapons[i] == 1){
count++;
format(String, 256, "%d. %s [id: %d]",count,GetName(i), i);
SendClientMessage(playerid,0x00bbffff, String);
}}
return 1;
}
if(!strcmp(cmd, "/BoomPlayers", true)){
if(BoomOn == 0) return SendClientMessage(playerid,COLOR_WHITE, "��� ������ ��� ����");
new count;
SendClientMessage(playerid, -1, "Boom Players List:");
for(new i, Boom = GetMaxPlayers(); i < Boom; i++){
if(InBoom[i] == 1){
count++;
format(String, 256, "%d. %s [id: %d]",count,GetName(i), i);
SendClientMessage(playerid,0x00bbffff, String);
}}
return 1;
}
if(!strcmp(cmd, "/SWarPlayers", true)){
if(SwarOn == 0) return SendClientMessage(playerid,COLOR_WHITE, "��� ������ ������ ����");
new count;
SendClientMessage(playerid, -1, "Sultan War Players List:");
for(new i, SSWar = GetMaxPlayers(); i < SSWar; i++){
if(InSwar[i] == 1){
count++;
format(String, 256, "%d. %s [id: %d]",count,GetName(i), i);
SendClientMessage(playerid,0x00bbffff, String);
}}
return 1;
}
if(!strcmp(cmd, "/TanksPlayers", true)){
if(TanksOn == 0) return SendClientMessage(playerid,COLOR_WHITE, "��� ������ ����� ����");
new count;
SendClientMessage(playerid, -1, "Tanks Players List:");
for(new i, STanks = GetMaxPlayers(); i < STanks; i++){
if(InTanks[i] == 1){
count++;
format(String, 256, "%d. %s [id: %d]",count,GetName(i), i);
SendClientMessage(playerid,0x00bbffff, String);
}}
return 1;
}
//==============================================================================
if(strcmp(cmd, "/SetTime", true) == 0)
{
new any,time;
tmp = strtok(cmdtext, idx);
tmp2 = strtok(cmdtext, idx);
if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid,-1, "/SetTime [Hour] [Min]");
any = strval(tmp);
time = strval(tmp2);
SetPlayerTime(playerid,any,time);
return 1;
}
if(strcmp("/Npcs",cmdtext,true) == 0) return SendClientMessage(playerid,red,".��� ����� ������� ����");
//==============================================================================
if(!strcmp(cmd, "/Date", true) || !strcmp(cmd, "/Date", true)){
new Hours,Minutes,Days,Months,Years;
gettime(Hours, Minutes),getdate(Years, Months, Days);
format(string, sizeof(string), "Date: %d/%d/%d, Time %02d:%02d", Days,Months,Years,Hours,Minutes),SendClientMessage(playerid,0xFFFF00AA,string);
return 1;}
if (strcmp("/UpdateCarAdmin", cmdtext, true, 10) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
PayCarTax();
return 1;}
if(!strcmp(cmdtext,"/Rules",true))return ShowPlayerDialog(playerid, Rules_Dialog1, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 1 - ����� ��'���� / �����\n\n.��� ������ ��'���� / ����� ����\n����� ��� ���� �� ��� �� ����� ������� �����", "����", "");

if(strcmp(cmd, "/dice", true) ==0){
new num[MAX_PLAYERS], amount[MAX_PLAYERS];
num = strtok(cmdtext,idx);
amount = strrest(cmdtext,idx);
if(!strlen(num) || !strlen(amount)) return SendClientMessage(playerid,red,"/Dice [Number] [Money]");
if(strval(num) == 0 || strval(num) > 6) return SendClientMessage(playerid,red,"������ �� ��� 6-1");
new Mcheck = GetPlayerMoney(playerid);
if(Mcheck < strval(amount)) return SendClientMessage(playerid,red,"��� �� ����� ���");
if(!strlen(amount) || strval(amount) > 10000000 || strval(amount) < 1000) return SendClientMessage(playerid, COLOR_WHITE, "1,000 - 10,000,000");
GivePlayerMoney(playerid, -(strval(amount)));
new DiceCheck[][] = {{1},{2},{3},{4},{5},{6}};
new rand = random(sizeof(DiceCheck));
new DiceWin = DiceCheck[rand][0];
if(DiceWin != strval(num)) return format(tmp,sizeof(tmp),"%d �����, ����� ����� ���", DiceWin),SendClientMessage(playerid, red, tmp);
if(DiceWin == strval(num)) return format(tmp,sizeof(tmp),"[Dice] >> .�����! ��� ���, ���� ����� %d ���� �����", DiceWin),SendClientMessage(playerid, COLOR_SATLA, tmp),GivePlayerMoney(playerid,(strval(amount))*2);
if(DiceWin == strval(num) || strval(num) < 100000) return SendFormatMessageToAll(COLOR_SATLA,"[Dice] >> .$%s ��� ����� ������� �������''%s''",(strval(amount))*2,GetName(playerid));
return 1; }
//==============================================================================
if(strcmp(cmd,"/Trivia",true)==0){
tmp=strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/Trivia [Start | Stop]");
if(!strcmp(tmp,"Start",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 4)return SendClientMessage(playerid,red,"4 - ��� �� ���");
if(TriviaOn == 1)return SendClientMessage(playerid, COLOR_KRED,".�� ��� ������� ����");
ShowPlayerDialog(playerid,1984,DIALOG_STYLE_INPUT,"����� �������","���� �� ����� �������:","����","�����");
return 1;
}
if(!strcmp(tmp,"Stop",true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 4)return SendClientMessage(playerid,red,"4 - ��� �� ���");
if(TriviaOn == 0)return SendClientMessage(playerid, COLOR_KRED,".��� ������� ����");
TriviaOn = 0,format(String, sizeof(String), "! ���� �� ������� %s ������",GetName(playerid)),SendClientMessageToAll(COLOR_KRED,String);
return 1;
}
return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/Trivia [Start | Stop]");}
//==============================================================================
if(!strcmp(cmd, "/Ans", true))
{
if(TriviaOn == 0)return SendClientMessage(playerid, COLOR_KRED,"! ��� ����� ���� ����");
if(GetPVarInt(playerid,"WrongAns") == 3)return SendClientMessage(playerid, COLOR_KRED,".���� ��� 3 ������ ������");
if(!strlen(strrest(cmdtext, idx)))return SendClientMessage(playerid,COLOR_WHITE, "Usage: /Ans [Answer]");
if(strcmp(strrest(cmdtext, idx),Answer,false)) return SendFormatMessage(playerid, COLOR_KRED,".[%d/%d] ������ ����� �����",GetPVarInt(playerid,"WrongAns")),SetPVarInt(playerid,"WrongAns",GetPVarInt(playerid,"WrongAns")+1);
format(String, sizeof(String), "! %s ��� ���� ���� � %s",GetNum(GetPVarInt(playerid, "TriviaMoney")),GetName(playerid)),SendClientMessageToAll(0x00cbceFF,String);
format(String, sizeof(String), ".%s :������",Answer),SendClientMessageToAll(COLOR_WHITE,String);
TriviaOn = 0,GivePlayerMoney(playerid,GetPVarInt(playerid, "TriviaMoney")),KillTimer(EndTrivia);
return 1;
}
//==============================================================================
if(!strcmp(cmd, "/StartCode", true)){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 4)return SendClientMessage(playerid,red,"4 - ��� �� ���");
if(CodeOn == 1)return SendClientMessage(playerid, COLOR_KRED,".�� ��� ��� ����");
tmp = strtok(cmdtext, idx),CodeMoney = strval(tmp);
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE, "Usage: /StartCode [Reward]");
ShowPlayerDialog(playerid,1986,DIALOG_STYLE_INPUT,"����� ���",":���� �� ����","�����","�����");
return 1;}
if(!strcmp(cmd, "/ECode", true)){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 4)return SendClientMessage(playerid,red,"4 - ��� �� ���");
if(CodeOn == 0)return SendClientMessage(playerid, COLOR_KRED,".��� ��� ����");
CodeOn = 0,format(String, sizeof(String), "! ���� �� ���� %s ������",GetName(playerid)),SendClientMessageToAll(COLOR_KRED,String);
return 1;}
format(String,256,"/%s",CodeQuestion); if(!strcmp(cmdtext, String, false) && CodeOn) return format(String, sizeof(String), ".$%s ��� �� ���� ����� ���� � %s",GetNum(CodeMoney),GetName(playerid)),SendClientMessageToAll(COLOR_PINK,String),CodeOn = 0,GivePlayerMoney(playerid,CodeMoney),KillTimer(EndCode);
//==============================================================================
if(!strcmp(cmd, "/Spy", true) || !strcmp(cmd, "/SpySystem", true))
{
tmp=strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/SpySystem [Buy | ON | OFF | SPEC]");
if(!strcmp(tmp,"Buy",true))
{
if(DOF2_GetInt(SFile(playerid),"Spy") == 1)return SendClientMessage(playerid,red,".�� �� �� ������");
if(GetPlayerMoney(playerid) < 6000000) return SendClientMessage(playerid,COLOR_WHITE,"($6,000,000) - ��� ���� ����� ���");
SendClientMessage(playerid,COLOR_LIGHTGREEN, "[$6,000,000] �����! ���� ����� ���� �����"),SpySystem[playerid] = 1,DOF2_SetInt(SFile(playerid),"Spy",1),GivePlayerMoney(playerid,-6000000);
SendFormatMessageToAll(COLOR_LIGHTGREEN, "[Spy System] >> ��� �� ����� ������ %s �����",GetName(playerid));
return 1;
}
if(!strcmp(tmp,"On",true))
{
if(SpySystem[playerid] == 1) return SendClientMessage(playerid,COLOR_LIGHTGREEN,".������ ��� �����");
SpySystem[playerid] = 1,SendClientMessage(playerid,COLOR_LIGHTGREEN, "[SpySystem] ON.");
return 1;
}
if(!strcmp(tmp,"Off",true))
{
if(SpySystem[playerid] == 0) return SendClientMessage(playerid,COLOR_LIGHTGREEN,".������ ��� �����");
SpySystem[playerid] = 0,SendClientMessage(playerid,COLOR_ORANGE, "[SpySystem] ON.");
return 1;
}
if(!strcmp(tmp,"Spec",true))
{
if(DOF2_GetInt(SFile(playerid),"Spy") == 0)return SendClientMessage(playerid,red,".��� �� �� ������");
if(SpySystem[playerid] == 0) return SendClientMessage(playerid,COLOR_LIGHTGREEN,".������ ��� �����");
new Float:spos[MAX_PLAYERS][3];
if(Spec[playerid]) Spec[playerid] = 0,SetPlayerInterior(playerid, 0),SetPlayerPos(playerid, spos[playerid][0], spos[playerid][1], spos[playerid][2]),TogglePlayerSpectating(playerid, false);
else{
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /SpySpec [ID/NAME]");
if(!IsNumeric(cmd)) id = ReturnPlayerID(cmd); else id = strval(cmd);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_KRED, "! ����� �� �����");
if(id == playerid)return SendClientMessage(playerid, COLOR_KRED, "! ���� ���� ����� �� ����");
if(id == IsPlayerSupporter(playerid) && IsPlayerNightTeam(playerid) && IsPlayerXAdmin(playerid))return SendClientMessage(playerid, COLOR_KRED, "! ���� ���� ����� �� ���� ��");
Spec[playerid] = 1,TogglePlayerSpectating(playerid, true);
format(String, sizeof(String), "/Spy Spec - ��� ���� ���� �� ����,\"%s\" ��� ���� ��",GetName(id)),SendClientMessage(playerid,COLOR_PINK,String);
if(SpySystem[id] == 1 && playerid != id){
SendFormatMessage(playerid,COLOR_ORANGE,"[SpySystem] >> ���� �� ��� (id: %d) ''%s'' �����",playerid,GetName(playerid));
}
SetPlayerInterior(playerid, GetPlayerInterior(id)),GetPlayerPos(playerid, spos[playerid][0], spos[playerid][1], spos[playerid][2]);
if(!IsPlayerInAnyVehicle(id)) PlayerSpectatePlayer(playerid,id);
else PlayerSpectateVehicle(playerid,GetPlayerVehicleID(id));
if(IsPlayerInAnyVehicle(id)) PlayerSpectatePlayer(playerid, id);
else PlayerSpectateVehicle(playerid, GetPlayerVehicleID(id));}
return 1;
}
return SendClientMessage(playerid,0xFFFFFFFF,"Usage:/SpySystem [Buy | ON | OFF | SPEC]");}

if(!strcmp(cmd, "/SpyHelp", true)){
SendClientMessage(playerid, 0x1E90FFFF, "--- SpySystem Help ---");
SendClientMessage(playerid, white, ".����� ������ �� ���� ������ �� ����� �������");
SendClientMessage(playerid, white, ".����� ��� ������ �� ���� �� �� ���� ���� �� ������� ���, �� �� ������ ���,  �� �� ���� ��");
SendClientMessage(playerid, white, ".��� ��, ���� ����� ������ ����� ����� ���� ��� ������ ������ ���� ��� ��� ����");
SendClientMessage(playerid, white, ":������");
SendClientMessage(playerid, white, "/SpySystem Buy - ������ ������");
SendClientMessage(playerid, white, "/SpySystem ON - ������ ������, /SpySystem OFF - ������ ������");
SendClientMessage(playerid, white, "/SpySystem Spec - ����� ��� ����");
SendClientMessage(playerid, white, "/Spies - ������ ������� �������� ����");
SendClientMessage(playerid, 0x1E90FFFF, " ------------------------------");
return 1;}


if(!strcmp(cmd, "/Spies", true)){
new count;
if(DOF2_GetInt(SFile(playerid),"Spy") == 0)return SendClientMessage(playerid,red,".��� �� �� ������");
if(SpySystem[playerid] == 0) return SendClientMessage(playerid,COLOR_LIGHTGREEN,".������ ��� �����");
SendClientMessage(playerid, 0x1E90FFFF, "--- SpySystem List ---");
for(new i, SSpySystem = GetMaxPlayers(); i < SSpySystem; i++){
if(DOF2_GetInt(SFile(i),"Spy") == 1){
count++;
format(str, 256, "%d. %s [id: %d] - System: %s, Spector: None",count, GetName(i), i,SpySystem[playerid] == 1 ? ("{00FF00}ON{FFFFFF}"):("{FF0000}OFF{FFFFFF}"));
SendClientMessage(playerid, white, str);
}}
if(!count){
SendClientMessage(playerid, COLOR_KRED, "!��� ������ �� ����� �����");}
return 1;}

//==============================================================================
if (strcmp("/Update", cmdtext, true, 10) == 0){
new UStrinng[500];
new Update1[] = "{33FFCC}����� �����{FFFFFF}: 24.08.2013\n\n:������� �������\n";
new Update2[] = "{FFFFFF}/Commands [1-6] - ����� ������\n������ ����� �����\n���� ������ �����\nSuiT - ���� ����� �����\n����� ������ �����\n����� ����� �����\n������ ��� ������";
format(UStrinng,sizeof(UStrinng),"%s %s",Update1,Update2);
ShowPlayerDialog(playerid, 1191,DIALOG_STYLE_MSGBOX,"�����", UStrinng, "�����", "");
return 1;}
//==============================================================================
//==============================================================================
if(strcmp(cmd, "/ServerStats", true) == 0)
{
new v = CreateVehicle(411,0,0,0,0,0,0,1000);DestroyVehicle(v);
SendClientMessage(playerid, COLOR_WHITE,"---- Server Stats ----");
SendFormatMessage(playerid, COLOR_WHITE,"{1BA4FE}Clans:{EBEBEB} %i.",DOF2_GetInt(ServerStats(),"Clans"));
SendFormatMessage(playerid, COLOR_WHITE,"{1BA4FE}Players:{EBEBEB} %i.",GetConnectedPlayers());
SendFormatMessage(playerid, COLOR_WHITE,"{1BA4FE}Registered Players:{EBEBEB} %i.",DOF2_GetInt(ServerStats(),"Users")-10000);
SendFormatMessage(playerid, COLOR_WHITE,"{1BA4FE}Banned Players:{EBEBEB} %i.",Banned);
SendFormatMessage(playerid, COLOR_WHITE,"{1BA4FE}Server uptime:{EBEBEB} %s",DOF2_GetString(ServerStats(),"UpTime"));
SendFormatMessage(playerid, COLOR_WHITE,"{1BA4FE}Server running at:{EBEBEB} 00:00:00 [00.00.0000].", GetConnectedPlayers(),MAX_PLAYERS);
SendFormatMessage(playerid, COLOR_WHITE,"{1BA4FE}Max simultaneously connected: {EBEBEB}%d Players.",MAX_PLAYERS);
return 1;
}
//==============================================================================
if(strcmp("/Bug", cmdtext, true, 10) == 0) return ShowPlayerDialog(playerid,BugDialog,DIALOG_STYLE_INPUT,"����� �� ���","���� �� ���� �����\n�� ���� ���� �����, ���� ���� ��� ����� ����","����","�����");
//==============================================================================
if(strcmp("/SetEmail", cmdtext, true, 10) == 0) return ShowPlayerDialog(playerid,SetEmailDialog,DIALOG_STYLE_INPUT,"���� ����� �����","��� ���� ����� ����� ������ ����� �����\n����� ������ ����� ����� ����� ������ ������ �������� ����� �����","����","�����");
if(strcmp("/RemoveEmail", cmdtext, true, 10) == 0) return SendClientMessage(playerid, COLOR_SATLA, "!����� ��� ���� ������"),DOF2_SetString(SFile(playerid),"Email","None");
if(strcmp("/ResetPass", cmdtext, true, 10) == 0) return ShowPlayerDialog(playerid,ResetPassDialog,DIALOG_STYLE_INPUT,"������ �����","��� ���� �� ����� ������ ���","����","�����");
//==============================================================================
if(strcmp("/Battle", cmd, true, 10) == 0)
{
tmp = strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage: /Battle [Invite | Accept | Deny | Quit]");
if(strcmp("Invite", tmp, true, 10) == 0)
{
new ID,tmpmoney[256];
tmp = strtok(cmdtext,idx);
tmpmoney = strtok(cmdtext,idx);
ID = strval(tmp);
if(!strlen(tmp) || !strlen(tmpmoney)) return SendClientMessage(playerid,red, "/Battle Invite [ID] [Money]");
if(battle[playerid][InBattle] == 1) return SendClientMessage(playerid,red, "!��� ��� ���� ���� �� �����");
if(!IsPlayerConnected(ID)) return SendClientMessage(playerid,red, ".����� ����");
if(battle[ID][InBattle] == 1) return SendClientMessage(playerid,red, "!����� ���� ��� ����");
if(battle[playerid][InviteAnyOne] == 1) return SendClientMessage(playerid,red, "!���� �� ����� ���� ����");
if(battle[ID][InviteMe] == 1) return SendClientMessage(playerid,red, "!����� ��� ����� ���� �� ����");
if(GetPlayerMoney(playerid) < strval(tmpmoney)) return SendClientMessage(playerid,red, "!��� �� ����� ���");
if(Ignore[playerid][ID])return SendClientMessage(playerid,RED,"���� �� ����� ���"),0;
if(Ignore[ID][playerid])return SendClientMessage(playerid,RED,"����� ��� ����"),0;
battle[playerid][MoneyBattle] = strval(tmpmoney);
battle[ID][MoneyBattle] = strval(tmpmoney);
battle[ID][InviteMe] = 1;
battle[playerid][InviteAnyOne] = 1;
battle[ID][IDInvite] = playerid;
battle[playerid][IDJoin] = ID;
battle[playerid][Inviter] = 1;
SendClientMessage(ID,-1,"-----[ Battle - Invite ]-----");
SendFormatMessage(ID,Color_BB,".����� ���� ����� ''%s''",GetName(playerid));
SendFormatMessage(ID,Color_BB,".$%d ����� ����", battle[ID][MoneyBattle]);
SendClientMessage(ID,Color_BB,"/Battle Accept - ���� ���� �� ������, ���");
SendClientMessage(ID,Color_BB,"/Battle Deny - ���� ����� �� ������, ���");
SendClientMessage(ID,-1,"-----------------------------");
SendFormatMessage(playerid,COLOR_SATLA,".[���� ����� $%d]����, ��� ���� ������ ������ ''%s'' ����� ��", battle[ID][MoneyBattle],GetName(ID));
battle[playerid][TimerBattle] = SetTimerEx("NoAcceptBattle",20*1000, 0, "%d", playerid);
}
if(strcmp("Accept", tmp, true, 10) == 0)
{
IdInvite = battle[playerid][IDInvite];
if(battle[playerid][InviteMe] == 0) return SendClientMessage(playerid,red, "!�� ��� �� ����� ���� ����");
if(GetPlayerMoney(IdInvite) < battle[playerid][MoneyBattle]) return SendClientMessage(playerid,red, "!����� ������ ���� ��� ��� �� ���� ������ ����");
if(GetPlayerMoney(playerid) < battle[playerid][MoneyBattle]) return SendClientMessage(playerid,red, "!��� �� ����� ���");
KillTimer(battle[IdInvite][TimerBattle]);
battle[playerid][InviteMe] = 0;
battle[IdInvite][InviteAnyOne] = 0;
//
GivePlayerMoney(playerid, -battle[playerid][MoneyBattle]);
ResetPlayerWeapons(playerid);
TogglePlayerControllable(playerid, 0);
SetPlayerHealth(playerid, 100);
SetPlayerArmour(playerid,100);
GivePlayerWeapon(playerid, 26,10000);
SetPlayerPos(playerid, -1554.9391,320.5921,53.4609);
SetPlayerVirtualWorld(playerid,71);
//
GivePlayerMoney(IdInvite, -battle[IdInvite][MoneyBattle]);
ResetPlayerWeapons(IdInvite);
TogglePlayerControllable(IdInvite, 0);
SetPlayerHealth(IdInvite, 100);
SetPlayerArmour(IdInvite,100);
GivePlayerWeapon(IdInvite, 26,10000);
SetPlayerVirtualWorld(IdInvite,71);
SetPlayerPos(IdInvite, -1484.8385,325.6548,53.4609);
//
battle[playerid][joiner] = 1;
battle[playerid][InBattle] = 1;
battle[IdInvite][InBattle] = 1;
battle[playerid][CountBattle] = 5;
battle[IdInvite][CountBattle] = 5;
battle[playerid][TimerCountBattle] = SetTimerEx("CountBattlE",1*1000, 1, "%d", playerid);
battle[IdInvite][TimerCountBattle] = SetTimerEx("CountBattlE",1*1000, 1, "%d", IdInvite);
}
if(strcmp("Deny", tmp, true, 10) == 0)
{
IdInvite = battle[playerid][IDInvite];
if(battle[playerid][InviteMe] == 0) return SendClientMessage(playerid,red, "!�� ��� �� ����� ���� ����");
format(string, sizeof(string), ".%s ���� �� ����� ��", GetName(IdInvite));
SendClientMessage(playerid,COLOR_ORANGE,string);
format(string, sizeof(string), "[Battle] >> .��� �� ������ ����� %s �����",GetName(playerid));
SendClientMessage(IdInvite,COLOR_SATLA,string);
battle[IdInvite][MoneyBattle] = 0;
battle[playerid][MoneyBattle] = 0;
battle[playerid][InviteMe] = 0;
battle[IdInvite][InviteAnyOne] = 0;
KillTimer(battle[IdInvite][TimerBattle]);
}
if(strcmp("Quit", tmp, true, 10) == 0)
{
new IdWinner,IdLoozer;
format(String, sizeof(String),"[Battle] << .���� ������"),SendClientMessage(playerid,COLOR_KRED,String);
format(String, sizeof(String),"[Battle] << .��� ������ %s �����",GetName(playerid)),SendClientMessage(IdInvite,COLOR_KRED,String);
format(String,256,"[Battle] >> $%s -����� ���� � ''%s'' ���� �� ����� ''%s''", GetNum(battle[IdWinner][MoneyBattle]),GetName(IdLoozer),GetName(IdWinner)),SendClientMessageToAll(COLOR_LIGHTGREEN,String);
battle[IdInvite][MoneyBattle] = 0,battle[playerid][MoneyBattle] = 0,battle[playerid][InviteMe] = 0,battle[IdInvite][InviteAnyOne] = 0,KillTimer(battle[IdInvite][TimerBattle]);
}
return SendClientMessage(playerid,COLOR_WHITE,"Usage: /Battle [Invite | Accept | Deny | Quit]");
}
//==============================================================================

SendRconCommand("gmx");
SendRconCommand("exit");
SendRconCommand("gmx");
return 1;}
if(strcmp(cmdtext,"/Lv", true ) == 0 ) return Teleport(playerid, "! ���� ��� ���� ������", 2190.7876,1834.0406,10.8203,91.1756, 2189.9016,1832.4009,10.8203, 88.1535,0,0);
if(strcmp(cmdtext,"/NewCars", true ) == 0 ) return TeleportFoot(playerid, "! ���� ��� ������ ������",2907.3545,2397.1433,10.6719,359.4373,0,0);
if(strcmp(cmdtext,"/Tower", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� �����",1544.3032,-1353.2784,329.4744,271.0214, 1541.1882,-1366.7660,329.7969,359.1941,0,0);
if(strcmp(cmdtext,"/Garage 1", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� 1",-2696.8308,217.8290,4.1797,90.8921,-2696.8308,217.8290,4.1797,90.8921,0,0);
if(strcmp(cmdtext,"/Garage 2", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� 2",2644.5798,-2028.4697,13.5469,182.8485,2644.5798,-2028.4697,13.5469,182.8485,0,0);
if(strcmp(cmdtext,"/Garage 3", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� 3",2385.8396,1026.3246,10.8203,357.9488,2385.8396,1026.3246,10.8203,357.9488,0,0);
if(strcmp(cmdtext,"/Swamp", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����",-863.7606,-1983.8845,18.1053,339.5688,-875.3824,-1967.1909,16.8509,308.1491,0,0);
if(strcmp(cmdtext,"/ShipTrip", true ) == 0 ) return TeleportFoot(playerid, "! ���� ��� ����� �����",2124.7168,-89.2805,2.0099,124.5344,0,0);
if(strcmp(cmdtext,"/Drift", true ) == 0 ) return Teleport(playerid, "! ���� ��� ��� ��������",-2423.4199,-634.5181,132.9097,337.6015,-2390.2549,-604.9265,132.7672,82.4373,0,0);
if(strcmp(cmdtext,"/Ls", true ) == 0 ) return Teleport(playerid, "! ���� ��� ���� ������",2471.9077,-1674.0171,13.3353,3.2637,2514.091552,-1676.442871,13.634909,85.7782,0,0);
if(strcmp(cmdtext,"/Jump", true ) == 0 ) return Teleport(playerid, "! ���� ��� ������",-720.7347,2374.7107,127.4541,208.7969,-664.7120,2306.0642,136.1855,91.1076,0,0);
if(strcmp(cmdtext,"/CarPark", true ) == 0 ) return TeleportFoot(playerid, "! ���� ��� ����� ������",-1892.4120,-909.6633,32.0234,267.2712,0,0),ResetPlayerWeapons(playerid);
if(strcmp(cmdtext,"/Police", true ) == 0 ) return Teleport(playerid, "! ���� ��� ���� ������",-1635.6069,662.7398,7.1875,270.5280,-1639.0011,648.6382,7.187,319.5685,0,0);
if(strcmp(cmdtext,"/Jeeps", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� �'����",-296.3609,1772.1890,42.6875,180.2061,-307.5496,1767.6116,43.6406,271.6446,0,0);
if(strcmp(cmdtext,"/BusTrip", true ) == 0 ) return TeleportFoot(playerid, "! ���� ��� ����� ���������",-240.9133,1876.7273,42.4830,52.2736,0,0);
if(strcmp(cmdtext,"/Sf", true ) == 0 ) return Teleport(playerid, "! ���� ��� ���� �����",-1888.9790,883.5750,35.1719,181.0176,-1911.6771,882.2997,35.1719,264.0730,0,0);
if(strcmp(cmdtext,"/Chiliad", true ) == 0 ) return TeleportFoot(playerid, "! ���� ��� ��� �����",-2342.9651,-1599.4357,483.6536,231.6886,0,0);
if(strcmp(cmdtext,"/Ramp", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� ������",1898.3130,-1363.9915,13.5308,270.4628,1959.2759,-1450.8907,13.5534,358.6357,0,0);
if(strcmp(cmdtext,"/Race", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� �������",-2580.1914,1120.6102,55.5098,250.5582,-2591.6570,1106.3938,55.5781,311.7527,0,0);
if(strcmp(cmdtext,"/UnderWater", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� ���� ����",-1474.4282,514.2451,-40.3672,273.6302,-1486.5857,508.6428,-40.3672,269.0242,0,0);
if(strcmp(cmdtext,"/Stunts", true ) == 0 ) return TeleportFoot(playerid, "! ���� ��� ������",1766.8835,-2443.9329,13.5547,181.1934,4,0),ResetPlayerWeapons(playerid);
if(strcmp(cmdtext,"/Farm", true ) == 0 ) return Teleport(playerid, "! ���� ��� �����",-72.7786,-8.9454,3.1172,250.6714,-82.6268,-1.7461,3.1172,250.6714,0,0);
if(strcmp(cmdtext,"/Ap", true ) == 0 ) return Teleport(playerid, "! ���� ��� ���� �����",-1352.6832,-178.7354,14.1484,45.0028,-1360.5687,-245.5355,14.1440,316.6714,0,0);
if(strcmp(cmdtext,"/Parkour", true ) == 0 ) return TeleportFoot(playerid, "! ���� ��� ������",-1486.5483,1017.3245,7.3323,1.9218,5,0),ResetPlayerWeapons(playerid);
if(strcmp(cmdtext,"/Lv", true ) == 0 ) return Teleport(playerid, "! ���� ��� ���� ������", 2190.7876,1834.0406,10.8203,91.1756, 2189.9016,1832.4009,10.8203, 88.1535,0,0);
if(strcmp(cmdtext,"/NewCars", true ) == 0 ) return TeleportFoot(playerid, "! ���� ��� ������ ������",2907.3545,2397.1433,10.6719,359.4373,0,0);
if(strcmp(cmdtext,"/Tower", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� �����",1544.3032,-1353.2784,329.4744,271.0214, 1541.1882,-1366.7660,329.7969,359.1941,0,0);
if(strcmp(cmdtext,"/Garage 1", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� 1",-2696.8308,217.8290,4.1797,90.8921,-2696.8308,217.8290,4.1797,90.8921,0,0);
if(strcmp(cmdtext,"/Garage 2", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� 2",2644.5798,-2028.4697,13.5469,182.8485,2644.5798,-2028.4697,13.5469,182.8485,0,0);
if(strcmp(cmdtext,"/Garage 3", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� 3",2385.8396,1026.3246,10.8203,357.9488,2385.8396,1026.3246,10.8203,357.9488,0,0);
if(strcmp(cmdtext,"/Swamp", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����",-863.7606,-1983.8845,18.1053,339.5688,-875.3824,-1967.1909,16.8509,308.1491,0,0);
if(strcmp(cmdtext,"/ShipTrip", true ) == 0 ) return TeleportFoot(playerid, "! ���� ��� ����� �����",2124.7168,-89.2805,2.0099,124.5344,0,0);
if(strcmp(cmdtext,"/Drift", true ) == 0 ) return Teleport(playerid, "! ���� ��� ��� ��������",-2423.4199,-634.5181,132.9097,337.6015,-2390.2549,-604.9265,132.7672,82.4373,0,0);
if(strcmp(cmdtext,"/Ls", true ) == 0 ) return Teleport(playerid, "! ���� ��� ���� ������",2471.9077,-1674.0171,13.3353,3.2637,2514.091552,-1676.442871,13.634909,85.7782,0,0);
if(strcmp(cmdtext,"/Jump", true ) == 0 ) return Teleport(playerid, "! ���� ��� ������",-720.7347,2374.7107,127.4541,208.7969,-664.7120,2306.0642,136.1855,91.1076,0,0);
if(strcmp(cmdtext,"/CarPark", true ) == 0 ) return TeleportFoot(playerid, "! ���� ��� ����� ������",-1892.4120,-909.6633,32.0234,267.2712,0,0),ResetPlayerWeapons(playerid);
if(strcmp(cmdtext,"/Police", true ) == 0 ) return Teleport(playerid, "! ���� ��� ���� ������",-1635.6069,662.7398,7.1875,270.5280,-1639.0011,648.6382,7.187,319.5685,0,0);
if(strcmp(cmdtext,"/Jeeps", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� �'����",-296.3609,1772.1890,42.6875,180.2061,-307.5496,1767.6116,43.6406,271.6446,0,0);
if(strcmp(cmdtext,"/BusTrip", true ) == 0 ) return TeleportFoot(playerid, "! ���� ��� ����� ���������",-240.9133,1876.7273,42.4830,52.2736,0,0);
if(strcmp(cmdtext,"/Sf", true ) == 0 ) return Teleport(playerid, "! ���� ��� ���� �����",-1888.9790,883.5750,35.1719,181.0176,-1911.6771,882.2997,35.1719,264.0730,0,0);
if(strcmp(cmdtext,"/Chiliad", true ) == 0 ) return TeleportFoot(playerid, "! ���� ��� ��� �����",-2342.9651,-1599.4357,483.6536,231.6886,0,0);
if(strcmp(cmdtext,"/Ramp", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� ������",1898.3130,-1363.9915,13.5308,270.4628,1959.2759,-1450.8907,13.5534,358.6357,0,0);
if(strcmp(cmdtext,"/Race", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� �������",-2580.1914,1120.6102,55.5098,250.5582,-2591.6570,1106.3938,55.5781,311.7527,0,0);
if(strcmp(cmdtext,"/UnderWater", true ) == 0 ) return Teleport(playerid, "! ���� ��� ����� ���� ����",-1474.4282,514.2451,-40.3672,273.6302,-1486.5857,508.6428,-40.3672,269.0242,0,0);
if(strcmp(cmdtext,"/Stunts", true ) == 0 ) return TeleportFoot(playerid, "! ���� ��� ������",1766.8835,-2443.9329,13.5547,181.1934,4,0),ResetPlayerWeapons(playerid);
if(strcmp(cmdtext,"/Farm", true ) == 0 ) return Teleport(playerid, "! ���� ��� �����",-72.7786,-8.9454,3.1172,250.6714,-82.6268,-1.7461,3.1172,250.6714,0,0);
if(strcmp(cmdtext,"/Ap", true ) == 0 ) return Teleport(playerid, "! ���� ��� ���� �����",-1352.6832,-178.7354,14.1484,45.0028,-1360.5687,-245.5355,14.1440,316.6714,0,0);
if(strcmp(cmdtext,"/Parkour", true ) == 0 ) return TeleportFoot(playerid, "! ���� ��� ������",-1486.5483,1017.3245,7.3323,1.9218,5,0),ResetPlayerWeapons(playerid);
if(!strcmp(cmd, "/T", true) || !strcmp(cmd, "/Teleports", true) || !strcmp(cmd, "/Tele", true)) return ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST, "�������", "Ap\nDm\nLS\nLV\nSF\nFly\nStunts\nSawn\nRace\nDrift\nJump\nJeeps\nRamp\nPolice\nBustrip\nBank\nSwamp\nFight\nTower\nShipTrip\nChiliad\nFarm\nAmmo\nGarage 1\nGarage 2\nGarage 3\nBazooka\nUnderWater", "�����", "�����");
//==============================================================================
if(strcmp("/MH", cmdtext, true, 10) == 0 || strcmp("/MoneyHelp", cmdtext, true, 10) == 0) return ShowPlayerDialog(playerid,360,DIALOG_STYLE_LIST,"����� ����� ���","������\n����� ����\n�������\n������\n������\n����� ����\n��������","���","����");
//==============================================================================
if(strcmp("/Help", cmdtext, true, 10) == 0) return ShowPlayerDialog(playerid,1095,DIALOG_STYLE_MSGBOX,"{25A8B7}Help Menu // ����� ����","{FFFFFF}Please choose a Lanuage | ��� ��� �� ���� ���","English","�����");
//==============================================================================
if (strcmp("/Support", cmdtext, true, 10) == 0)
{
SendClientMessage(playerid, 0x1E90FFFF,"--- Support Help ---");
SendClientMessage(playerid,COLOR_WHITE, ".���� ������ ���� �� ��� ����� ������� ����� ����");
SendClientMessage(playerid,COLOR_WHITE, ".����� ����� ����� ����� /Helpme ��� ����? ���� ����? �� �� ��� �����! ����");
SendClientMessage(playerid,COLOR_WHITE, "");
SendClientMessage(playerid,0x00FF00FF, ":������");
SendClientMessage(playerid,COLOR_WHITE, "/Helpme, /Supporters");
SendClientMessage(playerid, 0x1E90FFFF,"-----------------");
return 1;
}
if(strcmp(cmd, "/HelpMe", true)==0){
new Supporters_Count;
for(new i=0;i<=GetMaxPlayers();i++) if(IsPlayerConnected(i) && IsPlayerSupporter(i))Supporters_Count++;
if(!Supporters_Count)return SendClientMessage(playerid,COLOR_KRED,".��� ���� ���� ����� �������");
if(IsPlayerSupporter(playerid) || IsPlayerXAdmin(playerid) || IsPlayerNightTeam(playerid)) return SendClientMessage(playerid,COLOR_KRED,".���� ����, ���� ���� ���� ����, ����� ��� ��� �� ���� �������� ��������");
if(HelpPlz[playerid] == 1)return SetTimerEx("AllowHelpPlz",3*60*1000,0,"d",playerid),SendClientMessage(playerid,COLOR_KRED,"! ��� �� ���� ������ �������, ��� ��� ����� �������");
SendClientMessage(playerid,COLOR_LIGHTGREEN,"...����� ��� ���� ���� ���� ����� ������ ���� �������, ��� ���� �����");
HelpPlz[playerid]++;
NeedHelp[playerid] = 1;
format(String,sizeof(String),"[Supporters] >> .���� ����[ID:%i] \"%s\"",playerid,GetName(playerid));
SendMessageToSupporters(COLOR_LIGHTBLUE,String);
format(String,sizeof(String),"/TakeCall %d :���� ����� ����/�",playerid);
SendMessageToSupporters(COLOR_LIGHTBLUE, String);
return 1;}
if(strcmp(cmd,"/takecall",true) == 0)
{
if(!IsPlayerSupporter(playerid) && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
cmd = strtok(cmdtext, idx);
id = strval(cmd);
if(!strlen(cmd)) return SendClientMessage(playerid,RED,"Usage: /TakeCall [ID]");
if(NeedHelp[id] == 0) return SendClientMessage(playerid,RED,"����� �� ���� ����");
if(Tallking[playerid] == 1) return SendClientMessage(playerid, RED,".��� ��� �����");
if(Tallking[id] == 1) return SendClientMessage(playerid, RED,".����� ��� �����");
if(id == playerid) return SendClientMessage(playerid,RED,".���� ���� ������ �����");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, RED,".�����/�� �� �����/�");
format(String,sizeof(String),".(%d) ����� \"%s\" ��� ��� ����� �� �����",playerid,GetName(playerid));
SendClientMessage(id,COLOR_LIGHTGREEN,String);
format(String, sizeof(String), "[Phone] >> From %s (id:%d) ?���� ���� ����� ��,%s ���� ��",GetName(playerid),playerid,GetName(id));
SendClientMessage(id, yellow, String);
format(String, sizeof(String), ".\"%s\" - ��� �� ���� �", GetName(id));
SendClientMessage(playerid, COLOR_LIGHTGREEN, String);
format(String,128,"[Supporters] >> .%s ���� ��� ����� \"%s\"",GetName(id),GetName(playerid));
SendMessageToSupporters(COLOR_LIGHTBLUE,String);
TallkingID[playerid] = id;
TallkingID[id] = playerid;
IsCalling[playerid] = 1;
InCall[playerid] = 1;
InCall[id] = 1;
Tallking[TallkingID[playerid]] = 1;
Tallking[playerid] = 1;
InCall[playerid] = 1;
NeedHelp[playerid] = 0;
return 1;
}
//==============================================================================
if (strcmp("/Supporters",cmdtext, true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"----- {6699FF}Supportes {FFFFFF}Online: -----");
new Supporters_Count;
for(new i=0;i<=GetMaxPlayers();i++)
{
if(IsPlayerConnected(i) && IsPlayerSupporter(i))
{
Supporters_Count++;
if(DOF2_GetInt(SFile(i),"Supporters") == 1) SupportersLevel = "Normal";
if(DOF2_GetInt(SFile(i),"Supporters") == 2) SupportersLevel = "Super";
if(DOF2_GetInt(SFile(i),"Supporters") == 3) SupportersLevel = "Sub Leader";
if(DOF2_GetInt(SFile(i),"Supporters") == 4) SupportersLevel = "Leader";
format(String,sizeof(String),"%d. %s [id: %d] [%s]",Supporters_Count,GetName(i),i,SupportersLevel);
SendClientMessage(playerid,COLOR_GRAY,String);
}
}
if(!Supporters_Count)SendClientMessage(playerid,COLOR_KRED,".��� ���� ���� ����� �������");
return 1;
}
if(strcmp(cmd,"/Supporter", true) == 0){
tmp = strtok(cmdtext, idx);
if(!IsPlayerSupporter(playerid) && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(!strlen(tmp)) return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid,"/Supporter Help");
//==============================================================================
if(strcmp(tmp,"Add", true) == 0){
tmp=strtok(cmdtext,idx);
new Rid = strval(tmp);
if(!IsPlayerSupporter(playerid) && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(GetSupporters(playerid) < 4 && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_KRED,"! ���� ������ ������ �� ���� ���� ����� ��� 4 ����� �����");
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE,"Usage: /Supporter Add [ID/NAME]");
if(!IsNumeric(tmp)) Rid = ReturnPlayerID(tmp); else Rid = strval(tmp);
if(!IsPlayerConnected(Rid)) return SendClientMessage(playerid, COLOR_KRED, "! ����� �� �����");
if(IsPlayerSupporter(Rid))return SendClientMessage(playerid,COLOR_WHITE,".���� �� ��� ���� �����");
format(String,sizeof(String),"[Supporter] >> !���� ����� ���! ���� ���� %s",GetName(Rid));
SendMessageToSupporters(COLOR_LIGHTGREEN,String);
SendClientMessage(Rid,COLOR_YELLOW,"! ��� ���� ��� ����� �����"),SendClientMessage(Rid,COLOR_PINK,"/Supporter - ����� ���/�");
DOF2_SetInt(SFile(Rid),"Supporters",1);
return 1;}
//==============================================================================
if(strcmp(tmp,"Kick", true) == 0){
tmp = strtok(cmdtext,idx);
new Rid = strval(tmp);
if(!IsPlayerSupporter(playerid) && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(GetSupporters(playerid) < 4 && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_KRED,"! ���� ������ ������ �� ���� ���� ����� ��� 4 ����� �����");
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE,"Usage: /Supporter Kick [ID/NAME]");
if(!IsNumeric(tmp)) Rid = ReturnPlayerID(tmp); else Rid = strval(tmp);
if(!IsPlayerConnected(Rid)) return SendClientMessage(playerid, COLOR_KRED, "! ����� �� �����");
if(Rid == playerid)return SendClientMessage(playerid,COLOR_KRED,"���� ���� ����� �� ����");
if(!IsPlayerSupporter(Rid))return SendClientMessage(playerid,COLOR_KRED,"! ���� �� ���� ���� �����");
DOF2_SetInt(SFile(Rid),"Supporters",0);
format(String,sizeof(String),".����� ����� %s ����� �� �����",GetName(Rid));
SendClientMessage(playerid,COLOR_ORANGE,String);
return 1;}
//==============================================================================
if (strcmp(tmp,"SetLevel", true) == 0)
{
tmp = strtok(cmdtext, idx);
id = strval(tmp);
if(!IsPlayerSupporter(playerid) && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(GetSupporters(playerid) < 4 && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"! ���� ������ ������ �� ���� ���� ����� ��� 4 ����� �����");
if(!strlen(tmp)) return SendClientMessage(playerid, red, "/Supporter SetLevel [id] [level 1-4]");
if(!IsPlayerConnected(id))return SendClientMessage(playerid, red, "����� �� �����");
if(!IsPlayerSupporter(id))return SendClientMessage(playerid,COLOR_KRED,".���� �� ���� ��� ���� �����");
if(id == playerid && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_KRED,"! ��� �� ���� ����� ����� �� ����");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, red, "/Supporter SetLevel [id] [level 1-4]");
new level = strval(cmd);
if(level < 1 || level > 4)return SendClientMessage(playerid,COLOR_WHITE, "/Supporter SetLevel [id] [level 1-4]");
DOF2_SetInt(SFile(id), "Supporters",level);
if(level == 1) levelname = "Normal";
if(level == 2) levelname = "Super";
if(level == 3) levelname = "Sub Leader";
if(level == 4) levelname = "Leader";
format(String,sizeof(String),"[Supporter] >> .%s -� ''%s'' ����� �� ''%s''",levelname,GetName(id),GetName(playerid));
SendMessageToSupporters(COLOR_LIGHTBLUE,String);
return 1;}
//==============================================================================
if(strcmp("Help",tmp,true) == 0){
if(!IsPlayerSupporter(playerid) && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
SendClientMessage(playerid,COLOR_PINK,"----- Supporter Help -----");
SendClientMessage(playerid,COLOR_WHITE,"/TakeCall - ����� �����");
SendClientMessage(playerid,COLOR_WHITE,"/SMute - ��� ����� ����");
SendClientMessage(playerid,COLOR_WHITE, "/SUnMute - ����� ����� ����");
SendClientMessage(playerid,COLOR_WHITE,"/SJail - ��� ����� ���");
SendClientMessage(playerid,COLOR_WHITE, "/SUnJail - ����� ����� ���");
SendClientMessage(playerid,COLOR_YELLOW,"~ - ����� ����� �����");
SendClientMessage(playerid,COLOR_PINK, "---------------------------------------------");
return 1;}}
//==============================================================================
if (strcmp("/NT",cmdtext, true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"----- {127eb4}NightTeam {FFFFFF}Online: -----");
new NightTeam_Count;
for(new i=0;i<=GetMaxPlayers();i++)
{
if(IsPlayerConnected(i) && IsPlayerNightTeam(i))
{
NightTeam_Count++;
if(DOF2_GetInt(SFile(i),"NightTeam") == 1) SupportersLevel = "Normal";
if(DOF2_GetInt(SFile(i),"NightTeam") == 2) SupportersLevel = "Super";
if(DOF2_GetInt(SFile(i),"NightTeam") == 3) SupportersLevel = "Sub Leader";
if(DOF2_GetInt(SFile(i),"NightTeam") == 4) SupportersLevel = "Leader";
format(String,sizeof(String),"%d. %s [id: %d] [%s]",NightTeam_Count,GetName(i),i,SupportersLevel);
SendClientMessage(playerid,COLOR_GRAY,String);
}
}
if(!NightTeam_Count)SendClientMessage(playerid,COLOR_KRED,".��� ���� ���� ���� �������");
return 1;
}
if(strcmp(cmd,"/NightTeam", true) == 0){
tmp = strtok(cmdtext, idx);
if(!IsPlayerNightTeam(playerid) && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(!strlen(tmp)) return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid,"/NightTeam Help");
//==============================================================================
if(strcmp(tmp,"Add", true) == 0){
tmp=strtok(cmdtext,idx);
new Rid = strval(tmp);
if(!IsPlayerNightTeam(playerid) && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(GetNightTeam(playerid) < 4 && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_KRED,"! ���� ������ ������ �� ���� ���� ����� ��� 4 ����� �����");
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE,"Usage: /NightTeam Add [ID/NAME]");
if(!IsNumeric(tmp)) Rid = ReturnPlayerID(tmp); else Rid = strval(tmp);
if(!IsPlayerConnected(Rid)) return SendClientMessage(playerid, COLOR_KRED, "! ����� �� �����");
if(IsPlayerNightTeam(Rid))return SendClientMessage(playerid,COLOR_WHITE,".���� �� ��� ���� ����");
format(String,sizeof(String),"[NightTeam] >> !���� ���� ���! ���� ���� %s",GetName(Rid));
SendMessageToNightTeam(COLOR_LIGHTGREEN,String);
SendClientMessage(Rid,COLOR_YELLOW,"! ��� ���� ��� ����� ����"),SendClientMessage(Rid,COLOR_PINK,"/NightTeam - ����� ���/�");
DOF2_SetInt(SFile(Rid),"NightTeam",1);
return 1;}
//==============================================================================
if(strcmp(tmp,"Kick", true) == 0){
tmp = strtok(cmdtext,idx);
new Rid = strval(tmp);
if(!IsPlayerNightTeam(playerid) && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(GetNightTeam(playerid) < 4 && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_KRED,"! ���� ������ ������ �� ���� ���� ����� ��� 4 ����� �����");
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE,"Usage: /NightTeam Kick [ID/NAME]");
if(!IsNumeric(tmp)) Rid = ReturnPlayerID(tmp); else Rid = strval(tmp);
if(!IsPlayerConnected(Rid)) return SendClientMessage(playerid, COLOR_KRED, "! ����� �� �����");
if(Rid == playerid)return SendClientMessage(playerid,COLOR_KRED,"���� ���� ����� �� ����");
if(!IsPlayerNightTeam(Rid))return SendClientMessage(playerid,COLOR_KRED,"! ���� �� ���� ���� �����");
DOF2_SetInt(SFile(Rid),"NightTeam",0);
format(String,sizeof(String),".����� ���� %s ����� �� �����",GetName(Rid));
SendClientMessage(playerid,COLOR_ORANGE,String);
return 1;}
//==============================================================================
if (strcmp(tmp,"SetLevel", true) == 0)
{
tmp = strtok(cmdtext, idx);
id = strval(tmp);
if(!IsPlayerNightTeam(playerid) && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
if(GetNightTeam(playerid) < 4 && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"! ���� ������ ������ �� ���� ���� ����� ��� 4 ����� �����");
if(!strlen(tmp)) return SendClientMessage(playerid, red, "/NightTeam SetLevel [id] [level 1-4]");
if(!IsPlayerConnected(id))return SendClientMessage(playerid, red, "����� �� �����");
if(!IsPlayerNightTeam(id))return SendClientMessage(playerid,COLOR_KRED,".���� �� ���� ��� ���� ����");
if(id == playerid && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_KRED,"! ��� �� ���� ����� ����� �� ����");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, red, "/NightTeam SetLevel [id] [level 1-4]");
new level = strval(cmd);
if(level < 1 || level > 4)return SendClientMessage(playerid,COLOR_WHITE, "/NightTeam SetLevel [id] [level 1-4]");
DOF2_SetInt(SFile(id), "NightTeam",level);
if(level == 1) levelname = "Normal";
if(level == 2) levelname = "Super";
if(level == 3) levelname = "Sub Leader";
if(level == 4) levelname = "Leader";
format(String,sizeof(String),"[NightTeam] >> .%s -� ''%s'' ����� �� ''%s''",levelname,GetName(id),GetName(playerid));
SendMessageToNightTeam(COLOR_LIGHTBLUE,String);
return 1;}
//==============================================================================
if(strcmp("Help",tmp,true) == 0){
if(!IsPlayerNightTeam(playerid) && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
SendClientMessage(playerid,COLOR_PINK,"----- NightTeam Help -----");
SendClientMessage(playerid,COLOR_WHITE,"/NC - ����� �'��");
SendClientMessage(playerid,COLOR_WHITE, "/NKick - ��� ����� ���");
SendClientMessage(playerid,COLOR_WHITE,"/NExplode - ����� ����");
SendClientMessage(playerid,COLOR_WHITE, "/NSpec - ������ �� ����");
SendClientMessage(playerid,COLOR_WHITE, "/NBan - ��� ����� ����");
SendClientMessage(playerid,COLOR_YELLOW,"& - ����� ����� ����");
SendClientMessage(playerid,COLOR_PINK, "---------------------------------------------");
return 1;}}
//==============================================================================
if(strcmp(cmdtext, "/nc", true) == 0){
if(!IsPlayerNightTeam(playerid) && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
for(new i=0; i<GetMaxPlayers(); i++) if(IsPlayerConnected(i) && !IsPlayerXAdmin(i) && !IsPlayerNightTeam(i) && !IsPlayerSupporter(i)) for(new o=0; o<100; o++) SendClientMessage(i,-1," ");
SendClientMessageToAll(COLOR_KRED,"An night team has cleaned the chat.");
return 1;}
//==============================================================================
if(!strcmp("/NKick", cmd, true)){
if(!IsPlayerNightTeam(playerid) && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /NKick [ID/NAME] [Reason]");
new id90 = strval(cmd);
if(!IsNumeric(cmd)) id90 = ReturnPlayerID(cmd); else id90 = strval(cmd);
if(!IsPlayerConnected(id90)) return SendClientMessage(playerid, COLOR_KRED, "! ����� �� �����");
if(id90 == IsPlayerNightTeam(playerid) && IsPlayerSupporter(playerid) && IsPlayerXAdmin(playerid))return SendClientMessage(playerid, COLOR_KRED, "���� ���� ��� ��� ������ / ���� ����");
tmp2 = strrest(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /NKick [ID/NAME] [Reason]");
format(String,128,"{FFFF00}\"%s\" has been Kicked from the server by NightTeam {FF0000}%s{FFFF00}. (Reason: %s)",GetName(id90),GetName(playerid),tmp2);
SendClientMessageToAll(COLOR_YELLOW,String);
SetTimerEx("KickPublic", 50, 0, "d", id90);
return 1;}
//==============================================================================
if(!strcmp("/NExplode", cmd, true)){
if(!IsPlayerNightTeam(playerid) && IsXLevel(playerid) < 14)return SendClientMessage(playerid,COLOR_WHITE,"/Help - ����� �� ���� �����,����� ���");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, COLOR_WHITE, "/NExplode [ID/NAME]");
id = strval(cmd);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_KRED, "! ����� �� �����");
if(id == playerid)return SendClientMessage(playerid, COLOR_KRED, "! ���� ���� ����� �� �����");
if(id == IsPlayerNightTeam(playerid) && IsPlayerSupporter(playerid) && IsPlayerXAdmin(playerid))return SendClientMessage(playerid, COLOR_KRED, "���� ���� ��� ����� ����� / ���� ����");
new Float:X2, Float:Y2, Float:Z2;
if(!IsPlayerInAnyVehicle(id)) GetPlayerPos(id,X2,Y2,Z2);
else GetVehiclePos(GetPlayerVehicleID(id),X2,Y2,Z2);
for(new i = 1; i <= 5; i++) CreateExplosion(X2,Y2,Z2,10,0);
format(String, sizeof(String), ".%s ����� �� �����",GetName(id));
SendClientMessage(playerid, COLOR_YELLOW, String);
format(String,128,"[NightTeam] << .%s ���� �� ����� ''%s''",GetName(id),GetName(playerid));
SendMessageToNightTeam(COLOR_LIGHTBLUE,String);
return 1;}
//==============================================================================
if(!strcmp(cmd, "/PInfo", true)) return ShowPlayerDialog(playerid,2666,DIALOG_STYLE_LIST,"����� ���� ����","�� ����\r\n�� ����� ������\r\n��� ������\r\n�����\r\n����'�","���","����");
if(!strcmp(cmd, "/Setting", true) || !strcmp(cmd, "/S", true)) return ShowPlayerDialog(playerid,2500,DIALOG_STYLE_LIST,"Settings","������ ������\r\n����� ��� ����\r\n�������� ��'��\r\n�������� ����\r\n������� ��������\r\n����� ���� ����\r\n����� ������\r\n����� ������","���","�����");
if (strcmp("/Credits", cmdtext, true, 10) == 0){
SendClientMessage(playerid, COLOR_WHITE,"----- ������� ������ -----");
SendClientMessage(playerid,0xFFFF00AA, "");
SendClientMessage(playerid,0xFFFF00AA, "GhostRider - �� ����������");
SendClientMessage(playerid, COLOR_WHITE,"-----------------");
return 1;}
if(!strcmp(cmd, "/Commands", true))
{
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid,-1, "Usage: /Commands [1-6]");
if(!strcmp(cmd, "1", true))
{
SendClientMessage(playerid, 0x1E90FFFF,"--- [1] ������ ---");
SendClientMessage(playerid,COLOR_WHITE, "/ChangeNick - ����� �� ������");
SendClientMessage(playerid,COLOR_WHITE, "/NextLevel - ����� �� ���� ����");
SendClientMessage(playerid,COLOR_WHITE, "/NextPoint - ����� �� ������ ����");
SendClientMessage(playerid,COLOR_WHITE, "/SetPass - ����� ������ ���");
SendClientMessage(playerid,COLOR_WHITE, "/SetTime - ����� ��� �����");
SendClientMessage(playerid,COLOR_WHITE, "/Ignore - ����� ������ / ������ �����");
SendClientMessage(playerid,COLOR_WHITE, "/TDStats - ���� ������� �� ����");
SendClientMessage(playerid,COLOR_WHITE, "/Kill - �������");
SendClientMessage(playerid, 0x1E90FFFF,"----- /Commands 2 - ����� -----");
return 1;
}
if(!strcmp(cmd, "2", true))
{
SendClientMessage(playerid, 0x1E90FFFF,"--- [2] ������ ---");
SendClientMessage(playerid,COLOR_WHITE, "/SaveSkin - ����� ���� �����");
SendClientMessage(playerid,COLOR_WHITE, "/DelSkin - ����� ���� �����");
SendClientMessage(playerid,COLOR_WHITE, "/Stats - ���� ���� / ���� ��� ����");
SendClientMessage(playerid,COLOR_WHITE, "/Pos [/SP - /LP] - ����� / ������� / ����� �����");
SendClientMessage(playerid,COLOR_WHITE, "/Dance - ����� ��� ���� �������");
SendClientMessage(playerid,COLOR_WHITE, "/NextWanted - ���� ���� ����� �������� ����");
SendClientMessage(playerid,COLOR_WHITE, "/CarJump - ����� �� ����");
SendClientMessage(playerid,COLOR_WHITE, "/Para [/P] - ���� ����� ����� ����");
SendClientMessage(playerid, 0x1E90FFFF,"----- /Commands 3 - ����� -----");
return 1;
}
if(!strcmp(cmd, "3", true))
{
SendClientMessage(playerid, 0x1E90FFFF,"--- [3] ������ ---");
SendClientMessage(playerid,COLOR_WHITE, "/Respond [/RE] - ����� ����� ����� ������ ���� �����");
SendClientMessage(playerid,COLOR_WHITE, "/FightStyle - ����� ������ ����");
SendClientMessage(playerid,COLOR_WHITE, "/ServerStats - ���������� ����");
SendClientMessage(playerid,COLOR_WHITE, "/GetRC - ����� ��� �� ���");
SendClientMessage(playerid,COLOR_WHITE, "/Eject - ���� ���� �����");
SendClientMessage(playerid,COLOR_WHITE, "/Honor [/H] - ������ ����� �������");
SendClientMessage(playerid,COLOR_WHITE, "/Car - ���� �� ���� �� ��� ����");
SendClientMessage(playerid,COLOR_WHITE, "/Bomb - ����� ����");
SendClientMessage(playerid, 0x1E90FFFF,"----- /Commands 4 - ����� -----");
return 1;
}
if(!strcmp(cmd, "4", true))
{
SendClientMessage(playerid, 0x1E90FFFF,"--- [4] ������ ---");
SendClientMessage(playerid,COLOR_WHITE, "/Spin - ����� �� ����� �������");
SendClientMessage(playerid,COLOR_WHITE, "/Fix - ����� ����");
SendClientMessage(playerid,COLOR_WHITE, "/PlayerJump - ����� �� �����");
SendClientMessage(playerid,COLOR_WHITE, "/Gang - ������ ���� ������ ����� �����");
SendClientMessage(playerid,COLOR_WHITE, "/MyGang - ���� �� ����� ���� ���� ��");
SendClientMessage(playerid,COLOR_WHITE, "/SGang - ���� �� ����� �� ���� ���");
SendClientMessage(playerid,COLOR_WHITE, "/Update - ����� �� ������� ������");
SendClientMessage(playerid,COLOR_WHITE, "/ChangeClass - TDM ����� ����� �");
SendClientMessage(playerid, 0x1E90FFFF,"----- /Commands 5 - ����� -----");
return 1;
}
if(!strcmp(cmd, "5", true))
{
SendClientMessage(playerid, 0x1E90FFFF,"--- [5] ������ ---");
SendClientMessage(playerid,COLOR_WHITE, "/SetEmail - ����� ��� ������ ����� ������");
SendClientMessage(playerid,COLOR_WHITE, "/ResetPass - ������ ����� ��� �������");
SendClientMessage(playerid,COLOR_WHITE, "/RemoveEmail - ������ ������� �������");
SendClientMessage(playerid,COLOR_WHITE, "/RespondEmail - ����� ��� ������ �� ���� ������");
SendClientMessage(playerid,COLOR_WHITE, "/Missions - ����� ���� ������� ��� ���� - ��� ���� ���");
SendClientMessage(playerid,COLOR_WHITE, "/Levels - ����� ��� ������� �������� ����� ���");
SendClientMessage(playerid,COLOR_WHITE, "/TTC - TDM ����� / ����� ������ ������� ��'�� �� ������ �");
SendClientMessage(playerid,COLOR_WHITE, "/HCC - ����� / ����� ������ ������� ��'�� �� �����");
SendClientMessage(playerid, 0x1E90FFFF,"----- /Commands 6 - ����� -----");
return 1;
}
if(!strcmp(cmd, "6", true))
{
SendClientMessage(playerid, 0x1E90FFFF,"--- [6] ������ ---");
SendClientMessage(playerid,COLOR_WHITE, "/Note - ������ / ����� ���� �����");
SendClientMessage(playerid,COLOR_WHITE, "/Notes - ������ ������ ������ ���");
SendClientMessage(playerid,COLOR_WHITE, "/DelNotes - ����� �� ������� �������");
SendClientMessage(playerid,COLOR_WHITE, "/Cam - ���� ����� �� ����� �����");
SendClientMessage(playerid,COLOR_WHITE, "/Pub - ����� ��'�� ����� �� ����� �����");
SendClientMessage(playerid,COLOR_WHITE, "/MChat - ���� / ��� ���� ������ �� �������");
SendClientMessage(playerid,COLOR_WHITE, "/CMessage - ���� / ��� ���� ������ �� ����� / �������");
SendClientMessage(playerid,COLOR_WHITE, "/BankLimit - ������ ������� ���� ����� �������");
SendClientMessage(playerid, 0x1E90FFFF," -------------------------------");
return 1;
}
return SendClientMessage(playerid, -1, "Usage: /Commands [1-6]");
}

if(!strcmp(cmd, "/CarHelp", true))
{
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, -1, "Usage: /CarHelp [1-5]");
if(!strcmp(cmd, "1", true)){
SendClientMessage(playerid, 0x1E90FFFF,"--- [1] ���� ������ ---");
SendClientMessage(playerid, white, "/Car - ���� �� ����");
SendClientMessage(playerid, white, "/BuyCar - ����� ���");
SendClientMessage(playerid, white, "/SellCar - ����� ���� ���");
SendClientMessage(playerid, white, "/CallCar - ����� ���� ���");
SendClientMessage(playerid, white, "/PayTax - ����� �� �����");
SendClientMessage(playerid, white, "/ResetCar - ����� ���� ���");
SendClientMessage(playerid, white, "/SpecCar - ���� ��� ���� ���");
SendClientMessage(playerid, white, "/CarEject - ����� ���� ����� ���");
SendClientMessage(playerid, 0x1E90FFFF,"--- /CarHelp 2 - ����� ---");
return 1;}

if(!strcmp(cmd, "2", true)){
SendClientMessage(playerid, 0x1E90FFFF,"--- [2] ���� ������ ---");
SendClientMessage(playerid, white, "/SetPrice - ���� ���� ������");
SendClientMessage(playerid, white, "/StopSale - ����� ���� ���� ������");
SendClientMessage(playerid, white, "/BuyNitro - ����� ����� ����� �����");
SendClientMessage(playerid, white, "/BuyHydraulics - ����� ���������� �����");
SendClientMessage(playerid, white, "/LockCar - ����� ����� ���� ���");
SendClientMessage(playerid, white, "/UnLockCar - ����� ����� ���� ���");
SendClientMessage(playerid, white, "/CarWheels - ������ ������ ������� �����");
SendClientMessage(playerid, white, "/RemoveWheels - ����� ������� ������� ������");
SendClientMessage(playerid, 0x1E90FFFF,"--- /CarHelp 3 - ����� ---");
return 1;}
if(!strcmp(cmd, "3", true)){
SendClientMessage(playerid, 0x1E90FFFF,"--- [3] ���� ������ ---");
SendClientMessage(playerid, white, "/Alarm - ����� / ����� �����");
SendClientMessage(playerid, white, "/Engine - ����� / ����� ����");
SendClientMessage(playerid, white, "/Lights - ����� / ����� �����");
SendClientMessage(playerid, white, "/Bonnet - ����� / ����� ���� ����");
SendClientMessage(playerid, white, "/Boot - '����� / ����� �����");
SendClientMessage(playerid, white, "/Objective - ����� / ����� ��� ����� ��� ����");
SendClientMessage(playerid, 0x1E90FFFF,"--- /CarHelp 4 - ����� ---");
return 1;}
if(!strcmp(cmd, "4", true)){
SendClientMessage(playerid, 0x1E90FFFF,"--- [4] ���� ������ ---");
SendClientMessage(playerid, white, "/VID - ����� �� ������ �� ���� ����");
SendClientMessage(playerid, white, "/VModel - ����� �� ����� �� ����");
SendClientMessage(playerid, white, "/ReplaceCar - ����� ��� �� ����");
SendClientMessage(playerid, white, "/CarDetails - ���� ����� �� ���� ���������");
SendClientMessage(playerid, white, "/BuyNeon - ����� ����");
SendClientMessage(playerid, white, "/SellNeon - ����� ����");
SendClientMessage(playerid, white, "/AddNeon - ����� ����");
SendClientMessage(playerid, 0x1E90FFFF,"--- /CarHelp 5 - ����� ---");
return 1;}
if(!strcmp(cmd, "5", true)){
SendClientMessage(playerid, 0x1E90FFFF,"--- [5] ���� ������ ---");
SendClientMessage(playerid, COLOR_PINK, "/Fix - ����� ��� �� ����");
SendClientMessage(playerid, COLOR_PINK, "/CarName - ����� �� ����");
SendClientMessage(playerid, COLOR_PINK, "/GotoCar - ������� ���� ���");
SendClientMessage(playerid, COLOR_PINK, "/BuyNeon - Neon ����� �����");
SendClientMessage(playerid, COLOR_PINK, "/SetCarColor - ����� ��� ���� ���");
SendClientMessage(playerid, COLOR_PINK, "/TmpCarColor - ����� ��� ���� ���� ������");
SendClientMessage(playerid, COLOR_PINK, "/WhoIsInMyCar - ������ �� ���� ���� ���");
SendClientMessage(playerid, 0x1E90FFFF,"--------------------------");
return 1;}
return SendClientMessage(playerid, -1, "Usage: /CarHelp [1-5]");}
//==============================================================================
//==============================================================================
if(!strcmp(cmdtext, "/Alarm", true)){
if(!(IsPlayerInAnyVehicle(playerid)))return SendClientMessage(playerid,-1,"���� ����");
new vehicleid = GetPlayerVehicleID(playerid);
if(GetPVarInt(playerid, "Alarm") == 0){
SetPVarInt(playerid, "Alarm", 1);
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
SetVehicleParamsEx(vehicleid, engine, lights, 1, doors, bonnet, boot, objective);
}else{
SetPVarInt(playerid, "Alarm", 0);
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
SetVehicleParamsEx(vehicleid, engine, lights, 0, doors, bonnet, boot, objective);}
return 1;
}
if(!strcmp(cmdtext, "/Engine", true)){
if(!(IsPlayerInAnyVehicle(playerid)))return SendClientMessage(playerid,-1,"���� ����");
new vehicleid = GetPlayerVehicleID(playerid);
if(GetPVarInt(playerid, "Engine") == 0){
SetPVarInt(playerid, "Engine", 1);
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
SetVehicleParamsEx(vehicleid, 1, lights, alarm, doors, bonnet, boot, objective);
}else{
SetPVarInt(playerid, "Engine", 0);
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);}
return 1;
}
if(!strcmp(cmdtext, "/Lights", true)){
if(!(IsPlayerInAnyVehicle(playerid)))return SendClientMessage(playerid,-1,"���� ����");
new vehicleid = GetPlayerVehicleID(playerid);
if(GetPVarInt(playerid, "Lights") == 0){
SetPVarInt(playerid, "Lights", 1);
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
SetVehicleParamsEx(vehicleid, engine, 1, alarm, doors, bonnet, boot, objective);
}else{
SetPVarInt(playerid, "Lights", 0);
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
SetVehicleParamsEx(vehicleid, engine, 0, alarm, doors, bonnet, boot, objective);}
return 1;
}
if(!strcmp(cmdtext, "/Bonnet", true)){
if(!(IsPlayerInAnyVehicle(playerid)))return SendClientMessage(playerid,-1,"���� ����");
new vehicleid = GetPlayerVehicleID(playerid);
if(GetPVarInt(playerid, "Bonnet") == 0){
SetPVarInt(playerid, "Bonnet", 1);
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 1, boot, objective);
}else{
SetPVarInt(playerid, "Bonnet", 0);
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 0, boot, objective);}
return 1;
}
if(!strcmp(cmdtext, "/Boot", true)){
if(!(IsPlayerInAnyVehicle(playerid)))return SendClientMessage(playerid,-1,"���� ����");
new vehicleid = GetPlayerVehicleID(playerid);
if(GetPVarInt(playerid, "Boot") == 0){
SetPVarInt(playerid, "Boot", 1);
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 1, objective);
}else{
SetPVarInt(playerid, "Boot", 0);
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 0, objective);}
return 1;
}
if(!strcmp(cmdtext, "/objective", true)){
if(!(IsPlayerInAnyVehicle(playerid)))return SendClientMessage(playerid,-1,"���� ����");
new vehicleid = GetPlayerVehicleID(playerid);
if(GetPVarInt(playerid, "objective") == 0){
SetPVarInt(playerid, "objective", 1);
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, 1);
}else{
SetPVarInt(playerid, "objective", 0);
GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, 0);}
return 1;
}
//==============================================================================
if(strcmp(cmd, "/VID", true) == 0){
if(!(IsPlayerInAnyVehicle(playerid)))return SendClientMessage(playerid,-1,"���� ����");
new vehicleid = GetPlayerVehicleID(playerid);
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
format(String,sizeof(String),"%d",vehicleid);
SendClientMessage(playerid,COLOR_LIGHTBLUE,String);
return 1;}
if(strcmp(cmd, "/vModel", true) == 0){
if(!(IsPlayerInAnyVehicle(playerid)))return SendClientMessage(playerid,-1,"���� ����");
new vehicleid = GetVehicleModel(playerid);
format(String,sizeof(String),"%d",vehicleid);
SendClientMessage(playerid,COLOR_LIGHTBLUE,String);
return 1;}
//==============================================================================
if(strcmp(cmdtext, "/Cars", true) == 0)
{
new Unbuyable = 0, HqCar = 0,SpecialCar = 0,SBuyAble = 0;
new SVCount = CreateVehicle(411,0,0,0,0,0,0,-1);
for(new i = 1; i < SVCount; i++)
{
if(DOF2_GetInt(CFile(i), "Buyable") == 0) Unbuyable++;
if(DOF2_GetInt(CFile(i), "Buyable") == -1) HqCar++;
if(DOF2_GetInt(CFile(i), "Buyable") == 1) SBuyAble++;
if(DOF2_GetInt(CFile(i), "Buyable") == 2) SpecialCar++;
}
DestroyVehicle(SVCount);
SendClientMessage(playerid, -1, "----- ���� ���� ------");
SendFormatMessage(playerid, COLOR_SATLA,".%d/%d :��' ����� ����",SVCount,MAX_VEHICLES);
SendClientMessage(playerid,-1,"");
SendFormatMessage(playerid, 0x00C3FFAA,".%d :����� ����� ������", SBuyAble);
SendFormatMessage(playerid, 0x00C3FFAA,".%d :����� ��������", Unbuyable);
SendFormatMessage(playerid, 0x00C3FFAA,".%d :����� �������", SpecialCar);
SendFormatMessage(playerid, 0x00C3FFAA,".%d :���� ������", HqCar);
SendClientMessage(playerid, -1, "-----------------------");
return 1;
}
//==============================================================================
//Cars System
if(strcmp(cmd, "/buyable", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!(IsPlayerInAnyVehicle(playerid)))return SendClientMessage(playerid,red,"/Buyable - ���� ����,���� ���� ����");
new vehicleid = GetPlayerVehicleID(playerid);
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
DOF2_SetInt(file,"Buyable",1),DOF2_SetInt(file,"CarOwned",0),DOF2_SetString(file,"CarOwner","none"),DOF2_SetInt(file,"CarLocked",0);
format(String,sizeof(String),".���� ���� ���� ������ , %s [ID: %d] ���� �� ����",GetVehicleName(vehicleid), vehicleid),SendClientMessage(playerid,COLOR_LIGHTBLUE,String);
PlayerPlaySound(playerid,1056,0.0, 0.0, 0.0),UpdateCar(GetPlayerVehicleID(playerid));
return 1;}
//==============================================================================
if(strcmp(cmd, "/unbuyable", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid,red,"/Unbuyable - ���� ����,���� ���� ����");
new vehicleid = GetPlayerVehicleID(playerid);
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
DOF2_SetInt(file,"Buyable",0);
format(String,sizeof(String),".���� ������ , %s [ID: %d] ���� �� ����",GetVehicleName(vehicleid), vehicleid),SendClientMessage(playerid,COLOR_LIGHTBLUE,String);
PlayerPlaySound(playerid,1056,0.0, 0.0, 0.0),UpdateCar(GetPlayerVehicleID(playerid));
return 1;}
if(strcmp(cmd, "/Hqcar", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid,red,"/HqCar - ���� ����,���� ���� ����");
new vehicleid = GetPlayerVehicleID(playerid);
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
DOF2_SetInt(file,"Buyable",-1);
format(String,sizeof(String),".���� ����� , %s [ID: %d] ���� �� ����",GetVehicleName(vehicleid), vehicleid),SendClientMessage(playerid,COLOR_LIGHTBLUE,String);
PlayerPlaySound(playerid,1056,0.0, 0.0, 0.0),UpdateCar(GetPlayerVehicleID(playerid));
return 1;}
if(strcmp(cmd, "/Scar", true) == 0){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!IsPlayerInAnyVehicle(playerid))return	SendClientMessage(playerid,red,"/Scar - ���� ����,���� ���� ����");
new vehicleid = GetPlayerVehicleID(playerid);
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
DOF2_SetInt(file,"Buyable",2);
format(String,sizeof(String),".���� �����, %s [ID: %d] ���� �� ����",GetVehicleName(vehicleid), vehicleid),SendClientMessage(playerid,COLOR_LIGHTBLUE,String);
PlayerPlaySound(playerid,1056,0.0, 0.0, 0.0),UpdateCar(GetPlayerVehicleID(playerid)),DOF2_SetInt(file,"Price",3500000);
return 1;}
//==============================================================================
if(strcmp(cmd, "/Car", true) == 0){
{
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
format(String,sizeof(String),"--- [{696969}%s{FFFFFF}] ���� ���� ���� ---",GetVehicleName(GetPlayerVehicleID(playerid)));
 SendClientMessage(playerid,COLOR_WHITE,String);
 format(String,sizeof(String),"{FFFFFF}%d {00B9F5}:�����",GetPlayerVehicleID(playerid));
 SendClientMessage(playerid,COLOR_WHITE,String);
   if(DOF2_GetInt(file,"CarOwned") != 0 ) {
 format(String,sizeof(String),"{FFFFFF}%s {00B9F5}:�����",DOF2_GetString(file,"CarOwner"));
 SendClientMessage(playerid,COLOR_WHITE,String);
 }else SendClientMessage(playerid,COLOR_WHITE,"{00B9F5}�����: {FFFFFF}���");
 format(String,sizeof(String),"{FFFFFF}%s {00B9F5}:���� ����",GetNum(DOF2_GetInt(file,"Price")));
 SendClientMessage(playerid,COLOR_WHITE,String);
  if(DOF2_GetInt(file,"PayTaxTime") >30)
 {
 }else{
 format(String,sizeof(String),"{FFFFFF}%s {00B9F5}:����� ��",GetNum(DOF2_GetInt(file,"Price")/10));
 SendClientMessage(playerid,COLOR_WHITE,String);
 }
 if(DOF2_GetInt(file,"PayTaxTime") >30)
 {

 }else if(DOF2_GetInt(file,"PayTaxTime") == 1 ){format(String,sizeof(String),"{00B9F5}���� ����� ��� ����: {FF0000}����",DOF2_GetInt(file,"PayTaxTime"));SendClientMessage(playerid,COLOR_WHITE,String);
 }else if(DOF2_GetInt(file,"PayTaxTime") == 2 ){format(String,sizeof(String),"{00B9F5}���� ����� ��� ����: {FF0000}���",DOF2_GetInt(file,"PayTaxTime"));SendClientMessage(playerid,COLOR_WHITE,String);
 }else if(DOF2_GetInt(file,"PayTaxTime") == 3 ){format(String,sizeof(String),"{00B9F5}���� ����� ��� ����: {FF0000}��� ������",DOF2_GetInt(file,"PayTaxTime"));SendClientMessage(playerid,COLOR_WHITE,String);
 }else if(DOF2_GetInt(file,"PayTaxTime") > 30)
 {
  }else{
 format(String,sizeof(String),"{00B9F5}���� ����� ��� ����: {FFFFFF}%d ����",DOF2_GetInt(file,"PayTaxTime"));
 SendClientMessage(playerid,COLOR_WHITE,String);
 }
SendClientMessage(playerid,COLOR_WHITE,"/CarDetails - {F59300}���� ���� �� ���� ����");
SendClientMessage(playerid,COLOR_WHITE,"-----------------------------------------");
}
return 1; }
//==============================================================================
if(strcmp(cmd, "/CarDetails", true) == 0){
{
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
format(String,sizeof(String),"-- {F59300}[%s]{FFFFFF} ���� ���� ���� --",GetVehicleName(GetPlayerVehicleID(playerid)));
SendClientMessage(playerid,COLOR_WHITE,String);

if(DOF2_GetInt(file,"Nitro") != 0 ) {
SendClientMessage(playerid,COLOR_WHITE,"{FFFFFF}Nitro {F59300}- ��");
}else SendClientMessage(playerid,COLOR_WHITE,"{FFFFFF}Nitro {00B9F5}- ���");
if(DOF2_GetInt(file,"Hydraulics") != 0 ) {
SendClientMessage(playerid,COLOR_WHITE,"{FFFFFF}Hydraulics {F59300}- ��");
}else SendClientMessage(playerid,COLOR_WHITE,"{FFFFFF}Hydraulics {00B9F5}- ���");
if(DOF2_GetInt(file,"Wheels") != 0 ) {
SendClientMessage(playerid,COLOR_WHITE,"{FFFFFF}Wheels {F59300}- ��");
}else SendClientMessage(playerid,COLOR_WHITE,"{FFFFFF}Wheels {00B9F5}- ���");
if(DOF2_GetInt(file,"Neon") != 0 ) {
SendClientMessage(playerid,COLOR_WHITE,"{FFFFFF}Neon {F59300}- ��");
}else SendClientMessage(playerid,COLOR_WHITE,"{FFFFFF}Neon {00B9F5}- ���");
if(DOF2_GetInt(file,"Disco") != 0 ) {
SendClientMessage(playerid,COLOR_WHITE,"{FFFFFF}Disco {F59300}- ��");
}else SendClientMessage(playerid,COLOR_WHITE,"{FFFFFF}Disco {00B9F5}- ���");
SendClientMessage(playerid,COLOR_WHITE,"-----------------------------------------");
}
return 1; }
//==============================================================================
if(strcmp(cmd, "/lockcar", true) == 0){
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,COLOR_WHITE,".�� ���� ���� ����� �� ����");
if(GetPlayerVehicleID(playerid) >= VCount) return SendClientMessage(playerid,COLOR_WHITE,".�� ���� ����� ��� ������");
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0) return SendClientMessage(playerid,COLOR_WHITE,".��� ������� ���");
for (new i=0;i<GetMaxPlayers();i++) if(i != playerid) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
SendClientMessage(playerid,COLOR_WHITE, "!���� �� ����");
PlayerPlaySound(playerid,1056,0.0,0.0,0.0);
return 1;
}
//==============================================================================
if(strcmp(cmd, "/unlockcar", true) == 0)
{
if(DOF2_GetInt(SFile(playerid),"CarID")== 0) return SendClientMessage(playerid,COLOR_WHITE,".��� ������� ���");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,COLOR_WHITE,".�� ���� ���� ����� �� ����");
if(GetPlayerVehicleID(playerid) >= VCount) return SendClientMessage(playerid,COLOR_WHITE,".�� ���� ����� ��� ������");
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
for (new i=0;i<GetMaxPlayers();i++) if(i != playerid) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0),SendClientMessage(playerid,COLOR_WHITE, "!���� �� ����"),PlayerPlaySound(playerid,1056,0.0,0.0,0.0);
return 1;}
//===========================================================================
if(strcmp(cmd, "/setprice", true) == 0)
{
if(DOF2_GetInt(SFile(playerid),"CarId")== 0) return SendClientMessage(playerid,COLOR_WHITE,".��� ������� ���");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
tmp = strtok(cmdtext, idx);
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE,"/SetPrice [1-10,000,000] - �����");
if(!IsNumber(tmp))return SendClientMessage(playerid,COLOR_WHITE,"/SetPrice [1-10,000,000] - �����");
if(strval_fix(tmp) < 1 || strval_fix(tmp) > 10000000)return SendClientMessage(playerid,COLOR_WHITE,"/SetPrice [1-10,000,000] - �����");
DOF2_SetInt(file,"SetPrice",strval_fix(tmp)),DOF2_SetInt(file,"CarOwned", 2);
format(String,sizeof(String),".[%s] ������ ����� \"%s\" - ���� �� ����",GetNum(strval_fix(tmp)),GetVehicleName(GetPlayerVehicleID(playerid))),SendClientMessage(playerid,COLOR_LIGHTBLUE,String),SendClientMessage(playerid,COLOR_LIGHTBLUE,"/StopSale - ������ ������ ���/�");
SetTimerEx("UpdateCar",1000,0,"d",GetPlayerVehicleID(playerid));
return 1;}
if(strcmp(cmd, "/StopSale", true) == 0)
{
if(DOF2_GetInt(SFile(playerid),"CarId")== 0) return SendClientMessage(playerid,COLOR_WHITE,".��� ������� ���");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
if(DOF2_GetInt(file,"CarOwned") != 2)return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� ���� ������");
DOF2_SetInt(file,"SetPrice",0),DOF2_SetInt(file,"CarOwned",1);
format(String,sizeof(String),"�� ���� ������ \"%s\" ��� ���� �",GetVehicleName(GetPlayerVehicleID(playerid))),SendClientMessage(playerid,COLOR_LIGHTBLUE,String);
SetTimerEx("UpdateCar",1000,0,"d",GetPlayerVehicleID(playerid));
return 1;}
//==============================================================================*/
if(strcmp(cmd, "/Buycar", true) == 0){
if(CarSystem) return SendClientMessage(playerid,COLOR_KRED,".������ ����� / ����� ������ ����� ���");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ���� ");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
new vehicleid = GetPlayerVehicleID(playerid);
if(DOF2_GetInt(file,"Buyable") == 3) return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� ������ ���� ���� ���� ������ ");
if(DOF2_GetInt(file,"Buyable") == 0) return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� ������ ���� ���� ���� ������ ");
if(DOF2_GetInt(file,"Buyable") == -1) return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� ������ ���� ���� ���� ������");
if(GetPlayerVehicleID(playerid) >= VCount) return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� ������ ���� ���� ���� ������  ");
if(DOF2_GetInt(file,"CarOwned") == 1 ){
format(String,sizeof(String),"����� ���� ������ %s ���� ������",DOF2_GetString(file,"CarOwner")),SendClientMessage(playerid,COLOR_WHITE,String);
return 1;}
if(DOF2_GetInt(SFile(playerid),"OwnCar") != 0) return SendClientMessage(playerid,COLOR_WHITE,"/SellCar - ���� ��� �������,�� ��� ����� ��� �� ��� �� ���� ����/�");
if(!DOF2_FileExists(file)){
SendClientMessage(playerid,red,"��� �� ���� ��� �� �����");
return 1;}
if(DOF2_GetInt(file,"CarOwned") == 2){
if(GetPlayerMoney(playerid) < DOF2_GetInt(file,"SetPrice")){
format(String,sizeof(String),".%s - ��� ���� �� ����� ����� ������ ��� ��",GetNum(DOF2_GetInt(file,"SetPrice"))),SendClientMessage(playerid,COLOR_WHITE,String);
return 1;}
format(String,sizeof(String),".%s ����� %s ���� ������, \"%s\" ��� ���, ���� �� ����",GetNum(DOF2_GetInt(file,"SetPrice")),DOF2_GetString(file,"CarOwner"),GetVehicleName(vehicleid)),SendClientMessage(playerid,COLOR_WHITE,String);
DOF2_SetInt(SFile1(DOF2_GetString(file,"CarOwner")),"Bank",DOF2_GetInt(SFile1(DOF2_GetString(file,"CarOwner")),"Bank") + DOF2_GetInt(file,"SetPrice")),DOF2_SetInt(SFile1(DOF2_GetString(file,"CarOwner")),"OwnCar",0),DOF2_SetInt(SFile1(DOF2_GetString(file,"CarOwner")),"CarID",0),DOF2_SetString(SFile1(DOF2_GetString(file,"CarOwner")),"ConnectMsg","���� ���� �'� ����� ���, ���� ������ ����� ����� ������ ���� ��� ");
DOF2_SetString(file,"CarOwner",playername),DOF2_SetInt(SFile(playerid),"OwnCar",1),DOF2_SetInt(SFile(playerid),"CarID",vehicleid),GivePlayerMoney(playerid,-DOF2_GetInt(file,"SetPrice")),DOF2_SetInt(file,"CarOwned",1),SetTimerEx("UpdateCar",1000,0,"d",GetPlayerVehicleID(playerid));
return 1;}
if(GetPlayerMoney(playerid) < DOF2_GetInt(file,"Price")){ format(String,sizeof(String),".%s - ��� ���� �� ����� ����� ������ ��� ��",GetNum(DOF2_GetInt(file,"Price"))),SendClientMessage(playerid,COLOR_WHITE,String);
return 1;}
SetTimerEx("BuyCar",100,0,"i",playerid);
return 1;}
//==============================================================================
if(strcmp(cmd, "/Sellcar", true) == 0)
{
if(CarSystem) return SendClientMessage(playerid,COLOR_KRED,".������ ����� / ����� ������ ����� ���");
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0) return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
new vehicleid = GetPlayerVehicleID(playerid);
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
if(!DOF2_FileExists(file)){
SendClientMessage(playerid,red,"��� �� ���� ��� �� �����");
}else{
for	(new i=0;i<GetMaxPlayers();i++) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
DOF2_SetInt(file,"CarOwned",0),DOF2_SetString(file,"CarOwner","none"),DOF2_SetInt(file,"SetPrice",0),DOF2_SetString(file,"carname1",GetVehicleName(vehicleid));
strmid(DOF2_GetString(file,"CarOwner"), DOF2_GetString(file,"CarOwner"), 0, strlen(DOF2_GetString(file,"CarOwner")), 255);
DOF2_SetInt(SFile(playerid),"CarID",0),DOF2_SetInt(SFile(playerid),"OwnCar",0);
DOF2_SetInt(file,"Hydraulics",0);
DOF2_SetInt(file,"Nitro",0);
DOF2_SetInt(file,"Neon",0);
DOF2_SetInt(file,"Disco",0);
DOF2_SetInt(file,"Wheels",0);
SetVehicleToRespawn(GetPlayerVehicleID(playerid));
printf("[CAR]  %s Sold His Car, A %s ID %d",playername,GetVehicleName(GetPlayerVehicleID(playerid)),GetPlayerVehicleID(playerid));
format(String,256,".[%s] ����� ��� ����� ������ ,\"%s\" ���� �� ���� �",GetNum(DOF2_GetInt(file,"Price")/2),GetVehicleName(GetPlayerVehicleID(playerid)));
SendClientMessage(playerid,COLOR_ORANGE,String),SetVehicleToRespawn(GetPlayerVehicleID(playerid)),GivePlayerMoney(playerid,DOF2_GetInt(file,"Price")/2),UpdateCar(GetPlayerVehicleID(playerid));
}

return 1;
}
if(!strcmp(cmd, "/CallCar", true) || !strcmp(cmd, "/Cc", true))
{
if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,".��/� ��� ����/� ����");
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)return SendClientMessage(playerid,red,".�� ���� ���� �� ���� ������ ��");
for(new i=0;i<GetMaxPlayers();i++) if( IsPlayerConnected(i) && IsPlayerInVehicle(i,DOF2_GetInt(SFile(playerid),"CarId")) && i != playerid )
{
new Float:OutCarPos[3];
GetPlayerPos(i,OutCarPos[0],OutCarPos[1],OutCarPos[2]),SetPlayerPos(i,OutCarPos[0],OutCarPos[1],OutCarPos[2]),format(String,256,"! ���� �� ����, ����� �����, %s - ��� ����",playername),SendClientMessage(i,COLOR_ORANGE,String),RemovePlayerFromVehicle(i);
}
GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]),GetPlayerFacingAngle(playerid,Pos[playerid][3]),PutPlayerInVehicle(playerid,DOF2_GetInt(SFile(playerid),"CarId"),0),SetVehiclePos(DOF2_GetInt(SFile(playerid),"CarId"),Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]),SetVehicleZAngle(DOF2_GetInt(SFile(playerid),"CarId"),Pos[playerid][3]);
new car;
car = GetPlayerVehicleID(playerid),format(String,256,"%s ,��� %s ���� ��� �",GetName(playerid),VehNames[GetVehicleModel(car)-400]);
return 1;
}
if(strcmp(cmd, "/ResetCar", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
SetVehicleToRespawn(DOF2_GetInt(SFile(playerid),"CarID")),format(String,256,"! ���� ������ %s ����",VehicleInfo[DOF2_GetInt(SFile(playerid),"CarID")][CarName]),SendClientMessage(playerid,COLOR_ORANGE,String),PutPlayerInVehicle(playerid,DOF2_GetInt(SFile(playerid),"CarID"),0);
return 1;
}
if(strcmp(cmd, "/SpecCar", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
TogglePlayerSpectating(playerid, 1),PlayerSpectateVehicle(playerid,DOF2_GetInt(SFile(playerid),"CarID")),format(String,sizeof(String),"��� ��� ���� �����"),SendClientMessage(playerid,COLOR_PINK,String);
return 1;
}
//==============================================================================
if(strcmp(cmd, "/SpecCaroff", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
TogglePlayerSpectating(playerid, 0),SendClientMessage(playerid,COLOR_ORANGE,".����� �� ������ ���� ���"),SetTimerEx("PosAfterSpec",1700,0,"d",playerid);
return 1;
}
//==============================================================================
if(strcmp(cmd,"/CarEject", true)==0){
new pid;
tmp = strtok(cmdtext,idx);
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,"! ��� �� ����");
if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,COLOR_KRED,".���� ����");
if(!strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,"Usage: /Eject [ID/NAME]");
pid = strval(tmp);
if(!IsNumeric(tmp)) pid = ReturnPlayerID(tmp); else pid = strval(tmp);
if(!IsPlayerConnected(pid)) return SendClientMessage(playerid,COLOR_KRED,"! ����� �� �����");
if(!IsPlayerInVehicle(pid,GetPlayerVehicleID(playerid))) return SendClientMessage(playerid,COLOR_KRED,"! ����� �� ����");
RemovePlayerFromVehicle(pid),format(String,sizeof(String),".����� ''%s'' ���� ��",GetName(pid)),SendClientMessage(playerid,COLOR_LIGHTBLUE,String);
return 1;}
//==============================================================================
if(strcmp(cmd, "/BuyHydraulics", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,"! ��� �� ����");
if(GetPlayerMoney(playerid) < 50000) return SendClientMessage(playerid,COLOR_KRED,"! [$50,000] ��� �� �� ����� �����");
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
switch(Model){ case 448,461,462,463,468,471,509,510,521,522,523,581,586: return SendClientMessage(playerid,COLOR_KRED,"! ������ �� �� ����� ���������/�������");}
if(DOF2_GetInt(file,"Hydraulics") != 0)return SendClientMessage(playerid,COLOR_WHITE,".����� �� ��� ������");
SendClientMessage(playerid,COLOR_LIGHTGREEN, "[$�����! ���� ����� ������ ����� [50,000"),DOF2_SetInt(file,"Hydraulics",1),AddVehicleComponent(GetPlayerVehicleID(playerid),1087),GivePlayerMoney(playerid,-50000);
return 1;}
if(strcmp(cmd, "/SellHydraulics", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,"! ��� �� ����");
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
switch(Model){ case 448,461,462,463,468,471,509,510,521,522,523,581,586: return SendClientMessage(playerid,COLOR_KRED,"! ������ �� �� ����� ���������/�������"); }
if(DOF2_GetInt(file,"Hydraulics") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ����� ������");
DOF2_SetInt(file,"Hydraulics",0),SendClientMessage(playerid,COLOR_WHITE, "[$25,000] ���� �� ������� ������! �����"),GivePlayerMoney(playerid,25000);
return 1;}
//==============================================================================
if(strcmp(cmd, "/BuyNitro", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,"! ��� �� ����");
if(GetPlayerMoney(playerid) < 50000) return SendClientMessage(playerid,COLOR_KRED,"! $��� �� 50,000");
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
switch(Model){ case 448,461,462,463,468,471,509,510,521,522,523,581,586: return SendClientMessage(playerid,COLOR_WHITE,".�������, ��� �� ���� ���� ������"); }
if(DOF2_GetInt(file,"Nitro") != 0)return SendClientMessage(playerid,COLOR_WHITE,".����� �� ��� �����");
SendClientMessage(playerid,COLOR_LIGHTGREEN, "[$50,000] �����! ���� ����� ����� �����"),DOF2_SetInt(file,"Nitro",1),AddVehicleComponent(GetPlayerVehicleID(playerid),1010),GivePlayerMoney(playerid,-50000);
return 1;}
//==============================================================================
if(strcmp(cmd, "/NitroUpgrade", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,"! ��� �� ����");
if(DOF2_GetInt(file,"Nitro") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ����� ��� �����");
if(GetPlayerMoney(playerid) < 50000) return SendClientMessage(playerid,COLOR_KRED,"! $��� �� 50,000");
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
switch(Model){ case 448,461,462,463,468,471,509,510,521,522,523,581,586: return SendClientMessage(playerid,COLOR_WHITE,".�������, ��� �� ���� ���� ������"); }
if(DOF2_GetInt(file,"Nitro") == 2)return SendClientMessage(playerid,COLOR_WHITE,".����� �� ��� �����  �������");
SendClientMessage(playerid,COLOR_LIGHTGREEN, "[$50,000] �����! ���� ����� ����� ������� �����"),DOF2_SetInt(file,"Nitro",2),AddVehicleComponent(GetPlayerVehicleID(playerid),1010),GivePlayerMoney(playerid,-50000);
return 1;}
//==============================================================================
if(strcmp(cmd, "/SellNitro", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,"! ��� �� ����");
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
if(DOF2_GetInt(file,"Nitro") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ����� ��� �����");
SendClientMessage(playerid,COLOR_LIGHTGREEN, "[$25,000] ���� �� ������ ������! �����"),DOF2_SetInt(file,"Nitro",0),GivePlayerMoney(playerid,25000);
return 1;}
//==============================================================================
if(strcmp(cmd, "/BuyNeon", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,"! ��� �� ����");
if(GetPlayerMoney(playerid) < 5000000) return SendClientMessage(playerid,COLOR_KRED,"! $��� �� 5,000,000");
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
if(DOF2_GetInt(file,"Buyable") != 2)return SendClientMessage(playerid,COLOR_KRED,"���� �� ���� �����");
if(DOF2_GetInt(file,"Neon") != 0)return SendClientMessage(playerid,COLOR_WHITE,".����� �� ��� ����");
SendClientMessage(playerid,COLOR_LIGHTGREEN, "[$5,000,000] �����! ���� ����� ���� �����"),SendClientMessage(playerid,COLOR_ORANGE, "/AddNeon - ��� ������ ����� ����/�"),DOF2_SetInt(file,"Neon",1),GivePlayerMoney(playerid,-5000000);
return 1;}
if(!strcmp(cmd, "/AddNeon", true) || !strcmp(cmd, "/An", true))
{
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
GetPlayerName(playerid,playername,30);
if(DOF2_GetInt(file,"Neon") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ����� ����");
ShowPlayerDialog(playerid, neondialog1, DIALOG_STYLE_LIST, "Neon Color", "Blue\nRed\nGreen\nWhite\nPink\nYellow\nDelete Neon", "Select", "Cancel");
return 1;
}
if(strcmp(cmd, "/SellNeon", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
GetPlayerName(playerid,playername,30);
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
if(DOF2_GetInt(file,"Neon") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ����� ����");
SendClientMessage(playerid,COLOR_LIGHTGREEN, ".500,000$ ���� �� ����� ������,����� ������"),DOF2_SetInt(file,"Neon",0),GivePlayerMoney(playerid,500000);
return 1;}
//==============================================================================
if(strcmp(cmd, "/BuyDisco", true) == 0){
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
GetPlayerName(playerid,playername,30);
if(GetPlayerMoney(playerid) < 2500000) return SendClientMessage(playerid,COLOR_WHITE,".$2,500,000 - ��� ���� ����� ���");
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
if(DOF2_GetInt(file,"Buyable") != 2)return SendClientMessage(playerid,COLOR_KRED,"����� �� ���� �����");
if(DOF2_GetInt(file,"Disco") != 0)return SendClientMessage(playerid,COLOR_WHITE,"����� �� ��� �����");
SendClientMessage(playerid,COLOR_LIGHTGREEN, "[$2,500,000] �����! ���� ����� ����� �����"),DOF2_SetInt(file,"Disco",1),GivePlayerMoney(playerid,-2500000);
return 1;
}
if(!strcmp(cmd, "/CarDisco", true) || !strcmp(cmd, "/CarDisco", true))
{
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
GetPlayerName(playerid,playername,30);
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
if(DOF2_GetInt(file,"Disco") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ����� �����");
CarDisco[playerid] = 1,SetTimerEx("CarDiscoO",200,1,"%d", playerid);
return 1;
}
//==============================================================================
//Replace
/*if(strcmp(cmd,"/ReplaceCar",true)==0)
{
cmd = strtok(cmdtext,idx);
if(!strlen(cmd)) return SendClientMessage(playerid,COLOR_WHITE,"/Replacecar [id] [Money] :���� �����");
id = strval(cmd);
tmp2 = strtok(cmdtext,idx);
if(!strlen(tmp2)) return SendClientMessage(playerid,COLOR_WHITE,"/Replacecar [id] [Money] :���� �����");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, Red, ".�� ����� ID");
if(id == playerid)return SendClientMessage(playerid, Red, ".���� ���� ������ �� ���� �� ����");
if(DOF2_GetInt(SFile(playerid),"OwnCar")== 0)return SendClientMessage(playerid,red,"��� �� ���");
if(DOF2_GetInt(SFile(id),"OwnCar")== 0)return SendClientMessage(playerid,red,"������ ��� ���");
if(HaveReplace[id][Invite] == 1 || HaveReplace[id][Inviter] == 1 )return SendClientMessage(playerid,red,"��� �� ���� ���� �� ����� �� ����� ������ ���� ��� ������ ����");
if(HaveReplace[playerid][Invite] == 1 || HaveReplace[playerid][Inviter] == 1)return SendClientMessage(playerid,red,"��� �� ���� ���� �� ����� �� ����� ������ ���� ��� ������ ���� ����");
if(strval(tmp2) > 1000000 || strval(tmp2) < 0)return SendClientMessage(playerid,COLOR_WHITE,"/Replacecar [id] [Extra money 0-1,000,000] :���� �����");
HaveReplace[id][Invite] = 1,HaveReplace[id][Money] = strval(tmp2),HaveReplace[playerid][Inviter] = 1,HaveReplace[id][IDInviter] = playerid,HaveReplace[playerid][IDInviter1] = id;
format(String,sizeof(String),".$%s ����� ���� ������ ������� ������ �� %s",strval(tmp2),GetName(playerid)),SendClientMessage(id,yellow,String);
format(String,sizeof(String),"/AccpetReplace - ���� ����� | /CancelReplace - ���� ��  ������"),SendClientMessage(id,yellow,String);
return 1;}

if(strcmp(cmd,"/CancelReplace",true)==0)
{
new IdInvite;
IdInvite = HaveReplace[playerid][IDInviter1];
if(!HaveReplace[playerid][Inviter])return SendClientMessage(playerid,red,"�� ����� ���� �����");
format(String,sizeof(String),"���� �� ������ %s",GetName(playerid));
SendClientMessage(IdInvite,yellow,String);
format(String,sizeof(String),"����� �� ������");
SendClientMessage(playerid,yellow,String);
HaveReplace[IdInvite][Invite] = 0,HaveReplace[IdInvite][Money] = 0,HaveReplace[playerid][Inviter] = 0;
return 1;}

if(strcmp(cmd,"/AccpetReplace",true)==0)
{
new IdInvite;
IdInvite = HaveReplace[playerid][IDInviter];
if(!HaveReplace[playerid][Invite])return SendClientMessage(playerid,red,"�� ����� ������");
if(GetPlayerMoney(playerid) < HaveReplace[playerid][Money])return SendClientMessage(playerid,red,"��� �� ����� ���");
if(DOF2_GetInt(SFile(playerid),"OwnCar")== 0)return SendClientMessage(playerid,red,"��� �� ���");
DOF2_SetString(file,"CarOwner",GetName(IdInvite));
format(file,sizeof(file),"Car/car%d.txt",DOF2_GetInt(SFile(IdInvite),"CarID"));
DOF2_SetString(file,"CarOwner",GetName(playerid));
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
DOF2_SetInt(SFile(playerid),"CarID1",DOF2_GetInt(SFile(IdInvite),"CarID")),DOF2_SetInt(SFile(IdInvite),"CarID",DOF2_GetInt(SFile(playerid),"CarID")),DOF2_SetInt(SFile(playerid),"CarID",DOF2_GetInt(SFile(playerid),"CarID1")),DOF2_Unset(SFile(playerid),"CarID1");
GivePlayerMoney(IdInvite,HaveReplace[playerid][Money]),GivePlayerMoney(playerid,-HaveReplace[playerid][Money]),SetTimerEx("UpdateCar",1000,0,"d",DOF2_GetInt(SFile(IdInvite),"CarID")),SetTimerEx("UpdateCar",1000,0,"d",DOF2_GetInt(SFile(playerid),"CarID"));
format(String,sizeof(String),"����� ���� ������ ������ %s",GetName(IdInvite)),SendClientMessage(playerid,yellow,String);
format(String,sizeof(String),"����� ���� ������ ������ %s",GetName(playerid)),SendClientMessage(IdInvite,yellow,String);
HaveReplace[playerid][Invite] = 0,HaveReplace[playerid][Money] = 0,HaveReplace[IdInvite][Inviter] = 0;
return 1;}*/
if(strcmp(cmd, "/CarWheels", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
GetPlayerName(playerid,playername,30);
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
	switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
	{
		case 581,509,481,462,521,463,510,522,461,448,471,468,586,523: return SendClientMessage(playerid,COLOR_KRED,"! ������ �� �� ����� ���������");
		case 548,425,417,487,488,497,563,447,469: return SendClientMessage(playerid,COLOR_KRED,"! ������ �� �� ����� �������");
		case 592,577,511,512,593,520,553,476,519,460,513: return SendClientMessage(playerid,COLOR_KRED,"! ������ �� �� ����� �������");
		case 472,473,493,595,484,430,453,452,446,454: return SendClientMessage(playerid,COLOR_KRED,"! ������ �� �� ����� ������");
	}
ShowPlayerDialog(playerid, 7116, DIALOG_STYLE_LIST, "����� ������", "Shadow\t<300,000>\nMega\t<500,000>\nRimshine <100,000>\nWires <100,000>\nClassic\t<200,000>\nTwist\t<300,000>\nCutter\t<400,000>\nSwitch\t<850,000>\nGrove\t<200,000>\nImport\t<300,000>\nDollar\t<500,000>\nTrance\t<200,000>\nAtomic\t<300,000>", "�����", "�����");
return 1;
}
if(strcmp(cmd, "/RemoveWheels", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
GetPlayerName(playerid,playername,30);
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
if(DOF2_GetInt(file,"Wheels") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ����� ������");
SendClientMessage(playerid,COLOR_LIGHTGREEN, ".25,000$ ���� �� ������� ������"),DOF2_SetInt(file,"Wheels",0),GivePlayerMoney(playerid,25000);
return 1;
}
if(strcmp(cmd, "/SetCarColor", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
if(DOF2_GetInt(file,"Buyable") != 2)return SendClientMessage(playerid,COLOR_WHITE,".����� ��� ���� ������ �� ���� �����");
if(GetPlayerMoney(playerid) < 500000) return SendClientMessage(playerid,COLOR_WHITE,".500,000$ - ��� ���� ����� ���");
tmp = strtok(cmdtext, idx);tmp2 = strtok(cmdtext, idx);
if(!strcmp(tmp,"Normal",true))return DOF2_SetInt(file,"Color1",-1),DOF2_SetInt(file,"Color2",-1),SendClientMessage(playerid,COLOR_WHITE,".���� ����� ���� , ���� ����");
if(!strlen(tmp)||!(strval(tmp) >= 0 && strval(tmp) <= 255)||!IsNumeric(tmp)||!IsNumeric(tmp2)) return SendClientMessage(playerid,COLOR_WHITE,"/SetCarColor [0-255 / Normal] [0-225] - �����");
if(!strlen(tmp2)) tmp2 = tmp;
format(String,256,".[%d,%d] ����� �� ��� ���� �",strval(tmp),strval(tmp2)),SendClientMessage(playerid,COLOR_WHITE,String),ChangeVehicleColor(GetPlayerVehicleID(playerid),strval(tmp),strval(tmp2)),DOF2_SetString(file,"Color1",tmp),DOF2_SetString(file,"Color2",tmp2),GivePlayerMoney(playerid,-500000);
return 1;
}
if(strcmp(cmd, "/TmpCarcolor", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
if(DOF2_GetInt(file,"Buyable") != 2)return SendClientMessage(playerid,COLOR_WHITE,".����� ��� ���� ������ �� ���� �����");
if(GetPlayerMoney(playerid) < 1000) return SendClientMessage(playerid,COLOR_WHITE,".$1,000 - ��� ���� ����� ���");
tmp = strtok(cmdtext, idx);tmp2 = strtok(cmdtext, idx);
if(!strcmp(tmp,"Normal",true))return DOF2_SetInt(file,"Color1",-1),DOF2_SetInt(file,"Color2",-1),SendClientMessage(playerid,COLOR_WHITE,".���� ����� ���� , ���� ����");
if(!strlen(tmp)||!(strval(tmp) >= 0 && strval(tmp) <= 255)||!IsNumeric(tmp)||!IsNumeric(tmp2)) return SendClientMessage(playerid,COLOR_WHITE,"/TmpCarColor [0-255 / Normal] [0-225] - �����");
if(!strlen(tmp2)) tmp2 = tmp;
ChangeVehicleColor(GetPlayerVehicleID(playerid),strval(tmp),strval(tmp2)),GivePlayerMoney(playerid,-1000);
return 1;
}
if(strcmp(cmd, "/CarName", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� �������");
if(DOF2_GetInt(file,"Buyable") != 2)return SendClientMessage(playerid,COLOR_WHITE,".����� �� ���� ������ �� ���� �����");
tmp = strtok(cmdtext,idx);
if(!strlen(tmp))return SendClientMessage(playerid,0xffffffff,"USAGE: /CarName [Name]");
DOF2_SetString(file,"carname1",tmp),DOF2_SetString(file,"carplate",tmp),format(String,256,".%s����� �� �� ���� �",DOF2_GetString(file,"carname1")),SendClientMessage(playerid,COLOR_WHITE,String),SetTimerEx("UpdateCar",1000,0,"d",GetPlayerVehicleID(playerid));
return 1;
}
if(strcmp(cmd, "/Gotocar", true) == 0)
{
if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,".��/� ��� ����/� ����");
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
format(file,sizeof(file),"Car/car%d.txt",DOF2_GetInt(SFile(playerid),"CarId"));
if(DOF2_GetInt(file,"Buyable") != 2)return SendClientMessage(playerid,COLOR_WHITE,"������� ���� ������ �� ���� �����");
for(new i=0;i<GetMaxPlayers();i++) if( IsPlayerConnected(i) && IsPlayerInVehicle(i,DOF2_GetInt(SFile(playerid),"CarId")) && i != playerid )
{
new Float:OutCarPos[3];
GetPlayerPos(i,OutCarPos[0],OutCarPos[1],OutCarPos[2]),SetPlayerPos(i,OutCarPos[0],OutCarPos[1],OutCarPos[2]),RemovePlayerFromVehicle(i),PutPlayerInVehicle(playerid,DOF2_GetInt(SFile(playerid),"CarId"),0);}
PutPlayerInVehicle(playerid,DOF2_GetInt(SFile(playerid),"CarId"),0);
return 1;
}

if(strcmp(cmd, "/fix", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� ��� �������");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)return SendClientMessage(playerid,red,".���� ���� ����� ����� �� ������ ��");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� ������� ");
if(DOF2_GetInt(file,"Buyable") != 2)return SendClientMessage(playerid,COLOR_WHITE,"����� ���� ����� �� ��� ���� �����");
RepairVehicle(GetPlayerVehicleID(playerid));
SetVehicleHealth(GetPlayerVehicleID(playerid),1000);
return 1;
}
if(strcmp(cmd, "/flip", true) == 0){
if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)return SendClientMessage(playerid,red,".���� ���� ����� ����� �� ������ ��");
new Float:X,Float:Y,Float:Z,Float:Angle;
GetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z); GetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);
SetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z+0.2); SetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);
RepairVehicle(GetPlayerVehicleID(playerid)),SetVehicleHealth(GetPlayerVehicleID(playerid),1000);
return 1;
}
if(strcmp(cmd, "/PayTax", true) == 0){
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,"! ��� �� ����");
if(strcmp(DOF2_GetString(file,"CarOwner"),playername,true))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� ������� ");
if(DOF2_GetInt(file, "PayTaxTime") > 10)return SendClientMessage(playerid, COLOR_WHITE, ".'���� ���� �� �� ������� ����� �������� �� ���");
if(GetPlayerMoney(playerid) < DOF2_GetInt(file,"Price")/10) return format(String,sizeof(String),".[$%s] ���� ���� �� ��� ��� ����",GetNum(DOF2_GetInt(file,"Price")/10)),SendClientMessage(playerid,COLOR_WHITE,String);
DOF2_SetInt(file,"PayTaxTime",30),GivePlayerMoney(playerid,-DOF2_GetInt(file,"Price")/10),SendClientMessage(playerid,COLOR_LIGHTGREEN,"! ����� �� �� ����");
return 1;}
if(strcmp(cmd, "/Gang", true) == 0) return SendClientMessage(playerid,COLOR_KRED,"������ ���� �����");

if(!strcmp(cmdtext,"/Clans",true))
{
new DClans[5000], ABCD[5000], ClanName[0xFF],cnum = 0,Clans = 0;
for(new w; w<MAX_CLANS; w++)
{
cnum++;
format(String,sizeof(String),"%d",cnum);
ClanName = DOF2_GetString("/Clans/ClanList.ini",String);
if(DOF2_FileExists(ClanFile(ClanName)))
{
Clans++;
if(Clans > 0)
{
format(String,sizeof(String),"{%s}%s{FFFFFF} [Created: %s // Members: %d // Bank: $%s // Test: %s // Hq: %s ]\n", DRGB2HEX(DOF2_GetInt(ClanFile(ClanName), "R"), DOF2_GetInt(ClanFile(ClanName), "G"), DOF2_GetInt(ClanFile(ClanName), "B"),100),ClanName, DOF2_GetString(ClanFile(ClanName),"CDate"),DOF2_GetInt(ClanFile(ClanName),"Players"),GetNum(DOF2_GetInt(ClanFile(ClanName),"Bank")),(DOF2_GetInt(ClanFile(ClanName),"Test")? ("Opened"):("Closed")),(DOF2_GetInt(ClanFile(ClanName),"Hq")? ("Yes"):("No")));
strcat(DClans,String);
}
else
{
ShowPlayerDialog(playerid, 158949+2, DIALOG_STYLE_MSGBOX, "����� ������� �� ����", "��� ������ ����", "�����", "");
}
}
}
format(ABCD, sizeof(ABCD), "%s",DClans);
ShowPlayerDialog(playerid, 158949+2, DIALOG_STYLE_MSGBOX, "����� ������� �� ����", ABCD, "�����", "");
return 1;
}
if (strcmp(cmd,"/CCP", true) == 0){
if(!InClan(playerid))return SendClientMessage(playerid,COLOR_WHITE, ".��� �� �����");
ShowPlayerDialog(playerid,515, DIALOG_STYLE_LIST, "CCP - Clan Control Panel", "��� ��� ����� �����\n����� �� ���� ��� ������ ����� ���\n���� ���� ��� ������ ����� ���", "���", "�����");
return 1;
}
if (strcmp(cmd,"/Clan", true) == 0)
{
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid,"/ClanHelp");
if (strcmp(tmp,"Create", true) == 0)
{
tmp = strtok(cmdtext, idx);
new date[20],year,month,day;
getdate(year, month, day);
format(date, sizeof(date), "%d/%d/%d",day,month,year);
if(!strlen(tmp)) return SendClientMessage(playerid, red, "/Clan Create [Name]");
if(GetPlayerMoney(playerid) < 50000) return SendClientMessage(playerid,COLOR_WHITE,"(��� ���� ����� ��� (800,000$");
if(strlen(tmp) > 10 || strlen(tmp) < 2)return SendClientMessage(playerid,COLOR_WHITE, ".�� ����� ���� ����� ��� 2 �10 ����� ");
if(!strcmp(tmp,"None.",true) || !strcmp(tmp,"None",true))return SendClientMessage(playerid,COLOR_WHITE, ".�� ���� ����� ���� ��� ��");
if(strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1)return SendClientMessage(playerid,COLOR_WHITE,".�� ����� ���� ����� �� �������");
if(strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1 || strfind(tmp,"�",true)!=-1)return SendClientMessage(playerid,COLOR_WHITE,".�� ����� ���� ����� �� �������");
if(InClan(playerid))return SendClientMessage(playerid,COLOR_WHITE, ".��� ��� �����");
format(file,256,"Clans/%s.ini",tmp);
if(DOF2_FileExists(file))return SendClientMessage(playerid, red,".��� ���� ���� ��� ��");
GivePlayerMoney(playerid,-800000);
DOF2_CreateFile(file);
DOF2_SetString(file,"ClanName",tmp);
DOF2_SetString(file,"CDate",date);
DOF2_SetString(file,"Founder",GetName(playerid));
DOF2_SetInt(file,"Players",1);
DOF2_SetInt(file,"ClanBank",0);
DOF2_SetInt(file,"Chat",1);
DOF2_SetString(file,"Msg","None");
DOF2_SetInt(file,"hq",0);
DOF2_SetInt(file,"Test",1);
DOF2_SetInt(file,"R",random(256));
DOF2_SetInt(file,"G",random(256));
DOF2_SetInt(file,"B",random(256));
DOF2_SetString(SFile(playerid), "Clan",tmp);
DOF2_SetInt(SFile(playerid), "ClanLevel",6);
SendClientMessage(playerid, -1,"--------------------------");
SendFormatMessage(playerid, -1,".''%s'' ��� ���! ���� ���� ��� ���",tmp);
SendClientMessage(playerid, -1,".������ �������� ���� 6 - ����� �����");
SendClientMessage(playerid, -1,"/ClanHelp - ������� ����� ������� ����/�");
SendClientMessage(playerid, -1,"--------------------------");
DOF2_SetInt(ServerStats(),"Clans",Clanss+1);
if(!DOF2_FileExists("Clans/ClanList.ini")) DOF2_CreateFile("Clans/ClanList.ini");
for(new i=1; i<MAX_CLANS; i++)
{
format(String, 0x7D, "%d", i);
if(!DOF2_IsSet("Clans/ClanList.ini", String))return DOF2_SetString("Clans/ClanList.ini", String, tmp);
}
return 1;
}
if (strcmp(tmp,"Invite", true) == 0)
{
tmp = strtok(cmdtext, idx);
id = strval(tmp);
if(!InClan(playerid))return SendClientMessage(playerid,COLOR_WHITE, ".��� �� �����");
if(DOF2_GetInt(SFile(playerid),"ClanLevel") < 3)return SendClientMessage(playerid, red, "����� ���� ����� ��� ���� 3 ����");
if(!strlen(tmp)) return SendClientMessage(playerid, red, "/Clan Invite [id]");
if(!IsPlayerConnected(id))return SendClientMessage(playerid, red, "����� �� �����");
if(InClan(id))return SendClientMessage(playerid,COLOR_WHITE, ".����� ��� �����");
if(id == playerid)return SendClientMessage(playerid,COLOR_WHITE, ".���� ���� ������ �� ���� ����� ");
ClanInvite[id] = 1;
ClanInviteName[id] = DOF2_GetString(SFile(playerid),"Clan");
format(String,sizeof(String),"%s - ����� ���� ������ ����� ��� \"%s\"",playerid,DOF2_GetString(SFile(playerid),"Clan"),GetName(playerid));
SendClientMessage(id,COLOR_ORANGE,String);
SendClientMessage(id,COLOR_WHITE,"/Clan Join - ���� ������ ����� ����/�");
format(String,sizeof(String),".\"%s\" - ������ ����� %s (id:%d) ����� �� ",DOF2_GetString(SFile(playerid),"Clan"),GetName(id),id);
SendClientMessage(playerid,COLOR_WHITE,String);
return 1;}

if (strcmp(tmp,"Join", true) == 0)
{
if(ClanInvite[playerid] == 0)return SendClientMessage(playerid,red,"�� ������ ���� ����");
if(InClan(playerid))return SendClientMessage(playerid,COLOR_WHITE, ".��� ��� �����");
DOF2_SetString(SFile(playerid), "Clan",ClanInviteName[playerid]);
DOF2_SetInt(SFile(playerid), "ClanLevel",1);
ClanInvite[playerid] = 0;
format(file,256,"Clans/%s.ini",ClanInviteName[playerid]);
DOF2_SetInt(file,"Players",DOF2_GetInt(file,"Players")+1);
format(String,sizeof(String),"!������ %s ������ �����",DOF2_GetString(SFile(playerid),"Clan"));
SendClientMessage(playerid,COLOR_SATLA,String);
format(String,sizeof(String),".��� ��� ����� ��� - \"%s\"",GetName(playerid));
SendClanMessage(playerid,COLOR_ORANGE,String);
return 1;}

if (strcmp(tmp,"SetLevel", true) == 0)
{
tmp = strtok(cmdtext, idx);
id = strval(tmp);
if(!InClan(playerid))return SendClientMessage(playerid,COLOR_WHITE, ".��� �� �����");
if(DOF2_GetInt(SFile(playerid),"ClanLevel") < 4)return SendClientMessage(playerid, red, "����� ��� ���� ����� ���� 4 ����");
if(!strlen(tmp)) return SendClientMessage(playerid, red, "/Clan SetLevel [id] [level 1-5]");
if(!IsPlayerConnected(id))return SendClientMessage(playerid, red, "����� �� �����");
if(!InClan(id))return SendClientMessage(playerid,COLOR_WHITE, ".����� ��� �����");
if(strcmp(DOF2_GetString(SFile(playerid),"Clan"),DOF2_GetString(SFile(id),"Clan"),true))return SendClientMessage(playerid,COLOR_WHITE, ".����� ���� ��� ����� ���");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, red, "/Clan SetLevel [id] [level 1-5]");
new level = strval(cmd);
if(level < 1 || level > 5)return SendClientMessage(playerid,COLOR_WHITE, "/Clan SetLevel [id] [level 1-5]");
if((DOF2_GetInt(SFile(playerid),"ClanLevel") < 5) && level > 3)return SendClientMessage(playerid,COLOR_WHITE, "������ ���� ��� ���� ������� ������ ���� �� ���� ����");
DOF2_SetInt(SFile(id), "ClanLevel",level);
if(level == 1) levelname = "Member";
if(level == 2) levelname = "Honor";
if(level == 3) levelname = "Tester";
if(level == 4) levelname = "Sub-Leader";
if(level == 5) levelname = "Leader";
format(String,sizeof(String),"%s � %s ����� �� \"%s\"",levelname,GetName(id),GetName(playerid));
SendClanMessage(playerid,COLOR_ORANGE,String);
return 1;}

if (strcmp(tmp,"quit", true) == 0 || strcmp(tmp,"leave", true) == 0){
if(!InClan(playerid))return SendClientMessage(playerid,COLOR_WHITE, ".��� �� �����");
return format(String, sizeof(String), "? %s ��� ��� ���� ������� ����� �� �����",DOF2_GetString(SFile(playerid),"Clan")),ShowPlayerDialog(playerid, 7001, DIALOG_STYLE_MSGBOX, "����� �����",String, "��", "��");}

   if(!strcmp(tmp, "Info", true))
    {
	new Cstring[1512];
	new Cstr[1512];
    tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)){
	if(!InClan(playerid))return SendClientMessage(playerid, COLOR_WHITE, "Usage: /Clan Info [Name]");
 	format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
	format(Cstring,sizeof(Cstring),"{FFFFFF}\n%s :�����",DOF2_GetString(file,"Founder"));
	strcat(Cstr, Cstring);
	format(Cstring,sizeof(Cstring),"\n{FFFFFF}%s :����� ����� ",DOF2_GetString(file,"CDate"));
	strcat(Cstr, Cstring);
	format(Cstring,sizeof(Cstring),"\n%d :������ ����� ",DOF2_GetInt(file,"Players"));
	strcat(Cstr, Cstring);
	format(Cstring,sizeof(Cstring),"\n{9cdb10}$%s {FFFFFF} :��� ����� ",GetNum(DOF2_GetInt(file,"Bank")));
 	strcat(Cstr, Cstring);
	if(DOF2_GetInt(file,"Hq") == 1)
	{
	format(Cstring,sizeof(Cstring),"\n{FFFFFF}�����: {00FF00}��\n");
	strcat(Cstr, Cstring);
	}else{
	format(Cstring,sizeof(Cstring),"\n{FFFFFF}�����: {FF0000}���\n");
	strcat(Cstr, Cstring);
	}
	if(DOF2_GetInt(file,"Test") == 1)
	{
	format(Cstring,sizeof(Cstring),"{FFFFFF}�����: {29ae29}��\n");
	strcat(Cstr, Cstring);
	}else{
	format(Cstring,sizeof(Cstring),"{FFFFFF}�����: {FF0000}���\n");
	strcat(Cstr, Cstring);
	}
	format(Cstring,sizeof(Cstring),"\n{FFFFFF}:����� ����� \n{ff9a00} %s  ",DOF2_GetString(file,"Msg"));
	strcat(Cstr, Cstring);
	new cR;
	new cG;
	new cB;
	cR = DOF2_GetInt(file,"R");
	cG = DOF2_GetInt(file,"G");
	cB = DOF2_GetInt(file,"B");
	format(Cstring,sizeof(Cstring),"{%06x}%s {FFFFFF}:���� �� �����",rgba2hex(cR,cG,cB,255) >>> 8,DOF2_GetString(file,"ClanName"));
	ShowPlayerDialog(playerid, 4518, DIALOG_STYLE_MSGBOX, Cstring ,Cstr, "�����", "");
	}else{
    format(file,256,"Clans/%s.ini",tmp);
    if(!DOF2_FileExists(file))return SendClientMessage(playerid, COLOR_WHITE,".�� ���� ���� ��� ��");
	format(Cstring,sizeof(Cstring),"{FFFFFF}\n%s :�����",DOF2_GetString(file,"Founder"));
	strcat(Cstr, Cstring);
	format(Cstring,sizeof(Cstring),"\n{FFFFFF}%s :����� ����� ",DOF2_GetString(file,"CDate"));
	strcat(Cstr, Cstring);
	format(Cstring,sizeof(Cstring),"\n%d :������ ����� ",DOF2_GetInt(file,"Players"));
	strcat(Cstr, Cstring);
	format(Cstring,sizeof(Cstring),"\n{9cdb10}$%s {FFFFFF} :��� ����� ",GetNum(DOF2_GetInt(file,"Bank")));
 	strcat(Cstr, Cstring);
	if(DOF2_GetInt(file,"Hq") == 1)
	{
	format(Cstring,sizeof(Cstring),"\n{FFFFFF}�����: {00FF00}��\n");
	strcat(Cstr, Cstring);
	}else{
	format(Cstring,sizeof(Cstring),"\n{FFFFFF}�����: {FF0000}���\n");
	strcat(Cstr, Cstring);
	}
	if(DOF2_GetInt(file,"Test") == 1)
	{
	format(Cstring,sizeof(Cstring),"{FFFFFF}�����: {29ae29}��\n");
	strcat(Cstr, Cstring);
	}else{
	format(Cstring,sizeof(Cstring),"{FFFFFF}�����: {FF0000}���\n");
	strcat(Cstr, Cstring);
	}
	format(Cstring,sizeof(Cstring),"\n{FFFFFF}:����� ����� \n{ff9a00} %s  ",DOF2_GetString(file,"Msg"));
	strcat(Cstr, Cstring);
	new cR;
	new cG;
	new cB;
	cR = DOF2_GetInt(file,"R");
	cG = DOF2_GetInt(file,"G");
	cB = DOF2_GetInt(file,"B");
	format(Cstring,sizeof(Cstring),"{%06x}%s {FFFFFF}:���� �� �����",rgba2hex(cR,cG,cB,255) >>> 8,DOF2_GetString(file,"ClanName"));
	ShowPlayerDialog(playerid, 4518, DIALOG_STYLE_MSGBOX, Cstring ,Cstr, "�����", "");
	}
	return 1;//;)
}
if (strcmp(tmp,"Kick", true) == 0)
{
tmp = strtok(cmdtext, idx);
id = strval(tmp);
if(DOF2_GetInt(SFile(playerid),"ClanLevel") < 4)return SendClientMessage(playerid, red, "����� ���� ����� ��� ���� 4 ����");
if(!strlen(tmp)) return SendClientMessage(playerid, red, "/Clan Kick [id]");
if(!IsPlayerConnected(id))return SendClientMessage(playerid, red, "����� �� �����");
if(!InClan(playerid))return SendClientMessage(playerid,COLOR_WHITE, ".����� �� �����");
if(strcmp(DOF2_GetString(SFile(playerid),"Clan"),DOF2_GetString(SFile(id),"Clan"),true))return SendClientMessage(playerid,COLOR_WHITE, ".����� ���� ��� ����� ���");
format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
DOF2_SetInt(file,"Players",DOF2_GetInt(file,"Players")-1);
DOF2_SetString(SFile(id), "Clan","None");
DOF2_SetInt(SFile(id), "ClanLevel",0);
format(String,sizeof(String),"%s - ����� ���� ������ %s",DOF2_GetString(SFile(playerid),"Clan"),GetName(playerid));
SendClientMessage(id,COLOR_KRED,String);
format(String,sizeof(String),"������ %s ���� �� %s",GetName(id),GetName(playerid));
SendClanMessage(playerid,COLOR_ORANGE,String);
return 1;}

if (strcmp(tmp,"Mute", true) == 0)
{
if(DOF2_GetInt(SFile(playerid),"ClanLevel") < 4)return SendClientMessage(playerid, red, "����� ���� ����� ��� ���� 4 ����");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, white, "/Clan Mute [ID] :���� ������");
id = strval(cmd);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, Red, ".����� �� �����");
if(strcmp(DOF2_GetString(SFile(playerid),"Clan"),DOF2_GetString(SFile(id),"Clan"),true))return SendClientMessage(playerid,COLOR_WHITE, ".����� ���� ��� ����� ���");
if(ClanMute[id] == 1) return SendClientMessage(playerid, Red, ".����� ��� ��� �����");
if(id == playerid)return SendClientMessage(playerid, Red, ".���� ���� ������ �� ����");
ClanMute[id] = 1;
format(String,sizeof(String),"������ %s \"����� � ''%s''",GetName(playerid),GetName(id));
SendClanMessage(playerid,COLOR_SATLA,String);
return 1;}
if (strcmp(tmp,"UnMute", true) == 0)
{

if(DOF2_GetInt(SFile(playerid),"ClanLevel") < 4)return SendClientMessage(playerid, red, "����� ����� ���� ����� ��� ���� 4 ����");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, white, "/Clan UnMute [ID]:���� ������");
id = strval(cmd);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, Red, ".����� �� �����");
if(strcmp(DOF2_GetString(SFile(playerid),"Clan"),DOF2_GetString(SFile(id),"Clan"),true))return SendClientMessage(playerid,COLOR_WHITE, ".����� ���� ��� ����� ���");
if(ClanMute[id] == 0) return SendClientMessage(playerid, Red, ".����� ��� �� �����");
if(id == playerid)return SendClientMessage(playerid, Red, ".���� ���� ����� �� �����");
ClanMute[id] = 0;
format(String,sizeof(String),"�� ������ ������ �'�� %s ���� � ''%s''",GetName(id),GetName(playerid));
SendClanMessage(playerid,COLOR_SATLA,String);
return 1;}
//==============================================================================
if (strcmp(tmp,"Players", true) == 0)
{
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)){
if(!InClan(playerid))return SendClientMessage(playerid, COLOR_WHITE, "Usage: /Clan Players [Name]");
if(InClan(playerid))return SetPVarInt(playerid,"ASpam",0),format(cmd,sizeof(cmd),"/Clan Players %s",DOF2_GetString(SFile(playerid),"Clan")),OnPlayerCommandText(playerid,cmd);
}
format(file,256,"Clans/%s.ini",tmp);
if(!DOF2_FileExists(file))return SendClientMessage(playerid, COLOR_WHITE,".�� ���� ���� ��� ��");
new playerscount;
new String2[265],CString[300];
for(new i=0;i<GetMaxPlayers();i++) if ( IsPlayerConnected(i))
{
if(DOF2_FileExists(SFile(i)) && !strcmp(DOF2_GetString(SFile(i),"Clan"),tmp,true))
{
if(DOF2_GetInt(SFile(i),"ClanLevel") == 1) levelname = "Member";
if(DOF2_GetInt(SFile(i),"ClanLevel") == 2) levelname = "{FFFF00}Honor{FFFFFF}";
if(DOF2_GetInt(SFile(i),"ClanLevel") == 3) levelname = "{4DCE03}Tester{FFFFFF}";
if(DOF2_GetInt(SFile(i),"ClanLevel") == 4) levelname = "{1BA5FE}Sub-Leader{FFFFFF}";
if(DOF2_GetInt(SFile(i),"ClanLevel") == 5) levelname = "{FF2400}Leader{FFFFFF}";
if(DOF2_GetInt(SFile(i),"ClanLevel") == 6) levelname = "{FF2400}Founder{FFFFFF}";
format(CString, sizeof(CString),"%d. %s (id: %d | %s)\n", playerscount,GetName(i),i,levelname),playerscount ++;
format(String2,sizeof(String2),"%d ������ �������",playerscount);
}}
ShowPlayerDialog(playerid,888,DIALOG_STYLE_MSGBOX,String2,CString,"�����","");
if(playerscount == 0)return ShowPlayerDialog(playerid,888,DIALOG_STYLE_MSGBOX,String2,".��� ������ ������� ����� ��","�����","");
return 1;}
//==============================================================================

if (strcmp(tmp,"Chat", true) == 0)
{
if(!InClan(playerid))return SendClientMessage(playerid, COLOR_WHITE,".���� ���/� ���� ����");
if(DOF2_GetInt(SFile(playerid),"ClanLevel") < 4)return SendClientMessage(playerid, red, "����� �'�� ���� ���� 4 ����");
format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
if(DOF2_GetInt(file,"Chat") == 0)
{
DOF2_SetInt(file,"Chat",1);
format(String,sizeof(String),"��� �� �'�� ����� \"%s\"",GetName(playerid));
SendClanMessage(playerid,green,String);
}
else if(DOF2_GetInt(file,"Chat") == 1){
DOF2_SetInt(file,"Chat",0);
format(String,sizeof(String),"��� �� ��'�� �� ����� \"%s\"",GetName(playerid));
SendClanMessage(playerid,red,String);
}
return 1;}

if (strcmp(tmp,"Test", true) == 0)
{
if(!InClan(playerid))return SendClientMessage(playerid, COLOR_WHITE,".���� ���/� ���� ����");
if(DOF2_GetInt(SFile(playerid),"ClanLevel") < 4)return SendClientMessage(playerid, red, "����� �'�� ���� ���� 4 ����");
format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
if(DOF2_GetInt(file,"Test") == 0)
{
DOF2_SetInt(file,"Test",1);
format(String,sizeof(String),"��� �� ����� ������ \"%s\"",GetName(playerid));
SendClanMessage(playerid,green,String);
}
else if(DOF2_GetInt(file,"Test") == 1){
DOF2_SetInt(file,"Test",0);
format(String,sizeof(String),"��� �� ����� ������ \"%s\"",GetName(playerid));
SendClanMessage(playerid,red,String);
}
return 1;}

if (strcmp(tmp,"SetMsg", true) == 0)
{
if(!InClan(playerid))return SendClientMessage(playerid, COLOR_WHITE,".���� ���/� ���� ����");
if(DOF2_GetInt(SFile(playerid),"ClanLevel") < 4)return SendClientMessage(playerid, red, "����� ����� ����� ���� 4");
tmp = strrest(cmdtext, idx);
if(!strlen(tmp))return SendClientMessage(playerid, COLOR_WHITE, "/Clan SetMsg [Msg]");
format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
DOF2_SetString(file,"Msg",tmp);
format(String,sizeof(String),"���� �� ����� ����� %s",GetName(playerid));
SendClanMessage(playerid,COLOR_ORANGE,String);
return 1;}
if (strcmp(tmp,"Hq", true) == 0)
{
if(!IsPlayerXAdmin(playerid))return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid,"/ClanHelp");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!InClan(playerid))return SendClientMessage(playerid, COLOR_WHITE,".���� ���/� ���� ����");
format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
if(DOF2_GetInt(file,"Hq") == 0)
{
DOF2_SetInt(file,"Hq",1);
}
else if(DOF2_GetInt(file,"Hq") == 1){
DOF2_SetInt(file,"Hq",0);
}
return 1;
}

return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid,"/ClanHelp");
}
if(!strcmp(cmd, "/Hq", true))
{
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None.",true) || !strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None",true))return SendClientMessage(playerid, COLOR_WHITE,"! ��� �� �����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq1,true))return  SetPlayerPos(playerid,2597.3315,1823.4454,10.8203);
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq2,true))return SetPlayerPos(playerid,2819.6719,1311.3782,10.7572);
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq3,true))return SetPlayerPos(playerid,1489.3895,718.6843,10.8203);
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq4,true))return SetPlayerPos(playerid,2328.4292,2353.2246,10.8203);
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq5,true))return SetPlayerPos(playerid,2976.1619,-1359.2666,11.2469);
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq6,true))return SetPlayerPos(playerid,2976.1619,-1359.2666,11.2469);
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq7,true))return SetPlayerPos(playerid,2976.1619,-1359.2666,11.2469);
return SendClientMessage(playerid,COLOR_WHITE, ".����� �� ��� �����");
}
if(strcmp(cmd,"/Open", true) == 0 || strcmp(cmd,"/O", true) == 0){
tmp = strtok(cmdtext, idx);
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None.",true) || !strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None",true))return SendClientMessage(playerid, COLOR_WHITE,"! ��� �� �����");
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE,"Usage: /Open [1-2]");
//==============================================================================
if(strcmp(tmp,"1", true) == 0){
tmp = strtok(cmdtext,idx);
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None.",true) || !strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None",true))return SendClientMessage(playerid, COLOR_WHITE,"! ��� �� �����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq1,true)) return MoveObject(JaSOpenMain1,2517.30004883,1836.30004883,13.50000000,3.0),MoveObject(JaSOpenMain2,2517.30004883,1809.90002441,13.50000000,3.0),SetTimer("JaSHqCloseMain",8000,0),SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq2,true)) return MoveObject(Hqq,2798.0000000,1312.9000244,2.6999998,3.0),SetTimer("HqqHqCloseMain",8000,0),SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq3,true)) return MoveDynamicObject(HqAviran[0],1447.1999500,663.0000000,22.4000000,3.0),SetTimer("VoLHqCloseMain",8000,0),SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq4,true)) return MoveDynamicObject(HqCpT[0],2316.6001000,2402.8999000,2.4000000,3.0),SetTimer("CpTHqCloseMain",8000,0),SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq5,true)) return SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq6,true)) return SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq7,true)) return SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
return SendClientMessage(playerid,COLOR_KRED, ".����� ��� ��� �����");}
if(strcmp(tmp,"2", true) == 0){
tmp = strtok(cmdtext,idx);
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None.",true) || !strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None",true))return SendClientMessage(playerid, COLOR_WHITE,"! ��� �� �����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq1,true)) return MoveObject(JaSOpen2,2586.89990234,1691.59997559,2.20000005,3.0),SetTimer("JaSHqClose2", 8000, 0),SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq2,true)) return MoveObject(Hqq1,2842.5000000,1290.9000244,3.1999998,3.0),SetTimer("HqqHqClose2",8000,0),SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq3,true)) return MoveDynamicObject(HqAviran[1],1533.9000200,744.2999900,2.1000000,3.0),SetTimer("VoLHqClose2",8000,0),SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq4,true)) return MoveDynamicObject(HqCpT[1],2365.3999000,2259.1999500,5.5000000,3.0),SetTimer("CpTHqClose2",8000,0),SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq5,true)) return SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq6,true)) return SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq7,true)) return SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
return SendClientMessage(playerid,COLOR_KRED, ".����� ��� ��� �����");}
return 1;
}
if(!strcmp(cmd,"/LiftUp",true) || !strcmp(cmd,"/Lu",true)){
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None.",true) || !strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None",true))return SendClientMessage(playerid, COLOR_WHITE,"! ��� �� �����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq1,true)) return SendClientMessage(playerid, COLOR_KRED,".��� ����� ��� �����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq2,true)) return SendClientMessage(playerid, COLOR_KRED,".��� ����� ��� �����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq3,true)) return MoveDynamicObject(HqAviran[2],1515.8000500,773.2999900,45.1000000,3.0),SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq4,true)) return MoveDynamicObject(HqCpT[2],2377.6001000,2324.1001000,26.2000000,3.0),SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq5,true)) return SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq6,true)) return SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq7,true)) return SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
return SendClientMessage(playerid,COLOR_KRED, ".����� ��� ��� �����");}

if(!strcmp(cmd,"/Liftdown",true) || !strcmp(cmd,"/LD",true)){
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None.",true) || !strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None",true))return SendClientMessage(playerid, COLOR_WHITE,"! ��� �� �����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq1,true)) return SendClientMessage(playerid, COLOR_KRED,".��� ����� ��� �����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq2,true)) return SendClientMessage(playerid, COLOR_KRED,".��� ����� ��� �����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq3,true)) return MoveDynamicObject(HqAviran[2],1515.8000500,773.2999900,11.1000000,3.0),SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq4,true)) return MoveDynamicObject(HqCpT[2],2377.6001000,2324.1001000,7.2000000,3.0),SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq5,true)) return SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq6,true)) return SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
if(!strcmp(DOF2_GetString(SFile(playerid),"Clan"),Hq7,true)) return SendClientMessage(playerid, COLOR_ORANGE,".���� ����� �� ������ ��� ����");
return SendClientMessage(playerid,COLOR_KRED, ".����� ��� ��� �����");}

if(strcmp(cmdtext, "/ClanBank", true)==0)
{
if(!InClan(playerid))return SendClientMessage(playerid, COLOR_WHITE,".���� ���/� ���� ����");
SetPlayerPos(playerid, -35.6529,-89.1784,1003.5469);
SendClientMessage(playerid, 0x00FF00FF, "���� ��� ���� �����");
SetPlayerVirtualWorld(playerid,12);
SetPlayerInterior(playerid,18);
GameTextForPlayer(playerid, "~w~Clan Bank", 3000, 1);
return 1;
}
if(!strcmp(cmd, "/ClanHelp", true))
{
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, -1, "Usage: /ClanHelp [1-2]");
if(!strcmp(cmd, "1", true)){
SendClientMessage(playerid, 0x1E90FFFF, "--- Clan Help [1] ---");
SendClientMessage(playerid,COLOR_WHITE, "/Clan Create - ����� ����");
SendClientMessage(playerid,COLOR_WHITE, "/Clan Invite - ���� ����� �����");
SendClientMessage(playerid,COLOR_WHITE, "/Clan Join - ������ �����");
SendClientMessage(playerid,COLOR_WHITE, "/Clan SetLevel - ���� ����� ��� �����");
SendClientMessage(playerid,COLOR_WHITE, "/Clan Quit - ���� ������");
SendClientMessage(playerid,COLOR_WHITE, "/Clan Info - ���� �� �����");
SendClientMessage(playerid,COLOR_WHITE, "/Clan Msg - ����� �� ����� �����");
SendClientMessage(playerid,0x1E90FFFF,"-- /ClanHelp 2 - ����� ��� --");
return 1;
}
if(!strcmp(cmd, "2", true))
{
SendClientMessage(playerid, 0x1E90FFFF, "--- Clan Help [2] ---");
SendClientMessage(playerid,COLOR_WHITE, "/Clan Kick - ����� ����� ������");
SendClientMessage(playerid,COLOR_WHITE, "/Clan Mute - ������ ����� ��'�� �����");
SendClientMessage(playerid,COLOR_WHITE, "/Clan UnMute - ������ ����� ��'�� �����");
SendClientMessage(playerid,COLOR_WHITE, "/Clan Players - ���� ������� �������� �����");
SendClientMessage(playerid,COLOR_WHITE, "/Clan Chat - �����/����� �� �'�� �����");
SendClientMessage(playerid,COLOR_WHITE, "/ClanBank - ����� ���� �����");
SendClientMessage(playerid,COLOR_WHITE, "@ [Text] - ����� ��'�� �����");
SendClientMessage(playerid, 0x1E90FFFF, "------------------------------");
return 1;
}
return SendClientMessage(playerid, -1, "Usage: /ClanHelp [1-2]");
}
//==============================================================================
if(!strcmp(cmd,"/ClanCreatePlayer", true)){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
tmp = strtok(cmdtext, idx),tmp2 = strtok(cmdtext, idx);
if(!strlen(tmp) || !strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /ClanCreatePlayer [ID/NAME] [Clan Name]");
id = strval(tmp);
if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_KRED, "! ����� �� �����");
if(!DOF2_IsSet(SFile(playerid), "Clan")) return SendClientMessage(playerid, COLOR_KRED, "! ����� �� �����");
format(file, sizeof (file), "Clans/%s.ini", DOF2_GetString(SFile(playerid), "Clan"));
new date[20],year,month,day;
getdate(year, month, day);
format(date, sizeof(date), "%d/%d/%d",day,month,year);
format(file,256,"Clans/%s.ini",tmp2);
if(strlen(tmp2) > 10 || strlen(tmp2) < 2)return SendClientMessage(playerid,COLOR_WHITE, ".�� ����� ���� ����� ��� 2 �10 �����");
if(!strcmp(tmp2,"None.",true) || !strcmp(tmp2,"None",true) || !strcmp(tmp2,"none.",true) || !strcmp(tmp2,"none",true))return SendClientMessage(playerid,COLOR_KRED, ".��� ����� ���� ��� ��");
if(DOF2_FileExists(file))return SendClientMessage(playerid, red,".��� �� ���� ��� ����, ��� ��� �� ���");
if(InClan(playerid))return SendClientMessage(playerid,COLOR_KRED, "! ����� ��� �����");
DOF2_CreateFile(file);
DOF2_SetString(file,"ClanName",tmp2);
DOF2_SetString(file,"CDate",date);
DOF2_SetString(file,"Founder",GetName(id));
DOF2_SetInt(file,"Players",1);
DOF2_SetInt(file,"ClanBank",0);
DOF2_SetString(file,"Msg","���");
DOF2_SetInt(file,"hq",0);
DOF2_SetString(SFile(id), "Clan",tmp2);
DOF2_SetInt(SFile(id), "ClanLevel",6);
format(String, sizeof(String),"[Clan] >> .%s ��� �� ���� ��� ��� ''%s'' ������",DOF2_GetString(SFile(id),"Clan"),GetName(playerid)),SendClientMessage(id,COLOR_LIGHTGREEN,String);
return 1;}
//==============================================================================
if(!strcmp(cmd,"/SetFounder", true)){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
tmp = strtok(cmdtext, idx),tmp2 = strtok(cmdtext, idx);
if(!strlen(tmp) || !strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /SetFounder [ID/NAME] [Clan Name]");
id = strval(tmp);
if(!IsNumeric(tmp)) id = ReturnPlayerID(tmp); else id = strval(tmp);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_KRED, "! ����� �� �����");
if(!DOF2_FileExists(file)) return SendClientMessage(playerid, COLOR_KRED, "! ����� �� ����");
format(file,256,"Clans/%s.ini",tmp2);
DOF2_SetString(file,"Founder",GetName(id));
return 1;}
//==============================================================================
if(!strcmp(cmd,"/xHqs",true)) return ShowPlayerDialog(playerid, 7519, DIALOG_STYLE_LIST, "������ ����", "1. JaS\n2. sSs\n3. kT\n4. sD\n5. None\n6. None\n7. None", "�����", "�����");
//==============================================================================
if(!strcmp(cmd,"/SetClanBank", true)){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
tmp = strtok(cmdtext, idx),tmp2 = strtok(cmdtext, idx);
if(!strlen(tmp) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /SetClanBank [Clan Name] [Money]");
format(file,256,"Clans/%s.ini",tmp);
if(!DOF2_FileExists(file)) return SendClientMessage(playerid, COLOR_KRED, "! ����� �� ����");
DOF2_SetInt(file, "Bank", strval(tmp2)),format(String, sizeof (String), ".%s �� ����� ��� � %s ���� �����",GetNum(strval(tmp2)),tmp),SendClientMessage(playerid, COLOR_ORANGE, String);
return 1;}
//==============================================================================
if(!strcmp(cmd,"/SetClanColor", true)){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
new r[256],g[256],b[256];
tmp = strtok(cmdtext, idx),r = strtok(cmdtext, idx),g = strtok(cmdtext, idx),b = strtok(cmdtext, idx);
if(!strlen(tmp) || !strlen(r) || !strlen(g) || !strlen(b))return SendClientMessage(playerid,COLOR_WHITE, "Usage: /Clan Color [Clan Name] [0-250] [0-250] [0-250]");
format(file,256,"Clans/%s.ini",tmp);
if(strval(r) == 240 && strval(g) == 240 && strval(b) == 240 && strval(r) == 250 && strval(g) == 250 && strval(b) == 250 && strval(r) == 250 && strval(g) == 250 && strval(b) == 250)return SendClientMessage(playerid,COLOR_KRED, "! ��� �� �� ����");
DOF2_SetInt(file,"R",strval(r));
DOF2_SetInt(file,"G",strval(g));
DOF2_SetInt(file,"B",strval(b));
return 1;}
//==============================================================================
if(!strcmp(cmd,"/DelClan", true)){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /DelClan [Clan Name]");
format(file, sizeof (file), "Clans/%s.ini", tmp);
if(!DOF2_FileExists(file)) return SendClientMessage(playerid, COLOR_KRED, "! ����� �� ����");
format(String, sizeof (String), "! ������ ''%s'' ���� �� �����",tmp),SendClientMessage(playerid,COLOR_LIGHTGREEN, String),DOF2_RemoveFile(file);
for(new i = 1; i < MAX_PLAYERS; i++) if(DOF2_GetInt(SFile(playerid),"Clan") == 1 && !strcmp(tmp2,DOF2_GetString(SFile(playerid),"Clan"),true)) DOF2_SetString(SFile(playerid), "Clan","None"),DOF2_SetInt(SFile(playerid), "ClanLevel",0);
return 1;}
//==============================================================================
if(!strcmp(cmd,"/DelUser", true)){
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /DelUser [Clan Name]");
format(file, sizeof (file), "Users/%s.txt", tmp);
if(!DOF2_FileExists(file)) return SendClientMessage(playerid, COLOR_KRED, "! ��� ����� ���");
format(String, sizeof (String), "! ������ ''%s'' ���� �� �����",tmp),SendClientMessage(playerid,COLOR_LIGHTGREEN, String),DOF2_RemoveFile(file);
return 1;}
//==============================================================================
if(!strcmp("/SaveSkin", cmd, true)) {
if(DOF2_GetInt(SFile(playerid),"HaveSkin") == 1)return SendClientMessage(playerid,red,"/DelSkin �� �� ��� ���� ���� ��� ����� ���� ���");
DOF2_SetInt(SFile(playerid), "Skin", GetPlayerSkin(playerid)),DOF2_SetInt(SFile(playerid),"HaveSkin", 1);
SendClientMessage(playerid,COLOR_SATLA,"!����� ������ ��� ���� ������"),SendClientMessage(playerid,orange,"/DelSkin - ���� ����� ���� ����");
return 1;}
if(!strcmp("/DelSkin", cmd, true)) {
if(DOF2_GetInt(SFile(playerid),"HaveSkin") == 0)return SendClientMessage(playerid,red,"/SaveSkin ��� �� ���� ���� ��� ����� ���� ���");
DOF2_SetInt(SFile(playerid), "Skin", 0),DOF2_SetInt(SFile(playerid),"HaveSkin", 0),SendClientMessage(playerid,COLOR_SATLA,"���� �� ����� ������");
return 1;}
if(!strcmp("/Sp", cmd, true)) {
if(GetPlayerInterior(playerid) != 0 || PlayerToPoint(18,playerid,2312.6421,-8.2676,26.7422) || IsPlayerInArea(playerid,1876.9946,642.8045, 1977.1577,762.8664) || IsPlayerInArea(playerid,1047.1776,1185.5588,-1562.4735,-1416.3406))return SendClientMessage(playerid,COLOR_WHITE,"�� ���� ����� ��� �����");
new Float:x, Float:y, Float:z;
if(DOF2_GetInt(SFile(playerid), "HavePos") == 1){
DOF2_SetInt(SFile(playerid),"IntS", 99);
DOF2_SetInt(SFile(playerid), "HavePos", 0);
DOF2_SetFloat(SFile(playerid), "FloatX", 0.0);
DOF2_SetFloat(SFile(playerid), "FloatY", 0.0);
DOF2_SetFloat(SFile(playerid), "FloatZ", 0.0);
}
GetPlayerPos(playerid, x, y, z);
DOF2_SetFloat(SFile(playerid), "FloatX", x);
DOF2_SetFloat(SFile(playerid), "FloatY", y);
DOF2_SetFloat(SFile(playerid), "FloatZ", z);
DOF2_SetInt(SFile(playerid),"IntS",GetPlayerInterior(playerid));
DOF2_SetInt(SFile(playerid), "HavePos", 1);
SendClientMessage(playerid,COLOR_SATLA,"! ������ ���� ������ ������");
return 1;
}

if(!strcmp("/Lp", cmd, true)) {
if(DOF2_GetInt(SFile(playerid), "HavePos") == 0)return SendClientMessage(playerid,red,"/Sp ��� �� ���� ����, ��� ����� ���� ���");
new Float:x, Float:y, Float:z;
x = DOF2_GetFloat(SFile(playerid),"FloatX");
y = DOF2_GetFloat(SFile(playerid),"FloatY");
z = DOF2_GetFloat(SFile(playerid),"FloatZ");
SetPlayerPos(playerid,x,y,z);
SetPlayerInterior(playerid, DOF2_GetInt(SFile(playerid),"IntS"));
SendClientMessage(playerid,COLOR_SATLA,"! ������ ������");

format(String,sizeof(String),"[Tele Pos] %s (ID:%d)",GetName(playerid),playerid);
SendMessageLpAdmin(yellow,String);

return 1;
}
//==============================================================================
if(!strcmp(cmd, "/Pos", true))
{
tmp=strtok(cmdtext,idx);
if(!strlen(tmp)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage: /Pos [Save | Tele | Del]");
if(!strcmp(tmp,"Save",true))
{
if(GetPlayerInterior(playerid) != 0 || PlayerToPoint(18,playerid,2312.6421,-8.2676,26.7422) || IsPlayerInArea(playerid,1876.9946,642.8045, 1977.1577,762.8664) || IsPlayerInArea(playerid,1047.1776,1185.5588,-1562.4735,-1416.3406))return SendClientMessage(playerid,COLOR_WHITE,"�� ���� ����� ��� �����");
new Float:x, Float:y, Float:z;
if(DOF2_GetInt(SFile(playerid), "HavePos") == 1){
DOF2_SetInt(SFile(playerid),"IntS", 99);
DOF2_SetInt(SFile(playerid), "HavePos", 0);
DOF2_SetFloat(SFile(playerid), "FloatX", 0.0);
DOF2_SetFloat(SFile(playerid), "FloatY", 0.0);
DOF2_SetFloat(SFile(playerid), "FloatZ", 0.0);
}
GetPlayerPos(playerid, x, y, z);
DOF2_SetFloat(SFile(playerid), "FloatX", x);
DOF2_SetFloat(SFile(playerid), "FloatY", y);
DOF2_SetFloat(SFile(playerid), "FloatZ", z);
DOF2_SetInt(SFile(playerid),"IntS",GetPlayerInterior(playerid));
DOF2_SetInt(SFile(playerid), "HavePos", 1);
SendClientMessage(playerid,COLOR_SATLA,"! ������ ���� ������ ������");
return 1;
}
if(!strcmp(tmp,"Tele",true))
{
if(DOF2_GetInt(SFile(playerid), "HavePos") == 0)return SendClientMessage(playerid,red,"/Sp ��� �� ���� ����, ��� ����� ���� ���");
new Float:x, Float:y, Float:z;
x = DOF2_GetFloat(SFile(playerid),"FloatX");
y = DOF2_GetFloat(SFile(playerid),"FloatY");
z = DOF2_GetFloat(SFile(playerid),"FloatZ");
SetPlayerPos(playerid,x,y,z);
SetPlayerInterior(playerid, DOF2_GetInt(SFile(playerid),"IntS"));
SendClientMessage(playerid,COLOR_SATLA,"! ������ ������");

format(String,sizeof(String),"[Tele Pos] %s (ID:%d)",GetName(playerid),playerid);
SendMessageLpAdmin(yellow,String);

return 1;
}
if(!strcmp(tmp,"Del",true))
{
if(DOF2_GetInt(SFile(playerid), "HavePos") == 0)return SendClientMessage(playerid,red,"��� �� ����� ����");
DOF2_SetInt(SFile(playerid), "HavePos", 0);
SendClientMessage(playerid,COLOR_SATLA,"! ������ ����� ���� ������");
return 1;
}
return SendClientMessage(playerid,0xFFFFFFFF,"Usage: /Pos [Save | Tele | Del]");}

//==============================================================================
if(!strcmp(cmd,"/Honor",true) || !strcmp(cmd,"/H",true)){
tmp = strtok(cmdtext, idx);
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
if(!strlen(tmp)) return 1;
if (strcmp(tmp,"Invite", true) == 0)
{
tmp=strtok(cmdtext,idx);
id = strval(tmp);
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
if(GetPlayerHonorLevel(playerid) < 3)return SendClientMessage(playerid,color_white,"3 ��� �� ���");
if(!strlen(tmp))return SendClientMessage(playerid,color_white,"USAGE: /Honor invite [playerid]");
if(!IsPlayerConnected(id))return SendClientMessage(playerid,color_white,".���� �� ���� �����");
if(IsPlayerHonor(id))return SendClientMessage(playerid,color_white,".���� �� ��� �����");
SendClientMessage(id,COLOR_WHITE,"{FEB91B}Honor ������� ����� �");
DOF2_SetInt(SFile(id),"Honor",1);
format(String,sizeof(String),"{FFFFFF}Honor {FEB91B}- � %s ����� ��",GetName(id));
SendClientMessage(playerid,COLOR_WHITE,String);
return 1;
}
if (strcmp(tmp,"Hq", true) == 0)
{
SetPlayerPos(playerid, 1903.1655,703.5532,10.8203),SendClientMessage(playerid,yellow,"/Honor HqHelp - ������ ������ �������� ����� ����");
return 1;
}
if (strcmp(tmp,"Kick", true) == 0)
{
tmp = strtok(cmdtext,idx);
id = strval(tmp);
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
if(GetPlayerHonorLevel(playerid) < 3)return SendClientMessage(playerid,color_white,"3 ��� �� ���");
if(!strlen(tmp))return SendClientMessage(playerid,color_white,"USAGE: /Honor kick [playerid]");
if(!IsPlayerConnected(id) || id == playerid)return SendClientMessage(playerid,color_white,".���� �� ���� �����, �� ���� ���� ������ �� ����");
if(!IsPlayerHonor(id))return SendClientMessage(playerid,color_white,".Honor - ���� �� ���� ���");
DOF2_SetInt(SFile(id),"Honor",0);
format(String,sizeof(String),"{FFFFFF}Honor {FEB91B}- ����� ���� ����� � %s",GetName(playerid));
SendClientMessage(id,COLOR_WHITE,String);
format(String,sizeof(String),"{FFFFFF}Honor {FEB91B}- ����� � %s ����� ��",GetName(id));
SendClientMessage(playerid,COLOR_WHITE,String);
return 1;
}
if (strcmp(tmp,"SetLevel", true) == 0)
{
tmp = strtok(cmdtext,idx);
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
if(GetPlayerHonorLevel(playerid) < 3)return SendClientMessage(playerid,color_white,"3 ��� �� ���");
if(!strlen(tmp))return SendClientMessage(playerid,color_white,"USAGE: /Honor setlevel [playerid] [Level]");
id = strval(tmp);
if(!IsPlayerConnected(id))return SendClientMessage(playerid,color_white,".���� �� ���� �����");
if(!IsPlayerHonor(id))return SendClientMessage(playerid,color_white,".Honor - ���� �� ���� ���");
tmp = strtok(cmdtext,idx);
if(!strlen(tmp))return SendClientMessage(playerid,color_white,"USAGE: /Honor SetLevel [playerid] [Level]");
new Level = strval(tmp);
if(Level > 3 || Level < 1)return SendClientMessage(playerid,color_white,"USAGE: /Honor SetLevel [playerid] [1 - 3]");
DOF2_SetInt(SFile(id),"Honor",Level);
format(String,sizeof(String),".%d � %s �� Honor - ���� �� ��� �",Level,GetName(id));
SendClientMessage(playerid,COLOR_WHITE,String);
format(String,sizeof(String),".%d ���, ���� ��� Honor - ��� �� ��� � %s",Level,GetName(playerid));
SendClientMessage(id,COLOR_WHITE,String);
return 1;
}
if(strcmp(tmp, "HqHelp", true) == 0)
{
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
SendClientMessage(playerid,color_white,"-- {FEB91B}/Honor HqHelp {FFFFFF}--");
SendClientMessage(playerid,color_white,"- /Honor Hq - ������� ������ ��������");
SendClientMessage(playerid,color_white,"- /Honor Open - ����� ���� �����");
SendClientMessage(playerid,color_white,"- /Honor Close - ����� ���� �����");
SendClientMessage(playerid,color_white,"- /Honor Open2 - ����� ��� �����");
SendClientMessage(playerid,color_white,"- /Honor Close2 - ����� ���������");
SendClientMessage(playerid,color_white,"{FEB91B}-------------------------------------");
return 1;
}
if(strcmp(tmp, "Open", true) == 0)
{
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
MoveObjectEx(Satla, 1877.5,704.09997558594,6.6999998092651, 2.5);
SendClientMessage(playerid, 0xFFFF00AA,"! ���� ���� ������");
return 1;
}
if(strcmp(tmp, "Close", true) == 0)
{
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
MoveObjectEx(Satla, 1877.40002441,703.59997559,12.60000038, 2.5);
SendClientMessage(playerid, 0xFFFF00AA,"! ���� ���� ������");
return 1;
}
if(strcmp(tmp, "Open2", true) == 0)
{
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
MoveObjectEx(SaTlaPc, 1966.80004883,701.59997559,5.59999990, 2.5);
SendClientMessage(playerid, 0xFFFF00AA,"! ���� ���� ������");
return 1;
}
if(strcmp(tmp, "Close2", true) == 0)
{
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
MoveObjectEx(SaTlaPc, 1966.50000000,702.29998779,11.50000000, 2.5);
SendClientMessage(playerid, 0xFFFF00AA,"! ���� ���� ������");
return 1;
}
if (strcmp(tmp,"fix", true) == 0)
{
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
if(!IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid,color_r,"��� �� ���� ����!");
return SendClientMessage(playerid,COLOR_WHITE,"! ���� ����"),SetVehicleHealth(GetPlayerVehicleID(playerid),1000);
}
if(strcmp(tmp,"Text", true) == 0){
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
new Message[256];
Message = strrest(cmdtext,idx);
format(String,MAX_CHATBUBBLE_LENGTH,"%s",Message);
SetPlayerChatBubble(playerid,String,COLOR_KRED,30.0,30000);
SendClientMessage(playerid, COLOR_KRED,":����� ���� ������ ������,����� ���");
SendFormatMessage(playerid, COLOR_ORANGE,"%s",Message);
SendClientMessage(playerid, COLOR_KRED,"���� ���� ����� �� �����,����� ���� 30 �����");
return 1;}
if (strcmp(tmp,"neon", true) == 0)
{
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
if(!IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid,color_r,"��� �� ���� ����!");
return ShowPlayerDialog(playerid, neondialog1, DIALOG_STYLE_LIST, "Neon Color", "Blue\n{ff0000}Red\n{00FF00}Green\nWhite\n{FF00CC}Pink\n{CCFF00}Yellow\nDelete Neon", "Select", "Cancel");
}
if (strcmp(tmp,"jetpack", true) == 0)
{
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
if(MiniOn == 1 || WarOn == 1 || MonsterOn == 1 || BoomOn == 1 || SwarOn == 1 || TanksOn == 1)return SendClientMessage(playerid,red,"���� ���� ���� �'� ��� ��� ������ �����");
return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USEJETPACK);
}

if (strcmp(tmp,"flip", true) == 0)
{
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
if(!IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid,COLOR_WHITE,"��� �� ���� ����!");
new Float:X,Float:Y,Float:Z,Float:Angle;
GetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z);
GetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);
SetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z+3);
SetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);
return 1;
}
if (strcmp(tmp,"Color", true) == 0)
{
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
if(GetPVarInt(playerid, "HonorColor") == 0) return SetPVarInt(playerid, "HonorColor", 1),SetPlayerColor(playerid,COLOR_YELLOW);
if(GetPVarInt(playerid, "HonorColor") == 1) return SetPVarInt(playerid, "HonorColor", 0),SetPlayerColor(playerid,COLOR_YELLOW),SetPlayerColor(playerid, PlayerColors[random(200)]);
return 1;
}
if (strcmp("Help",tmp,true) == 0)
{
if(!IsPlayerHonor(playerid))return SendClientMessage(playerid,red,"���� �����");
SendClientMessage(playerid,color_white,"-- {FEB91B}/Honor Help {FFFFFF}--");
SendClientMessage(playerid,color_white,"- /Honors - �������� Honor - ����� ����� �");
SendClientMessage(playerid,color_white,"- /Honor Hq - ����� ������");
SendClientMessage(playerid,color_white,"- /Honor Color - ��� ��������");
SendClientMessage(playerid,color_white,"- /Honor Flip - ����� ����");
SendClientMessage(playerid,color_white,"- /Honor Fix - ����� ����");
SendClientMessage(playerid,color_white,"{FEB91B}-------------------------------------");
return 1;
}
}

if (strcmp("/Honors",cmdtext, true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"----- {A64769}Honors {FFFFFF}Online: -----");
new Honor_Count;
for(new i=0;i<=GetMaxPlayers();i++)
{
if(IsPlayerConnected(i) && IsPlayerHonor(i))
{
Honor_Count++;
format(String,sizeof(String),"%d. %s [id: %d] - [Chat: %s]",Honor_Count,GetName(i),i,GetPVarInt(playerid, "HonorColor") == 1 ? ("ON"):("OFF"));
SendClientMessage(playerid,COLOR_ORANGE,String);
}
}
if(!Honor_Count)SendClientMessage(playerid,COLOR_KRED,".��� ������ ���� �������");
return 1;
}
//==============================================================================
if(!strcmp(cmd,"/Vip",true)){
tmp = strtok(cmdtext, idx);
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
if(!strlen(tmp)) return 1;
if (strcmp(tmp,"Invite", true) == 0)
{
tmp=strtok(cmdtext,idx);
id = strval(tmp);
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
if(GetPlayerHonorLevel(playerid) < 3 && !IsPlayerXAdmin(playerid))return SendClientMessage(playerid,color_white,"3 ��� �� ���");
if(!strlen(tmp))return SendClientMessage(playerid,color_white,"USAGE: /Vip Invite [playerid]");
if(!IsPlayerConnected(id))return SendClientMessage(playerid,color_white,".���� �� ���� �����");
if(IsPlayerVip(id))return SendClientMessage(playerid,color_white,".Vip ���� �� ���");
SendClientMessage(id,COLOR_WHITE,"{FEB91B}Vip ������� ����� �");
DOF2_SetInt(SFile(id),"Vip",1);
format(String,sizeof(String),"{FFFFFF}Vip {FEB91B}- � %s ����� ��",GetName(id));
SendClientMessage(playerid,COLOR_WHITE,String);
return 1;
}
if (strcmp(tmp,"Hq", true) == 0)
{
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
SetPlayerPos(playerid, 1129.6488,-1455.1267,15.7969),SendClientMessage(playerid,yellow,"/Vip HqHelp - ������ ������ �������, ����� �� ������ ����");
return 1;
}
if (strcmp(tmp,"Kick", true) == 0)
{
tmp = strtok(cmdtext,idx);
id = strval(tmp);
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
if(GetPlayerVipLevel(playerid) < 3 && IsPlayerXAdmin(playerid))return SendClientMessage(playerid,color_white,"3 ��� �� ���");
if(!strlen(tmp))return SendClientMessage(playerid,color_white,"USAGE: /Vip kick [playerid]");
if(!IsPlayerConnected(id) || id == playerid)return SendClientMessage(playerid,color_white,".���� �� ���� �����, �� ���� ���� ������ �� ����");
if(!IsPlayerVip(id))return SendClientMessage(playerid,color_white,".Vip - ���� �� ���� ���");
DOF2_SetInt(SFile(id),"Vip",0);
format(String,sizeof(String),"{FFFFFF}Vip {FEB91B}- ����� ���� ����� � %s",GetName(playerid));
SendClientMessage(id,COLOR_WHITE,String);
format(String,sizeof(String),"{FFFFFF}Vip {FEB91B}- ����� � %s ����� ��",GetName(id));
SendClientMessage(playerid,COLOR_WHITE,String);
return 1;
}
if (strcmp(tmp,"SetLevel", true) == 0)
{
tmp = strtok(cmdtext,idx);
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
if(GetPlayerVipLevel(playerid) < 3 && IsPlayerXAdmin(playerid))return SendClientMessage(playerid,color_white,"3 ��� �� ���");
if(!strlen(tmp))return SendClientMessage(playerid,color_white,"USAGE: /Vip setlevel [playerid] [Level]");
id = strval(tmp);
if(!IsPlayerConnected(id))return SendClientMessage(playerid,color_white,".���� �� ���� �����");
if(!IsPlayerVip(id))return SendClientMessage(playerid,color_white,".Vip - ���� �� ���� ���");
tmp = strtok(cmdtext,idx);
if(!strlen(tmp))return SendClientMessage(playerid,color_white,"USAGE: /Vip SetLevel [playerid] [Level]");
new Level = strval(tmp);
if(Level > 3 || Level < 1)return SendClientMessage(playerid,color_white,"USAGE: /Vip SetLevel [playerid] [1 - 3]");
DOF2_SetInt(SFile(id),"Vip",Level);
format(String,sizeof(String),".%d � %s �� Vip - ���� �� ��� �",Level,GetName(id));
SendClientMessage(playerid,COLOR_WHITE,String);
format(String,sizeof(String),".%d ���, ���� ��� Vip - ��� �� ��� � %s",Level,GetName(playerid));
SendClientMessage(id,COLOR_WHITE,String);
return 1;
}
if(strcmp(tmp, "HqHelp", true) == 0)
{
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
SendClientMessage(playerid,color_white,"-- {FEB91B}/Vip HqHelp {FFFFFF}--");
SendClientMessage(playerid,color_white,"- /Vip Hq - ������� ������ �������");
SendClientMessage(playerid,color_white,"- /Vip Open - ����� ���� �����");
SendClientMessage(playerid,color_white,"- /Vip Close - ����� ���� �����");
SendClientMessage(playerid,color_white,"- /Vip Open2 - ����� ��� �����");
SendClientMessage(playerid,color_white,"- /Vip Close2 - ����� ���������");
SendClientMessage(playerid,color_white,"{FEB91B}-------------------------------------");
return 1;
}
if(strcmp(tmp, "Open", true) == 0)
{
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
MoveObjectEx(VipHq, 1130.1999500,-1424.5999800,10.6000000, 2.5);
SendClientMessage(playerid, 0xFFFF00AA,"! ���� ���� ������");
return 1;
}
if(strcmp(tmp, "Close", true) == 0)
{
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
MoveObjectEx(VipHq, 1130.1999500,-1424.5999800,17.6000000, 2.5);
SendClientMessage(playerid, 0xFFFF00AA,"! ���� ���� ������");
return 1;
}
if (strcmp(tmp,"fix", true) == 0)
{
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
if(!IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid,color_r,"��� �� ���� ����!");
return SendClientMessage(playerid,COLOR_WHITE,"! ���� ����"),SetVehicleHealth(GetPlayerVehicleID(playerid),1000);
}
if(strcmp(tmp,"Text", true) == 0){
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
new Message[256];
Message = strrest(cmdtext,idx);
format(String,MAX_CHATBUBBLE_LENGTH,"%s",Message);
SetPlayerChatBubble(playerid,String,COLOR_KRED,30.0,30000);
SendClientMessage(playerid, COLOR_KRED,":����� ���� ������ ������,����� ���");
SendFormatMessage(playerid, COLOR_ORANGE,"%s",Message);
SendClientMessage(playerid, COLOR_KRED,"���� ���� ����� �� �����,����� ���� 30 �����");
return 1;}
if (strcmp(tmp,"neon", true) == 0)
{
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
if(!IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid,color_r,"��� �� ���� ����!");
return ShowPlayerDialog(playerid, neondialog1, DIALOG_STYLE_LIST, "Neon Color", "Blue\n{ff0000}Red\n{00FF00}Green\nWhite\n{FF00CC}Pink\n{CCFF00}Yellow\nDelete Neon", "Select", "Cancel");
}
if (strcmp(tmp,"jetpack", true) == 0)
{
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
if(MiniOn == 1 || WarOn == 1 || MonsterOn == 1 || BoomOn == 1 || SwarOn == 1 || TanksOn == 1)return SendClientMessage(playerid,red,"���� ���� ���� �'� ��� ��� ������ �����");
return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USEJETPACK);
}

if (strcmp(tmp,"flip", true) == 0)
{
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
if(!IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid,COLOR_WHITE,"��� �� ���� ����!");
new Float:X,Float:Y,Float:Z,Float:Angle;
GetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z);
GetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);
SetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z+3);
SetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);
return 1;
}
if (strcmp(tmp,"Color", true) == 0)
{
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
if(GetPVarInt(playerid, "VipColor") == 0) return SetPVarInt(playerid, "VipColor", 1),SetPlayerColor(playerid,0x008D00AA);
if(GetPVarInt(playerid, "VipColor") == 1) return SetPVarInt(playerid, "VipColor", 0),SetPlayerColor(playerid, PlayerColors[random(200)]);
return 1;
}
if (strcmp("Help",tmp,true) == 0)
{
if(!IsPlayerVip(playerid))return SendClientMessage(playerid,red,"Vip ����");
SendClientMessage(playerid,color_white,"-- {FEB91B}/Vip Help {FFFFFF}--");
SendClientMessage(playerid,color_white,"- /Vips - �������� Honor - ����� ����� �");
SendClientMessage(playerid,color_white,"- /Vip Hq - ����� ������");
SendClientMessage(playerid,color_white,"- /Vip Color - ��� ��������");
SendClientMessage(playerid,color_white,"- /Vip Flip - ����� ����");
SendClientMessage(playerid,color_white,"- /Vip Fix - ����� ����");
SendClientMessage(playerid,color_white,"{FEB91B}-------------------------------------");
return 1;
}
}

if (strcmp("/ViPs",cmdtext, true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"----- {A64769}Vip {FFFFFF}Online: -----");
new Vip_Count;
for(new i=0;i<=GetMaxPlayers();i++)
{
if(IsPlayerConnected(i) && IsPlayerVip(i))
{
Vip_Count++;
format(String,sizeof(String),"%d. %s [id: %d] - [Chat: %s]",Vip_Count,GetName(i),i,GetPVarInt(playerid, "VipColor") == 1 ? ("ON"):("OFF"));
SendClientMessage(playerid,COLOR_ORANGE,String);
}
}
if(!Vip_Count)SendClientMessage(playerid,COLOR_KRED,".��� ������ ������ �������");
return 1;
}
//==============================================================================
if(!strcmp(cmd,"/SetPass",true))
{
tmp = strtok(cmdtext,idx);
tmp2 = strtok(cmdtext,idx);
if(!strlen(tmp)||!strlen(tmp2)) return SendClientMessage(playerid,COLOR_WHITE,"/SetPass [OldPassword] [NewPassword] :�����");
if(strcmp(DOF2_GetString(SFile(playerid),"Password"),tmp,false)) return SendClientMessage(playerid,COLOR_KRED,"! ������ ������� ��� ���� ����� �� ����� �����");
DOF2_SetString(SFile(playerid),"Password",tmp2);
format(string,sizeof(string),"\"%s\" :������ ���� ������,���� ���",tmp2);
SendClientMessage(playerid,COLOR_AQUA,string);
SendClientMessage(playerid,COLOR_ORANGE,"! ��� ��,�� ����� �� ������ �� �� ��� ����� �������� ��������");
return 1;
}
if(!strcmp(cmd,"/ChangeNick",true) || !strcmp(cmd, "/ChangeNick", true))
{
if(GetPlayerLevel(playerid) < 2) return SendClientMessage(playerid,COLOR_WHITE,"! ������ ����� ���� 2 �����");
if(GetPlayerMoney(playerid) < 10000) return SendClientMessage(playerid,COLOR_WHITE,"! ���� ����� ��� ���� 10,000$");
tmp = strtok(cmdtext, idx);
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE, "Usage: /ChangeNick [NickName]");
if(!IsNickValid(tmp)) return SendClientMessage(playerid, COLOR_KRED, "! ��� ������ �� ����");
if(DOF2_FileExists(SFile1(tmp)))return SendClientMessage(playerid, red, ".��� ����,��� ��� �� ���");
if(DOF2_FileExists(SFile(playerid))){
if(DOF2_GetInt(SFile(playerid),"CarID") != 0){
format(file,sizeof(file),"Car/car%d.txt",DOF2_GetInt(SFile(playerid),"CarID"));
DOF2_SetString(file,"CarOwner",tmp);
}}
DOF2_CreateFile(SFile1(tmp));
DOF2_SetString(SFile1(tmp), "Nick", tmp);
DOF2_SetString(SFile1(tmp), "Password", DOF2_GetString(SFile(playerid),"Password"));
DOF2_SetString(SFile1(tmp), "Date", DOF2_GetString(SFile(playerid),"Date"));
DOF2_SetString(SFile1(tmp), "Email", DOF2_GetString(SFile(playerid),"Email"));
DOF2_SetInt(SFile1(tmp), "ReadRules", DOF2_GetInt(SFile(playerid),"ReadRules"));
DOF2_SetInt(SFile1(tmp), "Kills", DOF2_GetInt(SFile(playerid),"Kills"));
DOF2_SetInt(SFile1(tmp), "Level", DOF2_GetInt(SFile(playerid),"Level"));
DOF2_SetString(SFile1(tmp), "IP", GetIP(playerid));
DOF2_SetInt(SFile1(tmp), "AutoLogin", 1);
DOF2_SetInt(SFile1(tmp), "HaveSkin", DOF2_GetInt(SFile(playerid),"HaveSkin"));
DOF2_SetInt(SFile1(tmp), "Skin", DOF2_GetInt(SFile(playerid),"Skin"));
DOF2_SetInt(SFile1(tmp), "HavePos", DOF2_GetInt(SFile(playerid),"HavePos"));
DOF2_SetFloat(SFile1(tmp), "FloatX", DOF2_GetFloat(SFile(playerid), "FloatX"));
DOF2_SetFloat(SFile1(tmp), "FloatY", DOF2_GetFloat(SFile(playerid), "FloatY"));
DOF2_SetFloat(SFile1(tmp), "FloatZ", DOF2_GetFloat(SFile(playerid), "FloatZ"));
DOF2_SetInt(SFile1(tmp),"IntS",DOF2_GetInt(SFile(playerid),"IntS"));
DOF2_SetInt(SFile1(tmp), "Bank", DOF2_GetInt(SFile(playerid),"Bank"));
DOF2_SetInt(SFile1(tmp), "PlayerTag", DOF2_GetInt(SFile(playerid),"PlayerTag"));
DOF2_SetString(SFile1(tmp), "PlayerHaveTag", DOF2_GetString(SFile(playerid),"PlayerHaveTag"));
DOF2_SetInt(SFile1(tmp), "Honor", DOF2_GetInt(SFile(playerid),"Honor"));
DOF2_SetInt(SFile1(tmp), "Vip", DOF2_GetInt(SFile(playerid),"Vip"));
DOF2_SetInt(SFile1(tmp), "Supporters", DOF2_GetInt(SFile(playerid),"Supporters"));
DOF2_SetInt(SFile1(tmp), "NightTeam", DOF2_GetInt(SFile(playerid),"NightTeam"));
DOF2_SetInt(SFile1(tmp), "Spy", DOF2_GetInt(SFile(playerid),"Spy"));
DOF2_SetInt(SFile1(tmp),"OwnCar",DOF2_GetInt(SFile(playerid),"OwnCar"));
DOF2_SetInt(SFile1(tmp),"CarID",DOF2_GetInt(SFile(playerid),"CarID"));
format(file,sizeof(file),"Car/car%d.txt",DOF2_GetInt(SFile(playerid),"CarID"));
if(DOF2_GetInt(SFile1(tmp),"CarID")!= 0) DOF2_SetString(file,"CarOwner",tmp);
DOF2_SetInt(SFile1(tmp),"HaveSkin",DOF2_GetInt(SFile(playerid),"HaveSkin"));
DOF2_SetInt(SFile1(tmp),"Skin",DOF2_GetInt(SFile(playerid),"Skin"));
DOF2_SetInt(SFile1(tmp),"HavePos",DOF2_GetInt(SFile(playerid),"HavePos"));
DOF2_SetInt(SFile1(tmp),"IntS",DOF2_GetInt(SFile(playerid),"IntS"));
DOF2_SetFloat(SFile1(tmp),"FloatX",DOF2_GetFloat(SFile(playerid),"FloatX"));
DOF2_SetFloat(SFile1(tmp),"FloatY",DOF2_GetFloat(SFile(playerid),"FloatY"));
DOF2_SetFloat(SFile1(tmp),"FloatZ",DOF2_GetFloat(SFile(playerid),"FloatZ"));
DOF2_SetString(SFile1(tmp),"Clan", DOF2_GetString(SFile(playerid),"Clan"));
DOF2_SetInt(SFile1(tmp),"ClanLevel", DOF2_GetInt(SFile(playerid),"ClanLevel"));
if(strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None",true)){
format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
if(!strcmp(DOF2_GetString(file,"Founder"),GetName(playerid),true))DOF2_SetString(file,"Founder",tmp);}
DOF2_SetString(SFile1(tmp),"PName", DOF2_GetString(SFile(playerid),"PName"));
DOF2_SetString(SFile1(tmp),"PForum", DOF2_GetString(SFile(playerid),"PForum"));
DOF2_SetString(SFile1(tmp),"PCity", DOF2_GetString(SFile(playerid),"PCity"));
DOF2_SetString(SFile1(tmp),"PSkype", DOF2_GetString(SFile(playerid),"PSkype"));
DOF2_SetString(SFile1(tmp),"PMsn", DOF2_GetString(SFile(playerid),"PMsn"));
DOF2_SetInt(SFile1(tmp),"Golf", DOF2_GetInt(SFile(playerid),"Golf"));
DOF2_SetInt(SFile1(tmp),"Knife", DOF2_GetInt(SFile(playerid),"Knife"));
DOF2_SetInt(SFile1(tmp),"BaseBall", DOF2_GetInt(SFile(playerid),"BaseBall"));
DOF2_SetInt(SFile1(tmp),"ChineSaw", DOF2_GetInt(SFile(playerid),"ChineSaw"));
DOF2_SetInt(SFile1(tmp),"Pistol", DOF2_GetInt(SFile(playerid),"Pistol"));
DOF2_SetInt(SFile1(tmp),"SPistol", DOF2_GetInt(SFile(playerid),"SPistol"));
DOF2_SetInt(SFile1(tmp),"Eagle", DOF2_GetInt(SFile(playerid),"Eagle"));
DOF2_SetInt(SFile1(tmp),"GAmmo", DOF2_GetInt(SFile(playerid),"GAmmo"));
DOF2_SetInt(SFile1(tmp),"ShoutGun", DOF2_GetInt(SFile(playerid),"ShoutGun"));
DOF2_SetInt(SFile1(tmp),"Combat", DOF2_GetInt(SFile(playerid),"Combat"));
DOF2_SetInt(SFile1(tmp),"Sawn", DOF2_GetInt(SFile(playerid),"Sawn"));
DOF2_SetInt(SFile1(tmp),"GunAmmo", DOF2_GetInt(SFile(playerid),"GunAmmo"));
DOF2_SetInt(SFile1(tmp),"MP5", DOF2_GetInt(SFile(playerid),"MP5"));
DOF2_SetInt(SFile1(tmp),"Uzi", DOF2_GetInt(SFile(playerid),"Uzi"));
DOF2_SetInt(SFile1(tmp),"Tec9", DOF2_GetInt(SFile(playerid),"Tec9"));
DOF2_SetInt(SFile1(tmp),"AssAmmo",DOF2_GetInt(SFile(playerid),"AssAmmo"));
DOF2_SetInt(SFile1(tmp),"M4", DOF2_GetInt(SFile(playerid),"M4"));
DOF2_SetInt(SFile1(tmp),"AK47", DOF2_GetInt(SFile(playerid),"AK47"));
DOF2_SetInt(SFile1(tmp),"MaAmmo", DOF2_GetInt(SFile(playerid),"MaAmmo"));
DOF2_SetInt(SFile1(tmp),"Country", DOF2_GetInt(SFile(playerid),"Country"));
DOF2_SetInt(SFile1(tmp),"Sniper", DOF2_GetInt(SFile(playerid),"Sniper"));
DOF2_SetInt(SFile1(tmp),"RilfeAmmo", DOF2_GetInt(SFile(playerid),"RilfeAmmo"));
DOF2_SetInt(SFile1(tmp),"Armour",DOF2_GetInt(SFile(playerid),"Armour"));
DOF2_SetInt(SFile1(tmp),"PlayerTag", DOF2_GetInt(SFile(playerid),"PlayerTag"));
DOF2_SetInt(SFile1(tmp),"PlayerHaveTag",DOF2_GetInt(SFile(playerid),"PlayerHaveTag"));
format(String, sizeof(String), ".%s :������ ������ ��� ���",tmp);
SendClientMessage(playerid,COLOR_SATLA, String);
SendClientMessage(playerid,COLOR_WHITE,"");
SendClientMessage(playerid,COLOR_KRED,".��� ��� ��� �� ���� ������ ������ �� ������ ��� *");
SendClientMessage(playerid,COLOR_KRED,".��� ������ �����,�� ������ ������ �� ������ ���� ��� *");
printf("%s Has Been Changed His Name To:[%s]", GetName(playerid),tmp);
for(new i = 0; i < GetMaxPlayers(); i++)if(IsPlayerConnected(i) && i != playerid)format(String,sizeof(String), "%s - ���� �� ��� � %s", tmp,GetName(playerid)),SendClientMessage(i,COLOR_SATLA,String);
DOF2_RemoveFile(SFile(playerid));
SetPlayerName(playerid,tmp);
new szString2[500];
format(szString2, sizeof(szString2), "���� %s,\n\n!������ ��� ���� ����\n������ ���� ��� ���: %s\n�����,\n����  DeathMatch SA:MP", GetName(playerid),tmp);
SetTimerEx("KickPublic", 50, 0, "d", playerid);
return 1;
}
//===========================
if(!strcmp("/AutoMsg", cmd, true)) {
cmd = strtok(cmdtext,idx);
new Line[15];
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
if(!strlen(cmd))return SendClientMessage(playerid,-1,"/AutoMsg [1 - 3] [Text] - �����");
if(strval(cmd) > 3 || strval(cmd) < 1|| !IsNumber(cmd))return SendClientMessage(playerid,-1,"/AutoMsg [1 - 3] [Text] - �����");
format(Line,15,"b%d",strval(cmd));
tmp = strrest(cmdtext,idx);
if(!strlen(tmp))return SendClientMessage(playerid,-1,"/AutoMsg [1 - 3] [Text] - �����");
format(String,sizeof(String),"(%s)%s",GetName(playerid),tmp);
DOF2_SetString("BBoard.txt",Line,String);
return 1;}
if(!strcmp("/TimeUpdate", cmd, true)) {
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
TimeUpdate();
return 1;}
if(!strcmp(cmd,"/getrc",true))
{
tmp = strtok(cmdtext,idx);
new Float:Px[MAX_PLAYERS],Float:Py[MAX_PLAYERS],Float:Pz[MAX_PLAYERS],Float:Pa[MAX_PLAYERS];
if(DOF2_GetInt(SFile(playerid), "Level") <15 && !IsPlayerHonor(playerid))return LevelError(playerid,15);
if(!strlen(tmp))return SendClientMessage(playerid,yellow,"USAGE: /GetRC [Bandit | Raider | Baron | Goblin | Tiger | Cam]");

if(!strcmp(tmp,"goblin",true))
{
GetPlayerPos(playerid,Px[playerid],Py[playerid],Pz[playerid]);
GetPlayerFacingAngle(playerid,Pa[playerid]);
RC[playerid]=CreateVehicle(501,Px[playerid],Py[playerid],Pz[playerid],Pa[playerid],-1,-1,0);
PutPlayerInVehicle(playerid,RC[playerid],0);
return 1;
}
if(!strcmp(tmp,"raider",true))
{
GetPlayerPos(playerid,Px[playerid],Py[playerid],Pz[playerid]);
GetPlayerFacingAngle(playerid,Pa[playerid]);
RC[playerid]=CreateVehicle(465,Px[playerid],Py[playerid],Pz[playerid],Pa[playerid],-1,-1,0);
PutPlayerInVehicle(playerid,RC[playerid],0);
return 1;
}
if(!strcmp(tmp,"tiger",true))
{
GetPlayerPos(playerid,Px[playerid],Py[playerid],Pz[playerid]);
GetPlayerFacingAngle(playerid,Pa[playerid]);
RC[playerid]=CreateVehicle(564,Px[playerid],Py[playerid],Pz[playerid],Pa[playerid],-1,-1,0);
PutPlayerInVehicle(playerid,RC[playerid],0);
return 1;
}
if(!strcmp(tmp,"bandit",true))
{
GetPlayerPos(playerid,Px[playerid],Py[playerid],Pz[playerid]);
GetPlayerFacingAngle(playerid,Pa[playerid]);
RC[playerid]=CreateVehicle(441,Px[playerid],Py[playerid],Pz[playerid],Pa[playerid],-1,-1,0);
PutPlayerInVehicle(playerid,RC[playerid],0);
return 1;
}
if(!strcmp(tmp,"barron",true))
{
GetPlayerPos(playerid,Px[playerid],Py[playerid],Pz[playerid]);
GetPlayerFacingAngle(playerid,Pa[playerid]);
RC[playerid]=CreateVehicle(464,Px[playerid],Py[playerid],Pz[playerid],Pa[playerid],-1,-1,0);
PutPlayerInVehicle(playerid,RC[playerid],0);
return 1;
}
if(!strcmp(tmp,"cam",true))
{
GetPlayerPos(playerid,Px[playerid],Py[playerid],Pz[playerid]);
GetPlayerFacingAngle(playerid,Pa[playerid]);
RC[playerid]=CreateVehicle(594,Px[playerid],Py[playerid],Pz[playerid],Pa[playerid],-1,-1,0);
PutPlayerInVehicle(playerid,RC[playerid],0);
return 1;
}
return 0;
}

if(strcmp(cmd, "/dance", true) == 0) {
new dancestyle;
// Get the dance style param
tmp = strtok(cmdtext, idx);
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE,"/Dance [style 1-12] - �����");
dancestyle = strval(tmp);
if(dancestyle < 1 || dancestyle > 12)return SendClientMessage(playerid,COLOR_WHITE,"/Dance [Style 1-12 / Off] - �����");
if(!strcmp(tmp,"off",true))StopLoopingAnim(playerid);
if(dancestyle == 1)SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
else if(dancestyle == 2)SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
else if(dancestyle == 3)SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
else if(dancestyle == 4)SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
else if(dancestyle == 5)ApplyAnimation(playerid,"DANCING","DAN_LOOP_A",4.0,1,0,0,0,-1);
else if(dancestyle == 6)ApplyAnimation(playerid,"DANCING","DNCE_M_A",4.0,1,0,0,0,-1);
else if(dancestyle == 7)ApplyAnimation(playerid,"DANCING","DNCE_M_B",4.0,1,0,0,0,-1);
else if(dancestyle == 8)ApplyAnimation(playerid,"DANCING","DNCE_M_C",4.0,1,0,0,0,-1);
else if(dancestyle == 9)ApplyAnimation(playerid,"DANCING","DNCE_M_D",4.0,1,0,0,0,-1);
else if(dancestyle == 10)ApplyAnimation(playerid,"DANCING","DNCE_M_E",4.0,1,0,0,0,-1);
else if(dancestyle == 11)ApplyAnimation(playerid,"SPRAYCAN","spraycan_fire",4.0,1,0,0,0,-1);
else if(dancestyle == 12)ApplyAnimation(playerid,"SPRAYCAN","spraycan_full",4.0,1,0,0,0,-1);
Danced[playerid] = 1;
return 1;
}
if(!strcmp(cmd,"/FightStyle",true) || !strcmp(cmd, "/FS", true)){
if(DOF2_GetInt(SFile(playerid), "Level") <4 && !IsPlayerHonor(playerid))return LevelError(playerid,4);
ShowPlayerDialog(playerid, 32, DIALOG_STYLE_LIST, "����� �����", "Normal\nBoxing\nKongFu\nKneeHead\nGrabKick\nElbow", "�����", "�����");
return 1;}

if(strcmp(cmd, "/Bazooka", true) == 0) return SendClientMessage(playerid, COLOR_KRED, "����� �� ���� �����");

if(!strcmp("/Pay", cmd, true)) {
tmp = strtok(cmdtext, idx);
if(!strlen(tmp))return SendClientMessage(playerid, COLOR_WHITE, "/Pay [Playerid] [Amount] - �����");
id = strval(tmp);
cmd = strtok(cmdtext, idx);
if(!strlen(cmd))return SendClientMessage(playerid, COLOR_WHITE, "/Pay [Playerid] [Amount] - �����");
new money = strval(cmd);
if(money < 1 || money > 100000000)return SendClientMessage(playerid,COLOR_WHITE,"/Pay [Playerid] [Amount] - �����");
if(!IsPlayerConnected(id))return SendClientMessage(playerid,red,"����� �� �����");
if(id == playerid)return SendClientMessage(playerid,red,"��� ���� ���� �����");
if(GetPlayerMoney(playerid) < money)return SendClientMessage(playerid,red,"��� �� �� ���� �����");
GivePlayerMoney(playerid, -money);
GivePlayerMoney(id,money);
format(String,sizeof(String),".$%s \"%s\" ���� �",GetNum(money),GetName(id));
SendClientMessage(playerid,yellow,String);
format(String,sizeof(String),".$%s ��� �� \"%s\"",GetNum(money),GetName(playerid));
SendClientMessage(id,yellow,String);
format(String,sizeof(String),"\r\n%s Give %s | %s$",GetName(playerid),GetName(id),GetNum(money));
WriteToServerLog("Pay",String);
return 1;}
//==============================================================================
if (!strcmp("/ignore", cmd, true))
{
cmd = strtok(cmdtext,idx);
if (!strlen(cmd) || strval(cmd) < 0) return SendClientMessage(playerid,-1,"Usage: /Ignore [ID]");
new target = strval(cmd);
if (playerid == target) return SendClientMessage(playerid,COLOR_KRED,"��� �� ���� ����� �� ����");
if (!IsPlayerConnected(target)) return SendClientMessage(playerid,-1," ! ������ �� �����");
if (Ignore[playerid][target])return format(cmd,sizeof(cmd),"%s ��� ���� ���� ������ / ������ ��� �����",GetName(target)),SendClientMessage(playerid,yellow,cmd),Ignore[playerid][target] = false;
format(cmd,sizeof(cmd),"%s ���� �� ����� ������, ��� �� ���� ������ / ������ ��� �����",GetName(target));
SendClientMessage(playerid,yellow,cmd);
Ignore[playerid][target] = true;
return 1;
}
//==============================================================================
if(strcmp(cmd,"/Respond",true) == 0 || strcmp(cmd,"/RE",true) == 0)
{
if(-1 == GetPVarInt(playerid,"ReturnPM"))return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� ����� ����� �����");
tmp = strrest(cmdtext,idx);
if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE, "Usage: /Respond [Message]");
if(!IsPlayerConnected(GetPVarInt(playerid,"ReturnPM")))return SendClientMessage(playerid,COLOR_KRED, "! ����� �� �����");
OnPlayerPrivatemsg(playerid,GetPVarInt(playerid,"ReturnPM"),tmp);
return 1;
}

if(!strcmp(cmd, "/pm", true)){
new gMessage[256];
tmp = strtok(cmdtext,idx);
if(!strlen(tmp) || strlen(tmp) > 5) return SendClientMessage(playerid,white,"Usage: /PM [ID] [Message]");
id = strval(tmp);
gMessage = strrest(cmdtext,idx);
if(!strlen(gMessage)) return SendClientMessage(playerid,white,"Usage: /PM [ID] [Message]");
if(strlen(gMessage) > 85) return SendClientMessage(playerid,white,"Usage: /PM [ID] [Message]");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid,COLOR_KRED,"! ����� �� �����");
if(id == playerid) return SendClientMessage(playerid,COLOR_KRED,"! ���� ���� ����� ����� ����� �����");
PlayerPlaySound(id,1085,0.0,0.0,0.0);
OnPlayerPrivatemsg(playerid,id,gMessage);
return 1;}

if(!strcmp(cmd, "/Pub", true)){
tmp2 = strrest(cmdtext, idx);
if(!strlen(tmp2)) return SendClientMessage(playerid, red, "/Pub [Text]");
if(Tallking[playerid] == 0 & InTeamA[playerid] & InTeamB[playerid]) return SendClientMessage(playerid, white,"��� �� �����,��� ���� ���� ���� �����");
new Chat[256];
if(DOF2_GetInt(SFile(playerid), "PlayerHaveTag") == 0){
format(Chat, sizeof (Chat), "%s: {FFFFFF}%s (ID: %d)", GetName(playerid), tmp2, playerid);
SendChatMessageToAll(GetPlayerColor(playerid), Chat);
}else{
format(Chat, sizeof (Chat), "%s: {FFFFFF}%s (ID: %d | %s {FFFFFF})", GetName(playerid), tmp2, playerid, ColouredText(DOF2_GetString(SFile(playerid), "PlayerTag")));
SendChatMessageToAll(GetPlayerColor(playerid), Chat);}
return 1;}

if(strcmp(cmd, "/SetTag", true) == 0)
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
tmp = strtok(cmdtext, idx);
new idname[24],ids = strval(tmp);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "/SetTag [playerid] [(Color)Tag] - �����");
if(!IsPlayerConnected(ids)) return SendClientMessage(playerid, COLOR_WHITE, "����� ���� �����");
GetPlayerName(ids,idname,24);
tmp2 = strrest(cmdtext, idx);
if(!strlen(tmp2))return SendClientMessage(playerid,COLOR_WHITE,"/SetTag [playerid] [(Color)Tag]");
DOF2_SetString(SFile(ids), "PlayerTag", tmp2);
format(String, sizeof(String),"%s �� ���� %s ��� �",tmp2,GetName(ids));
SendClientMessage(playerid,COLOR_WHITE,String);
DOF2_SetInt(SFile(ids), "PlayerHaveTag", 1);
return 1;
}
if(strcmp(cmd, "/xTagColor", true) == 0)
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 13)return SendClientMessage(playerid,red,"13 - ��� �� ���");
ShowPlayerDialog(playerid,1552,DIALOG_STYLE_LIST,"����� ������","(WHITE)\n(RED)\n(GRREN)\n(YELLOW)\n(ORANGE)\n(GREY)\n(PURPLE)\n(PINK)\n(BROWN)\n(LIME)\nAQUA","�����","");
return 1;
}
if(!strcmp(cmd, "/DelTag", true))
{
if(!IsPlayerXAdmin(playerid))return SendClientMessage(playerid,COLOR_WHITE, "/Help - ����� �� ���� �����,����� ���");
if(IsXLevel(playerid) < 14)return SendClientMessage(playerid,red,"14 - ��� �� ���");
cmd = strtok(cmdtext, idx);
if(!strlen(cmd)) return SendClientMessage(playerid, COLOR_WHITE, "/DelTag [ID]");
id = strval(cmd);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, ".Player is not logged");
DOF2_SetInt(SFile(id), "PlayerHaveTag", 0);
DOF2_SetString(SFile(id), "PlayerTag","None");
return 1;
}
if(strcmp(cmd, "/Survival", true) == 0)
{
SetPlayerPos(playerid, 1433.5216, 2658.7385 ,11.3926);
ResetPlayerWeapons(playerid);
SetPlayerFacingAngle(playerid, 0);
SetPlayerVirtualWorld(playerid, 195);
SendClientMessage(playerid, 0xAA3333AA, "����� ����� ��������");
SetPlayerInterior(playerid,0);
return 1;
}
if(!strcmp(cmd, "/AFKList", true)){
new count;
for(new i, AfK = GetMaxPlayers(); i < AfK; i++){
if(InAfk[i] == 1){
count++;
format(str, 256, "%s [#%d]", GetName(i), i);
}}
if(count)return ShowPlayerDialog(playerid,888,DIALOG_STYLE_MSGBOX,"AFK LIST",str,"�����","");
if(!count)return SendClientMessage(playerid, COLOR_KRED, "!���� AFK ��� ������ ����");
return 1;
}
//Bank===================================
if(strcmp(cmdtext, "/Bank", true) == 0)
{
if(GetPlayerLevel(playerid) == 1) return SendClientMessage(playerid,COLOR_WHITE,"����� ������� ���� ���� ������ ���� ����� ����"),OnPlayerCommandText(playerid,"/PBank");
SetPlayerVirtualWorld(playerid, 0);
SetPlayerInterior(playerid,1);
SetPlayerPos(playerid, 2144.235351,1632.090332,993.576110);
ResetPlayerWeapons(playerid);
SendClientMessage(playerid, 0x00FF00FF, "!���� ��� ����");
GameTextForPlayer(playerid, "~w~Bank", 3000, 1);
return 1;
}
if(strcmp(cmdtext, "/pBank", true) == 0)
{
SetPlayerVirtualWorld(playerid,playerid+1);
SetPlayerInterior(playerid,1);
SetPlayerPos(playerid, 2144.235351,1632.090332,993.576110);
ResetPlayerWeapons(playerid);
SendClientMessage(playerid, 0x00FF00FF, "!���� ��� ���� �����");
GameTextForPlayer(playerid, "~w~Bank", 3000, 1);
return 1;
}
if(strcmp(cmdtext, "/Ammu", true) == 0)return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid,"/ammo");
if(strcmp(cmdtext, "/Ammo", true) == 0)return SetPlayerVirtualWorld(playerid,25),SetPlayerInterior(playerid,0),SetPlayerTime(playerid,21,0),SetPlayerPos(playerid,835.0563,-2048.2368,12.8672),SendClientMessage(playerid, COLOR_SATLA, "���� ����� ������");
//==============================================================================
if(strcmp(cmd, "/BuyArmour", true) == 0){
if(DOF2_GetInt(SFile(playerid),"Armour") != 0)return SendClientMessage(playerid,COLOR_WHITE,".�� �� ��� ��� �������");
if(GetPlayerMoney(playerid) < 750000) return SendClientMessage(playerid,COLOR_KRED,"! $��� �� 750,000");
SendClientMessage(playerid,COLOR_LIGHTGREEN, "[$750,000] �����! ���� ��� ������� �����"),DOF2_SetInt(SFile(playerid),"Armour",1),SetPlayerArmour(playerid,100.00),GivePlayerMoney(playerid,-750000);
return 1;}
//==============================================================================
if(strcmp(cmd, "/ArmourUpgrade", true) == 0){
if(DOF2_GetInt(SFile(playerid),"Armour") == 0)return SendClientMessage(playerid,COLOR_WHITE,".��� �� ��� ��� �������");
if(DOF2_GetInt(SFile(playerid),"Armour") == 2)return SendClientMessage(playerid,COLOR_WHITE,".�� �� ��� ��� �����");
if(GetPlayerMoney(playerid) < 10000000) return SendClientMessage(playerid,COLOR_KRED,"! $��� �� 10,000,000");
SendClientMessage(playerid,COLOR_LIGHTGREEN, "[$10,000,000] �����! ���� ��� ������� �����"),DOF2_SetInt(SFile(playerid),"Armour",2),SetPlayerArmour(playerid,100.00),GivePlayerMoney(playerid,-10000000);
return 1;}
//==============================================================================
new CmdError[256]; format(CmdError, sizeof(CmdError), "/Help - ����� �� ���� �����,����� ���");
return SendClientMessage(playerid, white, CmdError);
}

forward OnPlayerPrivatemsg(playerid, recieverid, text[]);
public OnPlayerPrivatemsg(playerid, recieverid, text[])
{
SetPVarInt(recieverid,"ReturnPM",playerid),SetPVarInt(playerid,"ReturnPM",recieverid);
new playerip[16];
GetPlayerName(playerid, playername, sizeof(playername));
GetPlayerIp(playerid, playerip, sizeof(playerip));
new recievername[MAX_PLAYER_NAME],recieverip[16];
GetPlayerName(recieverid,recievername, sizeof(recievername));
GetPlayerIp(playerid,recieverip, sizeof(recieverip));
if(BlockPm[playerid] == 1)return SendClientMessage(playerid,COLOR_KRED,".������� ������� ������ ����"),0;
if(BlockPm[recieverid] == 1)return SendClientMessage(playerid,COLOR_KRED,".������ ��� �� ������� ������� ���"),0;
if(Ignore[playerid][recieverid])return SendClientMessage(playerid,RED,"���� �� ����� ���"),0;
if(Ignore[recieverid][playerid])return SendClientMessage(playerid,RED,"����� ��� ����"),0;
format(String,sizeof(String),"[PM] << IN %s (%d):%s",playername,playerid,text),SendClientMessage(recieverid,COLOR_YELLOW,String);
format(String,sizeof(String),"[PM] << OUT %s (%d):%s",recievername,recieverid,text),SendClientMessage(playerid,0x00cbceFF,String);
format(String,sizeof(String),"%s (id:%d) - To - %s (id:%d): %s",playername,playerid,recievername,recieverid,text);
SendMessagePmsAdmin(yellow,String);
format(String,sizeof(String),"\r\n[IP: %s] %s (id:%d) - To - [IP:%s] %s (id:%d): %s",playerip,playername,playerid,recieverip,recievername,recieverid,text);
WriteToServerLog("Pms",String);
return 0;}

public OnPlayerExitVehicle(playerid, vehicleid)
{
DestroyObject(GetPVarInt(playerid, "neon"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon1"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon2"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon3"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon4"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon5"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon6"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon7"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon8"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon9"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon10"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon11"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon12"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon13"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon14"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon15"));
DestroyObject(GetPVarInt(playerid, "neon17"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon16"));
DeletePVar(playerid, "Status");
CarDisco[playerid] = 0;
Autojump[playerid] = 0;
if(InMonster[playerid] == 1 && MonsterStarted == 1)
{
MonsterPlayers --;
InMonster[playerid] = 0;
SetPlayerHealth(playerid,0.0);
DestroyVehicle(vehicleid);
SendClientMessage(playerid,COLOR_WHITE, ".����� ������� ���� ����� �����");
}
if(InTanks[playerid] == 1 && TanksStarted == 1)
{
TanksPlayers --;
InTanks[playerid] = 0;
SetPlayerHealth(playerid,0.0);
DestroyVehicle(vehicleid);
SendClientMessage(playerid,COLOR_WHITE, ".����� ������� ���� ����� �����");
}

if(InSwar[playerid] == 3)
{
SwarPlayers --;
InSwar[playerid] = 0;
DestroyVehicle(Swar[playerid]);
CallRemoteFunction("CheckPlayers","i",SwarPlayers);
SendClientMessage(playerid,COLOR_LIGHTBLUEGREEN,"! ����� �������, ������ ���� ����");
SetPlayerPos(playerid,Position[playerid][0],Position[playerid][1],Position[playerid][2]);
SetPlayerVirtualWorld(playerid,0);
return 1;
}
return 1;

}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
if(newstate != PLAYER_STATE_DRIVER)
{
if(GetPVarInt(playerid,"InStuntMission")) SetPVarInt(playerid,"InStuntMission",0),StuntMissionDo = 0,DisablePlayerRaceCheckpoint(playerid),SendClientMessage(playerid,COLOR_KRED,".����� ������ ������ ������ ����� ��������"),KillTimer(StuntCd(0,0)),DestroyVehicle(StuntCar),SetPlayerHealth(playerid,0),SetPlayerVirtualWorld(playerid,0),format(String, sizeof(String), "[Stunt Mission] << .���� ������ ������ %s", GetName(playerid)),SendClientMessageToAll(COLOR_ORANGE, String);
}
if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
{
if (newstate == 2 || newstate == 3)
{
format(str, sizeof(str), "~B~%s",VehNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
GameTextForPlayer(playerid, str, 5000, 1);
}
}
if(newstate == PLAYER_STATE_DRIVER)
{
new vehicleid = GetPlayerVehicleID(playerid);
CarDisco[playerid] = 0;
GetPlayerName(playerid, playername, sizeof(playername));
new file[256];
format(file,sizeof(file),"Car/car%d.txt", vehicleid);
if(vehicleid >= VCount) return 1;
new msg[256];
if(DOF2_GetInt(file,"CarOwned") == 1 && strcmp(playername,DOF2_GetString(file,"CarOwner"),false)) return format(msg,sizeof(msg),"%s ���� � %s ��� ��",DOF2_GetString(file,"CarOwner"),GetVehicleName(vehicleid)),SendClientMessage(playerid,COLOR_ORANGE,msg);

if(DOF2_GetInt(file,"CarOwned") == 2 && DOF2_GetInt(file,"SetPrice") > 0)
{
if(DOF2_GetInt(file,"Buyable") == 2){
if(strcmp(playername,DOF2_GetString(file,"CarOwner"),true) == 0) {
format(msg,sizeof(msg),".%s,������� ��� %s ���� ���� �",playername,DOF2_GetString(file,"carname1"));
SendClientMessage(playerid,COLOR_ORANGE,msg);
format(msg,sizeof(msg),"/StopSale -  ���� ���� ������ ����� %s$ ,������ ������ ���/�",GetNum(DOF2_GetInt(file,"SetPrice")));
SendClientMessage(playerid,COLOR_ORANGE,msg);
}else{
format(msg,sizeof(msg),".%s ���� ��� ����� ����� ������� �� %s - ��� ��",DOF2_GetString(file,"CarOwner"),DOF2_GetString(file,"carname1"));
SendClientMessage(playerid,COLOR_ORANGE,msg);
format(msg,sizeof(msg),"./BuyCar -  ��� �� ���� ������ ����� %s$ ,������ ���� ���/� ",GetNum(DOF2_GetInt(file,"SetPrice")));
SendClientMessage(playerid,COLOR_ORANGE,msg);
}
return 1;
}
if(strcmp(playername,DOF2_GetString(file,"CarOwner"),true) == 0)
{
format(msg,sizeof(msg),".%s - ���� ��� ����� ,%s ����",GetVehicleName(vehicleid),playername);
SendClientMessage(playerid,COLOR_ORANGE,msg);
format(msg,sizeof(msg),"./StopSale -  ���� ���� ������ ����� %s$ ,������ ������ ���/�",GetNum(DOF2_GetInt(file,"SetPrice")));
SendClientMessage(playerid,COLOR_ORANGE,msg);
}
else
{
format(msg,sizeof(msg),".%s �� ���� ������ %s ���",DOF2_GetString(file,"CarOwner"),GetVehicleName(vehicleid));
SendClientMessage(playerid,COLOR_ORANGE,msg);
format(msg,sizeof(msg),"./BuyCar{ff66ff}:������ ����/� ,$%s:��� �� ���� ������  ����� ��",GetNum(DOF2_GetInt(file,"SetPrice")));
SendClientMessage(playerid,COLOR_ORANGE,msg);
}
return 1;
}

if(DOF2_GetInt(file,"Buyable") == 2 && DOF2_GetInt(file,"CarOwned") == 1)
{
if(strcmp(playername,DOF2_GetString(file,"CarOwner"),true) == 0)
{
format(msg,sizeof(msg),".%s,������� ��� %s ���� ���� �",playername,DOF2_GetString(file,"carname1"));
SendClientMessage(playerid,COLOR_ORANGE,msg);
}
else
{
format(msg,sizeof(msg),".%s ����� �� ���� ������ %s ���",DOF2_GetString(file,"CarOwner"),DOF2_GetString(file,"carname1"));
SendClientMessage(playerid,COLOR_ORANGE,msg);
}
return 1;
}

if(DOF2_GetInt(file,"CarOwned") == 1)
{
if(strcmp(playername,DOF2_GetString(file,"CarOwner"),true) == 0)
{
format(msg,sizeof(msg),".%s - ���� ��� �����,%s ����",GetVehicleName(vehicleid),playername);
SendClientMessage(playerid,COLOR_ORANGE,msg);
}
else
{
format(msg,sizeof(msg),".%s ������� ��,%s - ��� ��",DOF2_GetString(file,"CarOwner"),GetVehicleName(vehicleid));
SendClientMessage(playerid,COLOR_ORANGE,msg);
}
}
else if(DOF2_GetInt(file,"Buyable") == 0)
{
format(msg,sizeof(msg),".�� ���� ��� ������ %s ���",GetVehicleName(vehicleid));
SendClientMessage(playerid,red,msg);
}
else if(DOF2_GetInt(file,"Buyable") == -1)
{
format(msg,sizeof(msg),".���� ��� ����� %s ��� ��",GetVehicleName(vehicleid));
SendClientMessage(playerid,COLOR_KRED,msg);
}
else if(DOF2_GetInt(file,"Buyable") == 3)
{
format(String,sizeof(String),".�� ���� ������ ���� %s ���",GetVehicleName(GetPlayerVehicleID(playerid)));
SendClientMessage(playerid,COLOR_LIGHTBLUE,String);
}
else if(DOF2_GetInt(file,"Buyable") == 2)
{
format(msg,sizeof(msg),"{ff66ff}[{a0d911}%s${ff66ff}] - ����� �� ���� ������ ����� %s ���",GetNum(DOF2_GetInt(file,"Price")),GetVehicleName(vehicleid));
SendClientMessage(playerid,COLOR_WHITE,msg);
SendClientMessage(playerid,COLOR_WHITE,"{ffffff}/Car{ff66ff} :���� ���� ���� ��� �� ����/�");
return 1;
}
else
{
format(msg,sizeof(msg),"{19C0E5}[{a0d911}%s${19C0E5}] - �� ���� ������ ����� %s {19C0E5}���",GetNum(DOF2_GetInt(file,"Price")),GetVehicleName(vehicleid));
SendClientMessage(playerid,COLOR_WHITE,msg);
SendClientMessage(playerid,COLOR_WHITE,"{ffffff}/Car{19C0E5} :���� ���� ���� ��� �� ����/�");
}
}
return 1;
}
public OnPlayerEnterCheckpoint(playerid)
{
if(CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
if(CPS_IsPlayerInCheckpoint(playerid,BankCP)) return ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, "�������� ����", "���� ���� ������\n���� �� �� ����\n���� ���� ������\n����� �����", "���", "�����");
if(CPS_IsPlayerInCheckpoint(playerid,CP_CBank))return ShowPlayerDialog(playerid, 84, DIALOG_STYLE_LIST, "Bank Help", "\n������ ���� ������\n����� ���� ������\nCBalance- ����� ���� ���� �� �����", "�����", "�����");
if(CPS_IsPlayerInCheckpoint(playerid,CP_Wang)) return SellWangExportVehicle(playerid);

if(CPS_IsPlayerInCheckpoint(playerid,CP_StuntStart))
{
if(xStuntsMission) return SendClientMessage(playerid,COLOR_KRED,".������ ����� ���");
if(StuntMissionDo == 1) return SendClientMessage(playerid, COLOR_KRED, ".�� ��� ���� ����� �� ������");
if(GetPlayerMoney(playerid) < 1500) return SendClientMessage(playerid,COLOR_KRED,".$1,500 ���� ���� ������ ������ ��� ����");
for(new i; i < MAX_PLAYERS; i++)if(IsPlayerConnected(i) && i != playerid)format(String, sizeof(String), "[Stunt Mission] >> .��� ������ ������ %s", GetName(playerid)),SendClientMessage(i,COLOR_PINK, String);
SetPlayerTime(playerid,1,00),SetPVarInt(playerid,"InStuntMission",1),StuntMissionDo = 1,StuntCar = CreateVehicle(522,1969.8053,-1425.3619,13.1313,88.5009,3,8,15),SetPlayerVirtualWorld(playerid,15),SetVehicleVirtualWorld(StuntCar,15),PutPlayerInVehicle(playerid,StuntCar,0),GivePlayerMoney(playerid,-1500),StuntCd(60,1),SetTimer("StuntMissionTime",60000,0);
SetPlayerRaceCheckpoint(playerid,1,1824.0890,-1435.1476,35.9219,0,0,0,14);
}
if(CPS_IsPlayerInCheckpoint(playerid,CP_MoneyMission))
{
if(GetPVarInt(playerid,"InMoneyMission") == 0) return SendClientMessage(playerid, COLOR_WHITE, ".��� �� ���� �� ������");
GivePlayerMoney(playerid,9000),format(String, sizeof(String), "[Money Mission] >> ! ���� �� ����� ���� ����� ������ %s",GetName(playerid)),SendClientMessageToAll(COLOR_LIGHTBLUE, String),SetPVarInt(playerid,"InMoneyMission",0),MoneyMissionPickup = CreatePickup(1550 , 2, -2667.6865,732.2017,27.9531, 0);
}
return 1;
}

public TimeUpdate() {
new n = random(MAX_WANGEXPORTVEHICLES);
SendClientMessageToAll(white,"|________________ ��� ������ ________________|");
if(DOF2_IsSet("BBoard.txt","b1"))SendClientMessageToAll(Color_BB,DOF2_GetString("BBoard.txt","b1"));
if(DOF2_IsSet("BBoard.txt","b2"))SendClientMessageToAll(Color_BB,DOF2_GetString("BBoard.txt","b2"));
if(DOF2_IsSet("BBoard.txt","b3"))SendClientMessageToAll(Color_BB,DOF2_GetString("BBoard.txt","b3"));
format(String, sizeof(String),"("Forum")%s`s ���� ����� ���� ��� �� ����",wantedWangExportVehicleNames[n]);
SendClientMessageToAll(Color_BB, String);
SendClientMessageToAll(Color_BB,"{2FE3EE}("Forum")����� ��� ���� ���� ���� ;)");
SendClientMessageToAll(white,"|________________________________________________|");
Wangcar = wantedWangExportVehicleNames[n];
wantedWangExportVehicle = wantedWangExportVehicles[n];
for(new i=0;i<GetMaxPlayers();i++) {
if(IsPlayerConnected(i)) {
Sell[i] = -1;
}
}
}
//==============================================================================
public SellWangExportVehicle(playerid) {
new wantedVehicle = -1;
for(new i=0;i<MAX_WANGEXPORTVEHICLES;i++) {
if(wantedWangExportVehicles[i]==wantedWangExportVehicle) {
wantedVehicle = i;
break;
}
}
if(wantedVehicle>=0) {
if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid)!=PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_WHITE, ".���� ���� ����");
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "���� ���� ����� ����");
if(GetVehicleModel(GetPlayerVehicleID(playerid))!=wantedWangExportVehicle){
format(String, sizeof(String), ".\"%s\" ����� ������ ��� �� ����",Wangcar);
SendClientMessage(playerid, COLOR_WHITE, String);
return 1;
}
if(Sell[playerid] == wantedWangExportVehicle){
format(String, sizeof(String), ".\"%s\" - ��� ���� ��� ���� ��",Wangcar);
SendClientMessage(playerid, COLOR_WHITE, String);
return 1;
}
new payment = (random(6000) + 1000);
format(String, sizeof(String), " *** .%s $ ����� ����,\"%s\" - ���� ���� ��� �� ���� *** ",GetNum(payment),Wangcar);
SendClientMessage(playerid, COLOR_YELLOW, String);
GivePlayerMoney(playerid, payment);
SetVehicleToRespawn(GetPlayerVehicleID(playerid));
Sell[playerid] = wantedWangExportVehicle;
}
return 1;
}


public OnPlayerPickUpPickup(playerid, pickupid)
{
if(pickupid == MoneyMissionPickup)
{
if(xMoneyMission)return SendClientMessage(playerid,red,"������ ����� ���");
for(new i; i < MAX_PLAYERS; i++)if(IsPlayerConnected(i) && GetPVarInt(i,"InMoneyMission") == 1)return SendClientMessage(playerid,COLOR_WHITE,"! ����� ���� �� ������");
for(new i; i < MAX_PLAYERS; i++)if(IsPlayerConnected(i) && i != playerid) format(String, sizeof(String), "[Money Mission] >> .��� ������ ���� ����� %s", GetName(playerid)),SendClientMessage(i,COLOR_PINK, String);
SendClientMessage(playerid, COLOR_PINK, "--- Money Mission ---");
SendClientMessage(playerid, COLOR_WHITE, "!����� ������ ����");
SendClientMessage(playerid, COLOR_WHITE, ".����� ��� ��� ����� ���� ���� ������");
SendClientMessage(playerid, COLOR_WHITE, "(1:30) ��� ������: 90 �����");
SendClientMessage(playerid, COLOR_WHITE, ".SF ���: ���� ������ �");
SendClientMessage(playerid, COLOR_PINK, "----------------------------");
SetPVarInt(playerid,"InMoneyMission",1),MoneyCd(90,1),MoneyMissionTimer = SetTimerEx("MoneyMissionTime",90000,0,"i",playerid),DestroyPickup(MoneyMissionPickup);
return 1;
}
if(pickupid == ArmourSur)
{
SetPlayerArmour(playerid, 100);
}
if(pickupid == HpSur)
{
SetPlayerHealth(playerid, 100);
}
if(pickupid == BankEnter) return SetPlayerPos(playerid,2144.3083,1628.8544,993.6882),SetPlayerInterior(playerid,1),SendClientMessage(playerid,COLOR_YELLOW,"!���� ����"),ResetPlayerWeapons(playerid);

if(pickupid == BankExit){
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,-1953.9718,1343.5518,7.1875);
if(DOF2_GetInt(SFile(playerid),"Golf") == 1){ GivePlayerWeapon(playerid,2,1);}
if(DOF2_GetInt(SFile(playerid),"Knife") == 1){ GivePlayerWeapon(playerid,4,1);}
if(DOF2_GetInt(SFile(playerid),"BaseBall") == 1){ GivePlayerWeapon(playerid,5,1);}
if(DOF2_GetInt(SFile(playerid),"ChineSaw") == 1){ GivePlayerWeapon(playerid,9,1);}
if(DOF2_GetInt(SFile(playerid),"Pistol") == 1){ GivePlayerWeapon(playerid,22,DOF2_GetInt(SFile(playerid),"GAmmo"));}
if(DOF2_GetInt(SFile(playerid),"SPistol") == 1){ GivePlayerWeapon(playerid,23,DOF2_GetInt(SFile(playerid),"GAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Eagle") == 1){ GivePlayerWeapon(playerid,24,DOF2_GetInt(SFile(playerid),"GAmmo"));}
if(DOF2_GetInt(SFile(playerid),"ShoutGun") == 1){ GivePlayerWeapon(playerid,25,DOF2_GetInt(SFile(playerid),"GunAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Combat") == 1){ GivePlayerWeapon(playerid,27,DOF2_GetInt(SFile(playerid),"GunAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Sawn") == 1){ GivePlayerWeapon(playerid,26,DOF2_GetInt(SFile(playerid),"GunAmmo"));}
if(DOF2_GetInt(SFile(playerid),"MP5") == 1){ GivePlayerWeapon(playerid,29,DOF2_GetInt(SFile(playerid),"AssAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Uzi") == 1){ GivePlayerWeapon(playerid,28,DOF2_GetInt(SFile(playerid),"AssAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Tec9") == 1){ GivePlayerWeapon(playerid,32,DOF2_GetInt(SFile(playerid),"AssAmmo"));}
if(DOF2_GetInt(SFile(playerid),"M4") == 1){ GivePlayerWeapon(playerid,31,DOF2_GetInt(SFile(playerid),"MaAmmo"));}
if(DOF2_GetInt(SFile(playerid),"AK47") == 1){ GivePlayerWeapon(playerid,30,DOF2_GetInt(SFile(playerid),"MaAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Country") == 1){ GivePlayerWeapon(playerid,33,DOF2_GetInt(SFile(playerid),"RilfeAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Sniper") == 1){ GivePlayerWeapon(playerid,34,DOF2_GetInt(SFile(playerid),"RilfeAmmo"));}
return 1;
}
return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
new file[256];
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
if(DOF2_GetInt(file,"Nitro") == 2 || strcmp(playername,DOF2_GetString(file,"CarOwner"),true) == 0)
{
if(newkeys & KEY_ACTION || oldkeys & KEY_FIRE)
{
if(MiniOn == 1 || WarOn == 1 || MonsterOn == 1 || BoomOn == 1 || SwarOn == 1 || TanksOn == 1)return 0;
if(IsPlayerInAnyVehicle(playerid))
RemoveVehicleComponent(GetPlayerVehicleID(playerid),1010);
AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
}
}
if(Autojump[playerid] == 1)
{
if((oldkeys & KEY_FIRE))
{
if(MiniOn == 1 || WarOn == 1 || MonsterOn == 1 || BoomOn == 1 || SwarOn == 1 || TanksOn == 1)return 0;
new Float:x,Float:y,Float:z;
if(IsPlayerInAnyVehicle(playerid))
GetVehicleVelocity(GetPlayerVehicleID(playerid),x,y,z);
SetVehicleVelocity(GetPlayerVehicleID(playerid),x,y,z+0.2);
}
}
if(Autonitro[playerid] == 1)
{
if(newkeys & KEY_ACTION || oldkeys & KEY_FIRE)
{
if(MiniOn == 1 || WarOn == 1 || MonsterOn == 1 || BoomOn == 1 || SwarOn == 1 || TanksOn == 1)return 0;
if(IsPlayerInAnyVehicle(playerid))
if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
RemoveVehicleComponent(GetPlayerVehicleID(playerid),1010);
AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
}
}
if(Autopjump[playerid] == 1)
{
if((oldkeys & KEY_JUMP))
{
if(MiniOn == 1 || WarOn == 1 || MonsterOn == 1 || BoomOn == 1 || SwarOn == 1 || TanksOn == 1)return 0;
new Float:x,Float:y,Float:z;
if(!IsPlayerInAnyVehicle(playerid))
GetPlayerVelocity(playerid,x,y,z);
SetPlayerVelocity(playerid,x,y,z+0.4);
}
}
if(IsKeyJustDown(KEY_FIRE,newkeys,oldkeys) || IsKeyJustDown(128,newkeys,oldkeys))
//	if(IsKeyJustDown(KEY_FIRE,newkeys,oldkeys))
{
if(IsPlayerInArea(playerid, 2141.1985,1627.7273,2147.1577,1641.9762))
{
SetPlayerVirtualWorld(playerid, 0);
SetPlayerInterior(playerid,1);
SetPlayerPos(playerid, 2144.235351,1632.090332,993.576110);
ResetPlayerWeapons(playerid);
ShowPlayerDialog(playerid, 5569, 0, "ERROR", "��� ����� / ����� ����� ��", "����", "");
}
}
if(IsKeyJustDown(KEY_FIRE,newkeys,oldkeys) || IsKeyJustDown(128,newkeys,oldkeys))
//	if(IsKeyJustDown(KEY_FIRE,newkeys,oldkeys))
{
if(IsPlayerInArea(playerid, 343.4185,2528.9663,375.8793,2548.4529))
{
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,365.3967,2536.4294,16.6646);
ShowPlayerDialog(playerid, 5569, 0, "ERROR", "��� ����� / ����� ����� ��", "����", "");
}
}
if(IsKeyJustDown(KEY_FIRE,newkeys,oldkeys) || IsKeyJustDown(128,newkeys,oldkeys))
{
if(GetPlayerVirtualWorld(playerid) == 25)
{
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,828.2188,-2110.1045,7.2493);
ShowPlayerDialog(playerid, 5569, 0, "ERROR", "��� ����� / ����� ����� ��", "����", "");
}
}

if(IsKeyJustDown(KEY_SPRINT,newkeys,oldkeys)&&Stoned[playerid] == 1) StopLoopingAnim(playerid);
if(IsKeyJustDown(KEY_SPRINT,newkeys,oldkeys) && Danced[playerid] == 1)StopLoopingAnim(playerid);

return 1;
}
stock IsPlayerInArea(playerid, Float:min_x, Float:min_y, Float:max_x, Float:max_y)
{
new Float:X, Float:Y, Float:Z;
GetPlayerPos(playerid, X, Y, Z);
if(X <= max_x && X >= min_x && Y <= max_y && Y >= min_y) return 1;
return 0;
}


public OnPlayerUpdate(playerid){
SetPlayerScore(playerid,GetPVarInt(playerid,"Money"));
 new drunknew;
    drunknew = GetPlayerDrunkLevel(playerid);

    if (drunknew < 100) { // go back up, keep cycling.
        SetPlayerDrunkLevel(playerid, 2000);
    } else {

        if (pDrunkLevelLast[playerid] != drunknew) {

            new wfps = pDrunkLevelLast[playerid] - drunknew;

            if ((wfps > 0) && (wfps < 200))
                pFPS[playerid] = wfps;

            pDrunkLevelLast[playerid] = drunknew;
        }
	}
new Float:SPos[3];
if(InSwar[playerid] == 3)
{
GetPlayerPos(playerid,SPos[0],SPos[1],SPos[2]);
if(SPos[2] < -0.7251)
{
SwarPlayers --;
InSwar[playerid] = 0;
DestroyVehicle(Swar[playerid]);
CallRemoteFunction("CheckPlayers","i",SwarPlayers);
SetPlayerPos(playerid,Position[playerid][0],Position[playerid][1],Position[playerid][2]);
SetPlayerVirtualWorld(playerid,0);
}
}
if(GetPVarInt(playerid,"TDStats") == 1){
new Kills;
switch(GetPlayerLevel(playerid)){
case 0:Kills = Level2; case 1:Kills = Level2; case 2:Kills = Level3;
case 3:Kills = Level4; case 4:Kills = Level5; case 5:Kills = Level6;
case 6:Kills = Level7; case 7:Kills = Level8; case 8:Kills = Level9;
case 9:Kills = Level10; case 10:Kills = Level11; case 11:Kills = Level12;
case 12:Kills = Level13; case 13:Kills = Level14; case 14:Kills = Level15;
case 15:Kills = Level16; case 16:Kills = Level17; case 17:Kills = Level18;
case 18:Kills = Level19; case 19:Kills = Level20; case 20:Kills = Level21;
case 21:Kills = Level22; case 22:Kills = Level23; case 23:Kills = Level24;
case 24:Kills = Level25; case 25:Kills = Level26; case 26:Kills = Level27;
case 27:Kills = Level28; case 28:Kills = Level29; case 29:Kills = Level30;
case 30:Kills = Level31; case 31:Kills = Level32; case 32:Kills = DOF2_GetInt(SFile(playerid), "Kills");
default:Kills = 0;
}
format(SString,sizeof(SString),"~h~~r~LEVEL:~w~~h~%d ~r~KIILS:~w~%d/%d~h~~r~ NEXTLEVEL:~w~~h~%d",DOF2_GetInt(SFile(playerid), "Level"),DOF2_GetInt(SFile(playerid), "Kills"),Kills,DOF2_GetInt(SFile(playerid), "Level") + 1);
TextDrawSetString(Textdraw1[playerid],SString);
}
return 1;}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
//==============================================================================
if(dialogid == 360)
{
    if(!response)return 1;
	switch(listitem)
	{
		case 0:ShowPlayerDialog(playerid,361,DIALOG_STYLE_MSGBOX,"����� ����� ��� - ������","{FFFFFF}.�� �� ���� ������ ���� ���� 800 ����\n���� ����� 10 ����� ���� ����� 15 ��� ������ ���� /Dm, /Sawn, /Bazooka, /TDM ��������\n�����, �� ����� ���� ���� ''�����'' (����� ����� ������ ��������) ����� �� ���� ��� ����. ��-�� ��� ��������\n.�� ��� ����� ��� 1 ����� ���� 3,000 ���� �� ��� ��� 2 ����� ���� 5,000 ���� ��� ����","����","�����");
  		case 1:ShowPlayerDialog(playerid,361,DIALOG_STYLE_MSGBOX,"����� ����� ��� - ����� ����","{FFFFFF}:�� ��� ����� ����� �� ��� ���� ���� ����\n.������� ���� 10 ������ ����� �� 200,000 ���� ����\n.������� ���� 15 ������ ����� �� 300,000 ���� ����\n.������� ���� 20 ������ ����� �� 400,000 ���� ����\n.������� ��� 30 ������ ����� �� 800,000 ���� ����","����","�����");
  		case 2:
		{
		new DiceDialog[1000];
	 	strcat(DiceDialog, "{FF9900}[ Dice ]{FFFFFF}\n");
	 	strcat(DiceDialog, ".����� ���� �� ���� ����� - ����� ���� �� ���� ���� ���� ����� /Dice ������\n");
	 	strcat(DiceDialog, "Money ��� ���� � 1 �� 6 ����� ��� ������, �- Number ���� /Dice Number Money ������ ����� ���\n");
	 	strcat(DiceDialog, ".��� ���� ���� ����� ��� ������. ����� ���� �� ����� ���, ��� ��� 1,000 ���� �- 100,000,000 ����\n");
	 	strcat(DiceDialog, ".�� ����, ���� ������� - �����! ����� �� ������ �� 1,000 ����, ����� 2,000 ����, 1,000 ���� ������\n");
	 	strcat(DiceDialog, "�� ������ �� ���� ���� ���� ���, ������ �� �� ���� ������� ����, �� ����� ��� ��� ���� ���� ������\n");
	 	strcat(DiceDialog, "\n{FF9900}[ Lotto ]{FFFFFF}\n");
	 	strcat(DiceDialog, ".������ ��� �������� ����� �� ������ �����, ��� ���� ����� ���� ������ ��� ����� �����\n");
	 	strcat(DiceDialog, "/Lotto Number �������� �������� ���� ����� �� ����, ����� ������ ���� ������\n");
	 	strcat(DiceDialog, ".���� ���� �-1 ��� � 120 ������� ���� ���� �����Number �����\n");
	 	strcat(DiceDialog, "����� ����� ���� 1,500 �� �� ���� ��, ������ ���� ���� ����� ����� - ����� ���� 100 �� ����� 200 ��� ����, ��� ���\n");
  		ShowPlayerDialog(playerid,361,DIALOG_STYLE_MSGBOX,"����� ����� ��� - �������",DiceDialog,"����","�����");
		}
		case 3:ShowPlayerDialog(playerid,361,DIALOG_STYLE_MSGBOX,"����� ����� ��� - ������","{ffffff}.������ ������� ������� ���� ���� �� ���, �� ����� ������ �� ���� ���� ������\n/Battle Invite ID Light/Heavy/Sniper Money ��� ������ ���� ����� ����� �� ������\nID - ������ �� �����\n(Colt 45 / Uzi / Sawn) ����� ���� - Light\n(Deagle / Combat / M4) ����� ����� - Heavy\n������ - Sniper\n���� ���� ����� ���� ���� - Money","����","�����");
  		case 4:ShowPlayerDialog(playerid,362,DIALOG_STYLE_LIST,"����� ����� ��� - ������","���� �����\n����� ����\n����� ������\n����� �����\n����� �������\n����� �������","���","����");
  		case 5:ShowPlayerDialog(playerid,361,DIALOG_STYLE_MSGBOX,"����� ����� ��� - ������","{ffffff}","����","�����");
  		case 6:ShowPlayerDialog(playerid,361,DIALOG_STYLE_MSGBOX,"����� ����� ��� - ������","{ffffff}","����","�����");
  		
	}
	return 1;
}
if(dialogid == 361)
{
if(response)return ShowPlayerDialog(playerid,360,DIALOG_STYLE_LIST,"����� ����� ���","������\n����� ����\n�������\n������\n������\n����� ����\n��������","���","����");
return 1;
}
//==============================================================================
if(dialogid == 7519)
{
	switch(listitem)
	{
		case 0: HqTeleport(playerid,2597.3315,1823.4454,10.8203,89.9345,2622.0415,1824.2712,11.0234,88.4563);
		case 1: HqTeleport(playerid,2159.8992,1126.8579,23.3359,60.6472,2159.8992,1126.8579,23.3359,60.6472);
		case 2: HqTeleport(playerid,1538.9275,698.3962,10.8203,91.7784,1489.3052,702.5983,10.8203,3.4176);
		case 3: HqTeleport(playerid,-1415.7756,392.0870,30.0859,269.0803,-1415.7756,392.0870,30.0859,269.0803);
	}
	return 1;
}
if(dialogid == 1192)
{
if(!response)return 1;
switch(listitem)
{
case 0:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xmini start 10000");
case 1:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xwar start 10000");
case 2:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xweapons start 10000");
case 3:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xmonster start 10000");
case 4:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xboom start 10000");
case 5:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xswar start 10000");
case 6:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xkart start 10000");
case 7:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xracing start 10000");
case 8:return ShowPlayerDialog(playerid, 1193,DIALOG_STYLE_LIST,"End Active","Mini\nWar\nWeapons\nMonster\nBoom\nSwar\nKart\nRacing", "�����", "�����");
}
return 1;
}
if(dialogid == 1193)
{
if(!response)return 1;
switch(listitem)
{
case 0:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xmini end");
case 1:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xwar end");
case 2:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xweapons end");
case 3:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xmonster end");
case 4:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xboom end");
case 5:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xswar end");
case 6:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xkart end");
case 7:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/xracing end");
}
return 1;
}
if(dialogid == 1984 && response) return format(Question,sizeof Question,"%s",inputtext),ShowPlayerDialog(playerid, 1985, DIALOG_STYLE_INPUT, "����� �������", "���� �� �� ������", "�����", "�����");
if(dialogid == 1985 && response) return format(Answer,sizeof Answer,"%s",inputtext),ShowPlayerDialog(playerid, 1986, DIALOG_STYLE_INPUT, "����� �������", "���� �� �� �����", "�����", "�����");
if(dialogid == 1986 && response)
{
 	SetPVarInt(playerid,"TriviaMoney",strval(inputtext));
	SendClientMessageToAll(COLOR_WHITE,"--- Trivia ---");
	format(String, sizeof(String), "%s",Question),SendClientMessageToAll(COLOR_PINK,String);
	format(String, sizeof(String), ".$%s :���� ������",GetNum(GetPVarInt(playerid, "TriviaMoney"))),SendClientMessageToAll(COLOR_PINK,String);
	SendClientMessageToAll(COLOR_PINK,"/Ans - ����� ������ �����");
	SendClientMessageToAll(COLOR_WHITE,"------------------------------");
	for(new i = 0; i < GetMaxPlayers() ; i++)if(IsPlayerConnected(i)) SetPVarInt(i,"WrongAns",0);
	TriviaOn = 1,EndTrivia = SetTimer("TriviaFinish",1000*60,0);
	return 1;
}
if(dialogid == SetEmailDialog)
{
if(!response)return 1;
DOF2_SetString(SFile(playerid),"Email",inputtext);
ShowPlayerDialog(playerid,MSGBoxDialog,DIALOG_STYLE_MSGBOX,"���� ����� �����","!����� ������ ��� ������ ������\n DeathMatch SA:MP ��� �� �� ����� �� ���� ������ ��� ������ �� ����� ���","�����","");
new szString2[500];
format(szString2, sizeof(szString2), "���� %s,\n\n������ ������� ����� ������!\n������ ����� ��� ���: %d - ���� ����� �� �����\n\n�����,\n���� Ultimate DM SA:MP", GetName(playerid),DOF2_GetInt(SFile(playerid),"UserID"), DOF2_GetString(SFile(playerid),"Password"));
return 1;
}
if(dialogid == ResetPassDialog)
{
if(!response)return 1;
ShowPlayerDialog(playerid,MSGBoxDialog,DIALOG_STYLE_MSGBOX,"����� �����","������ ����� �����","�����","");
new szString2[500];
format(szString2, sizeof(szString2), "���� %s,\n\n���� ����� �� �����\n%s:������ ���\n\n�����,\nDeathMatch SA:MP ����", GetName(playerid), DOF2_GetString(SFile(playerid),"Password"));
return 1;
}
if(dialogid == BugDialog)
{
if(!response)return 1;
ShowPlayerDialog(playerid,MSGBoxDialog,DIALOG_STYLE_MSGBOX,"����� ���","���� ���� ������ ����\n���� �� ����� ����","�����","");
new szString2[500];
format(szString2, sizeof(szString2), "��� ��� %s �����\n����:\n%s", GetName(playerid),inputtext);
return 1;
}

if(dialogid == 1093) ShowPlayerDialog(playerid,1015,DIALOG_STYLE_MSGBOX,"{25A8B7}����� ����","{FFFFFF}/Tele - ������ �������\n/CarHelp - ������ ��������\n/ClanHelp - ������ �������\n/SpyHelp - ����� �� ����� ������\n/WeedsHelp - ������ �����\n/PhoneHelp - ����� ������\n/WeaponsHelp - ���� ������","�����","");
if(dialogid == 1094) ShowPlayerDialog(playerid,1015,DIALOG_STYLE_MSGBOX,"{25A8B7}Help Menu","{FFFFFF}/Tele - Teleports Dialog\n/CarHelp - Cars Commands\n/ClanHelp - Clan Commands\n/SpyHelp - Spy system\n/WeedsHelp - Weeds Commands\n/PhoneHelp - CallPhone Usage\n/WeaponsHelp - Weapons Information","Exit","");
if(dialogid == 1095)
{
if(!response)return ShowPlayerDialog(playerid,1093,DIALOG_STYLE_MSGBOX,"{25A8B7}����� ����","{FFFFFF}/Commands - ����� ������\n/Teleports - ����� �������\n/Credits - ����� �������\n/Admins - ������� �������\n/Support - ���� �� ���� �����\n/Settings - ����� ������ �����\n/Animlist - ����� ��������\n/MoneyHelp - ����� ����� ���\n/Helpme - ���� ���� ����� ������\n{FF0000}/Rules - ���� ���","���� ���","�����");
ShowPlayerDialog(playerid,1094,DIALOG_STYLE_MSGBOX,"{25A8B7}Help Menu","{FFFFFF}/Commands - Main commands\n/Teleports - Server's Teleports\n/Credits - Server's Credits\n/Admins - Onlie admin\n/Support - Information about supporters\n/Settings - Change your settings\n/Animlist - Animations list\n/MoneyHelp - Ways to make money\n/Helpme - Requesthelp from online helpers\n{FF0000}/Rules - Rules","Next Page","Exit");
return 1;
}
  if(dialogid == 84 && response)
    {
        switch(listitem)
        {
         case 0:{
             ShowPlayerDialog(playerid, 107, DIALOG_STYLE_INPUT, "{FF0000} ����� ��� ", "���� �� ���� ���� �������", "�����", "�����");
                 } case 1:{
         ShowPlayerDialog(playerid, 108, DIALOG_STYLE_INPUT, "{FF0000} ����� ��� ", "���� �� ���� ���� �������", "�����", "�����");
          } case 2:{
  		if(!InClan(playerid))return SendClientMessage(playerid, COLOR_WHITE,".���� ���/� ���� ����");
  		new file[256];
		format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
		SendFormatMessage(playerid, COLOR_YELLOW,"$ %d : ���� ����� ���",DOF2_GetInt(file,"Bank"));
         }
        }
       	return 1;
    }
    	if(dialogid==107 && response)
	{
		if(!InClan(playerid))return SendClientMessage(playerid, COLOR_WHITE,".���� ���/� ���� ����");
	    if(!strlen(inputtext))return ShowPlayerDialog(playerid, 107, DIALOG_STYLE_INPUT, "{FF0000} ����� ��� ", "���� �� ���� ���� �������", "�����", "�����");
	    if(strval(inputtext) < 1 || strval(inputtext) > 10000000)return ShowPlayerDialog(playerid, 107, DIALOG_STYLE_INPUT, "{FF0000} ����� ��� ", "���� �� ���� ���� �������", "�����", "�����");
        if(GetPlayerMoney(playerid) < strval(inputtext))return ShowPlayerDialog(playerid, 107, DIALOG_STYLE_INPUT, "{FF0000} ����� ��� ", "���� �� ���� ���� �������", "�����", "�����");
		GivePlayerMoney(playerid,-strval(inputtext));
		new file[256];
		format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
        DOF2_SetInt(file,"Bank",  DOF2_GetInt(file,"Bank") + strval(inputtext));
		format(String, sizeof(String), "$ %d ����� ������ �����", strval(inputtext));
		SendClientMessage(playerid, COLOR_YELLOW, String);
		format(String,sizeof(String),".$%s ����� ����� ��� \"%s\"",GetNum(strval(inputtext)),GetName(playerid));
		SendClanMessage(playerid,COLOR_ORANGE,String);
		return 1;}
	 	if(dialogid== 108&& response)
	{
	    new file[256];
		if(!InClan(playerid))return SendClientMessage(playerid, COLOR_WHITE,".���� ���/� ���� ����");
        if(DOF2_GetInt(SFile(playerid), "ClanLevel") < 5)return SendClientMessage(playerid, COLOR_WHITE,"�� ���� ���� ����� ���");
        format(String, sizeof(String),"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
	    if(!strlen(inputtext))return ShowPlayerDialog(playerid, 108, DIALOG_STYLE_INPUT, "{FF0000} ����� ��� ", "���� �� ���� ���� �������", "�����", "�����");
	     if(strval(inputtext) < 1 || strval(inputtext) > 10000000)return ShowPlayerDialog(playerid, 108, DIALOG_STYLE_INPUT, "{FF0000} ����� ��� ", "���� �� ���� ���� �������", "�����", "�����");
		format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
  		if(strval(inputtext) > DOF2_GetInt(file,"Bank"))return ShowPlayerDialog(playerid, 108, DIALOG_STYLE_INPUT, "{FF0000} ����� ��� ", "���� �� ���� ���� �������", "�����", "�����");
		GivePlayerMoney(playerid, strval(inputtext));
		DOF2_SetInt(file,"Bank",  DOF2_GetInt(file,"Bank") - strval(inputtext));
		format(String, sizeof(String), "$ %d :���� �������", strval(inputtext));
		SendClientMessage(playerid, COLOR_YELLOW, String);
		format(String,sizeof(String),".$%s ��� ������ ��� \"%s\"",GetNum(strval(inputtext)),GetName(playerid));
		SendClanMessage(playerid,COLOR_ORANGE,String);
		return 1;}
if(dialogid == 7116)
{
	new file[256];
	format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,"! ��� �� ����");
	if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
	switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
	{
		case 448,461,462,463,468,471,509,510,521,522,523,581,586: return SendClientMessage(playerid,COLOR_WHITE,".������ ��� �� ����� ���������");
	}
	switch(listitem)
	{
		case 0:
		{
			if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
			if(GetPlayerMoney(playerid) < 300000) return SendClientMessage(playerid,COLOR_KRED,"! ��� �� �� ����� �����");
			SendClientMessage(playerid,COLOR_LIGHTGREEN, "! $���� ����� ������ ����� 300,000"),AddVehicleComponent(GetPlayerVehicleID(playerid),1073),DOF2_SetInt(file,"Wheels",1),DOF2_SetInt(file,"WheelsOn",1073),AddVehicleComponent(GetPlayerVehicleID(playerid), 1073),GivePlayerMoney(playerid,-300000);
		}
		case 1:
		{
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
			if(GetPlayerMoney(playerid) < 500000) return SendClientMessage(playerid,COLOR_KRED,"! ��� �� �� ����� �����");
			SendClientMessage(playerid,COLOR_LIGHTGREEN, "! $���� ����� ������ ����� 500,000"),AddVehicleComponent(GetPlayerVehicleID(playerid),1074),DOF2_SetInt(file,"Wheels",1),DOF2_SetInt(file,"WheelsOn",1074),AddVehicleComponent(GetPlayerVehicleID(playerid), 1074),GivePlayerMoney(playerid,-500000);
		}
		case 2:
		{
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
			if(GetPlayerMoney(playerid) < 100000) return SendClientMessage(playerid,COLOR_KRED,"! ��� �� �� ����� �����");
			SendClientMessage(playerid,COLOR_LIGHTGREEN, "! $���� ����� ������ ����� 100,000"),AddVehicleComponent(GetPlayerVehicleID(playerid),1075),DOF2_SetInt(file,"Wheels",1),DOF2_SetInt(file,"WheelsOn",1075),AddVehicleComponent(GetPlayerVehicleID(playerid), 1075),GivePlayerMoney(playerid,-100000);
		}
		case 3:
		{
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
			if(GetPlayerMoney(playerid) < 100000) return SendClientMessage(playerid,COLOR_WHITE,"! ��� �� �� ����� �����");
			SendClientMessage(playerid,COLOR_LIGHTGREEN, "! $���� ����� ������ ����� 100,000"),AddVehicleComponent(GetPlayerVehicleID(playerid),1076),DOF2_SetInt(file,"Wheels",1),DOF2_SetInt(file,"WheelsOn",1076),AddVehicleComponent(GetPlayerVehicleID(playerid), 1076),GivePlayerMoney(playerid,-100000);
		}
		case 4:
		{
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
			if(GetPlayerMoney(playerid) < 200000) return SendClientMessage(playerid,COLOR_KRED,"! ��� �� �� ����� �����");
			SendClientMessage(playerid,COLOR_LIGHTGREEN, "! $���� ����� ������ ����� 200,000"),AddVehicleComponent(GetPlayerVehicleID(playerid),1077),DOF2_SetInt(file,"Wheels",1),DOF2_SetInt(file,"WheelsOn",1077),AddVehicleComponent(GetPlayerVehicleID(playerid), 1077),GivePlayerMoney(playerid,-200000);
		}
		case 5:
		{
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
			if(GetPlayerMoney(playerid) < 100000) return SendClientMessage(playerid,COLOR_KRED,"! ��� �� �� ����� �����");
			SendClientMessage(playerid,COLOR_LIGHTGREEN, "! $���� ����� ������ ����� 100,000"),AddVehicleComponent(GetPlayerVehicleID(playerid),1078),DOF2_SetInt(file,"Wheels",1),DOF2_SetInt(file,"WheelsOn",1078),AddVehicleComponent(GetPlayerVehicleID(playerid), 1078),GivePlayerMoney(playerid,-100000);
		}
		case 6:
		{
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
			if(GetPlayerMoney(playerid) < 400000) return SendClientMessage(playerid,COLOR_KRED,"! ��� �� �� ����� �����");
			AddVehicleComponent(GetPlayerVehicleID(playerid),1079),SendClientMessage(playerid,COLOR_LIGHTGREEN, "! $���� ����� ������ ����� 400,000"),DOF2_SetInt(file,"Wheels",1),DOF2_SetInt(file,"WheelsOn",1079),AddVehicleComponent(GetPlayerVehicleID(playerid), 1079),GivePlayerMoney(playerid,-400000);
		}
		case 7:
		{
		if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
			if(GetPlayerMoney(playerid) < 850000) return SendClientMessage(playerid,COLOR_WHITE,".��� �� �� ����� �����");
			SendClientMessage(playerid,COLOR_LIGHTGREEN, "! $���� ����� ������ ����� 850,000"),AddVehicleComponent(GetPlayerVehicleID(playerid),1080),DOF2_SetInt(file,"Wheels",1),DOF2_SetInt(file,"WheelsOn",1080),AddVehicleComponent(GetPlayerVehicleID(playerid), 1080),GivePlayerMoney(playerid,-850000);
		}
		case 8:
		{
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
			if(GetPlayerMoney(playerid) < 200000) return SendClientMessage(playerid,COLOR_KRED,"! ��� �� �� ����� �����");
			SendClientMessage(playerid,COLOR_LIGHTGREEN, "! $���� ����� ������ ����� 200,000"),AddVehicleComponent(GetPlayerVehicleID(playerid),1081),DOF2_SetInt(file,"Wheels",1),DOF2_SetInt(file,"WheelsOn",1081),AddVehicleComponent(GetPlayerVehicleID(playerid), 1081),GivePlayerMoney(playerid,-200000);
		}
		case 9:
		{
	if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
			if(GetPlayerMoney(playerid) < 300000) return SendClientMessage(playerid,COLOR_KRED,"! ��� �� �� ����� �����");
			SendClientMessage(playerid,COLOR_LIGHTGREEN, "! $���� ����� ������ ����� 300,000"),AddVehicleComponent(GetPlayerVehicleID(playerid),1082),DOF2_SetInt(file,"Wheels",1),DOF2_SetInt(file,"WheelsOn",1082),AddVehicleComponent(GetPlayerVehicleID(playerid), 1082),GivePlayerMoney(playerid,-300000);
		}
		case 10:
		{
		if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
			if(GetPlayerMoney(playerid) < 300000) return SendClientMessage(playerid,COLOR_WHITE,"! ��� �� �� ����� �����");
			SendClientMessage(playerid,COLOR_LIGHTGREEN, "! $���� ����� ������ ����� 300,000"),AddVehicleComponent(GetPlayerVehicleID(playerid),1083),DOF2_SetInt(file,"Wheels",1),DOF2_SetInt(file,"WheelsOn",1083),AddVehicleComponent(GetPlayerVehicleID(playerid), 1083),GivePlayerMoney(playerid,-300000);
		}
		case 11:
		{
		if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
			if(GetPlayerMoney(playerid) < 100000) return SendClientMessage(playerid,COLOR_KRED,"! ��� �� �� ����� �����");
			SendClientMessage(playerid,COLOR_LIGHTGREEN, "! $���� ����� ������ ����� 100,000"),AddVehicleComponent(GetPlayerVehicleID(playerid),1084),DOF2_SetInt(file,"Wheels",1),DOF2_SetInt(file,"WheelsOn",1084),AddVehicleComponent(GetPlayerVehicleID(playerid), 1084),GivePlayerMoney(playerid,-100000);
		}
		case 12:
		{
if(DOF2_GetInt(SFile(playerid),"OwnCar") == 0)return SendClientMessage(playerid,COLOR_WHITE,"! ��� ��� �������");
			if(GetPlayerMoney(playerid) < 300000) return SendClientMessage(playerid,COLOR_KRED,"! ��� �� �� ����� �����");
			SendClientMessage(playerid,COLOR_LIGHTGREEN, "! $���� ����� ������ ����� 300,000"),AddVehicleComponent(GetPlayerVehicleID(playerid),1085),DOF2_SetInt(file,"Wheels",1),DOF2_SetInt(file,"WheelsOn",1085),AddVehicleComponent(GetPlayerVehicleID(playerid), 1085),GivePlayerMoney(playerid,-300000);
		}
	}
	return 1;
}
if(dialogid == 7001 && response){
new file[50];
format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
format(String,sizeof(String),"!������ %s ���� ������",DOF2_GetString(SFile(playerid),"Clan"));
SendClientMessage(playerid,COLOR_KRED,String);
DOF2_SetInt(file,"Players",DOF2_GetInt(file,"Players")-1);
DOF2_SetString(SFile(playerid), "Clan","None");
DOF2_SetInt(SFile(playerid), "ClanLevel",0);
for(new c; c < GetMaxPlayers(); c++){
if(IsPlayerConnected(c) && !strcmp(DOF2_GetString(SFile(c),"Clan"),DOF2_GetString(SFile(playerid),"Clan"),true)){
format(String,sizeof(String),"��� ������ %s",GetName(playerid));
SendClientMessage(c,COLOR_KRED,String);
}}
return 1;}
if(dialogid == 1986 && response){
format(CodeQuestion,sizeof CodeQuestion,"%s",inputtext);
format(String, sizeof(String), ".$%s ���� � /%s ������ ������ �� ����",GetNum(CodeMoney),CodeQuestion),SendClientMessageToAll(COLOR_PINK,String);
for(new i = 0; i < GetMaxPlayers() ; i++)if(IsPlayerConnected(i)) CodeOn = 1,EndCode = SetTimer("CodeFinish",1000*60,0);
return 1;}
switch(dialogid)
{
case Rules_Dialog1:
{
	ShowPlayerDialog(playerid, Rules_Dialog2, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 2 - ����� ���� �����\n\n.��� ������ ���� �� �����, ����� ������ ������ ���� �� ����� ���\n.����� ��� ����� �� ��� �� ���� ���� �� ����� ����� ������ �� ����� ����� ����", "�����", "");
}
case Rules_Dialog2:
{
	ShowPlayerDialog(playerid, Rules_Dialog3, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 3 - �����\n\n.��� ����� ���� ����� ����� / ������ / �����\n.����� ��� ����� �� ��� �� ����� ������� �����", "����", "");
}
case Rules_Dialog3:
{
	ShowPlayerDialog(playerid, Rules_Dialog4, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 4 - �������\n\n��� ����� �� ���� ��'�� ����\n/Report [id] [reason] :���� ����� �� ���� �������� ������ ������\n.����� ������ �� ����� �� ������ �� ����� ���� ����� ����� ����� ���� ���� �������� ����� ����", "����", "");
}
case Rules_Dialog4:
{
	ShowPlayerDialog(playerid, Rules_Dialog5, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 5 - ������ ����\n\n!��� ���� ����� �� ���� ��� ���� �� ������\n.����� ���� ������ ����� �� ���� ��� ��� ���� �� ������ ����� �� ���� ����� ������ ���� ����\n.����� ���� ����� ���� ��� ���� �� ������ ����� ���� ���", "����", "");
}
case Rules_Dialog5:
{
	ShowPlayerDialog(playerid, Rules_Dialog6, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 6 - ����� ���\n\n.���� �� ����� ������� ����\n.����� �� ���� ����� ���� �� ���� ��� ������ ����� ���� ����� ���� �''� ����� �� ������� ���\n.����� ����� ��� ��� ������� ���� ������ ������ ������", "����", "");
}
case Rules_Dialog6:
{
	ShowPlayerDialog(playerid, Rules_Dialog7, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 7 - ����\n\n.���� ��� ����� �� ������ �����: �����\n.������ ���� ��� �������� ������ �� ������� ����� ������ ����� ���� ���, �������, ����� ����\n.����� ������ ����� �� ��� �� ��� ���", "����", "");
}
case Rules_Dialog7:
{
    ShowPlayerDialog(playerid, Rules_Dialog8, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 8 - ����� ������\n\n.����� ������ ������� ��� ���� ������ ������, ����� �������� ������ ����� ������ ��� ����� ���� �� ��-�������\n.�����, ����� ������ ����� ������� ������� ��'�����, ������ �� ���� �� ��� ����� ��'�� �� ���\n.����� ������ ��� ���� �� ��� �� ��� ���", "����", "");
}
case Rules_Dialog8:
{
	ShowPlayerDialog(playerid, Rules_Dialog9, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 9 - ����� �����\n\n.���� ����� ������� ����� ������ ������, ������ ������ ����� ���� �� ����� ����, ��� ���� ��� ���\n.����� ������ ���, ����� ���� ������ �����\n.��� ����� ����� ����� ������ ��� ���� ����� ��� ����� �� ��� �� ���� ���� ���", "����", "");
}
case Rules_Dialog9:
{
	ShowPlayerDialog(playerid, Rules_Dialog10, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 10 - ����� ������\n\n!��� ����� �� ������ ��� ��� ����\n.��� ����� ����� �� ��� �� ������ ��� ���� ����� ���� ���", "����", "");
}
case Rules_Dialog10:
{
	ShowPlayerDialog(playerid, Rules_Dialog11, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 11 - ����� ������ ����� ��'��\n\n.��'�� ��� �� ��� ������\n.����� ��� ����� �� ��� �� ���� ����", "����", "");
}
case Rules_Dialog11:
{
	ShowPlayerDialog(playerid, Rules_Dialog12, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 12 - ����� ���\n\n!��� ����� ���� ���� ��� ���� �� ���� ���� ��� �����\n.���� ����� ����� ���� ���� ���� ����\n.����� ��� ����� �� ��� �� ���� �� ��� ������ / �����", "����", "");
}
case Rules_Dialog12:
{
	ShowPlayerDialog(playerid, Rules_Dialog13, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 13 - ����� ���\n\n.����� �� ���� / ���� / ��� �� �� ��� �� ��� ����� ��� ��� ���� ����� ��� ������� �����\n��� ���� ����� ��� ������� �����: �������, ������ ����� �������� ������\n.����� ����� �� ��� �� ��� ���", "����", "");
}
case Rules_Dialog13:
{
	ShowPlayerDialog(playerid, Rules_Dialog14, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 14 - �'�����\n\n.����� ��������� ��� ����� ����� ������ ���� ����� - (Joypad) �'�����\n.������ ������ �������� ���� ���� ���� ����� ����� �� ��� ����� ����\n.����� ����� �� ��� �� ��� ���", "����", "");
}
}
if(dialogid == 2)
{
if(response)
{
switch(listitem)
{
case 0:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Ap");
case 1:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/DM");
case 2:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/LS");
case 3:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/LV");
case 4:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/SF");
case 5:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Fly");
case 6:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Stunts");
case 7:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Sawn");
case 8:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Race");
case 9:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Drift");
case 10:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Jump");
case 11:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Jeeps");
case 12:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Ramp");
case 13:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Police");
case 14:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Bustrip");
case 15:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Bank");
case 16:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Swamp");
case 17:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Fight");
case 18:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Tower");
case 19:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/ShipTrip");
case 20:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Chiliad");
case 21:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Farm");
case 22:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Ammo");
case 23:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Garage 1");
case 24:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Garage 2");
case 25:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Garage 3");
case 26:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/Bazooka");
case 27:return SetPVarInt(playerid,"ASpam",0),OnPlayerCommandText(playerid, "/UnderWater");
}
}
return 1;
}
if(dialogid == neondialog1)
{
if(response)
{
if(listitem == 0)
{
DestroyObject(GetPVarInt(playerid, "neon"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon1"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon2"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon3"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon4"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon5"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon6"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon7"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon8"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon9"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon10"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon11"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon12"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon13"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon14"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon15"));
DestroyObject(GetPVarInt(playerid, "neon17"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon16"));
DeletePVar(playerid, "Status");
SetPVarInt(playerid, "Status", 1);
SetPVarInt(playerid, "neon", CreateObject(18648,0,0,0,0,0,0));
SetPVarInt(playerid, "neon1", CreateObject(18648,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "neon"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
AttachObjectToVehicle(GetPVarInt(playerid, "neon1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
SendClientMessage(playerid, 0xFFFFFFAA, "Neon installed {000000}[{0000FF}Blue{000000}]");
}
if(listitem == 1)
{
DestroyObject(GetPVarInt(playerid, "neon"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon1"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon2"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon3"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon4"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon5"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon6"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon7"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon8"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon9"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon10"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon11"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon12"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon13"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon14"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon15"));
DestroyObject(GetPVarInt(playerid, "neon17"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon16"));
DeletePVar(playerid, "Status");
SetPVarInt(playerid, "Status", 1);
SetPVarInt(playerid, "neon2", CreateObject(18647,0,0,0,0,0,0));
SetPVarInt(playerid, "neon3", CreateObject(18647,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "neon2"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
AttachObjectToVehicle(GetPVarInt(playerid, "neon3"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
SendClientMessage(playerid, 0xFFFFFFAA, "Neon installed {000000}[{FF0000}Red{000000}]");

}
if(listitem == 2)
{
DestroyObject(GetPVarInt(playerid, "neon"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon1"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon2"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon3"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon4"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon5"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon6"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon7"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon8"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon9"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon10"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon11"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon12"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon13"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon14"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon15"));
DestroyObject(GetPVarInt(playerid, "neon17"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon16"));
DeletePVar(playerid, "Status");
SetPVarInt(playerid, "Status", 1);
SetPVarInt(playerid, "neon4", CreateObject(18649,0,0,0,0,0,0));
SetPVarInt(playerid, "neon5", CreateObject(18649,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "neon4"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
AttachObjectToVehicle(GetPVarInt(playerid, "neon5"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
SendClientMessage(playerid, 0xFFFFFFAA, "Neon installed {000000}[{00FF00}Green{000000}]");

}
if(listitem == 3)
{
DestroyObject(GetPVarInt(playerid, "neon"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon1"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon2"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon3"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon4"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon5"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon6"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon7"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon8"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon9"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon10"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon11"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon12"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon13"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon14"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon15"));
DestroyObject(GetPVarInt(playerid, "neon17"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon16"));
DeletePVar(playerid, "Status");
SetPVarInt(playerid, "Status", 1);
SetPVarInt(playerid, "neon6", CreateObject(18652,0,0,0,0,0,0));
SetPVarInt(playerid, "neon7", CreateObject(18652,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "neon6"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
AttachObjectToVehicle(GetPVarInt(playerid, "neon7"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
SendClientMessage(playerid, 0xFFFFFFAA, "Neon installed {000000}[{FFFFFF}White{000000}]");

}
if(listitem == 4)
{
DestroyObject(GetPVarInt(playerid, "neon"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon1"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon2"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon3"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon4"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon5"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon6"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon7"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon8"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon9"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon10"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon11"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon12"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon13"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon14"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon15"));
DestroyObject(GetPVarInt(playerid, "neon17"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon16"));
DeletePVar(playerid, "Status");
SetPVarInt(playerid, "Status", 1);
SetPVarInt(playerid, "neon8", CreateObject(18651,0,0,0,0,0,0));
SetPVarInt(playerid, "neon9", CreateObject(18651,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "neon8"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
AttachObjectToVehicle(GetPVarInt(playerid, "neon9"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
SendClientMessage(playerid, 0xFFFFFFAA, "Neon installed {000000}[{FF00FF}Pink{000000}]");

}
if(listitem == 5)
{
DestroyObject(GetPVarInt(playerid, "neon"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon1"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon2"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon3"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon4"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon5"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon6"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon7"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon8"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon9"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon10"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon11"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon12"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon13"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon14"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon15"));
DestroyObject(GetPVarInt(playerid, "neon17"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon16"));
DeletePVar(playerid, "Status");
SetPVarInt(playerid, "Status", 1);
SetPVarInt(playerid, "neon10", CreateObject(18650,0,0,0,0,0,0));
SetPVarInt(playerid, "neon11", CreateObject(18650,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "neon10"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
AttachObjectToVehicle(GetPVarInt(playerid, "neon11"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
SendClientMessage(playerid, 0xFFFFFFAA, "Neon installed {000000}[{FFFF00}Yellow{000000}]");

}
if(listitem == 6){//remove neon
DestroyObject(GetPVarInt(playerid, "neon"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon1"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon2"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon3"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon4"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon5"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon6"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon7"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon8"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon9"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon10"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon11"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon12"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon13"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon14"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon15"));
DestroyObject(GetPVarInt(playerid, "neon17"));
DeletePVar(playerid, "Status");
DestroyObject(GetPVarInt(playerid, "neon16"));
DeletePVar(playerid, "Status");
}
}
return 1;}
if(!dialogid)
{
if(!response) return SendClientMessage(playerid, red, ".���� ���� �� �������"),SetTimerEx("KickPublic", 50, 0, "d", playerid);
{
if(!strlen(inputtext)) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_PASSWORD, "{FF0000}���� ����", "! ���� ������ ���� ����� ��� 26-4\n\n:��� ����� �� ������ �������", "����", "��");
if(strlen(inputtext) < 4 || strlen(inputtext) > 26) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_PASSWORD, "{FF0000}���� ����", "! ���� ������ ���� ����� ��� 26-4\n\n:��� ����� �� ������ �������", "����", "��");
{
new year, month, day, string[256];
getdate(year, month, day);
format(string, sizeof(string),"%d/%d/%d", day, month, year);
DOF2_CreateFile(SFile(playerid));
DOF2_SetInt(SFile(playerid),"UserID",UserID++);
DOF2_SetInt(ServerStats(),"Users",UserID);
DOF2_SetString(SFile(playerid), "Nick", GetName(playerid));
DOF2_SetString(SFile(playerid), "Password", inputtext);
DOF2_SetString(SFile(playerid), "Date", string);
DOF2_SetString(SFile(playerid),"Email","None");
DOF2_SetInt(SFile(playerid), "ReadRules",0);
DOF2_SetInt(SFile(playerid), "Kills", 0);
DOF2_SetInt(SFile(playerid), "Level", 1);
DOF2_SetString(SFile(playerid), "IP", GetIP(playerid));
DOF2_SetInt(SFile(playerid), "AutoLogin", 1);
DOF2_SetInt(SFile(playerid), "Bank", 0);
DOF2_SetString(SFile(playerid), "PlayerTag", "None");
DOF2_SetString(SFile(playerid), "PlayerHaveTag", "0");
DOF2_SetInt(SFile(playerid),"Radius",100);
DOF2_SetInt(SFile(playerid),"Honor",0);
DOF2_SetInt(SFile(playerid),"Vip",0);
DOF2_SetInt(SFile(playerid),"Supporters",0);
DOF2_SetInt(SFile(playerid),"NightTeam",0);
DOF2_SetInt(SFile(playerid),"Spy",0);
DOF2_SetInt(SFile(playerid),"CarID",0);
DOF2_SetInt(SFile(playerid),"OwnCar",0);
DOF2_SetInt(SFile(playerid),"HaveSkin",0);
DOF2_SetInt(SFile(playerid),"Skin",0);
DOF2_SetInt(SFile(playerid),"HavePos",0);
DOF2_SetInt(SFile(playerid),"IntS",0);
DOF2_SetFloat(SFile(playerid),"FloatX",0);
DOF2_SetFloat(SFile(playerid),"FloatY",0);
DOF2_SetFloat(SFile(playerid),"FloatZ",0);
DOF2_SetString(SFile(playerid),"Clan", "None");
DOF2_SetInt(SFile(playerid),"ClanLevel", 0);
DOF2_SetString(SFile(playerid),"PName","None");
DOF2_SetString(SFile(playerid),"PForum","None");
DOF2_SetString(SFile(playerid),"PCity","None");
DOF2_SetString(SFile(playerid),"PSkype","None");
DOF2_SetString(SFile(playerid),"PMsn","None");
DOF2_SetInt(SFile(playerid),"Golf", 0);
DOF2_SetInt(SFile(playerid),"Knife", 0);
DOF2_SetInt(SFile(playerid),"BaseBall", 0);
DOF2_SetInt(SFile(playerid),"ChineSaw", 0);
DOF2_SetInt(SFile(playerid),"Pistol", 0);
DOF2_SetInt(SFile(playerid),"SPistol", 0);
DOF2_SetInt(SFile(playerid),"Eagle", 1);
DOF2_SetInt(SFile(playerid),"GAmmo", 100);
DOF2_SetInt(SFile(playerid),"ShoutGun", 0);
DOF2_SetInt(SFile(playerid),"Combat", 0);
DOF2_SetInt(SFile(playerid),"Sawn", 0);
DOF2_SetInt(SFile(playerid),"GunAmmo", 0);
DOF2_SetInt(SFile(playerid),"MP5", 0);
DOF2_SetInt(SFile(playerid),"Uzi", 0);
DOF2_SetInt(SFile(playerid),"Tec9", 0);
DOF2_SetInt(SFile(playerid),"AssAmmo", 0);
DOF2_SetInt(SFile(playerid),"M4", 0);
DOF2_SetInt(SFile(playerid),"AK47", 0);
DOF2_SetInt(SFile(playerid),"MaAmmo", 0);
DOF2_SetInt(SFile(playerid),"Country", 0);
DOF2_SetInt(SFile(playerid),"Sniper", 0);
DOF2_SetInt(SFile(playerid),"RilfeAmmo", 0);
DOF2_SetInt(SFile(playerid),"Armour",0);
ShowPlayerDialog(playerid, 2013, DIALOG_STYLE_INPUT, "{FF0000}���� ����", "!������ ������ ������\n��� ���� ����� ����� ������ ����� �����\n����� ������ ����� ����� ����� ������ ������ �������� ����� �����", "����", "���");
//ShowPlayerDialog(playerid, 14, DIALOG_STYLE_MSGBOX, "������ �������", "�����,\n!����� �� ��� ������ ����,��� ��� ����� ������ ������ ����� ������ ������\n\n����� �� ���� ����", "����", "");
}
}
return 1;
}
if(dialogid == 2013)
{
new string[256];
if(!response)
{
DOF2_SetString(SFile(playerid),"Email","None");
for(new C; C < 90; C++) SendClientMessage(playerid,COLOR_WHITE," ");
SendClientMessage(playerid,COLOR_ORANGE," ...���� �����, ��� ����");
SendClientMessage(playerid,0x00FF00FF,"!����� ���� ������");
format(string, sizeof(string), "%d :�����", DOF2_GetInt(SFile(playerid),"UserID"));
SendClientMessage(playerid,0x3399ffff,string);
format(string, sizeof(string), "%s :�����", GetIP(playerid));
SendClientMessage(playerid,0x3399ffff,string);
format(string, sizeof(string), "%s :�� �����", GetName(playerid));
SendClientMessage(playerid,0x3399ffff,string);
format(string, sizeof(string), "%s :������ ���", DOF2_GetString(SFile(playerid),"Password"));
SendClientMessage(playerid,0x3399ffff,string);
format(string, sizeof(string), "%s :�����", DOF2_GetString(SFile(playerid),"Email"));
SendClientMessage(playerid,0x3399ffff,string);
format(string, sizeof(string), "%s :����� ������", DOF2_GetString(SFile(playerid),"Date"));
SendClientMessage(playerid,0x3399ffff,string);
SendClientMessage(playerid,0xFF0000FF, "* ��� ��� ��� �� ���� ��� ����� ���� ��� ������� ���� ���� �� ������");
SendClientMessage(playerid,0xFF9900AA, "/Help - ����� ���/�");
RulesTimer[playerid] = SetTimerEx("Rules", 1000, 0, "dd", playerid, 0);
}
if(!strlen(inputtext)) return ShowPlayerDialog(playerid, 2013, DIALOG_STYLE_INPUT, "{FF0000}���� ����", "!������ ������ ������\n��� ���� ����� ����� ������ ����� �����\n����� ������ ����� ����� ����� ������ ������ �������� ����� �����", "����", "���");
if(!IsValidEmail(inputtext))return ShowPlayerDialog(playerid, 2013, DIALOG_STYLE_INPUT, "{FF0000}���� ����", "!������ ������ ������\n��� ���� ����� ����� ������ ����� �����\n����� ������ ����� ����� ����� ������ ������ �������� ����� �����", "����", "���");
DOF2_SetString(SFile(playerid),"Email",inputtext);
for(new C; C < 90; C++) SendClientMessage(playerid,COLOR_WHITE," ");
SendClientMessage(playerid,COLOR_ORANGE," ...���� �����, ��� ����");
SendClientMessage(playerid,0x00FF00FF,"!����� ���� ������");
format(string, sizeof(string), "%d :�����", DOF2_GetInt(SFile(playerid),"UserID"));
SendClientMessage(playerid,0x3399ffff,string);
format(string, sizeof(string), "%s :�����", GetIP(playerid));
SendClientMessage(playerid,0x3399ffff,string);
format(string, sizeof(string), "%s :�� �����", GetName(playerid));
SendClientMessage(playerid,0x3399ffff,string);
format(string, sizeof(string), "%s :������ ���", DOF2_GetString(SFile(playerid),"Password"));
SendClientMessage(playerid,0x3399ffff,string);
format(string, sizeof(string), "%s :�����", DOF2_GetString(SFile(playerid),"Email"));
SendClientMessage(playerid,0x3399ffff,string);
format(string, sizeof(string), "%s :����� ������", DOF2_GetString(SFile(playerid),"Date"));
SendClientMessage(playerid,0x3399ffff,string);
SendClientMessage(playerid,0xFF0000FF, "* ��� ��� ��� �� ���� ��� ����� ���� ��� ������� ���� ���� �� ������");
SendClientMessage(playerid,0xFF9900AA, "/Help - ����� ���/�");
ShowPlayerDialog(playerid,3,DIALOG_STYLE_MSGBOX,":���� ����","��� ��' 1 - ����� ���'��� / �����\n\n��� ������ ��'���� / ����� ����\n����� ��� ����� �� ��� �� ����� ������� �����","���","");
RulesTimer[playerid] = SetTimerEx("Rules", 1000, 0, "dd", playerid, 0);
new szString2[500];
format(szString2, sizeof(szString2), "���� %s,\n\n������ ������� ����� ������!\n������ ����� ��� ���: %d - ���� ����� �� �����\n\n�����,\n���� DeathMatch SA:MP", GetName(playerid),DOF2_GetInt(SFile(playerid),"UserID"), DOF2_GetString(SFile(playerid),"Password"));
return 1;
}
	if(dialogid == RulesDialog1 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
        GameTextForPlayer(playerid, "~r~YOU HAVE TO WAIT 4 SECONDS BETWEEN RULE AND RULE", 3000, 4);
        SendClientMessage(playerid, Red, ".��� ���� 4 ����� ����� ���� ����");
        ShowPlayerDialog(playerid, RulesDialog1, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 1 - ����� ��'���� / �����\n\n.��� ������ ��'���� / ����� ����\n����� ��� ���� �� ��� �� ����� ������� �����", "����", "");
		return 0;
	}
	if(dialogid == RulesDialog2 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
        GameTextForPlayer(playerid, "~r~YOU HAVE TO WAIT 4 SECONDS BETWEEN RULE AND RULE", 3000, 4);
        SendClientMessage(playerid, Red, ".��� ���� 4 ����� ����� ���� ����");
        ShowPlayerDialog(playerid, RulesDialog2, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 2 - ����� ���� �����\n\n.��� ������ ���� �� �����, ����� ������ ������ ���� �� ����� ���\n.����� ��� ����� �� ��� �� ���� ���� �� ����� ����� ������ �� ����� ����� ����", "�����", "");
		return 0;
	}
	if(dialogid == RulesDialog3 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
        GameTextForPlayer(playerid, "~r~YOU HAVE TO WAIT 4 SECONDS BETWEEN RULE AND RULE", 3000, 4);
        SendClientMessage(playerid, Red, ".��� ���� 4 ����� ����� ���� ����");
        ShowPlayerDialog(playerid, RulesDialog3, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 3 - �����\n\n.��� ����� ���� ����� ����� / ������ / �����\n.����� ��� ����� �� ��� �� ����� ������� �����", "����", "");
		return 0;
	}
	if(dialogid == RulesDialog4 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
        GameTextForPlayer(playerid, "~r~YOU HAVE TO WAIT 4 SECONDS BETWEEN RULE AND RULE", 3000, 4);
        SendClientMessage(playerid, Red, ".��� ���� 4 ����� ����� ���� ����");
        ShowPlayerDialog(playerid, RulesDialog4, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 4 - �������\n\n��� ����� �� ���� ��'�� ����\n/Report [id] [reason] :���� ����� �� ���� �������� ������ ������\n.����� ������ �� ����� �� ������ �� ����� ���� ����� ����� ����� ���� ���� �������� ����� ����", "����", "");
		return 0;
	}
	if(dialogid == RulesDialog5 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
        GameTextForPlayer(playerid, "~r~YOU HAVE TO WAIT 4 SECONDS BETWEEN RULE AND RULE", 3000, 4);
        SendClientMessage(playerid, Red, ".��� ���� 4 ����� ����� ���� ����");
        ShowPlayerDialog(playerid, RulesDialog5, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 5 - ������ ����\n\n!��� ���� ����� �� ���� ��� ���� �� ������\n.����� ���� ������ ����� �� ���� ��� ��� ���� �� ������ ����� �� ���� ����� ������ ���� ����\n.����� ���� ����� ���� ��� ���� �� ������ ����� ���� ���", "����", "");
		return 0;
	}
	if(dialogid == RulesDialog6 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
        GameTextForPlayer(playerid, "~r~YOU HAVE TO WAIT 4 SECONDS BETWEEN RULE AND RULE", 3000, 4);
        SendClientMessage(playerid, Red, ".��� ���� 4 ����� ����� ���� ����");
        ShowPlayerDialog(playerid, RulesDialog6, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 6 - ����� ���\n\n.���� �� ����� ������� ����\n.����� �� ���� ����� ���� �� ���� ��� ������ ����� ���� ����� ���� �''� ����� �� ������� ���\n.����� ����� ��� ��� ������� ���� ������ ������ ������", "����", "");
		return 0;
	}
	if(dialogid == RulesDialog7 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
        GameTextForPlayer(playerid, "~r~YOU HAVE TO WAIT 4 SECONDS BETWEEN RULE AND RULE", 3000, 4);
        SendClientMessage(playerid, Red, ".��� ���� 4 ����� ����� ���� ����");
        ShowPlayerDialog(playerid, RulesDialog7, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 7 - ����\n\n.���� ��� ����� �� ������ �����: �����\n.������ ���� ��� �������� ������ �� ������� ����� ������ ����� ���� ���, �������, ����� ����\n.����� ������ ����� �� ��� �� ��� ���", "����", "");
		return 0;
	}
	if(dialogid == RulesDialog8 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
        GameTextForPlayer(playerid, "~r~YOU HAVE TO WAIT 4 SECONDS BETWEEN RULE AND RULE", 3000, 4);
        SendClientMessage(playerid, Red, ".��� ���� 4 ����� ����� ���� ����");
        ShowPlayerDialog(playerid, RulesDialog8, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 8 - ����� ������\n\n.����� ������ ������� ��� ���� ������ ������, ����� �������� ������ ����� ������ ��� ����� ���� �� ��-�������\n.�����, ����� ������ ����� ������� ������� ��'�����, ������ �� ���� �� ��� ����� ��'�� �� ���\n.����� ������ ��� ���� �� ��� �� ��� ���", "����", "");
		return 0;
	}
	if(dialogid == RulesDialog9 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
        GameTextForPlayer(playerid, "~r~YOU HAVE TO WAIT 4 SECONDS BETWEEN RULE AND RULE", 3000, 4);
        SendClientMessage(playerid, Red, ".��� ���� 4 ����� ����� ���� ����");
        ShowPlayerDialog(playerid, RulesDialog9, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 9 - ����� �����\n\n.���� ����� ������� ����� ������ ������, ������ ������ ����� ���� �� ����� ����, ��� ���� ��� ���\n.����� ������ ���, ����� ���� ������ �����\n.��� ����� ����� ����� ������ ��� ���� ����� ��� ����� �� ��� �� ���� ���� ���", "����", "");
		return 0;
	}
	if(dialogid == RulesDialog10 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
        GameTextForPlayer(playerid, "~r~YOU HAVE TO WAIT 4 SECONDS BETWEEN RULE AND RULE", 3000, 4);
        SendClientMessage(playerid, Red, ".��� ���� 4 ����� ����� ���� ����");
        ShowPlayerDialog(playerid, RulesDialog10, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 10 - ����� ������\n\n!��� ����� �� ������ ��� ��� ����\n.��� ����� ����� �� ��� �� ������ ��� ���� ����� ���� ���", "����", "");
		return 0;
	}
	if(dialogid == RulesDialog11 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
        GameTextForPlayer(playerid, "~r~YOU HAVE TO WAIT 4 SECONDS BETWEEN RULE AND RULE", 3000, 4);
        SendClientMessage(playerid, Red, ".��� ���� 4 ����� ����� ���� ����");
        ShowPlayerDialog(playerid, RulesDialog11, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 11 - ����� ������ ����� ��'��\n\n.��'�� ��� �� ��� ������\n.����� ��� ����� �� ��� �� ���� ����", "����", "");
		return 0;
	}
	if(dialogid == RulesDialog12 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
        GameTextForPlayer(playerid, "~r~YOU HAVE TO WAIT 4 SECONDS BETWEEN RULE AND RULE", 3000, 4);
        SendClientMessage(playerid, Red, ".��� ���� 4 ����� ����� ���� ����");
        ShowPlayerDialog(playerid, RulesDialog12, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 12 - ����� ���\n\n!��� ����� ���� ���� ��� ���� �� ���� ���� ��� �����\n.���� ����� ����� ���� ���� ���� ����\n.����� ��� ����� �� ��� �� ���� �� ��� ������ / �����", "����", "");
		return 0;
	}
	if(dialogid == RulesDialog13 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
        GameTextForPlayer(playerid, "~r~YOU HAVE TO WAIT 4 SECONDS BETWEEN RULE AND RULE", 3000, 4);
        SendClientMessage(playerid, Red, ".��� ���� 4 ����� ����� ���� ����");
        ShowPlayerDialog(playerid, RulesDialog13, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 13 - ����� ���\n\n.����� �� ���� / ���� / ��� �� �� ��� �� ��� ����� ��� ��� ���� ����� ��� ������� �����\n��� ���� ����� ��� ������� �����: �������, ������ ����� �������� ������\n.����� ����� �� ��� �� ��� ���", "����", "");
		return 0;
	}
	if(dialogid == RulesDialog14 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
        GameTextForPlayer(playerid, "~r~YOU HAVE TO WAIT 4 SECONDS BETWEEN RULE AND RULE", 3000, 4);
        SendClientMessage(playerid, Red, ".��� ���� 4 ����� ����� ���� ����");
        ShowPlayerDialog(playerid, RulesDialog14, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 14 - �'�����\n\n.����� ��������� ��� ����� ����� ������ ���� ����� - (Joypad) �'�����\n.������ ������ �������� ���� ���� ���� ����� ����� �� ��� ����� ����\n.����� ����� �� ��� �� ��� ���", "����", "");
		return 0;
	}
	if(dialogid == RulesDialog15 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0)if(response) return ShowPlayerDialog(playerid, RulesDialog16, DIALOG_STYLE_MSGBOX, "���� ����", ",�����\n!����� �� ��� ������ ����, ��� ��� ����� ������ ����� �� ����� ����\n\n!����� �� ���� ����", "����", "");
	if(dialogid == RulesDialog16 && DOF2_GetInt(SFile(playerid), "ReadRules") == 0) if(response) return DOF2_SetInt(SFile(playerid), "ReadRules", 1),SendFormatMessageToAll(0x00FF00FF,"���� ���� %s �����", GetName(playerid)),Logged[playerid] = 1,BlockChat[playerid] = 0;
if(dialogid == 1)
        {
				if(!response) return SetTimerEx("KickPublic", 50, 0, "d", playerid);
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"�������","{ff0000}!�� ����� �����\n{ffffff}:��� ���� �� ������ ���� �����","�����","�����");
               if(!strcmp(DOF2_GetString(SFile(playerid),"Password"),inputtext,false))
                {
                    new playerip[16];
                    GetPlayerIp(playerid, playerip, 16);
                    DOF2_SetString(SFile(playerid),"IP",playerip);
                    KillTimer(stimer);
					SendFormatMessageToAll(0x00FF00FF, "����� ���� %s �����", GetName(playerid));
					Logged[playerid] = 2;
					BlockChat[playerid] = 0;
					if(DOF2_GetInt(SFile(playerid), "ReadRules") == 0) return RulesTimer[playerid] = SetTimerEx("Rules", 1000, 0, "dd", playerid, 0);
                }else{
				FailureLogin[playerid]++;
                        if(FailureLogin[playerid] < MAX_FAILURE_LOGINS)
                        {
                                format(SString,sizeof(SString),"(%d/%d) ������ ����� �����\n\n:��� ����/� �� ������ �������",FailureLogin[playerid], MAX_FAILURE_LOGINS);
                                ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"�������",SString,"�����","�����");
                        }
                        else SendClientMessage(playerid, 0xFF0000AA, "����� �� �� ��������� ���� ����� ���."),SetTimerEx("KickPublic", 50, 0, "d", playerid);
                }
return 1;}

if(dialogid == 22){
if(response)
{
if(listitem == 0) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 0)return WeaponLevelError(playerid,0);
if(GetPlayerMoney(playerid) < GolfP)return WeaponMoneyError(playerid,GolfP);
if(DOF2_GetInt(SFile(playerid),"Golf") == 1){DOF2_SetInt(SFile(playerid),"Golf", 0);}
if(DOF2_GetInt(SFile(playerid),"BaseBall") == 1){DOF2_SetInt(SFile(playerid),"BaseBall", 0);}
if(DOF2_GetInt(SFile(playerid),"Knife") == 1){DOF2_SetInt(SFile(playerid),"Knife", 0);}
if(DOF2_GetInt(SFile(playerid),"ChineSaw") == 1){DOF2_SetInt(SFile(playerid),"ChineSaw", 0);}
DOF2_SetInt(SFile(playerid),"Golf", 1);
GivePlayerMoney(playerid,-GolfP);
GivePlayerWeapon(playerid,2,1);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 1) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 0)return WeaponLevelError(playerid,0);
if(GetPlayerMoney(playerid) < BaseBallP)return WeaponMoneyError(playerid,BaseBallP);
if(DOF2_GetInt(SFile(playerid),"Golf") == 1){DOF2_SetInt(SFile(playerid),"Golf", 0);}
if(DOF2_GetInt(SFile(playerid),"BaseBall") == 1){DOF2_SetInt(SFile(playerid),"BaseBall", 0);}
if(DOF2_GetInt(SFile(playerid),"Knife") == 1){DOF2_SetInt(SFile(playerid),"Knife", 0);}
if(DOF2_GetInt(SFile(playerid),"ChineSaw") == 1){DOF2_SetInt(SFile(playerid),"ChineSaw", 0);}
DOF2_SetInt(SFile(playerid),"BaseBall", 1);
GivePlayerMoney(playerid,-BaseBallP);
GivePlayerWeapon(playerid,5,1);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 2) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 0)return WeaponLevelError(playerid,0);
if(GetPlayerMoney(playerid) < KnifeP)return WeaponMoneyError(playerid,KnifeP);
if(DOF2_GetInt(SFile(playerid),"Golf") == 1){DOF2_SetInt(SFile(playerid),"Golf", 0);}
if(DOF2_GetInt(SFile(playerid),"BaseBall") == 1){DOF2_SetInt(SFile(playerid),"BaseBall", 0);}
if(DOF2_GetInt(SFile(playerid),"Knife") == 1){DOF2_SetInt(SFile(playerid),"Knife", 0);}
if(DOF2_GetInt(SFile(playerid),"ChineSaw") == 1){DOF2_SetInt(SFile(playerid),"ChineSaw", 0);}
DOF2_SetInt(SFile(playerid),"Knife", 1);
GivePlayerMoney(playerid,-KnifeP);
GivePlayerWeapon(playerid,4,1);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem ==3) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 0)return WeaponLevelError(playerid,0);
if(GetPlayerMoney(playerid) < SawP)return WeaponMoneyError(playerid,SawP);
if(DOF2_GetInt(SFile(playerid),"Golf") == 1){DOF2_SetInt(SFile(playerid),"Golf", 0);}
if(DOF2_GetInt(SFile(playerid),"BaseBall") == 1){DOF2_SetInt(SFile(playerid),"BaseBall", 0);}
if(DOF2_GetInt(SFile(playerid),"Knife") == 1){DOF2_SetInt(SFile(playerid),"Knife", 0);}
if(DOF2_GetInt(SFile(playerid),"ChineSaw") == 1){DOF2_SetInt(SFile(playerid),"ChineSaw", 0);}
DOF2_SetInt(SFile(playerid),"ChineSaw", 1);
GivePlayerMoney(playerid,-SawP);
GivePlayerWeapon(playerid,9,1);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 4) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 0)return WeaponLevelError(playerid,0);
if(GetPlayerMoney(playerid) < PistolP)return WeaponMoneyError(playerid,PistolP);
if(DOF2_GetInt(SFile(playerid),"Pistol") == 1){ DOF2_SetInt(SFile(playerid),"Pistol", 0);}
if(DOF2_GetInt(SFile(playerid),"SPistol") == 1){ DOF2_SetInt(SFile(playerid),"SPistol", 0);}
if(DOF2_GetInt(SFile(playerid),"Eagle") == 1){ DOF2_SetInt(SFile(playerid),"Eagle", 0);}
DOF2_SetInt(SFile(playerid),"Pistol", 1);
DOF2_SetInt(SFile(playerid),"GAmmo",DOF2_GetInt(SFile(playerid),"GAmmo") + PistolA);
GivePlayerMoney(playerid,-PistolP);
GivePlayerWeapon(playerid,22,PistolA);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 5) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 0)return WeaponLevelError(playerid,0);
if(GetPlayerMoney(playerid) < SPistolP)return WeaponMoneyError(playerid,SPistolP);
if(DOF2_GetInt(SFile(playerid),"Pistol") == 1){ DOF2_SetInt(SFile(playerid),"Pistol", 0);}
if(DOF2_GetInt(SFile(playerid),"SPistol") == 1){ DOF2_SetInt(SFile(playerid),"SPistol", 0);}
if(DOF2_GetInt(SFile(playerid),"Eagle") == 1){ DOF2_SetInt(SFile(playerid),"Eagle", 0);}
DOF2_SetInt(SFile(playerid),"SPistol", 1);
DOF2_SetInt(SFile(playerid),"GAmmo", DOF2_GetInt(SFile(playerid),"GAmmo") + SPistolA);
GivePlayerMoney(playerid,-SPistolP);
GivePlayerWeapon(playerid,23,SPistolA);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 6) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 0)return WeaponLevelError(playerid,0);
if(GetPlayerMoney(playerid) < EagleP)return WeaponMoneyError(playerid,EagleP);
if(DOF2_GetInt(SFile(playerid),"Pistol") == 1){ DOF2_SetInt(SFile(playerid),"Pistol", 0);}
if(DOF2_GetInt(SFile(playerid),"SPistol") == 1){ DOF2_SetInt(SFile(playerid),"SPistol", 0);}
if(DOF2_GetInt(SFile(playerid),"Eagle") == 1){ DOF2_SetInt(SFile(playerid),"Eagle", 0);}
DOF2_SetInt(SFile(playerid),"Eagle", 1);
DOF2_SetInt(SFile(playerid),"GAmmo", DOF2_GetInt(SFile(playerid),"GAmmo") + EagleA);
GivePlayerMoney(playerid,-EagleP);
GivePlayerWeapon(playerid,24,EagleA);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 7) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 1)return WeaponLevelError(playerid,1);
if(GetPlayerMoney(playerid) < ShoutGunP)return WeaponMoneyError(playerid,ShoutGunP);
if(DOF2_GetInt(SFile(playerid),"ShoutGun") == 1){DOF2_SetInt(SFile(playerid),"ShoutGun", 0);}
if(DOF2_GetInt(SFile(playerid),"Combat") == 1){DOF2_SetInt(SFile(playerid),"Combat", 0);}
if(DOF2_GetInt(SFile(playerid),"Sawn") == 1){DOF2_SetInt(SFile(playerid),"Sawn", 0);}
DOF2_SetInt(SFile(playerid),"ShoutGun", 1);
DOF2_SetInt(SFile(playerid),"GunAmmo",DOF2_GetInt(SFile(playerid),"GunAmmo") + ShoutGunA);
GivePlayerMoney(playerid,-ShoutGunP);
GivePlayerWeapon(playerid,25,ShoutGunA);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 8) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 1)return WeaponLevelError(playerid,1);
if(GetPlayerMoney(playerid) < CombatP)return WeaponMoneyError(playerid,CombatP);
if(DOF2_GetInt(SFile(playerid),"ShoutGun") == 1){DOF2_SetInt(SFile(playerid),"ShoutGun", 0);}
if(DOF2_GetInt(SFile(playerid),"Combat") == 1){DOF2_SetInt(SFile(playerid),"Combat", 0);}
if(DOF2_GetInt(SFile(playerid),"Sawn") == 1){DOF2_SetInt(SFile(playerid),"Sawn", 0);}
DOF2_SetInt(SFile(playerid),"Combat", 1);
DOF2_SetInt(SFile(playerid),"GunAmmo",DOF2_GetInt(SFile(playerid),"GunAmmo") + CombatA);
GivePlayerMoney(playerid,-CombatP);
GivePlayerWeapon(playerid,27,CombatA);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 9) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 1)return WeaponLevelError(playerid,1);
if(GetPlayerMoney(playerid) < SawnP)return WeaponMoneyError(playerid,SawnP);
if(DOF2_GetInt(SFile(playerid),"ShoutGun") == 1){DOF2_SetInt(SFile(playerid),"ShoutGun", 0);}
if(DOF2_GetInt(SFile(playerid),"Combat") == 1){DOF2_SetInt(SFile(playerid),"Combat", 0);}
if(DOF2_GetInt(SFile(playerid),"Sawn") == 1){DOF2_SetInt(SFile(playerid),"Sawn", 0);}
DOF2_SetInt(SFile(playerid),"Sawn", 1);
DOF2_SetInt(SFile(playerid),"GunAmmo",DOF2_GetInt(SFile(playerid),"GunAmmo") + SawnA);
GivePlayerMoney(playerid,-SawnP);
GivePlayerWeapon(playerid,26,SawnA);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 10) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 2)return WeaponLevelError(playerid,2);
if(GetPlayerMoney(playerid) < MP5P)return WeaponMoneyError(playerid,MP5P);
if(DOF2_GetInt(SFile(playerid),"MP5") == 1){ DOF2_SetInt(SFile(playerid),"MP5", 0);}
if(DOF2_GetInt(SFile(playerid),"Uzi") == 1){ DOF2_SetInt(SFile(playerid),"Uzi", 0);}
if(DOF2_GetInt(SFile(playerid),"Tec9") == 1){ DOF2_SetInt(SFile(playerid),"Tec9", 0);}
DOF2_SetInt(SFile(playerid),"MP5", 1);
DOF2_SetInt(SFile(playerid),"AssAmmo", DOF2_GetInt(SFile(playerid),"AssAmmo") + MP5A);
GivePlayerMoney(playerid,-MP5P);
GivePlayerWeapon(playerid,29,MP5A);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 11) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 2)return WeaponLevelError(playerid,2);
if(GetPlayerMoney(playerid) < UziP)return WeaponMoneyError(playerid,UziP);
if(DOF2_GetInt(SFile(playerid),"MP5") == 1){ DOF2_SetInt(SFile(playerid),"MP5", 0);}
if(DOF2_GetInt(SFile(playerid),"Uzi") == 1){ DOF2_SetInt(SFile(playerid),"Uzi", 0);}
if(DOF2_GetInt(SFile(playerid),"Tec9") == 1){ DOF2_SetInt(SFile(playerid),"Tec9", 0);}
DOF2_SetInt(SFile(playerid),"Uzi", 1);
DOF2_SetInt(SFile(playerid),"AssAmmo", DOF2_GetInt(SFile(playerid),"AssAmmo") + UziA);
GivePlayerMoney(playerid,-UziP);
GivePlayerWeapon(playerid,28,UziA);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 12) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 2)return WeaponLevelError(playerid,2);
if(GetPlayerMoney(playerid) < Tec9P)return WeaponMoneyError(playerid,Tec9P);
if(DOF2_GetInt(SFile(playerid),"MP5") == 1){ DOF2_SetInt(SFile(playerid),"MP5", 0);}
if(DOF2_GetInt(SFile(playerid),"Uzi") == 1){ DOF2_SetInt(SFile(playerid),"Uzi", 0);}
if(DOF2_GetInt(SFile(playerid),"Tec9") == 1){ DOF2_SetInt(SFile(playerid),"Tec9", 0);}
DOF2_SetInt(SFile(playerid),"Tec9", 1);
DOF2_SetInt(SFile(playerid),"AssAmmo", DOF2_GetInt(SFile(playerid),"AssAmmo") + Tec9A);
GivePlayerMoney(playerid,-Tec9P);
GivePlayerWeapon(playerid,32,Tec9A);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 13){
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 3)return WeaponLevelError(playerid,3);
if(GetPlayerMoney(playerid) < M4P)return WeaponMoneyError(playerid,M4P);
if(DOF2_GetInt(SFile(playerid),"M4") == 1){ DOF2_SetInt(SFile(playerid),"M4", 0);}
if(DOF2_GetInt(SFile(playerid),"AK47") == 1){ DOF2_SetInt(SFile(playerid),"AK47", 0);}
DOF2_SetInt(SFile(playerid),"M4", 1);
DOF2_SetInt(SFile(playerid),"MaAmmo", DOF2_GetInt(SFile(playerid),"MaAmmo") + M4A);
GivePlayerMoney(playerid,-M4P);
GivePlayerWeapon(playerid,31,M4A);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 14) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 3)return WeaponLevelError(playerid,3);
if(GetPlayerMoney(playerid) < AK47P)return WeaponMoneyError(playerid,AK47P);
if(DOF2_GetInt(SFile(playerid),"AK47") == 1){ DOF2_SetInt(SFile(playerid),"AK47", 0);}
DOF2_SetInt(SFile(playerid),"AK47", 1);
DOF2_SetInt(SFile(playerid),"MaAmmo", DOF2_GetInt(SFile(playerid),"MaAmmo") + AK47A);
GivePlayerMoney(playerid,-AK47P);
GivePlayerWeapon(playerid,30,AK47A);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 15) {
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 4)return WeaponLevelError(playerid,4);
if(GetPlayerMoney(playerid) < CountryP)return WeaponMoneyError(playerid,CountryP);
if(DOF2_GetInt(SFile(playerid),"Sniper") == 1){ DOF2_SetInt(SFile(playerid),"Sniper", 0);}
if(DOF2_GetInt(SFile(playerid),"Country") == 1){ DOF2_SetInt(SFile(playerid),"Country", 0);}
DOF2_SetInt(SFile(playerid),"Country", 1);
DOF2_SetInt(SFile(playerid),"RilfeAmmo", DOF2_GetInt(SFile(playerid),"RilfeAmmo") + CountryA);
GivePlayerMoney(playerid,-CountryP);
GivePlayerWeapon(playerid,33,CountryA);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
if(listitem == 16){
if(!CPS_IsPlayerInCheckpoint(playerid,CP_Ammu))return SendClientMessage(playerid,red, ".��� ���� ����� ����� ������ �� ��� ������ ������ ��");
if(DOF2_GetInt(SFile(playerid),"Level") < 4)return WeaponLevelError(playerid,4);
if(GetPlayerMoney(playerid) < SniperP)return WeaponMoneyError(playerid,SniperP);
if(DOF2_GetInt(SFile(playerid),"Sniper") == 1){ DOF2_SetInt(SFile(playerid),"Sniper", 0);}
if(DOF2_GetInt(SFile(playerid),"Country") == 1){ DOF2_SetInt(SFile(playerid),"Country", 0);}
DOF2_SetInt(SFile(playerid),"Sniper", 1);
DOF2_SetInt(SFile(playerid),"RilfeAmmo", DOF2_GetInt(SFile(playerid),"RilfeAmmo") + SniperA);
GivePlayerMoney(playerid,-SniperP);
GivePlayerWeapon(playerid,34,SniperA);
format(AmmoString,sizeof(AmmoString),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",Text1,Text2,Text3,Text4,Text5,Text6,Text7,Text8,Text9,Text10,Text11,Text12,Text13,Text14,Text15,Text16,Text17),ShowPlayerDialog(playerid,22,DIALOG_STYLE_LIST,"����� �����",AmmoString,"���","��");
}
}
return 1;}
//Settings
if(dialogid == 2500){
if(response){
if(listitem == 0) return ShowPlayerDialog(playerid,2501,DIALOG_STYLE_LIST,"������ ������","����\r\n���","���","����");
if(listitem == 1) return ShowPlayerDialog(playerid,2502,DIALOG_STYLE_LIST,"����� ��� ����","��� �����\r\n��� ����\r\n��� ����� �����\r\n����� ���","���","����");
if(listitem == 2) return ShowPlayerDialog(playerid,2503,DIALOG_STYLE_LIST,"�������� ��'��","����\r\n���","���","����");
if(listitem == 3) return ShowPlayerDialog(playerid,2504,DIALOG_STYLE_LIST,"�������� ����","��� ����\r\n��� �� �����\r\n��� ����� �����","���","����");
if(listitem == 4) return ShowPlayerDialog(playerid,2505,DIALOG_STYLE_LIST,"������� ��������","����\r\n���","���","����");
if(listitem == 5) return ShowPlayerDialog(playerid,2506,DIALOG_STYLE_LIST,"����� ������","����\r\n���","���","����");
if(listitem == 6) return ShowPlayerDialog(playerid,2666,DIALOG_STYLE_LIST,"����� ���� ����","�� ����\r\n�� ����� ������\r\n��� ������\r\n�����\r\n����'�","���","����");
if(listitem == 7) return ShowPlayerDialog(playerid,2507,DIALOG_STYLE_MSGBOX,"����� ������","��� ��� ���� ������� ���� �� �� ������� ���?","���","����");
}
return 1;}

if(dialogid == 2501){
if(!response)return ShowPlayerDialog(playerid,2500,DIALOG_STYLE_LIST,"Settings","������ ������\r\n����� ��� ����\r\n�������� ��'��\r\n�������� ����\r\n������� ��������\r\n����� ������\r\n����� ������","���","�����");
{
if(listitem == 0) return SendClientMessage(playerid,0x00FF00FF,".����� �� ������� �������"),BlockPm[playerid] = 0;
if(listitem == 1) return SendClientMessage(playerid,0x00FF00FF,".���� �� ������� �������"),BlockPm[playerid] = 1;
}
return 1;}

if(dialogid == 2502){
if(!response)return ShowPlayerDialog(playerid,2500,DIALOG_STYLE_LIST,"Settings","������ ������\r\n����� ��� ����\r\n�������� ��'��\r\n�������� ����\r\n������� ��������\r\n����� ������\r\n����� ������","���","�����");
{
if(listitem == 0){
if(!IsPlayerHonor(playerid))return ShowPlayerDialog(playerid,2508,DIALOG_STYLE_MSGBOX,"Honor Tag","Honor ��� ��","���","����");
if(DOF2_GetInt(SFile(playerid), "PlayerHaveTag") == 1)return ShowPlayerDialog(playerid,2508,DIALOG_STYLE_MSGBOX,"Tag","��� ���� �� ���, ��� ��� �� ���� ��� ���� ��� ���� ������� ��","���","����");
DOF2_SetString(SFile(playerid), "PlayerTag","Honor");
if(DOF2_GetInt(SFile(playerid), "PlayerHaveTag") == 0){ DOF2_SetInt(SFile(playerid), "HaveTag", 1);}
}
if(listitem == 1){
ShowPlayerDialog(playerid,2510,DIALOG_STYLE_MSGBOX,"����� ��� ���� - ���","! ������� ������� ���� 15 �����","�����","����");
	if(GetPlayerLevel(playerid) == 15){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Above average"); }
	if(GetPlayerLevel(playerid) == 16){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Distingushed"); }
	if(GetPlayerLevel(playerid) == 17){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Idol"); }
	if(GetPlayerLevel(playerid) == 18){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Legendary"); }
	if(GetPlayerLevel(playerid) == 19){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Swordsman"); }
	if(GetPlayerLevel(playerid) == 20){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Gunslinger"); }
	if(GetPlayerLevel(playerid) == 21){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Professional"); }
	if(GetPlayerLevel(playerid) == 22){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Master Pro"); }
	if(GetPlayerLevel(playerid) == 23){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Hitman"); }
	if(GetPlayerLevel(playerid) == 24){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Veteran"); }
	if(GetPlayerLevel(playerid) == 25){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Hardcore"); }
	if(GetPlayerLevel(playerid) == 26){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Marksman"); }
	if(GetPlayerLevel(playerid) == 27){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Vicious"); }
	if(GetPlayerLevel(playerid) == 28){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Insane"); }
	if(GetPlayerLevel(playerid) == 29){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","Gladiator"); }
	if(GetPlayerLevel(playerid) == 30){ DOF2_SetInt(SFile(playerid),"PlayerHaveTag",1);DOF2_SetString(SFile(playerid),"PlayerTag","God !"); }
	ShowPlayerDialog(playerid,2510,DIALOG_STYLE_MSGBOX,"����� ��� ���� - ���","! ���� ��� ���� ������ ����� ���� ��� ����","�����","����");
}
if(listitem == 2){
if(DOF2_GetInt(SFile(playerid), "Level") < 32 && !IsPlayerHonor(playerid) && !IsPlayerVip(playerid))return ShowPlayerDialog(playerid,2508,DIALOG_STYLE_MSGBOX,"Tag","������ �� ����� ���� 32","���","����");
if(DOF2_GetInt(SFile(playerid), "PlayerHaveTag") == 1)return ShowPlayerDialog(playerid,2508,DIALOG_STYLE_MSGBOX,"Tag","��� ���� �� ���, ��� ��� �� ���� ��� ���� ��� ���� ������� ��","���","����");
ShowPlayerDialog(playerid,2509,DIALOG_STYLE_INPUT,"Tag","��� ���� �� ���� ������� ����","���","����");
}
if(listitem == 3){
ShowPlayerDialog(playerid,2508,DIALOG_STYLE_MSGBOX,"Tag","����� �� ���� ��� ������","���","����");
if(DOF2_GetInt(SFile(playerid), "PlayerHaveTag") == 1){ DOF2_SetInt(SFile(playerid), "PlayerHaveTag", 0);}
}
}
return 1;}
if(dialogid == 2503){
if(!response)return ShowPlayerDialog(playerid,2500,DIALOG_STYLE_LIST,"Settings","������ ������\r\n����� ��� ����\r\n�������� ��'��\r\n�������� ����\r\n������� ��������\r\n����� ������\r\n����� ������","���","�����");
{
if(listitem == 0) return SendClientMessage(playerid,0x00FF00FF,".��� ���� ���� �� ��'��"),BlockChat[playerid] = 0;
if(listitem == 1) return SendClientMessage(playerid,0x00FF00FF,".���� �� ��'�� ��� ���� ����� �� ����� ��"),BlockChat[playerid] = 1;
}
return 1;}
if(dialogid == 2509){
if(response)ShowPlayerDialog(playerid,2510,DIALOG_STYLE_MSGBOX,"Tag","����� ��� ������","���","");
DOF2_SetString(SFile(playerid), "PlayerTag", inputtext);
if(DOF2_GetInt(SFile(playerid), "PlayerHaveTag") == 0){ DOF2_SetInt(SFile(playerid), "PlayerHaveTag", 1);}
}
if(dialogid == 2504){
if(!response)return ShowPlayerDialog(playerid,2500,DIALOG_STYLE_LIST,"Settings","������ ������\r\n����� ��� ����\r\n�������� ��'��\r\n�������� ����\r\n������� ��������\r\n����� ������\r\n����� ������","���","�����");
{
if(listitem == 0){
}
if(listitem == 1){
   if(strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None",true))
   {
   new r = DOF2_GetInt(GetClanFile(DOF2_GetString(SFile(playerid),"Clan")),"R");
   new g = DOF2_GetInt(GetClanFile(DOF2_GetString(SFile(playerid),"Clan")),"G");
   new b = DOF2_GetInt(GetClanFile(DOF2_GetString(SFile(playerid),"Clan")),"B");
   if(r != -1 && g != -1 && b != -1)SetPlayerColor(playerid,rgba2hex(r,g,b,100));
   new file[256];
   format(file,256,"Clans/%s.ini",DOF2_GetString(SFile(playerid),"Clan"));
   }
}
}
return 1;}
if(dialogid == 2503){
if(!response)return ShowPlayerDialog(playerid,2500,DIALOG_STYLE_LIST,"Settings","������ ������\r\n����� ��� ����\r\n�������� ��'��\r\n�������� ����\r\n������� ��������\r\n����� ������\r\n����� ������","���","�����");
{
if(listitem == 0) return SendClientMessage(playerid,0x00FF00FF,".����� �� ������� �������"),BlockPm[playerid] = 0;
if(listitem == 1) return SendClientMessage(playerid,0x00FF00FF,".���� �� ������� �������"),BlockPm[playerid] = 1;
}
return 1;}

if(dialogid == 2505){
if(listitem == 0){
if(DOF2_GetInt(SFile(playerid),"AutoLogin") == 0){DOF2_SetInt(SFile(playerid),"AutoLogin",1);}
SendClientMessage(playerid,0x00FF00FF,".����� �� �������� ���������");
}
if(listitem == 1){
if(DOF2_GetInt(SFile(playerid),"AutoLogin") == 1){DOF2_SetInt(SFile(playerid),"AutoLogin",0);}
SendClientMessage(playerid,0x00FF00FF,".����� �� �������� ���������");
}
return 1;}

if(dialogid == 2667){
if(!response)return ShowPlayerDialog(playerid,2666,DIALOG_STYLE_LIST,"Settings","������ ������\r\n����� ��� ����\r\n�������� ��'��\r\n�������� ����\r\n������� ��������\r\n����� ������\r\n����� ������","���","�����");
{
if(listitem == 0) return ShowPlayerDialog(playerid,2600, DIALOG_STYLE_INPUT, "����� �� ����", "��� ���� �� ��� ����� ���", "����", "����");
if(listitem == 1) return ShowPlayerDialog(playerid,2601, DIALOG_STYLE_INPUT, "����� �� ����� ������", "��� ���� �� ��� ����� ��� ������", "����", "����");
if(listitem == 2) return ShowPlayerDialog(playerid,2602, DIALOG_STYLE_INPUT, "����� ��� ������", "��� ���� �� ���� ���", "����", "����");
if(listitem == 3) return ShowPlayerDialog(playerid,2603, DIALOG_STYLE_INPUT, "����� ����'�", "��� ���� �� ����� �����'� ���", "����", "����");
if(listitem == 4) return ShowPlayerDialog(playerid,2604, DIALOG_STYLE_INPUT, "����� �� ����", "��� ���� �� ����� ������ ���", "����", "����");
}
return 1;}
if(dialogid == 2600){
if(!response)return ShowPlayerDialog(playerid,2508,DIALOG_STYLE_LIST,"����� ���� ����","�� ����\r\n�� ����� ������\r\n��� ������\r\n����'�\r\n�����","���","����");
{
DOF2_SetString(SFile(playerid), "PName", inputtext);
new PInfo[256];
format(PInfo, sizeof(PInfo), "!��� ���� ��� ����� ������\n%s :��� ���� ��� ���",inputtext);
ShowPlayerDialog(playerid,2666,DIALOG_STYLE_MSGBOX,"����� �� ����",PInfo,"����","�����");
} return 1;}
if(dialogid == 2601){
if(!response)return ShowPlayerDialog(playerid,2508,DIALOG_STYLE_LIST,"����� ���� ����","�� ����\r\n�� ����� ������\r\n��� ������\r\n����'�\r\n�����","���","����");
{
DOF2_SetString(SFile(playerid), "PForum", inputtext);
new PInfo[256];
format(PInfo, sizeof(PInfo), "!�� ������ ��� ������ ����� ������\n%s :��� ������ ���� ��� ��� ���",inputtext);
ShowPlayerDialog(playerid,2666,DIALOG_STYLE_MSGBOX,"����� �� ����� ������",PInfo,"����","�����");
} return 1;}
if(dialogid == 2602){
if(!response)return ShowPlayerDialog(playerid,2508,DIALOG_STYLE_LIST,"����� ���� ����","�� ����\r\n�� ����� ������\r\n��� ������\r\n����'�\r\n�����","���","����");
{
DOF2_SetString(SFile(playerid), "PCity", inputtext);
new PInfo[256];
format(PInfo, sizeof(PInfo), "!��� ������� ��� ������ ������\n%s :��� ������� ��� ���",inputtext);
ShowPlayerDialog(playerid,2666,DIALOG_STYLE_MSGBOX,"����� ��� ������",PInfo,"����","�����");
} return 1;}
if(dialogid == 2603){
if(!response)return ShowPlayerDialog(playerid,2508,DIALOG_STYLE_LIST,"����� ���� ����","�� ����\r\n�� ����� ������\r\n��� ������\r\n����'�\r\n�����","���","����");
{
DOF2_SetString(SFile(playerid), "PSkype", inputtext);
new PInfo[256];
format(PInfo, sizeof(PInfo), "!����� �����'� ��� ������ ������\n%s :������ ��� ���",inputtext);
ShowPlayerDialog(playerid,2666,DIALOG_STYLE_MSGBOX,"����� ����'�",PInfo,"����","�����");
} return 1;}
if(dialogid == 2604){
if(!response)return ShowPlayerDialog(playerid,2508,DIALOG_STYLE_LIST,"����� ���� ����","�� ����\r\n�� ����� ������\r\n��� ������\r\n����'�\r\n�����","���","����");
{
DOF2_SetString(SFile(playerid), "PMsn", inputtext);
new PInfo[256];
format(PInfo, sizeof(PInfo), "!����� ������ ��� ������ ������\n%s :������ ��� ���",inputtext);
ShowPlayerDialog(playerid,2666,DIALOG_STYLE_MSGBOX,"����� �����",PInfo,"����","�����");
} return 1;}

//==============================================================================
if(dialogid == DIALOG_BANK)
{
	if(!response)return 1;
	{
		if(listitem == 0)//������ ����
		{
		  ShowPlayerDialog(playerid, DIALOG_BankDeposit, DIALOG_STYLE_INPUT, "��� - �����", ":��� ���� �� ����� ������� ������", "����", "����");
		}
	 	if(listitem == 1)//������ ���
		{
			if(GetPlayerMoney(playerid) < 1)return SendClientMessage(playerid, COLOR_KRED, ".��� ���� ���");
			new money;
			money = GetPlayerMoney(playerid);
			DOF2_SetInt(SFile(playerid), "Bank", DOF2_GetInt(SFile(playerid), "Bank")+money);
			ResetPlayerMoney(playerid);
			DOF2_SaveFile();
			ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_MSGBOX, "��� - �����", "!����� �� �� ���� ������", "�����", "�����");
		}
	 	if(listitem == 2)//�����
		{
        ShowPlayerDialog(playerid, DIALOG_BankWithdraw, DIALOG_STYLE_INPUT, "��� - �����", ":��� ���� �� ����� ������� �����", "����", "����");
		}
	 	if(listitem == 3)//����� ����
		{
		new DBank,string[128];
		DBank = DOF2_GetInt(SFile(playerid), "Bank");
		format(string, 128, "$%d ����� ���� ���� ��",DBank);
        ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_MSGBOX, "����� ����", string, "����", "�����");
		}
  }
return 1;}
//==============================================================================
if(dialogid == DIALOG_BankDeposit)
  {
  	if(!response)return 1;
	new string[128],money;
 	if(strval(inputtext) < 2000 || strval(inputtext) > 10000000)return ShowPlayerDialog(playerid, DIALOG_BankDeposit, DIALOG_STYLE_INPUT, "��� - �����", ":��� ���� �� ����� ������� ������", "����", "����");
  	if(!strlen(inputtext) || strval(inputtext) == 0 || strval(inputtext) < 0 ){
  	ShowPlayerDialog(playerid, DIALOG_BankDeposit, DIALOG_STYLE_INPUT, "��� - �����", ":��� ���� �� ����� ������� ������", "����", "����");}
  	else if(GetPlayerMoney(playerid) < strval(inputtext)){
  	ShowPlayerDialog(playerid, DIALOG_BankDeposit, DIALOG_STYLE_INPUT, "��� - �����", ":��� ���� �� ����� ������� ������", "����", "����");}
  	else if (strlen(inputtext) || strval(inputtext) > 0){
  	money = strval(inputtext);
	DOF2_SetInt(SFile(playerid), "Bank", DOF2_GetInt(SFile(playerid), "Bank")+money);
	GivePlayerMoney(playerid,-money);
	DOF2_SaveFile();
	format(string, 128, ".$%d ����� ������ ���� ���",inputtext);
	ShowPlayerDialog(playerid, MSGBoxDialog, DIALOG_STYLE_MSGBOX, "��� - �����", string, "����", "�����");}
return 1;}
if(dialogid == DIALOG_BankWithdraw)
  {
 	if(!response)return 1;
	new string[128],money;
		if(strval(inputtext) < 1 || strval(inputtext) > 10000000)return ShowPlayerDialog(playerid, DIALOG_BankWithdraw, DIALOG_STYLE_INPUT, "��� - �����", ":��� ���� �� ����� ������� �����", "����", "����");
  	if(!strlen(inputtext) || strval(inputtext) == 0 || strval(inputtext) < 0){
  	ShowPlayerDialog(playerid, DIALOG_BankWithdraw, DIALOG_STYLE_INPUT, "��� - �����", ":��� ���� �� ����� ������� �����", "����", "����");}
	if (strval(inputtext) > DOF2_GetInt(SFile(playerid), "Bank")){
	ShowPlayerDialog(playerid, DIALOG_BankWithdraw, DIALOG_STYLE_INPUT, "��� - �����", ":��� ���� �� ����� ������� �����", "����", "����");}
  	else if (strlen(inputtext) || strval(inputtext) > 0){
  	money = strval(inputtext);
	DOF2_SetInt(SFile(playerid), "Bank", DOF2_GetInt(SFile(playerid), "Bank")-money);
	GivePlayerMoney(playerid,money);
	DOF2_SaveFile();
	format(string, 128, ".$%d ���� ������ ���� ���", inputtext);
	ShowPlayerDialog(playerid, MSGBoxDialog, DIALOG_STYLE_MSGBOX, "���", string, "�����", "�����");}
return 1;}
//==============================================================================

if(dialogid == 1872)
{
if(response)
{
switch(listitem)
{
case 0:
{
if(teamaplayers == 20) return SendClientMessage(playerid, red, "������ ����");
InTDM[playerid] = 1;
OldInfo[playerid][0] = GetPlayerColor(playerid);
OldInfo[playerid][1] = GetPlayerSkin(playerid);
TextDrawShowForPlayer(playerid, CopsPoints);
TextDrawShowForPlayer(playerid, GangPoints);
SetPlayerTeam(playerid,TeamA);
new rand = random(sizeof(TDMCopsSpawn));
SetPlayerPos(playerid,TDMCopsSpawn[rand][0],TDMCopsSpawn[rand][1],TDMCopsSpawn[rand][2]);
new rand2 = random(sizeof(TDMCopsSkin));
SetPlayerSkin(playerid,TDMCopsSkin[rand2]);
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid,24,1000);
GivePlayerWeapon(playerid,27,1000);
GivePlayerWeapon(playerid,31,1000);
GivePlayerWeapon(playerid,29,1000);
GivePlayerWeapon(playerid,34,1000);
GivePlayerWeapon(playerid,16,3);
SetPlayerColor(playerid,0x0000ffff);
SendClientMessage(playerid,0xff0033ff,"[{ffffff}/TDM{ff0033}] ������ ������ �� ���� �� ������ {ffffff}Team Deathmatch {ff0033}���� ��� �����");
InTeamA[playerid] = 1;
teamaplayers ++;
}
case 1:
{
if(teambplayers == 20) return SendClientMessage(playerid, red, "������ ����");
SetPlayerTeam(playerid,TeamB);
TextDrawShowForPlayer(playerid, CopsPoints);
TextDrawShowForPlayer(playerid, GangPoints);
OldInfo[playerid][0] = GetPlayerColor(playerid);
OldInfo[playerid][1] = GetPlayerSkin(playerid);
new rand = random(sizeof(TDMGangSpawn));
SetPlayerPos(playerid,TDMGangSpawn[rand][0],TDMGangSpawn[rand][1],TDMGangSpawn[rand][2]);
new rand2 = random(sizeof(TDMGangSkin));
SetPlayerSkin(playerid,TDMGangSkin[rand2]);
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid,24,1000);
GivePlayerWeapon(playerid,25,1000);
GivePlayerWeapon(playerid,30,1000);
GivePlayerWeapon(playerid,32,1000);
GivePlayerWeapon(playerid,34,1000);
GivePlayerWeapon(playerid,18,3);
SetPlayerColor(playerid,0xff0000ff);
SendClientMessage(playerid,0xff0033ff,"[{ffffff}/TDM{ff0033}] ������ ������ �� ���� �� ������ {ffffff}Team Deathmatch {ff0033}���� ��� �����");
InTDM[playerid] = 1;
InTeamB[playerid] = 1;
teambplayers ++;
}
}
}
return 1;}
return 1;}

public UpdateCar(vehicleid)
{

new msg[256],car = vehicleid;
new file[50]; format(file,sizeof(file),"Car/car%d.txt",vehicleid);
if(DOF2_GetInt(file,"Nitro") != 0) AddVehicleComponent(vehicleid,1010);
if(DOF2_GetInt(file,"Hydraulics") != 0) AddVehicleComponent(vehicleid,1087);
if(DOF2_GetInt(file,"Wheels") != 0) AddVehicleComponent(vehicleid,DOF2_GetInt(file,"WheelsOn"));
if(DOF2_GetInt(file,"Buyable") == 2){
if(DOF2_GetInt(file,"Color1") != -1 && DOF2_GetInt(file,"Color2") == -1)ChangeVehicleColor(vehicleid,DOF2_GetInt(file,"Color1"),DOF2_GetInt(file,"Color1"));
format(String, sizeof(String), "{ff0000}%s",DOF2_GetString(file,"carplate"));
SetVehicleNumberPlate(car,String);
if(DOF2_GetInt(file,"Color1") != -1 && DOF2_GetInt(file,"Color2") != -1)ChangeVehicleColor(vehicleid,DOF2_GetInt(file,"Color1"),DOF2_GetInt(file,"Color2"));
}
if(DOF2_GetInt(file,"CarOwned") == 1)
{
Delete3DTextLabel(CarMsg[car]);
format(msg,sizeof(msg),"%s :�����",DOF2_GetString(file,"CarOwner"));
CarMsg[car] = Create3DTextLabel(msg,0xff9900AA,0.0,0.0,0.0,20.0,0);
Attach3DTextLabelToVehicle(CarMsg[car], car, 0.0,0.0,1.0);
}
if(DOF2_GetInt(file,"Buyable") == 2 && DOF2_GetInt(file,"CarOwned") == 1)
{
Delete3DTextLabel(CarMsg[car]);
format(msg,sizeof(msg),"{FF66FF}��� �����\n{FF9900}%s :�����",DOF2_GetString(file,"CarOwner"));
CarMsg[car] = Create3DTextLabel(msg,0xff66ffAA,0.0,0.0,0.0,20.0,0);
Attach3DTextLabelToVehicle(CarMsg[car], car, 0.0,0.0,1.0);
}
else if(DOF2_GetInt(file,"Buyable") == 0)
{
Delete3DTextLabel(CarMsg[car]);
format(msg,sizeof(msg),"��� ������",VehNames[GetVehicleModel(car)-400]);
CarMsg[car] = Create3DTextLabel(msg,0xff0000AA,0.0,0.0,0.0,20.0,0);
Attach3DTextLabelToVehicle(CarMsg[car], car, 0.0,0.0,1.0);
}
else if(DOF2_GetInt(file,"Buyable") == -1)
{
Delete3DTextLabel(CarMsg[car]);
format(msg,sizeof(msg),"��� �����",VehNames[GetVehicleModel(car)-400]);
CarMsg[car] = Create3DTextLabel(msg,0xff0000AA,0.0,0.0,0.0,20.0,0);
Attach3DTextLabelToVehicle(CarMsg[car], car, 0.0,0.0,1.0);
}
else if(DOF2_GetInt(file,"Buyable") == 3)
{
Delete3DTextLabel(CarMsg[car]);
format(msg,sizeof(msg),"{FFFF00}������ ����",VehNames[GetVehicleModel(car)-400]);
CarMsg[car] = Create3DTextLabel(msg,COLOR_KRED,0.0,0.0,0.0,20.0,0);
Attach3DTextLabelToVehicle(CarMsg[car], car, 0.0,0.0,1.0);
}
else if(DOF2_GetInt(file,"Buyable") == 2)
{
if(DOF2_GetInt(file,"Color1") != -1 && DOF2_GetInt(file,"Color2") == -1)ChangeVehicleColor(vehicleid,DOF2_GetInt(file,"Color1"),DOF2_GetInt(file,"Color1"));
else if(DOF2_GetInt(file,"Color1") != -1 && DOF2_GetInt(file,"Color2") != -1)ChangeVehicleColor(vehicleid,DOF2_GetInt(file,"Color1"),DOF2_GetInt(file,"Color2"));
Delete3DTextLabel(CarMsg[car]);
format(msg,sizeof(msg),"{FF66FF}��� �����\n{00FF00}���� ������");
CarMsg[car] = Create3DTextLabel(msg,0xff66ffAA,0.0,0.0,0.0,20.0,0);
Attach3DTextLabelToVehicle(CarMsg[car], car, 0.0,0.0,1.0);

}
else if(DOF2_GetInt(file,"CarOwned") == 0)
{
Delete3DTextLabel(CarMsg[car]);
format(msg,sizeof(msg)," ���� ������ ",VehNames[GetVehicleModel(car)-400]);
CarMsg[car] = Create3DTextLabel(msg,0x00ff66AA,0.0,0.0,0.0,20.0,0);
Attach3DTextLabelToVehicle(CarMsg[car], car, 0.0,0.0,1.0);
}
else if(DOF2_GetInt(file,"CarOwned") == 2)
{
Delete3DTextLabel(CarMsg[car]);
format(msg,sizeof(msg),"{4682b4}%s :�����",DOF2_GetString(file,"CarOwner"));
CarMsg[car] = Create3DTextLabel(msg,0xff9900AA,0.0,0.0,0.0,20.0,0);
Attach3DTextLabelToVehicle(CarMsg[car], car, 0.0,0.0,1.0);
}
if(DOF2_GetInt(file,"Buyable") == 2 && DOF2_GetInt(file,"CarOwned") == 2)
{
Delete3DTextLabel(CarMsg[car]);
format(msg,sizeof(msg),"��� ����� \n {4682b4} %s :�����",DOF2_GetString(file,"CarOwner"));
CarMsg[car] = Create3DTextLabel(msg,0xff66ffAA,0.0,0.0,0.0,20.0,0);
Attach3DTextLabelToVehicle(CarMsg[car], car, 0.0,0.0,1.0);
}

if(DOF2_GetInt(file,"Nitro") != 0)AddVehicleComponent(vehicleid,1010);
if(DOF2_GetInt(file,"Hydraulics") != 0)AddVehicleComponent(vehicleid,1087);
if(DOF2_GetInt(file,"Wheels") != 0)AddVehicleComponent(vehicleid,DOF2_GetInt(file,"WheelsOn"));
return 1;
}

forward LoadFiles(playerid, vehicleid);
public LoadFiles(playerid, vehicleid)
{
new file[50], VPrice[MAX_VEHICLES];
VCount =CreateVehicle(411,0,0,0,0,0,0,-1);
DestroyVehicle(VCount);
printf("%d Cars Found In Your Server, Create cars files....",VCount-1);
for (new car=1; car < VCount; car++)
{
format(file,sizeof(file),"Car/car%d.txt",car);
format(String, sizeof(String), "{ff0000}%s",DOF2_GetString(file,"carplate"));
SetVehicleNumberPlate(car,String);
if(!DOF2_FileExists(file)){
DOF2_CreateFile(file); CreateCount++;
DOF2_SetInt(file,"CarID",car);
DOF2_SetString(file,"CarName",VehNames[GetVehicleModel(car)-400] );
DOF2_SetInt(file,"CarModel",GetVehicleModel(car));
DOF2_SetInt(file,"CarOwned",0);
DOF2_SetString(file,"CarOwner","none");
DOF2_SetInt(file,"CarLocked",0);
DOF2_SetInt(file,"Buyable",1);
DOF2_SetInt(file,"Price",90000);
DOF2_SetInt(file,"Nitro",0);
DOF2_SetInt(file,"Neon",0);
DOF2_SetInt(file,"Hydraulics",0);
DOF2_SetInt(file,"Wheel",0);
DOF2_SetString(file,"carname1",VehNames[GetVehicleModel(car)-400] );
DOF2_SetString(file,"carplate",GetVehicleName(car));
DOF2_SetInt(file,"Color1",-1);
DOF2_SetInt(file,"Color2",-1);
DOF2_SetInt(file,"PayTaxTime",30);
VehicleInfo[car][CarID] = DOF2_GetInt(file,"CarID");
strmid(VehicleInfo[car][CarName], DOF2_GetString(file,"CarName"), 0, strlen(DOF2_GetString(file,"CarName")), 255);
VehicleInfo[car][CarModel] = DOF2_GetInt(file,"CarModel");
VehicleInfo[car][CarOwned] = DOF2_GetInt(file,"CarOwned");
strmid(VehicleInfo[car][CarOwner], DOF2_GetString(file,"CarOwner"), 0, strlen(DOF2_GetString(file,"CarOwner")), 255);
VehicleInfo[car][CarLocked] = DOF2_GetInt(file,"CarLocked");
VehicleInfo[car][Nitro] = DOF2_GetInt(file,"Nitro");
VehicleInfo[car][Neon] = DOF2_GetInt(file,"Neon");
VehicleInfo[car][Hyd] = DOF2_GetInt(file,"Hydraulics");
VehicleInfo[car][Wheels] = DOF2_GetInt(file,"Wheels");
VPrice[car] = NormPrice;
for(new v=0; v < sizeof(Low); v++) if(VehicleInfo[car][CarModel] == Low[v][0])VPrice[car] = LowPrice;
for(new v=0; v < sizeof(VGood); v++) if(VehicleInfo[car][CarModel] == VGood[v][0])VPrice[car] = VeryGoodPrice;
for(new v=0; v < sizeof(Good1); v++) if(VehicleInfo[car][CarModel] == Good1[v][0])VPrice[car] = GoodPrice;
for(new v=0; v < sizeof(Likely1); v++) if(VehicleInfo[car][CarModel] == Likely1[v][0])VPrice[car] = Likely;
for(new v=0; v < sizeof(ALot1); v++) if(VehicleInfo[car][CarModel] == ALot1[v][0])VPrice[car] = ALot;
for(new v=0; v < sizeof(Expensive1); v++) if(VehicleInfo[car][CarModel] == Expensive1[v][0])VPrice[car] = Expensive;
for(new v=0; v < sizeof(VExpensive); v++) if(VehicleInfo[car][CarModel] == VExpensive[v][0])VPrice[car] = VeryExpensive;
for(new v=0; v < sizeof(VVexpensive); v++) if(VehicleInfo[car][CarModel] == VVexpensive[v][0])VPrice[car] = VeryVeryExpensive;
VehicleInfo[car][Price] = VPrice[car];
DOF2_SetInt(file,"Price",VehicleInfo[car][Price]);

}
else if(DOF2_FileExists(file)){


new msg[256];
if(DOF2_GetInt(file,"CarOwned") == 1)
{
format(msg,sizeof(msg),"{4682b4}%s :�����", DOF2_GetString(file,"CarOwner"));
CarMsg[car] = Create3DTextLabel(msg,0xff9900AA,0.0,0.0,0.0,20.0,0);
}
if(DOF2_GetInt(file,"Buyable") == 2 && DOF2_GetInt(file,"CarOwned") == 1)
{
format(msg,sizeof(msg),"��� ����� \n {ff9900} %s :����� ",DOF2_GetString(file,"CarOwner"));
CarMsg[car] = Create3DTextLabel(msg,0xff66ffAA,0.0,0.0,0.0,20.0,0);
}
else if(DOF2_GetInt(file,"Buyable") == 0)
{
format(msg,sizeof(msg)," ��� ������ ",VehNames[GetVehicleModel(car)-400]);
CarMsg[car] = Create3DTextLabel(msg,0xff0000AA,0.0,0.0,0.0,20.0,0);
}
else if(DOF2_GetInt(file,"Buyable") == -1)
{
format(msg,sizeof(msg)," ��� ����� ",VehNames[GetVehicleModel(car)-400]);
CarMsg[car] = Create3DTextLabel(msg,0xff0000AA,0.0,0.0,0.0,20.0,0);
}
else if(DOF2_GetInt(file,"Buyable") == 3)
{
format(msg,sizeof(msg)," {FFFF00}������ ���� ",VehNames[GetVehicleModel(car)-400]);
CarMsg[car] = Create3DTextLabel(msg,COLOR_KRED,0.0,0.0,0.0,20.0,0);
}
else if(DOF2_GetInt(file,"Buyable") == 2)
{
if(DOF2_GetInt(file,"Color1") != -1 && DOF2_GetInt(file,"Color2") == -1)ChangeVehicleColor(car,DOF2_GetInt(file,"Color1"),DOF2_GetInt(file,"Color1"));
else if(DOF2_GetInt(file,"Color1") != -1 && DOF2_GetInt(file,"Color2") != -1)ChangeVehicleColor(car,DOF2_GetInt(file,"Color1"),DOF2_GetInt(file,"Color2"));
format(msg,sizeof(msg),"��� ����� \n {00ff66} ���� ������");
CarMsg[car] = Create3DTextLabel(msg,0xff66ffAA,0.0,0.0,0.0,20.0,0);
}
else if(DOF2_GetInt(file,"CarOwned") == 0)
{
format(msg,sizeof(msg)," ���� ������ ",VehNames[GetVehicleModel(car)-400]);
CarMsg[car] = Create3DTextLabel(msg,0x00ff66AA,0.0,0.0,0.0,20.0,0);
}
if(DOF2_GetInt(file,"CarOwned") == 2)
{
format(msg,sizeof(msg),"{4682b4}%s :�����", DOF2_GetString(file,"CarOwner"));
CarMsg[car] = Create3DTextLabel(msg,0xff9900AA,0.0,0.0,0.0,20.0,0);
}
if(DOF2_GetInt(file,"CarOwned") == 4)
{
format(msg,sizeof(msg),"{4682b4}%s :�����", DOF2_GetString(file,"CarOwner"));
CarMsg[car] = Create3DTextLabel(msg,0xff9900AA,0.0,0.0,0.0,20.0,0);
}

if(DOF2_GetInt(file,"Buyable") == 2 && DOF2_GetInt(file,"CarOwned") == 2)
{
format(msg,sizeof(msg),"��� ����� \n {4682b4} %s :�����",DOF2_GetString(file,"CarOwner"));
CarMsg[car] = Create3DTextLabel(msg,0xff66ffAA,0.0,0.0,0.0,20.0,0);
}
Attach3DTextLabelToVehicle(CarMsg[car], car, 0.0,0.0,1.0);
VehicleInfo[car][CarID] = DOF2_GetInt(file,"CarID");
strmid(VehicleInfo[car][CarName], DOF2_GetString(file,"CarName"), 0, strlen(DOF2_GetString(file,"CarName")), 255);
VehicleInfo[car][CarModel] = DOF2_GetInt(file,"CarModel");
VehicleInfo[car][CarOwned] = DOF2_GetInt(file,"CarOwned");
strmid(VehicleInfo[car][CarOwner], DOF2_GetString(file,"CarOwner"), 0, strlen(DOF2_GetString(file,"CarOwner")), 255);
VehicleInfo[car][CarLocked] = DOF2_GetInt(file,"CarLocked");
VehicleInfo[car][Buyable] = DOF2_GetInt(file,"Buyable");
VehicleInfo[car][Price] = DOF2_GetInt(file,"Price");
VehicleInfo[car][Nitro] = DOF2_GetInt(file,"Nitro");
VehicleInfo[car][Neon] = DOF2_GetInt(file,"Neon");
VehicleInfo[car][Disco] = DOF2_GetInt(file,"Disco");
VehicleInfo[car][Hyd] = DOF2_GetInt(file,"Hydraulics");
VehicleInfo[car][Wheels] = DOF2_GetInt(file,"Wheels");
if(VehicleInfo[car][Nitro] != 0) { AddVehicleComponent(car,1010); ModCount++;}
if(VehicleInfo[car][Hyd] != 0) { AddVehicleComponent(car,1087); ModCount++;}
if(VehicleInfo[car][Wheels] != 0) AddVehicleComponent(car,DOF2_GetInt(file,"WheelsOn")),ModCount++;
if(DOF2_GetInt(file,"Buyable") == 2){
if(DOF2_GetInt(file,"Color1") != -1 && DOF2_GetInt(file,"Color2") == -1)ChangeVehicleColor(car,DOF2_GetInt(file,"Color1"),DOF2_GetInt(file,"Color1"));
else if(DOF2_GetInt(file,"Color1") != -1 && DOF2_GetInt(file,"Color2") != -1)ChangeVehicleColor(car,DOF2_GetInt(file,"Color1"),DOF2_GetInt(file,"Color2"));
}
}
}
printf(" %d Car Files Created.", CreateCount);
}

stock randomEx(randval)
{
new rand1 = random(2), rand2;
if (!rand1) rand2 -= random(randval);
else rand2 += random(randval);
return rand2;
}
stock LevelError(playerid,level)
{
new lString[256];
format(lString, sizeof(lString),".%d ����� �� ����� ������ ��� ���� #",level);
return SendClientMessage(playerid,COLOR_KRED,lString);
}

stock strval_fix(string[]) return strlen(string) > 49? 0 : strval(string);

forward IsNumber(string[]);
public IsNumber(string[]){
for(new i=0,j=strlen(string); i<j;i++)
{
if(string[i] > '9' || string[i] < '0'){return 0;}
}
return 1;
}

stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
new Float:oldposx, Float:oldposy, Float:oldposz;
new Float:tempposx, Float:tempposy, Float:tempposz;
GetPlayerPos(playerid, oldposx, oldposy, oldposz);
tempposx = (oldposx -x);
tempposy = (oldposy -y);
tempposz = (oldposz -z);
if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
{
return 1;
}
return 0;
}

stock IsNumeric(string[]){ for(new i = 0; i < strlen(string); i++) if(string[i] > '9' || string[i] < '0') return false; return true;}
stock SFile(playerid){ new us[128]; format(us,128,"Users/%s.txt",GetName(playerid)); return us; }

stock SFile1(name[]) {
new string[256];
format(string,sizeof(string),"Users/%s.txt",name);
return string;
}

stock WriteToServerLog(category[], string[]) {
new tnd[128],day,month,year,hour,minute,second;
new hour_tf[3],minute_tf[3],second_tf[3]; getdate(year,month,day); gettime(hour,minute,second);
if (hour <= 9) format(hour_tf,3,"0%d",hour); else format(hour_tf,3,"%d",hour);
if (minute <= 9) format(minute_tf,3,"0%d",minute); else format(minute_tf,3,"%d",minute);
if (second <= 9) format(second_tf,3,"0%d",second); else format(second_tf,3,"%d",second);
format(tnd,128,"[%d.%d.%d | %s:%s:%s]",day,month,year,hour_tf,minute_tf,second_tf);
new line[512],file[128];
if (!strcmp(category,"Commands",true)) {
file = "/ServerFiles/Commands.txt";
new File:handle = (fexist(file))?fopen(file,io_append):fopen(file,io_write);
format(line,512,"\n%s %s",tnd,string);
fwrite(handle,line); fclose(handle);

} else if (!strcmp(category,"Pms",true)) {
file = "/ServerFiles/Pms.txt";
new File:handle = (fexist(file))?fopen(file,io_append):fopen(file,io_write);
format(line,512,"\n%s %s",tnd,string);
fwrite(handle,line); fclose(handle);

} else if (!strcmp(category,"Gangs",true)) {
file = "/ServerFiles/Gangs.txt";
new File:handle = (fexist(file))?fopen(file,io_append):fopen(file,io_write);
format(line,512,"\n%s %s",tnd,string);
fwrite(handle,line); fclose(handle);

} else if (!strcmp(category,"Clans",true)) {
file = "/ServerFiles/Clans.txt";
new File:handle = (fexist(file))?fopen(file,io_append):fopen(file,io_write);
format(line,512,"\n%s %s",tnd,string);
fwrite(handle,line); fclose(handle);

} else if (!strcmp(category,"Phone",true)) {
file = "/ServerFiles/Phones.txt";
new File:handle = (fexist(file))?fopen(file,io_append):fopen(file,io_write);
format(line,512,"\n%s %s",tnd,string);
fwrite(handle,line); fclose(handle);

} else if (!strcmp(category,"Chat",true)) {
file = "/ServerFiles/Chat.txt";
new File:handle = (fexist(file))?fopen(file,io_append):fopen(file,io_write);
format(line,512,"\n%s %s",tnd,string);
fwrite(handle,line); fclose(handle);

} else if (!strcmp(category,"Report",true)) {
file = "/ServerFiles/Report.txt";
new File:handle = (fexist(file))?fopen(file,io_append):fopen(file,io_write);
format(line,512,"\n%s %s",tnd,string);
fwrite(handle,line); fclose(handle);

} else if (!strcmp(category,"Pay",true)) {
file = "/ServerFiles/Pay.txt";
new File:handle = (fexist(file))?fopen(file,io_append):fopen(file,io_write);
format(line,512,"\n%s %s",tnd,string);
fwrite(handle,line); fclose(handle);

} else if (!strcmp(category,"BugsReport",true)) {
file = "/ServerFiles/BugsReport.txt";
new File:handle = (fexist(file))?fopen(file,io_append):fopen(file,io_write);
format(line,512,"\n%s %s",tnd,string);
fwrite(handle,line); fclose(handle);

} else if (!strcmp(category,"Kills&Deaths",true)) {
file = "/ServerFiles/Kills&Deaths.txt";
new File:handle = (fexist(file))?fopen(file,io_append):fopen(file,io_write);
format(line,512,"\n%s %s",tnd,string);
fwrite(handle,line); fclose(handle);

} else if (!strcmp(category,"BoughtCars",true)) {
file = "/ServerFiles/BoughtCars.txt";
new File:handle = (fexist(file))?fopen(file,io_append):fopen(file,io_write);
format(line,512,"\n%s %s",tnd,string);
fwrite(handle,line); fclose(handle);

} else printf("ERROR: Can not find the log category named \"%s\"!",category);
return 1;
}

stock GetPlayerLevel(playerid)return DOF2_GetInt(SFile(playerid),"Level");
stock GetPlayerBank(playerid)return DOF2_GetInt(SFile(playerid),"Bank");
stock InClan(playerid)
{
if(strcmp(DOF2_GetString(SFile(playerid),"Clan"),"None",true))return true;
return false;
}
stock GetClanFile(ClanName[])
{
	format(String,256,"Clans/%s.ini",ClanName);
	return String;
}
stock ShowStats(playerid,Showfor)
{
if(!IsPlayerConnected(playerid) || !IsPlayerConnected(Showfor))return 0;
format(String, sizeof(String), "{FFFFFF}--- %s [{848284}%s{FFFFFF}] ---",GetName(playerid),ColouredText(DOF2_GetString(SFile(playerid), "PlayerTag")));
SendClientMessage(Showfor,-1,String);
format(String, sizeof(String), "{1B95FE}Level: [{FFFFFF}%d{1B95FE}] - {1B95FE}Kills: [{FFFFFF}%d{1B95FE}] - {1B95FE}Bank: [{a5db10}$%s{1B95FE}]",DOF2_GetInt(SFile(playerid),"Level"),DOF2_GetInt(SFile(playerid),"Kills"),GetNum(GetPlayerBank(playerid)));
SendClientMessage(Showfor, COLOR_WHITE,String);
format(String, sizeof(String), "{1B95FE}For more information about This Player Press:{FFFFFF} \"/details %s\"",GetName(playerid));
SendClientMessage(Showfor,-1,String);
if(SpySystem[playerid] == 1 && playerid != Showfor){
SendFormatMessage(playerid,COLOR_ORANGE,"[SpySystem] >> ��� Stats ���� � (id: %d) ''%s'' �����",Showfor,GetName(Showfor));
}
return 1;
}
stock NewShowStats(playerid,Showfor)
{
if(!IsPlayerConnected(playerid) || !IsPlayerConnected(Showfor))return 0;
new SString2[256];
format(SString, sizeof(SString), "Stats For: %s [#%d]",GetName(playerid),DOF2_GetInt(SFile(playerid),"UserID"));
format(SString2, sizeof(SString2), "{A91348}Level: {ffffff}%d{A91348} - Kills: {ffffff}%d{A91348} - Bank: {a5db10}$%s",DOF2_GetInt(SFile(playerid),"Level"),DOF2_GetInt(SFile(playerid),"Kills"),GetNum(GetPlayerBank(playerid)));
ShowPlayerDialog(Showfor, 15515, DIALOG_STYLE_MSGBOX, SString,SString2, "�����", "");
if(SpySystem[playerid] == 1 && playerid != Showfor){
SendFormatMessage(playerid,COLOR_ORANGE,"[SpySystem] >> ��� Stats ���� � (id: %d) ''%s'' �����",Showfor,GetName(Showfor));
}
return 1;
}
stock WeaponLevelError(playerid,level)return SendFormatMessage(playerid,red,".%d ��� �� ���� ������ ����",level);
stock WeaponMoneyError(playerid,money) return SendFormatMessage(playerid,red,".����� ��� �� %s$ ��� ��",GetNum(money));
forward BuyCar(playerid);
public BuyCar(playerid){
if(!IsPlayerConnected(playerid))return 0;
GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".���� ����");
new file[256];
format(file,sizeof(file),"Car/car%d.txt",GetPlayerVehicleID(playerid));
new vehicleid = GetPlayerVehicleID(playerid);
if(DOF2_GetInt(file,"Buyable") == 2 && DOF2_GetInt(SFile(playerid),"Level") < 3 && !IsPlayerHonor(playerid))return SendClientMessage(playerid,COLOR_WHITE,".����� ��� �� ������ ���� 3");
if(DOF2_GetInt(file,"Buyable") == 0) return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� ������ ���� ���� ���� ������ ");
if(DOF2_GetInt(file,"Buyable") == -1) return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� ������ ���� ���� ���� ������ ");
if(GetPlayerMoney(playerid) < DOF2_GetInt(file,"Price")){
format(String,sizeof(String),".%s - ��� ���� �� ����� ����� ������ ��� ��",GetNum(DOF2_GetInt(file,"Price")));
return SendClientMessage(playerid,COLOR_WHITE,String);
}
if(GetPlayerVehicleID(playerid) >= VCount) return SendClientMessage(playerid,COLOR_WHITE,".��� �� ���� ������ ���� ���� ���� ������");
if(DOF2_GetInt(file,"CarOwned") == 1){
format(String,sizeof(String),"!����� ���� ������ %s ������� �� , %s - ��� ��",DOF2_GetString(file,"CarOwner"),GetVehicleName(vehicleid));
SendClientMessage(playerid,COLOR_WHITE,String);
return 1;
}
if(DOF2_GetInt(SFile(playerid),"OwnCar") != 0) return SendClientMessage(playerid,COLOR_WHITE,"/SellCar - ���� ��� �������,�� ��� ����� ��� �� ��� �� ���� ����/�");
if(!DOF2_FileExists(file)){
SendClientMessage(playerid,red,"��� �� ���� ��� �� �����");
return 1;
}
SetVehicleParamsForPlayer(vehicleid, playerid, true, false);
if(DOF2_GetInt(file,"Buyable") == 2){
DOF2_SetInt(file,"CarOwned",1);
DOF2_SetString(file,"CarOwner",playername);
strmid(DOF2_GetString(file,"CarOwner"), playername, 0, strlen(playername), 255);
VehicleInfo[vehicleid][CarLocked] = 0;
DOF2_SetInt(SFile(playerid),"CarID",GetPlayerVehicleID(playerid));
DOF2_SetInt(SFile(playerid),"OwnCar",1);
format(String,sizeof(String),"[$%s] � \"%s\" �����! ���� �� ����",GetNum(DOF2_GetInt(file,"Price")),GetVehicleName(vehicleid));
SendClientMessage(playerid,COLOR_PINK,String);
format(String,sizeof(String),"\r\n%s Bought special car - \"%s\" for %d $.",playername,GetVehicleName(vehicleid),DOF2_GetInt(file,"Price"));
WriteToServerLog("BoughtCars",String);
GivePlayerMoney(playerid,-DOF2_GetInt(file,"Price"));
DOF2_SetInt(file,"PayTaxTime",30);
SetTimerEx("UpdateCar",1000,0,"d",GetPlayerVehicleID(playerid));
return 1;
}

printf("[Car]%s Buy Car - %s  ID %d",playername,GetVehicleName(vehicleid),GetPlayerVehicleID(playerid));
DOF2_SetInt(file,"CarOwned",1);
DOF2_SetString(file,"CarOwner",playername);
strmid(DOF2_GetString(file,"CarOwner"), playername, 0, strlen(playername), 255);
VehicleInfo[vehicleid][CarLocked] = 0;
DOF2_SetInt(SFile(playerid),"CarID",GetPlayerVehicleID(playerid));
DOF2_SetInt(SFile(playerid),"OwnCar",1);
printf("[CarID] %d <> [OwnCar] %d",DOF2_GetInt(SFile(playerid),"CarID"),DOF2_GetInt(SFile(playerid),"OwnCar"));
format(String,sizeof(String),"[$%s] � \"%s\" �����! ���� �� ����",GetNum(DOF2_GetInt(file,"Price")),GetVehicleName(vehicleid));
SendClientMessage(playerid,0x00FF00FF,String);
format(String,sizeof(String),"\r\n%s Bought car - \"%s\" for %d $.",playername,GetVehicleName(vehicleid),DOF2_GetInt(file,"Price"));
WriteToServerLog("BoughtCars",String);
GivePlayerMoney(playerid,-DOF2_GetInt(file,"Price"));
DOF2_SetInt(file,"PayTaxTime",30);
SetTimerEx("UpdateCar",1000,0,"d",GetPlayerVehicleID(playerid));
return 1;
}

public MiniCD(){
if(MiniCount > 20) format(String, 256,"~w~] ~b~~h~/mini %d ~w~]",ActNumber),GameTextForAll(String,1000,3);
if(MiniCount < 20) format(String, 256,"~b~~h~mini: ~w~%d",MiniCount),GameTextForAll(String,1000,3);
if(MiniCount == 30 || MiniCount == 20 || MiniCount == 10)PlayerPlaySoundToAll(1056);
if(MiniCount > 0){
--MiniCount;
SetTimer("MiniCD",1000,0);}
else{
if(MiniCountFuc == 1){
TeleportToMini();
if(Miniknoob == 1){
MiniCount = 10; MiniCD(); MiniCountFuc = 2;
}}
if(MiniCountFuc == 2 && MiniCount <= 0){
MiniUnFreeze();
}}
if(MiniCount == -1){
MiniEnd(2);}
}

public TeleportToMini(){
if(MiniPlayers < MinMiniPlayers)return MiniEnd(0);
for(new i =0; i<MAX_PLAYERS;i++){
if(InMini[i] == 1){
new rand = random(sizeof(MiniSpawns));
SetPlayerPos(i, MiniSpawns[rand][0], MiniSpawns[rand][1], MiniSpawns[rand][2]);
SetPlayerVirtualWorld(i,1);
SetPlayerInterior(i,0);
ResetPlayerWeapons(i);
Miniknoob = 1;
GivePlayerWeapon(i,38,30000);
SetPlayerArmour(i, 100.0);
SetPlayerHealth(i, 100.0);
TogglePlayerControllable(i, 0);
}}
MiniWinnerCheck = SetTimer("MiniCheck",500, 1);
return 1;}

public MiniUnFreeze(){
for(new i;i<GetMaxPlayers();i++) {
if(IsPlayerConnected(i) && InMini[i] == 1){
TogglePlayerControllable(i, 1),SetCameraBehindPlayer(i);
GameTextForPlayer(i,"~G~Good ~B~ Luck ~W~ :)", 1000,5);
}}
PlayerPlaySoundToAll(1056);
MiniStarted = 1;
return 1;}

public MiniEnd(status){
if(status == 0){
SendClientMessageToAll(COLOR_KRED,"������� ����� ��� ���� �������");
MiniOn = 0,MiniPlayers = 0,KillTimer(MiniWinnerCheck),MiniStarted = 0;
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
InMini[i] = 0;
Miniknoob = 0;}
}
return 1;}
else if(status ==1){
new MiniWinnerName[MAX_PLAYER_NAME];
GetPlayerName(MiniWinner,MiniWinnerName,sizeof(MiniWinnerName));
ResetPlayerWeapons(MiniWinner);
SetPlayerVirtualWorld(MiniWinner,0);
SetPlayerInterior(MiniWinner,0);
SetPlayerRandomSpawn(MiniWinner);
GivePlayerMoney(MiniWinner,MiniReward);
SendClientMessageToAll(COLOR_WHITE, " --- Minigun System ---");
SendClientMessageToAll(COLOR_ORANGE, "! ������� �������");
format(String, sizeof(String), ".%s :����� ���",MiniWinnerName);
SendClientMessageToAll(COLOR_ORANGE, String);
SendClientMessageToAll(COLOR_WHITE, "--------------------------------");
format(String, sizeof(String), ".$%s - ���� �, Mini -����� ������� �", GetNum(MiniReward));
SendClientMessage(MiniWinner, COLOR_WHITE, String);
DOF2_SetInt(SFile(MiniWinner),"Mini",DOF2_GetInt(SFile(MiniWinner),"Mini") +1);
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
InMini[i] = 0;
Miniknoob = 0;
}}
MiniOn = 0,MiniPlayers = 0,MiniStarted = 0;
KillTimer(MiniWinnerCheck);
return 1;
}

else if(status == 2) {
MiniPlayers = 0;
MiniStarted = 0;
MiniOn = 0;
Miniknoob = 0;
KillTimer(MiniWinnerCheck);
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
return InMini[i] = 0;
}}
}
return 1;
}

public MiniCheck() {

if(MiniStarted == 1 && MiniPlayers == 1){
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i) && InMini[i] == 1){
MiniWinner = i;
MiniEnd(1);
}}}
return 1;
}

//War Activity
public WarCD(){
if(WarCount > 20) format(String, 256,"~w~] ~b~~h~/WAR %d ~w~]",ActNumber),GameTextForAll(String,1000,3);
if(WarCount < 20) format(String, 256,"~b~~h~WAR: ~w~%d",WarCount),GameTextForAll(String,1000,3);
if(WarCount > 0){
--WarCount;
SetTimer("WarCD",1000,0);}
else{
if(WarCountFuc == 1){
TeleportToWar();
if(Warknoob == 1){
WarCount = 10; WarCD(); WarCountFuc = 2;
}}
if(WarCountFuc == 2 && WarCount <= 0){
WarUnFreeze();
}}
if(WarCount == -1){
WarEnd(2);}
}

public TeleportToWar(){
if(WarPlayers < MinWarPlayers)return WarEnd(0);
for(new i =0; i<MAX_PLAYERS;i++){
if(InWar[i] == 1){
new rand = random(sizeof(WarSpawns));
SetPlayerPos(i, WarSpawns[rand][0], WarSpawns[rand][1], WarSpawns[rand][2]);
SetPlayerVirtualWorld(i,2);
SetPlayerInterior(i,10);
ResetPlayerWeapons(i);
Warknoob = 1;
SetPlayerArmour(i, 100.0);
SetPlayerHealth(i, 100.0);
TogglePlayerControllable(i, 0);
}}
WarWinnerCheck = SetTimer("WarCheck",500, 1);
return 1;}
public WarUnFreeze(){
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i) && InWar[i] == 1){
TogglePlayerControllable(i, 1),SetCameraBehindPlayer(i);
PlayerPlaySoundToAll(1056);
WarStarted = 1;
GameTextForAll("~G~Good ~B~ Luck ~W~ :)", 1000,5);
new rand = random(sizeof(WarWeapons));
GivePlayerWeapon(i,WarWeapons[rand],10000);
format(String, sizeof(String), ".%s :���� ��� ���",GetWName(WarWeapons[rand]));
SendClientMessage(i, COLOR_WHITE,String);
}}
return 1;}
public WarEnd(status){
if(status == 0){
SendClientMessageToAll(COLOR_KRED,"������� ����� ��� ���� �������");
WarOn = 0,WarPlayers = 0,KillTimer(WarWinnerCheck),WarStarted = 0;
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
InWar[i] = 0;
Warknoob = 0;}
}
return 1;}
else if(status ==1){
new WarWinnerName[MAX_PLAYER_NAME];
GetPlayerName(WarWinner,WarWinnerName,sizeof(WarWinnerName));
ResetPlayerWeapons(WarWinner);
SetPlayerVirtualWorld(WarWinner,0);
SetPlayerInterior(WarWinner,0);
SetPlayerRandomSpawn(WarWinner);
GivePlayerMoney(WarWinner,WarReward);
SendClientMessageToAll(COLOR_WHITE, " --- War System ---");
SendClientMessageToAll(COLOR_ORANGE, "! ������� �������");
format(String, sizeof(String), ".%s :����� ���",WarWinnerName);
SendClientMessageToAll(COLOR_ORANGE, String);
SendClientMessageToAll(COLOR_WHITE, "--------------------------------");
format(String, sizeof(String), ".$%s - ���� �, War -����� ������� �", GetNum(WarReward));
SendClientMessage(WarWinner, COLOR_WHITE, String);
DOF2_SetInt(SFile(WarWinner),"War",DOF2_GetInt(SFile(WarWinner),"War") +1);
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
InWar[i] = 0;
Warknoob = 0;
}}
WarOn = 0,WarPlayers = 0,WarStarted = 0;
KillTimer(WarWinnerCheck);
return 1;
}

else if(status == 2) {
WarPlayers = 0;
WarStarted = 0;
WarOn = 0;
Warknoob = 0;
KillTimer(WarWinnerCheck);
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
return InWar[i] = 0;
}}
}
return 1;
}

public WarCheck() {

if(WarStarted == 1 && WarPlayers == 1){
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i) && InWar[i] == 1){
WarWinner = i;
WarEnd(1);
}}}
return 1;
}

//Monster Activity
public MonsterCD(){
if(MonsterCount > 20) format(String, 256,"~w~] ~b~~h~/Monster %d ~w~]",ActNumber),GameTextForAll(String,1000,3);
if(MonsterCount < 20) format(String, 256,"~b~~h~Monster: ~w~%d",MonsterCount),GameTextForAll(String,1000,3);
if(MonsterCount > 0){
--MonsterCount;
SetTimer("MonsterCD",1000,0);}
else{
if(MonsterCountFuc == 1){
TeleportToMonster();
if(Monsterknoob == 1){
MonsterCount = 10; MonsterCD(); MonsterCountFuc = 2;
}}
if(MonsterCountFuc == 2 && MonsterCount <= 0){
MonsterUnFreeze();
}}
if(MonsterCount == -1){
MonsterEnd(2);}
}

forward TeleportToMonster();
public TeleportToMonster()
{
if(MonsterPlayers < MinMonsterPlayers)return MonsterEnd(0);
for(new i; i < GetMaxPlayers(); i++)
{
if(InMonster[i] == 1)
{
SetPlayerVirtualWorld(i,0);
new rand = random(sizeof(MonsterSpawns));
MonsterCar[i] = CreateVehicle(556,MonsterSpawns[rand][0],MonsterSpawns[rand][1],MonsterSpawns[rand][2],0,0,0,100000);
PutPlayerInVehicle(i,MonsterCar[i],0);
SetVehicleVirtualWorld(MonsterCar[i],0);
LinkVehicleToInterior(MonsterCar[i],15);
SetPlayerInterior(i,15);
Monsterknoob = 1;
ResetPlayerWeapons(i);
SetPlayerHealth(i, 100.0);
TogglePlayerControllable(i, 0);
}
}
MonsterWinnerCheck = SetTimer("MonsterCheck",500, 1);
return 1;
}

public MonsterUnFreeze(){
for(new i;i<GetMaxPlayers();i++) {
if(IsPlayerConnected(i) && InMonster[i] == 1){
TogglePlayerControllable(i, 1),SetCameraBehindPlayer(i);
GameTextForPlayer(i,"~G~Good ~B~ Luck ~W~ :)", 1000,5);
}}
PlayerPlaySoundToAll(1056);
MonsterStarted = 1;
return 1;}

public MonsterEnd(status){
if(status == 0){
SendClientMessageToAll(COLOR_KRED,"������� ����� ��� ���� �������");
MonsterOn = 0,MonsterPlayers = 0,KillTimer(MonsterWinnerCheck),MonsterStarted = 0;
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
InMonster[i] = 0;
Monsterknoob = 0;}
}
return 1;}
else if(status ==1){
new MonsterWinnerName[MAX_PLAYER_NAME];
GetPlayerName(MonsterWinner,MonsterWinnerName,sizeof(MonsterWinnerName));
ResetPlayerWeapons(MonsterWinner);
SetPlayerVirtualWorld(MonsterWinner,0);
SetPlayerInterior(MonsterWinner,0);
SetPlayerRandomSpawn(MonsterWinner);
GivePlayerMoney(MonsterWinner,MonsterReward);
SendClientMessageToAll(COLOR_WHITE, " --- Monster System ---");
SendClientMessageToAll(COLOR_ORANGE, "! ������� �������");
format(String, sizeof(String), ".%s :����� ���",MonsterWinnerName);
SendClientMessageToAll(COLOR_ORANGE, String);
SendClientMessageToAll(COLOR_WHITE, "--------------------------------");
DOF2_SetInt(SFile(MonsterWinner),"Monster",DOF2_GetInt(SFile(MonsterWinner),"Monster") +1);
for(new i;i<GetMaxPlayers();i++)DestroyVehicle(MonsterCar[i]);
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
InMonster[i] = 0;
Monsterknoob = 0;
}}
MonsterOn = 0,MonsterPlayers = 0,MonsterStarted = 0;
KillTimer(MonsterWinnerCheck);
return 1;
}

else if(status == 2) {
MonsterPlayers = 0;
MonsterStarted = 0;
MonsterOn = 0;
Monsterknoob = 0;
KillTimer(MonsterWinnerCheck);
for(new i;i<GetMaxPlayers();i++)DestroyVehicle(MonsterCar[i]);
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
return InMonster[i] = 0;
}}
}
return 1;
}

public MonsterCheck() {

if(MonsterStarted == 1 && MonsterPlayers == 1){
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i) && InMonster[i] == 1){
MonsterWinner = i;
MonsterEnd(1);
}}}
return 1;
}

//Boom Activity
public BoomCD(){
if(BoomCount > 20) format(String, 256,"~w~] ~b~~h~/Boom %d ~w~]",ActNumber),GameTextForAll(String,1000,3);
if(BoomCount < 20) format(String, 256,"~b~~h~Boom: ~w~%d",BoomCount),GameTextForAll(String,1000,3);
if(BoomCount == 30 || BoomCount == 20 || BoomCount == 10)PlayerPlaySoundToAll(1056);
if(BoomCount > 0){
--BoomCount;
SetTimer("BoomCD",1000,0);}
else{
if(BoomCountFuc == 1){
TeleportToBoom();
if(Boomknoob == 1){
BoomCount = 10; BoomCD(); BoomCountFuc = 2;
}}
if(BoomCountFuc == 2 && BoomCount <= 0){
BoomUnFreeze();
}}
if(BoomCount == -1){
BoomEnd(2);}
}


public TeleportToBoom(){
if(BoomPlayers < MinBoomPlayers)return BoomEnd(0);
for(new i =0; i<MAX_PLAYERS;i++){
if(InBoom[i] == 1){
new rand = random(sizeof(BoomSpawns));
SetPlayerPos(i, BoomSpawns[rand][0], BoomSpawns[rand][1], BoomSpawns[rand][2]);
SetPlayerVirtualWorld(i,13);
SetPlayerInterior(i,0);
ResetPlayerWeapons(i);
Boomknoob = 1;
SetPlayerArmour(i, 100.0);
SetPlayerHealth(i, 100.0);
TogglePlayerControllable(i, 0);
}}
BoomWinnerCheck = SetTimer("BoomCheck",500, 1);
return 1;}

public BoomUnFreeze(){
for(new i;i<GetMaxPlayers();i++) {
if(IsPlayerConnected(i) && InBoom[i] == 1){
TogglePlayerControllable(i, 1),SetCameraBehindPlayer(i);
GameTextForPlayer(i,"~G~Good ~B~ Luck ~W~ :)", 1000,5);
}}
PlayerPlaySoundToAll(1056);
BoomStarted = 1;
BoomEx = SetTimer("BoomExp",500, 1);
return 1;}

public BoomEnd(status){
if(status == 0){
SendClientMessageToAll(COLOR_KRED,"������� ����� ��� ���� �������");
BoomOn = 0,BoomPlayers = 0,KillTimer(BoomWinnerCheck),BoomStarted = 0;
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
InBoom[i] = 0;
Boomknoob = 0;}
}
return 1;}
else if(status ==1){
new BoomWinnerName[MAX_PLAYER_NAME];
GetPlayerName(BoomWinner,BoomWinnerName,sizeof(BoomWinnerName));
ResetPlayerWeapons(BoomWinner);
SetPlayerVirtualWorld(BoomWinner,0);
SetPlayerInterior(BoomWinner,0);
SetPlayerRandomSpawn(BoomWinner);
GivePlayerMoney(BoomWinner,BoomReward);
SendClientMessageToAll(COLOR_WHITE, " --- Boom System ---");
SendClientMessageToAll(COLOR_ORANGE, "! ������� �������");
format(String, sizeof(String), ".%s :����� ���",BoomWinnerName);
SendClientMessageToAll(COLOR_ORANGE, String);
SendClientMessageToAll(COLOR_WHITE, "--------------------------------");
DOF2_SetInt(SFile(BoomWinner),"Boom",DOF2_GetInt(SFile(BoomWinner),"Boom") +1);
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
InBoom[i] = 0;
Boomknoob = 0;
}}
BoomOn = 0,BoomPlayers = 0,BoomStarted = 0;
KillTimer(BoomWinnerCheck);
KillTimer(BoomEx);
return 1;
}

else if(status == 2) {
BoomPlayers = 0;
BoomStarted = 0;
BoomOn = 0;
Boomknoob = 0;
KillTimer(BoomWinnerCheck);
KillTimer(BoomEx);
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
return InBoom[i] = 0;
}}
}
return 1;
}

public BoomCheck() {

if(BoomStarted == 1 && BoomPlayers == 1){
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i) && InBoom[i] == 1){
BoomWinner = i;
BoomEnd(1);
}}}
return 1;
}

public BoomExp(){
new rand = random(sizeof(BoomSpawns));
for(new i = 0; i <7; i++) CreateExplosion(BoomSpawns[rand][0], BoomSpawns[rand][1], BoomSpawns[rand][2],7,10);
return 1;}


//========================================================================
stock PlayerPlaySoundToAll(soundid){
for(new i = 0; i < GetMaxPlayers(); i++)if(IsPlayerConnected(i))PlayerPlaySound(i,soundid, 0.0, 0.0, 0.0);
return 1;
}
//=====================================TDM================================================
//TDM=========================

stock SendTeamMessage(Team[],Msg[]){
if(strcmp(Team, "Gang", true) == 0){
for(new t; t < GetMaxPlayers(); t++){
if(IsPlayerConnected(t) && InTeamB[t] == 1)SendClientMessage(t,0xFF0000AA,Msg);
}
return 1;
}
if(strcmp(Team, "Cops", true) == 0){
for(new c; c < GetMaxPlayers(); c++){
if(IsPlayerConnected(c) && InTeamA[c] == 1)SendClientMessage(c,0x00ccffff,Msg);
}
return 1;
}
return 1;
}

public TDM12()
{
new str3[256];
format(str3, sizeof(str3), "Cops:~w~ %s", Zero(DOF2_GetInt("TeamAS.txt", "Score"), 4));
TextDrawSetString(CopsPoints, str3);
new str4[256];
format(str4, sizeof(str4), "Gang:~w~ %s", Zero(DOF2_GetInt("TeamBS.txt", "Score"), 4));
TextDrawSetString(GangPoints, str4);

}

public CloseTdm()
{
for(new i = 0; i < GetMaxPlayers(); i++)
{
if(IsPlayerConnected(i) && InTDM[i] == 1)
{
OnPlayerCommandText(i,"/Tdm");
}
}

CantUseTDM=true;
SendClientMessageToAll(red, "/Tdm - ���� �������� �� ��� ������");

}

stock Zero(num, slots = 4)
{
new string[256];
format(string, sizeof(string), "%d", num);
for(new i = 0; i <= slots - strlen(string); i++)
{
strins(string, "0", 0);
}
return string;
}
forward Active();
public Active()
{
new h, m, s;
gettime(h, m, s);
if(h == 20 && m == 0 && s == 0 && !active)
{
active = true;
PayCarTax();
}
else if(h != 20 && m != 0 && s != 0) active = false;
}

stock GetNum(num)
{
if(num < 1000) format(str,sizeof(str),"%d",num);
if(num > 999 && num < 10000) {
format(str,sizeof(str),"%d,%d%d%d",num/1000,num/100%10,num/10%10,num%10); }
if(num > 9999 && num < 100000) {
format(str,sizeof(str),"%d%d,%d%d%d",num/10000,num/1000%10,num/100%10,num/10%10,num%10); }
if(num > 99999 && num < 1000000) {
format(str,sizeof(str),"%d%d%d,%d%d%d",num/100000,num/10000%10,num/1000%10,num/100%10,num/10%10,num%10); }
if(num > 999999 && num < 10000000) {
format(str,sizeof(str),"%d,%d%d%d,%d%d%d",num/1000000,num/100000%10,num/10000%10,num/1000%10,num/100%10,num/10%10,num%10); }
if(num > 9999999 && num < 100000000) {
format(str,sizeof(str),"%d%d,%d%d%d,%d%d%d",num/10000000,num/1000000%10,num/100000%10,num/10000%10,num/1000%10,num/100%10,num/10%10,num%10); }
if(num > 99999999 && num < 1000000000) {
format(str,sizeof(str),"%d%d%d,%d%d%d,%d%d%d",num/100000000,num/10000000%10,num/1000000%10,num/100000%10,num/10000%10,num/1000%10,num/100%10,num/10%10,num%10); }
return str;
}



StopLoopingAnim(playerid) ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0),Stoned[playerid] = 0;

forward CheckP();
public CheckP(){
new string2[256];
new icount = 0;
format(string2, sizeof(string2), "MaxPlayersRecord.ini");
for(new i; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)){
icount ++;
if(DOF2_GetInt(string2, "MaxPlayers") < icount)
{
DOF2_SetInt(string2, "MaxPlayers", icount);
SendClientMessageToAll(COLOR_WHITE, "|____________ ����� ____________|");
SendClientMessageToAll(COLOR_WHITE, "{00C3C3}!���� �� ������� �������� ��-����� ����");
SendFormatMessageToAll(COLOR_WHITE,"{00C3C3}.��� ���� ���� �� {FFFFFF}%d{00C3C3} ������ ������� �� ����� ", icount);
SendClientMessageToAll(COLOR_WHITE, "|___________________________________________________|");
}}
return 1;
}
stock ColouredText(text[])
{
enum
colorEnum
{
colorName[16],colorID[7]
};
new colorInfo[][colorEnum] = {
{"WHITE","F8F8FF"},  //
{"RED","FF0000"},   //
{"SUPP","6699FF"}, //
{"NT","127eb4"}, //
{"GREEN","00FF00"},  //
{"YELLOW","FFFF00"}, //
{"ORANGE","FFA500"}, //
{"GREY","C0C0C0"},   //
{"PURPLE","9370DB"}, //
{"PINK","FF1493"}, //
{"BROWN","8B4513"}, //
{"LIME","ADFF2F"}, //
{"BLACK","080808"}, //
{"AQUA","00FA9A"} //
},
string[(128 + 32)],tempString[16],pos = -1,x;
strmid(string, text, 0, 128, sizeof(string));
for( ; x != sizeof(colorInfo); ++x)
{
format(tempString, sizeof(tempString), "(%s)", colorInfo[x][colorName]);
while((pos = strfind(string, tempString, true, (pos + 1))) != -1)
{
new tempLen = strlen(tempString),tempVar,i = pos;
format(tempString, sizeof(tempString), "{%s}", colorInfo[x][colorID]);
if(tempLen < 8)
{
for(new j; j != (8 - tempLen); ++j)
{
strins(string, " ", pos);
}
}
for(;((string[i] != 0) && (tempVar != 8)) ; ++i, ++tempVar)
{
string[i] = tempString[tempVar];
}
if(tempLen > 8)
{
strdel(string, i, (i + (tempLen - 8)));
}
x = -1;
}
}
return string;
}
// �����
//==============================================================================
forward EndCall(id1,id2,reason);
public EndCall(id1,id2,reason)
{
if(reason == 1) // no answer.
{
if(InCall[id1] == 1)
{
InCall[id1] = 0;
SetPlayerSpecialAction(id1,SPECIAL_ACTION_STOPUSECELLPHONE);
format(str,sizeof(str),".�� ��� ������ \"%s\"",GetName(id2));
SendClientMessage(id1,RED,str);
}
format(str,sizeof(str),".\"%s\" �� ���� �����",GetName(id1));
SendClientMessage(id2,RED,str);
InCall[id1] = 0;
InCall[id2] = 0;
InCall[id1] = 0;
InCall[id2] = 0;
Tallking[id1] = 0;
Tallking[id2] = 0;
TallkingID[id1] = -1;
TallkingID[id2] = -1;
IsCalling[id1] = 0;
}
else if(reason == 2) // no money.
{
SendClientMessage(id1, RED, ".����� �����, ��� �� ����� ���");
SendClientMessage(id2, RED, ".����� ����� ���� ���� ����� ��� ����� ���");
InCall[id1] = 0;
InCall[id2] = 0;
InCall[id1] = 0;
InCall[id2] = 0;
Tallking[id1] = 0;
Tallking[id2] = 0;
TallkingID[id1] = -1;
TallkingID[id2] = -1;
IsCalling[id1] = 0;
}
else if(reason == 3) // player disconnected / hangup.
{
InCall[id1] = 0;
InCall[id2] = 0;
Tallking[id1] = 0;
Tallking[id2] = 0;
TallkingID[id1] = -1;
TallkingID[id2] = -1;
IsCalling[id1] = 0;
}
return 1;
}
//
forward Bomb(playerid);
public Bomb(playerid) {
DestroyObject(SBomb[playerid]);
UseBomb[playerid] = 0;
CreateExplosion(Float:PlayerPos[playerid][0],Float:PlayerPos[playerid][1],Float:PlayerPos[playerid][2],10,0);
SendClientMessage(playerid, 0x33AA33AA,".����� �������"),PlayerPlaySound(playerid,1056,0.0,0.0,0.0);
return 1; }
stock IsPlayerXAdmin(playerid){ new file[64], name[24]; GetPlayerName(playerid, name, 24); format(file, 64, "xap/Users/%s.ini", udb_encode(name)); if(DOF2_GetInt(file, "Level") >= 1 && DOF2_GetInt(file, "LoggedIn") == 1) return true; else return false;}
stock IsXLevel(playerid)
{
    new file[64], name[24]; GetPlayerName(playerid, name, 24);
    format(file, 64, "xap/Users/%s.ini", udb_encode(name));
    return DOF2_GetInt(file, "Level");
}
stock MoveObjectEx(Objectid,Float:X,Float:Y,Float:Z,Float:Speed)
{new Float:RX,Float:RY,Float:RZ;GetObjectRot(Objectid,RX,RY,RZ);
MoveObject(Objectid,X,Y,Z,Speed,RX,RY,RZ)
;return 1;}

stock ServerStats(){
	new int[128];
	format(int,128,"ServerStats.ini");
	return int;}
forward CarDiscoO(playerid);
public CarDiscoO(playerid){
new vehicleid = GetPlayerVehicleID(playerid);
if(CarDisco[playerid] == 1){
new rand = random(10);
switch(rand){
case 0: ChangeVehicleColor(vehicleid,0,93);
case 1: ChangeVehicleColor(vehicleid,243,6);
case 2: ChangeVehicleColor(vehicleid,233,151);
case 3: ChangeVehicleColor(vehicleid,222,144);
case 4: ChangeVehicleColor(vehicleid,223,65);
case 5: ChangeVehicleColor(vehicleid,198,93);
case 6: ChangeVehicleColor(vehicleid,194,126);
case 7: ChangeVehicleColor(vehicleid,183,126);
case 8: ChangeVehicleColor(vehicleid,1,125);
case 9: ChangeVehicleColor(vehicleid,164,144);
case 10: ChangeVehicleColor(vehicleid,136,6);
default: ChangeVehicleColor(vehicleid,135,131);}}
return 1;}
//================================ Honor =======================================
stock IsPlayerHonor(playerid)
{
if(DOF2_FileExists(SFile(playerid)) && strcmp(DOF2_GetString(SFile(playerid),"Honor"),"0",true))return true;
return false;
}
stock GetPlayerHonorLevel(playerid) return DOF2_GetInt(SFile(playerid),"Honor");
stock SendClientMessageToHonor(color, text[])
{
for(new i = 0; i < MAX_PLAYERS; ++i) if(IsPlayerConnected(i) && IsPlayerHonor(i) && IsPlayerXAdmin(i)) SendClientMessage(i,color,text);
return 1;
}//================================= ViP =======================================
stock IsPlayerVip(playerid)
{
if(DOF2_FileExists(SFile(playerid)) && strcmp(DOF2_GetString(SFile(playerid),"Vip"),"0",true))return true;
return false;
}
stock GetPlayerVipLevel(playerid) return DOF2_GetInt(SFile(playerid),"Vip");
stock SendClientMessageToVip(color, text[])
{
for(new i = 0; i < MAX_PLAYERS; ++i) if(IsPlayerConnected(i) && IsPlayerVip(i)) SendClientMessage(i,color,text);
return 1;
}

//============================= Supporters =====================================
stock GetSupporters(playerid)return DOF2_GetInt(SFile(playerid),"Supporters");
stock IsPlayerSupporter(playerid)
{
if(DOF2_FileExists(SFile(playerid)) && strcmp(DOF2_GetString(SFile(playerid),"Supporters"),"0",true))return true;
return false;
}
stock ReturnPlayerID(PlayerName[]) {
for(new i = 0; i < GetMaxPlayers(); i++) if(IsPlayerConnected(i)) {
new name[24]; GetPlayerName(i,name,24); if(strfind(name,PlayerName,true)!=-1) return i; }
return INVALID_PLAYER_ID;
}
stock SendMessageToSupporters(color, text[])
{
for(new i = 0; i < MAX_PLAYERS; ++i) if(IsPlayerConnected(i) && IsPlayerSupporter(i)) SendClientMessage(i,color,text);
return 1;
}
forward AllowHelpPlz(playerid); public AllowHelpPlz(playerid) return HelpPlz[playerid] = 0;
//============================= Supporters =====================================
stock GetNightTeam(playerid)return DOF2_GetInt(SFile(playerid),"NightTeam");
stock IsPlayerNightTeam(playerid)
{
if(DOF2_FileExists(SFile(playerid)) && strcmp(DOF2_GetString(SFile(playerid),"NightTeam"),"0",true))return true;
return false;
}
stock SendMessageToNightTeam(color, text[])
{
for(new i = 0; i < MAX_PLAYERS; ++i) if(IsPlayerConnected(i) && IsPlayerNightTeam(i)) SendClientMessage(i,color,text);
return 1;
}
stock TND(usage[]){
new tnd[128],day,month,year,hour,minute,second,hour_tf[3],minute_tf[3],second_tf[3];
getdate(year,month,day); gettime(hour,minute,second);
if(hour <= 9) format(hour_tf,3,"0%d",hour); else format(hour_tf,3,"%d",hour);
if(minute <= 9) format(minute_tf,3,"0%d",minute); else format(minute_tf,3,"%d",minute);
if(second <= 9) format(second_tf,3,"0%d",second); else format(second_tf,3,"%d",second);
if(!strcmp(usage, "ban", true)) format(tnd,128,"%d.%d.%d | %s:%s:%s",day,month,year,hour_tf,minute_tf,second_tf);
else if (!strcmp(usage, "logins", true)) format(tnd,128,"%s:%s",hour_tf,minute_tf,second_tf);
return tnd;}
stock BanCheckName(pName[]){ new BanFile[128]; format(BanFile, 128, "xadmin/Bans/Names/%s.ini",pName); if(!DOF2_FileExists(BanFile)) return false; return true;}

//==============================================================================
forward WeaponsCd(time,type);
public WeaponsCd(time,type){
switch(type){
case 1:{
if(WeaponsOn == 0){ KillTimer(WeaponsCd(time,type));}
if(time > 20) format(String, 256,"~w~] ~b~~h~/Weapons %d ~w~]",ActNumber),GameTextForAll(String,1000,3);
if(time < 20) format(String, 256,"~b~~h~Weapons: ~w~%d",time),GameTextForAll(String,1000,3);
if(time == 30 || time == 20 || time == 10)PlayerPlaySoundToAll(1056);
if(time > 0)SetTimerEx("WeaponsCd", 1000, 0,"dd",time-1,1);
else{
if(WeaponsOn == 1)WeaponsCd(10,2);
TeleportToWeapons();}}
case 2:{
if(!WeaponsOn)return 1;
for(new i; i < GetMaxPlayers() ;i++){
format(String, 256,"~R~Weapons: ~w~%d",time),GameTextForPlayer(i,String,1000,5);}
if(time > 0)SetTimerEx("WeaponsCd", 1000, 0,"dd",time-1,2);
else WeaponsUnfreeze();}}
return 1;}
//==============================================================================
forward WeaponsUnfreeze();
public WeaponsUnfreeze(){
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i) && InWeapons[i] == 1){
TogglePlayerControllable(i, 1),SetCameraBehindPlayer(i),GivePlayerWeapon(i,WeaponsWeapon,5000),GameTextForPlayer(i,"~G~Good ~B~ Luck ~W~ :)", 1000,5),WeaponsStarted = 1;}}}
//==============================================================================
forward TeleportToWeapons();
public TeleportToWeapons(){
for(new i;i<GetMaxPlayers();i++){
if(WeaponsPlayers < 2)return WeaponsEnd(0);
if(IsPlayerConnected(i) && InWeapons[i] == 1){
new rand = random(sizeof(WeaponsSpawns));
SetPlayerPos(i, WeaponsSpawns[rand][0], WeaponsSpawns[rand][1], WeaponsSpawns[rand][2]);
SetPlayerVirtualWorld(i,21),SetPlayerInterior(i,15),WeaponsWinnerCheck = SetTimer("WeaponsCheck",500, 1),ResetPlayerWeapons(i),SetPlayerArmour(i, 100.0),SetPlayerHealth(i, 100.0),TogglePlayerControllable(i, 0);}}
return 1;}
//==============================================================================
forward WeaponsEnd(status);
public WeaponsEnd(status){
if(status == 0){
SendClientMessageToAll(COLOR_KRED, "! ����� ��� ����� ������� Weapons -������ �"),WeaponsOn = 0,WeaponsPlayers = 0,WeaponsStarted = 0,KillTimer(WeaponsWinnerCheck);
for(new i;i<GetMaxPlayers();i++){ if(IsPlayerConnected(i))InWeapons[i] = 0;}
return 1;}
else if(status == 1){
ResetPlayerWeapons(WeaponsWinner),SpawnPlayer(WeaponsWinner),SetPlayerVirtualWorld(WeaponsWinner,0),SetPlayerInterior(WeaponsWinner,0),GivePlayerMoney(WeaponsWinner,WeaponsMoney);
SendClientMessageToAll(COLOR_WHITE, "--- Weapons System ---");
format(String, sizeof(String), ".%s :����� ���",GetName(WeaponsWinner)),SendClientMessageToAll(COLOR_ORANGE, String);
format(String, sizeof(String), ".$%s :���", GetNum(WeaponsMoney)),SendClientMessageToAll(COLOR_ORANGE, String);
format(String, sizeof(String), ".%s :����", GetWName(WeaponsWeapon)),SendClientMessageToAll(COLOR_ORANGE, String);
SendClientMessageToAll(COLOR_WHITE, "--------------------------------");
DOF2_SetInt(SFile(WeaponsWinner),"Weapons",DOF2_GetInt(SFile(WeaponsWinner),"Weapons") +1);
for(new i;i<GetMaxPlayers();i++){ if(IsPlayerConnected(i))InWeapons[i] = 0;}
WeaponsOn = 0,WeaponsPlayers = 0,WeaponsStarted = 0,KillTimer(WeaponsWinnerCheck);
return 1;}
else if(status == 2){
WeaponsOn = 0,WeaponsPlayers = 0,WeaponsStarted = 0,KillTimer(WeaponsWinnerCheck);
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
return InWeapons[i] = 0;}}}
return 1;}
//==============================================================================
forward WeaponsCheck();
public WeaponsCheck(){
for(new i;i<GetMaxPlayers();i++){
if(WeaponsStarted == 1 && WeaponsPlayers == 1){
if(IsPlayerConnected(i) && InWeapons[i] == 1){ WeaponsWinner = i,WeaponsEnd(1);}}}
return 1;}
stock GetWName(wid){
new weaponname[20];
GetWeaponName(wid, weaponname, sizeof(weaponname));
return weaponname;}
//==============================================================================
forward GunGameSpawn(playerid);
public GunGameSpawn(playerid){
SetCameraBehindPlayer(playerid),SetPlayerVirtualWorld(playerid,12);
switch(random(7)){
case 0: return SetPlayerPos(playerid, -2666.1399,-8.8469,6.1328);
case 1: return SetPlayerPos(playerid, -2666.9712,-2.1573,6.1328);
case 2: return SetPlayerPos(playerid, -2648.3340,15.1934,6.1328);
case 3: return SetPlayerPos(playerid, -2627.8428,-5.4806,6.1328);
case 4: return SetPlayerPos(playerid, -2648.5674,-26.3567,6.1328);
case 5: return SetPlayerPos(playerid, -2665.7339,-22.7553,6.1328);
case 6: return SetPlayerPos(playerid, -2631.3855,11.3821,6.1328);
case 7: return SetPlayerPos(playerid, -2631.4282,-22.4528,6.1328);}
KillTimer(GunGameSpawn1[playerid]);
return 1;}
//==============================================================================
forward GunGameWeapon(playerid);
public GunGameWeapon(playerid){
if(GunGame[playerid] == 1) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 22, 999);
if(GunGame[playerid] == 2) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 24, 999);
if(GunGame[playerid] == 3) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 25, 999);
if(GunGame[playerid] == 4) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 26, 999);
if(GunGame[playerid] == 5) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 28, 999);
if(GunGame[playerid] == 6) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 29, 999);
if(GunGame[playerid] == 7) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 30, 999);
if(GunGame[playerid] == 8) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 31, 999);
if(GunGame[playerid] == 9) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 33, 999);
if(GunGame[playerid] == 10) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 34, 999);
if(GunGame[playerid] == 11) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 16, 999);
if(GunGame[playerid] == 12) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 28, 999);
if(GunGame[playerid] == 13) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 28, 999);
if(GunGame[playerid] == 14) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 29, 999);
if(GunGame[playerid] == 15) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 29, 999);
if(GunGame[playerid] == 16) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 30, 999);
if(GunGame[playerid] == 17) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 30, 999);
if(GunGame[playerid] == 18) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 31, 999);
if(GunGame[playerid] == 19) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 31, 999);
if(GunGame[playerid] == 20) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 34, 999);
if(GunGame[playerid] == 21) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 34, 999);
if(GunGame[playerid] == 22) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 16, 999);
if(GunGame[playerid] == 23) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 16, 999);
if(GunGame[playerid] == 24) return ResetPlayerWeapons(playerid),GivePlayerWeapon(playerid, 4, 999);
KillTimer(GunGameWeapon1[playerid]);
return 1;}
//==============================================================================
forward GunGameClose(playerid);
public GunGameClose(playerid){
for(new i = 0; i < MAX_PLAYERS; i++) if(InGunGame[playerid] == 1) InGunGame[playerid] = 0,SpawnPlayer(i),SetPlayerVirtualWorld(i,0),SpawnPlayer(i),ResetPlayerWeapons(i),SendClientMessageToAll(COLOR_KRED, ".���� �������� �''� ������ Gun-Game ���� �");
return 1;}

//==============================================================================
forward LottoCount(type);
public LottoCount(type)
{
        switch(type)
        {
                case 1..2:
                {
                        lotto[LottoTimer] = SetTimerEx("LottoCount", 30*1000, 0,"d",type + 1),lotto[on] = 1;
						SendClientMessageToAll(COLOR_LIGHTBLUE, "--- Lotto System ---");
						SendClientMessageToAll(COLOR_WHITE,type == 1 ? ("! ����� ����� ����") : (".����� ��� ��� ��� ��� ����"));
						SendClientMessageToAll(COLOR_WHITE, "/Lotto [1-50] :��� ����");
						SendClientMessageToAll(COLOR_WHITE, "$2,000 :����� ����");
						SendClientMessageToAll(COLOR_WHITE, "! ������");
						SendClientMessageToAll(COLOR_LIGHTBLUE, "----------------------------------------");
                        GameTextForAll("~R~ /lotto [1-50]", 5000, 6);
                }
                case 3:
                {
                        SendClientMessageToAll(COLOR_LIGHTBLUE, "--- Lotto System ---");
                        if(lotto[winners] == 0)
                        {
                        SendClientMessageToAll(COLOR_WHITE, "! �� ��� ����� ������ �����");
						format(String, sizeof(String), ".%d :����� ���",lotto[satla]),SendClientMessageToAll(COLOR_WHITE, String);
						format(String, sizeof(String), "$%s :���� ������",GetNum(lotto[pay])),SendClientMessageToAll(COLOR_WHITE, String);
                        SendClientMessageToAll(COLOR_LIGHTBLUE, "----------------------------------------");
                        }
                        else
                        {
                        format(String, sizeof(String), "! �� ��� ����� ������ �����","");
                        for(new i; i < MAX_PLAYERS; i++)
                        if(IsPlayerConnected(i) && pInfo[i][participant] && pInfo[i][nnumber] == lotto[satla])
                        {
                                pInfo[i][nnumber] = 0;
                                pInfo[i][participant] = 0;
                                GivePlayerMoney(i, lotto[pay] / lotto[winners]);
                                format(String, sizeof(String), ".��� ����� %s",GetName(i));
                                SendClientMessageToAll(-1, String);
                                DOF2_SetInt(SFile(i),"Lotto",DOF2_GetInt(SFile(i),"Lotto") +1);
                        }
						format(String, sizeof(String), ".%d :����� ���",lotto[satla]),SendClientMessageToAll(COLOR_WHITE, String);
						format(String, sizeof(String), "$%s :���� ������",GetNum(lotto[pay])),SendClientMessageToAll(COLOR_WHITE, String);
                        SendClientMessageToAll(COLOR_LIGHTBLUE, "----------------------------------------");
                        for(new i; i < MAX_PLAYERS; i++) pInfo[i][participant] = 0;
                        lotto[satla] = 0,lotto[on] = 0,lotto[choose][lotto[satla]] = -1,lotto[pay] = 0,KillTimer(lotto[LottoTimer]);
                        lotto[winners] = 0;
                        }
}
}
        return 1;
}
//==============================================================================
forward JaSHqCloseMain(); public JaSHqCloseMain() return MoveObject(JaSOpenMain1,2517.29980469,1827.50000000,13.50000000,3.0),MoveObject(JaSOpenMain2,2517.30004883,1818.69995117,13.50000000,3.0);
forward JaSHqClose2(); public JaSHqClose2() return MoveObject(JaSOpen2, 2586.89990234,1691.59997559,8.10000038,3.0);

forward HqqHqCloseMain(); public HqqHqCloseMain() return MoveObject(Hqq,2798.0000000,1312.9000244,12.6999998,3.0);
forward HqqHqClose2(); public HqqHqClose2() return MoveObject(Hqq1,2842.5000000,1290.9000244,13.1999998,3.0);

forward VoLHqCloseMain(); public VoLHqCloseMain() return MoveDynamicObject(HqAviran[0],1447.1999500,663.0000000,12.4000000,3.0);
forward VoLHqClose2(); public VoLHqClose2() return MoveDynamicObject(HqAviran[1],1533.9000200,744.2999900,12.1000000,3.0);

forward CpTHqCloseMain(); public CpTHqCloseMain() return MoveDynamicObject(HqCpT[0],2316.6001000,2402.8999000,12.4000000,3.0);
forward CpTHqClose2(); public CpTHqClose2() return MoveDynamicObject(HqCpT[1],2365.3999000,2259.1999500,25.5000000,3.0);


stock Hq(vehicleid){
new file[256];
format(file,sizeof(file),"Car/car%d.txt",vehicleid);
DOF2_SetInt(file,"Buyable",-1);}

stock UnBuyAble(vehicleid){
new file[256];
format(file,sizeof(file),"Car/car%d.txt",vehicleid);
DOF2_SetInt(file,"Buyable",0);}

stock BuyAble(vehicleid){
new file[256];
format(file,sizeof(file),"Car/car%d.txt",vehicleid);
DOF2_SetInt(file,"Buyable",1);}

stock Special(vehicleid){
new file[256];
format(file,sizeof(file),"Car/car%d.txt",vehicleid);
DOF2_SetInt(file,"Buyable",2);}

stock Pizza(vehicleid){
new file[256];
format(file,sizeof(file),"Car/car%d.txt",vehicleid);
DOF2_SetInt(file,"Buyable",3);}


stock IsNickValid(const nick[])
{
	new strlen_nick = strlen(nick);
    if(strlen_nick < 3 || strlen_nick > 24) return false;
    for(new i = 0; i < strlen_nick; ++i)
{
	switch(nick[i])
{
	case 'A' .. 'Z': { }
	case 'a' .. 'z': { }
	case '0' .. '9': { }
	case '[',']' ,'_': { }
	case '(',')' ,'.': { }
 	default: return false;
}}
	return true;
}
forward TdmClose(playerid);
public TdmClose(playerid){
for(new i = 0; i < GetMaxPlayers(); i++){
if(IsPlayerConnected(i) && InTDM[i] == 1){
SetPlayerRandomSpawn(i);
ResetPlayerWeapons(playerid),SetPlayerSkin(playerid,OldInfo[playerid][1]),SetPlayerColor(playerid,OldInfo[playerid][0]);
InTDM[playerid] = 0,InTeamA[playerid] = 0,InTeamB[playerid] = 0,teamaplayers --,teambplayers --,SetPlayerTeam(playerid, playerid),TextDrawHideForPlayer(playerid, CopsPoints),TextDrawHideForPlayer(playerid, GangPoints);}}
CantUseTDM=true;
SendClientMessageToAll(COLOR_KRED, ".���� �������� �''� ������ TDM ���� �");
DOF2_RemoveFile("TeamAS.txt"),DOF2_RemoveFile("TeamBS.txt"),InTDM[playerid] = 0;
return 1;}
forward SendMSG();
public SendMSG(){
new randMSG = random(sizeof(RandomMSG));
SendClientMessageToAll(Color_BB, RandomMSG[randMSG]);
return 1;}
forward CodeFinish();
public CodeFinish(){
if(CodeOn == 0) return 0;
SendClientMessageToAll(COLOR_ORANGE,".�� ��� �� ��� �� ����"),CodeOn = 0;
return 1;}
forward GMXCD(cdf);
public GMXCD(cdf)
{
new string[256];
format(string,sizeof(string),"~b~Restart: ~w~%d",cdf);
GameTextForAll(string,1100,6);
if(cdf >=1)cdf--,SetTimerEx("GMXCD",1000,0,"%d",cdf);
else if(cdf == 0) GameTextForAll("~b~GMX!!",5000,6),GameModeExit();
return 1;}

forward SpamUpdate(playerid); public SpamUpdate(playerid)return SetPVarInt(playerid,"ASpam",0);

stock ClanFile(ClanName[])
{
new sstr[80];
format(sstr, 80, "Clans/%s.ini", ClanName);
return sstr;
}

stock DRGB2HEX(R,G,B,A)
{
new newcolor[32];
format(newcolor,32,"%06x",((R * 16777216) + (G * 65536) + (B * 256) + A) >>> 8);
return newcolor;
}

forward SpawnGod(playerid); public SpawnGod(playerid) return SetPlayerHealth(playerid,100.0);
forward satlatimer(playerid);
public satlatimer(playerid) return Kick(playerid);

forward PlayerUpLevel(playerid);
public PlayerUpLevel(playerid)
{
	DOF2_SetInt(SFile(playerid),"Level",DOF2_GetInt(SFile(playerid),"Level") +1);
	format(String, sizeof(String),"! %d ��� ���� %s",DOF2_GetInt(SFile(playerid),"Level"),GetName(playerid)),SendClientMessageToAll(0x8B00A0FF,String);
	format(String, sizeof(String),"! %d ��� ���! ���� ����",DOF2_GetInt(SFile(playerid),"Level")),SendClientMessage(playerid,COLOR_LIGHTGREEN,String),GivePlayerWeapon(playerid,16,5),GivePlayerWeapon(playerid, 14,1);
	return 1;
}

forward KickPublic(playerid);
public KickPublic(playerid) { Kick(playerid); }

//=============================== [Rules] ======================================
stock GetConnectedPlayers() { new Players; for(new i = 0; i < GetMaxPlayers(); i++) if(IsPlayerConnected(i)) Players++; return Players; }
//==============================================================================
public UpdateTimeAndWeather()
{
	// Update time
	new Days,Months,Years;
	getdate(Years, Months, Days);
    gettime(shour, sminute);
   	format(timestr,32,"%02d:%02d",shour,sminute);
   	TextDrawSetString(txtTimeDisp,timestr);
   	format(timestr,32,"%d/%d/%d",Days,Months,Years);
   	TextDrawSetString(Textdraw0,timestr);
}
//==============================================================================
forward StuntMissionTime(playerid);
public StuntMissionTime(playerid)
{
	if(GetPVarInt(playerid,"InStuntMission") == 1) return format(String, sizeof(String), "[Stunt Mission] >> .���� ������ ������ %s", GetName(playerid)),SendClientMessageToAll(COLOR_ORANGE, String),DisablePlayerRaceCheckpoint(playerid),KillTimer(StuntMissionTime(playerid)),StuntMissionDo = 0,SetPVarInt(playerid,"InStuntMission",0),SetPlayerHealth(playerid,0);
	return 1;
}
forward StuntCd(time,type);
public StuntCd(time, type)
{
	for(new i;i <GetMaxPlayers();i++) if(IsPlayerConnected(i) && GetPVarInt(i,"InStuntMission") == 1)
	{
		if(GetPVarInt(i,"InStuntMission") == 0) KillTimer(StuntCd(time,type));
		format(String, 256,"~R~%d",time),GameTextForPlayer(i,String,5000,6);
		if(time == 10 || time == 5 || time == 3)PlayerPlaySoundToAll(1056);
		if(time > 0)SetTimerEx("StuntCd", 1000, 0,"dd",time-1,1);
		if(time == 0){
		format(String, sizeof(String), "[Stunt Mission] << .���� ������ ������ %s", GetName(i));
		SendClientMessageToAll(COLOR_ORANGE, String);
		SetPVarInt(i,"InStuntMission",0);
		SetPlayerHealth(i,0),StuntMissionDo = 0;
		KillTimer(StuntMissionTime(i));
		DestroyVehicle(StuntCar);
		DisablePlayerRaceCheckpoint(i);
		}
	}
	return 1;
}
forward MoneyCd(time,type);
public MoneyCd(time,type)
{
	for(new i;i<GetMaxPlayers();i++) if(IsPlayerConnected(i) && GetPVarInt(i,"InMoneyMission") == 1)
	{
		if(GetPVarInt(i,"InMoneyMission") == 0 && time == 0)return KillTimer(MoneyCd(time,type));
		format(String, 256,"~R~%d",time),GameTextForPlayer(i,String,5000,6);
		if(time == 10 || time == 5 || time == 3)PlayerPlaySoundToAll(1056);
		if(time > 0)SetTimerEx("MoneyCd", 1000, 0,"dd",time-1,1);
		if(time == 0)format(String, sizeof(String), "[Money Mission] << .���� ������ ���� ����� %s", GetName(i)),MoneyCd(0,0),SendClientMessageToAll(COLOR_ORANGE, String),SetPVarInt(i,"InMoneyMission",0),SetPlayerHealth(i,0),MoneyMissionPickup = CreatePickup(1550 , 2, -2667.6865,732.2017,27.9531, 0),KillTimer(MoneyMissionTimer);
	}
	return 1;
}
forward TriviaFinish();
public TriviaFinish()
{
	if(TriviaOn == 0)return 0;
	SendClientMessageToAll(COLOR_WHITE,"--- Trivia System ---");
	SendClientMessageToAll(COLOR_PINK,".�� ��� �� ��� �� ������");
	SendClientMessageToAll(COLOR_PINK,":������ �����");
	format(String, sizeof(String), "%s",Answer),SendClientMessageToAll(COLOR_PINK,String);
	SendClientMessageToAll(COLOR_WHITE,"------------------------------------------");
	TriviaOn = 0;
	return 1;
}
forward CarGodMod();
public CarGodMod()
{
     new Float:hp;
     for(new c = 1; c <= MAX_VEHICLES; c++) if(CarGM[c]==1)
     {
          GetVehicleHealth(c, hp);
          if(hp<1000.0) SetVehicleHealth(c,1000),RepairVehicle(c);
     }
}
forward WhatIsNowTime();
public WhatIsNowTime()
{
	new Hours,Minutes;
	gettime(Hours,Minutes);
	if(Minutes == 0) switch(Hours)
	{
		case 0..23: return format(String,sizeof(String),"[Time] >> .%02d:%02d :���� ��� ���",Hours,Minutes),SendClientMessageToAll(Color_GMX,String);
	}
	return 1;
}
//==============================================================================

forward PlayerLozzeBattle(playerid);
public PlayerLozzeBattle(playerid)
{
new IdWinner, idLoozer,string3[256];
if(battle[playerid][Inviter]==1)
{
IdWinner = battle[playerid][IDJoin];
idLoozer = battle[IdWinner][IDInvite];
}
else if(battle[playerid][joiner]==1)
{
IdWinner = battle[playerid][IDInvite];
idLoozer = battle[IdWinner][IDJoin];
}
GivePlayerMoney(IdWinner,battle[IdWinner][MoneyBattle]*2);
format(string3,256 , "[Battle] >> $%d -����� ���� � ''%s'' ���� �� ����� ''%s''", battle[IdWinner][MoneyBattle],GetName(idLoozer),GetName(IdWinner));
SendClientMessageToAll(COLOR_SATLA,string3);
SetPlayerRandomSpawn(IdWinner);
SetPlayerRandomSpawn(idLoozer);
// ����� ������
battle[IdWinner][InBattle] = 0;
battle[idLoozer][InBattle] = 0;
SetPlayerHealth(IdWinner, 100);
SetPlayerArmour(IdWinner,0);
battle[IdWinner][Inviter] = 0;
battle[IdWinner][joiner] = 0;
battle[idLoozer][Inviter] = 0;
battle[idLoozer][joiner] = 0;
return 1;
}

forward CountBattlE(playerid);
public CountBattlE(playerid)
{
if(battle[playerid][CountBattle] == 0)
{
KillTimer(battle[playerid][TimerCountBattle]);
GameTextForPlayer(playerid,"~r~Good Luck",1000,6);
TogglePlayerControllable(playerid, 1);
}else if(battle[playerid][CountBattle] > 0)
{
format(battle[playerid][sstring2], 128, "~g~%d", battle[playerid][CountBattle]);
GameTextForPlayer(playerid,battle[playerid][sstring2],1000,6);
}
battle[playerid][CountBattle] --;
return 1;
}

forward NoAcceptBattle(playerid);
public NoAcceptBattle(playerid)
{
new ID = battle[playerid][IDJoin];

battle[ID][InviteMe] = 0;
battle[playerid][InviteAnyOne] = 0;
battle[ID][MoneyBattle] = 0;
battle[playerid][MoneyBattle] = 0;
SendClientMessage(playerid,COLOR_ORANGE,"..�� ���� �� ������ ��� ����� ''%s'' �����");
return 1;
}
//==============================================================================
forward SetPlayerRandomSpawn(playerid);
public SetPlayerRandomSpawn(playerid){
SetPlayerHealth(playerid,9999999.9),SetTimerEx("SpawnGod",3000,0,"d",playerid);
new rand = random(sizeof(RandSpawn));
SetPlayerPos(playerid, RandSpawn[rand][0], RandSpawn[rand][1], RandSpawn[rand][2]);
if(DOF2_GetInt(SFile(playerid),"Golf") == 1){ GivePlayerWeapon(playerid,2,1);}
if(DOF2_GetInt(SFile(playerid),"Knife") == 1){ GivePlayerWeapon(playerid,4,1);}
if(DOF2_GetInt(SFile(playerid),"BaseBall") == 1){ GivePlayerWeapon(playerid,5,1);}
if(DOF2_GetInt(SFile(playerid),"ChineSaw") == 1){ GivePlayerWeapon(playerid,9,1);}
if(DOF2_GetInt(SFile(playerid),"Pistol") == 1){ GivePlayerWeapon(playerid,22,DOF2_GetInt(SFile(playerid),"GAmmo"));}
if(DOF2_GetInt(SFile(playerid),"SPistol") == 1){ GivePlayerWeapon(playerid,23,DOF2_GetInt(SFile(playerid),"GAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Eagle") == 1){ GivePlayerWeapon(playerid,24,DOF2_GetInt(SFile(playerid),"GAmmo"));}
if(DOF2_GetInt(SFile(playerid),"ShoutGun") == 1){ GivePlayerWeapon(playerid,25,DOF2_GetInt(SFile(playerid),"GunAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Combat") == 1){ GivePlayerWeapon(playerid,27,DOF2_GetInt(SFile(playerid),"GunAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Sawn") == 1){ GivePlayerWeapon(playerid,26,DOF2_GetInt(SFile(playerid),"GunAmmo"));}
if(DOF2_GetInt(SFile(playerid),"MP5") == 1){ GivePlayerWeapon(playerid,29,DOF2_GetInt(SFile(playerid),"AssAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Uzi") == 1){ GivePlayerWeapon(playerid,28,DOF2_GetInt(SFile(playerid),"AssAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Tec9") == 1){ GivePlayerWeapon(playerid,32,DOF2_GetInt(SFile(playerid),"AssAmmo"));}
if(DOF2_GetInt(SFile(playerid),"M4") == 1){ GivePlayerWeapon(playerid,31,DOF2_GetInt(SFile(playerid),"MaAmmo"));}
if(DOF2_GetInt(SFile(playerid),"AK47") == 1){ GivePlayerWeapon(playerid,30,DOF2_GetInt(SFile(playerid),"MaAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Country") == 1){ GivePlayerWeapon(playerid,33,DOF2_GetInt(SFile(playerid),"RilfeAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Sniper") == 1){ GivePlayerWeapon(playerid,34,DOF2_GetInt(SFile(playerid),"RilfeAmmo"));}
if(DOF2_GetInt(SFile(playerid),"Armour") == 1){ SetPlayerArmour(playerid,100);}
if(DOF2_GetInt(SFile(playerid),"HaveSkin") == 1)return SetPlayerSkin(playerid, DOF2_GetInt(SFile(playerid), "Skin"));
return 1;
}
//==============================================================================
stock Teleport(playerid, telename[], Float:Vx, Float:Vy, Float:Vz, Float:Va, Float:Px, Float:Py, Float:Pz, Float:Pa,vw,interior)
{
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 553 && 520 && 593 && 512 && 511 && 577 && 592 && 556 && 557 && 601 && 432 && 476 && 449 && 519 && 532 && 406 && 570 && 594 && 564 && 465 && 501 && 464 && 446 && 513 && 441 && 454 && 452 && 460 && 453 && 430 && 484 && 595 && 493 && 473 && 472 && 447 && 469 && 425)return SendClientMessage(playerid,COLOR_KRED,"! �� ���� ������ �� ��� ��");
	format(String, sizeof(String), "%s",telename),SendClientMessage(playerid,COLOR_LIGHTGREEN,String);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) return SetVehiclePos(GetPlayerVehicleID(playerid),Vx,Vy,Vz+0.2),SetVehicleZAngle(GetPlayerVehicleID(playerid),Va),SetCameraBehindPlayer(playerid),SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),vw),LinkVehicleToInterior(GetPlayerVehicleID(playerid),interior);
	else SetPlayerPosEx(playerid,Px,Py,Pz,Pa),SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid,interior),SetPlayerVirtualWorld(playerid,vw);
	return 1;
}
//==============================================================================
stock TeleportFoot(playerid, telename[],Float:Px, Float:Py, Float:Pz, Float:Pa,vw,interior)
{
	format(String, sizeof(String), "%s",telename),SendClientMessage(playerid,COLOR_LIGHTGREEN,String),SetPlayerPosEx(playerid,Px,Py,Pz,Pa),SetCameraBehindPlayer(playerid),SetPlayerInterior(playerid, interior),SetPlayerVirtualWorld(playerid, vw);
	return 1;
}
stock SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, Float:a)return SetPlayerPos(playerid, x, y, z), SetPlayerFacingAngle(playerid, a);
//==============================================================================

stock CFile(vehicleid){
	new file[256];
	format(file, sizeof(file), "Car/car%d.txt",vehicleid);
	return file;
}
stock GetRad(playerid) return DOF2_GetInt(SFile(playerid), "Radius");
stock IsCarInRangeOfPoint(vehicleid, Float:range, Float:x, Float:y, Float:z)
{
        new Float:px,Float:py,Float:pz;
        GetVehiclePos(vehicleid,px,py,pz);
        px -= x;
        py -= y;
        pz -= z;
        return ((px * px) + (py * py) + (pz * pz)) < (range * range);
}
stock IsSkinValid(SkinID) return ((SkinID >= 0 && SkinID <= 1)||(SkinID == 2)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)
||(SkinID >= 43 && SkinID <= 85)||(SkinID >=87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)
||(SkinID >= 209 && SkinID <= 272)||(SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID <= 299)) ? true:false;
//==============================================================================
public SwarStart()
{
    ActNumber = 5 + random(28);
    SendClientMessageToAll(0x0EBFDEC8, " --- Swar System ---");
	SendClientMessageToAll(COLOR_WHITE, "! ������ ������� ����");
	SendFormatMessageToAll(COLOR_WHITE,"/Swar %d - ���� ������  ���/�",ActNumber);
	format(String,sizeof(String),"{A0D911}$%s{FFFFFF} ��� �����",GetNum(SwarReward));
	SendClientMessageToAll(COLOR_WHITE,String);
	SendClientMessageToAll(COLOR_WHITE," ������ �����");
	SendClientMessageToAll(0x0EBFDEC8, "--------------------------------");
	atime = gettime();
	SwarOn = 1;
	SwarPlayers = 0;
	CallRemoteFunction("Countdowns","ii",25,0);
	return 1;
}
//===
public TeleportPlayersToSwar()
{
    new s;
    if(SwarPlayers < MInSwarPlayers) return CallRemoteFunction("SwarEnd","ii",0,-1);
    for(new i; i<GetMaxPlayers(); i++)
    {
        if(IsPlayerConnected(i) && InSwar[i])
        {
            new rand = random(sizeof(Spawns));
            ResetPlayerWeapons(i);
            Swar[i] = CreateVehicle(560,Spawns[rand][0],Spawns[rand][1],Spawns[rand][2],Spawns[rand][3],-1,-1,60000);
            s++;
            SetVehicleVirtualWorld(Swar[i],1);
            SetPlayerVirtualWorld(i,1);
            ResetPlayerWeapons(i);
            SetPlayerTime(i,0,0);
            PutPlayerInVehicle(i,Swar[i],0);
            TogglePlayerControllable(i, 0);
            SetCameraBehindPlayer(i);
            SetTimer("Unfreeze",10000,0);
            CallRemoteFunction("Countdowns","ii",5,1);
            InSwar[i] = 2;
            SwarOn = 2;
        }
    }
    return 1;
}
//===
public Countdowns(Time,Num)
{
	if(Time > 20) format(String, 256,"~w~] ~b~~h~/swar %d ~w~]",ActNumber),GameTextForAll(String,1000,4);
	if(Time < 20) format(String, 256,"~b~~h~swar: ~w~%d",Time),GameTextForAll(String,1000,4);
 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(Time > 0) GameTextForPlayer(i,String,1000,4);
			if(Time <= 10 && Num)
			{
				PlayerPlaySound(i,1058, 0.0, 0.0, 0.0);
			}
		}
	}
	if(Time >= 1 && SwarOn)
	{
		Time --;
		CountTimer = SetTimerEx("Countdowns", 1000, 0,"ii",Time,Num);
	}
	else if(!Time && !Num && SwarOn)
	{
		CallRemoteFunction("TeleportPlayersToSwar","");
	}
	else if(!Time && Num && SwarOn)
	{
	    CallRemoteFunction("Unfreeze","");
	}
	return 1;
}
//===
public SwarEnd(Num,Winner)
{
	if(Num == 0)
	{
		SendClientMessageToAll(COLOR_KRED,"������� ����� ��� ���� �������");
		for(new i; i<MAX_PLAYERS; i++)
		{
		    if(IsPlayerConnected(i) && InSwar[i] != 0)
		    {
       			InSwar[i] = 0;
			}
		}
		SwarPlayers = 0;
		SwarReward = 0;
		SwarOn = 0;
	}
	else if(Num == 1)
	{
		format(knob, sizeof(knob), ".Swar ���� �� ������ � \"%s\" ������", Adminname);
		SendClientMessageToAll(0xFFFF00C8, knob);
		KillTimer(CountTimer);
		for(new i; i<MAX_PLAYERS; i++)
		{
		    if(IsPlayerConnected(i) && InSwar[i] != 0)
		    {
		    	if(InSwar[i] == 3)
				{
					SetPlayerPos(i,Position[i][0],Position[i][1],Position[i][2]);
		    		DestroyVehicle(Swar[i]);
		    		SetPlayerVirtualWorld(i,0);
				}
            	InSwar[i] = 0;
			}
		}
		SwarPlayers = 0;
		SwarReward = 0;
		SwarOn = 0;
	}
	else if(Num == 2)
	{
	    SendClientMessageToAll(COLOR_WHITE," --- Swar System --- ");
	    SendClientMessageToAll(COLOR_ORANGE,"! ������� �������");
	    format(String,256,".%s :����� ���",GetName(Winner));
	    SendClientMessageToAll(COLOR_ORANGE,String);
    	SendClientMessageToAll(COLOR_WHITE, "--------------------------------");
	    GivePlayerMoney(Winner,SwarReward);
	    SetPlayerPos(Winner,Position[Winner][0],Position[Winner][1],Position[Winner][2]);
		SwarPlayers = 0;
		SwarOn = 0;
		SetPlayerVirtualWorld(Winner,0);
		SwarReward = 0;
		InSwar[Winner] = 0;
		DestroyVehicle(Swar[Winner]);
		for(new i; i<MAX_PLAYERS; i++)
		{
		    if(IsPlayerConnected(i) && InSwar[i] != 0)
		    {
		        InSwar[i] = 0;
			}
		}
	}
	return 1;
}
//===
public Unfreeze()
{
	for(new i; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && InSwar[i] == 2)
	    {
	        TogglePlayerControllable(i, 1);
	        GameTextForPlayer(i,"~G~Good ~B~Luck",3000,4);
	        InSwar[i] = 3; SwarOn = 3;
		}
	}
	return 1;
}
//===
public CheckPlayers(PlayersNumber)
{
	if(PlayersNumber == 1)
	{
	    for(new i; i<MAX_PLAYERS; i++)
	    {
	        if(IsPlayerConnected(i) && InSwar[i] == 3 && SwarOn == 3)
			{
				SwarEnd(2,i);
			}
		}
	}
	return 1;
}

stock SendClanMessage(playerid,color,const string[])
{
for(new i = 0; i < MAX_PLAYERS; i++)
{
if(!strcmp(DOF2_GetString(SFile(playerid), "Clan"), DOF2_GetString(SFile(i), "Clan"), true))
{
SendClientMessage(i,color,string);
}
}
}
//==============================================================================
stock IsValidEmail(string[])
{
    new count, count2;
    for(new i; i < strlen(string); i++)
    {
        if(string[i] == '.') count++;
        if(string[i] == '@') count2++;
    }
    if(count < 1 || count > 2 || count2 != 1) return 0;
    return 1;
}
//==============================================================================
public TanksCD(){
if(TanksCount > 20) format(String, 256,"~w~] ~b~~h~/Tanks %d ~w~]",ActNumber),GameTextForAll(String,1000,3);
if(TanksCount < 20) format(String, 256,"~b~~h~Tanks: ~w~%d",TanksCount),GameTextForAll(String,1000,3);
if(TanksCount > 0){
--TanksCount;
SetTimer("TanksCD",1000,0);}
else{
if(TanksCountFuc == 1){
TeleportToTanks();
if(Tanksknoob == 1){
TanksCount = 10; TanksCD(); TanksCountFuc = 2;
}}
if(TanksCountFuc == 2 && TanksCount <= 0){
TanksUnFreeze();
}}
if(TanksCount == -1){
TanksEnd(2);}
}

forward TeleportToTanks();
public TeleportToTanks()
{
if(TanksPlayers < MinTanksPlayers)return TanksEnd(0);
for(new i; i < GetMaxPlayers(); i++)
{
if(InTanks[i] == 1)
{
SetPlayerVirtualWorld(i,0);
new rand = random(sizeof(TanksSpawns));
TanksCar[i] = CreateVehicle(432,TanksSpawns[rand][0],TanksSpawns[rand][1],TanksSpawns[rand][2],0,0,0,100000);
PutPlayerInVehicle(i,TanksCar[i],0);
SetVehicleVirtualWorld(TanksCar[i],0);
LinkVehicleToInterior(TanksCar[i],0);
SetVehicleHealth(TanksCar[i], 20000.0);
SetPlayerInterior(i,0);
Tanksknoob = 1;
ResetPlayerWeapons(i);
SetPlayerHealth(i, 100.0);
TogglePlayerControllable(i, 0);
}
}
TanksWinnerCheck = SetTimer("TanksCheck",500, 1);
return 1;
}

public TanksUnFreeze(){
for(new i;i<GetMaxPlayers();i++) {
if(IsPlayerConnected(i) && InTanks[i] == 1){
TogglePlayerControllable(i, 1),SetCameraBehindPlayer(i);
GameTextForPlayer(i,"~G~Good ~B~ Luck ~W~ :)", 1000,5);
}}
PlayerPlaySoundToAll(1056);
TanksStarted = 1;
return 1;}

public TanksEnd(status){
if(status == 0){
SendClientMessageToAll(COLOR_KRED,"������� ����� ��� ���� �������");
TanksOn = 0,TanksPlayers = 0,KillTimer(TanksWinnerCheck),TanksStarted = 0;
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
InTanks[i] = 0;
Tanksknoob = 0;}
}
return 1;}
else if(status ==1){
new TanksWinnerName[MAX_PLAYER_NAME];
GetPlayerName(TanksWinner,TanksWinnerName,sizeof(TanksWinnerName));
ResetPlayerWeapons(TanksWinner);
SetPlayerVirtualWorld(TanksWinner,0);
SetPlayerInterior(TanksWinner,0);
SetPlayerRandomSpawn(TanksWinner);
GivePlayerMoney(TanksWinner,TanksReward);
SendClientMessageToAll(COLOR_WHITE, " --- Tanks System ---");
SendClientMessageToAll(COLOR_ORANGE, "! ������� �������");
format(String, sizeof(String), ".%s :����� ���",TanksWinnerName);
SendClientMessageToAll(COLOR_ORANGE, String);
SendClientMessageToAll(COLOR_WHITE, "--------------------------------");
DOF2_SetInt(SFile(TanksWinner),"Tanks",DOF2_GetInt(SFile(TanksWinner),"Tanks") +1);
for(new i;i<GetMaxPlayers();i++)DestroyVehicle(TanksCar[i]);
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
InTanks[i] = 0;
Tanksknoob = 0;
}}
TanksOn = 0,TanksPlayers = 0,TanksStarted = 0;
KillTimer(TanksWinnerCheck);
return 1;
}

else if(status == 2) {
TanksPlayers = 0;
TanksStarted = 0;
TanksOn = 0;
Tanksknoob = 0;
KillTimer(TanksWinnerCheck);
for(new i;i<GetMaxPlayers();i++)DestroyVehicle(TanksCar[i]);
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i)){
return InTanks[i] = 0;
}}
}
return 1;
}

public TanksCheck() {

if(TanksStarted == 1 && TanksPlayers == 1){
for(new i;i<GetMaxPlayers();i++){
if(IsPlayerConnected(i) && InTanks[i] == 1){
TanksWinner = i;
TanksEnd(1);
}}}
return 1;
}
forward Rules(playerid, num);
public Rules(playerid, num)
{
	if(DOF2_GetInt(SFile(playerid), "ReadRules") == 0)
	{
		switch(num)
		{
		    case 0: ShowPlayerDialog(playerid, RulesDialog1, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 1 - ����� ��'���� / �����\n\n.��� ������ ��'���� / ����� ����\n����� ��� ���� �� ��� �� ����� ������� �����", "����", ""), RulesTimer[playerid] = SetTimerEx("Rules", 4*1000, 0, "dd", playerid, 1);
			case 1: ShowPlayerDialog(playerid, RulesDialog2, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 2 - ����� ���� �����\n\n.��� ������ ���� �� �����, ����� ������ ������ ���� �� ����� ���\n.����� ��� ����� �� ��� �� ���� ���� �� ����� ����� ������ �� ����� ����� ����", "����", ""),  RulesTimer[playerid] = SetTimerEx("Rules", 4*1000, 0, "dd", playerid, 2);
			case 2: ShowPlayerDialog(playerid, RulesDialog3, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 3 - �����\n\n.��� ����� ���� ����� ����� / ������ / �����\n.����� ��� ����� �� ��� �� ����� ������� �����", "����", ""),  RulesTimer[playerid] = SetTimerEx("Rules", 4*1000, 0, "dd", playerid, 3);
			case 3: ShowPlayerDialog(playerid, RulesDialog4, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 4 - �������\n\n��� ����� �� ���� ��'�� ����\n/Report [id] [reason] :���� ����� �� ���� �������� ������ ������\n.����� ������ �� ����� �� ������ �� ����� ���� ����� ����� ����� ���� ���� �������� ����� ����", "����", ""),  RulesTimer[playerid] = SetTimerEx("Rules", 4*1000, 0, "dd", playerid, 4);
			case 4: ShowPlayerDialog(playerid, RulesDialog5, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 5 - ������ ����\n\n!��� ���� ����� �� ���� ��� ���� �� ������\n.����� ���� ������ ����� �� ���� ��� ��� ���� �� ������ ����� �� ���� ����� ������ ���� ����\n.����� ���� ����� ���� ��� ���� �� ������ ����� ���� ���", "����", ""),  RulesTimer[playerid] = SetTimerEx("Rules", 4*1000, 0, "dd", playerid, 5);
			case 5: ShowPlayerDialog(playerid, RulesDialog6, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 6 - ����� ���\n\n.���� �� ����� ������� ����\n.����� �� ���� ����� ���� �� ���� ��� ������ ����� ���� ����� ���� �''� ����� �� ������� ���\n.����� ����� ��� ��� ������� ���� ������ ������ ������", "����", ""),  RulesTimer[playerid] = SetTimerEx("Rules", 4*1000, 0, "dd", playerid, 6);
			case 6: ShowPlayerDialog(playerid, RulesDialog7, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 7 - ����\n\n.���� ��� ����� �� ������ �����: �����\n.������ ���� ��� �������� ������ �� ������� ����� ������ ����� ���� ���, �������, ����� ����\n.����� ������ ����� �� ��� �� ��� ���", "����", ""),  RulesTimer[playerid] = SetTimerEx("Rules", 4*1000, 0, "dd", playerid, 7);
			case 7: ShowPlayerDialog(playerid, RulesDialog8, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 8 - ����� ������\n\n.����� ������ ������� ��� ���� ������ ������, ����� �������� ������ ����� ������ ��� ����� ���� �� ��-�������\n.�����, ����� ������ ����� ������� ������� ��'�����, ������ �� ���� �� ��� ����� ��'�� �� ���\n.����� ������ ��� ���� �� ��� �� ��� ���", "����", ""),  RulesTimer[playerid] = SetTimerEx("Rules", 4*1000, 0, "dd", playerid, 8);
			case 8: ShowPlayerDialog(playerid, RulesDialog9, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 9 - ����� �����\n\n.���� ����� ������� ����� ������ ������, ������ ������ ����� ���� �� ����� ����, ��� ���� ��� ���\n.����� ������ ���, ����� ���� ������ �����\n.��� ����� ����� ����� ������ ��� ���� ����� ��� ����� �� ��� �� ���� ���� ���", "����", ""),  RulesTimer[playerid] = SetTimerEx("Rules", 4*1000, 0, "dd", playerid, 9);
			case 9: ShowPlayerDialog(playerid, RulesDialog10, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 10 - ����� ������\n\n!��� ����� �� ������ ��� ��� ����\n.��� ����� ����� �� ��� �� ������ ��� ���� ����� ���� ���", "����", ""),  RulesTimer[playerid] = SetTimerEx("Rules", 4*1000, 0, "dd", playerid, 10);
			case 10: ShowPlayerDialog(playerid, RulesDialog11, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 11 - ����� ������ ����� ��'��\n\n.��'�� ��� �� ��� ������\n.����� ��� ����� �� ��� �� ���� ����", "����", ""),  RulesTimer[playerid] = SetTimerEx("Rules", 4*1000, 0, "dd", playerid, 11);
			case 11: ShowPlayerDialog(playerid, RulesDialog12, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 12 - ����� ���\n\n!��� ����� ���� ���� ��� ���� �� ���� ���� ��� �����\n.���� ����� ����� ���� ���� ���� ����\n.����� ��� ����� �� ��� �� ���� �� ��� ������ / �����", "����", ""),  RulesTimer[playerid] = SetTimerEx("Rules", 4*1000, 0, "dd", playerid, 12);
			case 12: ShowPlayerDialog(playerid, RulesDialog13, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 13 - ����� ���\n\n.����� �� ���� / ���� / ��� �� �� ��� �� ��� ����� ��� ��� ���� ����� ��� ������� �����\n��� ���� ����� ��� ������� �����: �������, ������ ����� �������� ������\n.����� ����� �� ��� �� ��� ���", "����", ""),  RulesTimer[playerid] = SetTimerEx("Rules", 4*1000, 0, "dd", playerid, 13);
			case 13: ShowPlayerDialog(playerid, RulesDialog14, DIALOG_STYLE_MSGBOX, "���� ����", "��� ��' 14 - �'�����\n\n.����� ��������� ��� ����� ����� ������ ���� ����� - (Joypad) �'�����\n.������ ������ �������� ���� ���� ���� ����� ����� �� ��� ����� ����\n.����� ����� �� ��� �� ��� ���", "����", ""),  RulesTimer[playerid] = SetTimerEx("Rules", 4*1000, 0, "dd", playerid, 14);
			case 14: ShowPlayerDialog(playerid, RulesDialog15, DIALOG_STYLE_MSGBOX, "���� ����", ".���! ������ �� ������\n\n.������ �� \"����\" ���� ����� �� ��� ����� ������", "����", "");
		}
	}
	return 1;
}
stock GetName(playerid)
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Name, sizeof(Name));
	return Name;
}
stock GetIP(playerid)
{
	new Ip[16];
	GetPlayerIp(playerid, Ip, 16);
	return Ip;
}
rgba2hex(r, g, b, a) return (r * 16777216) + (g * 65536) + (b * 256) + a;
stock strrest(const string[],index)
{
    new length = strlen(string),offset = index,result[256];
    while((index < length) && ((index - offset) < (sizeof(result) - 1)) && (string[index] > '\r')) result[index - offset] = string[index],index++;
    result[index - offset] = EOS;
    if(result[0] == ' ' && string[0] != ' ') strdel(result,0,1);
    return result;
}
public MoneyShip()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(i, x, y, z);
        if(x < 2005.4391 && x > 1995.4893 && y > 1518.1046 && y < 1570.3545 && z > 13.5859 && z < 44.6498)GivePlayerMoney(i, MONEYSHIPMONEY);
    }
    return 1;
}
stock SendMessagePmsAdmin(color, text[])
{
	for(new i = 0; i < MAX_PLAYERS; ++i) if(IsPlayerConnected(i) && SeePm[i] == 1) SendClientMessage(i,color,text);
	return 1;
}
stock SendMessageDisconnectAdmin(color, text[])
{
	for(new i = 0; i < MAX_PLAYERS; ++i) if(IsPlayerConnected(i) && SeeDisconnect[i] == 1) SendClientMessage(i,color,text);
	return 1;
}
stock SendMessageLpAdmin(color, text[])
{
	for(new i = 0; i < MAX_PLAYERS; ++i) if(IsPlayerConnected(i) && SeeLp[i] == 1) SendClientMessage(i,color,text);
	return 1;
}

stock SendMessageBombAdmin(color, text[])
{
	for(new i = 0; i < MAX_PLAYERS; ++i) if(IsPlayerConnected(i) && SeeBomb[i] == 1) SendClientMessage(i,color,text);
	return 1;
}
stock SendChatMessageToAll(color, text[])
{
	for(new i = 0; i < MAX_PLAYERS; ++i) if(IsPlayerConnected(i) && BlockChat[i] == 0) SendClientMessage(i,color,text);
	return 1;
}
stock HqTeleport(playerid, Float:Vx, Float:Vy, Float:Vz, Float:Va, Float:Px, Float:Py, Float:Pz, Float:Pa)
{
	SendClientMessage(playerid,COLOR_LIGHTGREEN, "! ���� ��� ������ ����� ���");
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid),Vx,Vy,Vz),SetVehicleZAngle(GetPlayerVehicleID(playerid),Va),SetCameraBehindPlayer(playerid),LinkVehicleToInterior(GetPlayerVehicleID(playerid),0);
	else SetPlayerPos(playerid,Px,Py,Pz),SetPlayerFacingAngle(playerid,Pa),SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid, 0),SetPlayerVirtualWorld(playerid, 0);
	return 1;
}
//==============================================================================
stock IsPlayerAntiFlood(playerid)
{
if(GetPlayerLevel(playerid) < 32) return true;
return false;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	ShowPlayerDialog(playerid, 5596, DIALOG_STYLE_LIST, "�������� �����", "��� ����� �����\n���� �� ���� ��\n����� �����\nDetails ���\n��� ����", "���", "�����");
    return 1;
}
ResetIgnoreList(playerid)
{
	for(new i = 0; i < MAX_PLAYERS; ++i) if(IsPlayerConnected(i)) Ignore[playerid][i] = false;
}

//all credits for YUVAL HILAI
//all credits for YUVAL HILAI
//all credits for YUVAL HILAI
//all credits for YUVAL HILAI
//all credits for YUVAL HILAI
//all credits for YUVAL HILAI
