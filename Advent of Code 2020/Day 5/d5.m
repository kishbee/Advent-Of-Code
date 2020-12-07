
%%
tmp = readInput(3);

maxID = 0;
for i = 1:length(tmp)
    val = convertStringsToChars(tmp(i));
    row = 0:127;
    for j = 1:7
        if val(j) == 'B'
            row = row((length(row)/2)+1:end);
        else
            row = row(1:length(row)/2);
        end
    end
    col = 0:7;
    for j = 8:10
        if val(j) == 'R'
            col = col((length(col)/2)+1:end);
        else
            col = col(1:length(col)/2);
        end
    end
    id = row*8 + col;
    id2(i) = id;
    if maxID < id
        maxID = id;
    end
end


%%