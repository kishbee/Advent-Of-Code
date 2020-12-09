strs = readInput(1)
for i = 26:1000
    previous = strs(i-25:i-1);
    for j = 1:25
        for k = 1:25
            if j ~= k
            ps(j,k) = previous(j) + previous(k);
            end
        end
    end
    if isempty(find(ps == strs(i)))
        strs(i)
    end
end

for i = 1:1000
    for j = i:1000
        if sum(strs(i:j)) == 26796446
            disp(num2str(i))
            disp(num2str(j))
        end
    end
end