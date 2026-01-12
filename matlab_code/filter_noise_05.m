%% ============================================================================
%  SIGNAL NOISE REDUCTION USING BUTTERWORTH LOW-PASS FILTER
%  信号降噪：基于巴特沃斯低通滤波器的噪声去除
% ============================================================================
%
% DESCRIPTION:
%   This script demonstrates the fundamental signal processing technique of
%   noise reduction through digital filtering. It creates a clean sinusoidal
%   signal, adds Gaussian white noise to simulate real-world signal corruption,
%   and then applies a Butterworth low-pass filter to recover the original
%   signal. This is a core practical skill in signal processing, communications,
%   and control systems engineering.
%
%   本脚本演示了数字滤波降噪的基础信号处理技术。通过生成纯净正弦信号、
%   添加高斯白噪声模拟真实环境干扰，最后应用巴特沃斯低通滤波器恢复原始信号。
%   这是信号处理、通信工程和控制系统中的核心实用技能。
%
% THEORY - BUTTERWORTH FILTER (巴特沃斯滤波器理论):
%   The Butterworth filter is a type of signal processing filter designed to
%   have a frequency response as flat as possible in the passband. It is also
%   known as a maximally flat magnitude filter.
%
%   Key characteristics (关键特性):
%   1. Maximally flat frequency response in passband (通带内最大平坦响应)
%   2. Monotonic response (no ripples) (单调响应，无波纹)
%   3. Order n determines roll-off steepness: 20n dB/decade (阶数决定滚降速率)
%   4. Trade-off: flatter passband vs. slower roll-off (权衡：更平坦的通带 vs 更慢的滚降)
%
%   Transfer function magnitude (传递函数幅度):
%   |H(jω)|² = 1 / (1 + (ω/ωc)^(2n))
%   where ωc is cutoff frequency, n is filter order
%
% PARAMETERS (参数说明):
%   Fs          - Sampling frequency in Hz (采样频率)
%                 Must satisfy Nyquist criterion: Fs ≥ 2*f_max
%                 Value: 1000 Hz (sufficient for audio and most signals)
%
%   t_total     - Total signal duration in seconds (信号总时长)
%                 Value: 2 seconds (provides good visualization window)
%
%   f           - Signal frequency in Hz (信号频率)
%                 Value: 5 Hz (low frequency, easy to visualize)
%
%   noise_amp   - Noise amplitude factor (噪声幅度系数)
%                 Value: 0.2 (20% of signal amplitude)
%                 Controls signal-to-noise ratio (SNR)
%
%   filter_order- Butterworth filter order (滤波器阶数)
%                 Value: 4 (good balance between performance and complexity)
%                 Higher order = steeper roll-off but more computation
%
%   Wn          - Normalized cutoff frequency (归一化截止频率)
%                 Range: 0 to 1, where 1 corresponds to Fs/2 (Nyquist frequency)
%                 Value: 0.1 → actual cutoff = 0.1 * (Fs/2) = 50 Hz
%                 Selected to pass 5Hz signal while blocking high-freq noise
%
% ALGORITHM STEPS (算法步骤):
%   1. Generate clean sinusoidal test signal (生成纯净测试信号)
%   2. Add Gaussian white noise to simulate real-world interference (添加噪声)
%   3. Design Butterworth low-pass filter coefficients (设计滤波器系数)
%   4. Apply filter to noisy signal using difference equation (应用滤波器)
%   5. Visualize original, noisy, and filtered signals for comparison (可视化对比)
%
% OUTPUT:
%   Three subplot figure showing:
%   - Top:    Original clean signal (原始信号)
%   - Middle: Noisy signal with SNR ≈ 14 dB (加噪信号)
%   - Bottom: Filtered signal with noise significantly reduced (滤波后信号)
%
% APPLICATIONS (应用场景):
%   - Audio signal denoising (音频降噪)
%   - Biomedical signal processing (ECG, EEG) (生物医学信号处理)
%   - Communication systems receiver design (通信系统接收机设计)
%   - Sensor data smoothing (传感器数据平滑)
%   - Control systems feedback filtering (控制系统反馈滤波)
%
% NOTES:
%   - The filter function implements the difference equation:
%     y[n] = (1/a[0]) * (b[0]*x[n] + b[1]*x[n-1] + ... - a[1]*y[n-1] - ...)
%   - For real-time applications, consider using filtfilt() for zero-phase filtering
%   - Adjust Wn based on your signal frequency and noise characteristics
%
% REFERENCES:
%   - Butterworth, S. (1930). "On the Theory of Filter Amplifiers"
%   - Oppenheim & Schafer, "Discrete-Time Signal Processing"
%   - MATLAB Signal Processing Toolbox Documentation
%
% AUTHOR: Signal & Systems Course (通信工程信号与系统课程)
% DATE: 2024
% VERSION: 1.1 - Comprehensive documentation added
%
%% ============================================================================

% -------------------------------------------------------------------------
% SECTION 1: Signal Generation and Parameter Setup (信号生成与参数设置)
% -------------------------------------------------------------------------
Fs = 1000;              % Sampling frequency: 1000 Hz (采样频率)
                        % Nyquist frequency = Fs/2 = 500 Hz

t_total = 2;            % Signal duration: 2 seconds (信号时长)

