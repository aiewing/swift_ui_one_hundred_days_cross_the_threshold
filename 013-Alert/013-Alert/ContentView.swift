//
//  ContentView.swift
//  013-Alert
//
//  Created by 舒毅文 on 2024/4/19.
//

import SwiftUI

/*
 https://juejin.cn/post/7268112661472198668
 */

#Preview {
    ContentView()
}

// MARK: -
// MARK: 1、Alert
/*
 SwiftUI可以通过alert()修饰符向用户显示弹出框，取决于是针对iOS15或更高的版本，还是需要支持iOS13和14。API有一些区别。在iOS15，要显示alert，先创建一些bool状态来确定alert是否应该可见，然后将其与希望在alert中显示的所有按钮一起附加到alert()修饰符。所有按钮在点击时都会关闭alert，因此可以理解为关闭是一个空操作。
 */

// MARK: 1.1、基础Alert
/*
 创建一个带有“OK”的alert
 */

//struct ContentView: View {
//    @State private var showingAlert = false
//    var body: some View {
//        Button("Show alert") {
//            showingAlert = true
//        }
//        .alert("Important message", isPresented: $showingAlert) {
//            Button("OK", role: .cancel) {}
//        }
//    }
//}

/*
 像这样显示alert会在点击按钮时自动将showingAlert设置为false。可以根据需求创建尽可能多的按钮，如果没有创建按钮，那么会自动得到一个默认的“OK”来关闭alert。因为这些都是SwiftUI按钮，可以分配其他的role，比如，.destructive来让系统对他们进行适当的样式化。
 */

// MARK: 1.2、多个Button的Alert
/*
 创建带有多个Button的alert,要显示alert，第一种方法是定义某种可绑定条件。以确定alert是否应该可见。然后将其附加到主视图上，一旦其条件为真，主视图就会显示alert。
 */

//struct ContentView: View {
//    @State private var showingAlert = false
//    var body: some View {
//        Button("Show Alert For Buttons") {
//            showingAlert = true
//        }
//        .alert("Important message", isPresented: $showingAlert) {
//            Button("First", role: .destructive) { }
//            Button("Second", role: .destructive) { }
//            Button("Third", role: .destructive) { }
//            Button("Cancel", role: .cancel) { }
//        }
//    }
//}

// MARK: 1.3、带有message的Alert
/*
 例如，这段代码创建了一个showingAlert的bool值，它跟踪防晒信息是否应该被显示，当按钮被点击时将Bool值设置为true，然后使用该bool值创建并附加一个alert视图，一边在按钮被点击时使用。
 */

//struct ContentView: View {
//    @State private var showingAlert = false
//    var body: some View {
//        Button("Show Alter") {
//            showingAlert = true
//        }
//        .alert(isPresented: $showingAlert) {
//            Alert(title: Text("metabblb"), message: Text("War sunsre"), primaryButton: .default(Text("Got it!")), secondaryButton: .default(Text("hha")))
//        }
//    }
//}

// MARK: 1.4、通过Identifiable可选状态创建Alert
/*
 创建Alert的第二种方法是绑定到一些符号Identifiable的可选状态，这将导致在对象的值发生变化时弹出alert。这种方法有两个有优点：

 可以在运行时附加任何对象，因此alert可以显示任意数量的不同数据块。
 SwiftUI会在可选值有值的时候自动展开，这样就可以在想要显示alert的时候确定他的存在。不需要自己检查和展开。
 */

//struct TVShow: Identifiable {
//    var id: String { name }
//    let name: String
//}
//
//struct ContentView: View {
//    @State private var selectedShow: TVShow?
//    var body: some View {
//        Divider()
//        VStack(spacing: 20) {
//            Text("What is your favorite TV Show?")
//                .font(.largeTitle)
//            Button("Select Ted Lasso") {
//                selectedShow = TVShow(name: "Ted Lasso")
//            }
//            Button("Select Bridgerton") {
//                selectedShow = TVShow(name: "Bridgerton")
//            }
//        }.alert(item: $selectedShow) { show in
//            Alert(title: Text(show.name), message: Text("Great choice!"), dismissButton: .cancel())
//        }
//    }
//}

// MARK: -
// MARK: 2、Alert内创建TextFiele
/*
 SwiftUI的alert可以创建一个或多个TextField或SecureField视图，提示用户直接输入。
 */

// MARK: 2.1、基础样式
/*
 可以添加一个TextField，让用户在alert中输入自己的名字
 */

//struct ContentView: View {
//    @State private var showingAlert = false
//    @State private var name = ""
//    var body: some View {
//        Button("Enter name") {
//            showingAlert.toggle()
//        }
//        .alert("Enter your name", isPresented: $showingAlert) {
//            TextField("username", text: $name)
//            Button("OK", action: submit)
//        } message: {
//            Text("Xcode will print whatever you type")
//        }
//    }
//    
//    func submit() {
//        print("Your entered \(name)")
//    }
//}

