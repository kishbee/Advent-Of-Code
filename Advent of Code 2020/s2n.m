function numArray = s2n(stringArray)

for i = 1:length(stringArray)
    tmp(i) = str2num(stringArray(i));
end
numArray = tmp';