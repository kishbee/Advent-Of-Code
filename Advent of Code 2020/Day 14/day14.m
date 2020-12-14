function [val1,val2] = d14f()

vals = readInput(5);
vals = vals.Var1;

%%
count = 0;
for i = 1:length(vals)
    if strcmp(vals(i),"mask")
        count = count + 1;
        tmp(count).base = zeros(1,2);
        cb = 1;
        tmp(count).mask = (vals(i+2));
    elseif strcmp(vals(i),"=")
        cb = cb;
    elseif strlength(vals(i))>3
        if strcmp(extractBetween(vals(i),1,3),"mem")
            tmp(count).base(cb,:) = [str2double(extractBetween(vals(i),5,strlength(vals(i))-1)),str2double(vals(i+2))];
            cb = cb + 1;
        end
    end
end


%% part 1

storage = [0];
storeVal = [0];
count = 1;
for i = 1:length(tmp)
    masker = convertStringsToChars(tmp(i).mask);
    for j = 1:size(tmp(i).base,1)
        if isempty(find(storage == tmp(i).base(j,1)))
            count = count + 1;
            storage(count) = tmp(i).base(j,1);
            storeVal(count) = unmask(masker,tmp(i).base(j,2));
        else
            ind = find(storage == tmp(i).base(j,1));
            storeVal(ind) = unmask(masker,tmp(i).base(j,2));
        end
    end
end

val1 = sum(storeVal);
%% part 2

storeVal = [];
memVal = strings(0,1);
count = 1;
for i = 1:length(tmp)
    masker = convertStringsToChars(tmp(i).mask);
    for j = 1:size(tmp(i).base,1)
        count = count + 1;
        storeVal(count) = tmp(i).base(j,2);
        memVal(count) = convertCharsToStrings(unmask2(masker,tmp(i).base(j,1)));
    end
end

memVal = memVal(2:end);
storeVal = storeVal(2:end);
storage = [];
fin = [];

for i = 1:length(memVal)
    [storage,fin] = permMask(storage,fin,memVal(i),storeVal(i));
end

val2 = sum(fin);
end
%%

function [slot,slotVal] = permMask(slot,slotVal,mem,val)

mem = convertStringsToChars(mem);
tmp = mem;
choices = find(mem == 'X');
for i = 0:length(choices)
    C = combnk(choices,i);
    
    if isempty(C)
        for j = 1:length(choices)
            if ismember(choices(j),C)
                tmp(choices(j)) = '1';
            else
                tmp(choices(j)) = '0';
            end
        end
        %calc%
        
        finmem = bin2dec(tmp);
        if isempty(find(slot == finmem))
            slot(length(slot)+1) = finmem;
            slotVal(length(slotVal)+1) = val;
        else
            ind = find(slot == finmem);
            slotVal(ind) = val;
        end
        
    else
        for k = 1:size(C,1)
            for j = 1:length(choices)
                if ismember(choices(j),C(k,:))
                    tmp(choices(j)) = '1';
                else
                    tmp(choices(j)) = '0';
                end
            end
            %calc%
            
            finmem = bin2dec(tmp);
            if isempty(find(slot == finmem))
                slot(length(slot)+1) = finmem;
                slotVal(length(slotVal)+1) = val;
            else
                ind = find(slot == finmem);
                slotVal(ind) = val;
            end
            
        end
    end
    
end

end


%%
function newdec = unmask(mask,num)

val = dec2bin(num,length(mask));
for i = 1:length(mask)
    if mask(i) ~= 'X'
        val(i) = mask(i);
    end
end

newdec = bin2dec(val);

end


function charlist = unmask2(mask,num)

val = dec2bin(num,length(mask));
for i = 1:length(mask)
    if mask(i) ~= '0'
        val(i) = mask(i);
    end
end

charlist = val;

end
