function count = d3f(strcase,right,down)

ind = 1;
count = 0;
jump = 1:down:length(strcase);
for i = jump(2:end)
    ind = ind + right;
    ind = mod(ind,strlength(strcase(1)));
    if ind == 0
        ind = 31;
    end
    if strcmp(extractBetween(strcase(i),ind,ind),"#")
        count = count + 1;
    end
end

end

