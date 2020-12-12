function [val1,val2] = d12f()
vals = readInput(3);

east = 0;
north = 0;
angle = 0;
for i = 1:length(vals)
    command = extractBetween(vals(i),1,1);
    dist = str2double(extractBetween(vals(i),2,strlength(vals(i))));
    
    if strcmp(command,"R")
        angle = angle + dist;
    elseif strcmp(command,"L")
        angle = angle - dist;
    end
    angle = mod(angle,360);
    
    if strcmp(command,"N")
            north = north + dist;
        elseif strcmp(command,"S")
            north = north - dist;
        elseif strcmp(command,"E") 
            east = east + dist;
        elseif strcmp(command,"W")
            east = east - dist;
    end
        
    if strcmp(command,"F")
        if angle == 0
            east = east + dist;
        elseif angle == 90
            north = north - dist;
        elseif angle == 180
            east = east - dist;
        else
            north = north + dist;
        end
    end
end

val1 = abs(east) + abs(north);

east = 0;
north = 0;
angle = 0;
waypoint = [1,10];
for i = 1:length(vals)
    command = extractBetween(vals(i),1,1);
    dist = str2double(extractBetween(vals(i),2,strlength(vals(i))));
    
    if strcmp(command,"R")
        angle = angle + dist;
    elseif strcmp(command,"L")
        angle = angle - dist;
    end
    angle = mod(angle,360);
    if angle == 90
        waypoint = [-waypoint(2),waypoint(1)];
    elseif angle == 180
        waypoint = [-waypoint(1),-waypoint(2)];
    elseif angle == 270
        waypoint = [waypoint(2),-waypoint(1)];
    end
    angle = 0;
    
    if strcmp(command,"F")
        north = north + dist * waypoint(1);
        east = east + dist * waypoint(2);
    end
    
    if strcmp(command,"N")
            waypoint(1) = waypoint(1) + dist;
        elseif strcmp(command,"S")
            waypoint(1) = waypoint(1) - dist;
        elseif strcmp(command,"E") 
            waypoint(2) = waypoint(2) + dist;
        elseif strcmp(command,"W")
            waypoint(2) = waypoint(2) - dist;
    end
        
    
end

val2 = abs(east) + abs(north);