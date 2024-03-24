%%%%%%%%%%%%%           Lab2                 %%%%%%%%%%%%%
clc
clear all
close all

ampl  = 0.45;    %%% Amplitude for the sine wave
offset = 0.5;    %%% Offset for the sine wave
fi     = 1e6;    %%% Frequency for the sine wave  
fs     = 100e6;  %%% Sampling Frequency    100e6
Ts     = 1/fs;   %%% Sampling period for the sampling clock.


alpha  = 10;     %%% Number of hits per code
Nbit   = 10;     %%% Number of bits in the ADC in simulink

% Change this for ramp vs sine input

% INL/DNL + Transfer func
% N      = 1024 * alpha;   %1024*alpha   %%% Number of simulation points

% Spectrum + SNR/ENOB
N       = 4096;


OSR    = 1;      %%% OverSampling Ratio, 1 > for Sigma-Delta and NS-SARs.   


coherent=1;         %%% 1=coherent sampling, 0=non coherent sampling

if coherent         %%% To calculate m prime number for fi with coherent sampling

    m=round(fi*N/fs);  %%% Calculate m 

    % Check if the input number is a prime number
    if isprime(m)
        closest_prime = m;
    end

    % Find the closest smaller prime
    smaller_prime = m - 1;
    while ~isprime(smaller_prime)
        smaller_prime = smaller_prime - 1;
    end

    % Find the closest larger prime
    larger_prime = m + 1;
    while ~isprime(larger_prime)
        larger_prime = larger_prime + 1;
    end

    % Determine which prime is closer
    if abs(m - smaller_prime) <= abs(m - larger_prime)
        closest_prime = smaller_prime;
    else
        closest_prime = larger_prime;
    end

fi=closest_prime*fs/N;
end

use_flash_model = 0; % choose which simulink model to use 

if use_flash_model
    sim('Lab2_ADC_modeling.slx')
else
    sim('Lab2_ADC_modeling_SAR.slx')
end

%%%%%%%%%%% Plot and process data to calculate SNR and ENOB  %%%%%%%%%%%%

[snr, enob] = gs_fresp(simout, N, fs, fi, OSR, 1);

[inl, dnl]=gs_inldnl(simout, Nbit , alpha);
 
