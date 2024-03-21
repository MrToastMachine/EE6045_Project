%%%%SAR ADC Model%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Coder: Gerardo Salgado%%%%%%%%%%%%%%%%%%%%
%%%%Microelectronic Circuits Centre Ireland%%%

close all 
clear all

vin=0.8;                    %%%Input voltage
Nbit=4;                     %%%Number of bits 

Vcdac = 1./2.^[1:1:Nbit];   %%Voltage vector from CDAC.

vx = -vin;                  %%%Models bottom plate sampling

sar=ones(1,Nbit);           %%%Formal initialization of variable

weights=2.^[0:1:Nbit-1];
weights=fliplr(weights); % binary num position weights

% PART (i) Capacitor mismatch
p = 0.1/100;
% randn('seed', 31233);
randn('seed', 31232);
mismatch = randn(1,Nbit)*p

Vcdac = Vcdac.*(1+mismatch);

comp_p = 0.0/100;
comparator_mismatch = randn(1,Nbit)*comp_p


for i=1:1:Nbit

    vx=vx+Vcdac(i);         %%%Bit Trial
    
        if vx > comparator_mismatch(i);          %%%Comparator Model  
            sar(i)=0;       %%%SAR resolution
                vx=vx-Vcdac(i); %%%Bit trial goes low
        else
            sar(i)=1;       %%%SAR resolution
                vx=vx;      %%%Bit trial remains high
    end
end

sum(sar.*weights)