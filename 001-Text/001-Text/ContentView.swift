//
//  ContentView.swift
//  001-Text
//
//  Created by 舒毅文 on 2023/12/26.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}

#Preview {
    ContentView()
}


// MARK: 1、使用AttributedString给Text添加样式
/*
 SwiftUI的Text视图可以渲染使用Foundation的AttributedString结构创建更复杂的字符串，包括下划线、删除线、网页链接、背景颜色等
 */

// MARK: 1.1、AttributedString通用属性创建Text

//struct ContentView: View {
//    var message: AttributedString {
//        var result = AttributedString("手握日月摘星辰，世间无我这般人。")
//        result.font = .largeTitle
//        result.foregroundColor = .white
//        result.backgroundColor = .red
//        return result
//    }
//    
//    var body: some View {
//        Text(message)
//    }
//}

// MARK: 1.2、多个AttributedString拼接
/*
 由于部分修饰是使用AttributedString自定义完成的，而不是Text，这意味着背景颜色是字符串本身的一部分，如果有需求，可以使用不同的背景颜色将多个字符串合并在一起。
 */

//struct ContentView: View {
//    var message1: AttributedString {
//        var result = AttributedString("手握日月摘星辰，")
//        result.font = .largeTitle
//        result.foregroundColor = .white
//        result.backgroundColor = .red
//        return result
//    }
//    
//    var message2: AttributedString {
//        var result = AttributedString("世间无我这般人。")
//        result.font = .largeTitle
//        result.foregroundColor = .white
//        result.backgroundColor = .blue
//        return result
//    }
//    
//    var body: some View {
//        Text(message1 + message2)
//            .background(.pink)
//        /*
//         Text.background()无效问题：
//         当使用AttributedString修饰自定义字符串的时候，Text.background()修饰符是不起作用的
//         */
//    }
//}

// MARK: 1.3、将单个字符上下偏移

//struct ContentView: View {
//    var message: AttributedString {
//        let string = "将单个字符上下偏移"
//        var result = AttributedString()
//        for (index, letter) in string.enumerated() {
//            var letterString = AttributedString(String(letter))
//            letterString.baselineOffset = sin(Double(index)) * 5
//            result += letterString
//        }
//        result.font = .largeTitle
//        return result
//    }
//    
//    var body: some View {
//        Text(message)
//    }
//}

// MARK: 1.4、Link属性

//struct ContentView: View {
//    var message: AttributedString {
//        var result = AttributedString("Link属性")
//        result.font = .largeTitle
//        result.link = URL(string: "https://hanyu.baidu.com")
//        return result
//    }
//
//    var body: some View {
//        Text(message)
//    }
//}

// MARK: 1.5、保留原数据
/*
 不会丢弃我们提供有关字符串的所有原数据，例如（处于可访问性原因，我们可以将字符串的一部分标记为需要拼写，以便在使用语音时正确读出密码等内容）
 */

//struct ContentView: View {
//    var message: AttributedString {
//        var password = AttributedString("123456")
//        password.accessibilitySpeechSpellsOutCharacters = true
//        return "你的密码是：" + password
//    }
//
//    var body: some View {
//        Text(message)
//    }
//}

// MARK: 1.6、结构化信息
/*
 处理结构化信息的方式，例如：如果我们将Date实例格式化为属性字符串，它会保留每个组件代表的内容的知识 - 例如，它会记住“November”是字符串的月份部分
 */

//struct ContentView: View {
//    var message: AttributedString {
//        var result = Date.now.formatted(.dateTime.weekday(.wide).day().month(.wide).attributed)
//        result.foregroundColor = .secondary
//        
//        let weekday = AttributeContainer.dateField(.weekday)
//        let weekdayStyling = AttributeContainer.foregroundColor(.primary)
//        result.replaceAttributes(weekday, with: weekdayStyling)
//        
//        return result
//    }
//
//    var body: some View {
//        Text(message)
//    }
//}

// MARK: 1.7、特殊字符加粗效果（例如名人、地名）
/*
 处理人名时也是如此PersonNameComponents——这就是一个AttributedString例子，某人的姓氏是粗体的：
 */

