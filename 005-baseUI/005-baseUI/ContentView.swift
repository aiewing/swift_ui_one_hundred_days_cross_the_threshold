//
//  ContentView.swift
//  005-BaseUI
//
//  Created by 舒毅文 on 2024/2/23.
//

import SwiftUI

#Preview {
    ContentView()
}

// MARK: -
// MARK: 1、@State的工作原理
/*
 SwiftUI中的@State是一个属性包装器，用于在视图中存储和管理可变的状态。使用@State属性包装器声明的变量在属性值改变时自动触发视图的重新渲染。@State属性包装器是SwiftUI中用于管理视图内部可变状态的重要机制，它确保了视图与状态的一致性，在界面交互中能够方便地更新和响应状态的变化。
 
 @State private var counter = 0
 
 工作原理如下：

 1. 声明状态属性：使用@State属性包装器将属性声明为状态属性。例如：@State private var counter = 0。这将创建一个名为counter的私有状态属性，并将其初始化为0。
 2. 视图的更新：当使用@State属性的视图发生更改时，SwiftUI会自动检测这些更改，并在属性值改变时触发视图的重新渲染。这意味着如果你在视图中使用了该状态属性，当该属性的值发生变化时，视图会自动更新以反映最新的值。
 3. 不可变性保证：由于@State属性是不可变的，SwiftUI确保对状态属性的修改只能在视图内部进行。这样可以防止不同视图之间意外地修改状态，并确保状态的一致性。
 4. 局部性：每个@State属性都与特定视图实例相关联。当你在多个相同类型的视图中使用相同名称的@State属性时，它们是彼此独立的，互不影响。
 5. 更新方式：要更新@State属性的值，你需要使用$符号来访问绑定到该状态属性的变量。例如，要在视图内部更新counter属性，你可以使用$counter来获取绑定，然后进行更改。SwiftUI会在更改时自动更新相关视图。
 6. 仅限于视图内部：@State属性通常用于在视图内部共享数据，因为它们的作用范围仅限于视图本身及其子视图。对于需要在多个视图之间共享状态的情况，使用@Binding、@ObservedObject或@EnvironmentObject等属性包装器。
 */

// MARK: -
// MARK: 2、创建Button
/*
 SwiftUI的Button和UIButton类似，但显示内容方面更加灵活，并且它的操作使用闭包而不是原来的target-action
 */

// MARK: 2.1、创建带有字符串标题的Button

//struct ContentView: View {
//    var body: some View {
//        Button("Button title") {
//            print("Button tapped!")
//        }
//    }
//}

// MARK: 2.2、创建一个Button，点击时显示/隐藏一些详细文本

//struct ContentView: View {
//    
//    @State private var showDetails = false
//    
//    var body: some View {
//        VStack(alignment: .leading, content: {
//            Button("Show Details") {
//                showDetails.toggle()
//            }
//            
//            if showDetails {
//                Text("蜀道难")
//                    .font(.largeTitle)
//            }
//        })
//    }
//}

// MARK: 2.3、创建一个图像Button

//struct ContentView: View {
//    var body: some View {
//        Button(action: {
//            print("Image tapped!")
//        }, label: {
//            Image("virgin-mojito")
//        })
//
//    }
//}

// MARK: 2.4、创建一个点击区域比实际区域大的Button
/*
 如果想要增加Button的可点击区域时，将Button的标签添加20个padding，获得更大的点击范围
 */

//struct ContentView: View {
//    var body: some View {
//        Button {
//            print("Button pressed")
//        } label: {
//            Text("Press Me")
//                .padding(20)
//        }
//        .contentShape(Rectangle())
//    }
//}

// MARK: 2.5、通过role创建Button，来改变样式
/*
 在iOS15以及更高的版本，你还可以为button添加一个role参数，有几个枚举，其实就是SwiftUI为你定义好了几种样式的Button。例如，如果创建一个删除按钮，用.destructive来标记它，Button显示红色
 */

//struct ContentView: View {
//    var body: some View {
//        Button("Delete", role: .destructive) {
//            print("Perform delete")
//        }
//        
//        Button("Detail", role: .cancel) {
//            print("Perform cancel")
//        }
//
//    }
//}

