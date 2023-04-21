language = {}

language.roundtype = "Round type: "
language.preparing = "Prepare, round will start soon"
language.round = "The round has started, good luck!"

language.lang_pldied = {
	"1 player died", 
	"{num} players died"
}
language.lang_descaped = {
	"1 Class D escaped the facility", 
	"{num} Class Ds escaped the facility"
}
language.lang_sescaped = {
	"1 SCP escaped the facility", 
	"{num} SCPs escaped the facility"
}
language.lang_rescaped = {
	"1 Staff member escaped the facility", 
	"{num} Staff members escaped the facility"
}
language.lang_dcaptured = {
	"1 Class D was captured by the Chaos Insurgency", 
	"{num} Class Ds were captured by the Chaos Insurgency"
}
language.lang_rescorted = {
	"1 Staff member was escorted by the MTF", 
	"{num} Staff members were escorted by the MTF"
}
language.lang_teleported = {
	"1 player was captured to the Pocket Dimnesion by the SCP-106",
	"{num} players were captured to the Pocket Dimnesion by the SCP-106"
}
language.lang_snapped = {
	"1 neck was snapped by the SCP-173",
	"{num} neck(s) were snapped by the SCP-173"
}
language.lang_zombies = {
	'1 player was cured by the SCP-049',
	'{num} players were cured by the SCP-049'
}

language.class_unknown = "Unknown"

