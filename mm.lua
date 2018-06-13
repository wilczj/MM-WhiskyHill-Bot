----- DH Farming Script ------
debug = false
immersive = true
scriptDimension = 1920
Settings:setScriptDimension(true, scriptDimension)
Settings:setCompareDimension(true, scriptDimension)
setImmersiveMode(immersive)
local index = 1
farmList = {}
arenaList = {}
localPath = scriptPath()
imagePath = localPath .. "/" .. "images"

farmList[index] = {target =  "victory.png", region = Region(732, 51, 250, 250), id = "victory", action = 'click', sleep = 1}
index = index + 1

farmList[index] = {target =  "get.png", region = Region(1027, 865, 250, 250), id = "get", action = 'click', sleep = 1}
index = index + 1

farmList[index] = {target =  "replay.png", region = Region(765, 493, 250, 250), id = "replay", action = 'click', sleep = 4}
index = index + 1

farmList[index] = {target =  "start.png", region = Region(772, 673, 250, 250), id = "start", action = 'click', sleep = 60}
index = index + 1

farmList[index] = {target =  "sell.png", region = Region(530, 854, 250, 250), id = "sell", action = 'click', sleep = 1}
index = index + 1

farmList[index] = {target =  "continue.png", region = Region(777, 841, 250, 250), id = "continue", action = 'click', sleep = 1}
index = index + 1

farmList[index] = {target =  "next.png", region = Region(786, 637, 250, 250), id = "next", action = 'click', sleep = 4}
index = index + 1

farmList[index] = {target =  "defeated.png", region = Region(785, 38, 250, 250), id = "defeated", action = 'click', sleep = 1}
index = index + 1

farmList[index] = {target =  "close.png", region = Region(1465, 21, 250, 250), id = "close", action = 'click', sleep = 1}
index = index + 1

farmList[index] = {target =  "replaydefeat.png", region = Region(763, 450, 250, 250), id = "replaydefeat", action = 'click', sleep = 1}
index = index + 1

farmList[index] = {target =  "giveup.png", region = Region(809, 348, 250, 250), id = "giveup", action = 'click', sleep = 1}
index = index + 1

function farm()
	while true do
		local length = table.getn(farmList)
		
		setImagePath(imagePath)
		
		for i = 1, length do
			local t = farmList[i]
			if (t.action == "click") then
				--Debug
				if (debug and t.region) then 
					toast(t.target)
					t.region:highlight(0.2)
					wait(1)
				end
				if (t.id == "sell") then
					--ONLY click if farmSellAll = true
					if( farmSellAll == true ) then
						t.region:existsClick(t.target, 0)
					end
				elseif (t.id == "get") then
					--ONLY click if farmSellAll = false
					if( farmSellAll == false ) then
						t.region:existsClick(t.target, 0)
					end
				elseif (t.id == "next") then
					--ONLY click if farmNextStage = true
					if( farmNextStage == true ) then
						t.region:existsClick(t.target, 0)
					end
				elseif (t.id == "replay") then
					--ONLY click if farmNextStage = false
					if( farmNextStage == false ) then
						t.region:existsClick(t.target, 0)
					end
				else
					--Default
					if (t.region and (t.region):existsClick(t.target, 0)) then
						wait(t.sleep)
					end
				end
			end
			wait(.5)
		end
	end
end

---- Main ----
dialogInit()
addTextView("Choose your mode:")
newRow()
addRadioGroup("actionSelect", 1)
addRadioButton("Farming", 1)
addRadioButton("Arena", 2)
newRow()
addCheckBox("farmSellAll", "Sell All", false)
newRow()
addCheckBox("farmNextStage", "Next Stage", false)
dialogShowFullScreen("Might and Magic Bot")

if (actionSelect == 2) then
	--arena()
else
	farm()
end
