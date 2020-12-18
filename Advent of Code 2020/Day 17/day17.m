clear
grid = convertStringsToChars(readInput(4));
num = 8;
for i = 1:num
    grid2(i,:) = grid((i-1)*(num+1)+1:(num+1)*i);
end

grid2 = grid2(1:num,1:num);

grid2 = (grid2 - 46)/-11;
grid = grid2;

fullCube = zeros(30,30,30,30);

fullCube(12:12+size(grid,1)-1,12:12+size(grid,1)-1,15,15) = grid;


%%
cycleCount = 0;

for cycle = 1:6
fc2 = zeros(30,30,30,30);

for i = 1:size(fc2,1)
    for j = 1:size(fc2,2)
        for k = 1:size(fc2,3)
            for l = 1:size(fc2,4)
            fc2(i,j,k,l) = cubeCheck4d(fullCube,i,j,k,l);
            end
        end
    end
end

fullCube = fc2;
cycleCount = cycleCount + 1;
end

%%
sum(sum(sum(sum((fullCube)))))

function val = cubeCheck(fullCube,x,y,z)

xr = [x-1,x,x+1]; xr = xr(xr >= 1 & xr <= 30);
yr = [y-1,y,y+1]; yr = yr(yr >= 1 & yr <= 30);
zr = [z-1,z,z+1]; zr = zr(zr >= 1 & zr <= 30);

count = 0;
for i = xr
    for j = yr
        for k = zr
            if i ~= x || j ~= y || k ~= z
            if fullCube(i,j,k) == 1
                count = count + 1;
            end
            end
        end
    end
end

val = 0;

if fullCube(x,y,z) == 1 && (count == 2 || count == 3)
    val = 1;
elseif fullCube(x,y,z) == 0 && count == 3
    val = 1;
end

end

function val = cubeCheck4d(fullCube,x,y,z,w)

xr = [x-1,x,x+1]; xr = xr(xr >= 1 & xr <= 30);
yr = [y-1,y,y+1]; yr = yr(yr >= 1 & yr <= 30);
zr = [z-1,z,z+1]; zr = zr(zr >= 1 & zr <= 30);
wr = [w-1,w,w+1]; wr = wr(wr >= 1 & wr <= 30);

count = 0;
for i = xr
    for j = yr
        for k = zr
            for l = wr
            if i ~= x || j ~= y || k ~= z || l ~= w
            if fullCube(i,j,k,l) == 1
                count = count + 1;
            end
            end
            end
        end
    end
end

val = 0;

if fullCube(x,y,z,w) == 1 && (count == 2 || count == 3)
    val = 1;
elseif fullCube(x,y,z,w) == 0 && count == 3
    val = 1;
end

end