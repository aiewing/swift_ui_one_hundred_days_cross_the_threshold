//
//  ContentView.swift
//  002-Image
//
//  Created by 舒毅文 on 2023/12/27.
//

import SwiftUI
import AVKit

#Preview {
    ContentView()
}

// MARK: 1、如何使用Image绘制图像
/*
 使用Image视图在SwiftUI布局中渲染图像。它可以从你的Bundle、系统图标、UIImage等加载图像
 */

//struct ContentView: View {
//    var body: some View {
//        //如果使用Xcode15构建，则可以从Bundle加载图像病使用内置静态属性将其显示在图像视图中
////        Image(.fullEnglishThumb)
////            .resizable()
////            .scaledToFit()
//        //如果是Xcode14以及一下，则需要饮用图像名称以字符串的方式
//        Image("full-english-thumb")
//    }
//}

// MARK: 1.1、uiImage方式加载
/*
 你还可以从现有的UIImage加载，因为UIImage的初始化会默认加载一个named，并且返回一个可选图像，但是你需要确定这个named存在你的资产目录中
 */

//struct ContentView: View {
//    var body: some View {
//        Image(uiImage: UIImage(named: "test_1")!)
//    }
//}

// MARK: 1.2、Image(SystemName:)
/*
 如果你要使用Apple的SF Symbols图标集，你应该使用Image(SystemName:)
 
 注意：使用font修饰符来调整SF符号，就跟文本一样,可以修改图片大小
 */

//struct ContentView: View {
//    var body: some View {
//        Image(systemName: "cloud.heavyrain.fill")
//            .font(.largeTitle)
//    }
//}

// MARK: -
// MARK: 2、如何调整图像大小
/*
 SwiftUI的Image视图能够以不同的方式缩放，就像UIImageView一样，默认情况下，图像视图会自动根据器内容调整大小，这可能会是他们超出屏幕范围，如果添加了resizable()修饰符，则图像将自动调整大小，以便填充到可用空间，无论是在你指定的框架中还是屏幕上的任何空间中
 */

//struct ContentView: View {
//    var body: some View {
//        Image(systemName: "cloud.heavyrain.fill")
//             .resizable()
//             .frame(width: 200)
//    }
//}

// MARK: 2.2、aspectRatio
/*
 然而，这会导致图像的原始纵横比扭曲，因为它将在所有维度上拉伸以填充空间，如果你想保持纵横比，可以使用aspectRatio的.fill或.fit修饰符
 */

//struct ContentView: View {
//    var body: some View {
//        Image(systemName: "cloud.heavyrain.fill")
//             .resizable()
//             .aspectRatio(contentMode: .fit)
//             .frame(width: 200)
//    }
//}

// MARK: -
// MARK: 3、如何平铺图像
/*
 如果SwiftUI被要求使用图像视图占用的空间超过图像设计的空间，它的默认行为是拉伸图像，使其适合你所要求的空间。然而，它不需要这样，它可以平铺图像（水平或垂直重复），以便填满空间。关键将resizable()修饰符与其resizingMode参数一起使用，可以是.stretch(默认)、tile(平铺)
 */

//struct ContentView: View {
//    var body: some View {
//        Image(uiImage: UIImage(named: "test_1")!)
//            .resizable(resizingMode: .tile)
//    }
//}

// MARK: 3.1、capInsets
/*
 如果你只想平铺图像的一部分（或将一个或多个边缘固定到图像视图的边缘），那么可以为第一个参数提供边缘插入
 */

//struct ContentView: View {
//    var body: some View {
//        Image(uiImage: UIImage(named: "test_1")!)
//            .resizable(capInsets: EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20), resizingMode: .tile)
//    }
//}

// MARK: 4、如何使用SF Symbols渲染图像
/*
 SwiftUI的Image视图允许我们加载SF Symbols中2400图标中的任意一个，其中的很多图标也可以使用多色
 */

// MARK: -
// MARK: 4.1、标准加载
/*
 要从Apple的SF Symbols加载图标，请使用Image(systemName:),传入要加载的图标字符串
 */

//struct ContentView: View {
//    var body: some View {
//        Image(systemName: "moon.stars.fill")
//    }
//}

