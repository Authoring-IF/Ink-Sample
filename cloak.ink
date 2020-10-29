# title: Cloak of Inky Darkness
# author: Shin

VAR score = 0
VAR turns = 0
VAR strikes = 0

-> Introduction

=== Introduction ===
<i>Hurrying through the rainswept November night, you're glad to see the bright lights of the Opera House. It's surprising that there aren't more people about but, hey, what do you expect in a cheap demo game...?
-> Foyer


=== Foyer ===
<h4>Foyer
You are standing in a spacious hall, splendidly decorated in red and gold, with glittering chandeliers overhead. The entrance from the street is to the north, and there are doorways south and west.
-> choices

= tried_to_leave
You've only just arrived, and besides, the weather outside seems to be getting worse.
-> choices

= choices
~ turns = turns + 1
* [walk outside]          -> tried_to_leave
+ [enter doorway (south)] -> Bar
+ [enter doorway (west)]  -> Cloakroom


=== Bar ===
{not (Cloakroom.cloak_dropped or Cloakroom.cloak_hung): <h4>Darkness}
{    (Cloakroom.cloak_dropped or Cloakroom.cloak_hung): <h4>Bar}
{not (Cloakroom.cloak_dropped or Cloakroom.cloak_hung): It is pitch black. You can't see a thing.}
{    (Cloakroom.cloak_dropped or Cloakroom.cloak_hung): The bar, much rougher than you'd have guessed after the opulence of the foyer to the north, is completely empty. There seems to be some sort of message scrawled in the sawdust on the floor.}
-> choices

= one_strike_given
~ strikes = strikes + 1
In the dark? You could easily disturb something!
-> choices

= two_strikes_given
~ strikes = strikes + 2
Blundering around in the dark isn't a good idea!
-> choices

= choices
~ turns = turns + 1
+ {not (Cloakroom.cloak_dropped or Cloakroom.cloak_hung)} [find a light switch] -> one_strike_given
+ {not (Cloakroom.cloak_dropped or Cloakroom.cloak_hung)} [find another exit]   -> two_strikes_given
+ {    (Cloakroom.cloak_dropped or Cloakroom.cloak_hung)} [read the message]    -> Conclusion
+                                                         [return to the foyer] -> Foyer


=== Cloakroom ===
<h4>Cloakroom
The walls of this small room were clearly once lined with hooks, though now only one remains. The exit is a door to the east.
-> choices

= cloak_discovered
You are wearing a velvet cloak.
-> choices

= cloak_examined
A handsome cloak, of velvet trimmed with satin, and slightly spattered with raindrops. Its blackness is so deep that it almost seems to suck light from the room.
-> choices

= cloak_dropped
You drop the velvet cloak.
-> choices

= hook_examined
A small brass hook, screwed to the wall. Just the thing to hang a cloak on.
-> choices

= cloak_hung
~ score = score + 1
[Your score has gone up by 1 point.]
You hang the velvet cloak on the small brass hook.
-> choices

= choices
~ turns = turns + 1
*                                                              [what are you wearing?]      -> cloak_discovered
* {cloak_discovered}                                           [look at the cloak]          -> cloak_examined
* {cloak_examined and not hook_examined}                       [drop the cloak]             -> cloak_dropped
* {cloak_examined and not hook_examined and not cloak_dropped} [look at the hook]           -> hook_examined
* {cloak_examined and hook_examined and not cloak_dropped}     [hang the cloak on the hook] -> cloak_hung
+                                                              [return to the foyer]        -> Foyer


=== Conclusion ===
~ score = score + 1
[Your score has gone up by 1 point.]
{strikes <  2: The message, neatly marked in the sawdust, reads...<center><h4>*** You have won ***}
{strikes >= 2: The message has been carelessly trampled, making it difficult to read. You can just distinguish the words...<center><h4>*** You have lost ***}
<center><h4>You scored {score} out of a possible 2 points in {turns} turn{turns != 1:s}.
-> END


