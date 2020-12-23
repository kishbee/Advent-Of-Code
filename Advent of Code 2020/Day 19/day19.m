clear
tmp = readInput(4);

rules = tmp(1);
rules = strsplit(rules," ");
startInd = contains(rules,":");
startInd = find(startInd);

for i = 1:length(startInd)-1
    fullRules(i) = strjoin(rules(startInd(i):startInd(i+1)-1)," ");
end
fullRules(length(startInd)) = strjoin(rules(startInd(end):end)," ");

input = strsplit(tmp(2)," ");
fullRules = fullRules';
input = input';
clearvars tmp startInd i rules

for i = 1:length(fullRules)
    tmp = strsplit(fullRules(i),":");
    tmp = tmp(1);
    ruleInd(i) = str2double(tmp);
end
ruleInd = ruleInd';
[~, idx] = sortrows(ruleInd);
fullRules = fullRules(idx);
clearvars tmp ruleInd i idx

for i = 1:length(fullRules)
    tmp = strsplit(fullRules(i)," ");
    if isnan(str2double(tmp(2)))
        tmp(2) = extractBetween(tmp(2),2,2);
        fullRules(i) = strjoin(tmp);
    end
end
rule0 = strsplit(fullRules(1),": ");
rule0 = rule0(2);
fr = fullRules(2:end); 
clearvars i tmp fullRules

% ruleParse

count = 0;
allRules = strings(0,2);
ruleInd = [];
for i = 1:length(fr)
    tmp = strsplit(fr(i),":");
    tmpri = str2double(tmp(1));
    tmp = strsplit(tmp(2),"|");
    for i = 1:length(tmp)
        count = count + 1;
        ruleInd(count) = tmpri;
        tmp2 = strsplit(tmp(i)," ");
        tmp2 = tmp2(~strcmp(tmp2,""));
        if length(tmp2) == 1
            allRules(count,:) = [tmp2,""];
        else
            allRules(count,:) = tmp2;
        end
    end
    
end
ruleInd = ruleInd';
clearvars tmp tmpri count ans i  tmp2

ris = ruleIsNum(allRules);
ruleAnchor = catalogRules(ruleInd,ris);

%% rule processing
while ~isequal(ruleAnchor,1:max(ruleInd)) || ~isequal(ris(:,2),-1*ones(size(ris,1),1))
for ii = 1:numel(allRules)
    for jj = 1:length(ruleAnchor)
        if str2double(allRules(ii)) == ruleAnchor(jj)
            allRules(ii) = strjoin(allRules(find(ruleInd == ruleAnchor(jj)),1),"|");
        end
    end
end
[allRules,ris] = ruleMerge(allRules);
ruleAnchor = catalogRules(ruleInd,ris);
end

allRules = ruleScrunch(allRules,ruleInd);
ruleInd = ruleAnchor';

%% rule 0 map
rule0 = strsplit(rule0," ");
r0map = rule0;
sai = str2double(rule0(1));
r0map(1) = allRules(sai);
for ii = 2:length(rule0)
    sbi = str2double(rule0(ii));
    sideA = strsplit(r0map(ii-1),"|");
    sideB = strsplit(allRules(sbi),"|");
    r0map(ii) = sideAandB(sideA,sideB);
end
finalRule0 = r0map(end);
%% 
tfTable = inputCheck(input,finalRule0);

sum(tfTable)

%% functions
function tfTable = inputCheck(input,rule)

tfTable = false(length(input),1);
rule = strsplit(rule,"|");
for ii = 1:length(input)
        if sum(strcmp(input(ii),rule))
            tfTable(ii) = true;
        end
end

end
%%
function allRules = ruleScrunch(allRules,ruleInd)

frs = strings(max(ruleInd),1);
for ii = 1:max(ruleInd)
    tmp = allRules(find(ruleInd == ii),1);
        frs(ii) = strjoin(tmp,"|");
end

allRules = frs;

end

%%
function [allRules,ris] = ruleMerge(allRules)

ris = ruleIsNum(allRules);
for ii = 1:size(allRules)
    if isequal(ris(ii,:),[0,0])
        sideA = strsplit(allRules(ii,1),"|");
        sideB = strsplit(allRules(ii,2),"|");
        allRules(ii,1) = sideAandB(sideA,sideB);
        allRules(ii,2) = "";
    end
end

ris = ruleIsNum(allRules);

end

%% 
function combStr = sideAandB(sideA,sideB)

sideC = strings(0,1);
count = 0;
for ii = 1:length(sideA)
    for jj = 1:length(sideB)
        count = count + 1;
        sideC(count) = sideA(ii) + sideB(jj);
    end
end
combStr = strjoin(sideC,"|");

end

%%
function ruleAnchor = catalogRules(ruleInd,ris)

ruleAnchor = [];
for i = 1:max(ruleInd)
    tmp = ris(find(ruleInd == (i)),:);
    check = true;
    for j = 1:size(tmp,1)
        if ~isequal(tmp(j,:),[0,-1])
            check = false;
        end
    end
    if check
        ruleAnchor(end+1) = i;
    end
end

end

%% isnum check

function ris = ruleIsNum(strs)

    for i = 1:size(strs,1)
        for j = 1:size(strs,2)
            if strcmp(strs(i,j),"")
                ris(i,j) = -1;
            elseif isnan(str2double(strs(i,j)))
                ris(i,j) = 0;
            else
                ris(i,j) = 1;
            end
        end
    end

end