// MARK: 4.2、.font(.largeTitle)
/*
 Image通过systemName方式初始化返回的结果是可以缩放和着色的
 */

//struct ContentView: View {
//    var body: some View {
//        Image(systemName: "wind.snow")
//            .font(.largeTitle)
//    }
//}

// MARK: 4.3、foregroundStyle(.red)
/*
 foregroundStyle,对图像着色
 */

//struct ContentView: View {
//    var body: some View {
//        Image(systemName: "cloud.heavyrain.fill")
//            .font(.largeTitle)
//            .foregroundColor(.red)
//    }
//}

// MARK: 4.4、.renderingMode(.original)
/*
 如果你使用的图像包含颜色，则可以使用多色模式.renderingMode(.original)
 */

//struct ContentView: View {
//    var body: some View {
//        Image(systemName: "cloud.sun.rain.fill")
//            .renderingMode(.original)
//            .font(.largeTitle)
//            .padding()
//            .background(.black)
//            .clipShape(Circle())
//    }
//}

// MARK: 4.5、多色SF Symbols
/*
 你可以选择将foregroundStyle()修饰符用于多色SF Symbols，这样的话，符号的部分重新着色
 */

//struct ContentView: View {
//    var body: some View {
//        Image(systemName: "person.crop.circle.fill.badge.plus")
//            .renderingMode(.original)
//            .foregroundColor(.blue)
//            .font(.largeTitle)
//    }
//}

// MARK: -
// MARK: 5、如何渲染渐变
/*
 SwiftUI 为我们提供了多种渐变选项，所有这些选项都可以以多种方式使用。 如果你的环境是 iOS 16 或更高版本，则可以通过附加到您正在使用的任何颜色来获得精美简单的线性渐变.gradient
 */

//struct ContentView: View {
//    var body: some View {
//        Rectangle().fill(.blue.gradient)
//    }
//}

// MARK: 5.1、LinearGradient
/*
 对于更高级的渐变，或支持iOS16之前的版本，你可以使用SwiftUI的内置渐变类型来获得精准控制。例如：用red到blue的线性渐变来渲染文本视图
 */

//struct ContentView: View {
//    var body: some View {
//        Text("内置渐变类型来获得精准控制")
//            .padding()
//            .foregroundStyle(.white)
//            .font(.largeTitle)
//            .background(
//                LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: .trailing)
//            )
//    }
//}

/*
 颜色被指定为一个数组，你可以用更多数量的颜色构建更复杂的渐变
 */

//struct ContentView: View {
//    var body: some View {
//        Text("内置渐变类型来获得精准控制")
//            .padding()
//            .foregroundStyle(.white)
//            .font(.largeTitle)
//            .background(
//                LinearGradient(gradient: Gradient(colors: [.red, .green, .blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: .trailing)
//            )
//    }
//}

// MARK: 5.2、RadialGradient
/*
 替代渐变样式，请尝试RadialGradient、AngularGradient,这会通过各种颜色创建径向渐变，从圆的中心一直到边缘
 */

//struct ContentView: View {
//    var body: some View {
//        Circle()
//            .fill(
//                RadialGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple]), center: .center, startRadius: 50, endRadius: 100)
//            ).frame(width: 200 ,height: 200)
//    }
//}

// MARK: 5.3、AngularGradient
/*
 创建一个角度渐变（圆锥渐变），循环显示各种颜色，返回到开头
 */

//struct ContentView: View {
//    var body: some View {
//        Circle()
//            .fill(
//                AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
//            )
//            .frame(width: 200, height: 200)
//    }
//}

// MARK: 5.4、strokeBorder -> ShapeStyle协议
/*
 由于RadialGradient、AngularGradient、渐变类型都符合ShapeStyle协议，因此你可以将它们用于背景、填充和描边
 */

//struct ContentView: View {
//    var body: some View {
//        Circle()
//            .strokeBorder(
//                AngularGradient.init(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startAngle: .zero, endAngle: .degrees(360)),
//                lineWidth: 30
//            )
//            .frame(width: 200, height: 200)
//    }
//}

// MARK: -
// MARK: 6、何使用Image和其他View作为背景
/*
 SwiftUI 没有用于显示背景颜色或图像的专用修饰符，而是让我们使用background()修饰符指定任何类型的背景视图
 */

