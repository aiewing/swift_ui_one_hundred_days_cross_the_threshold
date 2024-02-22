//
//  ContentView.swift
//  003-ViewLayout
//
//  Created by 舒毅文 on 2024/1/10.
//

import SwiftUI


#Preview {
    ContentView()
}

// MARK: 1、如何设置一个自定义View的frame
/*
 默认情况下，SwiftUI的视图仅占用所需的空间，但如果更改，可以使用frame()来控制
 */

// MARK: 1.1 .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 200)
/*
 创建一个最大宽高200*200的Button
 */

//struct ContentView: View {
//    var body: some View {
//        Button {
//            print("button tapped")
//        } label: {
//            Text("Welcome")
//                .frame(minWidth: 1, maxWidth: 200, minHeight: 0, maxHeight: 200)
//                .font(.largeTitle)
//        }
//    }
//}

// MARK: 1.2、.infinity
/*
 指定View的最小宽度和最小高度，最大宽度和高度为无穷大，是文本视图填充整个可用空间
 */

//struct ContentView: View {
//    var body: some View {
//        Text("整个可用空间")
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//            .font(.largeTitle)
//            .foregroundStyle(.white)
//            .background(.red)
//    }
//}

// MARK: -
// MARK: 2、如何使用padding填充控制各个视图周围的间距
/*
 在SwiftUI中，可以使用修饰符在视图的周围单独填充padding(),从而使视图距离相邻的视图更远
 */

// MARK: 2.1、padding
/*
 不带任何参数使用，Text("Hello, SwiftUI!")的padding的设定是在上下左右所有的边上
 */

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Hello, World")
//            Text("Hello, SwiftUI")
//                .padding()
//            Text("Hello, World")
//            Text("Hello, World")
//        }
//    }
//}

// MARK: 2.2、padding(.bottom)
/*
 添加位置参数，只针对Text的bottom设置
 */

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Hello, World")
//            Text("Hello, SwiftUI")
//                .padding(.bottom)
//            Text("Hello, World")
//            Text("Hello, World")
//        }
//    }
//}

// MARK: 2.3、padding(100)
/*
 添加距离参数，设置目标到边的具体距离，默认是所有边全部填充
 */

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Hello, World")
//            Text("Hello, SwiftUI")
//                .padding(100)
//            Text("Hello, World")
//            Text("Hello, World")
//        }
//    }
//}

// MARK: 2.4、padding(.bottom, 100)
/*
 同时添加位置与距离参数
 */

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Hello, World")
//            Text("Hello, SwiftUI")
//                .padding(.bottom, 100)
//            Text("Hello, World")
//            Text("Hello, World")
//        }
//    }
//}

// MARK: -
// MARK: 3、如何使用GeometryReader提供相对尺寸
/*
 在SwiftUI中，最好的选择是让系统自己自动布局，但也可以使用GeometryReader ，例如你希望两个View占据屏幕上可用宽度的一半，如果使用硬编码是不可能的，因为我事先不知道屏幕宽度是多少，为了解决这个问题GeometryReader为我们提供了一个输入值，告诉我们可以使用的宽度和高度，然后我们可以将其用于我们的任何计算。

 我现在创建两个视图，希望其中一个占据父视图的1/3，另一个占据2/3
 */

/*
 注意：GeometryReader 不考虑视图层次结构中的任何偏移或间距，这就是 HStack 上没有间距的原因 - 如果我们允许其中的间距，则视图对于可用空间来说会有点太大 。通过GeometryReader设置的就超出了原本视图frame
 */

//struct ContentView: View {
//    var body: some View {
//        GeometryReader(content: { geometry in
//            HStack(spacing: 0, content: {
//                Text("Left")
//                    .font(.largeTitle)
//                    .foregroundStyle(.black)
//                    .frame(width: geometry.size.width * 0.33)
//                    .background(.yellow)
//                Text("Right")
//                    .font(.largeTitle)
//                    .foregroundStyle(.black)
//                    .frame(width: geometry.size.width * 0.67)
//                    .background(.orange)
//            })
//        })
//    }
//}

