//
//  ContentView.swift
//  012-Container
//
//  Created by 舒毅文 on 2024/3/19.
//

/*
 https://juejin.cn/post/7266455050632855571
 */

import SwiftUI

#Preview {
    ContentView()
}

// MARK: -
// MARK: 1、Container概述
/*
 SwiftUI的设计源自于便捷、易用，可以根据需求将一个视图放置在另一个视图中。这在处理常用的主要容器视图时尤其有用，比如导航控制器和tabBar控制器。可以把任何视图放到另一个容器视图中，SwiftUI会自动调整它的布局。
 
 在这方面，SwiftUI自己的容器-NavigationStack、TabView、Group等--与用自己的视图组合制作的容器没有什么不同。
 */


// MARK: -
// MARK: 2、使用TabView在tabbar中嵌入视图
/*
 SwiftUI的TabView提供了一个等价于UITabBarController的控件，允许我们让用户使用屏幕底部的一个栏在几个活跃视图之间切换。在其基本形式中，应该为每个item提供一个图像和标题，如果希望以编程方式控制哪个item是active的，还可以添加一个标记。
 */

// MARK: 2.1、基本样式
/*
 创建两个具有不同图像、表土和标签的视图。
 */

//struct ContentView: View {
//    var body: some View {
//        TabView(selection: .constant(1),
//                content:  {
//            Text("Tab Content 1").tabItem {
//                Image(systemName: "1.circle")
//                Text("Tab Label 1")
//            }.tag(1)
//            
//            Text("Tab Content 2").tabItem {
//                Image(systemName: "2.circle")
//                Text("Tab Label 2")
//            }.tag(2)
//        })
//    }
//}

// MARK: 2.2、通过Label创建tabItem
/*
 除了分指定文本和图像，还可以使用Label视图将它们组合在一起。
 */

//struct ContentView: View {
//    var body: some View {
//        TabView(selection: .constant(1),
//                content:  {
//            Text("Tab Content 1").tabItem {
//                Label("Third", systemImage: "3.circle")
//            }.tag(1)
//
//            Text("Tab Content 2").tabItem {
//                Image(systemName: "2.circle")
//                Text("Tab Label 2")
//            }.tag(2)
//        })
//    }
//}

/*
 从iOS15开始，不用明确的使用SF Symbols图标的填充变化，因为系统会自动填充。如果添加label，则可以通过修改item视图的选择以编程方式控制active的item。
 */

// MARK: 2.3、通过tag切换Item
/*
 把每个item的content中添加一个Button来模拟点击，通过添加一些新的状态来跟踪哪个item是活跃的，然后将其附加到TabView的tag。
 */

//struct ContentView: View {
//    @State private var selctedView = 4
//    var body: some View {
//        TabView(selection: $selctedView,
//                content:  {
//            Button("Show Five View") {
//                selctedView = 5
//            }
//            .padding()
//            .tabItem {
//                Label("Third", systemImage: "4.circle")
//            }
//            .tag(4)
//            
//            Button("Show Four View") {
//                selctedView = 4
//            }
//            .padding()
//            .tabItem {
//                Label("Third", systemImage: "5.circle")
//            }
//            .tag(5)
//        })
//    }
//}

/*
 只要数据类型符合Hashable，item的label可以是任何类型。整数可能是最好的，但是如果要进行任何有意义的程序化导航，则应该确保将标记放在视图的中心位置，例如静态属性。这是可以在许多地方共享的方式，从而降低出错的风险。
 */

// MARK: -
// MARK: 3、使用TabView创建UIPageViewController
/*
 SwiftUI的TabView可以当作为一个UIPageViewController，可以制作在多个屏幕间滑动的Content，底部的分页点显示具体位置。要激活页面的视图样式，将.tabViewStyle()修饰符附加到TabView，传入参数.page。
 */

// MARK: 3.1、.tabViewStyle(.page)
/*
 分页点是白色和半透明的白色，如果视图背景为白色，则看不到分页点
 */

//struct ContentView: View {
//    var body: some View {
//        TabView {
//            Text("First")
//            Text("Second")
//        }
//        .tabViewStyle(.page)
//    }
//}

// MARK: 3.2、.indexViewStyle(.page(backgroundDisplayMode: .always))
/*
 为了解决这个问题，可以在tabViewStyle()设置额外的修饰符来要求SwiftUI放置背景
 */

//struct ContentView: View {
//    var body: some View {
//        TabView {
//            Text("First")
//            Text("Second")
//        }
//        .tabViewStyle(.page)
//        .indexViewStyle(.page(backgroundDisplayMode: .always))
//    }
//}

