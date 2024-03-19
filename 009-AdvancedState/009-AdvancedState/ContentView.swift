//
//  ContentView.swift
//  009-AdvancedState
//
//  Created by 舒毅文 on 2024/3/12.
//

import SwiftUI

/*
 SwiftUI基础篇AdvancedState
 https://juejin.cn/post/7263726955600887867
 */

#Preview {
    ContentView()
}

// MARK: -
// MARK: 1、@ObservedObject,@State和@EnvironmentObject之间的区别是什么？
/*
 在任何现代应用程序中，state都是不可避免的，但对于SwiftUI，所有的视图都只是其状态的函数--不直接改变视图，而是操纵状态，让状态决定结果。

 使用state最简单的方法是使用@State属性包装器
 */

//struct ContentView: View {
//    @State private var tapCount = 0
//    var body: some View {
//        Button("Tap count: \(tapCount)")  {
//            tapCount += 1
//        }
//    }
//}

// MARK: 1.1、@State
/*
 在视图中创建了一个属性，但是使用@State属性包装器来请求SwiftUI管理内存。所有的视图都是结构体，这代表着他们不能被改变。所以，当使用@State去创建一个属性时，把对它的控制交给SWiftUI，这样只要视图存在，它就会在内存中保持状态，当状态改变时，SwiftUI根据最新的变化重新加载视图，这样就可以更新视图了。

 @State对于属性特定视图且永远不会在视图外使用的简单属性非常有用，因此将这些属性标记为私有以强化这样的想法：这种状态时专门设计的，永远不会逃离其视图。
 */

// MARK: 1.2、@ObservedObject
/*
 对于更复杂的属性--当有一个想要使用的自定义类型，可能有多个属性和方法，或者可能在多个视图之间共享--通常使用@ObservedObject。这与@State非常相似，只是现在使用的是外部引用类型，而不是简单的本地属性（如字符串）。除了现在要负责管理自己的数据--需要创建类的实例，属性等等，视图会依赖于动态数据。
 
 无论使用@ObservedObject的类型是什么，都应该遵守ObserableObject协议。当向可观察对象添加属性时，可以决定对每个属性的更改是否应该强制监视对象的视图刷新，通常会这么做，但不是必须的。
 
 观察对象有几种方法可以通知视图数据已经更改，但最简单的方法是使用@Published属性包装器，如果需要更多的控制，也可以使用Combine框架中的自定义发布者，但实际上这种情况非常少见。如果可观察对象碰巧有多个殊途在使用他的数据，任何改变都会通知所有视图。
 
 观察对象有几种方法可以通知视图数据已经更改，但最简单的方法是使用@Published属性包装器，如果需要更多的控制，也可以使用Combine框架中的自定义发布者，但实际上这种情况非常少见。如果可观察对象碰巧有多个殊途在使用他的数据，任何改变都会通知所有视图。当使用自定义发布器宣布对象已更改时，必须在主线程。
 */

// MARK: 1.3、@StateObject
/*
 @StateObject位于@State和@ObservedObject之间，这是ObservedObject的一个特殊版本，原理几乎完全相同：必须遵守ObservableObject协议，可以使用@Published将属性标记为引起更改通知，并且任何观察@StateObject的视图都会在对象更改时刷新其主体。@StateObject和@ObservedObject之间有一个重要的区别，那就是所有权--那个视图创建了对象，那个视图在观察它。
 
 规则是这样的：无论哪个视图是第一个创建对象的，都必须使用@StateObject，告诉SwiftUI它是数据的所有者，并负责保持数据存活。所有其他视图都必须使用@ObservedObject来告诉SwitUI他们想要观察对象的变化，但不直接拥有它。
 */

// MARK: 1.4、@EnvironmentObject
/*
 已经了解@State如何为一个类型声明简单的属性，当它改变时自动刷新视图。以及@observedObject如果为一个外部类型声明属性，当他改变时可能会或不会导致视图刷新，这两个都必须有视图设置，但@ObsrevedObject可以与其他视图共享。
 
 还有一种属性包装器，它是@EnvironmentObject，这是一个通过应用程序本身提供给视图的值--它是每个视图都可以读取的共享数据，如果引用有一些重要模型数据所有的视图都需要读取，可以把它从一个视图传递到另一个视图，或者把它放到每个视图都能及时访问的环境中。
 
 当在应用程序中传递大量数据时，把@Environment看作一个巨大的便利构造器，因为所有的视图都指向同一个模型，如果一个视图改变了模型，所有的视图都会立即更新，规避app不同部分不同步的风险。
 */

