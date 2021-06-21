classdef SlurmJob < handle
    % SlurmManager Class for managing Slurm jobs within MATLAB.
    % Slurm 
    % Create new instance by calling 'SlurmJob'.
    % Assign slurm arguments using 'addarg' method (could also assign direclty if lazy).
    % 
    properties
        handle = @disp;         % Function to be called.
        data;                   % Data to do paralell operation on. Must be iterable.
        constants = {};         % Constants needed by the function. 

        slurmArg = struct;      % Aruments to be passed to slurm.
        silent = false;         % Does nothing. 
        passWorkspace = false;  % Passes entire workspace to function. Don't do this.       
        workDir;                % Temporary Working directory. Set automatically if unassigned.
        keepWorkDir = false;    % Delete WorkDir on sucessful completion.
        mlStr;                  % Matlab command to be run. Can be set manually.
        slStr;                  % slurm command to be run. Can be set manually.
        waitPeriod = 15;        % How often to ping squeue when waiting. 
        arrayMax = 40;          % Limit to this many jobs at once. Same as slurm array '%'
        
        
        % In the form {'const1' 'const2'}
        % progBarSize = 40;
        % throbber = ["/ ", "- ", "\\ ", "| "];
    end
    properties (SetAccess = protected, GetAccess=public)
        nJobs;                  % Number jobs to run. Equal to length of 'data'
        jobid;                  % Slurm job id.
        handleArgOut;           % How many arguments the output has, maybe?
        results;                % The results. Cell array.
        status='UNKNOWN';       % Current slurm job status.
    end

    methods
        addarg(jobject,key,value);
        testsubmit(jobject);
        submit(jobject);
        % Constructor
        function obj=SlurmJob()   
            % take slurm id to follow existing job.
            obj.workDir=tempname(pwd);
            obj.addarg('output', [obj.workDir,'/slurm%x.out']);
            obj.addarg('open-mode', 'append');
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

