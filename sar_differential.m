close all
clear all

vin_p=0.8;
vin_n=1 - vin_p;

Nbit=10;                    %%%Number of bits 

Vcdac = 1./2.^[1:1:Nbit];   %%Voltage vector from CDAC.
 
sar=ones(1,Nbit);           %%%Formal initialization of variable

%p=0.0/100;                      %%percentage of mismatch
%randn('seed', 31233);           %% Uses a fixed seed for the PRNG
%mismatch=randn(1,2^Nbit-1)*p;   %%Random variable to be added to rladder
%rladder=rladder.*(1+mismatch);  %%Mismatch added to rladder.


test_voltage = 0;

for i=1:1:Nbit
    i

    if vin_p - vin_n > test_voltage
        sar(i) = 1;
        test_voltage = test_voltage + Vcdac(i);
    else
        sar(i) = 0;
        test_voltage = test_voltage - Vcdac(i);
    end

end

weights=2.^[0:1:Nbit-1];
weights=fliplr(weights);
y=sum(sar.*weights)