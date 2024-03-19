//
//  ContentView.swift
//  011-Form
//
//  Created by 舒毅文 on 2024/3/19.
//

/*
 https://juejin.cn/post/7265673876033093695
 */

import SwiftUI

#Preview {
    ContentView()
}

// MARK: -
// MARK: 1、Form详细解释
/*
 Swift坚定的专注于声明式用户界面，因此提供了一种构建表单的奇妙机制--用于收集信息的用户输入控件集合，比如订单或设置页面。SwiftUI实际上动态调整布局，可以根据代码运行的平台自动制作全新的UI--它完全理解了控件的目的和视觉效果。这意味着通过描述告诉他想要什么，然后SwiftUI实现在当前平台上。表单就像VStack一样的常规容器，可以根据需求在两者之间自由的切换。
 */

//struct ContentView: View {
//    var body: some View {
//        Form {
//            Text("Hello World!")
//        }
//    }
//}

// MARK: -
// MARK: 2、创建Form
/*
 SwiftUI的From像容器一样工作，就像HStack和VStack一样，这意味着可以根据需要在其中添加其他视图。但是，会自动调整某些控件的行为和样式，以便更好的适应Form环境。
 */

//struct ContentView: View {
//    @State private var enableLogging = false
//    @State private var selectedColor = "red"
//    @State private var colors = ["red", "green", "blue"]
//    var body: some View {
//        Form {
//            Picker("Select a color", selection: $selectedColor) {
//                ForEach(colors, id: \.self) {
//                    Text($0)
//                }
//            }
//            .pickerStyle(.segmented)
//            
//            Toggle("Enable Logging", isOn: $enableLogging)
//            
//            Button("Save Changes") {
//                print("Save")
//            }
//        }
//    }
//}

// MARK: -
// MARK: 3、Form的Section
/*
 SwiftUI的Form通常分成几个Section时工作的最好，就像常规的内容列表一样。如何分解取决于需求，但通常情况下，根据它们的目的对他们进行分组时效果最好，如果它是一个订单页面，可能会把物品放在一组，订单放在一起，支付分一组。From的section与List的Section相同，这意味着可以在这两个地方重用相同的代码。所以，可以添加header/footer到section，或者两者都不用，只是在section之间获得一些屏幕上的间距。
 */

//struct ContentView: View {
//    @State private var enableLogging = false
//    @State private var selectedColor = "red"
//    @State private var colors = ["red", "green", "blue"]
//    var body: some View {
//        Form {
//            Section {
//                Picker("Select a color", selection: $selectedColor) {
//                    ForEach(colors, id: \.self) {
//                        Text($0)
//                    }
//                }
//                .pickerStyle(.segmented)
//
//                Toggle("Enable Logging", isOn: $enableLogging)
//            } footer: {
//                Text("Note: Enable logging may slow down the app")
//            }
//
//            Section {
//                Button("Save Changes") {
//                    print("Save")
//                }
//            }
//        }
//    }
//}

// MARK: -
// MARK: 4、Form的Picker
/*
 SwiftUI的picker在Form中有特殊的行为，会根据你使用的平台自动调整，在iOS上，picker将被折叠成一个单独的列表行，以弹出菜单的形式显示所有可用的选项。
 */

