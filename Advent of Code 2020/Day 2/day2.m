%% day 2 load
tbl = readInput(2);
for i = 1:size(tbl,2)
    tbl.(i) = convertCharsToStrings(tbl.(i));
end

%% day 2 process
tbl.(2) = extractBetween(tbl.(2),1,1); %key
strs = tbl.(1);
for i = 1:length(strs)
    dash(i) = strfind(strs(i),"-");
    st(i) = str2double(extractBetween(strs(i),1,dash(i)-1));
    et(i) = str2double(extractBetween(strs(i),dash(i)+1,strlength(strs(i));
end
tbl = [tbl st et];
%%
count = 0;
count2 = 0;
for i = 1:length(strs)
    dash(i) = strfind(strs(i),"-");
    colon(i) = strfind(strs(i),":");
    key(i) = extractBetween(strs(i),colon(i)-1,colon(i)-1);
    main(i) = extractBetween(strs(i),colon(i)+2,strlength(strs(i)));
    st(i) = str2double(extractBetween(strs(i),1,dash(i)-1));
    et(i) = str2double(extractBetween(strs(i),dash(i)+1,colon(i)-2));
    lister = strfind(main(i),key(i));
    if length(strfind(main(i),key(i))) >= st(i) && length(strfind(main(i),key(i))) <= et(i)
        count = count + 1;
    end
    if xor(sum(lister == st(i)),sum(lister == et(i)))
        count2 = count2 + 1;
    end
    
    test(i) = strcat(string(st(i)),"-",string(et(i))," ",key(i),":",main(i));
end
    
count

tbl = table(st',et',key',main');
for i = 1:length(strs)
    check(i) = strcmp(strs(i),test(i));
end
check = check';