/*
 总结

 对于属于单个视图的简单属性使用@State，通常将属性标记为private
 
 对于可能属于多个视图的复杂属性，使用@ObservedObject，在使用引用类型时，大多数情况下应该使用@ObservedObject
 
 对于使用的每个可观察对象，无论你的代码的哪一部分负责创建它，都要使用一次@StateObject

 对于在应用程序其他对方创建的属性，比如共享数据，使用@Environmentobject
 */

// MARK: -
// MARK: 2、使用@StateObject来创建和监控外部对象
/*
 SwiftUI的@StateObject属性包装器是@observedObject的一种特殊形式，具有相同的功能，但有一个重要的补充，由被观察对象创建，而不仅仅是存储外部传递的对象。
 当用@StateObject给视图添加属性时，SwiftUI会认为这个视图是这个可观察对象的持有者，所有其他给传递对象的视图都应该使用@observedObject。
 
 所以，如果在某个地方使用@StateObject创建了可观察对象，在你传递该对象的所有后续地方，都必须使用@ObservedObject。
 */

//class Player: ObservableObject {
//    @Published var name = "meta BBlv"
//    @Published var age = 29
//}
//
//struct PlayernameView: View {
//    @ObservedObject var player: Player
//    
//    var body: some View {
//        Text("Hello, \(player.name)")
//    }
//}
//
//struct ContentView: View {
//    @StateObject var player = Player()
//    
//    var body: some View {
//        NavigationStack {
//            NavigationLink {
//                PlayernameView(player: player)
//            } label: {
//                Text("Show Detail View")
//            }
//        }
//    }
//}

// MARK: -
// MARK: 3、使用@ObservedObject从外部对象管理状态
/*
 当使用观察对象时，需要处理三件关键事情：ObservableObject协议与一些可以存储数据的类一起使用。@ObservedObject属性包装器在视图中用于存储可观察对象实例，@Published属性包装器被添加到观察对象中的任何属性，当视图发生变化时，这些属性会导致视图刷新。
 
 对于从其他地方传入的视图，只使用@ObservedObject是非常重要的，你不应该使用这个属性包装器来创建一个可观察对象的初始实例--这就是@StateObject的作用。
 */

//class UserProgress: ObservableObject {
//    @Published var score = 0
//}
//
//struct InnerView: View {
//    @ObservedObject var progress: UserProgress
//    var body: some View {
//        Button("Increase Score") {
//            progress.score += 1
//        }
//    }
//}
//
//struct ContentView: View {
//    @StateObject var progress = UserProgress()
//    
//    var body: some View {
//        VStack {
//            Text("Your score is \(progress.score)")
//            InnerView(progress: progress)
//        }
//    }
//}

// MARK: -
// MARK: 4、@EnvironmentObject来共享视图之间的数据
/*
 对于应该与应用程序中的许多视图共享数据，SwiftUI提供了@EnvironmentObject属性包装器，这可以在任何需要的地方共享模型数据，同时还确保当数据发生变化时，视图自动保持更新。把@EnvironmentObject看作是在许多视图上使用@ObservedObject的一种更智能更简单的方式。在视图A中创建数据，然后将其传递给视图B，然后传递给视图C，再传递给视图D，不如在视图A中穿件它并将其放入环境中，以便视图B、C和D将自动访问它。
 
 就像@ObservedObject一样，你永远不会给@EnvironmentObject属性赋值。相反，它应该在其他地方传入，最终可能在某处使用@StateObject来创建它。然而，与@ObservedObject不同，不需要手动将对象传递给其他视图，相反，使用send数据到一个叫environmentObject()修饰符中，这使得该对象在SwiftUI的环境中对该视图以及其内部的任何其他视图可用。
 环境对象必须有根视图提供，如果SwiftUI找不到正确类型的环境对象，就会crash。
 */