// MARK: -
// MARK: 4、如何将内容放置在safeArea之外
/*
 默认情况下，SwiftUI视图将大部分留在安全区域内，它们将到达屏幕底部，但不会接近设备顶部的任何凹口，如果想更改，设置真正的全屏，添加修饰符ignoresSafeArea()
 */

//struct ContentView: View {
//    var body: some View {
//        Text("Hello World!")
//            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
//            .foregroundStyle(.white)
//            .background(.orange)
//            .ignoresSafeArea()
//    }
//}

// MARK: -
// MARK: 5、如何返回不同类型的视图
/*
 借助名为 @ViewBuilder 的特殊属性，任何 SwiftUI 的 body 属性都会自动获得返回不同视图的能力。 这是使用 Swift 的结果生成器系统实现的，它了解如何根据我们应用程序的状态呈现两个不同的视图。然而，这种相同的功能并不是自动无处不在，这意味着您创建的任何自定义属性都必须返回相同的视图类型。
 */

// MARK: 5.1、Group
/*
 方案一：将输出包装在一个Group中，根据下面的例子，无论你返回图像还是文本视图，它们都会返回到一个组中
 */

//var tossResult: some View {
//    Group {
//        if Bool.random() {
//            Image("chincoteague")
//                .resizable()
//                .scaledToFit()
//        } else {
//            Text("Better luck next time")
//                .font(.title)
//        }
//    }
//    .frame(width: 400,height: 150)
//}

// MARK: 5.2、AnyView
/*
 方案二：使用类型擦除的包装器，返回AnyView
 */

//var tossResult2: some View {
//    if Bool.random() {
//        return AnyView(Image("chincoteague")
//            .resizable()
//            .scaledToFit()
//        )
//    } else {
//        return AnyView( Text("Better luck next time")
//            .font(.title)
//        )
//    }
//}

// MARK: 5.3、@ViewBuilder
/*
 方案三：为属性主动添加@ViewBuilder属性包装器，将属性标记，使其自动获得返回不同视图的能力
 */

//@ViewBuilder var tossResult3: some View {
//    if Bool.random() {
//        Image("chincoteague")
//            .resizable()
//            .scaledToFit()
//    } else {
//        Text("Better luck next time")
//            .font(.title)
//    }
//}

// MARK: 5.4、创建一个Struct
/*
 方案四：大多数情况下最有效的解决方案，是将视图分解为更小的视图，然后根据需求组合在一起
 */

//struct TossResult4: View {
//    var body: some View {
//        if Bool.random() {
//            Image("chincoteague")
//                .resizable()
//                .scaledToFit()
//        } else {
//            Text("Better luck next time")
//                .font(.title)
//        }
//    }
//}

// MARK: 关于body内的调试代码

//struct ContentView: View {
//    var body: some View {
//        List {
//            Section {
//                VStack {
//                    Text("Coin Flip")
//                        .font(.largeTitle)
//                    tossResult
//                }
//            }
//
//            Section {
//                VStack {
//                    Text("Coin Flip")
//                        .font(.largeTitle)
//                    tossResult2
//                        .frame(width: 400, height: 150)
//                }
//            }
//            
//            Section {
//                VStack {
//                    Text("Coin Flip")
//                        .font(.largeTitle)
//                    tossResult3
//                        .frame(width: 400, height: 150)
//                }
//            }
//            
//            Section {
//                VStack {
//                    Text("Coin Flip")
//                        .font(.largeTitle)
//                    TossResult4()
//                        .frame(width: 400, height: 150)
//                }
//            }
//        }
//    }
//}

// MARK: 关于返回type的总结：
/*
 1. 关于类型擦除，他会有效地迫使Swift忘记内部的具体类型，从而使他们看起来像是相同的东西，不过，这会带来性能成本，因此不要经常使用它。
 2. 用Group和AnyView都实现了相同的结果，两之间更推荐Group，对于SwiftUI来讲更加的高效
 3. 自定义struct这特别有助于分解逻辑和布局，并且还有一个好处是使你的视图在app的其他的地方可以重用。SwiftUI会自动折叠你的视图层次结构，因此当你分解视图时，不会产生有异议的性能差异。
 */

