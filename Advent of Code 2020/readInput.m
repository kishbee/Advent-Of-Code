function stringData = readInput(type)

if type == 1 % all doubles
    stringData = load("input.txt");
elseif type == 2 % 1 row string = 1 case => tbl with delim " "
    stringData = readtable("input.txt","ReadVariableNames",false);
elseif type == 3 % 1 row string, no delim
    tbl = readtable("input.txt","ReadVariableNames",false);
    stringData = convertCharsToStrings(tbl.(1));
elseif type == 4 % multilines = 1 case, merge
    count = 0;
    fileName = 'input.txt';
    FID = fopen(fileName);
    tline = fgetl(FID);
    while ischar(tline)
        count = count + 1;
        tmp(count).str = strcat((tline)," ");
        tline = (fgetl(FID));
    end
    
    count = 1;
    tmpstr = "";
    for i = 1:length(tmp)
        if ~strcmp(tmp(i).str," ")
            tmpstr(count) = strcat(tmpstr(count),tmp(i).str);
        else
            count = count + 1;
            tmpstr(count) = "";
        end
    end
    stringData = tmpstr';
elseif type == 5 %multiline make into tbl
    count = 0;
    fileName = 'input.txt';
    FID = fopen(fileName);
    tline = fgetl(FID);
    while ischar(tline)
        count = count + 1;
        tmp(count).str = strcat((tline)," ");
        tline = (fgetl(FID));
    end
    
    count = 1;
    tmpstr = "";
    for i = 1:length(tmp)
        if ~strcmp(tmp(i).str," ")
            tmpstr(count) = strcat(tmpstr(count),tmp(i).str);
        else
            count = count + 1;
            tmpstr(count) = "";
        end
    end
    for i = 1:length(tmpstr)
        vals(i).parser = strsplit(tmpstr(i)," ");
        vals(i).parser = vals(i).parser(1:end-1);
    end
    stringData = struct2table(vals');
    stringData.Properties.VariableNames = cellstr(["Var1"]);
end

end

