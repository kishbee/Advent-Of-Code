%%
for i = 1:length(tv)
    spaces = strfind(tv(i)," ");
    
    %%byr
    ind = strfind(tv(i),"byr");
    tmp = extractBetween(tv(i),ind + 4,min(spaces(spaces > ind))-1);
    tmp = str2double(tmp);
    byr(i) = tmp;
    
    %%iyr
    ind = strfind(tv(i),"iyr");
    tmp = extractBetween(tv(i),ind + 4,min(spaces(spaces > ind))-1);
    tmp = str2double(tmp);
    iyr(i) = tmp;
    
    %%eyr
    ind = strfind(tv(i),"eyr");
    tmp = extractBetween(tv(i),ind + 4,min(spaces(spaces > ind))-1);
    tmp = str2double(tmp);
    eyr(i) = tmp;
    
    %%hgt
    ind = strfind(tv(i),"hgt");
    tmp = extractBetween(tv(i),ind + 4,min(spaces(spaces > ind))-1);
    hgt(i) = tmp;
    
    %%ecl
    ind = strfind(tv(i),"ecl");
    tmp = extractBetween(tv(i),ind + 4,min(spaces(spaces > ind))-1);
    ecl(i) = tmp;
    
    %%pid
    ind = strfind(tv(i),"pid");
    tmp = extractBetween(tv(i),ind + 4,min(spaces(spaces > ind))-1);
    pid(i) = tmp;
    
    %%hcl
    ind = strfind(tv(i),"hcl");
    tmp = extractBetween(tv(i),ind + 4,min(spaces(spaces > ind))-1);
    hcl(i) = tmp;
    
    %%cid
    ind = strfind(tv(i),"cid");
    if ~isempty(ind)
        tmp = str2double(extractBetween(tv(i),ind + 4,min(spaces(spaces > ind))-1));
        cid(i) = tmp;
    else
        cid(i) = "";
    end
    
end

tbl = table(byr',iyr',eyr',hcl',ecl',cid',pid',hgt');
for i = 1:length(tbl.(8))
    units(i) = extractBetween(tbl.(8)(i),strlength(tbl.(8)(i))-1,strlength(tbl.(8)(i)));
    tbl.(8)(i) = extractBetween(tbl.(8)(i),1,strlength(tbl.(8)(i))-2);
    th(i) = str2double(tbl.(8)(i));
end
tbl.(8) = th';
tbl.(9) = units';
tbl.Properties.VariableNames = cellstr(["byr","iyr","eyr","hcl","ecl","cid","pid","hgt","hgt_units"]);
presentTbl = tbl;
%%

%ecl
tbl = tbl(ismember(tbl.(5),["amb","blu","brn","gry","grn","hzl","oth"]),:);

%strlength pid
tbl = tbl(strlength(tbl.(7)) == 9,:);

%byr
tbl = tbl((tbl.(1) >= 1920 & tbl.(1) <= 2002),:);
%iyr
tbl = tbl((tbl.(2) >= 2010 & tbl.(2) <= 2020),:);
%eyr
tbl = tbl((tbl.(3) >= 2020 & tbl.(3) <= 2030),:);

% hgt
for i = length(tbl.(8)):-1:1
    if strcmp(tbl.(9)(i),"cm")
        if ~(tbl.(8)(i) >= 150 && tbl.(8)(i) <= 193)
            tbl(i,:) = [];
        end
    elseif strcmp(tbl.(9)(i),"in")
        if ~(tbl.(8)(i) >= 59 && tbl.(8)(i) <= 76)
            tbl(i,:) = [];
        end
    else
        tbl(i,:) = [];
    end
end

% ecl
for i = length(tbl.(4)):-1:1
    tmp = convertStringsToChars(tbl.(4)(i));
    
    hclu = [48:57 65:90 97:122];
    if double(tmp(1)) ~= 35
        tbl(i,:) = [];
    elseif strlength(tmp) ~= 7
        tbl(i,:) = [];
    else
        for j = 2:7
            if ~sum(ismember(hclu,tmp(j)))
                tbl(i,:) = [];
            end
        end
    end
end
validTbl = tbl;