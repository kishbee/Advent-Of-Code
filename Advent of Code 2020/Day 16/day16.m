
rules = readInput(4);
rules = rules(1);

myTicket = readInput(2);
myTicket = myTicket(1,:);

others = readInput(2);
others = others(3:end,:);

values = [];
rules = strsplit(rules);
for i = 1:length(rules)
    if contains(rules(i),"-")
        loc = strfind(rules(i),"-");
        num1 = str2double(extractBetween(rules(i),1,loc-1));
        num2 = str2double(extractBetween(rules(i),loc+1,strlength(rules(i))));
        values = [values num1:num2];
    end
end

values = unique(values);

%%

calc = 0;

otherVals = zeros(236,20);
for i = 1:20
    otherVals(:,i) = others.(i);
end

for i = 1:numel(otherVals)
    if ~ismember(otherVals(i),values)
        calc = calc + otherVals(i);
    end
end
count = 0;
for j = 1:236
    for i = 1:20
        if ~ismember(otherVals(j,i),values)
            count = count + 1;
            blackList(count) = j;
        end
    end
end

fov = otherVals;
for i = length(blackList):-1:1
    fov(blackList(i),:) = [];
end


%%
count = 0;
for i = 1:length(rules)
    if contains(rules(i),"-")
        count = count + 1;
        if mod(count,2)
            boom = round((count+1)/2);
            ranger(boom).vals = [];
        else
            boom = round(count/2);
        end
        loc = strfind(rules(i),"-");
        num1 = str2double(extractBetween(rules(i),1,loc-1));
        num2 = str2double(extractBetween(rules(i),loc+1,strlength(rules(i))));
        ranger(boom).vals = [ranger(boom).vals num1:num2];
        
    end
end

%%

scuba = zeros(190,20,20);
for k = 1:190
for i = 1:20
    ind = fov(k,i);
    for j = 1:20
        if ismember(ind,ranger(j).vals)
            scuba(k,i,j) = 1;
        end
    end
end
end

scuba2(:,:) = prod(scuba,1);

%%
scuba3 = scuba2;
ind1 = 1:20;
ind2 = 1:20;
for i = 1:20
    category = find(sum(scuba3,1)==max(sum(scuba3,1)));
    val = find(sum(scuba3,2)==1);
            tmpr(i,:) = [ind1(val) ind2(category)];
    scuba3(val,:) = [];
    ind1(val) = [];
    scuba3(:,category) = [];
    ind2(category) = [];
end

%%
calc2 = 1;
for j = 1:6
    calc2 = calc2 * myTicket.(tmpr(find(tmpr(:,2) == j),1));
end