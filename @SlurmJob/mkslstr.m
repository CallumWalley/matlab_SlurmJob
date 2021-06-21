function mkslstr(jobject)
    %% Make slurm string
    
    jobject.slStr = 'sbatch ';
    fn = fieldnames(jobject.slurmArg);
    for i=1:numel(fn)
        jobject.slStr = append(jobject.slStr, ' --', strrep(fn{i},'_','-'), ' ', jobject.slurmArg.(fn{i}));
    end
    
    jobject.slStr = append( jobject.slStr, ' --array 1-', num2str(length(jobject.data)), '%', num2str(jobject.arrayMax)); 
    jobject.slStr =  append( jobject.slStr, ' --wrap "matlab -nodisplay -r \"', jobject.mlStr, '\""' );
end