// MARK: -
// MARK: 6、如何使用ForEach在循环中创建视图
/*
 你通常会发现需要循环序列来创建视图，而在 SwiftUI 中这是使用 ForEach 完成的。
 重要提示：很容易看到 ForEach 并认为它与 Swift 序列上的 forEach() 方法相同，但情况并非如此。
 
 SwiftUI 中的 ForEach 本身就是一个视图结构，这意味着如果需要，您可以直接从视图主体返回它。 你为其提供一个项目数组，并且您可能还需要告诉 SwiftUI 如何唯一地识别每个项目，以便它知道如何在值更改时更新它们。 您还可以向其传递一个要运行的函数，以便为循环中的每个项目创建视图。
 */

// MARK: 6.1、倒计时
/*
 对于范围内的简单循环，你将范围直接传递到 ForEach 中，并告诉 Swift 使用每个数字作为项目的唯一标识符。 例如，从 10 计数到 1，然后在末尾添加一条消息：倒计时结束。
 
 id: .self 部分是必需的，以便 SwiftUI 可以唯一地标识数组中的每个元素 - 这意味着如果您添加或删除一个项目，SwiftUI 确切地知道是哪一个。
 */

//struct ContentView: View {
//    var body: some View {
//        ForEach((1...10).reversed(), id: \.self) {
//            Text("\($0)...")
//        }
//        Text("Ready or not, here I come!")
//    }
//}

// MARK: 6.2、通过colors数组遍历创建
/*
 创建一个包含三种颜色的数组，循环遍历所有颜色，并使用每种颜色的名称和颜色值来创建文本View
 */

//struct ContentView: View {
//    let colors: [Color] = [.red, .green, .blue]
//    var body: some View {
//        ForEach(colors, id: \.self) { color in
//            Text(color.description.capitalized)
//                .padding()
//                .background(color)
//        }
//    }
//}

// MARK: 6.3、通过id属性来区分
/*
 如果数组中有自定义类型，则应使用id类型中的任何属性来唯一表示它。例如，下面创建了一个结构体，其中id属性为UUID，这意味着它保证是唯一的。
 */

/*
 ForEach告诉SwiftUI可以通过查看属性来区分内部的视图
 */

//struct ContentView: View {
//    struct SimpleGameResult {
//        let id = UUID()
//        let score: Int
//    }
//    
//    let results = [
//        SimpleGameResult(score: 8),
//        SimpleGameResult(score: 5),
//        SimpleGameResult(score: 10)
//    ]
//    
//    var body: some View {
//        ForEach(results, id: \.id) { result in
//            Text("Result: \(result.score)")
//        }
//    }
//}

// MARK: 6.4、Identifiable
/*
 SwiftUI 中的 Identifiable 是一个协议（protocol），用于为集合类型中的元素提供唯一标识符。它要求类型拥有一个名为 id 的属性，该属性用于唯一标识集合中的每个元素。
 作为替代方案，可以创建一个遵守Identifiable协议的结构体，遵守此协议意味着一定要添加一个id成员变量，用来标记每个对象
 */

//struct ContentView: View {
//    struct IdentifiableGameResult: Identifiable {
//        var id = UUID()
//        var score: Int
//    }
//    let results1 = [
//        IdentifiableGameResult(score: 8),
//        IdentifiableGameResult(score: 5),
//        IdentifiableGameResult(score: 20)
//    ]
//    var body: some View {
//        ForEach(results1) { result in
//            Text("Result: \(result.score)")
//        }
//    }
//}

// MARK: -
// MARK: 7、如何使用layoutPriority()控制布局优先级
/*
 SwiftUI 的layoutPriority() 修饰符让我们可以请求在空间有限时在屏幕上为某些视图提供更多空间。 默认情况下，所有视图的布局优先级均为 0，但如果你发现某个特定视图被压缩，你可以使用layoutPriority() 要求为其赋予更高的优先级。
 */

