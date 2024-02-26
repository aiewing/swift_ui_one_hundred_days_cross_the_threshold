//
//  ContentView.swift
//  006-BaseUI2
//
//  Created by 舒毅文 on 2024/2/23.
//

import SwiftUI
import MapKit

#Preview {
    ContentView()
}

// MARK: -
// MARK: 1、TextField的numbers

// MARK: 1.1、.number

//struct ContentView: View {
//    @State private var score = 0
//    var body: some View {
//        VStack(alignment: .leading, content: {
//            TextField("Enter you score", value: $score, format: .number)
//                .textFieldStyle(.roundedBorder)
//            
//            Text("Your score was \(score)")
//        })
//    }
//}

// MARK: 1.2、NumberFormatter

//struct ContentView: View {
//    @State private var score = 0
//    
//    let formatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        return formatter
//    }()
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            TextField("Enter your score", value: $score, formatter: formatter)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            Text("Your score was \(score)")
//        }
//        .padding()
//    }
//}

// MARK: -
// MARK: 2、SecureField
/*
 SwiftUI的SecureField的原理与TextField几乎相同，有保护隐私而屏蔽字符的功能。
 */

//struct ContentView: View {
//    @State private var password: String = ""
//    var body: some View {
//        VStack(alignment: .leading) {
//            SecureField("Enter a password", text: $password)
//            Text("Your entered: \(password)")
//        }
//        .padding()
//    }
//}

// MARK: -
// MARK: 3、toggle
/*
 SwiftUI的toggle可以在true和false状态之间切换，就像UISwitch在UIKit中一样。
 */

// MARK: 3.1、toggle基础式样

//struct ContentView: View {
//    // 定义一个@state属性包装的bool类型的值，用于存储切换的当前值，然后根据需要使用它来显示或隐藏操作。
//    @State private var showGreeting = true
//    var body: some View {
//        Toggle("show welcome message", isOn: $showGreeting)
//        if showGreeting {
//            Text("Hi, Aie")
//        }
//    }
//}

// MARK: 3.2、使用.toggleStyle自定义按钮颜色

//struct ContentView: View {
//    @State private var showGreeting = true
//    var body: some View {
//        Toggle("show welcome message", isOn: $showGreeting)
//            .toggleStyle(SwitchToggleStyle(tint: .red))
//    }
//}

// MARK: 3.3、使用.toggleStyle(.button)自定义整个文字颜色

//struct ContentView: View {
//    @State private var showGreeting = true
//    var body: some View {
//        Toggle("show welcome message", isOn: $showGreeting)
//            .toggleStyle(.button)
//            .tint(.blue)
//    }
//}

// MARK: 3.4、批量订阅
/*
 从iOS16开始，可以将Toggle绑定到bool数组，可以批量禁用或者开启。例如，订阅
 */

//struct ContentView: View {
//    struct EmailList: Identifiable {
//        var id: String
//        var isSubscribed = false
//    }
//    
//    @State var lists = [
//        EmailList(id: "111", isSubscribed: true),
//        EmailList(id: "222", isSubscribed: true),
//        EmailList(id: "333", isSubscribed: true)
//    ]
//    
//    var body: some View {
//        Form {
//            Section {
//                ForEach($lists) { $list in
//                    Toggle($list.id, isOn: $list.isSubscribed)
//                }
//            }
//            Section {
//                Toggle("Subscribe to all", sources: $lists, isOn: \.isSubscribed)
//            }
//        }
//    }
//}

// MARK: -
// MARK: 4、创建Slider并读取值
/*
 SwiftUI的Slider的原理与UISlider相似，你需要将其绑定到某处一边可以存储值。创建一个Slider需要的常规参数：

 value：绑定一个Double类型的数据
 in：slider的滑动范围
 Step：移动时值的变化量。
 */

