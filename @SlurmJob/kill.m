function kill(obj)
            squeuecmd = ['skill ', obj];
            [submitstatus, returnstring]=system(strjoin(squeuecmd,''));
            if submitstatus ~= 0
                error(returnstring);
            end
            rmdir(obj.workspace, 's');         
end