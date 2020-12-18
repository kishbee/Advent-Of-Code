%% part 1 and 2
vals = [15,5,1,4,7,0];

for i = length(vals)+1:30000000
    if isempty(find(vals(1:i-2) == vals(i-1)))
        vals(i) = 0;
    else
        tmp = find(vals(1:i-2) == vals(i-1));
        tmp = tmp(end);
        vals(i) = i-tmp-1;
    end
end

vals(end)
