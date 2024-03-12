//
//  ContentView.swift
//  008-TapGestures
//
//  Created by 舒毅文 on 2024/3/11.
//

import SwiftUI

// https://juejin.cn/post/7263125158948094012

#Preview {
    ContentView()
}

// MARK: -
// MARK: 1、给View添加Gesture
/*
 任何SwiftUI视图都可以附加手势识别器，而这些手势识别器又可以附加闭包，这些闭包在手势被激活时使用。
 */

// MARK: 1.1、单击手势

//struct ContentView: View {
//    @State private var scale = 1.0
//    var body: some View {
//        Image("vip")
//            .scaleEffect(scale)
//            .gesture(
//                TapGesture()
//                    .onEnded({ _ in
//                        scale += 0.1
//                    })
//            )
//    }
//}

// MARK: 1.2、LongPressGesture长按手势
/*
 LongPressGesture会识别用户何时按住视图和按住的时间
 */

//struct ContentView: View {
//    @State private var scale = 1.0
//    var body: some View {
//        Image("vip")
//            .scaleEffect(scale)
//            .gesture(
//                LongPressGesture(minimumDuration: 1)
//                    .onEnded({ _ in
//                        scale *= 2
//                    })
//            )
//    }
//}

// MARK: 1.3、DragGesture拖动手势
/*
 DragGesture当用户按下视图并移动一段距离时，触发手势
 */

//struct ContentView: View {
//    @State private var dragCompleted = false
//    var body: some View {
//        Image("vip")
//            .gesture(
//                DragGesture(minimumDistance: 50)
//                    .onChanged({ _ in
//                        dragCompleted = true
//                    })
//            )
//        
//        if dragCompleted {
//            Text("Drag Completed!")
//        }
//    }
//}

// MARK: 1.4、DragGesture与offset
/*
 当DragGesture与offset修饰符结合使用时，可以调整视图到合适的位置。
 */

//struct ContentView: View {
//    @State private var dragOffset = CGSize.zero
//    var body: some View {
//        Image("vip")
//            .offset(dragOffset)
//            .gesture(
//                DragGesture()
//                    .onChanged({ gesture in
//                        dragOffset = gesture.translation
//                    })
//                    .onEnded({ gesture in
//                        dragOffset = .zero
//                    })
//            )
//    }
//}

/*
 由于在onEnded中设置了归零，所以当松开手指时，会弹回到原来的位置。
 */

// MARK: -
// MARK: 2、创建单机和多次点击的手势
/*
 任何SwiftUI视图都可以附加Tap操作，并且可以指定在触发操作之前应接受多少次点击
 */

//struct ContentView: View {
//    var body: some View {
//        List {
//            Text("Tap me")
//                .onTapGesture {
//                    print("Tapped!")
//                }
//            
//            Image("vip")
//                .onTapGesture(count: 2, perform: {
//                    print("Double Tapped!")
//                })
//        }
//    }
//}

/*
 count的数值是自定义的，不止局限于UIKit的双击。
 */

// MARK: -
// MARK: 3、通过highPriorityGesture()设置手势优先级
/*
 如果一个SwiftUI视图位于另一个视图中，并且两者具有相同的手势识别，则系统将始终在父级之前触发子集的手势。可以使用highPriorityGesture()来更改此行为，强制系统优先考虑你指定的手势。
 */

// MARK: 3.1、默认情况
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Circle()
//                .fill(.green)
//                .frame(width: 200, height: 200)
//                .onTapGesture {
//                    print("Circle Tapped!")
//                }
//        }
//        .onTapGesture {
//            print("VStack Tapped!")
//        }
//    }
//}

// MARK: 3.2、highPriorityGesture()
/*
 使用highPriorityGesture()触发VStack的手势
 */

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Circle()
//                .fill(.green)
//                .frame(width: 200, height: 200)
//                .onTapGesture {
//                    print("Circle Tapped!")
//                }
//        }
//        .highPriorityGesture(
//            TapGesture()
//                .onEnded({ _ in
//                    print("VStack Tapped!")
//                })
//        )
//    }
//}

/*
 使用这个修饰符，将始终打印“VStack tapped”，因为VStack手势始终优先于圆圈的手势。
 */