// MARK: 6.1、Image作为Text的背景

//struct ContentView: View {
//    var body: some View {
//        Text("Image作为Text的背景")
//            .foregroundStyle(.white)
//            .font(.system(size: 48))
//            .padding(50)
//            .background(
//                Image(uiImage: UIImage(named: "test_1")!)
//                    .resizable()
//            )
//    }
//}

// MARK: 6.2、使用圆形作为背景

//struct ContentView: View {
//    var body: some View {
//        Text("使用圆形作为背景")
//            .foregroundStyle(.black)
//            .font(.system(size: 48))
//            .padding(50)
//            .background(
//                Circle()
//                    .fill(.red)
//                    .frame(width: 50, height: 50)
//            )
//    }
//}

// MARK: 6.3、clipped()
/*
 默认情况下，背景视图会占据你所有的空间，可以用clipped()进行裁剪
 */

//struct ContentView: View {
//    var body: some View {
//        Text("用clipped()进行裁剪")
//            .font(.largeTitle)
//            .padding()
//            .background(
//                Circle()
//                    .fill(.red)
//                    .frame(width: 100, height: 100)
//            )
//            .clipped()
//    }
//}

// MARK: 7、如何绘制solid shapes
/*
 SwiftUI由很多种内置形状，例如矩形、圆形和圆角矩形
 */

//struct ContentView: View {
//    var body: some View {
//        // 200 * 200的红色矩形
//        Rectangle()
//            .fill(.red)
//            .frame(width: 200, height: 200)
//
//        // 100 * 100的蓝色圆形
//        Circle()
//            .fill(.blue)
//            .frame(width: 100, height: 100)
//
//        // 圆角矩形
//        RoundedRectangle(cornerRadius: 25.0)
//            .fill(.green)
//            .frame(width: 150, height: 100)
//
//        // Capsule()是SwiftUI提供的一种特殊的圆角矩形,其中最短的边永远是完全圆角的，类似Slider背景视图
//        Capsule()
//            .fill(.green)
//            .frame(width: 150, height: 100)
//    }
//}

// MARK: -
// MARK: 8、如何同时填充和描边
/*
 在iOS17中，只需要堆叠修饰符就可以同时填充和描边
 */

// MARK: 8.1、基础表示

//struct ContentView: View {
//    var body: some View {
//        Circle()
//            .stroke(.red, lineWidth: 5)
//            .fill(.green)
//            .frame(width: 150, height: 150)
//    }
//}

// MARK: 8.2 可以多次调用，大圈套小圈

//struct ContentView: View {
//    var body: some View {
//        Circle()
//            .stroke(.blue, lineWidth: 45)
//            .stroke(.green, lineWidth: 35)
//            .stroke(.yellow, lineWidth: 25)
//            .stroke(.orange, lineWidth: 15)
//            .stroke(.red, lineWidth: 5)
//            .frame(width: 150, height: 150)
//    }
//}

// MARK: 8.3、使用strokeBorder
/*
 在iOS16以及更低版本中，SwiftUI提供了fill()、stroke()、strokeBorder()修饰符来调整我们绘制形状的方式，但它不提供同时填充和描边的内置方法。但是我们可以通过两种不同的方式获得相同的效果
 使用strokeBorder()在形状周围添加边框，然后使用background()将其填充形状包含在内
 */

//struct ContentView: View {
//    var body: some View {
//        Circle()
//            .strokeBorder(.red, lineWidth: 20)
//            .background(
//                Circle()
//                    .fill(.orange)
//            )
//            .frame(width: 150, height: 150)
//    }
//}

// MARK: 8.4、使用ZStack

//struct ContentView: View {
//    var body: some View {
//        ZStack {
//            Circle()
//                .fill(.orange)
//            
//            Circle()
//                .strokeBorder(.red, lineWidth: 20)
//        }
//        .frame(width: 150, height: 150)
//    }
//}

// MARK: -
// MARK: 9、如何使用trim()绘制实体形状的一部分
/*
 SwiftUI允许我们使用其修饰符仅绘制形状的笔画或者填充一部分trim()，该修饰符采用两个参数，开始值和结束值，范围都是0-1
 */

