GM = GM or GAMEMODE
print("MYSQL DATABASE IS OFFLINE! WE RECOMMEND TO ENABLE IT IF YOU ARE USING LILIA!")
--[[
function GM:SetupDatabase()
    -- Which method of storage: sqlite, tmysql4, mysqloo
    lia.db.module = "mysqloo"
    -- The hostname for the MySQL server.
    lia.db.hostname = ""
    -- The username to login to the database.
    lia.db.username = ""
    -- The password that is associated with the username.
    lia.db.password = ""
    -- The database that the user should login to.
    lia.db.database = ""
    -- The port for the database, you shouldn't need to change this.
    lia.db.port = 3306
end
]]