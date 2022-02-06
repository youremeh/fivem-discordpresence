CreateThread(function()
	while true do
		Wait(1000)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
		local StreetHash = GetStreetNameAtCoord(x, y, z)
		if StreetHash ~= nil then
			StreetName = GetStreetNameFromHashKey(StreetHash)
			local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
			if VehName == "NULL" then return "Vehicle" end
			if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
				if IsPedSprinting(PlayerPedId()) then
					SetRichPresence("Sprinting down "..StreetName)
				elseif IsPedRunning(PlayerPedId()) then
					SetRichPresence("Running down "..StreetName)
				elseif IsPedWalking(PlayerPedId()) then
					SetRichPresence("Walking down "..StreetName)
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence("Standing on "..StreetName)
				end
			elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
				local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 2.236936)
				if MPH > 70 then
					SetRichPresence("Speeding down "..StreetName.." in a "..VehName)
				elseif MPH <= 70 and MPH > 1 then
					SetRichPresence("Cruising down "..StreetName.." in a "..VehName)
				elseif MPH == 0 then
					SetRichPresence("Parked on "..StreetName.." in a "..VehName)
				end
			elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
				if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
					SetRichPresence("Flying over "..StreetName.." in a "..VehName)
				else
					SetRichPresence("Landed at "..StreetName.." in a "..VehName)
				end
			elseif IsEntityInWater(PlayerPedId()) then
				SetRichPresence("Swimming around")
			elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence("Sailing around in a "..VehName)
			elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence("In a yellow submarine")
			end
		end
	end
end)