// MARK: 绘制一个半圆

//struct ContentView: View {
//    var body: some View {
//        Circle()
//            .trim(from: 0, to: 0.5)
//            .frame(width: 200, height: 200)
//    }
//}

// MARK: 9.2、rotationEffect
/*
 SwiftUI绘制其形状时0度直接位于右侧，因此如果你想更改此设置，使用修改器rotationEffect()
 */

//struct ContentView: View {
//    var completionAmount = 0
//
//    var body: some View {
//        Rectangle()
//            .trim(from: 0, to: completionAmount)
//            .stroke(.red, lineWidth: 20)
//            .frame(width: 200, height: 200)
//            .rotationEffect(.degrees(-90))
//            .onReceive(timer, perform: { _ in
//                withAnimation {
//                    if completionAmount == 1 {
//                        completionAmount = 0
//                    } else {
//                        completionAmount += 0.2
//                    }
//                }
//            })
//    }
//}

// MARK: -
// MARK: 10、如何使用VideoPlayer播放电影
/*
 SwiftUI的VideoPlayer可以从任何URL播放视频。需要导入AVKit框架
 */

// MARK: 10.1、本地视频

//struct ContentView: View {
//    var body: some View {
//        VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "Video", withExtension: ".mp4")!))
//            .frame(height: 400)
//    }
//}

// MARK: 10.2、URL链接视频

//struct ContentView: View {
//    var body: some View {
//        VideoPlayer(player: AVPlayer(url: URL(string: "https://bit.ly/swswift")!))
//            .frame(height: 400)
//    }
//}

// MARK: 10.3、 添加水印

//struct ContentView: View {
//    var body: some View {
//        VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "Video", withExtension: ".mp4")!)) {
//            VStack {
//                Text("Watermark")
//                    .foregroundStyle(.red)
//                    .background(
//                        .white.opacity(0.7)
//                    )
//            }
//        }
//        .frame(width: 400, height: 300)
//    }
//}

// MARK: 11、如何使用SpriteView集成SpriteKit
/*
 SwiftUI中可以的SpriteView可以渲染任何子类，如果有需求，SKScene可以调整场景大小,创建一个游戏场景，无论点击哪里，这都会创建下落的盒子，并添加物理效果,你创建的游戏场景是完全交互式的，因此它的工作方式就像SKViewUIKit 中的常规场景一样。
 */

//class FFGameScene: SKScene {
//    override func didMove(to view: SKView) {
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: self)
//        let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
//        box.position = location
//        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
//        addChild(box)
//    }
//}
//
//struct FFSpriteView: View {
//    
//    var scene: SKScene {
//        let scene = FFGameScene()
//        scene.size = CGSize(width: 300, height: 400)
//        scene.scaleMode = .fill
//        return scene
//    }
//    
//    var body: some View {
//        SpriteView(scene: scene)
//            .frame(width: 300, height: 400)
//            .ignoresSafeArea()
//    }
//}

// MARK: -
// MARK: 12、如何从 URL 加载远程图像
/*
 SwiftUI的AsynImage用于从网上下载和显示远程图像的功能。只需要传递一个URL
 */

// MARK: 12.1、基础表示
/*
 URL是可选参数，如果URL无效，将显示默认的灰色占位符。如果由于某种原因无法加载图像（用户离线、图像不存在），那么系统将继续显示相同的占位符图像
 */

//struct ContentView: View {
//    var body: some View {
//        AsyncImage(url: URL(string: "https://hws.dev/paul.jpg"), scale: 4)
//    }
//}

// MARK: 12.2、指定frame
/*
 因为SwiftUI不知道下载的图像有多大，因此默认情况下AsyncImage在加载时具有灵活的宽度和高度。因此如果你不指定固定的宽度和高度，在图像加载之前会占用大量空间，然后在图像加载之后会调整到正确的大小。
 */

//struct ContentView: View {
//    var body: some View {
//        AsyncImage(url: URL(string: "https://hws.dev/paul.jpg")) { image in
//            image.resizable()
//        } placeholder: {
//            Color.green
//        }
//        .frame(width: 128, height: 128)
//        .clipShape(RoundedRectangle(cornerRadius: 25))
//    }
//}

