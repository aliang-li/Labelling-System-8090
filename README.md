# Labelling-System-8090
服务器上的标注系统
修改的bug：
  1、修改了同一序列的dcm文件在系统的排列方式（原先时根据方位来排序的，现在改成是按照InstanceNumber排序）
  2、生成的标注信息jpg大小与输入的dcm大小相同  （都是512*512）
添加的功能：
  1、添加了标注工具  区域标注、刷子、擦子
  2、添加了标注信息以dcm文件格式保存
  3、修改了 保存标注信息文件的文件名 ，使jpg图片的文件名与输入的dcm文件名相对应（之前jpg图片的文件名：1.jpg）
  4、初步修改了 标注界面