function [maxID,seat] = d5f(tmp)
%% readInput 3
id = zeros(length(tmp),1);
for i = 1:length(tmp)
    val = convertStringsToChars(tmp(i));
    
    row = bin2dec(strjoin(string(double(val(1:7) == 'B'))));
    col = bin2dec(strjoin(string(double(val(8:10) == 'R'))));
    id(i) = row*8 + col;
end
maxID = max(id);
id = sortrows(id');
for i = 1:length(id) - 1
    if id(i+1) ~= id(i) + 1
        seat = id(i)+1;
    end
end

end