%% day 1 load
fileID = fopen('input.txt','r');
formatSpec = '%f';
A = fscanf(fileID,formatSpec);

%% part 1

for i = 1:length(A)
    for j = i:length(A)
        if A(i) + A(j) == 2020
            A(i) * A(j)
        end
    end
end

%% part 2
for i = 1:length(A)
    for j = i:length(A)
        for k = j:length(A)
            if A(i) + A(j) + A(k) == 2020
                A(i) * A(j) * A(k)
            end
        end
    end
end