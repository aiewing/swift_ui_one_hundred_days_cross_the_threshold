//
//  ContentView.swift
//  004-Stacks,Grids,ScrollViews
//
//  Created by 舒毅文 on 2024/2/22.
//

import SwiftUI

#Preview {
    ContentView()
}

// MARK: -
// MARK: 1、如何创建VStack和HStack
/*
 SwiftUI的内容视图必须包含一个或多个视图，这是我们希望它们显示的布局。 当我们想要一次在屏幕上显示多个视图时，就要使用VStack和HStack来决定视图的纵向还是横向排列。Stack - 相当于 UIKit 中的 UIStackView - 具有三种形式：水平 (HStack)、垂直 (VStack) 和基于深度 (ZStack)，当您想要放置子视图以使它们重叠时，使用后者。
 */

//struct ContentView: View {
//    var body: some View {
//        List {
//            Section {
//                Text("Hello, SwiftUI")
//            }
//            Section {
//                VStack {
//                    Text("Hello")
//                    Text("SwiftUI")
//                }
//            }
//            Section {
//                HStack {
//                    Text("Hello")
//                    Text("SwiftUI")
//                }
//            }
//        }
//    }
//}

// MARK: -
// MARK: 2、如何通过alignment和spacing自定义stack布局
/*
 默认情况下，stack中的View居中对齐，在HStack的情况下，这意味着项目在中间垂直对齐，因此如果你有两个不同高度的Text，它们都会与垂直中心对齐。对于VStack，意味着View在中间水平对齐，因此如果你有两个不同长度的Text视图，它们都会中心对齐
 */

// MARK: 2.1、spacing

//struct ContentView: View {
//    var body: some View {
//        // 内间距
//        VStack(spacing: 20, content: {
//            Text("Hi")
//            Text("Swift UI")
//            Text("Swift UI")
//        })
//    }
//}

// MARK: 2.2、Divider

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Hi")
//            Divider()
//            Text("Swift UI")
//        }
//    }
//}

// MARK: 2.3、alignment
/*
 如果要调整对齐方式，在创建stack时加入alignment参数
 */

//struct ContentView: View {
//    var body: some View {
//        VStack(alignment: .leading, content: {
//            Text("Hi")
//            Text("Swift UI")
//        })
//    }
//}

// MARK: 2.4、同时设置alignment与spacing

