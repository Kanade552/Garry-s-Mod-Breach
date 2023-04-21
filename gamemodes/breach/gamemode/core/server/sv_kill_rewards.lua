
kill_rewards = {}

kill_rewards[TEAM_GUARD] = {
    death_msg = "You were killed by an MTF Guard: ",
    rewards = {
        [TEAM_SCP] = {
            msg = "You've been awarded with 10 points for killing an SCP!",
            points = 10
       },
        [TEAM_CHAOS] = {
            msg = "You've been awarded with 5 points for killing a Chaos Insurgency member!",
            points = 5
       },
        [TEAM_CLASSD] = {
            msg = "You've been awarded with 2 points for killing a Class D Personnel!",
            points = 2
       }
   }
}

kill_rewards[TEAM_CHAOS] = {
    death_msg = "You were killed by a Chaos Insurgency Soldier: ",
    rewards = {
        [TEAM_GUARD] = {
            msg = "You've been awarded with 2 points for killing a Guard!",
            points = 2
       },
        [TEAM_SCI] = {
            msg = "You've been awarded with 2 points for killing a Researcher!",
            points = 2
       },
        [TEAM_STAFF] = {
            msg = "You've been awarded with 2 points for killing Staff!",
            points = 2
       },
        [TEAM_SCP] = {
            msg = "You've been awarded with 10 points for killing an SCP!",
            points = 10
       },
        [TEAM_CLASSD] = {
            msg = "Don't kill Class D Personnel, you can capture them to get bonus points!",
            points = 1
       }
   }
}

kill_rewards[TEAM_SCP] = {
    death_msg = "You were killed by an SCP: ",
    msg = "You've been awarded with 2 points for killing ",
    points = 2
}

kill_rewards[TEAM_CLASSD] = {
    death_msg = "You were killed by a Class D: ",
    rewards = {
        [TEAM_GUARD] = {
            msg = "You've been awarded with 4 points for killing a Guard!",
            points = 4
       },
        [TEAM_SCI] = {
            msg = "You've been awarded with 2 points for killing a Researcher!",
            points = 2
       },
        [TEAM_STAFF] = {
            msg = "You've been awarded with 2 points for killing Staff!",
            points = 2
       },
        [TEAM_SCP] = {
            msg = "You've been awarded with 10 points for killing an SCP!",
            points = 10
       },
        [TEAM_CHAOS] = {
            msg = "You've been awarded with 2 points for killing a Chaos Insurgency member!",
            points = 2
       }
   }
}

kill_rewards[TEAM_SCI] = {
    death_msg = "You were killed by a Researcher: ",
    rewards = {
        [TEAM_SCP] = {
            msg = "You've been awarded with 10 points for killing an SCP!",
            points = 10
       },
        [TEAM_CHAOS] = {
            msg = "You've been awarded with 5 points for killing a Chaos Insurgency member!",
            points = 5
       },
        [TEAM_CLASSD] = {
            msg = "You've been awarded with 2 points for killing a Class D Personnel!",
            points = 2
       }
   }
}

print("Gamemode loaded core/server/sv_kill_rewards.lua")