%% read input
tmp = readInput(2);
strs = strings(size(tmp,1),1);
for i =1:size(tmp)
    tmp2 = tmp{i,:};
    tmp2 = convertCharsToStrings(tmp2);
    strs(i) = strjoin(tmp2);
end

%%
bagList = strings(size(tmp,1),1);
for i = 1:length(strs)
    tmp = strfind(strs(i),"bag");
    bagList(i) = extractBetween(strs(i),1,tmp(1)-2);
end
bagList=bagList';

%%
clearvars tmp tmp2
for i = 1:length(strs)
    bag(i).List = bagList(i);
    count = 0;
    for j = 1:length(strs)
        if i ~= j && contains(strs(i),bagList(j))
            count = count + 1;
            tmp(count) = j;
            tmp2(count) = str2double(extractBetween(strs(i),strfind(strs(i),bagList(j))-3,strfind(strs(i),bagList(j))-1));
        end
    end
    if exist("tmp",'var')
        bag(i).contained = tmp;
        bag(i).bagCount = tmp2;
    else
        bag(i).contained = [];
        bag(i).bagCount = [];
    end
    clearvars tmp tmp2
end
%%
outVals = bagRecursion(bag,384,strs);
length(unique(outVals))-1 %count bags containing shiny gold

%%
insideBags(bag,384,strs)-1 %count inside bags

%%
function outVals = bagRecursion(bag,vals,strs)

vals = unique(vals);
tmp = vals;
count = length(tmp);

for i = 1:length(bag)
    if sum(ismember(bag(i).contained,vals))>0
        count = count + 1;
        tmp(count) = i;
    end
end

tmp = unique(tmp);

if isequal(vals,tmp)
    outVals = vals;
else
    outVals = [tmp bagRecursion(bag,tmp,strs)];
end

end
%%
function counter = insideBags(bag,vals,strs)

count = 1;
for i = 1:length(vals)
    if ~isempty(bag(vals(i)).bagCount)
        for j = 1:length(bag(vals(i)).bagCount)
            count = count + bag(vals(i)).bagCount(j)*insideBags(bag,bag(vals(i)).contained(j),strs);
        end
    end
    
end
counter = count;
end