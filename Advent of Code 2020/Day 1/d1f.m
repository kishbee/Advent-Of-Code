function vals = d1f(A,count)

if count == 2
    
    for i = 1:length(A)
        for j = i:length(A)
            if A(i) + A(j) == 2020
                vals = A(i) * A(j);
            end
        end
    end
    
    
elseif count == 3
    
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
    
end