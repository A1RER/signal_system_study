import numpy as np

print("="*50)
print("python 基础语法：")
print("="*50)

# 1.变量和基本数据类型
x = 10  #整数
y=3.14  #浮点数
name='signal'   #字符串，可以用单引号
name2="hello,world!"    #字符串，也可以用双引号
is_valid = True #注意布尔值的首字母要大写

print(f"'int':{x}")
print(f"'float':{y}")
print(f"'str':{name}")
print(f"'list':{name2}")
print(f"bool:{is_valid}")

sample_rate=20  #推荐：小写+下划线
SampleRate=20
_private=10     ##下划线开头一般表示私有变量

#2.关于打印输出：
print("="*50)

#方式1：基本print
print("Hello Python!")
print("value:",42)

#方式2：f-string
x=3.14159
name="python"
print(f"圆周率约为")

#2.列表
samples=[1,2,3,4,5] #创建列表
samples.append(6)   ##添加元素
print(f"列表:{samples}")
print(f"第一个元素:{samples[0]}")    #索引从0开始
print(f"最后一个元素:{samples[-1]}")

#3.循环
print("\n使用for循环:")
for i in range(5):
    print(f"i={i}")

#4.注释
# 单行注释
"""
这是
多行注释
"""

'''
这也是
多行注释
'''