// MARK: -
// MARK: 3、Button和NavigationLink
/*
 在SwiftUI中，Button和NavigationLink中的图像默认会显示覆盖颜色，以提供按下按钮或激活链接时的视觉反馈。如果想禁用这种覆盖颜色，自定义button样式来避免应用任何覆盖效果。
 */

// MARK: 3.1、.renderingMode(.original)
/*
 保留原有图像颜色
 */

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            NavigationLink {
//                Text("Detail View Here")
//            } label: {
//                Image("ai_image")
//                    .renderingMode(.original)
//            }
//        }
//        .frame(height: 200)
//    }
//}

// MARK: 3.2、.buttonStyle(.plain)
/*
 将buttonStyle设定为.plain
 */

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            NavigationLink {
//                Text("Detail View Here")
//            } label: {
//                Image("ai_image")
//            }
//            .buttonStyle(.plain)
//        }
//        .frame(height: 200)
//    }
//}

// MARK: 3.3、 Button

//struct ContentView: View {
//    var body: some View {
//        Button {
//            print("Button click")
//        } label: {
//            Image("ai_image")
//        }
//        .buttonStyle(.plain)
//    }
//}

// MARK: -
// MARK: 4、Button的Bordered

// MARK: 4.1、基础样式

//struct ContentView: View {
//    var body: some View {
//        Button("Buy: $0.99") {
//            print("Buying....")
//        }
//        .buttonStyle(.bordered)
//    }
//}

// MARK: 4.2、borderedProminent

//struct ContentView: View {
//    var body: some View {
//        Button("But: $993") {
//            print("Buying./....")
//        }
//        .buttonStyle(.borderedProminent)
//    }
//}

// MARK: 4.3、tint

//struct ContentView: View {
//    var body: some View {
//        Button("Submit") {
//            print("Buying./....")
//        }
//        .tint(.indigo)
//        .buttonStyle(.borderedProminent)
//    }
//}

// MARK: 4.4、.role

//struct ContentView: View {
//    var body: some View {
//        Button("Delete", role: .destructive) {
//            print("Buying./....")
//        }
//        .buttonStyle(.borderedProminent)
//    }
//}

// MARK: -
// MARK: 5、ControlGroup
/*
 在SwiftUI中，ControlGroup是一个容器视图，用于将多个视图组合在一起，并以类似于控件组的样式呈现。
 */

//struct ContentView: View {
//    var body: some View {
//        ControlGroup {
//            Button("First") { }
//            Button("Second") { }
//            Button("Thread") { }
//        }
//    }
//}

// MARK: -
// MARK: 6、TextField
/*
 SwiftUI的TextField与UIKit中的UITextField类似，默认情况下看起来不同，非常依赖状态绑定,创建一个TextField，传入一个文本字段内使用占位符，以及它应绑定的状态值。
 */

//struct ContentView: View {
//    @State private var name: String = "Aie"
//    var body: some View {
//        VStack(alignment: .leading, content: {
//            TextField("输入你的名字", text: $name)
//            Text("Hello, \(name)")
//        })
//    }
//}

/*
 使用TextField时有两个重要限制条件:

 默认情况下它们没有边框，因此看不到任何内容
 点击才能激活键盘
 */

// MARK: 7、submitLabel
/*
 自定义TextField、SecureField和TextEditor的submitLabel按钮，默认情况下，TextField和SecureField在键盘上显示一个简单的“return”按钮，可以使用submitlabel()修饰符从一系列替枚举中进行选择。
 */

//struct ContentView: View {
//    @State private var username: String = "Aie"
//    var body: some View {
//        // 修改为join
//        TextField("Username", text: $username)
//            .submitLabel(.join)
//    }
//}

/*
 通过submitLabel修饰符：可以选择不同的枚举：

 continue
 done
 go
 join
 next
 return
 route
 search
 send
 适用于TextField、SecureField、TextView输入控件
 */

// MARK: 8、给TextField添加圆角边框
/*
 如何向TextField添加边框,默认情况下，SwiftUI的TextField视图没有样式，在屏幕上表现为空白区域。通常情况下，会添加边框使其更具有辨识度
 */

//struct ContentView: View {
//    @State private var name: String = "Aie"
//    var body: some View {
//        VStack(alignment: .leading, content: {
//            TextField("输入你的名字", text: $name)
//                .textFieldStyle(.roundedBorder)
//            Text("Hello, \(name)")
//        })
//    }
//}

// MARK: -
// MARK: 9、给TextField添加PlaceHolder

//struct ContentView: View {
//    @State private var emailAddress = ""
//    var body: some View {
//        List {
//            TextField("metabblv@163.com", text: $emailAddress)
//                .textFieldStyle(.roundedBorder)
//                .padding()
//        }
//    }
//}


// MARK: 10、使TextField文本自动更正
/*
 SwiftUI的TextField默认开启自动更正，这在大多数时候都是ok的，但是，如果你想禁用它，使用autocorrectionDisabled()修饰符,默认是true
 */

//struct ContentView: View {
//    @State private var name = ""
//    var body: some View {
//        TextField("输入你的名字", text: $name)
//            .autocorrectionDisabled()
//    }
//}

// MARK: 11、关闭TextField的键盘
/*
 SwiftUI在输入时自动显示键盘，但在iOS15之前，输入完成后隐藏键盘很麻烦，特别是当你使用keyboardType()的.numberPad、.decimalPad、.phonePad修饰符时。在iOS15或更高版本，则可以通过聚焦和取消聚焦来激活和关闭TextField的键盘，最简单的情况是使用@FocusState属性包装器和focusable修饰符来完成：第一个存储一个bool值，用于跟踪第二个当前是否处于焦点状态
 */

// MARK: 11.1、点击Button关闭键盘

//struct ContentView: View {
//    @State private var name = ""
//    @FocusState private var nameIsFocused: Bool
//    var body: some View {
//        List {
//            TextField("输入你的名字", text: $name)
//                .focused($nameIsFocused)
//            
//            Button("Submit") {
//                nameIsFocused = false
//            }
//        }
//    }
//}

// MARK: 11.2、通过Enum监控焦点
/*
 更复杂的使用方法，可以通过@FocusState跟踪enum的值关注表单字段。例如，创建一个表单，包含3个文本字段，最后确认是否信息完全填入成功。
 */

//struct ContentView: View {
//    enum Field {
//        case firstName
//        case lastName
//        case emailAddress
//    }
//
//    @State private var firstName = ""
//    @State private var lastName = ""
//    @State private var emailAddress = ""
//    @FocusState private var focusedField: Field?
//    
//    var body: some View {
//        VStack {
//            TextField("Enter your first name", text: $firstName)
//                .focused($focusedField, equals: .firstName)
//                .textContentType(.givenName)
//                .submitLabel(.next)
//            TextField("Enter your last name", text: $lastName)
//                .focused($focusedField, equals: .lastName)
//                .textContentType(.familyName)
//                .submitLabel(.next)
//            TextField("Enter your email Address", text: $emailAddress)
//                .focused($focusedField, equals: .emailAddress)
//                .textContentType(.emailAddress)
//                .submitLabel(.join)
//        }
//        .onSubmit {
//            switch focusedField {
//            case .firstName:
//                focusedField = .lastName
//            case .lastName:
//                focusedField = .emailAddress
//            default:
//                print("Creating account....")
//            }
//        }
//    }
//}

// MARK: 11.3、通过UIKit函数强制关闭键盘

//#if canImport(UIKit)
//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
//#endif
//
//struct ContentView: View {
//    @State private var tipAmount = ""
//    var body: some View {
//        TextField("Tip Amount", text: $tipAmount)
//            .textFieldStyle(.roundedBorder)
//            .keyboardType(.decimalPad)
//
//        Button("Submit") {
//            print("Tip: \(tipAmount)")
//            hideKeyboard()
//        }
//    }
//}

// MARK: -
// MARK: 12、使TextField或TextEditor具有默认focus
/*
 macOS上的SwiftUI提供了一个defaultFocus()修饰符，可以在视图显示后立即激活键盘，作为用户输入的第一响应者，但是，在iOS上不存在，只能使用onAppear()
 */

//struct ContentView: View {
//    enum FocusedField {
//        case firstName, lastName
//    }
//
//    @State private var firstName = ""
//    @State private var lastName = ""
//    @FocusState private var focusedField: FocusedField?
//
//    var body: some View {
//        Form {
//            TextField("First name", text: $firstName)
//                .focused($focusedField, equals: .firstName)
//            
//            TextField("Last name", text: $lastName)
//                .focused($focusedField, equals: .lastName)
//        }
//        .onAppear() {
//            focusedField = .firstName
//        }
//    }
//}

// MARK: 12.2、mac写法.defaultFocus()

//struct ContentView: View {
//    enum FocusedField {
//        case firstName, lastName
//    }
//
//    @State private var firstName = ""
//    @State private var lastName = ""
//    @FocusState private var focusedField: FocusedField?
//
//    var body: some View {
//        Form {
//            TextField("First name", text: $firstName)
//                .focused($focusedField, equals: .firstName)
//            
//            TextField("Last name", text: $lastName)
//                .focused($focusedField, equals: .lastName)
//        }
//        .defaultFocus($focusedField, .lastName)
//    }
//}

// MARK: 13、使TextField随着输入的内容增多而垂直扩展
/*
 SwiftUI的TextField默认是单行，并且TextEditor根据你要分配的空间大小提供多行替代方案。如果将axis参数传递给TextField，可以要求它以单行开始并随着输入而增长，并且可以选择文本超过一定长度后切换到滚动。
 */

// MARK: 13.1、行数无限延伸

//struct ContentView: View {
//    @State private var bio = "Ablout me"
//    var body: some View {
//        TextField("Describe yourself", text: $bio, axis: .vertical)
//            .textFieldStyle(.roundedBorder)
//    }
//}

// MARK: 13.2、lineLimit添加行数限制
/*
 添加lineLimit()修饰符来控制最大几行,一旦TextField超出限制，将切换到滚动模式。
 */

//struct ContentView: View {
//    @State private var bio = "Ablout me"
//    var body: some View {
//        TextField("Describe yourself", text: $bio, axis: .vertical)
//            .textFieldStyle(.roundedBorder)
//            .lineLimit(3)
//    }
//}

// MARK: 13.3、lineLimit(2...5)
/*
 lineLimit(2...5),最少2行，最多5行
 */

//struct ContentView: View {
//    @State private var bio = "Ablout me"
//    var body: some View {
//        TextField("Describe yourself", text: $bio, axis: .vertical)
//            .textFieldStyle(.roundedBorder)
//            .lineLimit(2...5)
//    }
//}

// MARK: 13.4、reservesSpace
/*
 添加reservesSpace参数，lineLimit()是TextField可以自动分配空间
 */

//struct ContentView: View {
//    @State private var bio4 = "About me"
//    var body: some View {
//        TextField("Describe yourself", text: $bio4, axis: .vertical)
//            .textFieldStyle(.roundedBorder)
//            .lineLimit(5, reservesSpace: true)
//    }
//}

// MARK: -
// MARK: 14、onSubmit
/*
 SwiftUI有一个onSbumit()修饰符，可以附加到层次结构中的任何视图，并在用户完成TextField或SecureField中输入文本后运行你的action
 */

// MARK: 14.1、对于SecureField
/*
 密码输入之后，按确认键运行action
 */

//struct ContentView: View {
//    @State private var password = ""
//    var body: some View {
//        SecureField("Password", text: $password)
//            .onSubmit {
//                print("Authenticating.....")
//            }
//    }
//}

// MARK: 14.2、对于Form
/*
 对于Form表单中所有的值进行check，这样使填写表单更加方便
 */

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    var body: some View {
        Form {
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
        }
        .frame(height: 200)
        .onSubmit {
            guard username.isEmpty == false && password.isEmpty == false else { return }
            print("Authenticating")
        }

    }
}