// MARK: 12.3、AsyncImagePhase
/*
 显示image加载过程，会有菊花的中间视图过度
 */

//struct ContentView: View {
//    var body: some View {
//        AsyncImage(url: URL(string: "https://hws.dev/paul.jpg")) { phase in
//            switch phase {
//            case .failure:
//                Image(systemName: "photo")
//                    .font(.largeTitle)
//            case .success(let image):
//                image.resizable()
//            default:
//                ProgressView()
//            }
//        }
//        .frame(width: 256, height: 256)
//        .clipShape(RoundedRectangle(cornerRadius: 25))
//    }
//}

// MARK: -
// MARK: 13、如何使用 SF Symbols 获得自定义颜色和透明度
/*
 如果你在SwiftUIImage中使用SF Symbols，你可以使用foregroundStyle()修饰符获得单一的颜色，或者使用.renderingMode(.original)使用多色。
 */

// MARK: 13.1、.symbolRenderingMode(.hierarchical)
/*
 分层渲染,用透明的方式绘制图像以提供额外的深度和清晰度
 */

//struct ContentView: View {
//    var body: some View {
//        Image(systemName: "theatermasks")
//            .symbolRenderingMode(.hierarchical)
//            .font(.system(size: 144))
//    }
//}

// MARK: 13.2、.symbolRenderingMode(.hierarchical) + .foregroundStyle(.blue)
/*
 分层渲染与前景色结合使用，可以同时指定两者
 */

//struct ContentView: View {
//    var body: some View {
//        Image(systemName: "theatermasks")
//            .symbolRenderingMode(.hierarchical)
//            .foregroundStyle(.blue)
//            .font(.system(size: 144))
//    }
//}

// MARK: 13.3、.symbolRenderingMode(.palette)
/*
 .palette,完全控制图像中的颜色，全部自己指定
 */

//struct ContentView: View {
//    var body: some View {
//        Image(systemName: "shareplay")
//            .symbolRenderingMode(.palette)
//            .foregroundStyle(.blue, .black)
//            .font(.system(size: 144))
//    }
//}

// MARK: 13.4、.palette + .foregroundStyle(.blue, .green, .red)
/*
 这些颜色的应用方式取决于每个单独的符号 - 有时符号是用两层定义的，有时是三层
 */

//struct ContentView: View {
//    var body: some View {
//        Image(systemName: "person.3.sequence.fill")
//            .symbolRenderingMode(.palette)
//            .foregroundStyle(.blue, .green, .red)
//            .font(.system(size: 144))
//    }
//}

// MARK: 13.5、linearGradient
/*
 增加渐变
 */

//struct ContentView: View {
//    var body: some View {
//        Image(systemName: "person.3.sequence.fill")
//            .symbolRenderingMode(.palette)
//            .foregroundStyle(
//                .linearGradient(colors: [.red, .black], startPoint: .top, endPoint: .bottomTrailing),
//                .linearGradient(colors: [.green, .black], startPoint: .top, endPoint: .bottomTrailing),
//                .linearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottomTrailing)
//                
//            )
//            .font(.system(size: 144))
//    }
//}

// MARK: -
// MARK: 14、如何动态调整 SF Symbol的颜色

//struct ContentView: View {
//    @State private var value = 0.0
//    
//    var body: some View {
//        List {
//            Section {
//                Image(systemName: "wifi", variableValue: 0.5)
//            }
//            
//            Section {
//                //通过Slider滑动动态修改填充值
//                Image(systemName: "aqi.low", variableValue: value)
//                Image(systemName: "wifi", variableValue: value)
//                Image(systemName: "chart.bar.fill", variableValue: value)
//                Image(systemName: "waveform", variableValue: value)
//                
//                Slider(value: $value)
//            }
//            .font(.system(size: 72))
//            .foregroundStyle(.blue)
//            .padding()
//        }
//    }
//}

// MARK: -
// MARK: 15、如何使用PhotosPicker选择图片
/*
 SwiftUI PhitisPicker可以使用系统标准图片导入界面，允许用户选择一张或多张图片以及视频导入你的应用程序。如果使用它来导入图像，你需要导入PhotosUI，然后创建存储PhotosPickerItem来保存用户选择的内容，并创建一个Image属性来存储加载的资源。
 这组代码相对复杂一些，不好做拆分，如果想调试，整体copy一下，自己研究吧
 */

