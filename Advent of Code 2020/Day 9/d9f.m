function [bug,vul,strs] = d9f()

bug = 0;
strs = readInput(1);
for i = 26:1000
    previous = strs(i-25:i-1);
    for j = 1:25
        for k = 1:25
            if j ~= k
            ps(j,k) = previous(j) + previous(k);
            end
        end
    end
    if isempty(find(ps == strs(i))) && bug == 0
        bug = strs(i);
    end
end

vul = 0;
for i = 1:1000
    for j = i:1000
        if sum(strs(i:j)) == bug && i ~= j && vul == 0
            vul = min(strs(i:j)) + max(strs(i:j));
        end
    end
end
end