//class GameSettings: ObservableObject {
//    @Published var score = 0
//}
//
//struct ScoreView: View {
//    @EnvironmentObject var settings: GameSettings
//    var body: some View {
//        Text("Score: \(settings.score)")
//    }
//}
//
//struct ContentView: View {
//    @StateObject var settings = GameSettings()
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Button("Increase Score \(settings.score)") {
//                    settings.score += 1
//                }
//                
//                NavigationLink {
//                    ScoreView()
//                } label: {
//                    Text("Show Detail View")
//                }
//            }
//            .frame(height: 200)
//        }
//        .environmentObject(settings)
//    }
//}

/*
这段代码中有一些重要的内容：
就像@StateObject与@ObservedObject一样，与@EnvironmentObject一起使用的所有类都必须遵守ObservableObject协议。
 
将GameesSettings放入导航Stack环境中，这意味着navigationStack中所有的视图都可以读取该对象，以及navigationStack显示的任何视图。
 
当使用@EnvironmentObject属性包装器是，声明了期望接受的对象类型，而不是创建它--毕竟，期望在环境中获取它。
 
因为Detail视图显示在NavigationStack中，它将访问相同的环境，这反过来意味着它可以读取创建的gamesSetting对象。
 
不需要显示的将环境中的gamesettings实例与scoreView的settings属性关联起来--SwiftUI会自动计算它在环境中有一个gamesSetting实例，所以那就是它使用的。
 
既然视图依赖于当前的环境对象，那么更新与来代码以提供一些示例设置是很重要的。例如，使用ScoreView().environmentObject(gamesetting())之类的预览应该可以做到这一点。
 
如果需要向环境中添加多个对象，则应该添加多个environmentObject（）修饰符--只需一个接一个调用。
 */

// MARK: -
// MARK: 5、ObjectWillChange手动发送状态更新
/*
 虽然使用@published是控制状态更新最简单的方法，但如果需要某些特定的东西，也可以手动操作，例如，当你对给定值符合条件才刷新视图。所有可观察对象会自动访问ObjectWillChange属性时，该属性本身有一个send（）方法，可以在想要刷新观察视图时调用他。
 */

//class UserAuthentication: ObservableObject {
//    var username = "Aieiwng" {
//        willSet {
//            objectWillChange.send()
//        }
//    }
//}
//
//struct ContentView: View {
//    @StateObject private var user = UserAuthentication()
//    var body: some View {
//        VStack(alignment: .leading) {
//            TextField("Enter your name", text: $user.username)
//            Text("Your username is: \(user.username)")
//        }
//    }
//}

// MARK: -
// MARK: 7、自定义绑定
/*
 当使用SwiftUI的@State属性包装器时，它代表我们做了大量的工作来允许用户界面控件的双向绑定。但是，我们也可以使用Binding类型手动创建绑定，该类型可以提供自定义的get和set闭包，以便在读取和写入时运行。
 */

//struct ContentView: View {
//    @State private var username = ""
//    @State private var firstToggle = false
//    @State private var secondToggle = false
//    
//    var body: some View {
//        let binding = Binding {
//            self.username
//        } set: {
//            self.username = $0
//        }
//        
//        VStack {
//            TextField("enter your name", text: binding)
//        }
//        
//        let firstBinding = Binding {
//            self.firstToggle
//        } set: {
//            self.firstToggle = $0
//            if $0 {
//                self.secondToggle = false
//            }
//        }
//        
//        let secondBinding = Binding {
//            self.secondToggle
//        } set: {
//            self.secondToggle = $0
//            if $0 {
//                self.firstToggle = false
//            }
//        }
//        
//        VStack {
//            Toggle(isOn: firstBinding, label: {
//                Text("Frist Toggle")
//            })
//            
//            Toggle(isOn: secondBinding, label: {
//                Text("Second Toggle")
//            })
//        }
//    }
//}

// MARK: -
// MARK: 8、Timer
/*
 如果想要定期运行一些代码，也许需要制作一个倒计时计时器，应该使用timer和onReceive()修饰符
 */

//struct ContentView: View {
//    @State private var currentDate = Date.now
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    
//    @State private var timeRemaining = 10
//    let timer1 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    
//    var body: some View {
//        Text("\(currentDate)")
//            .onReceive(timer, perform: { input in
//                currentDate = input
//            })
//        
//        /*
//         对于Runloop选项使用.main很重要，因为计时器将更新用户界面，至于.common模式，它允许计时器与其他常见事件一起运行，例如，文本在视图中滚动。
//         onReceive（）闭包被传入一些包含当前日期的输入。在上面的代码中，将其直接赋值给currentDate，但是你可以使用它来计算从上一个日期到现在已经过去了多少时间。
//         
//         如果你特别希望创建一个倒计时器或者秒表，则应该创建一些状态来跟踪剩余的时间，然后在计时器触发时减去剩余时间。
//         创建倒计时器，在label上显示剩余时间。
//         */
//
//        Text("倒计时：\(timeRemaining)")
//            .onReceive(timer1, perform: { input in
//                if timeRemaining > 0 {
//                    timeRemaining -= 1
//                }
//            })
//    }
//}

// MARK: -
// MARK: 9、在状态改变时使用onChange()运行一些代码
/*
 SwiftUI可以使onChange()修饰符附加到任何视图上，当程序中的某些状态发生变化时，它将运行你想要运行的代码，因为我们不能总是把属性观察者如didSet与@State一起使用。
 */

//extension Binding {
//    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
//        Binding {
//            self.wrappedValue
//        } set: { newValue in
//            self.wrappedValue = newValue
//            handler(newValue)
//        }
//    }
//}
//
//struct ContentView: View {
//    @State private var name1 = ""
//    @State private var name2 = ""
//    @State private var name3 = ""
//    @State private var name4 = ""
//    
//    var body: some View {
//        TextField("Enter your name:", text: $name1)
//            .textFieldStyle(.roundedBorder)
//            .onChange(of: name1) { oldValue, newValue in
//                print("Name change to \(name1)")
//            }
//        
//        TextField("Enter your name:", text: $name2)
//            .onChange(of: name2, initial: true) { oldValue, newValue in
//                print("Name change to \(name2)")
//            }
//        
//        TextField("Enter your name:", text: $name3.onChange(nameChange(to:)))
//    }
//    
//    func nameChange(to value: String) {
//        print("Name change to \(name3)")
//    }
//}
  
// MARK: -
// MARK: 10、在明暗模式下显示不同的图像和其他视图
/*
 SwiftUI可以根据用户当前的外观设置直接从你的ASset catalog中加载明暗模式的图像，但如果不使用Asset catalog，例如，如果你下载图像或在本地生成他们。最简单的解决方案是创建一个同时处理明暗模式图像的新视图
 */

//struct AdaptiveImage: View {
//    @Environment(\.colorScheme) var colorScheme
//    let light: Image
//    let dark: Image
//    
//    @ViewBuilder var body: some View {
//        if colorScheme == .light {
//            light
//        } else {
//            dark
//        }
//    }
//}
//
////它保留了相同的便捷初始化器，但现在添加了接受闭包的替代方法。所以，现在可以利用闭包在明暗之下切换更复杂的代码
//struct AdaptiveView<T: View, U: View>: View {
//    @Environment(\.colorScheme) var colorScheme
//    let light: T
//    let dark: U
//    
//    init(light: T, dark: U) {
//        self.light = light
//        self.dark = dark
//    }
//    
//    init(light: () -> T, dark: () -> U) {
//        self.light = light()
//        self.dark = dark()
//    }
//    
//    @ViewBuilder var body: some View {
//        if colorScheme == .light {
//            light
//        } else {
//            dark
//        }
//    }
//}
//
//struct FFDarkMode: View {
//    var body: some View {
//        //这样可以传入两张图，SwiftUI会自动选择正确的明暗模式。
//        AdaptiveImage(light: Image(systemName: "sun.max"), dark: Image(systemName: "moon"))
//        //如果你只是想在明暗模式的之间切换，这很有效，但如果想要添加一些额外的代码，我们可以创建一个包装器视图，能够根据明暗模式显示完全不同的内容。
//        VStack {
//            AdaptiveView {
//                VStack {
//                    Text("Light mode")
//                    Image(systemName: "sun.max")
//                }
//            } dark: {
//                HStack {
//                    Text("Dark mode")
//                    Image(systemName: "moon")
//                }
//            }
//            .font(.largeTitle)
//        }
//    }
//}