//struct FFImagePhotosPicker: View {
//    @State private var avatarItem: PhotosPickerItem?
//    @State private var avatarImage: Image?
//    
//    @State private var selectedItems = [PhotosPickerItem]()
//    @State private var selectedImages = [Image]()
//    
//    var body: some View {
//        /**
//         如果您想更好地控制所选数据，请matching根据您要查找的内容调整参数：
//         
//         matching: .screenshots如果您只需要屏幕截图，请使用。
//         matching: .any(of: [.panoramas, .screenshots])如果您想要其中任何一种类型，请使用。
//         matching: .not(.videos)如果您想要非视频的任何媒体，请使用。
//         matching: .any(of: [.images, .not(.screenshots)]))如果您想要除屏幕截图之外的所有类型的图像，请使用。
//         */
//        List {
//            Section {
//                PhotosPicker("Select acatar", selection: $avatarItem, matching: .images)
//                
//                if let avatarImage {
//                    avatarImage
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 300, height: 300)
//                }
//            }
//            .onChange(of: avatarItem) {
//                Task {
//                    if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
//                        if let uiImage = UIImage(data: data) {
//                            avatarImage = Image(uiImage: uiImage)
//                            return
//                        }
//                    }
//                }
//            }
//            
//            Section {
//                
//                PhotosPicker("Select Images", selection: $selectedItems, matching: .images)
//                    .onChange(of: selectedItems) {
//                        Task {
//                            selectedImages.removeAll()
//                            
//                            for item in selectedItems {
//                                if let data = try? await item.loadTransferable(type: Data.self) {
//                                    if let uiImage = UIImage(data: data) {
//                                        let image = Image(uiImage: uiImage)
//                                        selectedImages.append(image)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                ForEach(0..<selectedImages.count, id: \.self) { i in
//                    selectedImages[i]
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 300 ,height: 300)
//                }
//            }
//        }
//    }
//}

// MARK: -
// MARK: 16、如何使用PhotosPicker导入视频
/*
 1. 导入AVKit以访问VideoPlayer视图，导入PhotosUI访问PhotosPicker视图
 2. 自定义Movie结构体是告诉程序导入movie数据的方式，Transferable可以通过URL使用SentTransferredFile来发送数据，这意味着我可以讲Movie实例拖出应用程序，它还可以使用必报接受数据，它将movie的URL转换成movie.mp4的方式复制到我的文档目录，并删除任何现有的文件
 3. 导入movie可能需要一些时间，因此我需要确认用户在后台应用程序运行时后了解我们的导入状态，通过4种状态来处理的：
    unknown当应用程序启动时
    loading显示进度旋转器
    loaded当movie导入完成
    failed导入失败

 4. 在onChange修饰符种，要求系统为我们提供一个Movie实例，以便我们接受URL并将其转移到正确的位置提供给app，这还负责设置loadState属性，保持UI同步
 */

// MARK: Transferable

//struct Movie: Transferable {
//    let url: URL
//    
//    static var transferRepresentation: some TransferRepresentation {
//        FileRepresentation(contentType: .movie) { movie in
//            SentTransferredFile(movie.url)
//        } importing: { received in
//            let copy = URL.documentsDirectory.appending(path: "movie.mp4")
//            
//            if FileManager.default.fileExists(atPath: copy.path()) {
//                try FileManager.default.removeItem(at: copy)
//            }
//            
//            try FileManager.default.copyItem(at: received.file, to: copy)
//            return self.init(url: copy)
//        }
//
//
//    }
//}

// MARK: PhotosPicker

