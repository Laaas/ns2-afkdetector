# Warning

This does not work properly with official spectator slots (if at all).

# About

This mod detects AFK players and kicks them if they are AFK for too long.

# How do I use this?

Just put it on your server through your mapcycle and enable the plugin in Shine.
NB: This conflics with any other AFK mechanisms.

# Why not just use the shine AFK system?

The shine AFK system is buggy, does not correctly exclude spectators,
doesn't catch all signs of activity, is expensive for both server and client,
and does not properly warn players before kicking them to RR (goodbye my onos...)

This mod attempts to keep it simple, fast, and non-buggy.
This means no getting kicked when you're spectating, no getting moved to the RR when you're
actually playing, and not having the performance of your server or client affected.

# How it works

There are three configuration options

## Configuration options

### KickTime
After this amount of inactivity, the player will be kicked from the server.

### WarnTime
After this amount of inactivity, the player will be warned about an upcoming kick.

### PlayingKickTime
After this amount of inactivity, the player will be moved to the ready room, if they
are not spectating.

### MaxTeamPlayers
This tells the plugin how many players can be on a playing team at any time. On Wooza's
Playground this would be 42.

**NB:** I have no idea how this interacts with spectator slots.

## When will I be kicked?

As a player in a playing team (i.e. team 1 or 2), you will always be subject AFK kicking.
However, a player in a playing team will only get kicked to the ready room.
Although if they are eligible for AFK kicking while in the ready room too, then they may
get kicked from the server completely.
This depends on your configuration options and the amount of players in each team.


As a player in a non-playing team, you will only ever get kicked if you are preventing someone
from joining the server and joining a playing team.
I.e., if there can max be 42 playing players, but only 40 are playing and 10 are spectating or in RR, then
2 spectators or RR players may be kicked. If there are 42 playing players, then no spectator or RR player will be kicked.