t = 0:1/Fs:t_total;     % Time vector: from 0 to 2s with step size 1/Fs
                        % Total samples: 2001 points (2000 intervals + 1)
                        % 时间向量：从0到2秒，步长为1/采样率

f = 5;                  % Signal frequency: 5 Hz (信号频率)
                        % Period T = 1/f = 0.2 seconds (周期)
                        % 10 complete cycles in 2 seconds (2秒内10个完整周期)

x = sin(2*pi*f*t);      % Generate clean sinusoidal signal (生成纯净正弦信号)
                        % Amplitude = 1, Phase = 0
                        % Mathematical form: x(t) = sin(2πft)

% -------------------------------------------------------------------------
% SECTION 2: Add Gaussian White Noise (添加高斯白噪声)
% -------------------------------------------------------------------------
noise_amplitude = 0.2;  % Noise amplitude factor: 20% of signal amplitude
                        % (噪声幅度系数：信号幅度的20%)

x_noise = x + noise_amplitude * randn(size(t));
                        % randn() generates Gaussian white noise: mean=0, std=1
                        % Noise is scaled by 0.2 to control SNR
                        % Signal-to-Noise Ratio (SNR) ≈ 14 dB
                        % randn()生成标准正态分布噪声(均值0，标准差1)
                        % 信噪比约14分贝

% -------------------------------------------------------------------------
% SECTION 3: Design Butterworth Low-Pass Filter (设计巴特沃斯低通滤波器)
% -------------------------------------------------------------------------
filter_order = 4;       % Filter order: 4th-order Butterworth (滤波器阶数)
                        % Higher order → steeper roll-off (20*4=80 dB/decade)
                        % More poles → better frequency selectivity
                        % 更高阶数→更陡峭的滚降(80分贝/十倍频)

Wn = 0.1;               % Normalized cutoff frequency: 0.1 (归一化截止频率)
                        % Actual cutoff = Wn * (Fs/2) = 0.1 * 500 = 50 Hz
                        % This passes our 5Hz signal while blocking high-freq noise
                        % 实际截止频率 = 0.1 × 500 = 50赫兹

[b, a] = butter(filter_order, Wn);
                        % Returns filter coefficients in transfer function form
                        % b: numerator coefficients (zeros) (分子系数)
                        % a: denominator coefficients (poles) (分母系数)
                        % Transfer function: H(z) = B(z)/A(z)
                        % 传递函数：H(z) = (b0 + b1*z^-1 + ...)/(a0 + a1*z^-1 + ...)

% -------------------------------------------------------------------------
% SECTION 4: Apply Filter to Noisy Signal (对噪声信号应用滤波器)
% -------------------------------------------------------------------------
x_filter = filter(b, a, x_noise);
                        % Implements the difference equation:
                        % a[0]*y[n] = b[0]*x[n] + b[1]*x[n-1] + ... - a[1]*y[n-1] - ...
                        % This is a causal, time-domain implementation
                        % 实现差分方程进行滤波处理(因果、时域实现)

% -------------------------------------------------------------------------
% SECTION 5: Visualization and Comparison (可视化对比)
% -------------------------------------------------------------------------
figure('Name', 'Signal Denoising with Butterworth Filter', 'NumberTitle', 'off');

% Subplot 1: Original Clean Signal (原始纯净信号)
subplot(3,1,1);
plot(t, x, 'LineWidth', 1.5, 'Color', [0 0.4470 0.7410]);
title('Original Clean Signal (原始信号) - 5Hz Sinusoid', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Time (seconds) 时间(秒)');
ylabel('Amplitude 幅度');
grid on;
ylim([-1.5 1.5]);       % Fixed scale for comparison (固定刻度便于对比)

% Subplot 2: Noisy Signal (加噪声信号)
subplot(3,1,2);
plot(t, x_noise, 'LineWidth', 1, 'Color', [0.8500 0.3250 0.0980]);
title('Noisy Signal (加噪信号) - SNR ≈ 14 dB', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Time (seconds) 时间(秒)');
ylabel('Amplitude 幅度');
grid on;
ylim([-1.5 1.5]);       % Same scale for fair comparison (相同刻度便于对比)

% Subplot 3: Filtered Signal (滤波后信号)
subplot(3,1,3);
plot(t, x_filter, 'LineWidth', 1.5, 'Color', [0.4660 0.6740 0.1880]);
title('Filtered Signal (滤波后信号) - Noise Removed', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Time (seconds) 时间(秒)');
ylabel('Amplitude 幅度');
grid on;
ylim([-1.5 1.5]);       % Consistent scale across all plots (统一刻度)

%% ============================================================================
% END OF SCRIPT
%
% EXPERIMENT SUGGESTIONS (实验建议):
%   1. Try different noise amplitudes (0.1, 0.5, 1.0) to see filter limits
%      尝试不同噪声幅度(0.1, 0.5, 1.0)观察滤波器极限
%
%   2. Change filter order (2, 6, 8) and observe roll-off differences
%      改变滤波器阶数(2, 6, 8)观察滚降差异
%
%   3. Adjust Wn (0.05, 0.2) to see cutoff frequency effects
%      调整截止频率(0.05, 0.2)观察滤波效果
%
%   4. Add multiple frequency components and selective filtering
%      添加多频率分量并进行选择性滤波
%
%   5. Compare with other filter types: Chebyshev, Elliptic, FIR
%      与其他滤波器类型对比：切比雪夫、椭圆、FIR滤波器
% ============================================================================