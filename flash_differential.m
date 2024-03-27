clc
clear all

vin_p = 0.65;
vin_n = 1 - vin_p;

% Parameters
Nbit = 4;                              % Number of bits
LSB = 1/2^Nbit;                        % LSB size (assuming Vp=1 and Vn=0)

% Generate the resistor ladders for both positive and negative inputs
rladder_p = (1:2^Nbit-1)*LSB;   % Positive reference ladder
rladder_n = fliplr(rladder_p);   % Negative reference ladder (same as positive)

% Initialize output
vout = ones(1, 2^Nbit-1);
vout_p = ones(1, 2^Nbit-1);
vout_n = ones(1, 2^Nbit-1);

% Comparator operation
for i = 1:2^Nbit-1
    % Compare positive input against positive reference ladder
    if vin_p < rladder_p(i)
        vout_p(i) = 0;
    else
        vout_p(i) = 1;
    end
    
    % Compare negative input against negative reference ladder
    if vin_n < rladder_n(i)
        vout_n(i) = 1;
    else
        vout_n(i) = 0;
    end
    
    
end

sum_p = sum(vout_p)
sum_n = sum(vout_n)
y = (sum_p + sum_n) / 2
