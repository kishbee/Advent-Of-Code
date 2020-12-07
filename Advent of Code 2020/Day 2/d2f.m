function [count1,count2,newTbl] = d2f(tbl)

for i = 1:size(tbl,2)
    tbl.(i) = convertCharsToStrings(tbl.(i));
end

key = extractBetween(tbl.(2),1,1);
for i = 1:size(tbl,1)
st(i) = str2double(extractBetween(tbl.(1)(i),1,strfind(tbl.(1)(i),"-")-1));
et(i) = str2double(extractBetween(tbl.(1)(i),strfind(tbl.(1)(i),"-")+1,strlength(tbl.(1)(i))));
end
st = st';
et = et';
main = tbl.(3);

%% calc
ruleCount = zeros(length(main),1);
ruleIndex = zeros(length(main),1);
for i = 1:length(main)
    vals = strfind(main(i),key(i));
        if length(vals) >= st(i) && length(vals) <= et(i)
            ruleCount(i) = 1;
        end
        if xor(sum(vals == st(i)),sum(vals == et(i)))
            ruleIndex(i) = 1;        
        end
end

count1 = sum(ruleCount);
count2 = sum(ruleIndex);

%% tbl maker
newTbl = table(st,et,key,main,ruleCount,ruleIndex);
newTbl.Properties.VariableNames = cellstr(["st","et","key","main","rcount","rind"]);

end