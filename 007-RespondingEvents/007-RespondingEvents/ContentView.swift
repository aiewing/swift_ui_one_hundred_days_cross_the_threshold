//
//  ContentView.swift
//  007-RespondingEvents
//
//  Created by 舒毅文 on 2024/2/26.
//

import SwiftUI

#Preview {
    ContentView()
}

// MARK: -
// MARK: 1、使用scenePhase检测App何时移动至前台或后台
/*
 SwiftUI提供了一个scenePhase环境变量，当你的App在前台、后台和非活跃状态之间移动时，该环境变量会自动更新。可以在在App的任何视图中观察这些内容。
 */

//struct ContentView: View {
//    @Environment(\.scenePhase) var scenePhase
//    @State private var currentState = "Active"
//    var body: some View {
//        // 可以添加在函数体中观察，也可以用onChange()直接观察
//        Text(currentState)
//            .onChange(of: scenePhase) { oldPhase, newPhase in
//                if newPhase == .inactive {
//                    currentState = "Inactive"
//                    print("Inactive")
//                } else if newPhase == .active {
//                    currentState = "Active"
//                    print("active")
//                } else if newPhase == .background {
//                    currentState = "Background"
//                    print("background")
//                }
//            }
//    }
//}

/*
 App共有三种状态

 Active：在前台，标记为活跃状态，正在使用
 Background：在后台。
 Inactive：在前台与后台之间，应该属于系统桌面控制状态，App可见，但是不可交互，标记为非活跃状态。在多任务窗口时最常见。
 */

// MARK: 2、响应Life cycle事件
/*
 onAppear()
 onDisappear()
 */

