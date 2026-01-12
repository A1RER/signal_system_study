% MATLAB 卷积运算 - 信号与系统核心
% 两个简单信号的卷积，直观理解卷积的物理意义
x = [1,2,3,4]; % 信号x
h = [1,1,1];   % 系统单位冲激响应h
y = conv(x, h);% 卷积运算，核心函数：conv(信号1, 信号2)

% 绘制卷积前后的波形
subplot(2,1,1); stem([1,2,3,4],x); title('原始信号x'); grid on;
subplot(2,1,2); stem(1:length(y),y); title('卷积结果 y=x*h'); grid on;