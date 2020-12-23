input = readInput(4);

for i = 1:2
    tmp = strsplit(input(i),":");
    tmp = strsplit(tmp(2)," ");
    tmp = str2double(tmp(2:end-1));
    player(i).deck = tmp';
end

clearvars -except player

%%
while ~isempty(player(1).deck) && ~isempty(player(2).deck)
    player = duel(player);
    disp(strcat(string(length(player(1).deck)),"/",string(length(player(2).deck))))
end


%%
sum(player(1).deck.*[length(player(1).deck):-1:1]')

%%
function player = duel(player)

if player(1).deck(1) > player(2).deck(1)
    player(1).deck(end+1) = player(1).deck(1);
    player(1).deck(end+1) = player(2).deck(1);
    player(2).deck = player(2).deck(2:end);
    player(1).deck = player(1).deck(2:end);
else
    player(2).deck(end+1) = player(2).deck(1);
    player(2).deck(end+1) = player(1).deck(1);
    player(2).deck = player(2).deck(2:end);
    player(1).deck = player(1).deck(2:end);
end

end

