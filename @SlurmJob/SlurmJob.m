classdef SlurmJob < handle
    % SlurmManager Class for managing Slurm jobs within MATLAB.
    %   Detailed explanation goes here
    properties
        slurmArg = struct;
        silent = false;
        passWorkspace = false;        
        workDir;
        keepWorkDir = false;
        handle = @disp;
        data = {'No data'};
        mlStr;
        slStr;
        waitPeriod = 5; %Time 
        arrayMax = 40; % Limit to this many jobs at once.
        %progBarSize = 40;
        %throbber = ["/ ", "- ", "\\ ", "| "];
    end
    properties (SetAccess = protected, GetAccess=public)
        nJobs;
        jobid;
        handleArgOut;
        results;
        status='UNKNOWN';
    end

    methods
        add(jobject,key,value);
        testsubmit(jobject);
        submit(jobject);
        % Constructor
        function obj=SlurmJob()   
            % take slurm id to follow existing job.
            obj.workDir=tempname(pwd);
            obj.add('output', [obj.workDir,'/slurm%x.out']);
            obj.add('open-mode', 'append');
            mkdir(obj.workDir)
        end
    end
    
%    methods (Access = protected)
    methods (Access = public)

        presubmit(jobject);
        collect(jobject);
        mkslstr(jobject);
        mkmlstr(jobject);
    end
end