// MARK: -
// MARK: 4、通过simultaneousGesture()同时识别两个手势
/*
 默认情况下，SwiftUI一次只会触发一个手势操作，通常时层次结构中最前面的视图。子视图优先于父视图，如果想覆盖此行为同时触发两个手势，则应在创建第二个以及后续手势时使用simultaneousGesture()
 */

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Circle()
//                .fill(.green)
//                .frame(width: 200, height: 200)
//                .onTapGesture {
//                    print("Circle Tapped!")
//                }
//        }
//        .simultaneousGesture(
//            TapGesture()
//                .onEnded({ _ in
//                    print("VStack Tapped!")
//                })
//        )
//    }
//}

// MARK: -
// MARK: 5、通过sequenced(before:)创建手势链
/*
 SwiftUI可以从其他手势中创建新手势，使得仅在两个手势连续出现时才触发操作，例如，用户拖动视图然后长按它。
 
 由于排序视图需要能够互相引用，因此无法真正的将它们创建为视图的属性。相反，直接在body属性内创建它们，然后使用FirstGesture.sequenced(before:secondaryGesture)将两者链接在一起形成一个手势。
 */

//struct ContentView: View {
//    @State private var message = "Long press then darg"
//    var body: some View {
//        let longPress = LongPressGesture()
//            .onChanged { _ in
//                message = "Now drag me"
//            }
//        
//        let drag = DragGesture()
//            .onEnded { _ in
//                message = "Success"
//            }
//        
//        let conbined = longPress.sequenced(before: drag)
//        
//        Text(message)
//            .gesture(conbined)
//    }
//}

// MARK: -
// MARK: 6、检测用户鼠标悬停在视图上
/*
 在SwiftUI中，链接鼠标的任何macOS应用或任何iPadOs引用都可以检测用户何时将指针悬停在视图上，并做出适当的响应:

 onHover():跟踪指针是否悬停在视图上，并传递一个反应该状态的bool值。
 hideEffect(): 选择系统在悬停发生时突出显示视图。
 */

// MARK: 6.1、onHover
/*
 将某些文本着色为红色或绿色，具体取决于指针是否悬停在其上。
 */

//@State private var overText = false
//
//Text("Hello, World!")
//    .foregroundStyle(overText ? .green : .red)
//    .onHover { over in
//        overText = over
//    }

// MARK: 6.2、hoverEffect
/*
 如果应用不带有任何参数的hoverEffect修饰符，automatic是默认值。但它不仅仅在highhlight和lift之间进行选择，这是完全不同的效果，并且不会转换指针以匹配你想的形状。
 
 hoverEffect的三种枚举：

 highlight：将指针转换为图形的形状
 lift：将指针转换为形状，放大视图并在其后面放置软阴影
 automatic:选择最适合的高光效果。
 */

//Text("Tap me!")
//    .font(.largeTitle)
//    .hoverEffect(.lift)
//    .onTapGesture {
//        print("Text tapped")
//    }

/*
 悬浮效果仅在MacOS和iPadOS上有效果，iOS不可以。在iPad模拟器上操作，点击I/O菜单并选择输入（Input），再选将光标显示到设备（Send Pointer to Device）
 */

// MARK: -
// MARK: 7、检测摇动手势
/*
 SwiftUI没有内置的方法来检测用户摇动设备，但通过重写UIWindow中的motionEnded()并创建自定义视图修饰符。
 
 五个步骤：

 1）向UIDevece添加扩展以跟踪发生摇动手势时将发送新的通知。
 2）在UIWindow上创建扩展以覆盖默认的motionEnded()方法，这是UIKit发送摇动手势的地方，因此应该查找发生的情况并将其转换为新通知。
 3）创建一个自定义视图修饰符来监视发布的摇动通知，并在发生时调用选择的函数。
 4）创建一个视图扩展来整齐的包装新修饰符。
 5）在视图中使用一下
 */

//extension UIDevice {
//    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
//}
//
//extension UIWindow {
//    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//        if motion == .motionShake {
//            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
//        }
//    }
//}
//
//struct DeviceShakeViewModifier: ViewModifier {
//    let action: () -> Void
//    
//    func body(content: Content) -> some View {
//        content
//            .onAppear()
//            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification), perform: { _ in
//                action()
//            })
//    }
//}
//
//
//extension View {
//    func onShake(perform action: @escaping () -> Void) -> some View {
//        self.modifier(DeviceShakeViewModifier(action: action))
//    }
//}
//
//
//struct FFGestureShake: View {
//    var body: some View {
//        Text("Shake me!")
//            .onShake {
//                print("Device shaken!")
//            }
//    }
//}

