function addarg(obj,key,value)
    key = strrep(key,'-','_');
    
    obj.slurmArg.(key)=value;

end