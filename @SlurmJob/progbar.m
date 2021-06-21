function progbar()
    nthrobber = 1;
    endStr = "";
    barSoFar = pad([repmat(char(9615), 1, floor(jobject.progBarSize*run_count/length(jobject.data)))+1, repmat(' ', 1, floor(jobject.progBarSize*pend_count/length(jobject.data))+1)], jobject.progBarSize, 'left', char(9608));
    outstring = strjoin([endStr, 'Progress: |', barSoFar, '|  [', jobject.throbber(nthrobber), ']'],'');
    fprintf(outstring);

    if usejava('desktop')  % Check if GUI or CLI
        endStr = "\x0D";
        %endStr = repelem("\b", strlength(outstring));
    else
        %endStr = "\033[1F\033[2K\r";
        endStr = "\r";
    end

    if nthrobber >= length(jobject.throbber);nthrobber = 1;else; nthrobber = nthrobber + 1; end
    if all_count < 1; break; end  
end