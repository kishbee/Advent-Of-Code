function vals = d1f(count)
A = readInput(1); % load Input (numberical array)
if count == 2 % Use count == 2 if want sum of 2 numbers     
    for i = 1:length(A)
        for j = i:length(A)
            if A(i) + A(j) == 2020
                vals = A(i) * A(j);
            end
        end
    end
elseif count == 3 % Use count == 3 if want sum of 3 numbers 
    
    for i = 1:length(A)
        for j = i:length(A)
            for k = j:length(A)
                if A(i) + A(j) + A(k) == 2020
                    vals = A(i) * A(j) * A(k);
                end
            end
        end
    end
    
end

% vals = product of numbers.
    
end