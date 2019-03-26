# JKMovingLabelsView
A collectionview which can show scroll labels, and the labels' text are attributed. It's simple but useful.
<div align=left>
  <img src="https://upload-images.jianshu.io/upload_images/1590790-3cecf8639f3b2431.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/376" width="300" height="533" />
  <img src="https://upload-images.jianshu.io/upload_images/1590790-276dedcfbfa29e8a.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/449" width="300" height="533" />
</div>


思路：
计时器使用的gcd的，如果需要调整速度，就增加或者减小每次每次向右移动的幅度吧。
默认好像一次向右移动+1px的偏移量，等移动到contentSize.width的时候，就直接重置到初始位置，实现轮播。
主要内容右边的空白需要计算出正确的长度，然后和从0到第n的元素的长度之和对比，如果正好能够填充，就不再循环添加。
关于展示文本的数组，因为感觉富文本包含plain样式，就强制必须传入富文本的数组。
点击回调用了block实现。
（完）
·
·
·
·
one more thing，版权没有，盗版不究，欢迎fork&star，任意交流。