language.starttexts = {
	ROLE_SCP173 = {
		"You are the SCP-173",
		{"Your objective is to escape the facility",
		"You cannot move when someone is looking at you",
		"Remember, humans are blinking"}
		--"You have a special ability on RMB: blind everyone around you"}
	},
	ROLE_SCP106 = {
		"You are the SCP-106",
		{"Your objective is to escape the facility",
		"When you touch someone, they will teleport",
		"to your pocket dimension"}
	},
	ROLE_SCP966 = {
		"You are the SCP-966",
		{"Your objective is to escape then facility",
		"You are invisible, humans can only see you using a nvg"}
	},
	ROLE_SCP457 = {
		"You are the SCP-457",
		{"Your objective is to escape then facility",
		"You are always burning",
		"If you are close enough to a human, you will burn them"}
	},
	ROLE_SCP049 = {
		"You are the SCP-049",
		{"Your objective is to escape the facility",
		"If you touch someone, they will become SCP-049-2"}
	},
	ROLE_SCP0492 = {
		"You are the SCP-049-2",
		{"Your objective is to escape the facility",
		"Cooperate with SCP-049 to kill more people"}
	},
	ROLE_SCP0082 = {
		"You are the SCP-008-2",
		{"Your objective is to infect every MTF Guard",
		"If you attack someone, they will become 008-2 aswell"}
	},
	-- RESEARCH STAFF
	ROLE_RES = {
		"You are a Researcher",
		{"Your objective is to escape from the facility",
		"You need to find a MTF Guard that will help you",
		"Be on the look out of Class Ds as they might try to kill you"}
	},
	ROLE_RES_SPY = {
		"You are a Chaos Insurgency Spy",
		{"Your objective is to kill all MTF Guards and capture the Class D",
		"They are unaware of your disguise",
		"Don't destroy your disguise",
		"If you find any class d's, try to escort them"}
	},
	ROLE_HRES = {
		"You are the Head Researcher",
		{"Your objective is to escape from the facility",
		"You need to find a MTF Guard that will help you",
		"Be on the look out of Class Ds as they might try to kill you"}
	},
	-- MISC STAFF
	ROLE_JANITOR = {
		"You are a Janitor",
		{"Your objective is to escape from the facility",
		"You need to find a MTF Guard that will help you",
		"Be on the look out of Class Ds as they might try to kill you"}
	},
	ROLE_ENG = {
		"You are an Engineer",
		{"Your objective is to escape from the facility",
		"You need to find a MTF Guard that will help you",
		"Be on the look out of Class Ds as they might try to kill you"}
	},
	ROLE_MEDIC = {
		"You are a Medic",
		{"Your objective is to escape from the facility",
		"You need to find a MTF Guard that will help you",
		"Be on the look out of Class Ds as they might try to kill you",
		"If someone gets injured, heal them"}
	},
	-- CLASS D PERSONNEL
	ROLE_CLASSD = {
		"You are a Class D",
		{"Your objective is to escape from the facility",
		"You need to cooperate with other Class Ds",
		"Search for keycards and be aware of MTF and SCPs"}
	},
	ROLE_VETERAN = {
		"You are a Veteran Class D",
		{"Your objective is to escape from the facility",
		"You need to cooperate with other Class Ds",
		"Search for keycards and be aware of MTF and SCPs"}
	},
	-- SITE SECURITY
	ROLE_SEC_GUARD = {
		"You are a Security Guard",
		{"Your objective is to find and rescue all",
		"staff that is still in the facility",
		"You have to kill any Class Ds or SCPs that you find",
		"If there is a security chief somewhere, listen to his orders"}
	},
	ROLE_SEC_OFFICER = {
		"You are a Security Officer",
		{"Your objective is to find and rescue all",
		"staff that is still in the facility",
		"You have to kill any Class Ds or SCPs that you find",
		"If there is a security chief somewhere, listen to his orders"}
	},
	ROLE_SEC_MEDIC = {
		"You are a Security Medic",
		{"Your objective is support your teammates",
		"If someone gets injured, heal them",
		"If there is a security chief somewhere, listen to his orders"}
	},
	ROLE_SEC_CHIEF = {
		"You are a Security Chief",
		{"Your objective is to find and rescue all",
		"staff that is still in the facility",
		"You have to kill any Class Ds or SCPs that you find",
		"You can give orders to security officers"}
	},
	ROLE_SD = {
		"You are a Site Director",
		{"Your objective is to give objectives to the site security",
		"You need to keep the site secure, don't let any SCP or Class D escape"}
	},
	-- SUPPORT
	ROLE_CHAOS = {
		"You are a Chaos Insurgency Soldier",
		{"Your objective is to capture as much Class Ds as it is possible",
		"Escort them to the helipad outisde of the facility",
		"You have to kill anyone who will stop you"}
	},
	ROLE_MTF_OFFICER = {
		"You are a MTF Officer",
		{"Your objective is to find and rescue all",
		"of the researchers that are still in the facility",
		"You have to kill any Class D or SCP that you will find",
		"Listen to MTF Commander's orders and stick to your team"}
	},
	ROLE_MTF_MEDIC = {
		"You are a MTF Medic",
		{"Your objective is support your teammates",
		"If someone gets injured, heal them",
		"Listen to MTF Commander's orders and stick to your team"}
	},
	ROLE_MTF_SCU = {
		"You are a MTF Special Containment Unit",
		{"Your objective is to find and rescue all",
		"of the researchers that are still in the facility",
		"Listen to MTF Commander's orders and stick to your team"}
	},
	ROLE_CHAOSCOM = {
		"You are a Chaos Insurgency Commander",
		{"Your objective is to give objectives to your team",
		"Kill anyone who will stop you"}
	},
	ROLE_MTF_SNIPER = {
		"You are a MTF Sniper",
		{"Your objective is to find and rescue all",
		"of the researchers that are still in the facility",
		"You have to kill any Class D or SCP that you will find",
		"Listen to MTF Commander's orders and stick to your team"}
	},
	ROLE_MTF_LIE = {
		"You are a MTF Lieutenant",
		{"Your objective is to find and rescue all",
		"of the researchers that are still in the facility",
		"You have to kill any Class Ds or SCPs that you will find",
		"Give orders to Guards to simplify the task",
		"Listen to MTF Commander's orders and stick to your team"}
	},
	ROLE_MTF_COM = {
		"You are a MTF Commander",
		{"Your objective is to find and rescue all",
		"of the researchers that are still in the facility",
		"You have to kill any Class Ds or SCPs that you will find",
		"Give orders to Guards to simplify the task"}
	},
	-- CI
	ROLE_CI_RES = {
		"You are a CI Spy",
		{"You are a part of Chaos Insurgency disguised as a Researcher",
		"Your objective is to capture and escort Class D Personnel",
		"Kill anyone who will stop you"}
	},
	ROLE_CI_GUARD = {
		"You are a CI Spy",
		{"You are a part of Chaos Insurgency disguised as a Guard",
		"Your objective is to capture and escort Class D Personnel",
		"Kill anyone who will stop you"}
	},
	ROLE_CI_SOLD = {
		"You are a CI Spy",
		{"You are a part of Chaos Insurgency disguised as a Guard",
		"Your objective is to capture and escort Class D Personnel",
		"Kill anyone who will stop you"}
	},
	-- OTHERS
	ROLE_SPEC = {
		"You are a Spectator",
		{'HMMMMMMMMMMMMMM'}
	},
}

