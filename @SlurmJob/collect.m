function collect(jobject)
    jobject.results = cell(1, jobject.nJobs);
    failedToCollect=0;
    for i=1:jobject.nJobs
        try
            res = load([jobject.workDir, '/res', num2str(i), '.mat']);
            jobject.results(i)=res.res;
        catch
            failedToCollect = failedToCollect + 1;
        end
    end
    if failedToCollect > 0
       warning([num2str(failedToCollect), ' results failed to collect.'])      
       jobject.keepWorkDir=true;
    end
end