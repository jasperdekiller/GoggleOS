version = 0.1
ServerID = 7
Adress = ""



function drawHeader()

Header = paintutils.loadImage("Images/Backgrounds/.Header")
paintutils.drawImage(Header,1,1)

end

function drawBlankPage()

blankPage = paintutils.loadImage("Images/Backgrounds/.blankScreen")
paintutils.drawImage(blankPage,1,2)


end

function drawHelpPage()

term.clear()
helpPage = paintutils.loadImage("Images/Backgrounds/.loadScreen")
paintutils.drawImage(helpPage,1,1)
term.setCursorPos(2,1)
term.setBackgroundColor(colors.red)
term.clearLine()
term.setTextColor(colors.white)
write("rdnt://"..Adress)
userClicks()

end

function userPress()

while true do

	 local event, key = os.pullEvent("char")

	 if key == keys.escape then
	 	term.setBackgroundColor(colors.white)
	 	term.setCursorPos(1,1)
	 	term.clearLine()
	 	term.setCursorPos(1,1)
	 	print("                                      GoggleOS v", version)
      end
 	 end
 end

 function Start()

if fs.exists("Website_History") then
Adress = "start.goggle.com"
term.clear()
rednet.open("top")
drawHeader()
drawMainScreen()
term.setBackgroundColor(colors.red)
term.setCursorPos(2,1)
term.setTextColor(colors.white)
write("rdnt://start.goggle.com")
 userClicks()
else
fs.makeDir("Website_History")
Start()
end
end -- End function

searchSite = function(websiteName)
 loadScreen = paintutils.loadImage("Images/Backgrounds/.loadScreen")
 paintutils.drawImage(loadScreen,1,1)
 term.setCursorPos(20,8)
 print("Searching..")
 sleep(0.8)
 rednet.send(ServerID, "@searchWeb")
 rednet.send(ServerID, Adress)
 id, Answer = rednet.receive(3)
if Answer == nil then
 term.setCursorPos(15,8)
 print("Connection timed out.")
 term.setCursorPos(15,9)
 print("Error: Server offline.")
 sleep(2)
 term.setCursorPos(13,11)
 print("Please, try it again later.")
 term.setCursorPos(11,13)
 print("Are you the Owner of the server?")
 term.setCursorPos(7,14)
 print("Please, make sure the server is Online!")
 userClicks()
else
if id == ServerID then
  if Answer == "@Found" then
  	id, index = rednet.receive()
  	if index == true then
  	  id, indexLines = rednet.receive()
  	 if id == ServerID then

  	   drawBlankPage()
  	   fs.delete("Website_History/"..Adress.."/index")
  	   dFile = fs.open("Website_History/"..Adress.."/index", "w")
  	   dFile.write(indexLines)
  	   dFile.close()
  	   iFile = fs.open("Website_History/"..Adress.."/index","r")
       FileLines = iFile.readAll()
       iFile.close()
       term.setCursorPos(1,2)
       term.setTextColor(colors.gray)
       shell.run("Website_History/"..Adress.."/index")
       drawHeader()
       term.setCursorPos(2,1)
	   term.setTextColor(colors.white)
	   write("rdnt://"..Adress)
	   userClicks()
  	 else
  	  print("Wrong ID.")
  	 end
  	elseif index == false then
  	 print("No results.")
  	 userClicks()
    end
  elseif Answer == "@Not_Found" then
  	print("No results.")
  	      term.setCursorPos(2,1)
       term.setBackgroundColor(colors.red)
       term.clearLine()
       term.setTextColor(colors.white)
       write("rdnt://")
       Adress = read()
      if Adress then
       	if Adress == "start.goggle.com" then
          drawMainScreen()
       	  Adress = "start.goggle.com"
       	elseif Adress == "goggle.com" then
       	  drawMainScreen()
       	  Adress = "goggle.com"
       	elseif Adress == "cloud.goggle.com" then
       	  drawBlankPage()
       	  parallel.waitForAny(userPress, userClicks, function() shell.run("Websites/cloud.goggle.com/Cloud") end)	
      if Adress then
       	if Adress == "start.goggle.com" then
          drawMainScreen()
       	  Adress = "start.goggle.com"
       	elseif Adress == "goggle.com" then
       	  drawMainScreen()
       	  Adress = "goggle.com"
       	elseif Adress == "cloud.goggle.com" then
       	  drawBlankPage()
       	  parallel.waitForAny(userPress, userClicks, function() shell.run("Websites/cloud.goggle.com/Cloud") end)	
       	  userClicks()
        elseif Adress == "user.goggle.com" then
            drawHeader()
            Adress = "user.goggle.com"
	   		term.setBackgroundColor(colors.white)
       		shell.run("Websites/user.goggle.com/home")
       		term.setBackgroundColor(colors.red)
       		term.setCursorPos(2,1)
       		term.clearLine()
	   		term.setTextColor(colors.white)
	   		write("rdnt://"..Adress)
	   		term.setBackgroundColor(colors.white)
	   		userClicks()
          elseif Adress == "help" then
            drawHelpPage()
           else
       	    searchSite(Adress)
          end -- End of Adress
         end -- End Adress
        elseif Adress == "user.goggle.com" then
            drawHeader()
            Adress = "user.goggle.com"
	   		term.setBackgroundColor(colors.white)
       		shell.run("Websites/user.goggle.com/home")
       		term.setBackgroundColor(colors.red)
       		term.setCursorPos(2,1)
       		term.clearLine()
	   		term.setTextColor(colors.white)
	   		write("rdnt://"..Adress)
	   		term.setBackgroundColor(colors.white)
	   		userClicks()
          elseif Adress == "help" then
            drawHelpPage()
           else
       	    searchSite(Adress)
          end -- End of Adress
         end -- End Adress
   end
  end
