function mkmlstr(jobject)
%% Make matlab string
    jobject.mlStr = '';
    % Save entire workspace if requested.
    if jobject.passWorkspace==1
        jobject.mlStr = append(jobject.mlStr, 'load(''', jobject.workDir, '/workspace.mat', ''');');
    end
    % Save handle function and data.
    jobject.mlStr = append(jobject.mlStr, 'load(''', jobject.workDir, '/handledata.mat', ''');');
    
    % Check if this function returns outputs. If so, write out.
    jobject.handleArgOut = nargout(jobject.handle);
    if jobject.handleArgOut > 0
       jobject.mlStr=append(jobject.mlStr, 'res=handle(data(\${SLURM_ARRAY_TASK_ID}));save(''',jobject.workDir, '/res\${SLURM_ARRAY_TASK_ID}.mat'', ''res'');exit;');
    else
        jobject.mlStr=append(jobject.mlStr, 'handle(data(\${SLURM_ARRAY_TASK_ID}));exit;');
    end
    
end

