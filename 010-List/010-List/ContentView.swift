//
//  ContentView.swift
//  010-List
//
//  Created by 舒毅文 on 2024/3/19.
//

import SwiftUI

/*
 https://juejin.cn/post/7265153693140713511
 */


#Preview {
    ContentView()
}

// MARK: -
// MARK: 1、List详细解释
/*
 SwiftUI的List视图类似于UITableView，可以根据需求显示静态的列表视图。对比于UITableView使用也更加简单，不需要通过Storyboard或者在代码中register，也不需要告诉它有多少行，也不需要去手动排列和配置cell。
 
 相反，SwiftUI的List是为可组合性而设计的--设计成能够从小的东西构建更大的东西。所以，SwiftUI没有一个大的视图控制器，而是通过构建小的视图进行堆叠。
 
 就代码大小而言，如果不考虑其他因素，差异是惊人的--可以删除几乎所有想象中的UITableView的视图代码，但仍然能得到那种很好的UI和感觉。
 */

//struct ContentView: View {
//    var body: some View {
//        List {
//            Text("hello world!")
//        }
//    }
//}

// MARK: -
// MARK: 2、创建static List
/*
 要创建项目的静态列表，首先要定义列表中每一行应该是什么样子。这是一个与其他View一样的View，计划在行中显示的数据提供任何参数。一旦有了row，就可以创建一个List视图，该视图可以根据需要创建任意多的行。
 */

