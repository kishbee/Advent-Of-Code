function co = counterCheck(vals,i,j)

a = 1;
coors = [i-a,j;... %col up
    i+a,j; %col down
    i,j-a;... % row left
    i,j+a;...% row right
    i-a,j-a;... % diag up left
    i+a,j-a;... %diag down left
    i-a,j+a;... %diag up right
    i+a,j+a]; % diag down right

truthCheck = false(8,1);

init = ['.';'.';'.';'.';'.';'.';'.';'.'];

coorsCheck = (coors > 0);
coorsCheck(:,1) = (coors(:,1) > 0) & (coors(:,1) <= size(vals,1));
    coorsCheck(:,2) = (coors(:,2) > 0) & (coors(:,2) <= size(vals,2));
full = and(coorsCheck(:,1),coorsCheck(:,2));

while ~isequal(full,truthCheck) && sum(init == '.') > 0
    
    for k = 1:8
        if coorsCheck(k,1) && coorsCheck(k,2)
            if init(k) == '.'
                init(k) = vals(coors(k,1),coors(k,2));
            end
        end
    end
    a = a+1;
    coors = [i-a,j;... %col up
    i+a,j; %col down
    i,j-a;... % row left
    i,j+a;...% row right
    i-a,j-a;... % diag up left
    i+a,j-a;... %diag down left
    i-a,j+a;... %diag up right
    i+a,j+a];
    coorsCheck(:,1) = (coors(:,1) > 0) & (coors(:,1) <= size(vals,1));
    coorsCheck(:,2) = (coors(:,2) > 0) & (coors(:,2) <= size(vals,2));
    full = and(coorsCheck(:,1),coorsCheck(:,2));
end

co = sum(init == '#');
    
end