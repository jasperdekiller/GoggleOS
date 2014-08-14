-- Made by Jasperdekiller and Esbenmine --
-- Don't own or distribute the Program --

-- WARNING --
-- Don't edit this, if you don't know how to work with it.
-- 1 wrong Variable could mess the whole program up.

-- GOGGLE USER DETAILS 

ServerID = 7 -- Change this one to the REAL server ID.
Lname = "" -- Don't change this one.
Uadmin = 0 -- Don't change this one.
rRank = 0 -- Don't change this one. If you think you receive an ADMIN rank if you chnage this? Wrong!
adminName = "" -- This is for the Logout system. Don't change. Else if you change it. Program is messed up.
ProgramName = "Websites/cloud.goggle.com/Cloud" -- Did you change the name of the program? Maybe to Startup? Change 'Cloud' to the new name.
serverName = "Console" -- You may change this. But I don't know why you should.. Its just an Prefix.
gogglePassword = "goggledc123" -- This will be the Password you'll need for signing up.

-- GOGGLE variables

Start = true -- Don't change this.
loginON = true -- If loginON is 'true' then Login is Enabled. Else if loginON is 'false' then Login is Disabled.
registerON = true -- Same as LoginON, only will this Enable/Disable the Register Page.

-- GOGGLE information

version = "0.1" -- Just don't change this. We will make something later what will check the version. So you can check you're Up to Date.
mode = "Beta" -- Don't change this.

-- GOGGLE functions

-- On start

term.clear()
term.setCursorPos(1,1)
xPos, yPos = term.getSize()
rednet.open("top")




-- MENU Screen
-- After logging in screen.


