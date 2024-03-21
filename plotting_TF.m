%% P = 0.0%

stairs_signal = TF_p0_0.signals(1).values
ramp = TF_p0_0.signals(2).values

figure;
hold on;
plot(ramp);
plot(stairs_signal);
grid on;

%% P = 0.1%

stairs_signal = TF_p0_1.signals(1).values
ramp = TF_p0_1.signals(2).values

figure;
hold on;
plot(ramp);
plot(stairs_signal);
grid on;

%% P = 1.0%

stairs_signal = TF_p1_0.signals(1).values
ramp = TF_p1_0.signals(2).values

figure;
hold on;
plot(ramp);
plot(stairs_signal);
grid on;