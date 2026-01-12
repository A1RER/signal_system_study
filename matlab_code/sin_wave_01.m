% MATLAB 生成5Hz正弦波 - 信号与系统入门
% 采样率Fs=1000Hz，时长2s，频率5Hz，和Python代码参数一致
Fs = 1000;        % 采样率：每秒采集1000个点
t_total = 2;      % 信号时长：2秒
t = 0:1/Fs:t_total;  % 生成时间轴，步长=1/采样率
f = 5;            % 信号频率：5Hz
x = sin(2*pi*f*t);% 生成正弦信号，核心公式和Python完全一致

% 绘制时域波形图
figure;           % 新建画布
plot(t, x);       % 绘制波形，比Python的plt.plot()更简洁
title('5Hz 正弦信号 - 时域波形图'); % 标题，中文完美显示
xlabel('时间 (单位：秒)');          % x轴标签
ylabel('信号幅值');                % y轴标签
grid on;          % 显示网格线，辅助看波形，一键开启