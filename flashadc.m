clc
clear all

vin=0.65;                    %%Input voltage to ADC

% Github Notes:
% LSB = Vref / 2^NBit   ==> but again, Vref is set to 1 with no mention
% really in this code there should be a variable called Vref, ya-hear!

Nbit=4 ;                     %%Number of bits
LSB=1/2^Nbit;               %%LSB size (considers Vp=1 and Vn=0)
rladder=[1:1:2^Nbit-1]*LSB; %%%Reference voltage generation.\
vout=ones(1,2^Nbit-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%  Mismatch  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p=0.1/100;                    %%percentage of mismatch
randn('seed', 31233);       %% Uses a fixed seed for the PRNG
mismatch=randn(1,2^Nbit-1)*p; %%Random variable to be added to rladder

rladder

rladder=rladder.*(1+mismatch);%%Mismatch added to rladder.

rladder
%%%%%%%%%%%%%%%%%%%%%%%%%%%  Mismatch  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:1:2^Nbit-1          %%2^Nbit -1 comparators 
    if vin<rladder(i)       %%Vin Compared agains the different voltages
                            %%In the rladder
        vout(i)=0;          %%Output is 0 if the vin is < a given rladder
    else 
        vout(i)=1;          %%Output is 1 if vin is larger.
    end
end

y = sum(vout);