//struct FFDetailView: View {
//    var body: some View {
//        VStack {
//            Text("Second View")
//        }
//        .onAppear {
//            print("FFDetailView appeared!")
//        }
//        .onDisappear {
//            print("FFDetailView disappeared!")
//        }
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            VStack {
//                NavigationLink {
//                    FFDetailView()
//                } label: {
//                    Text("Hi, BBLv")
//                }
//            }
//            .onAppear {
//                print("ContentView appeared!")
//            }
//            .onDisappear {
//                print("ContentView disappeared!")
//            }
//        }
//    }
//}

// MARK: -
// MARK: 3、TabView
/*
 控制App的启动时加载哪个视图,当你创建一个SwiftUI项目时，Xcode将自动创建一个与你项目同名的Swift文件，该文件用于引导你的App加载第一个画面。
 */

//struct FFFirstView: View {
//    var body: some View {
//        Text("First")
//    }
//}
//
//struct FFSecondView: View {
//    var body: some View {
//        Text("Second")
//    }
//}
//
//struct FFThirdView: View {
//    var body: some View {
//        Text("Third")
//    }
//}
//
//struct FFFourView: View {
//    var body: some View {
//        Text("Four")
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        TabView {
//            FFFirstView()
//                .tabItem { Label("First", systemImage: "moonphase.first.quarter") }
//            FFSecondView()
//                .tabItem { Label("Second", systemImage: "moonphase.first.quarter") }
//            FFThirdView()
//                .tabItem { Label("Third", systemImage: "moonphase.first.quarter") }
//            FFFourView()
//                .tabItem { Label("four", systemImage: "moonphase.first.quarter") }
//        }
//    }
//}

// MARK: -
// MARK: 4、在应用程序启动的时候运行代码
/*
 SwiftUI应用程序生命周期，你的应用程序将通过应用程序协议的结构体启动。使用WindowGroup、DocumentGroup类似的工具创建初始视图，但因为它在你任何的实际视图之前创建的，所以这是在应用程序启动时运行代码的完美位置。
 
 例如：如果你想设置一些初始UserDefaults值，那么应用程序的init()是调用register(defaults:)的好地方。此方法设置默认值，UserDefaults的初始值仅在设置它们之前存在，一旦你提供了自己的值，这些值不再使用，并且这些初始值也会在以下app退出时消失。
 */

//struct FFModifierApp: App {
//    // initializer()在body属性之前被调用，所以它在ContentView之前被调用，因此，你在ContentView中读取UserDefaults的任何地方都已经有了你的默认值。
//    init() {
//        //每次启动时注册初始UserDefaults值
//        UserDefaults.standard.register(defaults: [
//            "name": "Taylor Swift",
//            "highScore": 10
//        ])
//    }
//    
//    var body: some Scene {
//        WindowGroup {
//            FFLaunchesCode()
//        }
//    }
//}

/*
 使用@AppStorage读取name的值。
 */

//struct FFLaunchesCode: View {
//    // 一种属性包装器类型，它反映UserDefaults中的值，并在该用户默认值的值更改时使视图无效。
//    @AppStorage("name") var name = "Anonymous"
//    var body: some View {
//        // 当通过@AppStorage属性包装器声明的变量，只有当没register默认值的时候才用。如果有默认值，就使用默认的。
//        Text("Your name is \(name).")
//    }
//}

// MARK: -
// MARK: 5、给SwiftUI App添加一个AppDelegate
/*
 SwiftUI应用启动时使用一个符合App协议的自定义结构体，但有时你可能想要使用UIApplicationDelegate功能--理推送通知的注册，响应内存警告，检测时间变化等等。
 */

//要做到这一点，首先创建一个自定义类，继承自NSObject并遵守UIApplicationDelegate协议。
//class Appdelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        print("applicationDidFinishLaunching")
//        return true
//    }
//}
//
//struct FFModifierApp: App {
//    
//    //使用UIApplicationDelegateAdaptor属性包装器来告诉SwiftUI它应该使用你的AppDelegate类作为delegate
//    @UIApplicationDelegateAdaptor(Appdelegate.self) var appDelegate
//    
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

// MARK: -
// MARK: 6、如何更改设备的rotation
/*
 SwiftUI没有内置的方法来检测用户在纵向和横向之间旋转设备，但我们可以通过响应UIDevice使用自定义修改器来创建一个UIDevice.orientationDidChangeNotification通知。
 三个步骤：

 1. 创建一个自定义视图修饰器，用于监视方向变化，并在发生变化时运行毁掉函数。这不是必须的，但我们会让回调接受一个UIDeviceOrientation作为他的唯一的参数，以防你需要知道当前的朝向。
 2. 将视图修饰符包装在视图扩展中，以便更容易调用
 3. 在选择的视图中使用自定义修饰符
 */

// MARK: 创建视图修饰器

//struct DeviceRotationViewMofifier: ViewModifier {
//    let action: (UIDeviceOrientation) -> Void
//    
//    func body(content: Content) -> some View {
//        content
//            .onAppear()
//            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification), perform: { _ in
//                action(UIDevice.current.orientation)
//            })
//    }
//}

/*
 在编写视图修饰符时，除非你先添加onAppear()，否则它不能与onReceive()一起工作，这就是为什么它出现在上面。他是空的，但是它作为一个解决问题的方法。
 */

// MARK: 创造便捷函数

//extension View {
//    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
//        self.modifier(DeviceRotationViewMofifier(action: action))
//    }
//}

// MARK: 自动探查屏幕旋转

//struct ContentView: View {
//    @State private var orientation = UIDeviceOrientation.unknown
//    
//    var body: some View {
//        Group {
//            if orientation.isPortrait {
//                Text("Protrait")
//            } else if orientation.isLandscape {
//                Text("Landscape")
//            } else if orientation.isFlat {
//                Text("Flat")
//            } else {
//                Text("Unknown")
//            }
//        }
//        .onRotate { newOrientation in
//            orientation = newOrientation
//        }
//    }
//}

// MARK: -
// MARK: 7、在键盘上添加工具栏
/*
 SwiftUI可以在键盘上添加输入附件视图，当用户激活某些文本输入时，可以在那里呈现自定义按钮。

 这一些都是通过将toolbar()修饰符附加到应该拥有输入附件的任何视图来完成的。在创建工具栏组时，使用.keyboard的文字将此工具栏附加到键盘上。
 */

//struct FFToolbarKeyboard: View {
//    @State private var name = "Taylor"
//    @State private var name1 = "BBLv"
//    @FocusState var isInputActive: Bool
//    
//    var body: some View {
//        
//        List {
//            TextField("Enter your name", text: $name)
//                .textFieldStyle(.roundedBorder)
//                .toolbar(content: {
//                    ToolbarItemGroup(placement: .keyboard) {
//                        Button("Click me!") {
//                            print("Clicked")
//                        }
//                    }
//                })
//            
//            //在实际操作中，可以利用这个功能临时关闭键盘
//            TextField("Enter your name", text: $name1)
//                .textFieldStyle(.roundedBorder)
//                .focused($isInputActive)
//                .toolbar(content: {
//                    ToolbarItemGroup(placement: .keyboard) {
//                        Spacer()
//                        Button("Done") {
//                            isInputActive = false
//                        }
//                    }
//                })
//        }
//    }
//}

// MARK: -
// MARK: 8、在显示UI时异步加载任务
/*
 SwiftUI的task()修饰符是onAppear()的一个更强大的版本，在显示视图时立即启动异步任务。更好的是，当视图被销毁时，如果任务没有完成，任务将自动取消。由于任务是异步执行的，这是为UI获取一些初始网络数据的好地方。
 
 从服务器获取消息列表，将其解码为message结构数组，然后将其显示在列表中。
 */

//struct Message: Decodable, Identifiable {
//    let id: Int
//    let from: String
//    let text: String
//}
//
//struct SourceViewer: View {
//    let site: String
//    @State private var sourceCode = "Loading...."
//    
//    var body: some View {
//        ScrollView {
//            Text(sourceCode)
//                .font(.system(.body, design: .monospaced))
//        }
//        .task {
//            guard let url = URL(string: "https://\(site)") else {
//                return
//            }
//            
//            do {
//                let (data, _) = try await URLSession.shared.data(from: url)
//                sourceCode = String(decoding: data, as: UTF8.self).trimmingCharacters(in: .whitespacesAndNewlines)
//            } catch {
//                sourceCode = "Faild to fetch site"
//            }
//        }
//    }
//}
//
//struct FFToolbarKeyboard: View {
//    @State private var name = "Taylor"
//    @State private var name1 = "BBLv"
//    @FocusState var isInputActive: Bool
//    
//    var body: some View {
//        
//        List {
//            TextField("Enter your name", text: $name)
//                .textFieldStyle(.roundedBorder)
//                .toolbar(content: {
//                    ToolbarItemGroup(placement: .keyboard) {
//                        Button("Click me!") {
//                            print("Clicked")
//                        }
//                    }
//                })
//            
//            //在实际操作中，可以利用这个功能临时关闭键盘
//            TextField("Enter your name", text: $name1)
//                .textFieldStyle(.roundedBorder)
//                .focused($isInputActive)
//                .toolbar(content: {
//                    ToolbarItemGroup(placement: .keyboard) {
//                        Spacer()
//                        Button("Done") {
//                            isInputActive = false
//                        }
//                    }
//                })
//        }
//    }
//}

// MARK: -
// MARK: 9、如何将数据粘贴到应用程序中
/*
 SwiftUI有一个专用的PasteBUtton视图，接收任何符合Transferable协议的数据，比如String和Data
 */

//struct ContentView: View {
//    @State private var username = "@twostraws"
//    var body: some View {
//        VStack {
//            TextField("Username", text: $username)
//                .textFieldStyle(.roundedBorder)
//            
//            PasteButton(payloadType: String.self) { strings in
//                guard let first = strings.first else { return }
//                username = first
//            }
//            .buttonBorderShape(.capsule)
//        }
//        .padding()
//    }
//}

// MARK: -
// MARK: 10、使用系统共享表共享内容
/*
 SwiftUI的ShareLink视图可以很容易的从你的app共享任何类型的数据，只要它符合Transferable协议
 */

//struct ContentView: View {
//    let link = URL(string: "https://www.hackingwithswift.com")!
//    let link1 = URL(string: "https://www.admin.ch")!
//    
//    var body: some View {
//        
//        List {
//            Section {
//                // 默认情况下，你会得到一个简单的带有响应图标的“分享”标签，但你可以提供你自己的标题文本，或者一个完全自定义的标签。
//                VStack(spacing: 20, content: {
//                    ShareLink(item: link)
//                    ShareLink("Learn Swift here", item: link)
//                    ShareLink(item: link) {
//                        Label("Learn Swift here", image: "swift")
//                    }
//                })
//            }
//            
//            Section {
//                //如果你想在你分享的内容中附加一些额外的文本，通过message参数
//                ShareLink(item: link, message: Text("Learn Swift here!"))
//            }
//            
//            Section {
//                //对于一些简单Url，系统能够替我们生成预览，但你也可以提供一些文本和你选择的图像自定义预览
//                ShareLink(
//                    item: link,
//                    preview: SharePreview("Swizerland's flag: it's a big plus.", image: Image(systemName: "plus"))
//                )
//            }
//        }
//    }
//}

// MARK: -
// MARK: 11、查找和替换文本
/*
 SwiftUI的TextEditor内置支持用户搜索文本，或根据需要进行搜索和替换。对于连接了键盘的用户来说，更简单。
 */

//struct FFFindAndReplaceText: View {
//    @State private var bio = "Describe yourself."
//    @State private var bio1 = "Describe yourself 1."
//    @State private var bio2 = "Describe yourself 2."
//    @State private var isShowingFindNavigator = false
//    
//    var body: some View {
//        //点击激活TextEditor，然后按cmd+f进行搜索。查找和替换仅适用于TextEditor，而不适用于TextField
//        NavigationStack {
//            TextEditor(text: $bio)
//                
//            
//            Divider()
//            
//            TextEditor(text: $bio1)
//                .findNavigator(isPresented: $isShowingFindNavigator)
//                .toolbar(content: {
//                    Button("Toggle Search") {
//                        isShowingFindNavigator.toggle()
//                    }
//                })
//            
//            //当当前没有TextEditor接受输入时，将true传递给findNavigator()将使系统尝试自动查找和激活一个。如果从系统中有多个可选择时，系统将为你选择一个。
//            //如果你明确视图选择退出搜索或替换，请使用一个或两个findDisabled()和replaceDisabled()
//            TextEditor(text: $bio2)
//                .replaceDisabled()
//        }
//        .navigationTitle("Edit Bio")
//        //对于没有硬件键盘的用户，你可以使用findNavigator()修饰符以编程的方式显示查找接口
//    }
//}

// MARK: -
// MARK: 12、在SwiftUI中支持拖放
/*
 SwiftUI的Transferable协议可以使用dropDestination()和draggable()修饰符，无需大量代码即可为App添加拖放功能
 */

// MARK: 12.1、Canvas
/*
 关键部分是dropDestination()修饰符，做4件事：

 接受的类型（String）
 预计会截取到在应用程序上掉落的项目数组。自动转化为String数组。
 我们被告知他们被扔在哪里，这将是画布坐标空间中的CGPoint
 我们认为掉落操作是成功的，所以返回true
 */

//struct ContentView: View {
//    @State private var message = ""
//    @State private var image = Image("1111")
//    @State private var images = [Image]()
//    
//    var body: some View {
//        Canvas { context, size in
//            let formattedText = Text(message)
//                .font(.largeTitle)
//                .foregroundStyle(.red)
//            context
//                .draw(formattedText, in: CGRect(origin: .zero, size: size))
//        }
//        .dropDestination(for: String.self) { items, location in
//            message = items.first ?? ""
//            return true
//        }
//    }
//}

// MARK: 12.2、Image
/*
 处理图像有点困难，将获得一个代表图像内容的data实例。我们需要将其转化为UIImage，并将结果放入图像中进行渲染。如果支持data，那么两者都会起作用，所以像这样的代码允许用户将图像从照片中直接拖入到我们的应用程序中。
 */

//struct FFCanvasDropImage: View {
//    @State private var message = ""
//    @State private var image = Image(systemName: "photo")
//    var body: some View {
//        image
//            .resizable()
//            .scaledToFit()
//            .frame(width: 300,height: 300)
//            .dropDestination(for: Data.self) { items, location in
//                guard let item = items.first else { return false }
//                guard let uiImage = UIImage(data: item) else { return false }
//                image = Image(uiImage: uiImage)
//                return true
//            }
//    }
//}

// MARK: 102.3、多张Image
/*
 将多个图像拖入数组中，遵循相同的过程：使用dropDestination(for:Data.Self)，但现在不应该只读取一个项目，而是应该读取全部。ScrollView通过每个Data实例转化为UIImage，然后转换为SwiftUI，在ScrollView中显示多张Image
 */

//struct FFCanvasDropImages: View {
//    @State private var images = [Image]()
//    
//    var body: some View {
//        ScrollView {
//            VStack {
//                ForEach(0..<images.count, id: \.self) { i in
//                    images[i]
//                        .resizable()
//                        .scaledToFit()
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//            }
//            .dropDestination(for: Data.self) { items, location in
//                images = items.compactMap({
//                    UIImage(data: $0).map(Image.init)
//                })
//                return true
//            }
//        }
//    }
//}

// MARK: 12.4、Draggable
/*
 向视图添加拖动功能时，使用draggable()任何内容添加修饰符。Transferable在默认情况下，SwiftUI将使用视图本身进行拖动预览，如果你从应用程序内拖动图像，不必须将Image.self转换为Data再转为UIImage。
 
 显示3个不同的SF Symbol，并可以将其拖动到下面的框中
 */

//VStack {
//    HStack {
//        ForEach(sports, id: \.self) { sport in
//            Image(systemName: sport)
//                .frame(minWidth: 50, minHeight: 50)
//                .background(.red)
//                .foregroundStyle(.white)
//                .draggable(Image(systemName: sport))
//        }
//    }
//    .frame(minWidth: 300, minHeight: 70)
//    .background(.gray)
//    
//    dropImage
//        .frame(width: 150, height: 150)
//        .background(.green)
//        .foregroundStyle(.white)
//        .dropDestination(for:Image.self) { items, location in
//            dropImage = items.first ?? Image(systemName: "photot")
//            return true
//        }
//}

/*
 当你拖动SF Symbol图像时，SwiftUI将发送图像像素数据，而不是可整体缩放的矢量。这意味着删除的数据不会响应font()或foregroundStyle()等修饰符。
 
 如果你想显示自定义拖动预览，添加一些带有SwiftUI视图的尾随闭包。例如，这会生成一个可拖动的golf图像，并在其旁边添加文本“Figure Playing Golf”
 */

//Image(systemName: "figure.golf")
//    .frame(minWidth: 50, minHeight: 50)
//    .background(.red)
//    .foregroundStyle(.white)
//    .draggable(Image(systemName: "figure.golf")) {
//        Label("Figure playing golf", systemImage: "figure.golf")
//    }

// MARK: -
// MARK: 13、检测键盘并响应按键事件
/*
 SwiftUI有一个onKeyPress()修饰符，响应应用程序中触发的硬件“键盘”事件，唯一的问题按键的视图当前必须具有输入焦点。
 */

// MARK: 13.1、.focused($focused)
/*
 监视按键可以采取多种形式，但无论采取哪种方法，视图都必须是可聚焦的，以便响应按键。因此，此代码将文本视图标记为可聚焦且当前已聚焦，然后每当按下键时更细内容。
 */

//struct ContentView: View {
//    @FocusState private var focused: Bool
//    @State private var key = ""
//    var body: some View {
//        //return .handler部分告诉SwiftUI完全响应按键操作的闭包。如果、是.ignored，则按键操作将被传递到接下来能处理它的任何视图。
//        Text(key)
//            .focusable()
//            .focused($focused)
//            .onKeyPress { press in
//                key += press.characters
//                return .handled
//            }
//            .onAppear {
//                focused = true
//            }
//        .focused($focused)
//    }
//}

/*
 接收到的字符没有附加任何修饰键，因此不会为你提供大写字母或者特殊符号内容。
 */

// MARK: 13.2、phases: .up
/*
 其他形式的onKeyPress()包括跟踪那个阶段被触发的形式，因此你可以使用此代码仅跟踪何时释放按键。
 */

//Text(key)
//    .onKeyPress(phases: .up) { press in
//        print("Received \(press.characters)")
//        return .handled
//    }

// MARK: 13.3、.onKeyPress(characters: .alphanumerics)
/*
 响应按下的某些类型按键,characters: .alphanumerics 指定了只响应字母和数字字符的按键事件。这意味着只有当用户按下字母或数字键时，处理程序才会被触发。
 */

//Text(key)
//    .onKeyPress(characters: .alphanumerics) { press in
//        print("Received \(press.characters)")
//        return .handled
//    }

// MARK: 13.4、.onKeyPress(keys: [.escape, "w", "q"])
/*
 响应特定字符:当按下空格、w、q时触发
 */

//Text(key)
//    .onKeyPress(keys: [.escape, "w", "q"]) { press in
//        print("Received \(press.characters)")
//        return .handled
//    }

// MARK: -
// MARK: 14、何使用感觉反馈添加触觉效果
/*
 SwiftUI的sensoryFeedback()修饰符为一系列简单的触觉提供内置支持，可以为成功、失败、选择、影响等创建震动效果。要触发反馈，将sensoryFeedback()附加到任何视图，告诉她要制作什么样的效果以及触发器应该是什么--何时播放效果。SwiftUI将监视触发值，并在其发生变化时运行触觉效果。
 */

//struct ContentView: View {
//    var body: some View {
//        FFHapticEffects()
//    }
//}
//
//struct FFHapticEffects: View {
//    @State private var taskIsComplete = false
//    @State private var randomNumber = 0.0
//    
//    var body: some View {
//        //例如，如果有一个将任务标记为已完成的按钮，则可以在完成时播放。
//        Button("Mark Complete") {
//            taskIsComplete = true
//        }
//        .sensoryFeedback(.success, trigger: taskIsComplete)
//        
//        //为了进行更细颗粒度的控制，可以通过比较触发器的新旧值来确定触发哪种类型的触觉效果。例如，使用了.impact触觉效果，其强度根据两个随机数之间的差异而变化。
//        Button("Mark Complete") {
//            randomNumber = Double.random(in: 0...1)
//        }
//        .sensoryFeedback(trigger: randomNumber) { oldValue, newValue in
//            let amount = abs(oldValue - newValue)
//            return .impact(flexibility: .solid, intensity: amount)
//        }
//        
//        //可以提供固定的触觉效果，并通过提供比较函数来自定义何时触发。例如，当两个随机数之间的差异大于0.5时，触发.success触觉
//        Button("Mark Complete") {
//            randomNumber = Double.random(in: 0...1)
//        }
//        .sensoryFeedback(.success, trigger: randomNumber) { oldValue, newValue in
//            abs(oldValue - newValue) > 0.5
//        }
//    }
//}