// MARK: 3.3、.tabViewStyle(.page(indexDisplayMode: .never))
/*
 可以通过像.page方法添加一个额外的参数来控制分页点的显示，如果不想显示分页点，可以直接传入.never
 */

//struct ContentView: View {
//    var body: some View {
//        TabView {
//            Text("First")
//            Text("Second")
//        }
//        .indexViewStyle(.page(backgroundDisplayMode: .never))
//    }
//}

// MARK: -
// MARK: 4、使用Group对视图分组
/*
 如果需要几个视图作为一个整体--例如，一起转换，那么可以使用SwiftUI的Group视图，这一点尤其重要，因为由于潜在技术原因，一次最多向父视图添加10个视图。
 */

//struct ContentView: View {
//    var body: some View {
//        //包含10个Text的Stack,当添加了11个视图的时候就会报错（Extra argument in call）
//        //得到的错误是对成员“buildBlock()”的模糊引用。
//        VStack {
//            Text("Line 1")
//            Text("Line 2")
//            Text("Line 3")
//            Text("Line 4")
//            Text("Line 5")
//            Text("Line 6")
//            Text("Line 7")
//            Text("Line 8")
//            Text("Line 9")
//            Text("Line 0")
//        }
//        Divider()
//        //这是因为SwiftUI的视图构建系统有各种各样的代码，可以添加1-10个视图，
//        //但不能添加第11个视图，但是，可以使用Group
//        VStack {
//            Group {
//                Text("Line 1")
//                Text("Line 2")
//                Text("Line 3")
//                Text("Line 4")
//                Text("Line 5")
//                Text("Line 6")
//            }
//            
//            Group {
//                Text("Line 7")
//                Text("Line 8")
//                Text("Line 9")
//                Text("Line 0")
//                Text("Line 11")
//            }
//        }
//        //这种情况下就巧妙的绕过了10个视图的限制，因为这个时候VStack只包含了两个Group
//    }
//}

// MARK: -
// MARK: 5、StatusBar的显示和隐藏
/*
 使用SwiftUI的StatusBar()修饰符隐藏和显示iOS状态栏。接受一个隐藏参数，该参数必须为true或false，取决于需求。
 */

//struct ContentView: View {
//    @State private var hideStatusBar = false
//    var body: some View {
//        Text("No status bar, Please")
////            .statusBar(hidden: false)
//        
//        Button("Toggle status Bar") {
//            withAnimation {
//                hideStatusBar.toggle()
//            }
//        }
//        .statusBar(hidden: hideStatusBar)
//    }
//}

// MARK: -
// MARK: 6、使用DisclosureGroup隐藏和显示内容
/*
 SwiftUI有一个专用的DisclosureGroup视图，它显示一个披露指示器，并包含其中的内容。在最简单的形式中，他可以完全由用户控制，但也可以将其绑定到一个bool属性，确定当前内容是否可见。
 */

// MARK: 6.1、DisclosureGroup
/*
 创建一个包含大量文本的DisclosureGroup
 */

//struct ContentView: View {
//    var body: some View {
//        DisclosureGroup("Show Terms") {
//            Text("噫吁嚱，危乎高哉！蜀道之难，难于上青天！蚕丛及鱼凫，开国何茫然！尔来四万八千岁，噫吁嚱，危乎高哉！蜀道之难，难于上青天！蚕丛及鱼凫，开国何茫然！尔来四万八千岁，")
//                .frame(width: 300)
//                .padding()
//        }
//    }
//}

// MARK: 6.2、通过修改bool值，控制是否展开Content
/*
 如果想要跟踪披露组是否打开，可以将其绑定到bool值
 */

//struct ContentView: View {
//    @State private var revealDetails = true
//    var body: some View {
//        DisclosureGroup("Show Terms", isExpanded: $revealDetails) {
//            Text("噫吁嚱，危乎高哉！蜀道之难，难于上青天！蚕丛及鱼凫，开国何茫然！尔来四万八千岁，噫吁嚱，危乎高哉！蜀道之难，难于上青天！蚕丛及鱼凫，开国何茫然！尔来四万八千岁，")
//                .frame(width: 300)
//                .padding()
//        }
//    }
//}

// MARK: -
// MARK: 7、创建Toolbar并向其添加按钮
/*
 SwiftUI的toolbar()修饰符可以在顶部或底部任何地方方式按钮item，但只有视图嵌入到NavigationStack中时才可以。
 */

// MARK: 7.1、ToolbarItem
/*
 如果你想把按钮放在屏幕底部的工具栏中，使用Toolbar()，然后创建一个Toolbar item，指定位置为.bottomBar
 */

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            Text("fdsfds")
//                .padding()
//                .navigationTitle("SwiftUI")
//                .toolbar(content: {
//                    ToolbarItem(placement: .bottomBar) {
//                        Button("Press me") {
//                            print("Toolbar Bottom")
//                        }
//                    }
//                })
//        }
//    }
//}