//struct Pizzeria: View {
//    let name: String
//    var body: some View {
//        Text("Restaurant: \(name)")
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        List {
//            Pizzeria(name: "Aie")
//            Pizzeria(name: "Wing")
//        }
//    }
//}

// MARK: -
// MARK: 3、创建Dynamic List
/*
 为了处理动态项，必须告诉SwiftUI它如何识别哪个item是哪个。这可以通过手动指定标识属性或使用可识别的协议(Identifiable)来完成。协议只有一个要求，即类型必须具有某种类型的id值，SwiftUI可以使用id来标记。
 */

//struct Restaurant: Identifiable {
//    let id = UUID()
//    let name: String
//}
//
//struct RestaurantRow: View {
//    let restaurant: Restaurant
//    var body: some View {
//        Text("Come and eat at \(restaurant.name)")
//    }
//}
//
//struct ContentView: View {
//    let arr = [
//        Restaurant(name: "111"),
//        Restaurant(name: "222"),
//        Restaurant(name: "333"),
//    ]
//    var body: some View {
//        List(arr) {
//            RestaurantRow(restaurant: $0)
//        }
//    }
//}

// MARK: -
// MARK: 4、删除List中的cell
/*
 SwiftUI提供了deleteDisabled()修饰符可以从列表中删除cell。如果只想滑动从数组中删除项，而不添加任何额外的逻辑，那么简单的方法非常有效。使用与列表的数据绑定，并传入editActions参数
 */

// MARK: 4.1、基础侧滑删除

//struct ContentView: View {
//    @State private var users = ["111", "222", "333", "444"]
//    var body: some View {
//        List($users, id: \.self, editActions: .delete) { $user in
//            Text(user)
//        }
//    }
//}

// MARK: 4.2、deleteDisabled()条件删除

//struct ContentView: View {
//    @State private var users = ["111", "222", "333", "444"]
//    var body: some View {
//        List($users, id: \.self, editActions: .delete) { $user in
//            Text(user)
//                .deleteDisabled(users.count < 2)
//        }
//    }
//}

// MARK: 4.3、onDelete删除
/*
 通常会想要调用Swift的remove(at Offsets:)方法从你的序列中删除行。因为SwiftUI正在监视你的状态，你所做的任何更改都会自动反应在你的UI中。例如，创建一个包含三个项目的ContentView结构体，然后附加一个onDelete(perform:)修饰符，从列表中删除row
 */

//struct ContentView: View {
//    @State private var users = ["111", "222", "333"]
//    
//    func delete(at offsets: IndexSet) {
//        users.remove(atOffsets: offsets)
//    }
//    
//    var body: some View {
//        List {
//            ForEach(users, id: \.self) { user in
//                Text(user)
//            }
//            .onDelete(perform: { indexSet in
//                delete(at: indexSet)
//            })
//            .navigationTitle("Users")
//        }
//    }
//}

/*
 onDelete()作为ForEach的修饰符，不能直接用于List，因为此修饰符是在DynamicViewContent中定义的
 */

// MARK: -
// MARK: 5、移动List中的cell
/*
 SwiftUI的moveDisabled()修饰符可以移动行,类似于deleteDisabled()修饰符
 */

//struct ContentView: View {
//    @State private var users = ["111", "222", "333", "444"]
//    @State private var users1 = ["aaa", "bbb", "ccc"]
//    
//    var body: some View {
//        List($users, id: \.self, editActions: .move) { $user in
//            Text(user)
//        }
//        
//        List($users, id: \.self, editActions: .move) { $user in
//            Text(user)
//                .moveDisabled(user == "111")
//        }
//        
//        NavigationStack {
//            List {
//                ForEach(users, id: \.self) {
//                    Text($0)
//                }
//                .onMove(perform: { indices, newOffset in
//                    move(from: indices, to: newOffset)
//                })
//            }
//            .toolbar {
//                EditButton()
//            }
//        }
//    }
//    
//    func move(from source: IndexSet, to destination: Int) {
//        users.move(fromOffsets: source, toOffset: destination)
//    }
//}

// MARK: -
// MARK: 6、List添加Section
/*
 创建一个cell备用
 */

struct TaskRow: View {
    var body: some View {
        Text("Task data goes here")
    }
}

// MARK: 6.1、创建附加header的section

//struct ContentView: View {
//    var body: some View {
//        List {
//            Section {
//                TaskRow()
//                TaskRow()
//                TaskRow()
//            } header: {
//                Text("Tmportant tasks")
//            }
//            
//            Section {
//                TaskRow()
//                TaskRow()
//                TaskRow()
//            } header: {
//                Text("Other tasks")
//            }
//        }
//    }
//}

// MARK: 6.2、创建附加footer的section

//struct ContentView: View {
//    var body: some View {
//        List {
//            Section {
//                Text("111")
//                Text("111")
//                Text("111")
//            } footer: {
//                Text("End")
//            }
//        }
//    }
//}

// MARK: 6.3、headerProminence()修改section的header
/*
 默认情况下，section header匹配默认的iOS样式，可以通过headerProminence()修饰符更改
 */

//struct ContentView: View {
//    var body: some View {
//        List {
//            Section {
//                TaskRow()
//            } header: {
//                Text("Header")
//            }
//            .headerProminence(.increased)
//        }
//    }
//}

// MARK: -
// MARK: 7、设置cell的背景颜色
/*
 SwiftUI有一个专门的修饰符来设置cell的背景视图，是listRowBackground()。它接受任何类型的视图--包括颜色、图像和形状。
 */

//struct ContentView: View {
//    var body: some View {
//        List {
//            ForEach(0..<10) {
//                Text("Row \($0)")
//            }
//            .listRowBackground(Color.green)
//        }
//    }
//}

// MARK: -
// MARK: 8、通过listStyle创建List
/*
 SwiftUI的列表视图有一个listStyle()修饰符来控制list的样式：

 grouped
 insetGrouped
 */

//struct ExampleRow: View {
//    var body: some View {
//        Text("Example Row")
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        List {
//            Section {
//                ExampleRow()
//                ExampleRow()
//                ExampleRow()
//            } header: {
//                Text("Examples")
//            }
//        }
//        .listStyle(.grouped)
//        
//        List(0..<100) {
//            Text("Row \($0)")
//        }
//        .listStyle(.insetGrouped)
//    }
//}

// MARK: -
// MARK: 9、创建可折叠的List
/*
 SwiftUI的List视图有一个增强初始化器，可以创建带有子节点的扩展--以可以点击的箭头的方式呈现，当点击时，箭头转动，显示子节点。要使用这种形式的List，需要有精确的数据，数据模型应该拥有相同类型的可选子节点，这样可以创建树。通常情况下，可能会从JSON或类似的地方加载这类数据。
 */

//struct Bookmark: Identifiable {
//    let id = UUID()
//    let name: String
//    let icon: String
//    let items: [Bookmark]?
//    
//    static let apple = Bookmark(name: "Apple", icon: "1.circle", items: nil)
//    static let bbc = Bookmark(name: "BBC", icon: "square.and.pencil", items: nil)
//    static let swift = Bookmark(name: "Swift", icon: "bolt.fill", items: nil)
//    static let twitter = Bookmark(name: "Twitter", icon: "mic", items: nil)
//    
//    static let example1 = Bookmark(name: "Favorites", icon: "star", items: [Bookmark.swift, Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
//    static let example2 = Bookmark(name: "Recent", icon: "timer", items: [Bookmark.apple, Bookmark.bbc, Bookmark.twitter])
//    static let example3 = Bookmark(name: "Recommended", icon: "hand.thumbsup", items: [Bookmark.apple, Bookmark.swift, Bookmark.bbc,  Bookmark.twitter])
//    
//}
//
//struct ContentView: View {
//    let items: [Bookmark] = [.example1, .example2, .example3]
//    var body: some View {
//        List(items, children: \.items) { row in
//            HStack {
//                Image(systemName: row.icon)
//                Text(row.name)
//            }
//        }
//    }
//}

// MARK: -
// MARK: 10、滚动到list中的特定cell
/*
 让SwiftUI的List移动来显示特定的行。应该把它嵌入到ScrollViewReader中。这在其代理上提供了一个scrollTo()方法，该方法可以移动到列表中的任意行，只需要提供id和锚点。
 */

// MARK: 10.1、scrollTo

//struct ContentView: View {
//    var body: some View {
//        ScrollViewReader(content: { proxy in
//            VStack {
//                Button("Jump to #50") {
//                    proxy.scrollTo(50)
//                }
//                
//                List(0..<100, id: \.self) { i in
//                    Text("Example \(i)")
//                        .id(i)
//                }
//            }
//        })
//    }
//}

// MARK: 10.2、anchor

//struct ContentView: View {
//    var body: some View {
//        ScrollViewReader(content: { proxy in
//            VStack {
//                Button("Jump to #50") {
//                    proxy.scrollTo(50, anchor: .top)
//                }
//                
//                List(0..<100, id: \.self) { i in
//                    Text("Example \(i)")
//                        .id(i)
//                }
//            }
//        })
//    }
//}

// MARK: 10.3、withAnimation
/*
 将锚点标记为.top，以动画效果过渡
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollViewReader(content: { proxy in
//            VStack {
//                Button("Jump to #50") {
//                    withAnimation {
//                        proxy.scrollTo(50, anchor: .top)
//                    }
//                }
//                
//                List(0..<100, id: \.self) { i in
//                    Text("Example \(i)")
//                        .id(i)
//                }
//            }
//        })
//    }
//}

// MARK: -
// MARK: 11、List支持多选
/*
 SwiftUI的list支持多选，但仅限于编辑模式之下。为了支持多选，首先添加一个与列表中使用的类型相同的可选属性集合。例如，如果一个整数list，那么将有一个可选的Int。使用他的选择参数将它传递给list，确保list处于编辑模式。
 */

//struct ContentView: View {
//    @State private var selection = Set<String>()
//    let names = ["BBLv", "Cyril", "Lana", "Mallory", "Sterling"]
//    var body: some View {
//        NavigationStack {
//            List(names, id: \.self, selection: $selection) { name in
//                Text(name)
//            }
//            .navigationTitle("List Selction")
//            .toolbar {
//                EditButton()
//            }
//        }
//    }
//}

// MARK: -
// MARK: 12、List的分隔符的隐藏和颜色
/*
 wiftUI提供了两个修饰符来控制其列表中行分隔符的外观：

 listRowSeparator()用于控制行分隔符是否可见，
 listRowSeparatorTint()用于控制分隔符的颜色
 */

//struct ContentView: View {
//    var body: some View {
//        // 隐藏分隔符
//        List {
//            ForEach(0..<100) { index in
//                Text("Row \(index)")
//                    .listRowSeparator(.hidden)
//            }
//        }
//        
//        // 设置分隔符颜色
//        List {
//            ForEach(1..<100) { index in
//                Text("Row \(index)")
//                    .listRowSeparatorTint(.red)
//            }
//        }
//    }
//}

// MARK: -
// MARK: 13、List的下拉刷新
/*
 SwiftU的refreshable()修饰符可以附加到list上，当发生拖拽且有一段距离时触发。只要的你的代码完成运行，iOS会自动显示一个菊花。
 */

//struct NewsItem: Decodable, Identifiable {
//    let id: Int
//    let title: String
//    let strap: String
//}
//
//struct ContentView: View {
//    @State private var news = [
//        NewsItem(id: 0, title: "Want the lastest news?", strap: "Pull to refresh!")
//    ]
//    var body: some View {
//        NavigationStack {
//            List(news) { item in
//                VStack(alignment: .leading, content: {
//                    Text(item.title)
//                        .font(.headline)
//                    Text(item.strap)
//                        .foregroundStyle(.secondary)
//                })
//            }
//            .refreshable {
//                
//            }
//        }
//    }
//}

// MARK: -
// MARK: 14、Cell添加自定义侧滑Button
/*
 SwiftUI的swipeActions()修饰符可以添加一个或多个滑动button到cell，可选的控制它们属于哪一边，以及它们是否应该被触发使用一个完整的滑动。
 */

// MARK: 14.1、swipeActions
/*
 button使用了tint进行了作色，如果未使用，默认是灰色的
 */

//struct ContentView: View {
//    var body: some View {
//        List {
//            Text("11111")
//                .swipeActions {
//                    Button("Order") {
//                        print("111111")
//                    }
//                }
//            Text("2222")
//                .swipeActions {
//                    Button("Burn") {
//                        print("2222")
//                    }
//                }
//                .tint(.red)
//        }
//    }
//}

// MARK: 14.2、allowsFullSwipe
/*
 默认情况下，如果滑动足够远，将自动触发第一个滑动动作。如果想要禁用，在创建滑动时将allowsFullSwipe设置为false。
 */

//struct ContentView: View {
//    let friends = ["Antoine", "Bas", "Curt", "Dave", "Erica"]
//    var body: some View {
//        List {
//            ForEach(friends, id: \.self) { friend in
//                Text(friend)
//                    .swipeActions(allowsFullSwipe:false) {
//                        Button {
//                            print("Muting conversation")
//                        } label: {
//                            Label("Mute", systemImage: "bell.slash.fill")
//                        }
//                        .tint(.indigo)
//                        
//                        Button(role: .destructive) {
//                            print("Deleting conversation")
//                        } label: {
//                            Label("Delete", systemImage: "trash.fill")
//                        }
//                        
//                    }
//            }
//            
//        }
//    }
//}

/*
 对于真正删除性质的按钮，应该通过role设定，避免通过tint指定红色
 */

// MARK: 14.3、swipeActions(edge: .leading)
/*
 如果想要在cell的两端都添加不同的滑动操作，只需要了用两次swipeActions在边缘
 */

//struct ContentView: View {
//    @State private var total = 0
//    var body: some View {
//        List {
//            Section {
//                ForEach(0..<10) { i in
//                    Text("\(i)")
//                        .swipeActions(edge: .leading) {
//                            Button {
//                                total += i
//                            } label: {
//                                Label("Add \(i)", systemImage: "plus.circle")
//                            }
//                            .tint(.indigo)
//                        }
//                        .swipeActions(edge: .trailing) {
//                            Button {
//                                total -= 1
//                            } label: {
//                                Label("Subtract \(i)", systemImage: "minus,circle")
//                            }
//                        }
//                }
//            } header: {
//                Text("Total: \(total)")
//            }
//            .headerProminence(.increased)
//        }
//    }
//}

// MARK: -
// MARK: 15、List的Binding
/*
 SwiftUI可以直接从绑定中创建List或ForEach，然后提供内容闭包，显示的数据中的每个元素都提供单独的绑定。
 */

//struct UserA: Identifiable {
//    let id = UUID()
//    let name: String
//    var isContracted = false
//}
//
//struct ContentView: View {
//    @State private var users = [
//        UserA(name: "111"),
//        UserA(name: "222"),
//        UserA(name: "333")
//    ]
//    var body: some View {
//        List($users) { $user in
//            HStack {
//                Text(user.name)
//                Spacer()
//                Toggle("User has been contacted", isOn: $user.isContracted)
//                    .labelsHidden()
//            }
//        }
//    }
//}

/*
 以这种方式使用绑定是修改列表的最有效方式，因为他不会在只有一个项更改时导致整个视图重新加载
 */