//struct FFImageVideo: View {
//    enum LoadState {
//        case unknown, loading, loaded(Movie), failed
//    }
//    
//    @State private var selectedItem: PhotosPickerItem?
//    @State private var loadState = LoadState.unknown
//    
//    var body: some View {
//        
//        List {
//            PhotosPicker("Select movie", selection: $selectedItem, matching: .videos)
//                .onChange(of: selectedItem) {
//                    Task {
//                        do {
//                            loadState = .loading
//                            
//                            if let movie = try await selectedItem?.loadTransferable(type: Movie.self) {
//                                loadState = .loaded(movie)
//                            } else {
//                                loadState = .failed
//                            }
//                        } catch {
//                            loadState = .failed
//                        }
//                    }
//                }
//            
//            switch loadState {
//            case .unknown:
//                EmptyView()
//            case .loading:
//                ProgressView()
//            case .loaded(let movie):
//                VideoPlayer(player: AVPlayer(url: movie.url))
//                    .scaledToFit()
//                    .frame(width: 300, height: 300)
//            case .failed:
//                Text("Import failed")
//            }
//        }
//    }
//}

// MARK: -
// MARK: 17、如何绘制SF Symbols动画
/*
 SwiftUI提供了symbolEffect()修饰符来为SF Symbol添加内置动画效果，
 */

// MARK: 17.1、symbolEffect
/*
 点击button，小狗图标跳动一次
 */

//var petCount = 0
//struct ContentView: View {
//    var body: some View {
//        Button {
//            petCount += 1
//        } label: {
//            Label("Pet the Dog", systemImage: "dog")
//        }
//        .symbolEffect(.bounce, value: petCount)
//        .font(.largeTitle)
//    }
//}

// MARK: 17.2、调整动画的方向

//Button {
//    isFavorite.toggle()
//} label: {
//    Label("Activate Inbox Zero", systemImage: "mail.stack")
//}
//.symbolEffect(.bounce.down, value: isFavorite)
//.font(.largeTitle)

// MARK: 17.3、options: .speed(3).repeat(3)
/*
 添加额外的选项来获得重复计数和自定义速度
 */

//Button {
//    isFavorite.toggle()
//} label: {
//    Label("Activate Inbox Zero", systemImage: "mail.stack")
//}
//.symbolEffect(.bounce.down, options: .speed(3).repeat(3),value: isFavorite)
//.font(.largeTitle)

// MARK: 17.4、iterative、cumulative
/*
 可变颜色动画特别强大，因为SF Symbols可以让你控制每个图层的动画
 .variableColor.iterative：一次为一个图层做色，.variableColor.cumulative将每个新图层添加到先前的着色图层中，并且可以使用reversing到其中任何一个来制作动画是向前播放还是向后播放
 */

//struct ContentView: View {
//    var body: some View {
//        Button("Start Animations") {
//            withAnimation {
//                animationsRunning.toggle()
//            }
//        }
//
//        HStack {
//            Image(systemName: "square.stack.3d.up")
//                .symbolEffect(.variableColor.iterative, value: animationsRunning)
//                
//            Image(systemName: "square.stack.3d.up")
//                .symbolEffect(.variableColor.cumulative, value: animationsRunning)
//                
//            Image(systemName: "square.stack.3d.up")
//                .symbolEffect(.variableColor.reversing.iterative, value: animationsRunning)
//                
//            Image(systemName: "square.stack.3d.up")
//                .symbolEffect(.variableColor.reversing.cumulative, value: animationsRunning)
//                
//        }
//        .font(.largeTitle)
//
//        HStack {
//            Image(systemName: "square.stack.3d.up")
//                .symbolEffect(.variableColor.iterative,options: .repeating, value: animationsRunning)
//                
//            Image(systemName: "square.stack.3d.up")
//                .symbolEffect(.variableColor.cumulative,options: .repeat(3), value: animationsRunning)
//                
//            Image(systemName: "square.stack.3d.up")
//                .symbolEffect(.variableColor.reversing.iterative, options: .speed(3), value: animationsRunning)
//                
//            Image(systemName: "square.stack.3d.up")
//                .symbolEffect(.variableColor.reversing.cumulative, options: .repeat(3).speed(3), value: animationsRunning)
//                
//        }
//        .font(.largeTitle)
//    }
//}

// MARK: 17.5、contentTransition
/*
 如果通过点击与用户交互，切换图标，使用修饰符contentTransition()
 */

//Button{
//    withAnimation {
//        isFavorite.toggle()
//    }
//} label: {
//    Label("Toggle Favorite", systemImage: isFavorite ? "checkmark" : "heart")
//}
//.contentTransition(.symbolEffect(.replace))
//.font(.largeTitle)

