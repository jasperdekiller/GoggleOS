if fs.exists("Installer") then
  fs.delete("Installer")
  shell.run("Startup")
 elseif fs.exists("background") then
  fs.delete("background")
  shell.run("Startup")
 end
if fs.exists("Users") and 
   fs.exists("Cloud_Backup") and
   fs.exists("Cloud_Users") and 
   fs.exists("Online_Cloud_Users") and
   fs.exists("Online_Websites") and
   fs.exists("Websites") then

term.clear()
term.setCursorPos(1,1)
print("SERVER ONLINE, ID: "..os.getComputerID())
xPos, yPos = term.getSize()
Start = true
banCheck = true
UP = false
PP = false
L = true

standardReason = "Not specified."
standardLoginMessage = "Login information was wrong."
rednet.open("top")

-- KICK TABLE

bannedUsers = {}

function loadTable()

local f = io.open("file", "r")
bannedUsers = textutils.unserialize(f:read("*a"))
f:close()

end

function saveTable()

local f = io.open("file", "w")
f:write(textutils.serialize(bannedUsers))
f:close()

end

function removeFromTable(processTable, element)
 for k,v in pairs(processTable) do
  if v == element then
   table.remove(processTable, k)
   return
  end
 end
end


-- CONSOLE COMMANDS

function unBan()

write("Player?: ")
uKUser = read()
loadTable()
removeFromTable(bannedUsers, uKUser)
term.setCursorPos(1,1)
print("User: "..uKUser.." has been unbanned.")
saveTable()


end



--

function command()
    term.setCursorPos(1,yPos)
    print("Console: CONSOLE DISABLED.")
    if Ccommand == "ban" then
      write("Player?: ")
      bUser = read()
       table.insert(bannedUsers, bUser)
       term.setCursorPos(1,1)
       print("User: "..bUser.." has been banned from Goggle Cloud.")
       print("Reason: ", standardReason)
   elseif Ccommand == "unban" then
    unBan()
   else
    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(colors.red)
    print("No such command.")
    term.setTextColor(colors.white)
    command()
  end
  end



function Upload()

      end


-- START FUNCTION


Start = function()
  id, x = rednet.receive()
   if x == "@ConnectRequest" then
    done = 0
   repeat
    term.clear()
    term.setCursorPos(1,1)
    print("ID: '"..id.."' wants to connect to the server.")
    write("Y/N: ")
    IDra = read()
   if IDra:upper() == "Y" then
    rednet.send(id, "@Approved")
    term.clear()
    term.setCursorPos(1,1)
    print("Console: Accepted a connect request from ID: "..id)
    done = 1
   elseif IDra:upper() == "N" then
    rednet.send(id, "@Denied")
    term.clear()
    term.setCursorPos(1,1)
    print("Console: Denied a connect request from ID: "..id)
    done = 1
   end


    until done == 1

   elseif x == "@searchWeb" then
    id, websiteName = rednet.receive()
    Search = searchWebsite(websiteName)
    if Search == true then
     rednet.send(id, "@Found")
     index = fs.exists("Websites/"..websiteName.."/index")
    if index == true then
      rednet.send(id, true)
      file = fs.open("Websites/"..websiteName.."/index","r")
      FileLines = file.readAll()
      rednet.send(id,FileLines)
      file.close()
    elseif index == false then
      rednet.send(id, false)
    end
    elseif Search == false then
     rednet.send(id, "@Not_Found")
    end
   elseif x == "@userLogin" then
    id, lUsername = rednet.receive()

      if fs.exists("Users/"..lUsername) then
        rednet.send(id, "@Approved")
       else
        rednet.send(id, "@Denied")
       end
   elseif x == "@relogMessage" then
    id, relogName = rednet.receive()
    print("User: "..relogName.." has been relogged.")
   elseif x == "@SaveRegisterDetails" then
    id, rUsername = rednet.receive()
    id, rPassword = rednet.receive()
    file = fs.open("Users/"..rUsername, "w")
    file.write(rPassword)
    file.close()
    fs.makeDir("Cloud_Users/"..rUsername)
    sleep(1)
    print("Console: Successfully saved "..rUsername.."'s account.")
    rednet.send(id, "@Saved")
   elseif x == "@rNA" then
    id, rUsername = rednet.receive()
     if fs.exists("Users/"..rUsername) then
       print("Console: Checking for name '"..rUsername.."'..")
       print("Console: Name already taken.")
       rednet.send(id, "@AIU")
      else
       print("Console: Checking for name '"..rUsername.."'..")
       print("Console: Name available.")
       rednet.send(id, "@AV")
      end
   elseif x == "@Logout" then
     id, Uname = rednet.receive()
    id, Pass = rednet.receive()
   if fs.exists("Online_Cloud_Users/"..Uname) then
     fs.delete("Online_Cloud_Users/"..Uname)
         Login = LoginCheck(Uname, Pass)
    if Login == false then
      print("User: "..Uname.." was denied for logging out.")
      print("Reason: ", standardLoginMessage)
      rednet.send(id, "@Aborted")
     else
      print("User: "..Uname.." logged out from his Goggle Cloud.")
      rednet.send(id, "@Approved")
    end
   else
    Login = LoginCheck(Uname, Pass)
    if Login == false then
      print("User: "..Uname.." was denied for logging out.")
      print("Reason: ", standardLoginMessage)
      rednet.send(id, "@Aborted")
     else
      print("User: "..Uname.." logged out from his Goggle Cloud.")
      rednet.send(id, "@Approved")
    end
   end
   elseif x == "@uList" then
    ID, Uname = rednet.receive()
      if L == true then
        rednet.send(ID, true)
        files = fs.list("Cloud_Users/"..Uname.."/")
        rednet.send(ID, files)
      elseif L == false then
        rednet.send(ID, false)
      end
   elseif x == "@Pass" then
    id, Uname = rednet.receive()
    id, Pass = rednet.receive()
     Check = LoginCheck(Uname, Pass)
     if Check == true then
       fs.makeDir("Online_Cloud_Users/"..Uname)
      if fs.exists("Cloud_Users/"..Uname) then
       rednet.send(id, "@CP")
       term.clear()
       term.setCursorPos(1,1)
      print("User: ",Uname," logged in to Goggle Cloud.")
      print("")
      if Uname == "jasperdekiller" then
        rednet.send(id, "7")
    elseif Uname == "Esbenmine" then
        rednet.send(id, "7")
       else
        rednet.send(id, "1")
       end
     else
      if Uname == "jasperdekiller" then
        rednet.send(id, "7")
      elseif Uname == "Esbenmine" then
        rednet.send(id, "7")
       else
        rednet.send(id, "1")
       end
       fs.makeDir("Cloud_Users/"..Uname)
       rednet.send(id, "@CP")
       term.clear()
       term.setCursorPos(1,1)
       print("User: ",Uname," logged in to Goggle Cloud.")
       print("")
      end
      return
     elseif Check == false then
      term.clear()
  term.setCursorPos(1,1)
      print("User: ",Uname," failed to log in to his Goggle Cloud.")
      print("")
       rednet.send(id, "@WP")
    end