//struct ContentView: View {
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20, content: {
//            Text("Hi")
//            Text("Swift UI")
//        })
//
//    }
//}

// MARK: -
// MARK: 3、如何使用 Spacer 将视图强制到stack内的一侧
/*
 SwiftUI默认情况下将视图居中，这意味着如果你将三个Text放入Vstack内，则所有的Text都将在屏幕中垂直居中。如果你想更改，比如你想让强制视图朝向屏幕顶部、底部、左侧或右侧，那么你就要使用Spacer视图
 */

// MARK: 3.1、在视图下方添加spacer
/*
 要将文本视图推到父级的顶部，在下方放一个间隔符spacer
 */

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Hello, World!")
//            Spacer()
//        }
//    }
//}

// MARK: 3.2、在视图中间添加spacer
/*
 在横向Stack中，如果你要是视图放置在两侧，在中间添加spacer
 */

//struct ContentView: View {
//    var body: some View {
//        HStack {
//            Text("Hello")
//            Spacer()
//            Text("World")
//        }
//    }
//}

// MARK: 3.3、按照特定需求添加spacer
/*
 如果想要将文本放置在其父视图1/3中的位置，那么就在Text之前放置1个spacer，在之后放置2个spacer
 */

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Spacer()
//            Text("Hello, World!")
//            Spacer()
//            Spacer()
//        }
//    }
//}

// MARK: -
// MARK: 4、如何创建固定宽高的spacer
/*
 SwiftUI的Spacer视图会自动填充其扩展轴上的所有可用空间，这是一种奇特的说法，它在水平或垂直方向上占据了尽可能多的空间，具体要取决于你放置它们内容
 */

// MARK: 4.1、frame(height: 50)
/*
 创建2个文本视图，中间间隔符距离为50
 */

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Hi, FF!")
//            Spacer()
//                .frame(height: 50)
//            Text("Hi, BBLv~")
//        }
//    }
//}

// MARK: 4.2、minLength
/*
 如果你为间隔符指定一个值范围，那么使用.frame(minHeight: 50, maxHeight: 500),那么它将自动占用尽可能多的空间，知道你设置的最大值。这种方式使创建视图增加了灵活性。某些情况下，你希望指定与其布局方向无关的间隔符大小，例如，如果你的视图的排列方向可能是动态的（VStack或HStack），你的需求时无论哪个方向，两个视图之间的间隔符都添加最少50距离
 */

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Hi, FF!")
//            Spacer(minLength: 50)
//            Text("Hi, BBLv~")
//        }
//    }
//}

/*
 这是最小的长度，因此如果可用空间更多，spacer会变大
 */

// MARK: -
// MARK: 5、如何使用ZStack将视图分层
/*
 SwiftUI有一个专用的Stack类型，用于创建重叠内容，例如，如果你想在图片上放置一些文本，它是ZStack，原理类似HStack与VStack
 */

// MARK: 5.1 在文本下面添加一个图片

//struct ContentView: View {
//    var body: some View {
//        ZStack {
//            Image("strawberry-surprise")
//                .scaledToFit()
//                .background(.red)
//            Text("Hi, BBLv!")
//                .font(.largeTitle)
//                .foregroundStyle(.white)
//                .background(.black)
//        }
//    }
//}

// MARK: 5.2、通过Alignment方式创建

//struct ContentView: View {
//    var body: some View {
//        ZStack(alignment: .leading) {
//            Image("strawberry-surprise")
//                .scaledToFit()
//            Text("Hi, BBLv!")
//                .font(.largeTitle)
//                .foregroundStyle(.white)
//                .background(.black)
//        }
//    }
//}

// MARK: 5.3、设置水印
/*
 通过offset将Text添加在Image右下方
 */

//struct ContentView: View {
//    var body: some View {
//        ZStack(alignment: .bottomTrailing) {
//            Image("strawberry-surprise")
//                .scaledToFit()
//            Text("Hi, BBLv!")
//                .font(.largeTitle)
//                .foregroundStyle(.white)
//                .background(.black)
//                .offset(CGSize(width: -40.0, height: -10.0))
//        }
//    }
//}

// MARK: 6、如何通过zIndex更改视图分层的顺序（优先级）
/*
 默认情况下，SwiftUI的ZStack使用画家算法来分层其视图来决定视图的深度：无论你先放入ZStack的什么内容都会被先绘制，然后后续的视图将在其上分层。虽然这通常是你想要的，但有时你需要更多的控制-例如，你可能需要在app运行时将一个视图推到另一个视图后面，或者在点击某个特定视图时将其置于前面。为此，你需要使用zIndex修饰符，它允许你准确指定视图在单个ZStack中如何分层。视图默认Z索引为0，但你可以设置正值或负值，分别将它们放置在其他视图的顶部或下方
 */

//struct ContentView: View {
//    var body: some View {
//        //此ZStack包含两个重叠的矩形，但绿色矩形仍然可见，因为它设置zIndex为1
//        ZStack {
//            Rectangle()
//                .fill(.green)
//                .frame(width: 50, height: 50)
//                .zIndex(1)
//            Rectangle()
//                .fill(.red)
//                .frame(width: 100, height: 100)
//        }
//        //zIndex修饰符仅影响当前ZStack内的绘制顺序，如果你有两个ZStack，需要分别设定
//    }
//}

// MARK: 7、如何使用尺寸类别创建不同的Layouts
/*
 SwiftUI通过将尺寸类暴露在环境中供我们阅读原生支持尺寸类。要使用它们，首先创建一个将存储其值的@Environment对象，然后在需要时检查该属性的值，查找.compact或.regular大小类。

 compact: 表示紧凑的尺寸类别。通常用于较小的屏幕或限制空间的界面布局。
 regular: 表示常规的尺寸类别。通常用于较大的屏幕或具有更多空间的界面布局
 */

//struct ContentView: View {
//    @Environment(\.horizontalSizeClass) var horizontalSizeClass
//    
//    var body: some View {
//        if horizontalSizeClass == .compact {
//            return Text("Compact Size Class")
//        } else {
//            return Text("Regular Size Class")
//        }
//    }
//}

/*
 通过检查 FFLayoutsSizeClasses 的 horizontalSizeClass 和 verticalSizeClass 属性来获取当前设备的尺寸类别。
 
 使用 SwiftUI 的 @Environment 属性包装器来获取尺寸类别信息。
 
 在 iPad 上，用户界面的尺寸类别通常是 regular，因为 iPad 屏幕较大，提供了足够的空间来显示更多内容。而在 iPhone 的竖屏模式下，尺寸类别通常是 compact，因为屏幕相对较小，需要更紧凑的布局。
 */

// MARK: -
// MARK: 8、如何使用ScrollView添加水平和垂直滚动
/*
 SwiftUI的ScrollView可以创建视图的滚动容器，因为它会自动调整自身大小以适合我们放置在其中的内容
 */

// MARK: 8.1、基础样式
/*
 一个包含10个文本的滚动列表
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 20, content: {
//                ForEach(0..<10) {
//                    Text("Item \($0)")
//                        .foregroundStyle(.white)
//                        .font(.largeTitle)
//                        .frame(width: 200, height: 200)
//                        .background(.red)
//                }
//            })
//        }
//        .frame(height: 350)
//    }
//}

// MARK: 8.2、horizontal
/*
 ScrollView默认是垂直的，但你可以通过传入.horizontal参数作为第一个参数来控制轴
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView(.horizontal) {
//            HStack(spacing: 20, content: {
//                ForEach(0..<10) {
//                    Text("Item \($0)")
//                        .foregroundStyle(.white)
//                        .font(.largeTitle)
//                        .frame(width: 200, height: 200)
//                        .background(.red)
//                }
//            })
//        }
//    }
//}

// MARK: 8.3、showsIndicators
/*
 是否在滚动发生时显示滚动显示器(showsIndicators)
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 20, content: {
//                ForEach(0..<10) {
//                    Text("Item \($0)")
//                        .foregroundStyle(.white)
//                        .font(.largeTitle)
//                        .frame(width: 200, height: 200)
//                        .background(.red)
//                }
//            })
//        }
//    }
//}

// MARK: -
// MARK: 9、如何使用ScrollViewReader使scrollView移动到某个位置
/*
 如果你想SwiftUI的ScrollView移动到特定位置，你应该在其中嵌入ScrollViewReader。它提供了一个scrollTo()方法，只需要提供其锚点即可移动到父ScrollView内的任何视图
 */

// MARK: 9.1、scrollTo
/*
 👇例子，在ScrollView中创建100个彩色框，当按下按钮，他会直接滚动到ID为8的框
 */

//struct ContentView: View {
//    let colors: [Color] = [.red, .green, .blue]
//    var body: some View {
//        ScrollViewReader(content: { value in
//            ScrollView {
//                Button("Jump to 8") {
//                    value.scrollTo(8)
//                }
//                .padding()
//                
//                ForEach(0..<100) { i in
//                    Text("Example \(i)")
//                        .font(.title)
//                        .frame(width: 200, height: 200)
//                        .background(colors[i % colors.count])
//                        .id(i)
//                }
//            }
//        })
//        .frame(height: 350)
//    }
//}

// MARK: 9.2、scrollTo(8, anchor: .top)
/*
 为了更好的控制滚动，你可以指定成为锚点的第二个参数，以控制滚动完成后目标视图的位置
 */

//struct ContentView: View {
//    let colors: [Color] = [.red, .green, .blue]
//    var body: some View {
//        ScrollViewReader(content: { value in
//            ScrollView {
//                Button("Jump to 8") {
//                    value.scrollTo(8, anchor: .top)
//                }
//                .padding()
//                
//                ForEach(0..<100) { i in
//                    Text("Example \(i)")
//                        .font(.title)
//                        .frame(width: 200, height: 200)
//                        .background(colors[i % colors.count])
//                        .id(i)
//                }
//            }
//        })
//        .frame(height: 350)
//    }
//}

// MARK: 9.3、withAnimation
/*
 如果你在withAnimation中调用scrollTo()，会有动画效果
 */

//struct ContentView: View {
//    let colors: [Color] = [.red, .green, .blue]
//    var body: some View {
//        ScrollViewReader(content: { proxy in
//            ScrollView {
//                Button("Jump to #88") {
//                    withAnimation {
//                        proxy.scrollTo(88, anchor: .top)
//                    }
//                }
//                .padding()
//                
//                ForEach(0..<100) { i in
//                    Text("Example \(i)")
//                        .font(.title)
//                        .frame(width: 200, height: 200)
//                        .background( colors[i % colors.count])
//                        .id(i)
//                }
//            }
//        })
//        .frame(height: 350)
//    }
//}

// MARK: -
// MARK: 10、如何使用ScrollView和GeometryReader创建Cover Flow等3D效果
/*
 如果将GeometryReader与任何可以更改的视图（例如具有拖动手势或位于列表内的视图）相结合，就可以创建屏幕上看起来很棒的3D效果。GeometryReader可以读取视图的坐标，并将这些值直接输入到rotation3DEffect()修饰符中
 */

// MARK: 10.1、GeometryReader
/*
 创建ScrollView，使其水平方向滑动，循环创建文本视图，然后使用rotation3DEffect()来创建Cover Flow的滚动效果
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 0) {
//                ForEach(1..<20) { num in
//                    GeometryReader(content: { geometry in
//                        Text("Number \(num)")
//                            .font(.largeTitle)
//                            .padding()
//                            .background(.red)
//                            .rotation3DEffect(.degrees(-Double(geometry.frame(in: .global).minX) / 8),axis: (x: 0.0, y: 1.0, z: 0.0))
//                            .frame(width:200, height: 200)
//                    })
//                    .frame(width: 200, height: 200)
//                }
//            }
//        }
//    }
//}

// MARK: 10.2、DragGesture
/*
 不一定总使用GeometryReader来实现这个效果，也可以使用DragGesture()来实现类似的效果。因此，此代码创建一个类似卡片的矩形，可以在X轴和Y轴上推动，并使用两个rotation3DEffect()修饰符来应用
 */

//struct ContentView: View {
//    @State var dragAmount = CGSize.zero
//    var body: some View {
//        VStack {
//            Rectangle()
//                .fill(LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                .frame(width: 200, height: 150)
//                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .rotation3DEffect(.degrees(-Double(dragAmount.width) / 20), axis: (x: 0, y: 1, z: 0))
//                .rotation3DEffect(.degrees(Double(dragAmount.height)), axis: (x: 1, y: 0, z: 0))
//                .offset(dragAmount)
//                .gesture(
//                    DragGesture()
//                        .onChanged({
//                            dragAmount = $0.translation
//                        })
//                        .onEnded({ _ in
//                            withAnimation(.spring()) {
//                                dragAmount = .zero
//                            }
//                        })
//                )
//        }
//        .frame(width: 400, height: 400)
//    }
//}

// MARK: -
// MARK: 11、如何使用LazyVStack和LazyHStack延迟加载视图
/*
 默认情况下，SwiftUI的VStack和HStack会预先加载所有的内容，如果你在ScrollView使用它，可能会很慢，如果你想延迟加载内容-即今当内容滚动到视图中时，你应该考虑使用LazyVStack和LazyHStack
 */

// MARK: 11.1、基础式样
/*
 创建100个垂直排列的Text，确保每个Text在滚动到视图中才创建
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView {
//            LazyVStack {
//                ForEach(1...100, id: \.self) { value in
//                    Text("Row \(value)")
//                }
//            }
//        }
//        .frame(height: 300)
//    }
//}

/*
 这些懒加载的stack在布局中具有自适应的首选宽度，因此它们会以与常规stack不同的方式占用空闲空间，👆的代码，你会发现可以在文本周围的空白处拖动，如果你切换到常规的垂直stack，就只能点文本本身拖动。
 */

// MARK: 11.2、工作原理
/*
 使用懒加载Stack，SwiftUI会在首次显示时自动创建视图，之后，该视图将保存在内存中，因此要注意显示内容的量。如果想了解懒加载在实践中是如何工作的
 */

//struct ContentView: View {
//    // 创建一个可以打印的View
//    struct SampleRow: View {
//        let id: Int
//        
//        var body: some View {
//            Text("Row \(id)")
//        }
//        
//        init(id: Int) {
//            print("loading row \(id)")
//            self.id = id
//        }
//    }
//
//    var body: some View {
//        // 添加到ScrollView中
//        ScrollView {
//            LazyVStack {
//                ForEach(1...1000, id: \.self) { i in
//                    SampleRow(id: i)
//                }
//            }
//        }
//        .frame(height: 300)
//    }
//}

// MARK: -
// MARK: 12、如何在fixed Grid中定位视图
/*
 SwiftUI的GridView可以创建静态网格视图，并精确控制每行每列中的内容，你可以使用GridRow标记各个行，然后还可以选择配置每个单元格的宽度
 */

// MARK: 12.1、基础样式
/*
 创建一个2*2的网格，其中的文本表示每个单元格的位置
 */

//struct ContentView: View {
//    var body: some View {
//        Grid {
//            GridRow {
//                Text("Top Leading")
//                    .background(.red)
//                Text("Top Trailing")
//                    .background(.orange)
//            }
//            GridRow {
//                Text("Bottom Leading")
//                    .background(.red)
//                Text("Bottom Trainling")
//                    .background(.blue)
//            }
//        }
//        .font(.title)
//    }
//}

// MARK: 12.2、自由添加item
/*
 如果你不希望每行中有相同数量的单元格，有三种方式。首先，如果什么都不做，SwiftUI将自动插入空单元格，以确保行数相等。因此，在此代码中，我们可以自由的添加红色和蓝色的数量，并且SwiftUI会保持整个布局的平衡
 */

//struct ContentView: View {
//    @State private var redScore = 0
//    @State private var blueScore = 0
//    var body: some View {
//        Grid {
//            GridRow {
//                Text("red")
//                ForEach(0..<redScore, id: \.self) { _ in
//                    Rectangle()
//                        .fill(.red)
//                        .frame(width: 20, height: 20)
//                }
//            }
//            GridRow {
//                Text("blue")
//                ForEach(0..<blueScore, id: \.self) { _ in
//                    Rectangle()
//                        .fill(.blue)
//                        .frame(width: 20, height: 20)
//                }
//            }
//        }
//        .font(.title)
//
//        Button("Add to Red") {
//            redScore += 1
//        }
//
//        Button("Add to Blue") {
//            blueScore += 1
//        }
//    }
//}

// MARK: 12.3、gridCellColumns()
/*
 第二个方法是将视图放入Grid中，而不是将它们包装在GridRow中，这将导致它们自己占据整行，这对于分隔符视图非常有用，第三种方法选择使用gridCellColumns()修饰符，使一个单元格跨多个列
 */

//struct ContentView: View {
//    var body: some View {
//        Grid {
//            GridRow {
//                Text("Food")
//                Text("$200")
//            }
//            GridRow {
//                Text("Tent")
//                Text("$800")
//            }
//            GridRow {
//                Text("Candles")
//                Text("$36200")
//            }
//            
//            Divider()
//            GridRow {
//                Text("$4600")
//                    .gridCellColumns(2)
//                    .multilineTextAlignment(.trailing)
//            }
//        }
//    }
//}

/*
 使用具有相同数列数的‘gridCellColumns()’方法与将视图放在GridRow中得到的结果相同
 */

// MARK: 12.4、使用网格创建一个井字棋游戏版

//struct ContentView: View {
//    var body: some View {
//        Grid(horizontalSpacing: 20, verticalSpacing: 20) {
//            GridRow {
//                Image(systemName: "xmark")
//                Image(systemName: "xmark")
//                Image(systemName: "xmark")
//            }
//            GridRow {
//                Image(systemName: "circle")
//                Image(systemName: "xmark")
//                Image(systemName: "circle")
//            }
//            GridRow {
//                Image(systemName: "xmark")
//                Image(systemName: "circle")
//                Image(systemName: "circle")
//            }
//        }
//        .font(.largeTitle)
//    }
//}

// MARK: 12.5、使用网格创建类似国际象棋棋盘

//struct ContentView: View {
//    var body: some View {
//        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
//            ForEach(0..<8) { row in
//                GridRow {
//                    ForEach(0..<8) { col in
//                        if (row + col).isMultiple(of: 2) {
//                            Rectangle()
//                                .fill(.black)
//                        } else {
//                            Rectangle()
//                                .fill(.red)
//                        }
//                    }
//                }
//            }
//        }
//        .aspectRatio(1, contentMode: .fit)
//        .border(.black, width: 1)
//        .padding()
//    }
//}

// MARK: -
// MARK: 13、如何使用LazyVGrid和LazyHGrid在网格中定位视图
/*
 SwiftUI的LazyVGrid和LazyHGrid为我们提供了具有相当灵活性的网格布局。最简单的网格由三部分组成：原始数据、描述所需布局的GridItem数组，以及将数据和布局组合在一起的LazyVGrid或LazyHGrid
 */

// MARK: 13.1、GridItem(.adaptive(minimum:80))
/*
 使用GridItem(.adaptive(minimum:80))意味着我希望网格可以容纳尽可能多的数量，每行最小为80
 */

//struct ContentView: View {
//    var body: some View {
//        let data = (1...100).map {
//            "Item \($0)"
//        }
//
//        let columns = [
//            GridItem(.adaptive(minimum: 80))
//        ]
//
//        ScrollView {
//            LazyVGrid(columns: columns, spacing: 20, content: {
//                ForEach(data, id: \.self) { item in
//                    Text(item)
//                }
//            })
//            .padding()
//        }
//        .frame(maxHeight: 300)
//    }
//}

// MARK: 13.2、flexible
/*
 如果你想控制列数，可以使用.flexible()代替，它还可以指定每个item的大小
 */

//struct ContentView: View {
//    var body: some View {
//        let data = (1...100).map {
//            "Item \($0)"
//        }
//
//        let columns1 = [
//            GridItem(.flexible()),
//            GridItem(.flexible()),
//            GridItem(.flexible()),
//            GridItem(.flexible()),
//            GridItem(.flexible())
//        ]
//
//        ScrollView {
//            LazyVGrid(columns: columns1, spacing: 20, content: {
//                ForEach(data, id: \.self) { item in
//                    Text(item)
//                }
//            })
//            .padding(.horizontal)
//        }
//        .frame(height: 300)
//    }
//}

// MARK: 13.3、fixed(50)
/*
 第三种选择使用固定尺寸，例如，设置第一列宽度为50，让第二列填充所有剩余的空间
 */

//struct ContentView: View {
//    var body: some View {
//        let data = (1...100).map {
//            "Item \($0)"
//        }
//
//        let columns2 = [
//            GridItem(.fixed(50)),
//            GridItem(.flexible())
//        ]
//
//        ScrollView {
//            LazyVGrid(columns: columns2, spacing: 20, content: {
//                ForEach(data, id: \.self) { item in
//                    Text(item)
//                }
//            })
//            .padding()
//        }
//        .frame(maxHeight: 300)
//    }
//}

// MARK: 13.4、LazyHGrid
/*
 还可以使用LazyHGrid制作水平滚动网格，原理大致相同，只是需要在初始化时提供行数。创建10个并排的水平滚动标题图像
 */

//struct ContentView: View {
//    var body: some View {
//        let items = 1...50
//
//        let rows = [
//            GridItem(.fixed(50)),
//            GridItem(.fixed(50))
//        ]
//
//        ScrollView(.horizontal) {
//            LazyHGrid(rows: rows, alignment: .center, content: {
//                ForEach(items, id: \.self) { item in
//                    Image(systemName: "\(item).circle.fill")
//                        .font(.largeTitle)
//                }
//            })
//            .frame(height: 150)
//        }
//    }
//}

// MARK: -
// MARK: 14、如何在ScrollView滚动时关闭键盘
/*
 SwiftUI的scrollDismissesKeyboard()修饰符控制当用户在scrollView中滚动时如何关闭键盘。
 
 scrollDissmissesKeyboard()修饰符有四个可选值:
 .automatic:让SwiftUI根据滚动的上下文判断最佳操作
 .immediately：使键盘在任何滚动发生时立即完全关闭
 .interactively：时键盘与用户手势同步关闭，用户需要进一步滚动才能完全关闭键盘
 .never：使键盘在滚动期间保持可见
 */

//struct ContentView: View {
//    @State private var username = "BabyLove"
//    @State private var bio = ""
//    var body: some View {
//        ScrollView {
//            VStack {
//                TextField("Name", text: $username)
//                    .textFieldStyle(.roundedBorder)
//                TextEditor(text: $bio)
//                    .frame(height: 400)
//                    .border(.quaternary, width: 1)
//            }
//            .padding(.horizontal)
//        }
//        .scrollDismissesKeyboard(.interactively)
//
//    }
//}

// MARK: -
// MARK: 15、如何隐藏ScrollView、List的滚动指示器
/*
 SwiftUI的ScrollIndicators()修饰符控制是否显示滚动指示器--这些闪烁的小条既能让用户了解内容的大小，又允许长按滚动
 
 ScrollIndicatorVisibility有四个枚举值：
 .automatic：这是没有应用修饰符的行为
 .visible：可以在iOS上显示自动隐藏滚动指示器，或在macOS上根据用户偏好设置来决定是否隐藏
 .hidden：可以隐藏iOS上的指示器，并在大多数情况下macOS上隐藏，如果用户连接鼠标，滚动指示器重新显示
 .never：可以在iOS和macOS上隐藏指示器，无论用户使用的指针设备是什么
 */

//struct ContentView: View {
//    var body: some View {
//        List(1..<100) { i in
//            Text("Row \(i)")
//        }
//        .scrollIndicators(.hidden)
//    }
//}

// MARK: -
// MARK: 16、如何使用Table创建多列列表
/*
 SwiftUI的Table可以创建包含多列的列表。包括选择和排序功能。它的原理与常规列表不同，因为给Table传递要的是数据数组，并使用key-paths指定要显示的值，同时还需要传递标题以显示在表头区域。如果在iOS17以上，还可以添加DisclosureTableRow实例，使表格可以展开和折叠。
 在iPhone上，表格会向下折叠以显示第一列数据，但在iPad和Mac上，将显示所有数据
 */

//struct ContentView: View {
//    struct User: Identifiable {
//        let id: Int
//        var name: String
//        var score: Int
//    }
//
//    struct Person: Identifiable {
//        let id = UUID()
//        let name: String
//        var city: String
//        let birthDate: Date
//        var children = [Person]()
//
//        // some example websites
//        static let betsy = Person(name: "Betsy Appleseed", city: "San Jose", birthDate: ISO8601DateFormatter().date(from: "1977-01-30T11:28:00+00:00")!)
//        static let kate = Person(name: "Kate Appleseed", city: "Los Altos", birthDate: ISO8601DateFormatter().date(from: "1977-02-25T04:15:00+00:00")!)
//        static let johnny = Person(name: "Johnny Appleseed", city: "Santa Clara", birthDate: ISO8601DateFormatter().date(from: "1952-06-03T12:45:00+00:00")!, children: [betsy, kate])
//        static let tim = Person(name: "Tim Appleseed", city: "Mountain View", birthDate: ISO8601DateFormatter().date(from: "1960-11-01T09:41:00+00:00")!)
//    }
//    
//    let family: [Person] = [.johnny, .tim]
//    @State private var bookmarksExpanded = false
//    
//    var body: some View {
//        Table(of: Person.self) {
//            TableColumn("Name", value: \.name)
//            TableColumn("City", value: \.city)
//            TableColumn("Birthdate") { person in
//                Text(person.birthDate.formatted(date: .numeric, time: .omitted))
//            }
//        } rows: {
//            ForEach(family) { member in
//                if member.children.isEmpty {
//                    TableRow(member)
//                } else {
//                    DisclosureTableRow(member) {
//                        ForEach(member.children)
//                    }
//                }
//            }
//        }
//    }
//}

// MARK: -
// MARK: 17、如何缩进ScrollView中的内容或滚动指示器
/*
 默认情况下，SwiftUI的ScrollView允许其内容填充所有可用空间，并且滚动指示器在屏幕的尾部边缘显示，使用contentMargins()修饰符，可以调整位置，将内容或滚动指示器根据指定的数值和边缘进行内嵌调整
 
 ContentMarginPlacement包含3个参数：
 automatic：会自动将其内容和滚动指示器都向内缩进，以指定的量为边距。
 scrollContent：内部View
 scrollIndicators：滚动指示器
 */

// MARK: 17.1、.contentMargins(50, for: .scrollContent)
/*
 指定内容View，四边缩进50
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView {
//            ForEach(0..<50) { i in
//                Text("Item \(i)")
//                    .frame(maxWidth: .infinity)
//                    .foregroundStyle(.white)
//                    .background(.blue)
//            }
//        }
//        .frame(height: 300)
//        .contentMargins(50, for: .scrollContent)
//    }
//}

// MARK: 17.2、.contentMargins(.top, 50, for: .scrollContent)
/*
 可以指定单一边缘进行单独调整
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView {
//            ForEach(0..<50) { i in
//                Text("Item \(i)")
//                    .frame(maxWidth: .infinity)
//                    .foregroundStyle(.white)
//                    .background(.blue)
//            }
//        }
//        .frame(height: 300)
//        .contentMargins(.top, 50, for: .scrollContent)
//    }
//}

// MARK: 17.3
/*
 调整滚动指示器，针对top，距离是50
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView {
//            ForEach(0..<50) { i in
//                Text("Item \(i)")
//                    .frame(maxWidth: .infinity)
//                    .foregroundStyle(.white)
//                    .background(.blue)
//            }
//        }
//        .frame(height: 300)
//        .contentMargins(.top, 50, for: .scrollIndicators)
//    }
//}

// MARK: 18、如何使ScrollView或List的滚动条指示器闪烁
/*
 SwiftUI给我们提供了scrollindicatorsFlash()来控制ScrollView或List的滚动指示器何时应该闪烁，这是通知用户其数据某些部分已更改的好方法。此修饰符有两种形式：

 当滚动视图出现时指示器是否应该闪烁
 当值更改时指示器是否应该闪烁
 */

// MARK: 18.1、ScrollView首次显示时闪烁

//struct ContentView: View {
//    var body: some View {
//        ScrollView {
//            ForEach(0..<50) { i in
//                Text("Item \(i)")
//                    .frame(maxWidth: .infinity)
//            }
//        }
//        .frame(height: 300)
//        .scrollIndicatorsFlash(onAppear: true)
//    }
//}

// MARK: 18.2、数据刷新时闪烁
/*
 创建一个自定义值来跟踪指示器是否应该闪烁，这可以时任何Equatable值，只要该值变化，指示器就闪烁
 */

//struct ContentView: View {
//    @State private var exampleState = false
//    var body: some View {
//        Button("Flash!") {
//            exampleState.toggle()
//        }
//        ScrollView {
//            ForEach(0..<50) { i in
//                Text("Item \(i)")
//                    .frame(maxWidth: .infinity)
//                    .background(.blue)
//                    .foregroundStyle(.white)
//            }
//        }
//        .frame(height: 300)
//        .scrollIndicatorsFlash(trigger: exampleState)
//    }
//}

/*
 相同的代码与 List 一起使用，就像与 ScrollView 一起使用一样。
 */

// MARK: -
// MARK: 19、如何使ScrollView在子视图之间实现分页或滑动吸附效果
/*
 在SwiftUI中，ScrollView默认具有平滑的滚动效果，但是通过使用scrollTargetLayout()和scrollTargetBehavior()修饰符，可以使其自动对齐到特定的值视图或整个页面
 */

// MARK: 19.1、scrollTargetBehavior(.viewAligned)
/*
 在水平滚动的视图中放置了10个远郊矩形，其中每个矩形都是一个滚动目标，因为设置了.scrollTargetBehavior()为.viewAligned，SwiftUI会自动在每个圆角矩形之间对齐
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView(.horizontal) {
//            LazyHStack {
//                ForEach(0..<10) { i in
//                    RoundedRectangle(cornerRadius: 25.0)
//                        .fill(Color(hue: Double(i) / 10, saturation: 1, brightness: 1).gradient)
//                        .frame(width: 200, height: 100)
//                }
//            }.scrollTargetLayout()
//        }
//        .scrollTargetBehavior(.viewAligned)
//        .safeAreaPadding(.horizontal, 40)
//    }
//}

/*
 使用scrollTargetLayout()使布局内的所有内容都成为滚动目标，如果你只想捕捉某些子视图，则应该将其删除，并将scrollTarget附加到各个子视图
 */

// MARK: 19.2、scrollTargetBehavior(.paging)
/*
 另一种滚动定位行为是.padding，它是ScrollView根据滚动方向精确移动一个屏幕的宽度或高度
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView {
//            ForEach(0..<50) { i in
//                Text("Item \(i)")
//                    .font(.largeTitle)
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 200)
//                    .background(.blue)
//                    .foregroundStyle(.white)
//                    .clipShape(.rect(cornerRadius: 20))
//            }
//        }
//        .scrollTargetBehavior(.paging)
//        .frame(height: 410)
//    }
//}

// MARK: -
// MARK: 20、如何使用自定义transition创建ScrollView
/*
 SwiftUI的ScrollView将其所有子视图放置在平滑滚动的垂直或水平容器中，但如果我们将scrollTransition()修饰符附加到子视图，那么我们就可以在屏幕上切换自定义视图。
 
 该修饰符必须传递一个至少带有两个参数的必要：一些要控制内容（滚动其余内的一个子视图），加上滚动过渡阶段。阶段有三个枚举值：
 .identity阶段：，视图在屏幕上可见
 .topLeading阶段：根据滚动视图方向，视图即将从顶部或前缘变得可见（即将出现）
 .bottomTrailing阶段：他是.topLeading的递补对影像
 */

// MARK: 20.1、scrollTransition
/*
 垂直滚动视图中方式一些理圆角矩形，在靠近屏幕边缘时淡入和淡出
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView {
//            ForEach(0..<10) {i in
//                RoundedRectangle(cornerRadius: 25.0)
//                    .fill(.blue)
//                    .frame(height: 80)
//                    .scrollTransition { content, phase in
//                        content
//                            .opacity(phase.isIdentity ? 1 : 0)
//                            .scaleEffect(phase.isIdentity ? 1 : 0.75)
//                            .blur(radius: phase.isIdentity ? 0 : 10)
//                    }
//                    .padding(.horizontal)
//            }
//        }
//        .frame(height: 300)
//    }
//}

// MARK: 20.2、.visible(0.9)
/*
 对于附加控制，你可以指定在显示或删除视图之前需要显示多少视图。当视图加载到90%的时候才会将它显示在视图数组中
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView {
//            ForEach(0..<10) {i in
//                RoundedRectangle(cornerRadius: 25.0)
//                    .fill(.blue)
//                    .frame(height: 80)
//                    .scrollTransition(.animated.threshold(.visible(0.9)), transition: { content, phase in
//                        content
//                            .opacity(phase.isIdentity ? 1 : 0)
//                            .scaleEffect(phase.isIdentity ? 1 : 0.75)
//                            .blur(radius: phase.isIdentity ? 0 : 10)
//                    })
//                    .padding(.horizontal)
//            }
//        }
//        .frame(height: 300)
//    }
//}

// MARK: 20.3、phase.value与hueRotation()
/*
 如果你需要非常精确的控制所有应用的效果，请读取过渡段的值。对于顶部前导阶段中的视图，该值为-1，对于底部尾随阶段中的视图，该值为1，对于所有其他视图，该值为0
 通过phase.value与hueRotation()修饰符结合起来，轻轻松松的修改每个滚动形状的色调
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView {
//            ForEach(0..<10) { i in
//                RoundedRectangle(cornerRadius: 25.0)
//                    .fill(.blue)
//                    .frame(height: 80)
//                    .shadow(radius: 3)
//                    .scrollTransition { content, phase in
//                        content.hueRotation(.degrees(45 * phase.value))
//                    }
//                    .padding(.horizontal)
//            }
//        }
//        .frame(height: 400)
//    }
//}

// MARK: -
// MARK: 21、如何让ScrollView在底部开始
/*
 默认情况下，SwiftUI的ScrollView从顶部开始滚动，但如果你想创建像Apple的消息app那样的UI，你可以使用带有.bottom初始锚点的scrollPosition()修饰符要求滚动视图从底部开始。这在滚动视图中显示50个文本视图，但要求滚动视图从底部而不是顶部开始
 */

//struct ContentView: View {
//    var body: some View {
//        ScrollView {
//            ForEach(0..<50) { i in
//                Text("Item \(i)")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(.blue)
//                    .clipShape(.rect(cornerRadius: 25))
//            }
//        }
//        .scrollPosition(initialAnchor: .bottom)
//    }
//}

/*
 如果你的UI在用户不滚动的情况下发生某种变化（例如，如果出现键盘，或者你调整ScrollView的大小），则滚动位置将保持锚定在底部。但是，如果用户手动调整滚动位置，他将正常自由的滚动
 initialAnchor参数是任何UIPoint，因此你可以使用.trailing从右边边缘启动水平滚动的视图
 */

// MARK: -
// MARK: 22、如何禁用ScrollView 滑动出本身自己UI的范围
/*
 SwiftUI的scrollClipDisabled，滚动视图始终完全保留在滚动视图区域内。但是，如果使用scrollClipDisabled()修饰符，则可以覆盖次默认行为，从而允许滚动视图溢出
 👇显示了一个顶部和底部都具有固定文本，中间有滚动区域的VStack。ScrollView将在顶部文本下方整齐的对齐，当你滚动时，就会溢出
 */

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Fixed at the top")
//                .frame(maxWidth: .infinity)
//                .frame(height: 100)
//                .background(.green)
//                .foregroundStyle(.white)
//            
//            ScrollView {
//                ForEach(0..<5) { i in
//                    Text("Scrolling")
//                        .frame(maxWidth:.infinity)
//                        .frame(height:200)
//                        .background(.orange)
//                        .foregroundStyle(.white)
//                }
//            }
//            .scrollClipDisabled()
//            Text("Fixed at the bottom")
//                .frame(maxWidth: .infinity)
//                .frame(height: 100)
//                .background(.green)
//                .foregroundStyle(.white)
//        }
//    }
//}

/*
 使用scrollSlipDisabled()时，有两点注意：

 你可以添加自定义剪辑形状来限制内容溢出的距离。例如，添加padding()然后添加ClipShape(.rect)意味着你会得到一点溢出，但不是无限的
 由于scrollVIew现在与周围环境重叠，因此你可能需要使用zIndex()来调整其垂直位置。例如，如果其他视图具有哦默认的Z索引，则在滚动视图上使用zIndex(1)将其选在在其他视图上
 */

// MARK: -
// MARK: 23、如何根据大小类别在HStack和VStack之间自动切换
/*
 SwiftUI让我们可以监控当前的大小类别来决定如何布局，例如在空间充足时从HStack切换到空间有限时的VStack。这使得在iPad上创建出色的布局变得更加简单，因为我的布局经自动调整以适应分割视图和滑动场景
 */

struct AdaptiveStack<Content: View>: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let spacing: CGFloat?
    let content: () -> Content
    
    init(horizontalAlignment: HorizontalAlignment = .center, verticalAlignment: VerticalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack(alignment: horizontalAlignment, spacing: spacing, content: content)
            } else {
                HStack(alignment: verticalAlignment, spacing: spacing, content: content)
            }
        }
    }
}

/*
 工作原理：
 1. 它监视horizontalSizeClass环境键值，以便每次尺寸发生变化时都会更新
 2. 我给她创建了单独存储水平和垂直对齐的参数，因此可以准确的控制布局如何适应
 3. 有一个可选的CGFloat，用于间距，因为这就是VStack和HStack的工作原理。如果你想要更多控制，你可以添加horizontalSpacing和verticalSpacing属性
 4. content属性是一个不接受参数并返回内容的函数（闭包），最终用户将依赖他来创建布局的视图构建器
 5. 我的初始化函数提供了全部的默认参数，即使不传递任何参数来初始化也不会出错
 6. 在 body 属性中，我们可以读取水平尺寸类，然后将对 content() 的调用包装在 VStack 或 HStack 中
 */

struct ContentView: View {
    var body: some View {
        AdaptiveStack {
            Text("Horizontal when there's lots of space")
            Text("But")
            Text("Vertical when space is restricted")
        }
    }
}