// MARK: -
// MARK: 8、使用contentShape（）控制视图的可点击区域
/*
 如果将点击手势添加到原始的SwiftUI视图（文本或图像等），则整个视图将变得可点击。如果你将点击手势添加到SwiftUI的容器视图（VStack或HStack），那么SwiftUI只会将手势添加到容器中包含内容的部分--Stack的大部分将无法点击。
 
 如果你想改变点击的区域，可以使用contengShape()修饰符和想要的形状。
 */

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image("vip")
//                .resizable()
//                .frame(width: 50, height: 50)
//            Spacer()
//                .frame(height: 50)
//            Text("Meta BBlv")
//        }
//        .contentShape(Rectangle())
//        .onTapGesture {
//            print("Show details for user")
//        }
//    }
//}

// MARK: -
// MARK: 9、使用allowsHitTexting()禁用视图的点击
/*
 SwiftUI可以使用allowedHitTesting()修饰符阻止视图接收任何类型的点击。如果视图不允许进行命中测试，则任何点击都会自动继续穿过测图，到达其后面的任何内容。
 */

//struct ContentView: View {
//    var body: some View {
//        ZStack {
//            Button("Tap Me") {
//                print("Button was Tapped!")
//            }
//            .frame(width: 100, height: 100)
//            .background(.gray)
//            
//            Rectangle()
//                .fill(.green.opacity(0.2))
//                .frame(width: 300, height: 300)
//                .clipShape(Circle())
//                .allowsHitTesting(false)
//        }
//    }
//}

/*
 尽管矩形位于按钮的上面，但它设置了allowsTightening(false)-矩形上的任何点击都不会被矩形捕获，而是传递到下面的按钮
 */

// MARK: -
// MARK: 10、检测Tap的Insert位置
/*
 SwiftUI中有一个onTapGesture()变量，可以检测点击的确切位置，无论是相对于视图的边界还是在整个屏幕的全局位置。
 */

// MARK: 10.1、相对位置（视图内）
/*
 相对位置是指相对一圆圈的边界--由于圆圈的大小为100*100，如果你点击的中心，无论圆圈放置在屏幕上的任何位置，都会打印50
 */

//struct ContentView: View {
//    var body: some View {
//        Circle()
//            .fill(.green)
//            .frame(width: 100, height: 100)
//            .onTapGesture { location in
//                print("Tapped at \(location)")
//            }
//    }
//}

// MARK: 10.2、全局位置
/*
 如果想要全局位置--即相对于屏幕左上角的位置，这样添加参数：coordinateSpace
 */

//struct ContentView: View {
//    var body: some View {
//        Circle()
//            .fill(.blue)
//            .frame(width: 100, height: 100)
//            .onTapGesture(coordinateSpace: .global) { location in
//                print("Tapped at \(location)")
//            }
//    }
//}

/*
 此onTapGesture在iOS16以及更高版本可用，如果你想在早期版本上做类似的事情。可以通过包装UIKit实现。
 */

// MARK: -
// MARK: 11、处理缩放视图的捏合
/*
 SwiftUI的MangifyGesture用于跟踪视图的缩放，可以绑定到scalEffect()修饰符，因此用户的捏合手势会自动缩放或缩小视图
 */

// MARK: 11.1、MagnifyGesture
/*
 如果想在他们完成手势后保持他们的缩放比例，应该跟踪他们的当前和总缩放的级别。
 */

//@State private var currentZoom = 0.0
//@State private var totalZoom = 1.0
//
//Image(.chrysanthemumTea)
//    .scaleEffect(currentZoom + totalZoom)
//    .gesture(
//        MagnifyGesture()
//            .onChanged({ value in
//                currentZoom = value.magnification - 1
//            })
//            .onEnded({ value in
//                totalZoom += currentZoom
//                currentZoom = 0
//            })
//    )
//    .accessibilityZoomAction { action in
//        if action.direction == .zoomIn {
//            totalZoom += 1
//        } else {
//            totalZoom -= 1
//        }
//    }

/*
 从Value.magnification中减去1很重要，因为1是新手势的默认值，使用accessibilityZoomAction()修饰符可以辅助技术控制缩放级别。
 */

// MARK: 11.2、@GestureState
/*
 另一方面，如果想跟踪他们的手势，但每次都重置为0，使用@GestureState
 */

//@GestureState private var zoom = 1.0
//
//Image(.fullEnglishThumb)
//    .scaleEffect(zoom)
//    .gesture(
//        MagnifyGesture()
//            .updating($zoom, body: { value, gestureState, transaction in
//                gestureState = value.magnification
//            })
//        )
