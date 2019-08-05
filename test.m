function[decimal] = ChromoBinConverter(binary,len)

isNum = false;
isOpr = false;

for i = 1:2:len
    analyzing = strBin(i:i+1);
        if analyzing == 00
            num = 0;
            isNum = true;
            ChromoBinConverter(binary(i+2:len),length(binary(i+2)))
        elseif analyzing == 01
            num = 1;
            isNum = true;
        elseif analyzing == 1011 % +
            opr = 1;
            isOpr = true;
        elseif analyzing == 1100 % -
            opr = 2;
            isOpr = true;
        end
end
end