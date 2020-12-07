function fin = d6f(type)
%% anyone
if type == 1
strs = readInput(5);
for i = 1:size(strs,1)
    vals = convertStringsToChars(strs.Var1{i,1});
    if ~ischar(vals)  
        vals = unique(strjoin(vals));
    end
    count(i) = length(vals);
    if double(vals(1)) == 32
        count(i) = count(i) - 1;
    end
end

fin = sum(count)


%% everyone
elseif type == 2
strs = readInput(5);
for i = 1:length(strs.Var1)
    tmp = strs.Var1{i,1};
    tmp = convertStringsToChars(tmp);
    if iscell(tmp)
        vals = tmp{1};
        for j = 2:length(tmp)
            vals = intersect(vals,tmp{j});
        end
        
    else
        vals = tmp;
    end
    
    if ~isempty(vals)
        count(i) = length(unique(vals));
        tmp2 = unique(vals);
        if double(tmp2(1)) == 32
            count(i) = count(i) - 1;
        end
    else
        count(i) = 0;
    end
    %clearvars vals
end

fin = sum(count)
end