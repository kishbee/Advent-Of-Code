eqs = readInput(3);

%%
val = 0;
for i = 1:length(eqs)
str = eqs(i);
while findParens(str)
    [~,ploc] = findParens(str);
    str = evalInParensV2(str,ploc);
end
val = val + evalInGeneralV2(str);
end



%%
%%
function str = evalInParensV2(str,ploc)

    tmp = extractBetween(str,ploc(1)+1,ploc(2)-1);
    tmp = strsplit(tmp,"*");
    vals = zeros(length(tmp),1);
    for i = 1:length(tmp)
        vals(i) = eval(tmp(i));
    end
    val = num2str(prod(vals));
    tmp = extractBetween(str,ploc(1),ploc(2));
    str = strrep(str,tmp,num2str(val));
end

%%
function val = evalInGeneralV2(str)

    tmp = strsplit(str,"*");
    vals = zeros(length(tmp),1);
    for i = 1:length(tmp)
        vals(i) = eval(tmp(i));
    end
    val = (prod(vals));
end

%%
function val = evalInGeneral(str)

    tmp = strsplit(str," ");
    idx = 1:2:length(tmp)-2;
    for i = idx
        tmp(i+2) = num2str(eval(strjoin(tmp(i:i+2))));
    end
    
    val = str2double(tmp(end));
end

%%
function str = evalInParens(str,ploc)

    tmp = extractBetween(str,ploc(1)+1,ploc(2)-1);
    tmp = strsplit(tmp," ");
    if length(tmp) > 3
    idx = 1:2:length(tmp)-2;
    else
        idx = 1;
    end
    for i = idx
        tmp(i+2) = num2str(eval(strjoin(tmp(i:i+2))));
    end
    
    val = str2double(tmp(end));
        tmp = extractBetween(str,ploc(1),ploc(2));
    str = strrep(str,tmp,num2str(val));
end

%%
function [tf,ploc] = findParens(str)

openLoc = strfind(str,"(");
closeLoc = strfind(str,")");

if isempty(openLoc)
    tf = false;
else
    tf = true;
    val = 1000;
    for i = 1:length(openLoc)
        for j = 1:length(closeLoc)
            if abs(openLoc(i)-closeLoc(j)) < val && closeLoc(j) > openLoc(i)
                val = abs(openLoc(i)-closeLoc(j));
                ploc = [openLoc(i),closeLoc(j)];
            end
        end
    end
end

end