//struct ContentView: View {
//    @State private var selectedStrength = "Mild"
//    let strengths = ["Mild", "Medium", "mature"]
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section {
//                    // 在iOS上，这将标识一个单独的列表行出现，可以点击它来显示所有的选项--"Mild", "Medium", "Mature"
//                    Picker("Strength", selection: $selectedStrength) {
//                        ForEach(strengths, id: \.self) {
//                            Text($0)
//                        }
//                    }
//                }
//                
//                Section {
//                    // 如果想禁用此行为，使用pickerStyle(.wheel)修饰符强制选择器使用常规样式
//                    Picker("Strength", selection: $selectedStrength) {
//                        ForEach(strengths, id: \.self) {
//                            Text($0)
//                        }
//                    }
//                    .pickerStyle(.wheel)
//                }
//            }
//            .navigationTitle("Select your choose")
//        }
//    }
//}

// MARK: -
// MARK: 5、启用和禁用Form中的element
/*
 通过使用disable()修饰符，可以禁用form的任何section，甚至整个form。接受一个bool值，用来定义element是否应该被禁用。form的element的样式会自动更新，以反映其状态--例如，按钮和开关会变灰。
 */

//struct ContentView: View {
//    @State private var agreedToTerms = false
//    var body: some View {
//        Form {
//            Section {
//                Toggle("Agree", isOn: $agreedToTerms)
//            }
//            
//            Section {
//                Button("Continue") {
//                    print("Thank you!")
//                }
//                .disabled(agreedToTerms == false)
//            }
//            // 像许多其他SwiftUI修饰符一样，disabled状态是可以解除的，可以附加到section，
//            // 可以附加到Form，根据需求来决定禁用某一行还是禁用整块区域。
//        }
//    }
//}

// MARK: -
// MARK: 6、显示和隐藏Form-rows
/*
 根据需要在表单中添加和删除项目，当想要根据之前的选项调整可见选项列表时，这一特性可用。
 */

//struct ContentView: View {
//    @State private var showing = false
//    @State private var enable = false
//    var body: some View {
//        Form {
//            Section {
//                Toggle("Show", isOn: $showing.animation())
//                
//                if showing {
//                    Toggle("Enable", isOn: $enable)
//                }
//            }
//        }
//    }
//}

// MARK: -
// MARK: 7、创建对齐Form文本和控件整齐的LabelContent
/*
 SwiftUI的表单做的很好，让许多视图看起来很好，但有时需要一点额外的控制来获得正确的结果--正确的对齐文本，标记自定义视图，或者对齐没有带标签的空间，比如Slider
 */

// MARK: 7.1、LabeledContent
/*
 使用LabeledContent，类似于badge()修饰符
 */

//struct ContentView: View {
//    var body: some View {
//        Form {
//            LabeledContent("This is important", value: "Value goes here")
//        }
//    }
//}

/*
 这把标题放在前面，而值放在后面，对齐方式将根据平台自动调整，iOS左对齐标题，右对齐值，而macOS右对齐标题左对齐值，对于macOS上的Form尤其重要，因为其他视图类型（如TextField和Toggle）会自动对齐标题和值，而slider不会。
 
 在iOS上，使用LabeledContent会得到与使用Text相同的结果，但LabeledContent真正强大之处在于它可以接受任何视图，而badge只接受文本和数字
 */

// MARK: 7.2、Image
/*
 使用LabeledContent来创建一个包含Image的视图
 */

//struct ContentView: View {
//    var body: some View {
//        Form {
//            LabeledContent("This is important", value: "Value goes here")
//            LabeledContent("This is Imaged") {
//                Image(systemName: "exclamationmark.triangle")
//            }
//        }
//    }
//}

// MARK: 7.3 Slider
/*
 但更重要的是，也可以在任何通常没有标签的视图使用它，比如slider
 */

//struct ContentView: View {
//    @State private var brightness = 50
//    var body: some View {
//        Form {
//            LabeledContent("This is important", value: "Value goes here")
//            LabeledContent("This is Imaged") {
//                Image(systemName: "exclamationmark.triangle")
//            }
//            LabeledContent {
//                Slider(value: $brightness)
//            } label: {
//                Text("Brightness")
//            }
//        }
//    }
//}

/*
 在写文本时是，一些SwiftUI视图（如Stepper）将不会使用LabeledContent的标题作为VoiceOver。这使得可以在访问性支持方面相当不透明。
 */

// MARK: 7.4、两段文本
/*
 如果你的labeledContent的标题包含两段文本，iOS会自动以更小、更亮的字体呈现第二段文本，使其看起来像副标题。
 */

//struct ContentView: View {
//    @State private var brightness = 50
//    var body: some View {
//        Form {
//            LabeledContent("This is important", value: "Value goes here")
//            LabeledContent("This is Imaged") {
//                Image(systemName: "exclamationmark.triangle")
//            }
//            LabeledContent {
//                Text("Value")
//            } label: {
//                Text("Title")
//                Text("Subtitle")
//            }
//
//        }
//    }
//}

// MARK: 7.5、多段文本
/*
 事实上，使用这种方法，最多支持四段文本，每一段都会变得更小
 */

//struct ContentView: View {
//    @State private var brightness = 50
//    var body: some View {
//        Form {
//            LabeledContent("This is important", value: "Value goes here")
//            LabeledContent("This is Imaged") {
//                Image(systemName: "exclamationmark.triangle")
//            }
//            LabeledContent {
//                Text("Value")
//            } label: {
//                Text("Title")
//                Text("Subtitle")
//            }
//            LabeledContent {
//                Text("Value")
//            } label: {
//                Text("Title")
//                Text("Subtitle")
//                Text("Subsubtitle")
//                Text("Subsubsubtitle")
//            }
//
//        }
//    }
//}

// MARK: 7.6、labelHidden
/*
 将labelHidden()修饰符应用于任何LabeledContent，则标签标题将被隐藏，而value将保持可见。
 */

//struct ContentView: View {
//    @State private var brightness = 50
//    var body: some View {
//        Form {
//            LabeledContent("This is important", value: "Value goes here")
//            LabeledContent("This is Imaged") {
//                Image(systemName: "exclamationmark.triangle")
//            }
//            LabeledContent {
//                Text("Value")
//            } label: {
//                Text("Title")
//                Text("Subtitle")
//            }
//            LabeledContent {
//                Text("Value")
//            } label: {
//                Text("Title")
//                Text("Subtitle")
//                Text("Subsubtitle")
//                Text("Subsubsubtitle")
//            }
//
//            LabeledContent {
//                Text("Value")
//            } label: {
//                Text("Title")
//                Text("Subtitle")
//            }
//            .labelsHidden()
//
//        }
//    }
//}