//struct ContentView: View {
//    var message: AttributedString {
//        var components = PersonNameComponents()
//        components.givenName = "yiwen"
//        components.familyName = "Shu"
//        
//        var result = components.formatted(.name(style: .long).attributed)
//        
//        let familyNameStyling = AttributeContainer.font(.headline)
//        let familyName = AttributeContainer.personNameComponent(.familyName)
//        result.replaceAttributes(familyName, with: familyNameStyling)
//        
//        return result
//    }
//
//    var body: some View {
//        Text(message)
//    }
//}

// MARK: 1.8、格式化测量单位
/*
 以下代码创建 200 公里的测量值，然后对其进行格式化，数值200显示的大小远大于单位显示大小：
 */

//struct ContentView: View {
//    var message: AttributedString {
//        let amount = Measurement(value: 200, unit: UnitLength.kilometers)
//        var result = amount.formatted(.measurement(width: .wide).attributed)
//        
//        let distanceStyling = AttributeContainer.font(.title)
//        let distance = AttributeContainer.measurement(.value)
//        result.replaceAttributes(distance, with: distanceStyling)
//        
//        return result
//    }
//
//    var body: some View {
//        Text(message)
//    }
//}

// MARK: -
// MARK: 2、multilineTextAlignment() 调整文本对齐方式
/*
 当 SwiftUI 的Text视图跨多行换行时，它们默认与其左端对齐。如果你想更改它，使用multilineTextAlignment()修饰符指定替代项，例如.center、 或.trailing。
 */

// MARK: 2.1、多行文本换行居中

//struct ContentView: View {
//    var body: some View {
//        Text("《瓦尔登湖》一书，详细地记录了作家在长达两年的时间里的日常生活状态以及所思所想，他在小木屋旁开荒种地，春种秋收，自给自足。")
//            .font(.largeTitle)
//            .multilineTextAlignment(.center)
//            .frame(width: 300)
//    }
//}

// MARK: 2.2、使用picker选择器动态修改3种对齐方式

//struct ContentView: View {
//    let alignments: [TextAlignment] = [.leading, .center, .trailing]
//    @State private var alignment = TextAlignment.leading
//    
//    var body: some View {
//        List {
//            Section() {
//                Picker("Text alignment", selection: $alignment) {
//                    ForEach(alignments, id: \.self) { alignment in
//                        Text(String(describing: alignment))
//                    }
//                }
//                
//                Text("《瓦尔登湖》一书，详细地记录了作家在长达两年的时间里的日常生活状态以及所思所想，他在小木屋旁开荒种地，春种秋收，自给自足。")
//                    .font(.largeTitle)
//                    .multilineTextAlignment(alignment)
//                    .frame(width: 300)
//            }
//        }
//    }
//}

// MARK: -
// MARK: 3、使用format格式化文本
/*
 SwiftUI 的文本视图能够通过其format参数显示日期、数组、测量值等。
 */

// MARK: 3.1、format: .list(type: .and)
/*
 如果将格式类型与字符串数组一起使用.list()，则可以获得格式整齐的列表，例如“Howard、Josie 和 Kingsley”。例如，无论添加多少项目，这都将正确打印成分列表：
 
 Text(ingredients, format: .list(type: .and))

 Button("Add Ingredient") {
     let possibles = ["Egg", "Sausage", "Bacon","Spam"]
     
     if let newIngredieng = possibles.randomElement() {
         ingredients.append(newIngredieng)
     }
 }

 如果有一个数字类型的数组（例如整数），则可以通过指定成员样式来格式化该数组
 
 Text(ingredients, format: .list(type: .and))

 Button("Add Ingredient") {
     let possibles = ["Egg", "Sausage", "Bacon","Spam"]
     
     if let newIngredieng = possibles.randomElement() {
         ingredients.append(newIngredieng)
     }
 }
 */

// MARK: 3.2、.measurement()
/*
 如果您正在处理距离或重量等测量值，.measurement()格式类型将自动调整您的值以在用户区域设置中显示。例如，如果您在内部存储以厘米为单位的值，但用户设备上的区域设置为美国，iOS 将根据值的大小自动显示以英尺或英寸为单位的值。
 
 Text(rolls, format: .list(memberStyle: .number, type: .and))

 Button("Roll Dice") {
     let result = Int.random(in: 1...6)
     rolls.append(result)
 }
 */