//struct ContentView: View {
//    var body: some View {
//        HStack{
//            Text("蜀道难蜀道难，难于上青天！")
//            Text("蚕丛及鱼凫，开国何茫然！")
//        }
//        HStack{
//            Text("蜀道难蜀道难，难于上青天！")
//            Text("蚕丛及鱼凫，开国何茫然！")
//                .layoutPriority(1)
//        }
//    }
//}

// MARK: -
// MARK: 8、如何使两个视图具有相同的宽度或高度
/*
 SwiftUI可以轻松创建两个相同大小的视图，无论你想要相同的高度还是宽度，通过组合修饰符fixedSize。
 
 在iOS上，关键时为每个要调整大小的视图提供无限量的最大宽或高度，这将自动使其拉伸以填充所有的可用空间。然后，你将其应用于fixedSize它们所在的容器，这告诉SwiftUI这些视图应该只占用它们所需要的空间。
 */

// MARK: 8.1、fixedSize(horizontal: false, vertical: true)
/*
 此例子展示了两个文本视图具有相同的高度，即使文本视图长度差异很大，由于frame和fixedSize组合使用，两个文本视图都以相同大小布局的
 */

//struct ContentView: View {
//    var body: some View {
//        HStack{
//            Text("蜀道难.")
//                .foregroundStyle(.white)
//                .padding()
//                .frame(maxHeight: .infinity)
//                .background(.red)
//            Text("蜀道之难，难于上青天！蚕丛及鱼凫，开国何茫然！")
//                .foregroundStyle(.white)
//                .padding()
//                .frame(maxHeight: .infinity)
//                .background(.green)
//        }
//        .fixedSize(horizontal: false, vertical: true)
//        .frame(maxHeight: 200)
//    }
//}

// MARK: 8.2、fixedSize(horizontal: true, vertical: false)
/*
 两个视图宽度相同
 */

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Button("Log in") { }
//                .foregroundStyle(.white)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(.red)
//                .clipShape(Capsule())
//            
//            Button(" Reset Password") { }
//                .foregroundStyle(.white)
//                .padding()
//                .frame(maxHeight: .infinity)
//                .background(.green)
//                .clipShape(Capsule())
//        }
//        .fixedSize(horizontal: true, vertical: false)
//        .frame(height: 500)
//    }
//}

// MARK: -
// MARK: 9、如何使用forgoundStyle提供视觉结构
/*
 SwiftUI 提供了 foregroundStyle() 修饰符来同时控制文本、图像和形状的样式设置方式。 最简单的形式类似于将 foregroundStyle() 与 .secondary 一起使用，但它不仅解锁了更多语义颜色 – .tertiary 和 .quaternary，还增加了对任何符合 ShapeStyle 的支持。
 */

//struct ContentView: View {
//    var body: some View {
//        HStack {
//            Image(systemName: "clock.fill")
//            Text("Set the time")
//        }
//        .font(.largeTitle.bold())
//        .foregroundStyle(.quaternary)
//    }
//}

// MARK: 9.2、ShapeStyle
/*
 foregroundStyle遵守ShapeStyle协议，这就意味这任何遵守ShapeStyle协议的View都可以修饰，此案例设置Hsatck的线性渐变
 */

//struct ContentView: View {
//    var body: some View {
//        HStack {
//            Image(systemName: "clock.fill")
//            Text("Set the time")
//        }
//        .font(.largeTitle.bold())
//        .foregroundStyle(
//            .linearGradient(colors: [.red, .black], startPoint: .top, endPoint: .bottom)
//        )
//    }
//}

// MARK: -
// MARK: 10、如何使用自定义内容插入safeArea
/*
 SwiftUI提供了一个safeAreaInset修饰符，允许我们将内容放置在安全区域之外，同时还可以让其他视图调整其布局，使其内容保持可见，以确保所有的内容都可以按照预期显示在屏幕上。这与ignoresSafeArea不同，后者只是扩展视图边缘。
 */

