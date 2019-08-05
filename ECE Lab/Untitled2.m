load Vgs.txt
load expID.txt
load thrID.txt
plot(Vgs,expID,'x')
hold on
plot(Vgs,thrID)
xlabel('Vgs (V)')
ylabel('ID (mA)')
title('Gate Source Voltage vs. Drain Current')