elseif x == "@Upload" then
    id, Uname = rednet.receive()
    id, Pass = rednet.receive()
    id, File = rednet.receive()
    Login = LoginCheck(Uname, Pass)
    if Login == false then
      rednet.send(id, "@WP")
    else
      if fs.exists("Cloud_Users/"..Uname.."/"..File.."") then
        rednet.send(id, "@File Exists")
      else
        rednet.send(id, "@StartUL")
        ID, Message = rednet.receive()
        if id == ID then
          if Message == "@File Exists" then
            id, FileLines = rednet.receive()
            if id == ID then
              bcFile = fs.open("Cloud_Backup/"..Uname.."/"..File, "w")
              file = fs.open("Cloud_Users/"..Uname.."/"..File, "w")
              bcFile.write(FileLines)
              file.write(FileLines)
              file.close()
              bcFile.close()
              print("User: ",Uname," uploaded '",File,"' to his Goggle Cloud.")
            else
              rednet.send(id, "Nothing here.")
            end
          elseif Message == "@CancelUL" then
          end
        else
          rednet.send(id, "You send a message to an wrong idea.")
        end
      end
    end
  elseif x == "@uUpload" then
    id, Uname = rednet.receive()
    id, File = rednet.receive()
      if fs.exists("Cloud_Users/"..Uname.."/"..File.."") then
        rednet.send(id, "@File Exists")
      else
        rednet.send(id, "@StartUL")
        ID, Message = rednet.receive()
          if Message == "@File Exists" then
            id, FileLines = rednet.receive()
            if id == ID then
              bcFile = fs.open("Cloud_Backup/"..Uname.."/"..File, "w")
              file = fs.open("Cloud_Users/"..Uname.."/"..File, "w")
              bcFile.write(FileLines)
              file.write(FileLines)
              file.close()
              bcFile.close()
              print("User: ",Uname," uploaded ",File," to his Goggle Cloud")
            else
              rednet.send(id, "Nothing here.")
            end
          elseif Message == "@CancelUL" then
        else
          rednet.send(id, "You send a message to an wrong idea.")
        end
      end
  elseif x == "@abortedAdminLogin" then
    id, adminUser = rednet.receive()
    id, logUser = rednet.receive()
    print("WARNING: Admin: "..adminUser.." tried to login to ADMIN: "..logUser.."'s account.")
    print("Console: Aborting ADMIN: "..adminUser.."'s request..")
    print("Console: Login Request aborted.")
    rednet.send(id, true)
  elseif x == "@AdminLoginMessage" then
    id, lName = rednet.receive()
    id, ladminName = rednet.receive()

    print("Admin: "..ladminName.." has logged into "..lName.."'s account.")
    rednet.send(id, true)

  elseif x == "@uDownload" then
    ID, Uname = rednet.receive()
    ID2, FileName = rednet.receive()
      if L == true then
        rednet.send(id, true)
      if fs.exists("Cloud_Users/"..Uname.."/"..FileName) then
          rednet.send(id, "@File exists")
          file = fs.open("Cloud_Users/"..Uname.."/"..FileName,"r")
          Lines = file.readAll()
          rednet.send(id, Lines)
          file.close()
          term.clear()
          term.setCursorPos(1,1)
          print("Admin: ",Uname," downloaded file '"..FileName.."' from his Goggle Cloud.")
          print("")
        else
          rednet.send(id, "@File do not exists")
        end
      elseif L == 0 then
        rednet.send(id, false)
      end

  elseif x == "@Download" then
    ID, Uname = rednet.receive()
    ID2, Pass = rednet.receive()
    ID3, FileName = rednet.receive()
    if id == ID and ID2 == id and ID3 == id then
      Login = LoginCheck(Uname, Pass)
      if Login == true then
        rednet.send(id, true)
        if fs.exists("Cloud_Users/"..Uname.."/"..FileName) then
          rednet.send(id, "@File exists")
          file = fs.open("Cloud_Users/"..Uname.."/"..FileName,"r")
          Lines = file.readAll()
          rednet.send(id, Lines)
          file.close()
          term.clear()
  term.setCursorPos(1,1)
          print("User: ",Uname," downloaded file '"..FileName.."' from his Goggle Cloud.")
          print("")
        else
          rednet.send(id, "@File do not exists")
        end
      elseif Login == false then
        rednet.send(id, false)
      end
    else
      rednet.send(ID, "Wrong ID")
    end
  elseif x == "@List" then
    ID, Uname = rednet.receive()
    ID2, Pass = rednet.receive()
    if id == ID and id == ID2 then
      Login = LoginCheck(Uname, Pass)
      if Login == true then
        rednet.send(id, true)
        files = fs.list("Cloud_Users/"..Uname.."/")
        rednet.send(id, files)
      elseif Login == false then
        rednet.send(id, false)
      end
    end
  elseif x == "@Delete" then
    ID, Uname = rednet.receive()
    ID2, Pass = rednet.receive()
    if id == ID and id == ID2 then 
      Login = LoginCheck(Uname,Pass)
      if Login == true then
        rednet.send(ID, true)
        ID, FileName = rednet.receive()
        if id == ID then
          if fs.exists("Cloud_Users/"..Uname.."/"..FileName) then
            rednet.send(ID, true)
            fs.delete("Cloud_Users/"..Uname.."/"..FileName)
            term.clear()
  term.setCursorPos(1,1)
            print("User: ",Uname," removed ",FileName," from his Goggle Cloud.")
            print("")
          else
            rednet.send(ID, false)
          end
        else
          rednet.send(ID, "Wrong ID")
        end
      elseif Login == false then
        rednet.send(ID, false)
      end
    else
      rednet.send(ID, "Wrong ID")
    end
  else
    rednet.send(id, "Wrong ID")
  end