// MARK: -
// MARK: 18、如何从颜色中读取具体RGB（红、绿、蓝）的值
/*
 SwiftUI的Color视图并不是保留一种特定的颜色，而是在屏幕上绘制时才解析为特定值。这允许系统使用明暗模式之间的细微变化来确保最佳，但这也意味着获得市级的红绿蓝分别是什么的唯一方法是询问解析的颜色。
    1. 获取当前环境的访问权限，并将其传递到对你的颜色调用函数resolve(in:).Codable。
    2. 保存数据
 */

// MARK: 18.1、基础表示
/*
 RGB分量的数据格式为Float，而不是double
 */

//@Environment(\.self) var environment
//@State private var color = Color.red
//
//@State private var resolvedColor: Color.Resolved?
//
//func getColor() {
//    resolvedColor = color.resolve(in: environment)
//}
//
//ColorPicker("Select your favorite color", selection: $color)
//    .onChange(of: color, initial: true, getColor)
//
//if let resolvedColor {
//    Text("Red: \(resolvedColor.red)")
//    Text("Green: \(resolvedColor.green)")
//    Text("Blue: \(resolvedColor.blue)")
//    Text("Opacity: \(resolvedColor.opacity)")
//}

// MARK: 18.2、将颜色数据解析为json

//@Environment(\.self) var environment
//@State private var color = Color.red
//
//@State private var resolvedColor: Color.Resolved?
//@State private var colorJSON = ""
//
//func getColor() {
//    resolvedColor = color.resolve(in: environment)
//    
//    if let colorData = try? JSONEncoder().encode(resolvedColor) {
//        colorJSON = String(decoding: colorData, as: UTF8.self)
//    }
//}
//
//ColorPicker("Select your favorite color", selection: $color)
//    .onChange(of: color, initial: true, getColor)
//
//if let resolvedColor {
//    Text("Red: \(resolvedColor.red)")
//    Text("Green: \(resolvedColor.green)")
//    Text("Blue: \(resolvedColor.blue)")
//}
//
//Text("Color JSON: \(colorJSON)")

// MARK: 18.3、转化为实例Color

//struct ContentView: View {
//    let resolvedColor = Color.Resolved(red: 0, green: 0.6, blue: 0.9)
//    var body: some View {
//        Rectangle()
//            .fill(
//                Color(resolvedColor).gradient
//            )
//    }
//}

// MARK: -
// MARK: 19、如何组合图形并创建新图形
/*
 所有SwiftUI的图形都可以通过各种方式组合来创建新的图形，包括并集（合并两个图形的填充区域），交集（包含两个图形中共有区域的填充区域），线交集（返回一个图形的线填充另一个）
 */

// MARK: 19.1、union
/*
 将一个圆形与插入100个点的capsule组合起来，并填充为蓝色
 */

//struct ContentView: View {
//    var body: some View {
//        Circle()
//            .union(.capsule(style: .circular))
//            .fill(.blue)
//    }
//}

// MARK: 19.2、lineSubtraction
/*
 lineSubtraction()在圆形中切出矩形，用圆帽描边剩余部分
 */

//struct ContentView: View {
//    var body: some View {
//        Circle()
//            .lineSubtraction(.rect.inset(by: 30))
//            .stroke(style: .init(lineWidth: 20, lineCap: .round))
//            .padding()
//    }
//}

// MARK: 19.3、symmetricDifference
/*
 将一个圆放在左侧，然后减去另一个向右偏移的圆
 */

//struct ContentView: View {
//    var body: some View {
//        Circle()
//            .offset(x: 0)
//            .symmetricDifference(.circle.offset(x: 100))
//            .fill(.red)
//            .frame(width: 200, height: 200)
//            .padding()
//    }
//}

// MARK: -
// MARK: 20、如何加载Assets中的自定义颜色
/*
 在Assets中创建 颜色是可视化它们最好的方式，也是添加深色与浅色模式调整的简单方法（在Assets中添加color set可以同时分别设定深色与浅色模式）创建方式Assets catalog -> add -> Color Set
 */

//struct ContentView: View {
//    var body: some View {
//        List {
//            Section {
//                Color(.diyColor)
//            }
//        }
//    }
//}