//struct ContentView: View {
//    @State private var celsius = 50.0
//    var body: some View {
//        VStack(alignment: .leading) {
//            Slider(value: $celsius, in: -100...100)
//            Text("\(celsius, specifier: "%.1f") Celsius is \(celsius * 9 / 5 + 32, specifier: "%.1f") fahrenheit")
//        }
//        .padding()
//    }
//}

// MARK: -
// MARK: 5、创建Picker并读取值
/*
 SwiftUI的Picker将UIPickerView、UISegmentedControl合二为一，同时还适应其他OS上的样式。与大多数其他空间一样，你必须将picker附加到@State来跟踪picker的选择。例如，创建一个colors数组和一个整数来存储选择的颜色，然后将其与选择器和文本一起使用。
 */

//struct ContentView: View {
//    var colors = ["Red", "Green", "Blue", "Tartan"]
//    @State private var selectedColor = "Red"
//    var body: some View {
//        VStack {
//            Picker("Plaease choose a color", selection: $selectedColor) {
//                ForEach(colors, id: \.self) {
//                    Text($0)
//                }
//            }
//            
//            Text("Your selected: \(selectedColor)")
//        }
//    }
//}

// MARK: -
// MARK: 6、创建DatePicker并读取值
/*
 SwiftUI的DatePicker类似于UIDatePicker，并带有多种选项来控制其样式与工作方式，与所有存储值的空间一样，它需要绑定到应用程序中的某种状态。创建一个绑定到birthDate的datePicker，通过选择日期，然后显示设置的datePicker值
 */

// MARK: 6.1、基本样式

//struct ContentView: View {
//    @State private var birthDate = Date.now
//    
//    var body: some View {
//        VStack {
//            DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
//                Text("Select a date")
//            }
//            
//            Text("Date is \(birthDate.formatted(date: .long, time: .omitted))")
//        }
//        .padding()
//    }
//}

// MARK: 6.2、GraphicalDatePickerStyle
/*
 从iOS14开始，使用GraphicalDatePickerStyle获得更高级的日期选择
 */

//struct ContentView: View {
//    @State private var date = Date.now
//    var body: some View {
//        VStack {
//            Text("Enter your birthday")
//                .font(.largeTitle)
//            DatePicker("Enter your birthday", selection: $date)
//                .datePickerStyle(GraphicalDatePickerStyle())
//                .frame(maxHeight: 400)
//        }
//        .padding()
//    }
//}

// MARK: -
// MARK: 7、创建Segment并读取值
/*
 SwiftUI的Picker还可以用于创建UISegmentedControl一样的分段控件，尽管它需要帮到到某种状态，并且确保为每一个segment提供一个标记，以便可以识别，segment可以时文字或图片。
 */

// MARK: 7.1、基础样式
/*
 创建一个与favoriteColor状态属性一起使用的segment，并在下面添加一个Test，显示所选的值
 */

//struct ContentView: View {
//    @State private var favoriteColor = 0
//    var body: some View {
//        Picker("What is your favrite color?", selection: $favoriteColor) {
//            Text("Red").tag(0)
//            Text("Green").tag(1)
//            Text("Blue").tag(2)
//        }
//        .pickerStyle(.segmented)
//
//        Text("Value: \(favoriteColor)")
//    }
//}

// MARK: 7.2、通过遍历创建

//struct ContentView: View {
//    @State private var favoriteColorStr = "Red"
//    var colors = ["Red", "Green", "Blue"]
//    var body: some View {
//        Picker("What is your favrite color?", selection: $favoriteColorStr) {
//            ForEach(colors, id: \.self) {
//                Text($0)
//            }
//        }
//        .pickerStyle(.segmented)
//
//        Text("Value: \(favoriteColorStr)")
//    }
//}

// MARK: -
// MARK: 8、创建Stepper并读取值
/*
 SwiftUI的Stepper与UIStepper相同
 */

// MARK: 8.1、基础样式
/*
 创建一个setpper绑定到age，取值范围0-130
 */