// MARK: 2.2、混合TextField和SecureText
/*
 可以添加尽可能多的字段，混合TextField和SecureText根据需求。例如，这显示了一个登陆提示，要求用户在alert中输入用户名和密码。
 */

//struct ContentView: View {
//    @State private var isAuthentication = false
//    @State private var username = ""
//    @State private var password = ""
//    var body: some View {
//        Button("Please enter you Authentication") {
//            isAuthentication.toggle()
//        }
//        .alert("Login in", isPresented: $isAuthentication) {
//            TextField("username", text: $username)
//            SecureField("password", text: $password)
//            Button("OK", action: authenticate)
//            Button("Cancel", role: .cancel) { }
//        } message: {
//            Text("Please enter your user and Password")
//        }
//    }
//    
//    func authenticate() {
//        if username == "aie" && password == "123456" {
//            print("login successed")
//        } else {
//            print("login failed")
//        }
//    }
//}

// MARK: -
// MARK: 3、Alert-Button添加action
/*
 经常需要将操作附加到Button上，以便在点击按钮时执行特定的操作，要做到这一点，给按钮附加一个闭包，当他被点击时将被调用。
 */

//struct ContentView: View {
//    @State private var showingAlert = false
//    var body: some View {
//        Button("Show Alert") {
//            showingAlert = true
//        }
//        .alert(isPresented: $showingAlert) {
//            Alert(title: Text("你确定要删除数据吗？"), message: Text("这是一个不可逆操作。"), primaryButton: .destructive(Text("删除"), action: {
//                print("正在删除")
//            }), secondaryButton: .cancel(Text("取消")))
//        }
//    }
//}

/*
 如果要添加两个以上的Button，使用Sheet。
 */

// MARK: -
// MARK: 4、如何在一个视图中显示多个alert
/*
 SwiftUI使得显示单个alert相对容易，但是如果试图从一个视图中显示两个或更多的alert，就变得很困难，会出现一个alert好用，另外一个不好用。要解决这个问题，需要确保为每个视图附加不超过一个alert修饰符。看起来可能有一些限制，只需记住一点，不需要将alert附加到同一个视图，可以将他们附加到任何地方。事实上，可能会发现将他们直接附加到显示他们的View上更准确。
 
 可以编写一些代码来定义两个@State属性，每个属性控制显示的alert，不是将两个alert修饰符附加到同一个VStack上，而是将他们分别附加到负责显示该alert的按钮上。
 */

//struct ContentView: View {
//    @State private var showingAlert1 = false
//    @State private var showingAlert2 = false
//    
//    var body: some View {
//        VStack {
//            Button("Show 1") {
//                showingAlert1 = true
//            }
//            .alert(isPresented: $showingAlert1) {
//                Alert(title: Text("One"), message: nil, dismissButton: .cancel())
//            }
//            
//            Button("Show 2") {
//                showingAlert2 = true
//            }
//            .alert(isPresented: $showingAlert2, content: {
//                Alert(title: Text("Two"), message: nil, dismissButton: .cancel())
//            })
//        }
//    }
//}

/*
 如果尝试将alert()修饰符都移动到VStack中，你就会发现只有一个有效。
 */

// MARK: -
// MARK: 5、如何显示Alert的Sheet
/*
 SwiftUI可以使用confirmationDialog()修饰符向用户显示一个选项。要使用confirmationDialog()创建sheet，需要提供一些titleText、一个绑定来决定何时显示Action的sheet以及你是否想要标题文本，如果你没有指定，SwiftUI将根据上下文来为你决定。
 */

// MARK: 5.1、基础样式

//struct ContentView: View {
//    @State private var showingOptions = false
//    @State private var selection = "None"
//    
//    var body: some View {
//        VStack {
//            Text(selection)
//            Button("Confirm paint color") {
//                showingOptions = true
//            }
//            .confirmationDialog("Select a color", isPresented: $showingOptions, titleVisibility: .visible) {
//                Button("Red") {
//                    selection = "Red"
//                }
//                
//                Button("Green") {
//                    selection = "Green"
//                }
//                
//                Button("Blue") {
//                    selection = "Blue"
//                }
//            }
//        }
//    }
//}

// MARK: 5.2、For循环创建
/*
 这个API对每个Action使用一个标准的SwiftUI按钮，所以可以附加一个role，比如.desturective,让SwiftUI给它适当的上色。可以使用ForEach将这些动作分解成一个简单的循环。
 */

//struct ContentView: View {
//    @State private var showingOptions2 = false
//    @State private var selection2 = "None"
//    
//    var body: some View {
//        VStack {
//            Text(selection2)
//            Button("Confirm paint color 2") {
//                showingOptions2 = true
//            }
//            .confirmationDialog("Select a color", isPresented: $showingOptions2, titleVisibility: .visible) {
//                ForEach(["Red", "Green", "Blue"], id: \.self) { color in
//                    Button(color) {
//                        selection2 = color
//                    }
//                }
//            }
//        }
//    }
//}

