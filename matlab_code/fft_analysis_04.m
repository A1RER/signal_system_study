% MATLAB 傅里叶变换 FFT - 时域转频域，信号与系统核心
Fs = 1000; t_total = 2; t = 0:1/Fs:t_total-1/Fs;
f = 5; x = sin(2*pi*f*t); % 5Hz正弦信号

% 傅里叶变换，得到频域信号
N = length(x);          % 信号长度
X = fft(x);             % 傅里叶变换核心函数
f_axis = Fs*(0:N-1)/N;  % 生成频率轴

% 绘制时域+频域图
subplot(2,1,1); plot(t,x); title('时域波形 - 5Hz正弦波'); xlabel('时间(s)'); grid on;
subplot(2,1,2); plot(f_axis, abs(X)); title('频域频谱'); xlabel('频率(Hz)'); grid on;
xlim([0,50]); % 只显示0-50Hz的频谱，更清晰