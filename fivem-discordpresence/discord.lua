Citizen.CreateThread(function()
	while true do
		local pedID = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(pedID, true))
		local StreetHash = GetStreetNameAtCoord(x, y, z)
		Citizen.Wait(1000)
		if StreetHash ~= nil then
			StreetName = GetStreetNameFromHashKey(StreetHash)
			if IsPedOnFoot(pedID) and not IsEntityInWater(pedID) then
				local VehName = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(pedID)))
				if VehName == "NULL" then return "Vehicle" end
				if IsPedSprinting(pedID) then
					SetRichPresence("Sprinting down "..StreetName)
				elseif IsPedRunning(pedID) then
					SetRichPresence("Running down "..StreetName)
				elseif IsPedWalking(pedID) then
					SetRichPresence("Walking down "..StreetName)
				elseif IsPedStill(pedID) then
					SetRichPresence("Standing on "..StreetName)
				end
			elseif GetVehiclePedIsUsing(pedID) ~= nil and not IsPedInAnyHeli(pedID) and not IsPedInAnyPlane(pedID) and not IsPedOnFoot(pedID) and not IsPedInAnySub(pedID) and not IsPedInAnyBoat(pedID) then
				local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(pedID)) * 2.236936)
				local VehName = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(pedID)))
				if VehName == "NULL" then return "Vehicle" end
				if MPH > 70 then
					SetRichPresence("Speeding down "..StreetName.." in a "..VehName)
				elseif MPH <= 70 and MPH > 1 then
					SetRichPresence("Cruising down "..StreetName.." in a "..VehName)
				elseif MPH == 0 then
					SetRichPresence("Parked on "..StreetName.." in a "..VehName)
				end
			elseif IsPedInAnyHeli(pedID) or IsPedInAnyPlane(pedID) then
				local VehName = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(pedID)))
				if VehName == "NULL" then return "Vehicle" end
				if IsEntityInAir(GetVehiclePedIsUsing(pedID)) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(pedID)) > 5.0 then
					SetRichPresence("Flying over "..StreetName.." in a "..VehName)
				else
					SetRichPresence("Landed at "..StreetName.." in a "..VehName)
				end
			elseif IsEntityInWater(pedID) then
				SetRichPresence("Swimming around")
			elseif IsPedInAnyBoat(pedID) and IsEntityInWater(GetVehiclePedIsUsing(pedID)) then
				local VehName = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(pedID)))
				if VehName == "NULL" then return "Vehicle" end
				SetRichPresence("Sailing around in a "..VehName)
			elseif IsPedInAnySub(pedID) and IsEntityInWater(GetVehiclePedIsUsing(pedID)) then
				SetRichPresence("In a yellow submarine")
			end
		end
	end
end)