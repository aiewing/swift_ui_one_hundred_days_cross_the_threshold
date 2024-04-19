//
//  ContentView.swift
//  013-Navigation
//
//  Created by 舒毅文 on 2024/3/22.
//

/*
 https://juejin.cn/post/7267719499019862052
 */

import SwiftUI

#Preview {
    ContentView()
}

// MARK: -
// MARK: 1、Navigation概述
/*
 导航是许多应用程序的核心，SwiftUI的简单、易用的方面在Navigation上做的非常好，这意味着使用NavigationLink、使用NavigationPath完全控制导航，使用NavigationSplitcView支持第二视图和第三视图布局等。
 这意味着很多时候可以忽略Navigation相关的场景，因为非常简单，专注于需要更多思考的部分，例如：

 1）制作具有合理默认值的可自定义的toolbar
 2）通过状态恢复保存和加载用户的导航
 3）决定如何显示侧边栏，或在需要时添加额外的Content视图
 4）结合NavigationSplitView和NavigationStack获得想要的结构
 */

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            List {
//                NavigationLink("最简单的Navigation") {
//                    Text("So easy")
//                }
//            }
//        }
//    }
//}

// MARK: -
// MARK: 2、如何在Navigation中嵌入View
/*
 SwiftUI的NavigationStack或多或少的映射到UIKit的UINavigationController，因为它显示内容，它能够处理视图之间的导航。
 */

// MARK: 2.1、基础样式
/*
 以最简单的方式，将Text放入NavigationStack中
 */

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            Text("This is a great app")
//        }
//    }
//}

// MARK: 2.2、.navigationTitle("Welcome")
/*
 然而，顶部导航栏是空的。因此，通常会在嵌入的任何内容上使用navigationTitle()修饰符，因此可以在屏幕顶部添加标题。
 */

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            Text("Swift")
//                .navigationTitle("Welcome")
//        }
//    }
//}

// MARK: 2.3、navigationBarTitleDisplayMode
/*
 还有第二个修饰符，navigationBarTitleDisplayMode()，可以控制是否使用大标题还是小标题的内联标题。例如，默认情况下，任何视图以继承其大标题的显示模式呈现的，或者如果是初始视图，则使用大标题。但是，如果更愿意手动启用或禁用大标题，应该使用.navigationBarTitleDisoplayMode()
 */

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            Text("SwiftUI")
//                .navigationTitle("Meta BBlv")
//                .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}

/*
 这将产生小的导航标题，但可以使用.large来设置一个大标题
 */

// MARK: -
// MARK: 3、Navigation的可编辑状态
/*
 SwiftUI的NavigationStack可以使用navigationTitle()显示一个简单的字符串，但同一修饰符也可接受字符串绑定，以便可以通过点击来编辑标题
 */

//struct ContentView: View {
//    @State private var title = "Welcome"
//    var body: some View {
//        NavigationStack {
//            Text("Hello World")
//                .navigationTitle($title)
//                .navigationBarTitleDisplayMode(.inline)
//                .toolbarRole(.editor)
//        }
//    }
//}

/*
 只有当导航栏以内联模式运行时，导航标题编辑才有效。仅适用于iOS和iPadOS
 */

// MARK: 4、Navigation添加bar-Items
/*
 toolbar()修饰符可以将单个或多个item按钮添加到navigationStack的前面和后面，以及视图的其他部分。这些可能是可点击的按钮，但没有限制--可以添加任何类型的视图。
 */

// MARK: 4.1、在导航条的后面添加了两个按钮

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            Text("SwiftUI")
//                .navigationTitle("Welcome")
//                .toolbar(content: {
//                    Button("About") {
//                        print("About tapped")
//                    }
//                    Button("Help") {
//                        print("Help tapped")
//                    }
//                })
//        }
//    }
//}

// MARK: 4.2、在导航条的前面添加了一个按钮
/*
 如果想控制按钮的确切位置，可以通过将其包装在ToolBarItem并制定所需的位置来做到这一点。例如，创建一个按钮，并强制将其放在导航栏前面。
 */

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            Text("Swift UI")
//                .navigationTitle("Welcome")
//                .toolbar(content: {
//                    ToolbarItem(placement: .topBarLeading) {
//                        Button("Help") {
//                            print("Help tapped")
//                        }
//                    }
//                })
//        }
//    }
//}

// MARK: 4.3、多个item放在相同的位置(ToolbarItenmGroup)
/*
 如果想在不同位置放置多个item-button，只需要根据多次重复ToolBarItem，并每次指定不同的位置。要将多个item放在相同的位置，需要将他们包装在ToolbarItenmGroup中
 */

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            Text("SwiftUI")
//                .navigationTitle("Welcome")
//                .toolbar(content: {
//                    ToolbarItemGroup(placement: .primaryAction) {
//                        Button("About") {
//                            print("About tapped")
//                        }
//                        
//                        Button("Help") {
//                            print("Help tapped")
//                        }
//                    }
//                })
//        }
//    }
//}

/*
 这使用.primaryAction，将根据平台（iOS等）认为最重要的按钮的位置来定位按钮。
 */

// MARK: 4.4、primaryAction与secondaryAction优先级设置item
/*
 还有一个.secondaryAction放置，专为有用但不需要操作而设计，在iOS上，将导致该组中的按钮折叠为单个详细信息按钮
 */

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            Text("SwiftUI")
//                .navigationTitle("Welcome")
//                .toolbar(content: {
//                    ToolbarItemGroup(placement: .primaryAction) {
//                        Button("About") {
//                            print("About tapped!")
//                        }
//                        Button("Help") {
//                            print("About tapped!")
//                        }
//                    }
//                    ToolbarItemGroup(placement: .secondaryAction) {
//                        Button("Settings") {
//                            print("Credits tapped!")
//                        }
//                        Button("Email Me") {
//                            print("Email tapped!")
//                        }
//                    }
//                })
//        }
//    }
//}

// MARK: -
// MARK: 5、如何将新视图push到NavigationStack上
/*
 SwiftUI可以使用NavigationLink将任何视图推送到navigationStack上，在其最简单的形式中，可以为其标题提供字符串和目标视图作为尾随闭包。
 */

//struct DetailView: View {
//    var body: some View {
//        Text("This is the detail view")
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            VStack {
//                NavigationLink("Show Detail View") {
//                    DetailView()
//                }
//                
//                NavigationLink {
//                    DetailView()
//                } label: {
//                    Label("Show Detail View Label", systemImage: "globe")
//                }
//            }
//            .navigationTitle("Navigation")
//        }
//    }
//}

// MARK: 6、点击List-cellpush新的视图
/*
 SwiftUI的NavigationLink可在List-cell中使用，以便在点击cell时显示新的视图。如果NavigationLink包含整个cell，系统会自动理解为整个cell可点击，以显示新视图。有两种方法可以指定导航目的地，通过明确链接，或者如果目标是iOS16以及更高版本，可以使用navigationDestination()
 */

//struct PlayerView: View {
//    let name: String
//    var body: some View {
//        Text("Select player: \(name)")
//            .font(.largeTitle)
//    }
//}
//
//struct ContentView: View {
//    let players = [
//        "Roy Kent",
//        "Richard Montlaur",
//        "Dani Rojas",
//        "Jamie Tartt"
//    ]
//    
//    var body: some View {
//        // 创建一个包含List的NavigationStack，允许用户选择Player
//        NavigationStack {
//            List(players, id: \.self) { player in
//                NavigationLink(player, value: player)
//            }
//            .navigationDestination(for: String.self) {
//                PlayerView(name: $0)
//            }
//            .navigationTitle("Select a Player")
//            Divider()
//            
//            List {
//                NavigationLink("Show an Interge", value: 29)
//            }
//            .navigationDestination(for: Int.self) {
//                Text("Received Int: \($0)")
//            }
//        }
//    }
//}
    
/*
 如果不需要高度自定义的导航，并且可以在iOS16以及更高的版本运行，强烈建议使用navigationDestination()，因为SwiftUI会懒加载目标视图。
 */

// MARK: -
// MARK: 7、关于Navigation programmatic
/*
 可以使用SwiftUI的NavigationLink以编程的方式将新视图推送到NavigationStack，这意味着可以在准备好时触发导航，而不是仅当点击了button或cell时。从iOS16以及更高的版本，我们可以将一系列的Hashable数据直接传递给NavigationStack，以控制那些数据当前在stack上。
 */

// MARK: 7.1、绑定Path，跟踪显示

//struct ContentView: View {
//    @State private var presentedNumbers = [1, 4, 8]
//    var body: some View {
//        // 跟踪正在显示的数字，并首先将 1、4、8 push到stack上。
//        NavigationStack(path: $presentedNumbers) {
//            List(1..<50) { i in
//                NavigationLink(value: i) {
//                    Label("Row \(i)", systemImage: "\(i).circle")
//                }
//            }
//            .navigationDestination(for: Int.self) {
//                Text("Detail \($0)")
//            }
//            .navigationTitle("Navigation")
//        }
//        
//    }
//}

// MARK: 7.2、在detail页面直接跳转下一个detail（驾考答题需求）
/*
 这种方法很强大，因为可以在任何时候修改NavigationStack来push一个自定义视图。他是一个简单的数组，所以可以add、insert、delete item或者根据显示需求做任务操作。路径数组开始为空，在点击的detail中添加了一个button，可以直接在当前detailpush（n+1）个detail。
 */

//struct ContentView: View {
//    @State private var presentedNumbers = [Int]()
//    var body: some View {
//        NavigationStack(path: $presentedNumbers) {
//            List(1..<50) { i in
//                NavigationLink(value: i) {
//                    Label("Row \(i)", systemImage: "\(i).circle")
//                }
//                .navigationDestination(for: Int.self) { j in
//                    VStack {
//                        Text("Detail \(j)")
//                        
//                        Button("Go to Next") {
//                            presentedNumbers.append(j + 1)
//                        }
//                    }
//                }
//                .navigationTitle("NavigationForNext")
//            }
//        }
//    }
//}

// MARK: 7.3、NavigationPath
/*
 如果将一种很数据类型push到Stack，则可以使用简单数组作为navigation path，但如果需要heterogeneous数据，则可以使用名为NavigationPath的特殊类型擦除包装器。这可以处理任何可hash的数据，所以可以添加一些Staing、Int和custom struct，只要符合hashable都可以
 */

//struct ContentView: View {
//    @State private var navPath = NavigationPath()
//    var body: some View {
//        NavigationStack(path: $navPath) {
//            Button("Jump to random") {
//                navPath.append(Int.random(in: 1..<50))
//            }
//            
//            List(1..<50) { i in
//                NavigationLink(value: "Row \(i)") {
//                    Label("row \(i)", systemImage: "\(i).circle")
//                }
//                .navigationDestination(for: Int.self) { i in
//                    Text("Int detail \(i)")
//                }
//                .navigationDestination(for: String.self) { i in
//                    Text("String detail \(i)")
//                }
//                .navigationTitle("NavigationForHashable")
//            }
//        }
//    }
//}

/*
 可以随便的调整path--在哪里附加了一个value，但如果需要的话，可以一次附加多个值，像旧的UIKit的pop到根视图控制器这样的东西，就像从你的路径中清楚所有东西一样的简单-navPath.removeLast(navpath.count)这样就可以做到。
 */

// MARK: -
// MARK: 8、如何使用Codable协议保存和加载NavigationStach Paths
/*
 当使用NavigationPath对象管理SwiftUI的NavigationStack路径时，使用Codable协议保存和加载整个路径--可以存储完整的NavigationStack并在需要的时间恢复它，这样用户就能准确的回到离开的地方。最好的处理方法是将存储封装在一个单独的ObservableObject类中，这个类可以负责从视图中加载和保存路径数据。
 */

// MARK: 构建PathStore
/*
 例如，这个类在创建时加载一个保存的路径，并在他的NavigationPath属性改变时保存路径
 */

//class PathStore: ObservableObject {
//    @Published var path = NavigationPath() {
//        didSet {
//            save()
//        }
//    }
//    
//    private let savePath = URL.documentsDirectory.appending(path: "SavedPathStore")
//    
//    init() {
//        if let data = try? Data(contentsOf: savePath),
//            let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
//                path = NavigationPath(decoded)
//        }
//    }
//    
//    func save() {
//        guard let representation = path.codable else { return }
//        
//        do {
//            let data = try JSONEncoder().encode(representation)
//            try data.write(to: savePath)
//        } catch {
//            print("Failed to save navigation data")
//        }
//    }
//}

/*
 这是一个整洁的可重用类，只要写入NavigationPath的数据的Codable类型，就可以了。
 */

// MARK: 构建DetailViewCodable_013
/*
 创建一个简单的Detail视图，能够显示用户选择的数字，同时通过选择另一个数字进行更深的导航，然后将其与PathStore类一起使用，以便自动加载和保存导航
 */

//struct DetailViewCodable: View {
//    var id: Int
//    var body: some View {
//        VStack {
//            Text("View \(id)")
//                .font(.largeTitle)
//            NavigationLink("Jump to random", value: Int.random(in: 1...100))
//        }
//    }
//}

/*
 如果运行哪个代码，会看到可以浏览任意多的DetailView级别，数据会自动被存储--可以退出App并返回，导航历史将保持完整。
 */

//struct ContentView: View {
//    @StateObject private var pathStore = PathStore()
//    var body: some View {
//        NavigationStack(path: $pathStore.path) {
//            DetailViewCodable(id: 0)
//                .navigationDestination(for: Int.self, destination: DetailViewCodable.init)
//                .navigationTitle("Navigation")
//        }
//    }
//}

// MARK: -
// MARK: 9、创建一个两列或三列布局用NavigatinSplitView
/*
 SwiftUI的NavigationSplitView允许我们在更大的设备上创建多列布局（iPad macOS和大屏幕的iPhone上），但是当空间有限时，将自动折叠成NavigationStack风格的布局。在最简单的形式中，应该提供侧边栏作为它的第一个尾随闭包，的细节视图作为他的第二个闭包。
 */

// MARK: 9.1、Sidebar + Detail

//struct ContentView: View {
//    var body: some View {
//        NavigationSplitView {
//            List(1..<50) { i in
//                NavigationLink("Row \(i)", value: i)
//            }
//            .navigationDestination(for: Int.self) {
//                Text("Select row \($0)")
//            }
//            .navigationTitle("Split View")
//        } detail: {
//            Text("Please select a row")
//        }
//    }
//}

/*
 在该代码中，“Please select a row”文本仅在用户尚未在侧边栏中进行选择时显示，但是当用户进行选择时，将自动被替换。navigationDestination()修饰符将自动在详细信息区域中显示其目的地视图。更棒的是，当空间有限时，会看到整个东西被平展成一个常规的NavigationStack。
 */

// MARK: 9.2、Sidebar + Content + Detail
/*
 NavigationSplitView可以在布局中添加第三个视图，它可以通过点击Button来显示。
 */

//struct ContentView: View {
//    var body: some View {
//        NavigationSplitView {
//            Text("Sidebar")
//        } content: {
//            Text("Primary")
//        } detail: {
//            Text("Detail View")
//        }
//    }
//}

/*
 SwiftUI将自动显示一个按钮滑动在你的栏从屏幕的一边。
 */

// MARK: -
// MARK: 10、Sidebar的显示和隐藏
/*
 当在macOS上和iPad上使用NavigationSplitView时，SwiftUI使用NavigationSplitViewVisibility的enum来切换显示侧边栏、内容视图和详细视图。有四种模式可以选择：

 在.detailonly模式下，详细视图将占用应用程序的所有可用屏幕空间
 在.doublecolumn模式下，将同时看到内容视图和详细视图
 在.all模式下，如果存在，系统将尝试显示所有三个视图。在没有内容视图（中间视图）的情况下，它将只显示两个。
 在.automatic,系统将自动根据当前设备和方向做最好的UI布局
*/

//struct FFNavigationSplitViewHideAndShow: View {
//    @State private var columnVisibility = NavigationSplitViewVisibility.detailOnly
//    
//    var body: some View {
//        NavigationSplitView(columnVisibility: $columnVisibility) {
//            Text("Sidebar")
//        } content: {
//            Text("Content")
//        } detail: {
//            VStack {
//                Button("Detail Only") {
//                    columnVisibility = .detailOnly
//                }
//                Button("Content and Detail") {
//                    columnVisibility = .doubleColumn
//                }
//                Button("Show All") {
//                    columnVisibility = .all
//                }
//            }
//        }
//    }
//}

/*
 提供colunmVisibility是使用绑定完成的，因为当用户与UI交互时，value将自动更新。
 虽然SwiftUI对分屏视图界面的这三个部分使用了不同的名称，但他们与UIKit的对应部分直接匹配：在UIKit中，侧sidebar时”主要的“，content时“补充的”，detail是“次要的”
 */

// MARK: -
// MARK: 11、在NavigationSplitView中自定义一个宽度的视图
/*
 在其最简单的形式，传入一个固定的值给navigationSplitViewColumnWidth()导致它使用一个固定的大小，未使用更小或更大。
 */

//struct FFNavigationSplitViewCustomize: View {
//    var body: some View {
//        NavigationSplitView {
//            Text("Sidebar")
//                .navigationSplitViewColumnWidth(100)
//        } content: {
//            Text("Content")
//                .navigationSplitViewColumnWidth(200)
//        } detail: {
//            Text("Detail")
//        }
//        
//    }
//}

// MARK: 11.2、navigationSplitViewColumnWidth范围设定大小
/*
 然而，如果想通过最大值、最小值来设定范围，在macOS上，可以提供最小，最理想和最大的size
 */

//struct FFNavigationSplitViewCustomizeMax: View {
//    var body: some View {
//        NavigationSplitView {
//            Text("Sidebar")
//                .navigationSplitViewColumnWidth(min:100, ideal: 200, max: 300)
//        } content: {
//            Text("Content")
//                .navigationSplitViewColumnWidth(min:100, ideal: 200, max: 300)
//        } detail: {
//            Text("Detail")
//        }
//
//    }
//}

// MARK: -
// MARK: 12、自定义NavigationSplitView的显示模式
/*
 SwiftUI的NavigationSplitView有三个选项来控制侧面栏的显示方式，每个选项都可以使用navigationSplitViewStyle()修饰符进行调整。
 */

// MARK: 12.1、.prominentDetail
/*
 第一个是.prominentDetail,它告诉SwiftUI你想让细节视图一直保持完整的大小--侧边栏和内容视图会滑动到Detail视图上，而不是把他推到一边或把它挤得更小。
 */

//struct FFNavigationSplitViewDisplayMode: View {
//    var body: some View {
//        
//        NavigationSplitView {
//            Text("Sidebar")
//        } content: {
//            Text("Content")
//        } detail: {
//            Text("Detail")
//        }
//        .navigationSplitViewStyle(.prominentDetail)
//    }
//}

// MARK: 12.2、.balanced
/*
 第二个选项是.balanced，这将在显示侧边栏或Content栏时减少Detail视图的大小--只需将.prominentDetail切换为.balance
 */

//struct FFNavigationSplitViewDisplayModeBalance: View {
//    var body: some View {
//        NavigationSplitView {
//            Text("Sidebar")
//        } content: {
//            Text("Content")
//        } detail: {
//            Text("Detail")
//        }
//        .navigationSplitViewStyle(.balanced)
//    }
//}

/*
 默认设置是.automatic，这将根据平台的不同而有所不同，在写Text时，在iPhone上变成了.prominentDetail，在iPad上变成.balance
 */

// MARK: -
// MARK: 13、NavigationSplitView主动选择视图优先级
/*
 当有一个NavigationSplitView运行在一个紧凑的size class中。SwiftUI试图推断分屏视图列中哪一个是最优先的显示，这种推断通常是正确的，但可以通过分屏视图设置首选紧凑列来控制它。
 */

//struct FFNavigationSplitViewCompact: View {
//    @State private var preferredColumn = NavigationSplitViewColumn.detail
//    var body: some View {
//        //例如：这段代码强制将detail视图列为首选，从而覆盖了SwiftUI的默认选择
//        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
//            Text("Sidebar View")
//        } detail: {
//            Text("Detail View")
//        }
//    }
//}

/*
 如果提供了一个不存在的值，比如，当只有sidebar和detail，选择content，那么SwiftUI就会选择侧边栏。
 */

// MARK: -
// MARK: 14、在View上创建Inspector
/*
 SwiftUi的inspector()修饰符可以在任何需要的地方添加检查器视图。这就像Xcode一样，检查器添加到UI的后面，并且可以根据需要与NavigationSplitView和NavigationStack一起使用。
 */

// MARK: 14.1、 基本样式
/*
 当按钮被按下时，将显示一个检查器视图。
 */

//struct FFInspector: View {
//    @State private var isShowingInspector = false
//    
//    var body: some View {
//       
//        Button("Hello, world!") {
//            isShowingInspector.toggle()
//        }
//        .font(.largeTitle)
//        .inspector(isPresented: $isShowingInspector) {
//            Text("Inspector View")
//        }
//    }
//}

/*
 当空间很大时，比如使用全屏的iPad应用程序或macOS时，检查器就放在按钮旁边。然而，当空间有限时，例如在iPhone上，检查器作为一个页面向上滑动(present mode)。
 */

// MARK: 14.1、动态调整width
/*
 在支持他的平台上，你可以通过提供一个 (.inspectorColumnWidth(500)) 固定的大小来占用空间，或者通过提供一个.inspectorColumnWidth(min: 50, ideal: 150, max: 200)范围来调整检查器的占用空间。
 */

//struct FFInspectorIdeal: View {
//    @State private var isShowingInspector1 = false
//    
//    var body: some View {
//        Button("Hi, metaBBLv") {
//            isShowingInspector1.toggle()
//        }
//        .font(.largeTitle)
//        .inspector(isPresented: $isShowingInspector1) {
//            Text("Insepctor View BBlv")
//                .inspectorColumnWidth(min:50, ideal: 150, max: 200)
//        }
//    }
//}

