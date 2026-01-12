% MATLAB 信号参数修改 - 理解频率/采样率的意义
% 对比不同参数的波形变化，信号与系统核心知识点
Fs = 1000; t_total = 2; t = 0:1/Fs:t_total;

% 子图1：5Hz正弦波
subplot(2,2,1); % 2行2列，第1个子图
plot(t, sin(2*pi*5*t)); title('频率=5Hz'); grid on;

% 子图2：20Hz正弦波（频率越高，振动越快）
subplot(2,2,2);
plot(t, sin(2*pi*20*t)); title('频率=20Hz'); grid on;

% 子图3：采样率=50Hz（采样率越低，波形越粗糙）
subplot(2,2,3);
t_low = 0:1/50:t_total;
plot(t_low, sin(2*pi*5*t_low)); title('采样率=50Hz'); grid on;

% 子图4：时长=5s（时长越长，波形越完整）
subplot(2,2,4);
t_long = 0:1/Fs:5;
plot(t_long, sin(2*pi*5*t_long)); title('时长=5s'); grid on;