// MARK: 3.3、.currency(code: "CAD")
/*
 格式化货币符号，确保显示的是两位小数，并根据需要添加货币符号
 */

//struct ContentView: View {
//    var body: some View {
//        Text(72.3, format: .currency(code: "CAD"))
//    }
//}

// MARK: -
// MARK: 4、添加字母之间的间距
/*
 SwiftUI 为我们提供了两个修饰符来控制文本试图内的字符距离，使我们能够根据需要使字母间隔更紧密或更远。两个修饰符是tracking()和kerning():都在字母之间添加间距，但tracking会将连体分开，而kerning不会，并且kerning会留下一些空白，而tracnking不会。
 */

// MARK: 4.1、tracking()
/*
 将“Hello world”的tranking值设定为20，效果是字母键间隔非常大
 */

//struct ContentView: View {
//    var body: some View {
//        Text("Hello world")
//            .tracking(20)
//    }
//}

// MARK: 4.2 使用动态滑块Slider动态比较tracking与knening
/*
 例子使用了字体“AmericanTyperwriter”中的文本“ffi”，它有一个结合的字母子和，因为tracking会将结合分开，而kerning不会，所以当调整滑块的时候，第一个文本看起来像“f fi”，第二个文本看起来像“f f i”
 */

//struct ContentView: View {
//    @State private var amount = 50.0
//
//    var body: some View {
//        List {
//            Section {
//                Text("ffi")
//                    .font(.custom("AmericanTyperwriter", size: 72))
//                    .kerning(amount)
//                Text("ffi")
//                    .font(.custom("AmericanTyperwriter", size: 72))
//                    .tracking(amount)
//                
//                Slider(value: $amount, in: 0...100) {
//                    Text("Adjust the amount of spacing")
//                }
//            }
//        }
//    }
//}

// MARK: -
// MARK: 5、格式化文本视图中的日期
/*
 SwiftUI 的文本试图附带两种特定的日期格式化函数，以使日期在屏幕上看起来更好：一种是用来处理耽搁日期，另一种用来处理日期范围
 */

// MARK: 5.1、addingTimeInterval
/*
 日期范围实际上非常简单，因为你只需要提供一个封闭的时间范围，他将确保根据用户的区域设置正确的格式
 */

//struct ContentView: View {
//    var body: some View {
//        Text(Date.now...Date.now.addingTimeInterval(600))
//    }
//}

// MARK: 5.2、 使用style参数来确定日期的格式

//struct ContentView: View {
//    var body: some View {
//        // 只显示日期
//        Text(Date.now.addingTimeInterval(600), style: .date)
//        // 只显示时间
//        Text(Date.now.addingTimeInterval(600), style: .time)
//        // 显示距离现在的相对时间，自动更新(倒计时)
//        Text(Date.now.addingTimeInterval(600), style: .relative)
//        // 创建定时器样式，自动更新
//        Text(Date.now.addingTimeInterval(600), style: .time)
//    }
//}

// MARK: 6、使用 textCase() 将 TextField 设置为大写或小写
/*
 SwiftUI的TextField视图通常允许用户以他们想要的任何大小写的形式编辑内容，但如果你想控制它，你可以使用修饰符来强制使用大写或者小写textCase()
 */

//struct ContentView: View {
//    @State private var name = "Aiewing"
//    var body: some View {
//        List {
//            Section {
//                // 将用户输入的名字每个字母改成大写字母
//                TextField("Shout your name at me", text: $name)
//                    .textFieldStyle(.roundedBorder)
//                    .textCase(.uppercase)
//                    .padding(.horizontal)
//            }
//        }
//    }
//}

// MARK: 7、使用Label标签并排显示文本和图标
/*
 SwiftUI 有一个专属的视图类型，用于并排显示文本和图标，这对于菜单、列表非常有用
 */

