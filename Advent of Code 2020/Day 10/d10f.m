function [checker,pathCount] = d10f()
vals = readInput(1);

checker = zeros(3,1)+1;
tmp = sortrows(vals);

for i = 1:length(tmp)-1
    checker(tmp(i+1)-tmp(i)) = checker(tmp(i+1)-tmp(i))+1;
end

checker = checker(1) * checker(3);

%% prep values
tmp2 = tmp;
tmp2 = sortrows([0;tmp2;max(tmp2)+3]);

%% build graph array

A = zeros(length(tmp2));
for i = 1:length(tmp2)
    for j = 1:3
        if sum(ismember(tmp2,tmp2(i)+j))
            ind = find(ismember(tmp2,tmp2(i)+j));
            A(i,ind) = 1;
        end
    end
end
G = digraph(A);

%% derive core nodes

en = G.Edges.EndNodes;
coreNode = 1;
count = 1;
for i = 1:size(en,1)
    if isequal(successors(G,en(i,1)),en(i,2)) && ...
            isequal(en(i,1),predecessors(G,en(i,2)))
        count = count + 1;
        coreNode(count) = en(i,1);
    end
end
count = count + 1;
coreNode(count) = max(en(:,2));

%% calculate path counts

for i = 1:length(coreNode)-1
    times(i) = length(AllPath(A,coreNode(i+1),coreNode(i)));
end
pathCount = prod(times);

end
