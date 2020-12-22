## GetX
包含了常用的屏幕高度和宽度还有局部刷新等

## 效果

![](../../../img/get_all.gif)

## 代码

其实就是标准的`MVC`

`V`在flutter中叫做`StatefullWidget、StatelessWidget`,`M`是`Model`,`C`是`Controller`.
有数据更新在`C`中实现，自动更新`V`,实现原理是利用了`Stream`的流，每次有新的数据，则会刷新`V`.
![](../../../img/get_guanxi.png)

通过`obs`来更新局部`UI`
```
final log = ''.obs;
```
在`Widget`中：

```
ObxValue((v) {
            return Text('${v.value}');
          }, c.log),
```

完整的代码看仓库即可。