// MARK: 7.2、ToolbarItemGroup
/*
 要创建多个Button，使用ToolbarItemGroup而不是ToolbarItem，设置多个Button
 */

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            Text("fdsfds")
//                .padding()
//                .navigationTitle("SwiftUI")
//                .toolbar(content: {
//                    ToolbarItemGroup(placement: .bottomBar) {
//                        Button("Press me") {
//                            print("Toolbar Bottom")
//                        }
//                        Button("Press me") {
//                            print("Toolbar Bottom")
//                        }
//                    }
//                })
//        }
//    }
//}

// MARK: 7.3、ToolbarItemGroup添加Spacer

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            Text("fdsfds")
//                .padding()
//                .navigationTitle("SwiftUI")
//                .toolbar(content: {
//                    ToolbarItemGroup(placement: .bottomBar) {
//                        Button("Press me") {
//                            print("Toolbar Bottom")
//                        }
//                        Spacer()
//                        Button("Press me") {
//                            print("Toolbar Bottom")
//                        }
//                    }
//                })
//        }
//    }
//}

// MARK: -
// MARK: 8、自定义ToolbarButton
/*
 SwiftUI的工具栏允许用户自定义item，5个步骤：

 1）为toolbar提供唯一的、稳定的标识符字符串。
 2）为每个可自定义toolbar的item提供唯一的、稳定的标识符字符串。
 3）在.secondaryaction类别中放置可定制的button
 4）为toolbar启用编辑器模式，以便所有的辅助操作都成为toolbar按钮
 5）“唯一、稳定”的标识符很重要，因为这是SwiftUI用来记住用户设置的--toolbar
 */

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            Text("SwiftUI")
//                .navigationTitle("Welcome")
//                .toolbar(id: "option") {
//                    ToolbarItem(id: "settings", placement: .primaryAction) {
//                        Button("Settings") {
//                            print("Settings")
//                        }
//                    }
//                    
//                    ToolbarItem(id: "help", placement: .secondaryAction) {
//                        Button("Help") {
//                            print("Help")
//                        }
//                    }
//                    
//                    ToolbarItem(id: "email", placement: .secondaryAction) {
//                        Button("Email") {
//                            print("Email")
//                        }
//                    }
//                    
//                    ToolbarItem(id: "credits", placement: .secondaryAction) {
//                        Button("Credits") {
//                            print("Credits")
//                        }
//                    }
//                    
//                    //默认情况下，这将使所有的次要操作button都可以单独自定义，
//                    //但是如果你在ControlGroup中包装两个或更多Button，
//                    //则它们将被附加用于自定义目的--必须同时添加或不添加
//                    ToolbarItem(id: "font", placement: .secondaryAction) {
//                        ControlGroup {
//                            Button {
//                                print("ControlGroup - 1")
//                            } label: {
//                                Label("Decrease font size", systemImage: "textformat.size.smaller")
//                            }
//                            Button {
//                                print("ControlGroup - 2")
//                            } label: {
//                                Label("Increase font size", systemImage: "textformat.size.larger")
//                            }
//                        } label: {
//                            Label("Font size", systemImage: "textformat.size")
//                        }
//                    }
//                }
//                .toolbarRole(.editor)
//            
//            //如果没有为ControlGroup添加Label，SwiftUI将为他包含的按钮使用Label
//        }
//    }
//}

// MARK: -
// MARK: 9、TabView或List-cell添加一个badge
/*
 SwiftUI的Badge()修饰符可以向TabView item视图和list-cell添加数字和文本，目的将用户的注意力吸引到一些弥补状态信息上--例如，TabView上的数字标识未读消息。
 */

//struct ContentView: View {
//    var body: some View {
//        TabView {
//            VStack {
//                List {
//                    Text("Wifi")
//                        .badge("fdsf")
//                    
//                    Text("Bluetooth")
//                        .badge(100)
//                }
//            }
//            .tabItem {
//                Label("Home", systemImage: "house")
//            }
//            .badge(100)
//        }
//    }
//}

/*
 badge同样适用于List-cell，并自动以第二种颜色显示为右对齐文本。
 */

// MARK: -
// MARK: 10、GroupBox可视化的对视图进行分组
/*
 SwiftUI的GroupBox视图将视图组合在一起，并在他后面放置浅色背景，以便突出。如果需要的话，还可以选择包含一个标题来制作组标题。
 */

