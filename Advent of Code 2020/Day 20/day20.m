clear
tmp = readInput(4);
for ii = 1:length(tmp)
    tmp2 = strsplit(tmp(ii)," ");
    tmp3 = strsplit(tmp2(2),":");
    tmp3 = tmp3(1);
    puzzle(ii).num = str2double(tmp3);
    for jj = 1:10
        puzzle(ii).tile(jj,:) = convertStringsToChars(tmp2(jj+2));
    end
    puzzle(ii).sideL = puzzle(ii).tile(:,1);
    puzzle(ii).sideR = puzzle(ii).tile(:,10);
    puzzle(ii).sideU = puzzle(ii).tile(1,:);
    puzzle(ii).sideD = puzzle(ii).tile(10,:);
end
clearvars tmp tmp2 tmp3 ans ii jj

counters = zeros(length(puzzle),1);
for ii = 1:length(puzzle)
    counters(ii) = sum(checkSides(ii,puzzle));
    if counters(ii) == 2
        puzzle(ii).num
    end
end

%%
function [count,neighbors] = checkSides(idx,puzzle)

count = [0 0 0 0];
neighbors = [];
side = strings(8,1);
key = strings(4,1);
key(1) = convertCharsToStrings(puzzle(idx).sideL);
key(2) = convertCharsToStrings((puzzle(idx).sideR));
key(3) = convertCharsToStrings(puzzle(idx).sideU);
key(4) = convertCharsToStrings((puzzle(idx).sideD));

for ii = 1:length(puzzle)
    if ii ~= idx
        side(1) = convertCharsToStrings(puzzle(ii).sideL);
        side(2) = convertCharsToStrings(flip(puzzle(ii).sideL));
        side(3) = convertCharsToStrings(puzzle(ii).sideR);
        side(4) = convertCharsToStrings(flip(puzzle(ii).sideR));
        side(5) = convertCharsToStrings(puzzle(ii).sideU);
        side(6) = convertCharsToStrings(flip(puzzle(ii).sideU));
        side(7) = convertCharsToStrings(puzzle(ii).sideD);
        side(8) = convertCharsToStrings(flip(puzzle(ii).sideD));
        for jj = 1:4
            count(jj) = count(jj) + sum(strcmp(key(jj),side));
        end
    end
end

end