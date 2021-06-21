function submit(jobject)

    jobject.presubmit();
    [status, stdout]=system(jobject.slStr);
    if status == 1
        error(stdout);
    end
    stdoutSplit = split(stdout, ' ');
    jobject.jobid = strtrim(stdoutSplit{4});
    jobject.status = "PENDING";
end