//struct ContentView: View {
//    var body: some View {
//        GroupBox {
//            Text("Your account")
//                            .font(.headline)
//                        Text("Username: metabblv@163.com")
//                        Text("City: Shanghai")
//        }
//        GroupBox {
//            VStack(alignment:.leading) {
//                Text("Your account")
//                    .font(.headline)
//                Text("Username: metabblv@163.com")
//                Text("City: Shanghai")
//            }
//        }
//        //GroupBox的真正强大的功能，如果嵌套它们，会自动调整颜色，以便清晰的区分。
//        GroupBox {
//            Text("Outer Content")
//            GroupBox {
//                Text("Middle Content")
//                GroupBox {
//                    Text("Inner Content")
//                }
//            }
//        }
//    }
//}

// MARK: -
// MARK: 11、如何隐藏Tabbar、navigationBar、toolbars
/*
 SwiftUI的toolbar()修饰符允许我们在需要的时候隐藏或显示任何系统栏，当你有一个TabView想要在导航推送之后隐藏的时候，这个修饰符特别有用。将修饰符附加到可以触发隐藏或显示toolbar的任何视图上。
 */

// MARK: 11.1、

//struct ContentView: View {
//    var body: some View {
//        TabView {
//            NavigationStack {
//                NavigationLink("Tap me") {
//                    Text("Detail View")
//                        .toolbar(.hidden, for: .tabBar)
//                }
//                .navigationTitle("Primary View")
//            }
//            .tabItem {
//                Label("Home", systemImage: "house")
//            }
//        }
//    }
//}

/*
 如果没有指定要隐藏的是谁（for：tabbar），那么隐藏效果将流向最近的容器，可能是导航栏被隐藏。
 */

// MARK: 11.2、动态隐藏NavigationBar
/*
 当随时改变传递给toolbar的值，就可以动态切换导航栏了
 */

//struct BarDetailView: View {
//    @State private var showNavigationBar = true
//    var body: some View {
//        Text("Detail View")
//            .toolbar(showNavigationBar ? .visible : .hidden)
//            .onTapGesture {
//                withAnimation {
//                    showNavigationBar.toggle()
//                }
//            }
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        TabView {
//            NavigationStack {
//                NavigationLink("DetailView", destination: BarDetailView())
//                    .navigationTitle("Primary View")
//            }
//            .tabItem {
//                Label("Detail", systemImage: "1.circle")
//            }
//        }
//    }
//}

// MARK: -
// MARK: 12、自定义Navigationbar、tabbar、toolbars的背景色
/*
 SwiftUI的toolbarBackground()修饰符可以自定义工具来在app中的外观，根据需求控制NavigationStack、TabView和其他toolbar样式。
 */

// MARK: 12.1、设置Navigationbar背景色
/*
 显示包含100行的list，导航栏背景为蓝绿色
 */

//struct ContentView: View {
//    var body: some View {
//        TabView {
//            NavigationStack {
//                List(0..<100) {
//                    Text("Row \($0)")
//                }
//                .navigationTitle("100 Rows")
//                .toolbarBackground(.teal, for: .navigationBar)
//            }
//            .tabItem {
//                Label("First", systemImage: "1.circle")
//            }
//        }
//    }
//}

/*
 在这里选择的背景值在系统认为必要时使用，而不是总是可见的。因此，在上面的代码中，navigationbar开始是没有颜色的，滚动后会改变。
 */

// MARK: 12.2、Toolbar单独着色
/*
 如果希望为一个或两个栏类型着色，或者希望为每个栏提供不同的样式，则可以向toolbarBackground提供第二个参数以获得外的控制。
 */

//struct ContentView: View {
//    var body: some View {
//        // 显示包含100行的list，导航栏背景为蓝绿色
//        TabView {
//            NavigationStack {
//                List(0..<100) {
//                    Text("Row \($0)")
//                }
//                .navigationTitle("100 Rows")
//                .toolbarBackground(.orange, for: .navigationBar, .tabBar)
//            }
//            .tabItem {
//                Label("Second", systemImage: "list.bullet")
//            }
//        }
//    }
//}

// MARK: 12.3、完全隐藏
/*
 可以完全隐藏背景，而不是指定背景颜色
 */

//struct ContentView: View {
//    var body: some View {
//        // 显示包含100行的list，导航栏背景为蓝绿色
//        TabView {
//            NavigationStack {
//                List(0..<100) {
//                    Text("Row \($0)")
//                }
//                .navigationTitle("100 Rows")
//                .toolbarBackground(.hidden)
//            }
//            .tabItem {
//                Label("Second", systemImage: "list.bullet")
//            }
//        }
//    }
//}

/*
 当滚动时，列表内容直接出现在导航标题上。如果采用这种方法，请确保你的主要内容与toolbar重叠时不会发生UI问题。
 */

