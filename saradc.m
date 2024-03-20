%%%%SAR ADC Model%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Coder: Gerardo Salgado%%%%%%%%%%%%%%%%%%%%
%%%%Microelectronic Circuits Centre Ireland%%%

close all 
clear all

vin=0.8;                    %%%Input voltage
Nbit=4;                     %%%Number of bits 

Vcdac = 1./2.^[1:1:Nbit];   %%Voltage vector from CDAC.

vx = -vin;                  %%%Models bottom plate sampling

for i=1:1:Nbit

    vx=vx+Vcdac(i);         %%%Bit Trial
    
        if vx > 0;          %%%Comparator Model  
            sar(i)=0;       %%%SAR resolution
                vx=vx-Vcdac(i); %%%Bit trial goes low
        else
            sar(i)=1;       %%%SAR resolution
                vx=vx;      %%%Bit trial remains high
    end
end

weights=2.^[0:1:Nbit-1];
weights=fliplr(weights); % binary num position weights
sum(sar.*weights)