Menu = function()
  term.clear() if rRank == 1 then
  term.setCursorPos(1,1)
  term.setBackgroundColor(colors.white)
  term.setTextColor(colors.red)
  print("Type 'help'".."                           GoggleOS v", version)
  bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
  paintutils.drawImage(bground,1,2)
  repeat
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.blue)
    term.setCursorPos(1,yPos)
    write("Command: ")
    command = read()
    if command:upper() == "RELOG" then
      Relog()
    elseif command:upper() == "LOGOUT" then
       Logout()
    elseif command:upper() == "UPLOAD" then
      term.clear()
      term.setCursorPos(1,1)
      term.setTextColor(colors.red)
      print("Type 'help'".."                           GoggleOS v", version)
      bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
      paintutils.drawImage(bground,1,2)
      term.setTextColor(colors.blue)
      term.setCursorPos(1, yPos-1)
      print("Enter the file you wan't to upload: ")
      term.setCursorPos(1, yPos)
      FileName = read()
      rednet.send(ServerID, "@Upload")
      rednet.send(ServerID, Uname)
      rednet.send(ServerID, Pass)
      rednet.send(ServerID, FileName)
      id, Message = rednet.receive()
     if id == ServerID then
       if Message == "@File Exists" then
          term.clear()
          term.setCursorPos(1,1)
          term.setTextColor(colors.red)
          print("Type 'help'".."                           GoggleOS v", version)
          bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
          paintutils.drawImage(bground,1,2)
          term.setTextColor(colors.blue)
          term.setCursorPos(1,(yPos-1))
          print("File already exists.")
          sleep(2)
           term.clear()
           term.setCursorPos(1,1)
           term.setTextColor(colors.red)
           print("Type 'help'".."                           GoggleOS v", version)
           bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
           paintutils.drawImage(bground,1,2)
           term.setTextColor(colors.blue)
        elseif Message == "@WP" then
          term.clear()
          term.setCursorPos((xPos/2 - #"You are not logged in."),(yPos/2))
          print("You are not logged in.")
          os.reboot()
        elseif Message == "@StartUL" then
          if fs.exists(FileName) then
            rednet.send(ServerID, "@File Exists")
            file = fs.open(FileName,"r")
            FileLines = file.readAll()
            rednet.send(ServerID,FileLines)
            file.close()
            term.clear()
            term.setCursorPos(1,1)
            term.setTextColor(colors.red)
            print("Type 'help'".."                           GoggleOS v", version)
            bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
            paintutils.drawImage(bground,1,2)
            term.setTextColor(colors.blue)
            term.setCursorPos(1, yPos-2)
            print("File '"..FileName.."'".." has been sucessfully uploaded.")
          else
            rednet.send(ServerID, "@CancelUL")
            term.clear()
            term.setCursorPos(1,1)
            print("Type 'help'".."                           GoggleOS v", version)
            term.setCursorPos(1,(yPos-1))
            print("File do not exists on your computer.")
            sleep(2)
            term.clear()
            term.setCursorPos(1,1)
            term.setTextColor(colors.red)
            print("Type 'help'".."                           GoggleOS v", version)
            bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
            paintutils.drawImage(bground,1,2)
            term.setTextColor(colors.blue)
           Menu()
          end
        end
      end  
    elseif command:upper() == "HELP" then
      term.clear()
      term.setCursorPos(1,1)
      term.setTextColor(colors.red)
      print("Type 'help'".."                           GoggleOS v", version)
      term.setTextColor(colors.blue)
     if rRank == 7 then
      term.setCursorPos(1,(yPos-2))
      print("'Login'    - Login as an Admin on another account.")
      term.setCursorPos(1,(yPos-3))
      print("'Relog'    - Logout and relog automatically again.")
      term.setCursorPos(1,(yPos-4))
      print("'Logout'   - Logout from the Goggle Cloud.")
      term.setCursorPos(1,(yPos-5))
      print("'Upload'   - Upload file to Goggle Cloud.")
      term.setCursorPos(1,(yPos-6))
      print("'Download' - Download file from Goggle Cloud.")
      term.setCursorPos(1,(yPos-7))
      print("'List'     - List of your Goggle Cloud files.")
      term.setCursorPos(1,(yPos-8))
      print("'Remove'   - Remove a file from your Goggle Cloud.")
      sleep(4)
      Menu()
     elseif rRank == 1 then
      term.setCursorPos(1,(yPos-2))
      print("'Relog'    - Logout and relog automatically again.")
      term.setCursorPos(1,(yPos-3))
      print("'Logout'   - Logout from the Goggle Cloud.")
      term.setCursorPos(1,(yPos-4))
      print("'Upload'   - Upload file to Goggle Cloud.")
      term.setCursorPos(1,(yPos-5))
      print("'Download' - Download file from Goggle Cloud.")
      term.setCursorPos(1,(yPos-6))
      print("'List'     - List of your Goggle Cloud files.")
      term.setCursorPos(1,(yPos-7))
      print("'Remove'   - Remove a file from your Goggle Cloud.")
      sleep(4)
      Menu()
     else
      Logout()
     end
    elseif command:upper() == "DOWNLOAD" then
      term.clear()
      term.setCursorPos(1,1)
      term.setTextColor(colors.red)
      print("Type 'help'".."                           GoggleOS v", version)
      bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
      paintutils.drawImage(bground,1,2)
      term.setTextColor(colors.blue)
      term.setCursorPos(1,(yPos-1))
      print("Enter file name you wan't to download: ")
      term.setCursorPos(1,yPos)
      FileName = read()
     if fs.exists(FileName) then
      term.setCursorPos(1,(yPos-1))
      print("File already exists on your computer.")
      write("Would you like to rewrite it? Yes/no: ")
       rewrite = read()
        if rewrite == "yes" then
           fs.delete(FileName)
           rednet.send(ServerID, "@Download")
           rednet.send(ServerID, Uname)
           rednet.send(ServerID, Pass)
           rednet.send(ServerID, FileName)
         id, Continue = rednet.receive()
        if id == ServerID then
          if Continue == true then
            id, Message = rednet.receive()
            if id == ServerID then
                id, Lines = rednet.receive()
                  file = fs.open(FileName,"w")
                  file.write(Lines)
                  file.close()
                  term.clear()
                  term.setCursorPos(1,1)
                  print("Type 'help'".."                           GoggleOS v", version)
                  term.setCursorPos(1,(yPos-1))
                  print("sucessfully downloaded the file '"..FileName.."'.")
                end
               end
              end
       elseif rewrite == "no" then
         Menu()
          else
            Menu()
        end
      else
        rednet.send(ServerID, "@Download")
        rednet.send(ServerID, Uname)
        rednet.send(ServerID, Pass)
        rednet.send(ServerID, FileName)
        id, Continue = rednet.receive()
        if id == ServerID then
          if Continue == true then
            id, Message = rednet.receive()
            if id == ServerID then
              if Message == "@File exists" then
                id, Lines = rednet.receive()
                if id == ServerID then
                  file = fs.open(FileName,"w")
                  file.write(Lines)
                  file.close()
                  term.setCursorPos(1,(yPos-1))
                  print("sucessfully downloaded the file '"..FileName.."'.")
                  sleep(3)
                  Menu()
                else
                  rednet.send(id, "Wrong ID.")  
                end
              elseif Message == "@File do not exists" then
                term.setCursorPos(1,(yPos-1))
                print("File do not exists.")
              end
            end
          elseif Continue == false then
            term.setCursorPos(1,yPos)
            print("You are not logged in.")
          end
        else
          rednet.send(id, "Wrong ID")
        end
      end
    elseif command:upper() == "LS" or command:upper() == "LIST" then
      term.clear()
      fileManager()
    elseif command:upper() == "REMOVE" or command:upper() == "RM" then
      term.clear()
      term.setCursorPos(1,1)
      term.setTextColor(colors.red)
      print("Type 'help'".."                           GoggleOS v", version)
      bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
      paintutils.drawImage(bground,1,2)
      term.setTextColor(colors.blue)
      term.setCursorPos(1,(yPos-1))
      print("Enter the file you wan't to remove: ")
      FileName = read()
      rednet.send(ServerID, "@Delete")
      rednet.send(ServerID, Uname)
      rednet.send(ServerID, Pass)
      id, Login = rednet.receive()
      if id == ServerID then
        if Login == true then
          rednet.send(ServerID, FileName)
          id, Exists = rednet.receive()
          if id == ServerID then
            if Exists == true then
              term.setCursorPos(1,(yPos-1))
              print(FileName," deleted sucessful.")
            elseif Exists == false then
             term.clear()
             term.setCursorPos(1,1)
             term.setTextColor(colors.red)
             print("Type 'help'".."                           GoggleOS v", version)
             bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
             paintutils.drawImage(bground,1,2)
             term.setTextColor(colors.blue)
             term.setCursorPos(1,(yPos-1))
             print("File do not exists.")
             end
            else
             rednet.send(id, "Wrong ID")
           end
        elseif Login == false then
          term.setCursorPos(1,(yPos-1))
          print("You are not logged in.")
        end
      else
        rednet.send(id, "Wrong ID.")          
      end            
    else
    Menu()
end

  until Start == false


elseif rRank == 7 then
  term.setBackgroundColor(colors.white)
  print("Type 'help'".."                           Administrator")
  bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
  paintutils.drawImage(bground,1,2)
  repeat
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.red)
    term.setCursorPos(1,1)
    print("Type 'help'".."                           Administrator")
    term.setTextColor(colors.blue)
    term.setCursorPos(1,yPos)
    write("Command: ")
    command = read()
    if command:upper() == "RELOG" then
      Relog()
    elseif command:upper() == "LOGOUT" then
       Logout()
    elseif command:upper() == "LOGIN" then
      write("Username: ")
      lUser = read()
     if lUser == "jasperdekiller" then
      term.setTextColor(colors.red)
      print("You tried to login on a Administrator account!")
      print("You don't have access!")

      rednet.send(ServerID, "@abortedAdminLogin")
       rednet.send(ServerID, adminName)
       rednet.send(ServerID, "jasperdekiller")
       id, reported = rednet.receive()

       if reported == true then
         sleep(4)
         shell.run(FileName)
        else
         sleep(4)
         shell.run(FileName)
        end
     else
      rednet.send(ServerID, "@userLogin")
      rednet.send(ServerID, lUser)
      id, lExistsAnswer = rednet.receive()
       if lExistsAnswer == "@Approved" then
        print("User found.")
        sleep(2)
        Lname = lUser
        lLogin(lUser)
       elseif lExistsAnswer == "@Denied" then
        print("User does not exist.")
        sleep(2)
        Menu()
      end
  end
    elseif command:upper() == "UPLOAD" then
     if Uadmin == 1 then
      term.clear()
      term.setCursorPos(1,1)
      term.setTextColor(colors.red)
      print("Type 'help'".."                           Administrator")
      bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
      paintutils.drawImage(bground,1,2)
      term.setTextColor(colors.blue)
      term.setCursorPos(1, yPos-1)
      print("Enter the file you wan't to upload: ")
      term.setCursorPos(1, yPos)
      FileName = read()
      rednet.send(ServerID, "@uUpload")
      rednet.send(ServerID, Uname)
      rednet.send(ServerID, FileName)
      id, Message = rednet.receive()
      if id == ServerID then
        if Message == "@File Exists" then
           term.clear()
           term.setCursorPos(1,1)
           term.setTextColor(colors.red)
           print("Type 'help'".."                           Administrator")
           bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
           paintutils.drawImage(bground,1,2)
           term.setTextColor(colors.blue)
           term.setCursorPos(1,(yPos-1))
           print("File already exists.")
           sleep(2)
           term.clear()
           term.setCursorPos(1,1)
           term.setTextColor(colors.red)
           print("Type 'help'".."                           Administrator")
           bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
           paintutils.drawImage(bground,1,2)
           term.setTextColor(colors.blue)
           end
        elseif Message == "@WP" then
          term.clear()
          term.setCursorPos((xPos/2 - #"You are not logged in."),(yPos/2))
          print("You are not logged in.")
          os.reboot()
        elseif Message == "@StartUL" then
          if fs.exists(FileName) then
            rednet.send(ServerID, "@File Exists")
            file = fs.open(FileName,"r")
            FileLines = file.readAll()
            rednet.send(ServerID,FileLines)
            file.close()
            term.clear()
            term.setCursorPos(1,1)
            term.setTextColor(colors.red)
            print("Type 'help'".."                           Administrator")
            bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
            paintutils.drawImage(bground,1,2)
            term.setTextColor(colors.blue)
            term.setCursorPos(1, yPos-2)
            print("File '"..FileName.."'".." has been sucessfully uploaded.")
          else
            rednet.send(ServerID, "@CancelUL")
            term.clear()
            term.setCursorPos(1,1)
            print("Type 'help'".."                           Administrator")
            term.setCursorPos(1,(yPos-1))
            print("File do not exists on your computer.")
            sleep(2)
            term.clear()
            term.setCursorPos(1,1)
            term.setTextColor(colors.red)
            print("Type 'help'".."                           Administrator")
            bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
            paintutils.drawImage(bground,1,2)
            term.setTextColor(colors.blue)
           Menu()
          end
        end
     elseif Uadmin == 0 then
      term.clear()
      term.setCursorPos(1,1)
      term.setTextColor(colors.red)
      print("Type 'help'".."                           Administrator")
      bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
      paintutils.drawImage(bground,1,2)
      term.setTextColor(colors.blue)
      term.setCursorPos(1, yPos-1)
      print("Enter the file you wan't to upload: ")
      term.setCursorPos(1, yPos)
      FileName = read()
      rednet.send(ServerID, "@Upload")
      rednet.send(ServerID, Uname)
      rednet.send(ServerID, Pass)
      rednet.send(ServerID, FileName)
      id, Message = rednet.receive()
     if id == ServerID then
       if Message == "@File Exists" then
          term.clear()
          term.setCursorPos(1,1)
          term.setTextColor(colors.red)
          print("Type 'help'".."                           Administrator")
          bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
          paintutils.drawImage(bground,1,2)
          term.setTextColor(colors.blue)
          term.setCursorPos(1,(yPos-1))
          print("File already exists.")
          sleep(2)
           term.clear()
           term.setCursorPos(1,1)
           term.setTextColor(colors.red)
           print("Type 'help'".."                           Administrator")
           bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
           paintutils.drawImage(bground,1,2)
           term.setTextColor(colors.blue)
    end
        elseif Message == "@WP" then
          term.clear()
          term.setCursorPos((xPos/2 - #"You are not logged in."),(yPos/2))
          print("You are not logged in.")
          os.reboot()
        elseif Message == "@StartUL" then
          if fs.exists(FileName) then
            rednet.send(ServerID, "@File Exists")
            file = fs.open(FileName,"r")
            FileLines = file.readAll()
            rednet.send(ServerID,FileLines)
            file.close()
            term.clear()
            term.setCursorPos(1,1)
            term.setTextColor(colors.red)
            print("Type 'help'".."                           Administrator")
            bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
            paintutils.drawImage(bground,1,2)
            term.setTextColor(colors.blue)
            term.setCursorPos(1, yPos-2)
            print("File '"..FileName.."'".." has been sucessfully uploaded.")
          else
            rednet.send(ServerID, "@CancelUL")
            term.clear()
            term.setCursorPos(1,1)
            print("Type 'help'".."                           Administrator")
            term.setCursorPos(1,(yPos-1))
            print("File do not exists on your computer.")
            sleep(2)
            term.clear()
            term.setCursorPos(1,1)
            term.setTextColor(colors.red)
            print("Type 'help'".."                           Administrator")
            bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
            paintutils.drawImage(bground,1,2)
            term.setTextColor(colors.blue)
           Menu()
          end
        end
      end  
    elseif command:upper() == "HELP" then
      term.clear()
      term.setCursorPos(1,1)
      term.setTextColor(colors.red)
      print("Type 'help'".."                           Administrator")
      term.setTextColor(colors.blue)
     if rRank == 7 then
      term.setCursorPos(1,(yPos-2))
      print("'Login'    - Login as an Admin on another account.")
      term.setCursorPos(1,(yPos-3))
      print("'Relog'    - Logout and relog automatically again.")
      term.setCursorPos(1,(yPos-4))
      print("'Logout'   - Logout from the Goggle Cloud.")
      term.setCursorPos(1,(yPos-5))
      print("'Upload'   - Upload file to Goggle Cloud.")
      term.setCursorPos(1,(yPos-6))
      print("'Download' - Download file from Goggle Cloud.")
      term.setCursorPos(1,(yPos-7))
      print("'List'     - List of your Goggle Cloud files.")
      term.setCursorPos(1,(yPos-8))
      print("'Remove'   - Remove a file from your Goggle Cloud.")
      sleep(4)
      Menu()
     elseif rRank == 1 then
      term.setCursorPos(1,(yPos-2))
      print("'Relog'    - Logout and relog automatically again.")
      term.setCursorPos(1,(yPos-3))
      print("'Logout'   - Logout from the Goggle Cloud.")
      term.setCursorPos(1,(yPos-4))
      print("'Upload'   - Upload file to Goggle Cloud.")
      term.setCursorPos(1,(yPos-5))
      print("'Download' - Download file from Goggle Cloud.")
      term.setCursorPos(1,(yPos-6))
      print("'List'     - List of your Goggle Cloud files.")
      term.setCursorPos(1,(yPos-7))
      print("'Remove'   - Remove a file from your Goggle Cloud.")
      sleep(4)
      Menu()
     else
      Logout()
     end
    elseif command:upper() == "DOWNLOAD" then
     if Uadmin == 1 then
      term.clear()
      term.setCursorPos(1,1)
      term.setTextColor(colors.red)
      print("Type 'help'".."                           Administrator")
      bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
      paintutils.drawImage(bground,1,2)
      term.setTextColor(colors.blue)
      term.setCursorPos(1,(yPos-1))
      print("Enter file name you wan't to download: ")
      term.setCursorPos(1,yPos)
      FileName = read()
     if fs.exists(FileName) then
      term.setCursorPos(1,(yPos-1))
      print("File already exists on your computer.")
      write("Would you like to rewrite it? Yes/no: ")
       rewrite = read()
        if rewrite == "yes" then
           fs.delete(FileName)
           rednet.send(ServerID, "@uDownload")
           rednet.send(ServerID, Uname)
           rednet.send(ServerID, FileName)
         id, Continue = rednet.receive()
        if id == ServerID then
          if Continue == true then
            id, Message = rednet.receive()
            if id == ServerID then
                id, Lines = rednet.receive()
                  file = fs.open(FileName,"w")
                  file.write(Lines)
                  file.close()
                  term.clear()
                  term.setCursorPos(1,1)
                  print("Type 'help'".."                           Administrator")
                  term.setCursorPos(1,(yPos-1))
                  print("sucessfully downloaded the file '"..FileName.."'.")
                end
               end
              end
       elseif rewrite == "no" then
         Menu()
          else
            Menu()
        end
      else
        rednet.send(ServerID, "@uDownload")
        rednet.send(ServerID, Uname)
        rednet.send(ServerID, FileName)
        id, Continue = rednet.receive()
        if id == ServerID then
          if Continue == true then
            id, Message = rednet.receive()
            if id == ServerID then
              if Message == "@File exists" then
                id, Lines = rednet.receive()
                if id == ServerID then
                  file = fs.open(FileName,"w")
                  file.write(Lines)
                  file.close()
                  term.setCursorPos(1,(yPos-1))
                  print("sucessfully downloaded the file '"..FileName.."'.")
                  sleep(3)
                  Menu()
                else
                  rednet.send(id, "Wrong ID.")  
                end
              elseif Message == "@File do not exists" then
                term.setCursorPos(1,(yPos-1))
                print("File do not exists.")
              end
            end
          elseif Continue == false then
            term.setCursorPos(1,yPos)
            print("You are not logged in.")
          end
        else
          rednet.send(id, "Wrong ID")
        end
      end

     elseif Uadmin == 0 then
      term.clear()
      term.setCursorPos(1,1)
      term.setTextColor(colors.red)
      print("Type 'help'".."                           Administrator")
      bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
      paintutils.drawImage(bground,1,2)
      term.setTextColor(colors.blue)
      term.setCursorPos(1,(yPos-1))
      print("Enter file name you wan't to download: ")
      term.setCursorPos(1,yPos)
      FileName = read()
     if fs.exists(FileName) then
      term.setCursorPos(1,(yPos-1))
      print("File already exists on your computer.")
      write("Would you like to rewrite it? Yes/no: ")
       rewrite = read()
        if rewrite == "yes" then
           fs.delete(FileName)
           rednet.send(ServerID, "@Download")
           rednet.send(ServerID, Uname)
           rednet.send(ServerID, Pass)
           rednet.send(ServerID, FileName)
         id, Continue = rednet.receive()
        if id == ServerID then
          if Continue == true then
            id, Message = rednet.receive()
            if id == ServerID then
                id, Lines = rednet.receive()
                  file = fs.open(FileName,"w")
                  file.write(Lines)
                  file.close()
                  term.clear()
                  term.setCursorPos(1,1)
                  print("Type 'help'".."                           Administrator")
                  term.setCursorPos(1,(yPos-1))
                  print("sucessfully downloaded the file '"..FileName.."'.")
                end
               end
              end
       elseif rewrite == "no" then
         Menu()
          else
            Menu()
        end
      else
        rednet.send(ServerID, "@Download")
        rednet.send(ServerID, Uname)
        rednet.send(ServerID, Pass)
        rednet.send(ServerID, FileName)
        id, Continue = rednet.receive()
        if id == ServerID then
          if Continue == true then
            id, Message = rednet.receive()
            if id == ServerID then
              if Message == "@File exists" then
                id, Lines = rednet.receive()
                if id == ServerID then
                  file = fs.open(FileName,"w")
                  file.write(Lines)
                  file.close()
                  term.setCursorPos(1,(yPos-1))
                  print("sucessfully downloaded the file '"..FileName.."'.")
                  sleep(3)
                  Menu()
                else
                  rednet.send(id, "Wrong ID.")  
                end
              elseif Message == "@File do not exists" then
                term.setCursorPos(1,(yPos-1))
                print("File do not exists.")
              end
            end
          elseif Continue == false then
            term.setCursorPos(1,yPos)
            print("You are not logged in.")
          end
        else
          rednet.send(id, "Wrong ID")
        end
      end
     end
    elseif command:upper() == "LS" or command:upper() == "LIST" then
      fileManager()
    elseif command:upper() == "REMOVE" or command:upper() == "RM" then
      term.clear()
      term.setCursorPos(1,1)
      term.setTextColor(colors.red)
      print("Type 'help'".."                           Administrator")
      bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
      paintutils.drawImage(bground,1,2)
      term.setTextColor(colors.blue)
      term.setCursorPos(1,(yPos-1))
      print("Enter the file you wan't to remove: ")
      FileName = read()
      rednet.send(ServerID, "@Delete")
      rednet.send(ServerID, Uname)
      rednet.send(ServerID, Pass)
      id, Login = rednet.receive()
      if id == ServerID then
        if Login == true then
          rednet.send(ServerID, FileName)
          id, Exists = rednet.receive()
          if id == ServerID then
            if Exists == true then
              term.setCursorPos(1,(yPos-1))
              print(FileName," deleted sucessful.")
            elseif Exists == false then
             term.clear()
             term.setCursorPos(1,1)
             term.setTextColor(colors.red)
             print("Type 'help'".."                           Administrator")
             bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
             paintutils.drawImage(bground,1,2)
             term.setTextColor(colors.blue)
             term.setCursorPos(1,(yPos-1))
             print("File do not exists.")
             end
            else
             rednet.send(id, "Wrong ID")
           end
        elseif Login == false then
          term.setCursorPos(1,(yPos-1))
          print("You are not logged in.")
        end
      else
        rednet.send(id, "Wrong ID.")          
      end            
    else
      Menu()
    
end

  until Start == false
end
end -- End of the MAIN function.


-- FILEMANAGER --

function fileManager()
  if Uadmin == 1 then
        ChoosedFile = ""
      term.clear()
      term.setCursorPos(1,1)
      bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.bfilemanager")
      paintutils.drawImage(bground,1,1)
      term.setTextColor(colors.white)
      rednet.send(ServerID, "@uList")
      rednet.send(ServerID, Lname)
      id, Login = rednet.receive()
     if id == ServerID then
        if Login == true then
          id, Files = rednet.receive()
          if id == ServerID then
            term.setCursorPos(2,1)
            print("CLOUD:") 
            print("============")
            term.setCursorPos(15,1)
            print("You have ",table.getn(Files)," file(s) in Goggle Cloud. ")
            term.setCursorPos(14,2)
            print("======================================")
            term.setCursorPos(28,13)
            term.setTextColor(colors.black)
            term.setBackgroundColor(colors.lightGray)
            print("DOWNLOAD")
            term.setBackgroundColor(colors.blue)
            term.setTextColor(colors.white)
            term.setCursorPos(41,18)
            print("Go back ->")

            for i = 1, table.getn(Files) do
              term.setCursorPos(2,(3+i))
              write(Files[i],"      ")
            end
            Selected = false
            while true do
            term.setCursorPos(23, 6)
            print("FILE SELECTED:")

            local event, button, xPos, yPos = os.pullEvent("mouse_click")
             if xPos <= 40 and xPos >= 23 and yPos == 13 then
              if ChoosedFile == "" then
                fileManager()
             else
              FileName = ChoosedFile
              fs.delete(FileName)
              rednet.send(ServerID, "@uDownload")
              rednet.send(ServerID, Uname)
              rednet.send(ServerID, FileName)
              id, Continue = rednet.receive()
              if id == ServerID then
               if Continue == true then
                id, Message = rednet.receive()
                 if id == ServerID then
                  id, Lines = rednet.receive()
                  file = fs.open(FileName,"w")
                  file.write(Lines)
                  file.close()
                  term.clear()
                  term.setCursorPos(8,(yPos-1))
                  print("sucessfully downloaded the file '"..FileName.."'.")
                  sleep(2)
                  fileManager()
                 end
                end
             elseif rewrite == "no" then
              Menu()
             else
              Menu()
            end
           end
              elseif xPos <= 50 and xPos >= 41 and yPos == 18 then
                sleep(0.4)
                Menu()
               end
            for i = 4, table.getn(Files)+4 do

              if xPos <= 12 and xPos >= 2 and yPos == i then 
                term.setCursorPos(2,i)
                term.setBackgroundColor(colors.lightBlue)
                ChoosedFile = Files[i-3]
                print(Files[i-3])
                 term.setBackgroundColor(colors.blue)
                 term.setCursorPos(23, 8)
                 print("               ")
                 term.setCursorPos(23, 8)
                 print(ChoosedFile)
                if Selected then
                  term.setBackgroundColor(colors.blue)
                  term.setCursorPos(2,lastI)
                  print(Files[lastI-3])
                 else
                  ChoosedFile = ""
                  term.setBackgroundColor(colors.blue)
                  term.setCursorPos(23, 8)
                  print("               ")
                end
                lastI = i
                Selected = true
                break
             end
            end
           end
          end
          else
            rednet.send(id, "Wrong ID")
          end
        else
          term.setCursorPos(1,(yPos-1))
          print("You are not logged in.")
        end
      
  elseif Uadmin == 0 then
        ChoosedFile = ""
      term.clear()
      term.setCursorPos(1,1)
      bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.bfilemanager")
      paintutils.drawImage(bground,1,1)
      term.setTextColor(colors.white)
      rednet.send(ServerID, "@List")
      rednet.send(ServerID, Uname)
      rednet.send(ServerID, Pass)
      id, Login = rednet.receive()
     if id == ServerID then
        if Login == true then
          id, Files = rednet.receive()
          if id == ServerID then
            term.setCursorPos(2,1)
            print("CLOUD:") 
            print("============")
            term.setCursorPos(15,1)
            print("You have ",table.getn(Files)," file(s) in Goggle Cloud. ")
            term.setCursorPos(14,2)
            print("======================================")
            term.setCursorPos(28,13)
            term.setTextColor(colors.black)
            term.setBackgroundColor(colors.lightGray)
            print("DOWNLOAD")
            term.setBackgroundColor(colors.blue)
            term.setTextColor(colors.white)
            term.setCursorPos(41,18)
            print("Go back ->")

            for i = 1, table.getn(Files) do
              term.setCursorPos(2,(3+i))
              write(Files[i],"      ")
              print("")
            end
            Selected = false
            while true do
            term.setCursorPos(23, 6)
            print("FILE SELECTED:")

            local event, button, xPos, yPos = os.pullEvent("mouse_click")
             if xPos <= 40 and xPos >= 23 and yPos == 13 then
              if ChoosedFile == "" then
                fileManager()
             else
              FileName = ChoosedFile
              fs.delete(FileName)
              rednet.send(ServerID, "@Download")
              rednet.send(ServerID, Uname)
              rednet.send(ServerID, Pass)
              rednet.send(ServerID, FileName)
              id, Continue = rednet.receive()
              if id == ServerID then
               if Continue == true then
                id, Message = rednet.receive()
                 if id == ServerID then
                  id, Lines = rednet.receive()
                  file = fs.open(FileName,"w")
                  file.write(Lines)
                  file.close()
                  term.clear()
                  term.setCursorPos(8,(yPos-1))
                  print("sucessfully downloaded the file '"..FileName.."'.")
                  sleep(2)
                  fileManager()
                 end
                end
             elseif rewrite == "no" then
              Menu()
             else
              Menu()
            end
           end
              elseif xPos <= 50 and xPos >= 41 and yPos == 18 then
                sleep(0.4)
                Menu()
               end
            for i = 4, table.getn(Files)+4 do

              if xPos <= 12 and xPos >= 2 and yPos == i then 
                term.setCursorPos(2,i)
                term.setBackgroundColor(colors.lightBlue)
                ChoosedFile = Files[i-3]
                print(Files[i-3])
                 term.setBackgroundColor(colors.blue)
                 term.setCursorPos(23, 8)
                 print("               ")
                 term.setCursorPos(23, 8)
                 print(ChoosedFile)
                if Selected then
                  term.setBackgroundColor(colors.blue)
                  term.setCursorPos(2,lastI)
                  print(Files[lastI-3])
                 else
                  ChoosedFile = ""
                  term.setBackgroundColor(colors.blue)
                  term.setCursorPos(23, 8)
                  print("               ")
                end
                lastI = i
                Selected = true
                break
             end
            end
           end
          end
          else
            rednet.send(id, "Wrong ID")
          end
        else
          term.setCursorPos(1,(yPos-1))
          print("You are not logged in.")
        end
      end
    end -- End of the FileManager function.

-- Login function --

function Logout()

   term.clear()
        Lname = "" -- Don't change this one.
        Uadmin = 0 -- Don't change this one.
        rRank = 0 -- Don't change this one. If you think you receive an ADMIN rank if you chnage this? Wrong!
        adminName = "" -- This is for the Logout system. Don't change. Else if you change it. Program is messed up.
        term.setCursorPos(1,1)
        term.setTextColor(colors.red)
        print("                                      GoggleOS v", version)
        bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
        paintutils.drawImage(bground,1,2)
        term.setCursorPos(19,5)
        print("Saving Data..")
        sleep(1)
        term.clear()
        term.setCursorPos(1,1)
        term.setTextColor(colors.red)
        print("                                      GoggleOS v", version)
        bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
        paintutils.drawImage(bground,1,2)
        term.setCursorPos(19,5)
        print("Logging out..")
        sleep(2)
        rednet.send(ServerID, "@Logout")
        rednet.send(ServerID, Uname)
        rednet.send(ServerID, Pass)
       id, LogoutAnswer = rednet.receive()
      if LogoutAnswer == "@Aborted" then
           term.clear()
           term.setBackgroundColor(colors.white)
           term.setCursorPos(15,5)
           term.setTextColor(colors.red)
           print("Logout cancelled by: ", serverName)
           sleep(1)
           shell.run(ProgramName)
      elseif LogoutAnswer == "@Approved" then
          Uname = ""
          sleep(1)
          shell.exit()
          shell.run("Websites/cloud.goggle.com/Cloud")
        end
      end -- End of the Login function.

-- Checkbanned function --
-- This function is disabled, will be enabled later.

function checkBanned()

rednet.send(ServerID, "@askBanned")
rednet.send(ServerID, Uname)

id, Answ = rednet.receive()

  if Answ == "@You_have_been_Banned" then
    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(colors.red)
    print("You have been Banned from the Goggle Cloud.")
    print("If you think this is an error, please")
    print("contact someone from the Goggle Staff.")
    print("")
    print("Redirecting in 5 seconds..")
    sleep(5)
    Login()
   else
    Menu()
end
end -- End of the checkBanned function.

-- The Relog function

function Relog()

        term.clear()
        term.setCursorPos(1,1)
        term.setTextColor(colors.red)
        print("                                      GoggleOS v", version)
        bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
        paintutils.drawImage(bground,1,2)
        term.setCursorPos(19,5)
        print("Saving Data..")
        sleep(1)
        term.clear()
        term.setCursorPos(1,1)
        term.setTextColor(colors.red)
        print("                                      GoggleOS v", version)
        bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
        paintutils.drawImage(bground,1,2)
        term.setCursorPos(19,5)
        print("Logging out..")
        sleep(2)
        rednet.send(ServerID, "@Logout")
        rednet.send(ServerID, Uname)
        rednet.send(ServerID, Pass)
       id, LogoutAnswer = rednet.receive()
      if LogoutAnswer == "@Aborted" then
           term.clear()
           term.setBackgroundColor(colors.white)
           term.setCursorPos(15,5)
           term.setTextColor(colors.red)
           print("Logout cancelled by: ", serverName)
           sleep(1)
           Menu()
      elseif LogoutAnswer == "@Approved" then
        term.clear()
        term.setCursorPos(1,1)
        term.setTextColor(colors.red)
        print("                                      GoggleOS v", version)
        bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.background")
        paintutils.drawImage(bground,1,2)
        term.setCursorPos(19,5)
        rednet.send(ServerID, "@relogMessage")
        rednet.send(ServerID, Uname)
        print("Logging in..")
         sleep(1)
          Menu()
        end
       end -- End of the Relog function.

-- User Login function --

lLogin = function(username)

if rRank == 7 then
  Uadmin = Uadmin + 1
  rednet.send(ServerID, "@AdminLoginMessage")
  rednet.send(ServerID, Lname)
  rednet.send(ServerID, adminName)

  id, answerBack = rednet.receive()

  if answerBack == true then

  term.setTextColor(colors.red)
  print("You're now logged in as: ", Uname)
  term.setTextColor(colors.black)
  Menu()
 else
  Login()
 end
  else
    Menu()
  end
end -- End of the Login function.






-- The Login Function --

Login = function()
  repeat
    term.clear()
    bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.blogin")
    paintutils.drawImage(bground,1,2)
    term.setCursorPos(1,1)
    term.setTextColor(colors.red)
    print("                                      GoggleOS v", version)
    term.setTextColor(colors.black)
    term.setCursorPos(34,13)
    term.setBackgroundColor(colors.lightGray)
    print("LOGIN")
    term.setBackgroundColor(colors.lightBlue)
    term.setCursorPos(12,6)
    term.write("Username: ")
    term.setCursorPos(12,8)
    term.write("Password: ")
    term.setCursorPos(22,6)
    Uname = read()
    term.setCursorPos(22,8)
    Pass = read("*")

    while true do

    local event, button, X, Y = os.pullEventRaw()

    if event == "mouse_click" then
     if Y==13 and X >=33 and X <=39 then
      if loginON == false then
        term.setBackgroundColor(colors.white)
        term.setCursorPos((xPos/2 - #"Login is disabled."/2),18)
        print("Login is disabled.")
        sleep(1)  
        Login()
      elseif loginON == true then
        rednet.send(ServerID, "@Pass")
        rednet.send(ServerID, Uname)
        rednet.send(ServerID, Pass)
       id, Answer = rednet.receive()
        if Answer == "@CP" then
         id, rank = rednet.receive()
          if rank == "1" then
           rRank = rRank + 1
           checkBanned()
          elseif rank == "7" then
           rRank = rRank + 7
           adminName = Uname
           Menu()
         end
      elseif Answer == "@WP" then
       term.setBackgroundColor(colors.white)
       term.setCursorPos((xPos/2 - #"Incorrect Username or Password"/2),18)
       print("Incorrect Username or Password!")
       sleep(1)  
       Login()
      elseif Answer == "@AL" then
        print("Already logged in.")
        sleep(2)
        Login()
     end
  end
 end
end
end
  until Answer == "@CP"
          end -- End of the Login function.

-- The Register function --

function Register()

    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(colors.black)
    bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.register")
    paintutils.drawImage(bground,1,1)
    term.setBackgroundColor(colors.cyan)
    term.setCursorPos(12, 2)
    write("Username: ")
    term.setCursorPos(12, 5)
    write("Password: ")
    term.setCursorPos(12, 7)
    write("Confirm Password: ")
    term.setCursorPos(12, 11)
    print("What is:")
    term.setCursorPos(12, 12)
    write("17 + 5 = ")
    term.setCursorPos(12, 14)
    write("Goggle Password: ")
    term.setCursorPos(21,17)
    term.setBackgroundColor(colors.lightGray)
    print("REGISTER")
    term.setBackgroundColor(colors.cyan)
    term.setCursorPos(22, 2)
    rUsername = read()
    rednet.send(ServerID, "@rNA")
    rednet.send(ServerID, rUsername)
    id, message = rednet.receive()
   if message == "@AIU" then
     term.setCursorPos(12, 3)
     term.setTextColor(colors.red)
     print("Name not available!")
     sleep(2)
     Register()
   elseif message == "@AV" then
    term.setCursorPos(22, 5)
    rPassword = read("*")
    term.setCursorPos(31, 7)
    rCPassword = read("*")
     if rPassword == rCPassword then
       term.setCursorPos(21, 12)
       som = read()
        if som == "22" then
          term.setCursorPos(29, 14)
          gogglePass = read("*")
           if gogglePass == gogglePassword then
            while true do

             local event, button, X, Y = os.pullEventRaw()

             if event == "mouse_click" then
              if Y==17 and X >=20 and X <=28 then
                rednet.send(ServerID, "@SaveRegisterDetails")
                rednet.send(ServerID, rUsername)
                rednet.send(ServerID, rPassword)
               id, rAnswer = rednet.receive()
                if rAnswer == "@Saved" then
                 sleep(2)
                 Login()
              elseif rAnswer == "@Not_Saved" then
                Register()
            end
          end
         end
        end
         else
             term.setCursorPos(12, 15)
             term.setTextColor(colors.red)
             print("Goggle Password was wrong!")
             sleep(2)
             Register()
           end
     else
        term.setCursorPos(12, 13)
        term.setTextColor(colors.red)
        print("Captcha was wrong.")
        sleep(2)
        Register()
      end
     else
      term.setCursorPos(12, 6)
      term.setTextColor(colors.red)
      print("Password's didn't match.")
      sleep(2)
      Register()
  end
 end
end -- The end of the Register function

-- The Start page --
-- This will display the Start Page so you're able to choose "Login" or "Register".

function LoginRegister()

    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(colors.red)
    print("                                      GoggleOS v", version)
    bground = paintutils.loadImage("Websites/cloud.goggle.com/Images/Backgrounds/.bloginregister")
    paintutils.drawImage(bground,1,1)
    term.setTextColor(colors.black)
    term.setCursorPos(16,14)
    term.setBackgroundColor(colors.lightGray)
    print("REGISTER")
    term.setCursorPos(28,14)
    print("LOGIN")
    
    while true do

    local event, button, X, Y = os.pullEventRaw()



    if event == "mouse_click" then
     if Y==14 and X >=16 and X <=23 then
       if registerON then
         Register()
        else
          term.setBackgroundColor(colors.white)
          term.setCursorPos((xPos/2 - #"The Register page is disabled."/2),18)
          print("The Register page is disabled.")
          sleep(1)  
          LoginRegister()
         end
       elseif Y==14 and X >=28 and X<=32 then
  Login()
  end
 end
end
end -- The end of the Login / Register page.

term.setCursorPos(1,1)
term.setBackgroundColor(colors.red)
term.clearLine()
term.setTextColor(colors.white)
print("Click this line and the quarry box will appear.")
term.setBackgroundColor(colors.white)
sleep(2)
term.setCursorPos(1,1)
term.clearLine()
term.setCursorPos(1,1)
term.setTextColor(colors.red)
print("                                      GoggleOS v", version)
term.setCursorPos(22,8)
term.setTextColor(colors.gray)
print("Loading..")
sleep(1)
term.setTextColor(colors.white)
if not term.isColor or not term.isColor() then
        print('GoggleOS Requires an Advanced (gold) Computer')
      else
        LoginRegister()
end
