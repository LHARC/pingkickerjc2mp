-- * Ping Limit Kicker 0.1 * --
-- * Written by Lucas H. (Stoppered) & Techjar amazing programmer special thanks <3 * --
-- * Contact-me at webmaster@whispers.com.br --*/
-- * http://www.cshpforum.com * --
 
class 'PingKick'
 
function PingKick:__init()        
    Events:Subscribe("PlayerJoin", self, self.PlayerJoin)
    Events:Subscribe("PlayerQuit", self, self.PlayerQuit)
    Events:Subscribe("PostTick", self, self.PostTick)
    Events:Subscribe("ModuleLoad", self, self.ModuleLoad)
   
    self.timers = {}
       
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
		-- Don't you change anything here it's a calculation used to get close to the limit of the ping
		self.PingApproaching =  math.floor(self.PingPercentage/100*self.maxPing)
 
end
 
function PingKick:ModuleLoad()
    for player in Server:GetPlayers() do
        self.timers[player:GetSteamId().id] = Timer()
    end
end
 
function PingKick:PlayerJoin(args)
    self.timers[args.player:GetSteamId().id] = Timer()
end
 
function PingKick:PlayerQuit(args)
   
end
 
function PingKick:PostTick(args)

    for player in Server:GetPlayers() do
	
		if self.PingPercentageEnabled == 1 and player:GetPing() >=  self.PingApproaching then
			   Chat:Send(player, self.PingAppMessage, Color(255, 0, 4))
			   end
			   
	
        if self.timers[player:GetSteamId().id] ~= nil and player:GetPing() >= self.maxPing then
            if self.timers[player:GetSteamId().id]:GetSeconds() >= self.kickTime then
			   
                self:Announce(player:GetName() .. self.KickMessage)
                self.timers[player:GetSteamId().id] = nil
                player:Kick("exceeded the ping limit " .. self.maxPing) -- Player reason kicked windows at menu and show the ping limit on the server
				
		 
	
            end
        else	   
            self.timers[player:GetSteamId().id]:Restart()
        end
    end
end
 
 
function PingKick:Announce(message)
    Chat:Broadcast("[Server] " .. message, Color(255, 0, 4))
    print(message)
end
 
pingkick = PingKick()
