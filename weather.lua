local nuiVisible = false

RegisterCommand("weather", function()
    nuiVisible = not nuiVisible

    SetNuiFocus(nuiVisible, nuiVisible) 
    SendNUIMessage({
        type = "toggleVisibility",
        visible = nuiVisible
    })
end, false)

RegisterCommand("positionWeather", function()
    if nuiVisible then
        SetNuiFocus(true, true)
    end
    
    SendNUIMessage({
        type = "toggleDraggable",
        draggable = true 
    })
end, false)

RegisterNUICallback("removeFocus", function(data, cb)
    SetNuiFocus(false, false) 
    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local hours = GetClockHours()
        local minutes = GetClockMinutes()
        local timeString = string.format("%02d:%02d", hours, minutes)

        local weather = GetPrevWeatherTypeHashName()
        local weatherIcon = ""
        local weatherName = ""

        if weather == GetHashKey("EXTRASUNNY") then
            weatherIcon = "extrasunny.png"
            weatherName = "Extra Sunny"
        elseif weather == GetHashKey("CLEAR") then
            weatherIcon = "clear.png"
            weatherName = "Clear"
        elseif weather == GetHashKey("CLOUDS") then
            weatherIcon = "cloudy.png"
            weatherName = "Cloudy"
        elseif weather == GetHashKey("SMOG") then
            weatherIcon = "smog.png"
            weatherName = "Smoggy"
        elseif weather == GetHashKey("FOGGY") then
            weatherIcon = "foggy.png"
            weatherName = "Foggy"
        elseif weather == GetHashKey("OVERCAST") then
            weatherIcon = "overcast.png"
            weatherName = "Overcast"
        elseif weather == GetHashKey("RAIN") then
            weatherIcon = "rain.png"
            weatherName = "Rainy"
        elseif weather == GetHashKey("THUNDER") then
            weatherIcon = "thunderstorm.png"
            weatherName = "Thunderstorm"
        elseif weather == GetHashKey("SNOW") then
            weatherIcon = "snow.png"
            weatherName = "Snowy"
        elseif weather == GetHashKey("BLIZZARD") then
            weatherIcon = "blizzard.png"
            weatherName = "Blizzard"
        elseif weather == GetHashKey("SNOWLIGHT") then
            weatherIcon = "lightsnow.png"
            weatherName = "Light Snow"
        elseif weather == GetHashKey("XMAS") then
            weatherIcon = "xmas.png"
            weatherName = "Xmas Snow"
        elseif weather == GetHashKey("HALLOWEEN") then
            weatherIcon = "halloween.png"
            weatherName = "Halloween"
        else
            weatherIcon = "unknown.png"
            weatherName = "Unknown"
        end

        SendNUIMessage({
            type = "updateTimeWeather",
            time = timeString,
            weatherIcon = weatherIcon,
            weatherName = weatherName
        })
    end
end)
