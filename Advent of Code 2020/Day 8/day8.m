
for i = 1:size(vals,1)
    counter = 1;
    counter2 = 1;
    acc = 0;
    while (vals.(3)(counter) == 0)
        if strcmp(vals.(1)(counter),"acc")
            acc = acc + vals.(2)(counter);
            vals.(3)(counter) = counter2;
            counter2 = counter2 +1;
            counter = counter + 1;
        elseif strcmp(vals.(1)(counter),"jmp")
            vals.(3)(counter) = counter2;
            counter2 = counter2 +1;
            counter = counter + vals.(2)(counter);
        else
            vals.(3)(counter) =counter2;
            counter2 = counter2 +1;
            counter = counter + 1;
        end
    end
end

%%
truvals = vals;
for i = 1:size(vals,1)
    vals = truvals;
    
    if strcmp(vals.(1)(i),"jmp")
        vals.(1)(i) = {"nop"};
    elseif strcmp(vals.(1)(i),"nop")
         vals.(1)(i) = {"jmp"};
    end
    
    counter = 1;
    counter2 = 1;
    acc = 0;
    while (vals.(3)(counter) == 0 && counter ~= 647)
        if strcmp(vals.(1)(counter),"acc")
            acc = acc + vals.(2)(counter);
            vals.(3)(counter) = counter2;
            counter2 = counter2 +1;
            counter = counter + 1;
        elseif strcmp(vals.(1)(counter),"jmp")
            vals.(3)(counter) = counter2;
            counter2 = counter2 +1;
            counter = counter + vals.(2)(counter);
        else
            vals.(3)(counter) =counter2;
            counter2 = counter2 +1;
            counter = counter + 1;
        end
    end
    if counter == 647
        acc
    end
    %disp(num2str(i))
end
%%
checker = zeros(size(vals,1),1);
vals.(3) = checker;

