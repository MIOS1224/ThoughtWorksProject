# ThoughtWorkWebChat
ThoughtWorkWebChat  已适配 iOS 13

1.本文采用RAC + MVVM模式开发

2.Base类：
2.1BaseViewController：a.所有的controller基类，initWithViewModel 初始化ViewModel; bindViewModel  用于子类实现自定义方法及相关配置，与viewdidload同级别

2.2  BaseTableViewController ： 普通tableviewcontroller，提供reload方法，及cell注册方法，可根据此类实现不同类型的tableview，用于快速创建某些特定功能controller
2.3 baseviewmodel：viewmodel的基类，可添加对controller的配置，及其他相关参数eg：tableview 相关的datasource
2.4 BaseViewProtocol: uiview 通用协议，可用于uiview赋值，及uiview相关的配置
2.5 BaseTableViewModel： tablecontroller viewmodel，提供table相关的样式，网络请求命令，后续可添加同等配置或参数

3.UserModelManager：暂时管理userinfo信息

4.homePageviewcontroller:首页，可用于特定类型的tableview创建，可添加header，footerview 基础类

5.FriendShipController：朋友圈主要页面，标题头像等被看作是tableview 的sectionview (FriendShipHeaderView)，评论模块是真正的cell
5.1. CommentHeaderView 原本headview，包含本用户头像，名称，图片，及封面显示
5.2. 多数采用YYText控件，来实现富文本的显示

6.Utils 文件存放工具类：
6.1.safe:防止数组越界，字典为空时crash情况
6.2. Service：网络请求l工具
6.3 category：工具类分类

7.Vendor：第三方库

8.Macros：通用配置类
8.1：GlobalDefines 宏工具
8.2：ConstConfig 全局使用的关键字段

9.[[JPFPSStatus sharedInstance] open];FPS检测，debug状态下，在window顶部显示当前页面的FPS
10.MLeaksFinder 内存检测工具


             
