# Chapter 3: Understanding SwiftUI



### Why SwiftUI?

- Interface Builder와 Storyboard는 사용자 인터페이스에 따른 레이아웃을 적용하기 쉽게 도와주어 빠르게 앱을 개발할 수 있게 해줍니다.
- 하지만 많은 개발자들은 코드로 작성했을 때 UI를 효율적으로 복사하거나 편집하는 것이 가능하기 때문에 view들을 코드로 작성하는 것을 선호합니다.
- SwiftUI를 사용한다면 Interface Builder나 storyboard의 단계적인 UI를 배치하기 위한 세부적인 것을 작성할 필요가 없어집니다.
- SwiftUI View는 미리보기가 가능하며 항상 동기적으로 업데이트가 되어 변화를 알 수 있습니다.
- SwiftUI는 Swift과 Objective-C 처럼 UIKit을 대체하는 것은 아니며 같은 앱에서 두 개를 동시에 사용할 수 있습니다.



### Declarative app development

- SwiftUI를 통해 **declarative** 하게 앱 개발을 하는 것이 가능합니다.
- **Declarative** 앱이란 UI에서 보여지기를 원하는 방법과 의존하는 데이터를 어떻게 보여줄지 선언한다는 것을 의미합니다.
- SwiftUI 프레임워크는 뷰가 보여져야 할 때나 의존하는 데이터가 변경될 때마다 뷰를 업데이트하는 것을 의미합니다.
- 뷰의 상태에 따라 어떻게 영향을 받으며 SwiftUI가 데이터에 따라 어떻게 변경되어야 할지를 나타내는 것을 선언하게 됩니다.



### SwfitUI vs. UIKit

- UIKit으로 앱을 만들기 위해서는 몇 개의 라벨들, 버튼, 3개의 슬라이더를 스토리보드에 배치해야되며, 각각 outlet과 action들로 view controller에서 연결하여 액션들과 값의 변경에 따라 UI를 동기화 하는 작업을 해야 합니다.

- SwiftUI를 이용하여 앱을 생성하면 나열된 색상, Text, Button, Slider들을 보여지는 순서에 맞게 subview로 리스트 합니다.(오토 레이아웃 제약 조건을 이용하는 것보다 훨씬 쉬우며) 앱 데이터의 변경에 따라 각각의 서브 뷰들이 어떻게 달라지는지 선언하면 됩니다.
- SwiftUI는 그들의 상태에 따라 일관되게 데이터 의존성을 유지하므로 UI 객체를 순서에 따라 업데이트 하는 것을 잊지 않아도 됩니다.



### Declaring views

- SwiftUI 뷰들은 UI의 한 부분으로 작은 뷰들을 큰 뷰들로 합치는 것이 가능합니다.

<img width="601" alt="스크린샷 2020-10-20 오전 1 31 09" src="https://user-images.githubusercontent.com/48345308/96479449-efe17000-1273-11eb-907b-4ee07c665ca5.png">

- 첫 번째 탭 리스트는 컨트롤, 레이아웃, paints 또는 다른 뷰들의 원시적인 뷰들의 리스트입니다.
- 두 번째 탭 리스트는 컨트롤, 효과, 레이아웃, 텍스트등과 같은 변화들을 나타내는 리스트입니다.
  - modifier는 존재하는 뷰에서 새로운 뷰를 생성하는 메소드를 의미합니다.



### Environment values

```Swift
// ContentView.swift의 ContentView_Previews

.background(Color(.systemBackground))
.environment(\.colorScheme, .dark)
```

- ContentView_Previews에서 위와 같이 하면 preview에서는 dark로 변경될지 모르지만 앱을 실행해보면 변하지 않은 것을 확인할 수 있다.

```Swift
// ContentView.swift

 NavigationView {
            VStack {
                HStack {
                    VStack {
                        Color(red: rTarget, green: gTarget, blue: bTarget)
                        Text("Match this color!")
                            .padding()
                    }
                    VStack {
                        Color(red: rGuess, green: gGuess, blue: bGuess)
                        Text("R: \(Int(rGuess * 255.0))"
                       + " G: \(Int(gGuess * 255.0))" + " B: \(Int(bGuess * 255.0))")
                            .padding()
                    }
                }
                Button(action: { self.showAlert = true }, label: {
                    Text("Hit Me!")
                })
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Your Score"), message: Text(String(computeScore())))
                })
                .padding()
                ColorSlider(value: $rGuess, textColor: .red)
                ColorSlider(value: $gGuess, textColor: .green)
                ColorSlider(value: $bGuess, textColor: .blue)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .colorScheme(.dark)
```

- 위와 같이 하면 앱을 실행하면 다크모드로 변경되게 된다.



### **Adding modifiers in the right order**

- SwiftUI는 사용자가 modifier를 적용하는 순서대로 추가되게 됩니다.
- 백그라운드 색을 추가하고 패딩을 생성하는 것과 패딩을 생성하고 백그라운드 색을 추가하는 것은 다르게 보입니다.



### Tools for data flow

- SwiftUI는 앱에서 데이터의 흐름을 관리하는 몇가지 도구들을 제공합니다.
- **Property wrappers**는 변수의 동작을 제어합니다. 

1. **@State** 변수는 view에 의해 소유됩니다. @State var는 영구적으로 저장소에 할당되므로 값을 반드시 초기화해줘야 합니다. 애플은 @State 변수가 구제적으로 소유되고 관리되는 것을 강조하기 위해서 private으로 선언하기를 조언합니다.
2. **@Binding** 변수는 다른 뷰가 소유한 @State 변수에 대한 종속성을 선언하며, $ 접두사를 사용하여 상태 변수에 바인딩을 다른 뷰에 전달하는 역할을 합니다. @Binding 변수는 데이터의 참조이며, 값을 초기화할 필요가 없습니다.
3. **ObservedObject** 는 ObservedObject 프로토콜을 준수하는 참조 타입에 종속성을 선언합니다. 데이터 변경 내용을 보여주기 위하여 objectWillChange 프로퍼티를 구현하게 됩니다.
4. **EnvironmentObject** 는 앱의 모든 뷰에서 보일 수 있는 공유 데이터에 대한 종속성을 선언하게 됩니다. 