//struct ContentView: View {
//    var body: some View {
//        
//        List {
//            Section {
//                //使用系统图库
//                Label("Your Account", systemImage: "folder.circle")
//                //使用自己导入的icon
//                Label("Welcome to the app", image: "chincoteague")
//                
//                //可以使用修改器并行缩放文本和图标font()
//                Label("Your Account", systemImage: "person.crop.circle")
//                    .font(.title)
//            }
//            
//            Section {
//                // labelStyle()可以使用.titleOnly、.iconOnly和.titleAndIcon来控制标签的显示方式
//                Label("Text Only", systemImage: "heart")
//                    .font(.title)
//                    .labelStyle(.titleOnly)
//                
//                Label("Icon Only", systemImage: "star")
//                    .font(.title)
//                    .labelStyle(.iconOnly)
//                
//                Label("Both", systemImage: "paperplane")
//                    .font(.title)
//                    .labelStyle(.titleAndIcon)
//            }
//            
//            //完全自定义
//            Section {
//                Label {
//                    Text("Paul Hudson")
//                        .foregroundStyle(.primary)
//                        .font(.largeTitle)
//                        .padding()
//                        .background(.gray.opacity(0.2))
//                        .clipShape(Capsule())
//                } icon: {
//                    RoundedRectangle(cornerRadius: 10)
//                        .fill(.blue)
//                        .frame(width: 64, height: 64)
//                }
//            }
//        }
//    }
//}

// MARK: -
// MARK: 8、使用 redacted() 将内容标记为占位符
/*
 SwiftUI 允许我们将文本标记为视图中的占位符，这就意味着它会被渲染，但会被灰色遮盖以表明它不是最终的内容。这是通过redacted(reason:)修改器提供的，以及unredacted()可根据需要用于覆盖密文的修改器
 */

// MARK: 8.1、基础代码

//struct ContentView: View {
//    var body: some View {
//        Text("This is PlaceHolder text")
//            .font(.title)
//            .redacted(reason: .placeholder)
//    }
//}

// MARK: 8.2、可以将redacted修饰符提升到父控件以控制更多的Text

//struct ContentView: View {
//    var body: some View {
//        Section {
//            Text("This is Placehoder text")
//                Text("And so is thid")
//        }
//        .font(.title)
//        .redacted(reason: .placeholder)
//    }
//}

// MARK: 8.3、根据环境变量确定目前Text的状态
/*
 苹果表示，这是一个附加的过程，这意味着如果你向父集和子集添加编辑原因，那么他们就会合并。现在只有.placeholder,但也许我们将来会看到像素化或类似的，你还可以查询从环境软儒的任何编辑原因
 */

//struct ContentView: View {
//    @Environment(\.redactionReasons) var redactionReasons
//    let bio = "The rain in Span falls mainly on the Spaniards"
//    
//    var body: some View {
//        List {
//            Section {
//                if redactionReasons == .placeholder {
//                    Text("Loading...")
//                } else {
//                    Text(bio)
//                        .redacted(reason: redactionReasons)
//                }
//            }
//        }
//    }
//}

// MARK: -
// MARK: 9、 使用privacySensitive()将内容标记为私有
/*
 SwiftUI 允许我们将视图的某些部分标记为包含敏感信息，这实际上使我们可以使用密文更轻松的隐藏或显示它。要在代码中使用此功能，请首先将privacySensitive()修饰符添加到想要隐藏的任何视图，然后将.redacted(reason: .privacy)修饰符应用到视图层次中更高的位置
 */

// MARK: 9.1、privacySensitive
/*
 如果视图在非私有上下文中显示，则会隐藏用户的信用卡号
 */

//struct ContentView: View {
//    var body: some View {
//        Text("Card number")
//            .font(.headline)
//        Text("1234 5678 9012 3456")
//            .privacySensitive()
//    }
//}

// MARK: 9.2、通过@Environment读取
/*
 默认情况下，因此敏感上下文被灰色框屏蔽，但你也可以通过从环境中读取密文来提供自定义布局
 */

//struct ContentView: View {
//    @Environment(\.redactionReasons) var redactionReasons
//    var body: some View {
//        List {
//            Section {
//                Text("Card number")
//                    .font(.headline)
//                
//                if redactionReasons.contains(.privacy) {
//                    Text("[Hidden]")
//                } else {
//                    Text("1234 5678 9012 3456")
//                }
//            }
//        }
//    }
//}

// MARK: -
// MARK: 10、在Text中呈现 Markdown 内容
/*
 SwiftUI 内置了对Markdown渲染的支持，包括粗体、斜体、链接等。它实际上内置SwiftUI的Text视图中
 */