// MARK: 10.1、safeAreaInset(edge: .bottom, spacing: 100)
/*
 在iOS15.2之前，这只适用于ScrollView，在15.2之后，List和Form也可以用
 */

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            List(0..<100) { i in
//                Text("Row \(i)")
//            }
//            .navigationTitle("Select a row")
//            .safeAreaInset(edge: .bottom, spacing: 100) {
//                Text("Outside Safe Area")
//                    .font(.largeTitle)
//                    .foregroundStyle(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(.indigo)
//            }
//        }
//    }
//}

// MARK: 10.2、alignment

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            List(0..<100) { i in
//                Text("Row \(i)")
//            }
//            .navigationTitle("Select a row")
//            .safeAreaInset(edge: .bottom, alignment: .trailing) {
//                Button {
//                    print("Show help")
//                } label: {
//                    Image(systemName: "info.circle.fill")
//                        .font(.largeTitle)
//                        .symbolRenderingMode(.multicolor)
//                        .padding(.trailing)
//                }
//                .accessibilityLabel("Show help")
//            }
//        }
//    }
//}

// MARK: -
// MARK: 11、如何隐藏主页指示器和其他系统UI
/*
 SwiftUI 的 persistenceSystemOverlays() 修饰符让我们可以显示或隐藏所谓的“非瞬态系统视图”，这些视图自动放置在我们的 UI 上 - 苹果对主页指示器的名称、iPad 上的多任务指示器等等。
 */

//struct ContentView: View {
//    var body: some View {
//        Text("This needs to take up lots of space")
//            .frame(maxWidth: .infinity,maxHeight: .infinity)
//            .background(.yellow)
//            .persistentSystemOverlays(.hidden)
//    }
//}

// MARK: -
// MARK: 12、如何阻止系统手势干扰你自己的手势
/*
 SwiftUI 的 defersSystemGestures() 修饰符允许我们请求我们的手势优先于系统自己的内置手势。 这在很多地方都很重要，例如用户可能会频繁滑动的游戏，或者当您将自己的手势放在屏幕边缘时。
 */

//struct ContentView: View {
//    var body: some View {
//        Text("Current value: \(input)")
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .contentShape(Rectangle())
//            .gesture(
//                DragGesture().onChanged({ value in
//                    input = value.location.y - value.startLocation.y
//                })
//            )
//            .defersSystemGestures(on: .vertical)
//    }
//}

/*
 在 iOS 上，它做了三件不同的事情：
 1. 如果用户从顶部向下拉，他们会看到一个需要再次拉动的小选项卡，而不是立即出现控制中心 - 他们更难意外激活控制中心。
 2. 主页指示器将淡出至较低的不透明度，如果用户直接拖动该淡出的主页指示器，则主页指示器将淡入。然后，他们可以再次向上滑动以进入任务切换器或主屏幕。
3. 如果用户从底部向上滑动到主页指示器的任意一侧，则会发生我们的拖动手势。

 */

// MARK: -
// MARK: 13、如何在VStack和HStack之间动态切换
/*
 SwiftUI 的 AnyLayout 结构允许我们根据我们想要考虑的任何环境上下文在 HStack 和 VStack 之间自由切换 - 只需记住使用每个的符合布局的变体即可。
 
 与使用AnyView不同，AnyLayout不会产生任何性能影响，并且不会丢弃其子视图的任何状态。
 */

// MARK: 13.1、horizontalSizeClass

//@Environment(\.horizontalSizeClass) var horizontalSizeClass
//
//let layout = horizontalSizeClass == .regular ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
//
//layout {
//    Image(systemName: "1.circle")
//    Image(systemName: "2.circle")
//    Image(systemName: "3.circle")
//}
//.font(.largeTitle)

// MARK: 13.2、dynamicTypeSize

//@Environment(\.dynamicTypeSize) **var** dynamicTypeSize
//
//let layout = dynamicTypeSize <= .xxxLarge ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
//layout {
//    Image(systemName: "1.circle")
//    Image(systemName: "2.circle")
//    Image(systemName: "3.circle")
//}
//.font(.largeTitle)

// MARK: -
// MARK: 14、如何使用Layout Protocol创建自定义布局
/*
 SwiftUI 允许我们使用布局协议为视图创建完全自定义的布局，并且我们的自定义布局可以像 HStack、VStack 或任何其他内置布局类型一样使用。
 采用Layout协议只有两个要求：

 返回布局为其子视图需要多少空间的方法。 这将得到一个大小建议，即父视图有多少可用空间。 这可能会被多次调用，以便 SwiftUI 可以了解您的容器的灵活性。
 另一种方法实际上将这些子视图放置在您想要的位置。 这将被给予与第一种方法相同的大小建议，但也会被给予特定的范围来使用——这将是

 如果你做的函数很复杂，执行起来特别慢，你也可以选择让这些方法缓存它们的计算，这是一种猜测，目前没遇到过。
 当你给出一个frame时，他的宽度或高度可能包含nil值，因此，通常在天上调用repalcingUnspecifiedDimensions,以便将任何nil值替换为非nil值
 */

//struct RadialLayout: Layout {
//    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//        //接受完整的建议空间，用合理的默认值替换任何nil值
//        proposal.replacingUnspecifiedDimensions()
//    }
//    
//    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
//        //计算边界的半径
//        let radius = min(bounds.size.width, bounds.size.height) / 2
//        //求出圆上每个子视图之间的夹角
//        let angle = Angle.degrees(360 / Double(subviews.count)).radians
//        
//        for (index, subView) in subviews.enumerated() {
//            //询问这个视图的理想尺寸
//            let viewSize = subView.sizeThatFits(.unspecified)
//            //计算x、y的位置，时视图位于圆的边缘内
//            let xPos = cos(angle * Double(index) - .pi / 2) * (radius - viewSize.width / 2)
//            let yPos = cos(angle * Double(index) - .pi / 2) * (radius - viewSize.height / 2)
//            //使用其自然大小（未指定），将此视图相对于我们的中心位置。
//            let point = CGPoint(x: bounds.midX + xPos, y: bounds.midY + yPos)
//            subView.place(at: point, anchor: .center, proposal: .unspecified)
//        }
//    }
//}
//
//struct ContentView: View {
//    @State private var count = 16
//    var body: some View {
//        //我现在可以像任何其他布局类型一样使用它。例如，我可以在周围放置一些形状，使用stepper来控制显示的数量
//        RadialLayout {
//            ForEach(0..<count, id: \.self) {_ in
//                Circle()
//                    .frame(width: 32, height: 32)
//            }
//        }
//        .safeAreaInset(edge: .bottom) {
//            Stepper("Count: \(count)",value: $count.animation(), in: 0...36)
//                .padding()
//        }
//    }
//}

// MARK: -
// MARK: 15、如何使用ViewThatFits创建自适应布局
/*
 SwiftUI 为我们提供了 ViewThatFits，以便我们可以根据适合可用屏幕空间的布局从几种可能的布局中选择一种。 这使其成为确保您的应用程序从最大的 tvOS 屏幕到最小的 Apple Watch 都具有出色外观的绝佳方式。
 */

// MARK: 15.1、ViewThatFits基础形式
/*
 在最简单的形式中，你应该从最首选到最不首选列出您想要的所有布局替代方案，SwiftUI 将尝试所有这些，直到找到适合该空间的一个。👇例子选择顺序为：大文本长标题 -> 大文本短标题 -> 小文本短标题
 */

//struct ContentView: View {
//    var body: some View {
//        ViewThatFits {
//            Label("Wecome to AwsoemApp", systemImage: "bolt.shield")
//                .font(.largeTitle)
//            Label("Wecome", systemImage: "bolt.shield")
//                .font(.largeTitle)
//            Label("Wecome", systemImage: "bolt.shield")
//        }
//    }
//}

// MARK: 15.2、多个按钮的横/纵自动布局
/*
 创建一个具有四个不同按钮的button，然后可以根据空间大小决定水平还是垂直排列它们，这是非常有效的自定义布局的一种方式。
 */

//struct OptionsView: View {
//    var body: some View {
//        Button("Log in") { }
//            .buttonStyle(.borderedProminent)
//        Button("Create Account") { }
//            .buttonStyle(.bordered)
//        Button("Settings") { }
//            .buttonStyle(.bordered)
//        Spacer().frame(width: 50, height: 50)
//        Button("Need Help?") {}
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        ViewThatFits {
//            HStack {
//                OptionsView()
//            }
//            VStack {
//                OptionsView()
//            }
//        }
//    }
//}

// MARK: 15.3、ViewThatFits处理文本布局的方式
/*
 在SwiftUI中，文本更喜欢放在一行上，默认情况下ViewTahtFits更喜欢避免布局导致文本换行。因此，当空间有限时，像这样的代码会默认为VStack，而不是使用带有换行文本的HStack
 */

//struct ContentView: View {
//    var body: some View {
//        ViewThatFits {
//            HStack {
//                Text("The rain")
//                Text("in Spain")
//                Text("falls mainly")
//                Text("on the Spaniards")
//            }
//            
//            VStack {
//                Text("The rain")
//                Text("in Spain")
//                Text("falls mainly")
//                Text("on the Spaniards")
//            }
//        }
//        .font(.title)
//    }
//}

/*
 这里发生的是ViewThatFits正在水平和垂直测量我们的文本，并试图找到适合这两个维度的文本的情况--文本适合一行的情况，而不被截断垂直。这有时会导致问题，但幸运的事，我可以告诉ViewThatFits只关心一个维度，这样就可以获得更多的控制。
 */

// MARK: 15.4、ViewThatFits在ScrollView的应用
/*
 假设你想要向用户显示一些条款和条件，如果可以在有限的空间内展示，那么将其作为固定文本，否者将其显示为滚动文本
 */

//struct ContentView: View {
//    let terms = String(repeating: "abcde", count: 100)
//    
//    var body: some View {
//        ViewThatFits() {
//            Text(terms)
//            ScrollView {
//                Text(terms)
//            }
//        }
//        .frame(height: 100)
//    }
//}

// MARK: 15.5、ViewThatFits(in: .vertical)
/*
 除非有一个巨大的屏幕，否则将始终选择滚动版本，因为我们要求ViewThatFits关心文本的水平轴和垂直轴，这意味着一旦文本超过一行就是这个结果。SwiftUI更倾向于这种布局，为了解决这个问题，我们需要限制ViewThatFits为仅测量垂直轴（.vertical）
 */

//struct ContentView: View {
//    let terms = String(repeating: "abcde", count: 100)
//
//    var body: some View {
//        ViewThatFits(in: .vertical) {
//            Text(terms)
//            ScrollView {
//                Text(terms)
//            }
//        }
//        .frame(height: 100)
//    }
//}

// MARK: -
// MARK: 16、如何向safeArea添加额外的填充
/*
 SwiftUI 中的 safeAreaPadding() 修饰符可以选择性地将安全区域内部缩进一定的距离，可以选择在所有边缘或子集上进行缩进。在处理滚动内容时，它与使用普通的 padding() 修饰符的行为不同，因为它会将滚动视图的内容缩进，而不是缩进滚动视图本身。
 
 简而言之，safeAreaPadding() 修饰符是用于处理安全区域内部内容的缩进。安全区域是指屏幕上不被刘海、下巴、圆角等设备特定元素所覆盖的区域。
 
 通过使用 safeAreaPadding() 修饰符，您可以确保内容不会与设备的安全区域重叠，以提供更好的用户体验和可读性。
 */

// MARK: 16.1 safeAreaPadding基础用法

//struct ContentView: View {
//    var body: some View {
//        // 绘制一个红色圆，安全区域设置为50
//        Circle()
//            .fill(.red)
//            .safeAreaPadding(50)
//
//        // 只控制横向 50
//        Circle()
//            .fill(.red)
//            .safeAreaPadding(.horizontal, 50)
//
//        // Edgeinsets，四边分别控制
//        Circle()
//            .fill(.red)
//            .safeAreaPadding(.init(top: 20, leading: 50, bottom: 20, trailing: 50))
//    }
//}

// MARK: 16.2、关于ScrollView
/*
 当我对ScrollView应用safeAreaPadding时，事情就变得有趣了，因为它确保我们的内容从屏幕的边缘开始。
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView(.horizontal) {
//            HStack {
//                ForEach(0..<10) {i in
//                    Circle()
//                        .frame(width: 50, height: 50)
//                }
//            }
//        }
//        .safeAreaPadding(50)
//    }
//}

// MARK: -
// MARK: 17、如何根据视图大小和位置动态调整视图的外观
/*
 SwiftUI 的 VisualEffect() 修饰符允许我们在不使用 GeometryReader 的情况下读取视图的几何代理，这意味着我们可以查看视图的大小和位置，而不影响其布局行为。
 
 重要提示：此修改器专门用于应用视觉效果，例如调整颜色或添加模糊，并且无法调整出于布局目的计算内容框架的方式。 它可以调整类似框架的内容，例如视图的偏移和比例，因为它们不会影响布局。
 */

// MARK: 17.1、模糊效果
/*
 代码将滚动视图中的每个视图模糊一定的模糊量，该模糊量是根据视图距其滚动视图中心的距离计算的。 这意味着垂直中心附近的视图很少或没有模糊，而外部的视图则严重模糊：
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView {
//            ForEach(0..<100) { i in
//                Text("Row \(i)")
//                    .font(.largeTitle)
//                    .frame(maxWidth: .infinity)
//                    .visualEffect { content, proxy in
//                        content.blur(radius: blurAmount(for: proxy))
//                    }
//            }
//        }
//    }
//    
//    func blurAmount(for proxy: GeometryProxy) -> Double {
//        let scrollViewHeight = proxy.bounds(of: .scrollView)?.height ?? 100
//        let ourCenter = proxy.frame(in: .scrollView).midY
//        let distanceFromCenter = abs(scrollViewHeight / 2 - ourCenter)
//        return Double(distanceFromCenter) / 100
//    }
//}

/*
 调用proxy.frame(in: .scrollView)在包含该视图的最内层滚动视图中查找该视图的大小
 */

// MARK: 17.2、rotationEffect
/*
 这些视觉效果适用于任何类型的位置，包括通过动画生成的位置。 例如，这使得网格中的一系列圆圈旋转，每个圆圈根据色调旋转动态重新着色。
 */

//struct ContentView: View {
//    @State private var rotationAmount = 0.0
//
//    var body: some View {
//        Grid {
//            ForEach(0..<3) {_ in
//                GridRow{
//                    ForEach(0..<3) {_ in
//                        Circle()
//                            .fill(.green)
//                            .frame(width: 100, height: 100)
//                            .visualEffect { content, proxy in
//                                content.hueRotation(.degrees(proxy.frame(in: .global).midY / 2))
//                            }
//                    }
//                }
//            }
//        }
//        .rotationEffect(.degrees(rotationAmount))
//        .onAppear {
//            withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
//                rotationAmount = 360
//            }
//        }
//    }
//}

// MARK: -
// MARK: 18、如何调整一个视图相对于其container的大小
/*
 SwiftUI 的 containerRelativeFrame() 是一种简单但功能强大的方法，可以使视图具有相对于其容器的大小，容器可能是它们的整个窗口、它们所在的滚动视图，甚至只是布局中的一列。
 
 您需要提供三个核心值：您尝试设置哪个轴，您想要将空间划分为多少部分，以及应该为每个视图分配多少部分。
 */

struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<10) { i in
                    Text("Item \(i)")
                        .foregroundStyle(.white)
                        .containerRelativeFrame(.horizontal, count: 5, span: 2, spacing: 10)
                        .background(.blue)
                }
            }
        }
    }
}

/*
 👆例子针对ScrollView中的视图，它们应该是其容器宽度的2/5，需要明确的是：

 count参数是指ScrollView的水平空间应该分成多少部分，
 span参数指的是应该为每个文本视图分配多少部分，
 
 关于使用容器相对框架有两个点：

 如果需要，可以使用多个轴 [. horizontal, .vertical]
 默认的对齐方式为.center，但是你可以用任何你想要的来指定自定义的对齐方式参数
 */
