pingkickerjcmp
==============

High Ping Kicker JC-MP

-- * Ping Limit Kicker 0.1 *

-- * Written by Lucas H. (Stoppered) & Techjar *
-- * Contact-me at contato@lucas-henrique.com --*/
-- * http://lucas-henrique.com


Features you can set how many seconds the ping check is done you can configure the messages when the player is kicked notifies all online users what user X was kicked for having high ping, warns the user when approaching the limit of the ping


- * Changelog * -
- First release 21/12/2013


  
  
-- Change your server information below
-- Setup your ping limit
		
self.kickTime = 10 -- Seconds to wait and check the user ping
self.maxPing = 350 -- The ping limit
self.KickMessage = (" was kicked for having a ping over " .. self.maxPing .. " [HIGH PING]") -- Here warns all players online in chat sending a message warning that player X was kicked by reason HIGH PING
-- End the setup ping limit
-- Approaching the high ping
self.PingPercentageEnabled = 1 -- 1 Enabled - 0 Disabled Active message if reach close to the ping limit
self.PingPercentage = 98 -- Show a message when ping approaching the ping limit max value 100
self.PingAppMessage = ("[SERVER] You are near of the limit of the ping " .. self.maxPing .. "")-- Message shown when getting close to the limit