end

searchWebsite = function(websiteName)
  file = fs.exists("Websites/"..websiteName)
 if file then
  return true
 else
  return false
 end
end

LoginCheck = function(Username, Password)
  file = fs.open("/Users/"..Username,"r")
   if file then
     if Password == file.readLine() then
       return true
     else
       return false
     end
   else
     return false
    end
   file.close()
end
repeat
  Start()
until Start == false


else
 if fs.exists("Users") then
  else
  print("Generating some files..")
  fs.makeDir("Users")
  sleep(0.1)
  print("Type 'Reboot' again to start the server.")
  os.reboot()
  end
 if fs.exists("Cloud_Backup") then
  else
    print("Generating some files..")
   fs.makeDir("Cloud_Backup")
   sleep(0.1)
   print("Type 'Reboot' again to start the server.")
   os.reboot()
   end
  if fs.exists("Cloud_Users") then
   else
    print("Generating some files..")
    fs.makeDir("Cloud_Users")
    sleep(0.1)
    print("Type 'Reboot' again to start the server.")
    os.reboot()
  end
 if fs.exists("Online_Cloud_Users") then
   else
    print("Generating some files..")
    fs.makeDir("Online_Cloud_Users")
    sleep(0.1)
    print("Type 'Reboot' again to start the server.")
    os.reboot()
   end
  if fs.exists("Online_Websites") then
    else
     print("Generating some files..")
     fs.makeDir("Online_Websites")
     sleep(0.1)
     print("Type 'Reboot' again to start the server.")
     os.reboot()
    end
   if fs.exists("Websites") then
     else
      print("Generating some files..")
      fs.makeDir("Websites")
      sleep(0.1)
      print("Type 'Reboot' again to start the server.")
      os.reboot()
    end
  end
