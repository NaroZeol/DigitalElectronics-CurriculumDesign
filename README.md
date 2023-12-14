## 题目要求
>（1）电路有三个输入按键：clear，start 和 stop，使用一个 LED 作为视觉刺激指示灯，
在七段数码管上显示相应的信息。
><br>
（2）当按下 clear 键时，电路回到初始状态，七段数码管给出一个初始显示，同时 LED
指示灯熄灭。
><br>
（3）当按下 start 键，七段数码管熄灭，产生一段 2s 到 6s（包括 2s 和 6s）之间的随机
时间之后，LED 指示灯点亮，计数器开始加计数。计数器每 1ms 加 1，它的值以 XXX 的
格式显示在数码管上。
><br>
（4）被测试者看到 LED 指示灯点亮后，立即按下 stop 键，此时计数器暂停计数，数
码管显示的就是被测试者的反应时间。大多数人的反应时间在 0.1-0.3s 之间。
><br>
（5）如果不按下 stop 键，计时器达到 999 之后停止计数。
><br>
（6）如果 LED 指示灯点亮前，按下 stop 键，被视为犯规，数码管上应给出犯规指示。
><br>
（7）连续进行多次测试后，可查阅所有测试结果中的最短时间、最长时间和平均时间。
><br>
（8）两个人比赛，显示两人的反应时间及获胜者。

## 模块划分:

### 顶层模块
- FinalDesign.v

### 主控
- MainLogic.v

### 计数器
- Counter.v

### 动态扫描数码管

(改自数电实验5，保留了分层设计，或许之后会想办法整合)
- DivFreq.v
- DataTransformer.v
- Decoder.v
- DynamicScanTubes.v
- ModFourCounter.v
- Two2FourDecoder.v