//struct ContentView: View {
//    @State private var age = 18
//    var body: some View {
//        Stepper("Enter your age", value: $age, in: 0...130)
//        Text("Your age is \(age)")
//
//    }
//}

// MARK: 8.2、onIncrement自定义闭包

//struct ContentView: View {
//    @State private var age = 18
//    var body: some View {
//        Stepper("Enter your age") {
//            age += 1
//        } onDecrement: {
//            age -= 1
//        }
//
//        Text("Your age is \(age)")
//    }
//}

// MARK: -
// MARK: 9、TextEditor创建多行可编辑文本
/*
 SwiftUI的TextEditor用于处理多行滚动文本的视图。可以根据需要设置字体、更改颜色，甚至可以调整行距和行数
 */

//struct ContentView: View {
//    @State private var profileText = "Enter your bio"
//    var body: some View {
//        NavigationStack {
//            TextEditor(text: $profileText)
//                .foregroundStyle(.secondary)
//                .padding(.horizontal)
//                .navigationTitle("About you")
//        }
//    }
//}

// MARK: -
// MARK: 10、ColorPicker选择颜色

// MARK: 10.1、基础样式

//struct ContentView: View {
//    @State private var bgColor = Color.red
//    var body: some View {
//        VStack {
//            ColorPicker("Set the background color", selection: $bgColor)
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(bgColor)
//        .padding()
//    }
//}

// MARK: 10.2、禁用透明度选项
/*
 默认情况下，ColorPicker支持颜色选择中的不透明度，可以禁用
 */

//struct ContentView: View {
//    @State private var bgColor = Color.red
//    var body: some View {
//        VStack {
//            ColorPicker("Set the background color", selection: $bgColor, supportsOpacity: false)
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(bgColor)
//        .padding()
//    }
//}

// MARK: -
// MARK: 11、ProgressView显示任务进度

// MARK: 11.1、基础样式
/*
 创建一个正在下载的进度条
 */

//struct ContentView: View {
//    @State private var downloadAmount = 0.0
//    var body: some View {
//        VStack {
//            ProgressView("Downloading...", value: downloadAmount, total: 100)
//        }
//    }
//}

//struct ContentView: View {
//    @State private var downloadAmount = 0.0
//    var body: some View {
//        let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
//
//        ProgressView("Downloading...", value: downloadAmount, total: 100)
//            .onReceive(timer, perform: { _ in
//                if downloadAmount < 100 {
//                    downloadAmount += 2
//                }
//            })
//    }
//}

// MARK: -
// MARK: 12、ProgressView显示不确定的进度
/*
 ProgressView可以在不附加任何类型的绑定的情况下创建，这种情况下显示一个菊花，不带进度
 */

//struct ContentView: View {
//    var body: some View {
//        ProgressView("Downloading...")
//    }
//}

// MARK: -
// MARK: 13、Map
/*
 通过MKCoordinateRegion创建经纬度
 */

//struct ContentView: View {
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
//    var body: some View {
//        Map(coordinateRegion: $region)
//            .frame(width: 400, height: 300)
//    }
//}

// MARK: -
// MARK: 14、buttonRepeat
/*
 SwiftUI有一个专用的buttonRepeatBehavior()修饰符，跟随点击，每次点击都会被响应
 */

// MARK: 14.1、基础样式

//struct ContentView: View {
//    @State private var tapCount = 0
//    var body: some View {
//        Button("Tap Count: \(tapCount)") {
//            tapCount += 1
//        }
//        .buttonRepeatBehavior(.enabled)
//    }
//}

// MARK: 14.2、通过shift+return来反复触发我们的按钮

//struct ContentView: View {
//    @State private var tapCount = 0
//    var body: some View {
//        Button("Tap Count: \(tapCount)") {
//            tapCount += 1
//        }
//        .buttonRepeatBehavior(.enabled)
//        .keyboardShortcut(.return, modifiers: .shift)
//    }
//}