end
end

function userClicks()

    while true do

    local event, button, X, Y = os.pullEvent("mouse_click")

    if event == "mouse_click" then
      if Y==1 and X >=9 and X <=41 then
       if Adress == "cloud.goggle.com" then
       	term.setCursorPos(2,1)
      	term.setBackgroundColor(colors.red)
      	term.clearLine()
      	term.setTextColor(colors.white)
        write("rdnt://")
        wAdress = read()
       if wAdress then
       	Adress = wAdress
        searchSite(Adress)
   	    userClicks()
       end
      else
       term.setCursorPos(2,1)
       term.setBackgroundColor(colors.red)
       term.clearLine()
       term.setTextColor(colors.white)
       write("rdnt://")
       Adress = read()
      if Adress then
       	if Adress == "start.goggle.com" then
          drawMainScreen()
       	  Adress = "start.goggle.com"
       	elseif Adress == "goggle.com" then
       	  drawMainScreen()
       	  Adress = "goggle.com"
       	elseif Adress == "cloud.goggle.com" then
       	  drawBlankPage()
       	  parallel.waitForAny(userPress, userClicks, function() shell.run("Websites/cloud.goggle.com/Cloud") end)	
       	  userClicks()
        elseif Adress == "user.goggle.com" then
            drawHeader()
            Adress = "user.goggle.com"
	   		term.setBackgroundColor(colors.white)
       		shell.run("Websites/user.goggle.com/home")
       		term.setBackgroundColor(colors.red)
       		term.setCursorPos(2,1)
       		term.clearLine()
	   		term.setTextColor(colors.white)
	   		write("rdnt://"..Adress)
	   		term.setBackgroundColor(colors.white)
	   		userClicks()
          elseif Adress == "help" then
            drawHelpPage()
           else
       	    searchSite(Adress)
          end -- End of Adress
         end -- End Adress
      end -- event Pos's
     end -- if event
    end
   end
end

function drawMainScreen()
 mainScreen = paintutils.loadImage("Images/Backgrounds/.mainScreen")
 paintutils.drawImage(mainScreen,1,1)
 term.setBackgroundColor(colors.orange)
 term.setCursorPos(24,10)
 print("v"..version)
 term.setBackgroundColor(colors.gray)
 term.setCursorPos(10,14)
 term.setTextColor(colors.white)
 print("Search using the Query Box above")
 term.setCursorPos(3,15)
 print("Visit rdnt://help for help using Goggle Browser.")
 term.setCursorPos(15,17)
 print("Made by jasperdekiller")
end


if not term.isColor or not term.isColor() then
        print('GoggleOS Requires an Advanced (gold) Computer')
      else
        Start()
end
