function [val1,val2] = d13f()
vals = readInput(4);
C = strsplit(vals,[" ",","]);

for i = 2:length(C)
    num(i) = str2double(C(i));
    offset(i) = i-1;
end

offset = offset(~isnan(num));
num = num(~isnan(num));

minval = str2double(C(1));

offset = offset(2:end);
num = num(2:end);
newnum = zeros(length(num),1);
for i = 1:length(num)
    a = 1;
    while newnum(i) < minval
        a = a+1;
        newnum(i) = num(i) * a;
    end
end

[~,ind] = min(newnum);
val1 = num(ind) * (newnum(ind)-minval);

val2 = crt(num,offset)+2;