net.Receive("cityworker", function()
    local client = LocalPlayer()

    talkablenpcs.dialog("Eren Jääger", "models/player/suits/male_08_open.mdl", "CEO", "Quickie Fixie CEO", function(ply)
        talkablenpcs.dialogframe("Eren Jääger", "models/player/suits/male_08_open.mdl", "CEO", "Quickie Fixie CEO")
        talkablenpcs.dialogtext("Hello there! Looking for some quick cash?")

        if client:Team() == FACTION_CITIZEN then
            talkablenpcs.dialogbutton("I am interested in joining this job!", 40, function()
                self:Remove()
                net.Start("cityworker_job")
                net.WriteEntity(client)
                net.SendToServer()
            end)
        elseif client:Team() == FACTION_WORKER then
            talkablenpcs.dialogbutton("I want to resign from this Job!", 40, function()
                self:Remove()
                net.Start("cityworker_resign")
                net.WriteEntity(client)
                net.SendToServer()
            end)
        end

        talkablenpcs.dialogbutton("What is this?", 40, function()
            self:Remove()
            talkablenpcs.dialogframe("Eren Jääger", "models/player/suits/male_08_open.mdl", "CEO", "Quickie Fixie CEO")
            talkablenpcs.dialogtext("Fix stuff, Get Money, that's our Motto! If you want to get yourself hired, let me know! But keep in mind this job is... SHOCKING!")
        end)
    end)
end)