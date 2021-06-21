function results=wait(jobject)
% Blocking method, will wait until all jobs are complete then return results.
% Still undecided on whether this method should return a value or not.
% as value is accesable in the 'jobject.results' property anyway.


%     [submitstatus, returnstring]=system(strjoin(['sacct -nj ', jjobjectect.jobid, ' --array | wc -l'],''));
%     if submitstatus ~= 0
%         error(returnstring);
%     end
%     arraysize = str2int(returnstring) - 1;

    while 1
        nStates={};
        
        squeuecmd = ['squeue -hj ' jobject.jobid ' --array --format %T'];
        [submitstatus, returnstring]=system(squeuecmd);
        returnArray = split(strtrim(returnstring));
        
        for i=1:length(returnArray)
            try
                % Parsing of squeue could be improved.

                state=returnArray{i};
                if length(state)<2
                    break
                end
                if isfield(nStates,state)
                    nStates.(state)=nStates.(state)+1;
                else
                    nStates.(state)=1;
                end
            catch
                warning(returnArray{i});
            end
        end
        
        nFin = length(jobject.data)-length(returnArray);
        
        if nFin > 1
            nStates.('FINISHED')=nFin;
        end
        
        jobject.status = "";
        fn = fieldnames(nStates);
        
        for i=1:numel(fn)
            jobject.status = jobject.status + fn{i} + ':' + num2str(nStates.(fn{i})) + '  ';
        end
        
        if ~jobject.silent
            fprintf("\r" + jobject.status);
        end
        
        if submitstatus ~= 0
            error(returnstring);
        end      
        
        if length(returnArray{1}) < 1           
            break;
        end
        
        pause(jobject.waitPeriod);
    end
    
    if jobject.handleArgOut > 0
        jobject.collect;
        results = jobject.results;
    end
    
    if ~jobject.keepWorkDir
        rmdir(jobject.workDir)
    end

    
end