language.lang_round_end_main = "THE ROUND HAS ENDED"

language.lang_end_time = "TIME LIMIT HAS BEEN REACHED"
language.lang_end_noonewon = "NO ONE WON"
language.lang_end_align_chaos = "CHAOS INSURGENCY TOOK CONTROL OF THE FACILITY"
language.lang_end_align_site_staff = "THE FOUNDATION RETOOK THE FACILITY"
language.lang_end_align_scps = "SCPS TOOK CONTROL OF THE FACILITY"

language.lang_end3 = "Facility is under control of one faction"

language.endmessages = {
	"Time limit has been reached",
	"The SCP Foundation has lost control over this facility",
	"The SCP Foundation has regained control over this facility",
}

language.escapemessages = {
	{
		main = "You escaped",
		txt = "You escaped the facility in {t} minutes, good job!",
		txt2 = "Try to get escorted by MTF next time to get bonus points.",
		clr = Color(237, 28, 63),
	},
	{
		main = "You escaped",
		txt = "You escaped the facility in {t} minutes, good job!",
		txt2 = "Try to get escorted by Chaos Insurgency Soldiers next time to get bonus points.",
		clr = Color(237, 28, 63),
	},
	{
		main = "You were escorted",
		txt = "You were escorted in {t} minutes, good job!",
		txt2 = "",
		clr = Color(237, 28, 63),
	},
	{
		main = "You escaped",
		txt = "You escaped in {t} minutes, good job!",
		txt2 = "",
		clr = Color(237, 28, 63),
	}
}



language.ROLES = {}
language.ROLES.ROLE_SCP173 = "SCP-173"
language.ROLES.ROLE_SCP106 = "SCP-106"
language.ROLES.ROLE_SCP049 = "SCP-049"
language.ROLES.ROLE_SCP457 = "SCP-457"
language.ROLES.ROLE_SCP966 = "SCP-966"
language.ROLES.ROLE_SCP0492 = "SCP-049-2"
language.ROLES.ROLE_SCP0082 = "SCP-008-2"

language.ROLES.ROLE_RES = "Researcher"
language.ROLES.ROLE_RES_SPY = "CI Spy"
language.ROLES.ROLE_HRES = "Head Researcher"

-- Misc Staff
language.ROLES.ROLE_JANITOR = "Janitor"
language.ROLES.ROLE_ENG = "Engineer"
language.ROLES.ROLE_MEDIC = "Medic"

-- Class D Personnel
language.ROLES.ROLE_CLASSD = "Class D Personnel"
language.ROLES.ROLE_VETERAN = "Class D Veteran"

-- Security
language.ROLES.ROLE_SEC_GUARD = "Security Guard"
language.ROLES.ROLE_SEC_OFFICER = "Security Officer"
language.ROLES.ROLE_SEC_MEDIC = "Security Medic"
language.ROLES.ROLE_SEC_CHIEF = "Security Chief"
language.ROLES.ROLE_SD = "Site Director"

-- Support
language.ROLES.ROLE_CHAOS = "CI Soldier"
language.ROLES.ROLE_MTF_OFFICER = "MTF Officer"
language.ROLES.ROLE_MTF_MEDIC = "MTF Medic"
language.ROLES.ROLE_MTF_SCU = "MTF SCU"
language.ROLES.ROLE_MTF_SNIPER = "MTF Sniper"
language.ROLES.ROLE_CHAOSCOM = "CI Commander"
language.ROLES.ROLE_MTF_LIE = "MTF Lieutenant"
language.ROLES.ROLE_MTF_COM = "MTF Commander"

-- CI Spies
language.ROLES.ROLE_CI_RES = "CI Spy Researcher"
language.ROLES.ROLE_CI_GUARD = "CI Spy Guard"
language.ROLES.ROLE_CI_SOLD = "CI Spy Soldier"

language.ROLES.ROLE_SPEC = "Spectator"


print("Gamemode loaded core/shared/language.lua")