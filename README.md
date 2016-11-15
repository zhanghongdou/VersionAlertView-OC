# VersionAlertView-OC

<html>
<body>
<h2>什么是 VersionAlertView-OC</h2>
<p>这是一个基于OC语言实现更新版本提示框</p>
<p>相应的基于swift语言实现的更新版本提示框链接：https://github.com/zhanghongdou/VersionAlertView-Swift.git</p>
<p>OC代码链接： https://github.com/zhanghongdou/VersionAlertView-Swift.git</p>
<h2>效果图展示</h2>

<h3>强制更新效果图</h3>
<p><img src="picture/0BDF60CA-4EC4-4D43-ABB7-72A9A72CAAB4.png"/></p>

<h3>非强制更新效果图</h3>
<p><img src="picture/1D46FF2A-9410-4347-8E4C-0D802044D4CF.png"/></p>


<h2>使用方法</h2>
<p style="font-size:16px">

<span style="font-size:16px;color:green;">//updateDetailArray:传入更新的内容数组</span></br>
<span style="font-size:16px;color:green;">//isForcedUpdate:是否进行强制更新</span></br>
<span style="font-size:16px;color:green;">//versionStr：版本号</span></br>
<span style="font-size:16px;color:green;">//updateURLString：跳转地址</span></br>
 VersionAlertView *alert = [[VersionAlertView alloc]initWithUpdateDetailArray:@[@"1.这个版本到底更新了什么我不是很清楚",@"2.这个版本到底更新了什么我不是很清楚"] withIsForceUpdate:NO withVersionoStr:@"V5.0.2" withUpdateURLString:@"haha"];
 [alert show];</br>
</p>
</body>

</html>