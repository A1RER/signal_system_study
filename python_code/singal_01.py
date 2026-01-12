# 导入信号处理必备库
import numpy as np
import matplotlib.pyplot as plt

# ======================== Windows 万能中文修复 核心2行 ========================
plt.rcParams['font.sans-serif'] = ['SimHei', 'SimSun']  # 黑体+宋体，WIN系统必带，永不缺失
plt.rcParams['axes.unicode_minus'] = False              # 解决负号显示为方块的问题
# ==============================================================================

# 信号核心参数（通信工程 信号与系统 入门必懂）
Fs = 1000   # 采样率：每秒采集1000个点，保证波形光滑无锯齿
t_total = 2 # 信号时长：2秒钟
f = 20      # 信号频率：5Hz → 正弦波每秒振动5次

# 生成时间轴 + 生成标准正弦信号（核心公式：x = sin(2πft)）
t = np.arange(0, t_total, 1/Fs)
x = np.sin(2 * np.pi * f * t)

# 绘制正弦波时域波形图
plt.figure(figsize=(10, 4))  # 设置画布大小
plt.plot(t, x, color='#1f77b4', linewidth=1.8)  # 蓝色波形，美观清晰
plt.title("5Hz 正弦信号 - 时域波形图")          # 图表标题
plt.xlabel("时间 (单位：秒)")                   # x轴标签
plt.ylabel("信号幅值")                         # y轴标签
plt.grid(True, alpha=0.3)                      # 网格线，辅助看波形
plt.show()                                     # 显示图表