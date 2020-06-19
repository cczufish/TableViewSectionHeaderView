# TableViewSectionHeaderView


一开始接到需求后，UI说左边的日期时间就跟通讯录里面哪个组头的概念一样。。。。。我一想懵逼了，通讯录组头在上面啊，你这个在左边，怎么写。。。。。

左边日期是一个时间轴的概念，但是时间轴不能自己滑动，依赖于右边的课程列表滑动而去替换日期，当课程的下面一个Item靠近上面的时候，下面的时间替换上面的时间，同一天多个课程的时候，日期不动 。左边是一个时间轴跟右边分开的，日期会跟着列表滑动。

具体需求看图 蓝色的是一个时间轴线，时间轴，组头。红色的是一个组。

![avatar]([https://github.com/cczufish/TableViewSectionHeaderView/blob/master/test222/WechatIMG38.png)

后来查了很多资料做了多次的尝试，


iOS时间轴展示实现

https://www.jianshu.com/p/cf66fb0dc469

iOS 实现时间线列表效果

https://www.jianshu.com/p/2504f2989556

仿简友动态时间轴：使用Snapkit来实现UITableViewCell的动态布局

https://www.ktanx.com/blog/p/4392

UITableViewCell 时间线


https://www.jianshu.com/p/83fe305d2b57

IOS中当UITableView的SectionHead为透明时如何隐藏Section背后重叠的Cell


UITableView 设置sectionHeader 悬浮的位置


https://blog.csdn.net/u012089671/article/details/88114770


关于监测tableViewHeaderViewSection滑到顶部问题
https://www.jianshu.com/p/0b5c6a0b0d0f



发现都不能实现类似的效果，请教了小伙伴可以用tableview分组效果，每一组的section可以当作第一个cell，这样滑动就没有问题了。

后来发现section，也就是第一个cell一直在悬浮，UE要的是时间日期悬浮 其他模块跟着滑动。后来就看到了 MeteoriteMan 大佬的demo


MeteoriteMan ：

[Blog Address](https://blog.csdn.net/qq_18683985/article/details/80082282)

https://github.com/MeteoriteMan/BlogDemo/tree/master/getCurrentSuspendTableViewSectionHeaderView


实现效果如视频。。。。

<iframe 
    height=1920 
    width=886 
    src="https://github.com/cczufish/TableViewSectionHeaderView/blob/master/test222/RPReplay_Final1592534460.MP4" 
    frameborder=0 
    allowfullscreen>
</iframe>

