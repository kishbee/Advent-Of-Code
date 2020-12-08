function count = d3f(right,down)

strcase = readInput(3); % take in Input
ind = 1; %start index
count = 0;
jump = 1:down:length(strcase);
for i = jump(2:end)
    ind = ind + right;
    ind = mod(ind,strlength(strcase(1)));
    if ind == 0
        ind = strlength(strcase(1));
    end
    if strcmp(extractBetween(strcase(i),ind,ind),"#")
        count = count + 1; %add to tree count
    end
end

end