// MARK: 15、Map的大头针
/*
 swiftUI的Map可以在地图上标注注释，包括默认的标记和引脚，以及完全自定义的视图。

 1. 创建某种状态，以跟踪地图显示的坐标，使用MKCoordinateRegion跟踪地图的中心和缩放级别。
 2. 准备一系列位置用于你的注释
 3. 决定你希望它如何显示在你的地图上。你可以显示内置的MapPin和MapMaker注释，也可以使用自己的视图。

 无论你创建的什么位置数组，你的类型都必须符合Identifiable，以便SwiftUI了解如何唯一的识别每个项目。
 */

// 如果你拥有的只是CLLocationCoordinate2D数据，你可以通过向这样的扩展来直接使用他们。
//extension CLLocationCoordinate2D: Identifiable {
//    public var id: String {
//        "\(latitude)-\(longitude)"
//    }
//}
//
//struct ContentView: View {
//    
//
//    //它把所有的东西放在一起，这样你就可以看到各个首都城市的大头针
//    struct City: Identifiable {
//        let id = UUID()
//        let name: String
//        let coordinate: CLLocationCoordinate2D
//    }
//
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
//    let  annotations = [
//        City(name: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
//        City(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)),
//        City(name: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)),
//        City(name: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.89511, longitude: -77.036667))
//        
//    ]
//    
//    var body: some View {
//        Map(coordinateRegion: $region, annotationItems: annotations) {
//            MapPin(coordinate: $0.coordinate)
//        }
//        .frame(width: 400, height: 300)
//
//    }
//}

// MARK: -
// MARK: 16、Link

//struct ContentView: View {
//    var body: some View {
//        Link("BBlv的掘金主页", destination: URL(string: "https://juejin.cn/user/1196684132486568")!)
//
//        //由于它是一个文本链接，可以使用字体、颜色等修饰
//        Link("BBlv的掘金主页", destination: URL(string: "https://juejin.cn/user/1196684132486568")!)
//            .font(.title)
//            .foregroundStyle(.red)
//        //如果通过自定义视图，而不是文本
//        Link(destination: URL(string: "https://juejin.cn/user/1196684132486568")!, label: {
//            Image(systemName: "link.circle.fill")
//                .font(.largeTitle)
//        })
//
//        //在上下文环境中获取OpenUrl
////        Button("Visit Apple") {
////            openURL(URL(string: "https://juejin.cn/user/1196684132486568")!)
////        }
//    }
//}

// MARK: -
// MARK: 17、MultiDatePicker选择多个日期
/*
 SwiftUI的MultiDatePicker显示日历视图，用户能同时选择各种日期，无论是从任何可能的日期还是从你选择的日期范围
 */

//struct ContentView: View {
//    @Environment(\.calendar) var calendar
//    @State var dates: Set<DateComponents> = []
//    var body: some View {
//        List {
//            Section {
//                MultiDatePicker("Select your preferred dates", selection: $dates)
//            }
//            
//            Section {
//                //在环境中读取日历，并转换为数据
//                MultiDatePicker("Select your preferred dates", selection: $dates)
//                Text(summary)
//            }
//            
//            Section {
//                //添加选取时间限制，在今天开始往后的时间
//                MultiDatePicker("Select your preferred dates", selection: $dates, in: Date.now...)
//                Text(summary)
//            }
//        }
//
//        var summary: String {
//            dates.compactMap { components in
//                calendar.date(from: components)?.formatted(date:.long, time:.omitted)
//            }.formatted()
//        }
//    }
//}

// MARK: -
// MARK: 18、LabelsHidden()隐藏Picker、Stepper、Toggle等标签
/*
 SwiftUI要求我们在其控件中添加标签，通常想要隐藏这些标签，以便你可以获得更精确的UI布局。
 */

//struct ContentView: View {
//    @State private var selectedNumber = 0
//    var body: some View {
//        Picker("Select a number", selection: $selectedNumber) {
//            ForEach(0..<10) {
//                Text("\($0)")
//            }
//        }
//        .labelsHidden()
//    }
//}