// MARK: -
// MARK: 6、创建Menu
/*
 SwiftUI提供了ContextMenu修饰符，用于在app中创建弹出式菜单。在iOS中，这通常是长按触发的，但它的工作原理与macOS上的右键一样。contextMenu是由按钮组成的，每个按钮都有自己的动作、文本和图标。文本和图标可以直接在按钮中设置。因为SwiftUI将提供一个隐式的HStack来确保他们符合系统标准的外观和感觉。
 所以，如果我们想要一个上下文menu附加到一些文本上，可以为菜单提供两个按钮。
 */

//struct ContentView: View {
//    var body: some View {
//        Text("Options")
//            .contextMenu(ContextMenu(menuItems: {
//                Button {
//                    print("Change country setting")
//                } label: {
//                    Label("Choose Country", systemImage: "globe")
//                }
//                
//                Button(action: {
//                    print("Enable geolocation")
//                }, label: {
//                    Label("Detect Location", systemImage: "location.circle")
//                })
//            }))
//    }
//}

/*
 要在iOS上尝试一下，长按“Options”文本弹出来的菜单，或者在macOS上右键。此修饰符可以附加到任何SwiftUI视图。
 */

// MARK: -
// MARK: 7、使用appStoreOverlay()推荐另一个应用
/*
 SwiftUI给了一个专门的修改器，可以推荐AppStore上的其他应用，这是一个很好的交叉推荐的方式。如果你使用的是App Clips，这一点尤其有用，一旦用户完成了主要操作，你就可以从App Clips中推荐完整的应用。这个修饰符需要一些状态来观察，这将决定App Store覆盖是否激活，以及SDKOverlay。确定要推荐哪个应用程序AppConfiguration。
 appStoreOverlay在macOS上不可用。
 
 例如，当按钮被按下时，它会推荐一个特定的App
 */

//import StoreKit
//struct ContentView: View {
//    @State private var showRecommended = false
//    
//    var body: some View {
//        Button("Show Recommended App") {
//            showRecommended.toggle()
//        }
//        .appStoreOverlay(isPresented: $showRecommended) {
//            SKOverlay.AppConfiguration(appIdentifier: "1440611372", position: .bottom)
//        }
//    }
//}

/*
 需要导入StoreKit框架来使用SKOverlay。
 */

// MARK: -
// MARK: 8、Menu的显示
/*
 SwiftUI提供了一个专门的视图来显示按钮弹出时菜单。这可以通过简单的字符串或使用自定义视图创建，但无论哪种方式，都可以使用各种按钮来控制想要的菜单中显示的内容。在macOS上，菜单会自动呈现下拉按钮。
 */

// MARK: 8.1、基础样式

//struct ContentView: View {
//    var body: some View {
//        Menu("Options") {
//            Button("Order Now") {
//                print("Order Now")
//            }
//            Button("Adjust Order") {
//                print("Adjust Order")
//            }
//            Button("Cancel") {
//                print("Cancel")
//            }
//        }
//    }
//}

// MARK: 8.2、嵌套menu
/*
 也可以在菜单中放置菜单，这将导致iOS在点击第一个选项的时候弹出第二个菜单
 */

//struct ContentView: View {
//    var body: some View {
//        Menu("Options") {
//            Button("Order Now") {
//                print("Order Now")
//            }
//            Menu("Advanced") {
//                Button("Rename") {
//                    print("Rename")
//                }
//                Button("Delay") {
//                    print("Delay")
//                }
//            }
//            Button("Adjust Order") {
//                print("Adjust Order")
//            }
//            Button("Cancel") {
//                print("Cancel")
//            }
//        }
//        //如果你想使用一些文本和图标自定义Label
//        Menu {
//            Button("Order Now") {
//                print("Order Now")
//            }
//            Button("Adjust Order") {
//                print("Adjust Order")
//            }
//        } label: {
//            Label("Options", systemImage: "paperplane")
//        }
//    }
//}

// MARK: 8.3、丰富样式
/*
 如果想使用一些文本和图标自定义Label
 */

//struct ContentView: View {
//    var body: some View {
//        Menu {
//            Button("Order Now") {
//                print("Order Now")
//            }
//            Button("Adjust Order") {
//                print("Adjust Order")
//            }
//        } label: {
//            Label("Options", systemImage: "paperplane")
//        }
//    }
//}

// MARK: -
// MARK: 9、Picker的Menu
/*
 SwiftUI的Picker视图有一个名为.menu的专用样式，它显示了一个弹出式菜单的选项，选择器的标签显示为一个可点击的按钮。菜单本身将在当前选择的选项旁边自动显示一个复选标记，并可以根据选择器在屏幕上的位置向上或向下显示。
 */

//struct ContentView: View {
//    @State private var selection = "Red"
//    let colors = ["Red", "Green", "Blue", "Black", "Tartan"]
//    
//    var body: some View {
//        VStack {
//            Picker("Select a paint color", selection: $selection) {
//                ForEach(colors, id: \.self) {
//                    Text($0)
//                }
//            }
//            .pickerStyle(.menu)
//            
//            Text("Selected color: \(selection)")
//        }
//    }
//}
