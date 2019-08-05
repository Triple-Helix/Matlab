function[decimal] = ChromoBinConverter(binary)

isNum = false;
isOpr = false;
num = 0;
len = length(binary);

for i = 1:4:len
    analyzing = binary(i:i+3);
    if isNum == false && isOpr == false
        if isequal(analyzing,[0,0,0,0]) == 1
            num = 0;
            isNum = true;
        elseif isequal(analyzing,[0,0,0,1]) == 1
            num = 1;
            isNum = true;
        elseif isequal(analyzing,[0,0,1,0]) == 1
            num = 2;
            isNum = true;
        elseif isequal(analyzing,[0,0,1,1]) == 1
            num = 3;
            isNum = true;
        elseif isequal(analyzing,[0,1,0,0]) == 1
            num = 4;
            isNum = true;
        elseif isequal(analyzing,[0,1,0,1]) == 1
            num = 5;
            isNum = true;
        elseif isequal(analyzing,[0,1,1,0]) == 1
            num = 6;
            isNum = true;
        elseif isequal(analyzing,[0,1,1,1]) == 1
            num = 7;
            isNum = true;
        elseif isequal(analyzing,[1,0,0,0]) == 1
            num = 8;
            isNum = true;
        elseif isequal(analyzing,[1,0,0,1]) == 1
            num = 9;
            isNum = true;
        end
    elseif isNum == true
        if isequal(analyzing,[1,0,1,0]) == 1 % +
            opr = 1;
            isOpr = true;
            isNum = false;
        elseif isequal(analyzing,[1,0,1,1]) == 1 % -
            opr = 2;
            isOpr = true;
            isNum = false;
        elseif isequal(analyzing,[1,1,0,0]) == 1 % *
            opr = 3;
            isOpr = true;
            isNum = false;
        elseif isequal(analyzing,[1,1,0,1]) == 1 % /
            opr = 4;
            isOpr = true;
            isNum = false;
        end
    elseif isOpr == true
        if isequal(analyzing,[0,0,0,0]) == 1 && opr == 1
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,0,0]) == 1 && opr == 2
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,0,0]) == 1 && opr == 3
            num = 0;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,0,0]) == 1 && opr == 4
            num = inf;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,0,1]) == 1 && opr == 1
            num = num+1;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,0,1]) == 1 && opr == 2
            num = num-1;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,0,1]) == 1 && opr == 3
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,0,1]) == 1 && opr == 4
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,1,0]) == 1 && opr == 1
            num = num+2;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,1,0]) == 1 && opr == 2
            num = num-2;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,1,0]) == 1 && opr == 3
            num = num*2;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,1,0]) == 1 && opr == 4
            num = num/2;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,1,1]) == 1 && opr == 1
            num = num+3;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,1,1]) == 1 && opr == 2
            num = num-3;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,1,1]) == 1 && opr == 3
            num = num*3;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,0,1,1]) == 1 && opr == 4
            num = num/3;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,0,0]) == 1 && opr == 1
            num = num+4;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,0,0]) == 1 && opr == 2
            num = num-4;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,0,0]) == 1 && opr == 3
            num = num*4;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,0,0]) == 1 && opr == 4
            num = num/4;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,0,1]) == 1 && opr == 1
            num = num+5;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,0,1]) == 1 && opr == 2
            num = num-5;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,0,1]) == 1 && opr == 3
            num = num*5;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,0,1]) == 1 && opr == 4
            num = num/5;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,1,0]) == 1 && opr == 1
            num = num+6;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,1,0]) == 1 && opr == 2
            num = num-6;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,1,0]) == 1 && opr == 3
            num = num*6;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,1,0]) == 1 && opr == 4
            num = num/6;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,1,1]) == 1 && opr == 1
            num = num+7;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,1,1]) == 1 && opr == 2
            num = num-7;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,1,1]) == 1 && opr == 3
            num = num*7;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[0,1,1,1]) == 1 && opr == 4
            num = num/7;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[1,0,0,0]) == 1 && opr == 1
            num = num+8;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[1,0,0,0]) == 1 && opr == 2
            num = num-8;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[1,0,0,0]) == 1 && opr == 3
            num = num*8;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[1,0,0,0]) == 1 && opr == 4
            num = num/8;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[1,0,0,1]) == 1 && opr == 1
            num = num+9;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[1,0,0,1]) == 1 && opr == 2
            num = num-9;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[1,0,0,1]) == 1 && opr == 3
            num = num*9;
            isNum = true;
            isOpr = false;
        elseif isequal(analyzing,[1,0,0,1]) == 1 && opr == 4
            num = num/9;
            isNum = true;
            isOpr = false;
        end
    end
end

decimal = num;