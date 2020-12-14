function [val1,val2] = d11f()
vals = readInput(3);

for i = 1:length(vals)
    val2(i,:) = convertStringsToChars(vals(i));
end

%%
tmp = ['L.LL.LL.LL'
    'LLLLLLL.LL'
    'L.L.L..L..'
    'LLLL.LL.LL'
    'L.LL.LL.LL'
    'L.LLLLL.LL'
    '..L.L.....'
    'LLLLLLLLLL'
    'L.LLLLLL.L'
    'L.LLLLL.LL'];




%%

valNew = checkerSeat(val2);

count = 0;
for i = 1:size(valNew,1)
    for j = 1:size(valNew,2)
        if valNew(i,j) == '#'
            count = count + 1;
        end
    end
end

val1 = count;

%%
valNew = checkerSeatV2(val2);

count = 0;
for i = 1:size(valNew,1)
    for j = 1:size(valNew,2)
        if valNew(i,j) == '#'
            count = count + 1;
        end
    end
end

%%
function vals3 = checkerSeat(vals)
vals2 = vals;
for i = 1:size(vals,1)
    for j = 1:size(vals,2)
        if vals(i,j) ~= '.'
            co = 0;
            col = [j-1 j j+1];
            row = [i-1 i i+1];
            col = col(col > 0  & col < size(vals,2) + 1);
            row = row(row > 0  & row < size(vals,1) + 1);
            
            for k = 1:length(col)
                for l = 1:length(row)
                    if vals(row(l),col(k)) == '#' && ~isequal([row(l),col(k)],[i,j])
                        co = co + 1;
                    end
                end
            end
            
            if co == 0 && vals(i,j) == 'L'
                vals2(i,j) = '#';
            elseif co >= 4 && vals(i,j) == '#'
                vals2(i,j) = 'L';
            end
        end
    end
end

if isequal(vals2,vals)
    vals3 = vals2;
else
    vals3 = checkerSeat(vals2);
end

end

val2 = count;
end
%%
function vals3 = checkerSeatV2(vals)
vals2 = vals;
for i = 1:size(vals,1)
    for j = 1:size(vals,2)
        if vals(i,j) ~= '.'
            co = counterCheck(vals,i,j);
            
            if co == 0 && vals(i,j) == 'L'
                vals2(i,j) = '#';
            elseif co >= 5 && vals(i,j) == '#'
                vals2(i,j) = 'L';
            end
        end
    end
end

if isequal(vals2,vals)
    vals3 = vals2;
else
    vals3 = checkerSeatV2(vals2);
end

end
