-- * Ping Limit Kicker 0.2 * --
-- * Written by Lucas H. (Stoppered) Special thanks to techjar * --
-- * Contact-me at webmaster@whispers.com.br --*/
-- * http://www.cshpforum.com * --
 
class 'PingKick'
 
function PingKick:__init()        
    Events:Subscribe("PlayerJoin", self, self.PlayerJoin)
    Events:Subscribe("PlayerQuit", self, self.PlayerQuit)
    Events:Subscribe("PostTick", self, self.PostTick)
    Events:Subscribe("ModuleLoad", self, self.ModuleLoad)
   
    self.timers = {}
	self.pingkicker = {}
	self.pingalert = {}
	self.alertclean = {}
	
	
	self.kickTimePing = 5 -- If the player reach the numbers of alert he will be kicked
	self.PingAlertTime = 20 -- In how much time the system will check user if hes ping is 98% of 100% if the ping not get lower will be kicked
	self.CleanAlertTime = 300 -- If he don't receive more alerts in 5 minutes all alerts will be cleaned
       
        -- Change your server information below
        -- Setup your ping limit
		
    self.kickTime = 5 -- Seconds to wait and check the user ping
    self.maxPing = 400 -- The ping limit
    self.KickMessage = (" was kicked for having a ping over " .. self.maxPing .. " [HIGH PING]") -- Here warns all players online in chat sending a message warning that player X was kicked by reason HIGH PING
        -- End the setup ping limit
        -- Approaching the high ping
        self.PingPercentageEnabled = 1 -- 1 Enabled - 0 Disabled Active message if reach close to the ping limit
        self.PingPercentage = 98 -- Show a message when ping approaching the ping limit max value 100
		self.PingAppMessage = ("[SERVER] You are near of the limit of the ping " .. self.maxPing .. "")-- Message shown when getting close to the limit
		-- Don't you change anything here it's a calculation used to get close to the limit of the ping
		self.PingApproaching =  math.floor(self.PingPercentage/100*self.maxPing)
		
		-- Alert system Configuration
		-- Recommended 2 after that number the alert system would be useless
		self.NumberOfAlerts = 3 -- Change here the number of alerts before the user be kicked from server
		
        -- Don't change anything here this is the number of alerts started of player
		self.PingAlertNumber = 0 -- Don't change anything here it's by default 0 alerts

		
end
 
function PingKick:ModuleLoad()
    for player in Server:GetPlayers() do
        self.timers[player:GetSteamId().id] = Timer()
		self.pingkicker[player:GetSteamId().id] = Timer()
		self.pingalert[player:GetSteamId().id] = Timer()	
		self.alertclean[player:GetSteamId().id] = Timer()
    end
end
 
function PingKick:PlayerJoin(args)
    self.timers[args.player:GetSteamId().id] = Timer()
	self.pingkicker[args.player:GetSteamId().id] = Timer()
	self.pingalert[args.player:GetSteamId().id] = Timer()
	self.alertclean[args.player:GetSteamId().id] = Timer()
end
 
function PingKick:PlayerQuit(args)
end
 
function PingKick:PostTick(args)

    for player in Server:GetPlayers() do
	
		if self.pingalert[player:GetSteamId().id]:GetSeconds() >= self.PingAlertTime and player:GetPing() >=  self.PingApproaching then
		       self.PingAlertNumber = math.floor(self.PingAlertNumber+1) -- Here will add each alert the user to take
			   Chat:Send(player, self.PingAppMessage, Color(255, 0, 4))
			   self.pingalert[player:GetSteamId().id]:Restart()
			   self.pingkicker[player:GetSteamId().id]:Restart()
			   end
			   -- The function below check 
			  if self.alertclean[player:GetSteamId().id]:GetSeconds() >= self.CleanAlertTime and  self.PingAlertNumber <= self.NumberOfAlerts then
			   self.PingAlertNumber = 0
               self.alertclean[player:GetSteamId().id]:Restart()   
               self.pingkicker[player:GetSteamId().id]:Restart()
			  end
			   
			   if  self.pingkicker[player:GetSteamId().id]:GetSeconds() >= self.kickTimePing and self.PingAlertNumber >= self.NumberOfAlerts then
			    player:Kick("exceeded the ping limit " .. self.maxPing) 
			   end
		
        if self.timers[player:GetSteamId().id] ~= nil and player:GetPing() >= self.maxPing then
            if self.timers[player:GetSteamId().id]:GetSeconds() >= self.kickTime then
                self:Announce("[SERVER] ".. player:GetName() .. self.KickMessage)
                self.timers[player:GetSteamId().id] = nil
                player:Kick("exceeded the ping limit " .. self.maxPing) -- Player reason kicked windows at menu and show the ping limit on the server
end
   else
   	   --self.timers[player:GetSteamId().id]:Restart()
        end
    end
end 
 
function PingKick:Announce(message)
    Chat:Broadcast("[Server] " .. message, Color(255, 0, 4))
    print(message)
end
 
pingkick = PingKick()