//struct ContentView: View {
//    var body: some View {
//        Text("This is regular text.")
//        Text("* This is **bold** text,this is *italic* text, and this is ***bold, italic*** text.")
//        Text("~~A strikethrough example~~")
//        Text("`Monospaced works too`")
//        Text("Visit Apple: [click here](https://apple.com)")
//    }
//}

// MARK: 10.1、tint
/*
 该链接是可以点击的，默认情况下，Markdown链接将使用应用程序的强调色，但你可以使用tint()主题修饰符来更改它
 */

//struct ContentView: View {
//    var body: some View {
//        Text("Visit Apple: [Click here](https://Apple.com)")
//            .tint(.red)
//    }
//}

// MARK: 10.2、LocallizedStringKey
/*
 发生这种自动Markdown转换是因为SwiftUI将这些字符串解释为LocallizedStringKey可以由我们的应用程序本地化的字符串实例。这意味着如果你想从属性或者变量创建Markdown文本，你应该将其显示标记为LocallizedStringKey来获取Markdown的渲染
 */

//struct ContentView: View {
//    var body: some View {
//        let markdownText: LocalizedStringKey = "* This is **bold** text,this is *italic* text, and this is ***bold, italic*** text."
//        Text(markdownText)
//    }
//}

// MARK: 10.3、关于删除LocallizedStringKey和Text(verbatim:)
/*
 如果你希望原始的文本保持不变，只需要删除类型LocallizedStringKey。或者，你也可以使用初始化程序完全禁止Markdown和本地化Text(verbatim:)
 */

//struct ContentView: View {
//    var body: some View {
//        let markdownText1 = "* This is **bold** text,this is *italic* text, and this is ***bold, italic*** text."
//        Text(markdownText1)
//
//        let markdownText2 = "* This is **bold** text,this is *italic* text, and this is ***bold, italic*** text."
//        Text(verbatim: markdownText2)
//    }
//}

// MARK: 11、自定义Link处理方式
/*
 当你的用户点击了SwiftUIText或Link视图中显示的URL时，默认情况下它将在Safari中打开。但是，你可以通过openURL环境密钥来自定义此行为-你可能希望自己处理链接，或者可能在自定义操作完成后将其传递回系统再打开
 */

//struct ContentView: View {
//    var body: some View {
//        List {
//            Section {
//                //此代码调整Link和Text视图，以便将所有URL发送到handleURL()要执行操作的方法
//                Link("Visit Apple", destination: URL(string: "https://apple.com")!)
//                Text("[Visit Apple](https://apple.com)")
//            }
//            .environment(\.openURL, OpenURLAction(handler: handleURL))
//            
//            //如上所示，handleURL()返回OpenURLAction.Result的值.handle,这意味着该方法接受了链接并对其进行了操作。当然还有其他枚举值可以操作:
//            // .discarded：表示无法处理该链接
//            // .systemAction如果你想触发默认行为（除了你自己的逻辑之外）
//            // .systemAction(someOtherURL)如果你想使用默认行为打开不同的URL（可能是最初护发的URL的修改版本）
//            Section {
//                //默认情况下链接将使用应用程序的强调色，但是可以使用主题修饰符修改tint()
//                Text("[Visit Apple](https://apple.com)")
//                    .tint(.indigo)
//            }
//        }
//    }
//
//    func handleURL(_ url: URL) -> OpenURLAction.Result {
//        print("Handle \(url) somehow")
//        return .handled
//    }
//}

// MARK: -
// MARK: 12、Text的长按选择
/*
 默认情况下，Swift的Text视图表示静态、不可选择的文本，但是你可以使用.textSslection()带有值的修饰符来更改它为.enabled
 */

// MARK: 12.1、textSelection长按开启

//struct ContentView: View {
//    var body: some View {
//        Text("You can't touch this")
//        Text("Break it down!")
//            .textSelection(.enabled)
//    }
//}

// MARK: 12.2、批量操作
/*
 对任何类型的视图组进行设置都会自动使该组内的所有文本都可选择。例如，我们可以通过将修饰符添加到外层的Section组件上来使两个Text文本都可以选择copy
 
 注意：如果对list的section进行修饰，这个时候需要按住文本内容，点击空白处不会触发选择
 */

struct ContentView: View {
    var body: some View {
        Section {
            Text("You can't touch this")
            Text("Break it down!")
        }
        .textSelection(.enabled)
    }
}
