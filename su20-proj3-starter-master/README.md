# CS61CPU

Look ma, I made a CPU! Here's what I did:

做完pj3后对cpu硬件层面如何实现更加熟悉，整体上对各个组件（branch comparator，alu，imm gen等）以及control logic足够熟悉，以及按照slides上连接起来即可。

如果要说踩坑，swlt这个指令其实属于extra要求，没必要实现
并且在load和pcsel的实现上自己犯蠢了，pcsel忽略了condition是否满足，load忽略了lw lh lb的区别，后面才做好
control logic里面应该有不少可以简化，精力原因不去实现

总的来说这个pj3我分了两次来做，第二次做时回忆第一次就浪费了很多精力，以后一定避免

PS：su20的pj不够完善，建议最少做fa20以及之后的版本，pj4我做了一点发现环境配置有点麻烦，也会选择更新的版本
-
