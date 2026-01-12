% MATLAB 信号加噪+滤波 - 实用技能，信号与系统实验必做
Fs = 1000; t = 0:1/Fs:2;
x = sin(2*pi*5*t);       % 原始5Hz正弦信号
x_noise = x + 0.2*randn(size(t)); % 加高斯噪声

% 低通滤波，去除噪声，保留原始信号
[b,a] = butter(4, 0.1);  % 4阶巴特沃斯低通滤波器
x_filter = filter(b,a,x_noise);

% 绘制波形对比
subplot(3,1,1); plot(t,x); title('原始信号'); grid on;
subplot(3,1,2); plot(t,x_noise); title('加噪后的信号'); grid on;
subplot(3,1,3); plot(t,x_filter); title('滤波后的信号'); grid on;