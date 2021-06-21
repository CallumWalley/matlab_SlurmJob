function presubmit(jobject)
    
    data = jobject.data; %Rename for simplification of saved datatype.
    handle = jobject.handle;
    jobject.nJobs = numel(data);
    
    % If no matlab string. generate.
    if isempty(jobject.mlStr)
        jobject.mkmlstr();
    end
    % If no matlab string. generate.

    if isempty(jobject.slStr)
        jobject.mkslstr();
    end
    
    % Save to workspace.
    save([jobject.workDir, '/handledata.mat'], 'handle', 'data');

    if jobject.passWorkspace==1
        save([jobject.workDir,'/workspace.mat'])
    end
    
    % For debug readablility mlmString does not include escaped characters.
    % They are added below.
    %jobject.mlmString=strrep(strrep(jobject.mlmString,')','\)'),'(','\(');
    
end