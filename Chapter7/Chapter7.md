# Chapter 7: Controls & User Input



- Chapter 6에서는 가장 흔하게 사용되는 Text와 Image를 어떻게 사용하는지에 대해 배웠습니다.
- 이번 챕터에서는 흔하게 사용되는 TextField, Button, Stepper와 같은 control 들에 대해서 알아보도록 하겠습니다.



### A simple registration form

- 이번에는 사용자에게 이름을 입력 받는 간단한 상호작용 앱을 추가하도록 하겠습니다.



### A bit of refactoring

- 각각의 뷰의 코드의 양을 최소화하고 재사용하기 위해서 우리는 몇 가지 리펙토링을 거쳐야 합니다.
- 이 패턴은 애플에서 추천되어지는 자주 사용되는 방법입니다.
- 새로 작성할 registration view는 6장에서 만들었던 welcome view와 동일한 배경 이미지를 가집니다.
- welcome view를 복사하고 붙여넣기 할 수 있지만 이것은 재사용하거나 유지하기 어렵습니다.
- 이를 해결하기 위해 **WelcomeBackgroundImage.swift** 파일을 만들어줍니다.

```Swift
// WelcomeBackgroundImage.swift

struct WelcomeBackgroundImage: View {
    var body: some View {
        Image("welcome-background")
            .resizable()
            .aspectRatio(1 / 1, contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
            .saturation(0.5)
            .blur(radius: 5)
            .opacity(0.08)
    }
}
```

- 다음과 같은 형태를 띄는 image를 생성해줍니다!

```Swift
var body: some View {
    ZStack {
      WelcomeBackgroundImage()
      
      HStack {
        ...
```

- 그 이후 WelcomeView.swift 파일에서 위와 같이 WelcomeBackgroundImage() 로 view를 생성합니다!
- 만약에 동일한 welcome-background 이미지를 사용하는 배경뷰가 여러개 있다면 이를 위해서 똑같은 image를 여러번 생성해야 할 수도 있습니다. 이를 해결하기 위해 WelcomeBackgroundImage를 따로 빼내어 재사용성을 높이는 방법입니다!



#### Refactoring the logo image

```Swift
Image(systemName: "table")
          .resizable()
          .frame(width: 30, height: 30)
          .overlay(Circle().stroke(Color.gray, lineWidth: 1))
          .background(Color(white: 0.9))
          .clipShape(Circle())
          .foregroundColor(.red)
```

- 마찬 가지로 WelcomeView.swift 파일에 있는 위의 Logo image에 대한 코드를 LogoImage.swift 파일을 생성하여 빼내는 것도 가능합니다.

![스크린샷 2020-10-21 오전 2 33 09](https://user-images.githubusercontent.com/48345308/96623077-c4c75100-1345-11eb-909b-c9d95468a73f.png)

- 위와 같이 LogoImage를 빼준다면 WelcomeView.swift 파일에서는 아래와 같이 선언해도 같은 형태를 띄게 됩니다!

![스크린샷 2020-10-21 오전 2 34 54](https://user-images.githubusercontent.com/48345308/96623224-01934800-1346-11eb-8bda-34071fad25f1.png)



#### Refactoring the welcome message

![스크린샷 2020-10-21 오전 2 43 50](https://user-images.githubusercontent.com/48345308/96624104-4370be00-1347-11eb-8d1e-db4d312bbe0d.png)

- HStack을 command 우클릭하여 ***Extracted Subview*** 즉 subview로 추출하면 위와 같은 형태를 띄게 됩니다.
- 그리고 *ExtractedView* 는 파일의 아래로 이동하여 새로운 구조체로 선언됩니다.
- Xcode는 edit 모드에서 새로운 view의 이름을 바로 바꾸는 것이 가능합니다.
- 위에서 추출하였던 view도 WelcomeMessageView.swift 파일을 생성하여 해당 코드를 작성하도록 합니다.



### Creating the registration view

- 이번에는 RegisterView.swift 파일을 생성하여 body에 다음과 같이 선언합니다.

```Swift
VStack {
	WelcomeMessageView()
}
```

![스크린샷 2020-10-21 오전 2 54 35](https://user-images.githubusercontent.com/48345308/96625153-c21a2b00-1348-11eb-9ec2-6488e49d6a38.png)

- 위와 같이 선언한다면 preview는 다음과 같은 형태를 띄게 됩니다!
- 또한 이전에 리펙토링을 했었기 때문에 background view를 몇줄의 코드만으로도 추가하는 것이 가능합니다.

```Swift
struct RegisterView: View {
    var body: some View {
        ZStack {
          WelcomeBackgroundImage()
          VStack {
            WelcomeMessageView()
          }
        }
    }
}
```

![스크린샷 2020-10-21 오전 2 57 30](https://user-images.githubusercontent.com/48345308/96625435-2a690c80-1349-11eb-94e5-ef2504e7d018.png)

- 위의 코드만으로도 다음과 같은 view를 생성하는 것이 가능해집니다!
- 현재는 welcome view가 런치될 때 보여지게 됩니다. 이것을 바꾸기 위해서는 *SceneDelegate.swift* 에서 root view를 변경하는 작업을 해야합니다.

```Swift
if let windowScene = scene as? UIWindowScene {
     let window = UIWindow(windowScene: windowScene)
     window.rootViewController = UIHostingController(
       // rootView: WelcomeView()
       
       rootView: RegisterView()
     )
     self.window = window
     window.makeKeyAndVisible()
}
```

- 위와 같이 한다면 앞으로는 앱이 런치될 때 RegisterView()가 보여집니다!



### Power to the user: the TextField

- 리펙토링을 끝냈으니 이번에는 앱에서 사용자의 이름을 입력하는 방법에 대해서 알아보도록 하겠습니다.
- TextField는 일반적으로 키보드를 통해서 사용자가 데이터를 입력하는 것을 가능할 수 있게 해주는 control 입니다.
- 이전에 iOS 혹은 macOS 앱을 만들었다면 UITextField나 NSTextField 사용했을텐데 이와 비슷합니다.
- TextField는 간단하게 title과 text를 바인딩하는 initializer를 통해서 생성하는 것이 가능합니다.
- title은 textField가 비어있을 때 안에서 보여지는 *placeholder* 인 반면 바인딩은 textfield의 text와 이것의 프로퍼티 사이의 양방향(2-way connection) 연결을 관리하는 속성입니다.

```Swift
@State var name: String = ""
```

- @State 속성의 프로퍼티를 추가합니다.

![스크린샷 2020-10-21 오전 3 11 01](https://user-images.githubusercontent.com/48345308/96626910-0eff0100-134b-11eb-8ff4-38ccb1697667.png)

- 처음 TextField를 선언하기 위해서는 다음과 같은 형태를 구현해줘야 합니다.
- 이때 titleKey에는 placeholder로 들어갈 String 값을 입력해주면 되며 binding되는 프로퍼티를 뒤에 입력해주면 됩니다.
- 따라서 아래와 같이 구현하면 됩니다.

```Swift
TextField("Type your name...", text: $name)
```

- 위와 같이 TextField를 만들고 나면 wide가 너무 넓기 때문에 preview에서는 아무것도 보이지 않습니다. 
- <img width="284" alt="스크린샷 2020-10-21 오전 3 24 41" src="https://user-images.githubusercontent.com/48345308/96628266-f7287c80-134c-11eb-8b5e-479a6046c19c.png">
  - 왜냐하면 뒤에 있는 background image가 *.fill* content mode로 구현되어 있어 image는 가능한 부모 view의 많은 공간을 차지하도록 확장되기 때문입니다.
  - 이를 해결하기 위해서는 ZStack을 피하고 VStack의 *.background* modifier를 사용하여 콘텐츠 뒤에 background image를 배치해야 합니다.

![스크린샷 2020-10-21 오전 3 21 49](https://user-images.githubusercontent.com/48345308/96627967-91d48b80-134c-11eb-805d-75c740df51e5.png)

- <img width="158" alt="스크린샷 2020-10-21 오전 3 26 01" src="https://user-images.githubusercontent.com/48345308/96628400-263eee00-134d-11eb-8643-87d77ad90f0c.png">
- 위와 같이 선언하게 되면 background 조금 작아지게 됩니다. 왜냐하면 VStack의 경우는 전체 스크린을 사용하지 않고 컨텐츠를 render 하기 위해 필요한 것만 사용하기 때문입니다. 이를 해결하기 위해서는 2개의 **Spacer** 를 넣으면 됩니다. (Spacer는 모든 공간을 마음대로 사용할 수 있도록 확장할 수 있게 해줍니다. 자세한 내용은 다음 챕터에서 설명!)

![스크린샷 2020-10-21 오전 3 31 13](https://user-images.githubusercontent.com/48345308/96628954-e0cef080-134d-11eb-8f3f-b7adc5e3a4c9.png)

```Swift
var body: some View {
		VStack {
			Spacer()
            
			WelcomeMessageView()
			TextField("Type your name...", text: $name)
            
			Spacer()
      }.background(WelcomeBackgroundImage())
}
```

- 위와 같이 Spacer()를 아래 위로 넣으면 해결되는 것을 볼 수 있습니다.

- UIKit에서는 background color를 지정하는데 사용되는 backgroundColor 프로퍼티가 있습니다.
- SwiftUI는 이보다 다형적으로 .background modifier에서 Color, Image, Shape등을 사용 가능하며 이는 View를 준수하는 모든 타입에서 사용이 가능합니다!



### Styling the TextField

- 우리는 지금까지 TextField의 기본적인 것만 봤기 때문의 TextField의 스타일에 만족하지 못할수도 있습니다.
- TextField의 border를 적용하기 위해서는 *.textFieldStyle* modifier를 사용하는 것이 좋습니다.
- SwiftUI는 4가지의 다른 스타일을 제공하고 있습니다. 아래의 이미지를 봐주세요!

![스크린샷 2020-10-21 오전 9 30 00](https://user-images.githubusercontent.com/48345308/96658636-ffe67600-137f-11eb-88ca-5baf13712b82.png)

- **No Style** 의 경우 **DefaultTextFieldStyle** 과 동일 합니다.
- 또한 **DefaultTextFieldStyle**과  **PlainTextFieldStyle** 과의 차이점을 알아차리지 못할 수 있습니다. 하지만 **RoundedBorderTextFieldStyle** 의 경우 조금 둥글게된 border가 있는 것을 알 수 있습니다.
- 또한 **SquareBorderTextFieldStyle** 도 존재하지만 이것은 오직 macOS에서만 가능합니다.

- 우리의 TextField에 style을 제공하기 위해서는 3가지 옵션이 있습니다.
  1. TextField에 필요한 만큼 modifier를 적용하기.
  2. TextFieldStyle 프로토콜을 준수하여 정의된 나만의 TextField style 만들기.
  3. ViewModifier 프로토콜을 준수하여 정의된 custom한 ViewModifier 만들기.



#### 1. TextField에 필요한 만큼은 modifier를 적용하기.

```Swift
TextField("Type your name...", text: $name)
	.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
	.background(Color.white)
	.overlay(
		RoundedRectangle(cornerRadius: 8)
		.stroke(lineWidth: 2)
		.foregroundColor(Color.blue)
		)
.shadow(color: Color.gray.opacity(0.4), radius: 3, x: 60, y: 2)
```

![스크린샷 2020-10-21 오전 9 45 55](https://user-images.githubusercontent.com/48345308/96659565-391fe580-1382-11eb-8f47-db59d0514392.png)

- 현재 TextField는 왼쪽과 오른쪽에 spacing이 없습니다. 
- TextField와 parent view 사이에 padding을 넣기 위해서는 TextField를 포함하고 있는 view의 *padding modifier* 를 사용하면 됩니다.



#### 2. TextFieldStyle 프로토콜을 준수하여 정의된 나만의 TextField style 만들기

- custom한 TextField 스타일을 만들기 위해서는 TextFieldStyle을 채택해야 합니다.

```Swift
public func _body(configuration: TextField<Self._Label>) -> some View
```

- 이것은 TextField에 *configuration* 파라미터를 전달받고 원하는 modifier들을 적용시킨 후에 적용된 view를 리턴합니다.

```Swift
// RegisterView.swift에서 custom한 스타일을 만들겠습니다.

struct KuchiTextStyle: TextFieldStyle {
    public func _body(
        configuration: TextField<Self._Label>) -> some View {
        return configuration
    }
}
```

- 위의 코드만으로는 아무것도 할 수 없습니다. 왜냐하면 이것은 전달받은 TextField를 그대로 리턴하고 있기 때문입니다. 
- 커스터마이즈 하기 위해서는 modifier들을 추가해야 합니다.

<img width="569" alt="스크린샷 2020-10-21 오전 10 09 35" src="https://user-images.githubusercontent.com/48345308/96660806-881b4a00-1385-11eb-8e18-862950ae5f91.png">

- 위와 같이 modifier들을 추가하면 custom 하게 TextField 스타일을 만드는 것이 가능합니다.

```Swift
// TextField 스타일 적용하기

TextField("Type your name...", text: $name)
                .textFieldStyle(KuchiTextStyle())
```



#### 3. ViewModifier 프로토콜을 준수하여 정의된 custom한 ViewModifier 만들기

- custom한 TextField 스타일을 만드는 것보다 custom한 ViewModifier를 만드는 것을 더 선호하는 이유는 이렇게 만들면 button등에서도 적용이 가능하기 때문입니다.
- 이를 위해서 BorderedViewModifier라는 파일을 하나 생성합니다. ViewModifier를 만들기 위한 파일이기 때문에 BorderedViewModifier_Previews 구조체는 필요 없으며 *ViewModifier* 프로토콜을 준수하게 수정해야 합니다.
- *ViewModifier* 는 body를 프로퍼티로 정의하는 것이 아닌 modifier를 적용하기 위한 content로 가지게 됩니다. 그리고 modifier가 적용된 다른 view를 리턴하는 역할을 합니다.

```Swift
struct BorderedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
    }
}
```

```Swift
func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color.blue)
		)
		.shadow(color: Color.gray.opacity(0.4), radius: 3, x: 60, y: 2)
}
```

- 이렇게 하면 custom한 modifier가 완성됩니다!
- 이것을 적용하기 위해서는 이니셜라이저가 2개의 파라미터를 가진 ***ModifiedContent*** 라는 구조체를 사용해야 합니다. 

<img width="436" alt="스크린샷 2020-10-21 오전 10 28 52" src="https://user-images.githubusercontent.com/48345308/96661936-39bb7a80-1388-11eb-9e73-d7764dd2729e.png">

- 1번은 우리가 원래 생성했던 TextField이고 2번째가 바로 *ModifiedContent* 구조체를 사용해서 TextField를 만들고, 위에서 생성하였던 custom한 modifier인 BorderedViewModifier()를 적용한 방법입니다. 
  - 당연히 1번과 2번은 똑같은 TextField를 생성하게 됩니다!



- 이를 더 사용하기 쉽게 하는 방법은 extension을 사용하는 방법이 있습니다.

```Swift
// 다음과 같이 extension을 사용하면 bordered 메소드 만으로도 ModifiedContent를 일일이 만들지 않고 modifier를 적용하는 것이 가능합니다.

extension View {
    func bordered() -> some View {
        ModifiedContent(content: self, modifier: BorderedViewModifier())
    }
}

TextField("Type your name...", text: $name)
	.bordered()
```



### A peek at TextField's initializer

- TextField는 title 파라미터가 localized된 것과 localized가 되지 않은 두 쌍의 이니셜라이저가 있습니다.
- 이번 챕터에서는 non-localized를 사용하여 editable한 Text와 title을 가지는 것을 사용하였습니다.

```Swift
public init<S> (
  _ title: S,
  text: Binding<String>,
  onEditingChanged: @escaping (Bool) -> Void = { _ in },
  onCommit: @escaping() -> Void = {}
) where S: StringProtocol
```

- 위의 코드를 보시면 우리가 사용하지 않았던 2개의 파라미터가 있으며, default로는 아무것도 전달하지 않아도 됩니다.
- 이 2개의 파라미터는 사용자의 입력 전과 후에 처리하는 것이 가능한 클로저입니다.
  1. onEditingChanged
     - Boolean 파라미터가 true이면 호출되고 false이면 호출되지 않습니다.
  2. onCommit
     - 사용자가 return key를 누르는 것 같은 액션이 있을때 수행됩니다.
     - 이것은 다음으로 focus를 옮기고 싶을 때 자주 사용됩니다. (예를 들어서 return key를 누르고 나면 수행되는 액션을 정의.)



```Swift
public init<S, T> (
	_ title: S,
  value: Binding<T>,
  formatter: Formatter,
  onEditingChanged: @escaping (Bool) -> Void = {_ in},
  onCommit: @escaping() -> Void = {}
) where S: StringProtocol
```

- 2개의 차이점에 대해서 알아보면
  1. *formatter* (!)
     - Foundation의 추상 클래스인 Formatter의 인스턴스 파라미터입니다.
     - 이것은 예를 들어 숫자나, 날짜 같이 다른 타입의 값을 edit할 때 유용하게 사용할 수 있습니다.
     - ![스크린샷 2020-10-21 오전 10 55 01](https://user-images.githubusercontent.com/48345308/96663571-e1867780-138b-11eb-903e-0dbd8531e7ec.png)
  2. *T generic parameter*
     - TextField에서 처리하는 타입을 정의하는 역할을 합니다. 
     - 위에서는 String 타입의 Binding 값 만을 받을 수 있었다면 여기선 generic parameter를 통해 다른 타입의 값도 받아오는 것이 가능합니다.



### Showing the keyboard

- 사용자가 데이터를 입력할 수 있게 하기 위해서는 키보드를 보여줘야 합니다.
- TextField가 포커스를 획득하면 자동으로 키보드는 나타나지만, 키보드는 TextField를 가려서는 안됩니다.
- iPhone 8 시뮬레이터를 실행해 보면 키보드는 보이지만 이것은 TextField와 너무 가깝다는 것을 알 수 있습니다. (?????)
  - 제가 해봤을때는 TextField에서 키보드가 보일때 자동으로 올라가서 확인해 본 결과 iOS 14에서 TextField의 키보드에 따라 자동으로 올라가는 기능이 추가되었다는 것을 알게 되었습니다. (https://www.xspdf.com/resolution/58242249.html)

![스크린샷 2020-10-21 오전 11 12 43](https://user-images.githubusercontent.com/48345308/96664704-59ee3800-138e-11eb-83b0-53a4db07c10e.png) <img width="250" alt="스크린샷 2020-10-21 오전 11 13 03" src="https://user-images.githubusercontent.com/48345308/96664721-64103680-138e-11eb-8a5d-9e84563f1708.png">

- 프로젝트를 보면 **KeyboardFollower.swift** 라는 파일이 존재합니다.

```Swift
class KeyboardFollower : ObservableObject {
  @Published var keyboardHeight: CGFloat = 0
  @Published var isVisible = false
  
  init() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardVisibilityChanged), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
  
  @objc private func keyboardVisibilityChanged(_ notification: Notification) {
    guard let userInfo = notification.userInfo else { return }
    guard let keyboardEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
    
    isVisible = keyboardEndFrame.minY < UIScreen.main.bounds.height
    keyboardHeight = isVisible ? keyboardEndFrame.height : 0
  }
}

```

- 이것은 NotificationCenter를 사용하여 키보드의 높이에 대한 keyboardHeight 프로퍼티를 저장하고 있는*keyboardWillChangeFrameNotification* subscribe 하고 있습니다.
- 이 값은 키보드가 보이지 않을 때는 zero 였다가 키보드가 보여지면 값이 증가하게 됩니다.
- 키보드의 높이 변화에 따른 변경 사항을 subscribe하고 TextField를 포함하는 뷰의 bottom padding 값을 변경하는 것이 가능합니다!

```Swift
// RegisterView.swift

@ObservedObject var keyboardHandler: KeyboardFollower()
```

- 그 다음으로는 *keyboardHandler.keyboardHeight* 을 이용하여 bottom에 padding을 주는 modifier를 추가해야 합니다.

```Swift
TextField("Type your name...", text: $name)
                .bordered()
                .padding(.bottom, keyboardHandler.keyboardHeight)
```

- 위와 같이 bottom에 padding 값을 추가한다면 keyboard의 높이만큼 view가 올라가는 것을 확인하실 수 있습니다.

- 이를 통해서 SwiftUI는 다양한 조건에 따라서 dynamic하게 padding을 적용할 수 있습니다.

  1) keyboard가 보이지 않을 때는 *keyboardHandler.keyboardHeight* 의 값이 0이며 padding은 적용되지 않습니다.

  2) keyboard가 보이게 된다면 *keyboardHandler.keyboardHeight* 는 0보다 큰 값을 가질 것이며 키보드의 높이가 padding 값으로 적용되는 것입니다!

![스크린샷 2020-10-21 오전 11 44 34](https://user-images.githubusercontent.com/48345308/96666788-cc611700-1392-11eb-9d81-d29575a6f518.png)



- safe area때문에 keyboard는 맨 아래가 아닌 조금 위에서 시작하게 됩니다. padding을 정확하게 주기 위해서는 safe area 부터 올라오게 하는 것이 좋습니다.

```Swift
.edgesIgnoringSafeArea(keyboardHandler.isVisible ? .bottom : [])
```

- 위와 같은 메서드를 통해 keyboardHandler의 isVisible에 따라 safeArea를 무시할지 안할지를 정하는 것이 가능합니다!



### Taps and buttons

- 이제 form을 갖추었으니 사용자가 이 form을 제출하는 것을 만들어야 합니다.
- SwiftUI의 버튼은 UIKit 혹은 AppKit의 것보다 훨씬 유연합니다. button을 View로 사용하는 것이 가능합니다.

```Swift
struct Button<Label> where Label: View
```

- button의 비주얼 content는 제네릭 타입이며 이것은 View 프로토콜을 준수하고 있습니다. 이 의미는 button은 Text, Image 값은 컴포넌트들을 포함하는 것이 가능할 뿐만 아니라 vertical 혹은 horizontal 스택에 포함되어 있는 Text 혹은 Image의 쌍들을 포함하는 것도 가능합니다!



### Submitting the form

```Swift
Button(action: self.registerUser) {
	Text("OK") 
}

// MARK: - Evenet Handlers
extension RegisterView {
    func registerUser() {
        print("Button is Tapped")
    }
}
```

- 위와 같이 작성한다면 OK 버튼을 클릭하면 "Button is Tapped" 가 출력되는 것을 확인할 수 있습니다!
- 우리의 프로젝트는 사용자의 정보에 대해서 각각 저장 및 복원하는 UserManager 클래스가 있습니다.
- *UserManager* 는 클래스를 뷰에서 사용할 수 있도록 해주는 *ObservableObject* 프로토콜을 준수하고 있습니다. 이것은 인스턴스의 상태가 바뀔 때 뷰가 업데이트를 하게 합니다. 

```Swift
// UserManager.swift

@Published
var profile: Profile = Profile()
  
@Published
var settings: Settings = Settings()
```

- *profile* 과 *settings* 프로퍼티는 **@Published** 어트리뷰트로 선언되어 뷰가 reload될때 식별할 수 있게 해줍니다.

```Swift
@State var name: String = ""

@EnvironmentObject var userManager: UserManager
```

- 이제 RegisterView.swift 에서 *name* 프로퍼티를 지우고 *UserManager* 의 인스턴스로 대체하는 것이 가능합니다.

- **@EnvironmentObject** 어트리뷰트는 전체 앱에서 인스턴스를 한번 주입하고 이는 모든 환경에서 해당 인스턴스를 사용하는 것이 가능합니다. 저는 이것을 보면서 Singleton 같다고 생각이 들었습니다. 하지만 이것에 대해 조금 더 공부해보니 *@EnvironmentObject* 는 예를 들어 View A에서 View B, 그리고 View B에서 View C 등 데이터를 주고 받을 때 많이 사용된다고 합니다. 이렇게 한다면 화면에서 화면으로 전달하는 대신에 View A는 View C로 데이터를 전달하고 View C에서 이 데이터를 사용하는 것이 가능합니다. (이 부분은 Chapter 9에서 더 자세하게 설명한다고 합니다!)
- 따라서 아래와 같이 변경하는 것이 가능합니다.

```Swift
TextField("Type your name...", text: $userManager.profile.name)
                .bordered()
```



### Styling the button

- Button은 현재 잘 동작하지만 더 좋게 만들기 위해 라벨의 폰트등을 변경할 수 있습니다.

<img width="462" alt="스크린샷 2020-10-21 오후 2 15 22" src="https://user-images.githubusercontent.com/48345308/96676246-de00e980-13a7-11eb-8bd2-37d75f994337.png">

- 위와 같이 버튼 안에 HStack을 이용하여 이미지를 넣고 font의 스타일등을 변경하며 마지막으로 위에서 생성하였던 .bordered() 를 사용하여 버튼을 꾸미는 것이 가능합니다. 그 결과 아래와 같이 버튼이 변경되는 것을 확인할 수 있습니다!

<img width="230" alt="스크린샷 2020-10-21 오후 2 16 24" src="https://user-images.githubusercontent.com/48345308/96676314-025cc600-13a8-11eb-8229-b8bc6acb4539.png">



### Reacting to input: validation

- 이제 키보드를 사용할 수 있고 버튼을 사용하여 form을 제출할 수 있으니 이제 사용자가 입력하는동안 사용자의 input에 대해서 반응하는 방법에 대해서 알아보도록 하겠습니다.
- 이것은 입력하는 동안 데이터의 유효성을 체크할 수 있기 때문에 굉장히 유용합니다!
- 이전에 UIKit에서 이를위해 사용했던 방법은 delegate 혹은 Notification Center를 통해서 input의 입력값을 관찰하는 방법이었습니다.
- 아마 사용자가 키를 입력할 때마다 호출되는 modifier의 클로저는 input이 바뀔때마다 반응하므로 이와 비슷하게 느껴질 수 있습니다. 하지만 SwiftUI는 조금 다르게 이를 관찰합니다.
- input이 유효한 동안에는 **OK 버튼** 을 비활성화 하기 위해서 예전에는 *value changed* 액션을 subscribe하면서 버튼을 활성화 할지 비활성화 할지 결정해주어 버튼의 상태를 업데이트 했어야 합니다.
- 하지만 SwiftUI에서는 button의 modifier를 통해서 이를 해결하는 것이 가능합니다. 

```Swift
func isUserNameValid() -> Bool {
	return profile.name.count >= 3
}

.disabled(!userManager.isUserNameValid()) 
```

- 이렇게 button에 modifier를 설정하면 됩니다. modifier는 disabled state를 변경합니다. 
- 사용자가 TextField에 작성을 하면 *userManager.profile.name* 프로퍼티가 바뀌고, 이것은 뷰를 업데이트 하게 합니다. 따라서 버튼은 렌더링되고 각각의 input의 변화에 따라 버튼의 상태를 변경하는 것이 가능합니다!
- 따라서 아래와 같이 isUserNameValid()의 return 값에 따라 3개 이상이 되어야만 버튼이 활성화 됩니다.

![스크린샷 2020-10-21 오후 2 28 58](https://user-images.githubusercontent.com/48345308/96677065-c3c80b00-13a9-11eb-8b29-0a4957c7a3cd.png)



### Reacting to input: counting characters

- 만약에 현재 사용자에 의해 입력되어진 문자의 갯수를 보여주는 label을 추가하고 싶다면 이는 굉장히 간단합니다.

<img width="447" alt="스크린샷 2020-10-21 오후 2 33 29" src="https://user-images.githubusercontent.com/48345308/96677365-66808980-13aa-11eb-876f-29343ca797a3.png">

- 위와 같이 Text를 생성해주고 텍스트를 String Interpolation을 이용해서 입력된 글자수를 보여줍니다.
- 그리고 isUserNameValid 메서드를 활용하여 3이상이면 초록색 그보다 적으면 빨간색을 보여줍니다.

<img width="446" alt="스크린샷 2020-10-21 오후 2 35 14" src="https://user-images.githubusercontent.com/48345308/96677478-a5164400-13aa-11eb-9a2d-c3fc86860cfa.png">

- 그 결과 위와 같이 글자수에 따라 Textfield 우측 하단에 문자를 보여주는 Text가 추가된 것을 보실 수 있습니다!



### Toggle Controller

- toggle이란 Boolean 값으로 상태의 on, off를 제어하는 것을 말합니다.
- 우리는 웹사이트 같은 곳에서 내 아이디 저장과 같은 체크 박스를 통해 사용자의 이름을 저장할지 안할지에 대한 여부를 선택하는 것이 가능합니다! (보통은 아이디를 저장할지 안할지를 선택하고는 합니다.)

<img width="463" alt="스크린샷 2020-10-21 오후 2 40 36" src="https://user-images.githubusercontent.com/48345308/96677851-65039100-13ab-11eb-8399-fa3d97e2cb23.png">

```Swift
// Settings.swift

struct Settings : Codable {
  var rememberUser: Bool = false
}

settings에는 유저를 저장할지 안할지에 대한 bool 타입의 프로퍼티를 가진 구조체가 있습니다.
```



<img width="440" alt="스크린샷 2020-10-21 오후 2 42 32" src="https://user-images.githubusercontent.com/48345308/96677969-aa27c300-13ab-11eb-92a5-7d99f2f734dd.png">

- 다음과 같은 코드를 통해 ToggleI()을 생성하는 것이 가능합니다.

```Swift
extension RegisterView {
    func registerUser() {
        userManager.persistProfile()
        
        if userManager.settings.rememberUser {
            userManager.persistProfile()
        } else {
            userManager.clear()
        }
        
        userManager.persistSettings()
        userManager.setRegistered()
    }
}
```

- 다음과 같이 toggle의 state를 on 하면 앱이 런치 될때 userManager.settings.rememberUser 프로퍼티의 boolean 값을 체크하고 true라면 UserDefaults에 저장된 사용자의 이름을 불러오게 됩니다.



### Slider

- Slider는 사용자가 특정 범위 내에서 커서를 사용하여 숫자 값을 선택할 수 있을때에 많이 사용됩니다.

```swift
public init<V>(
	value: Binding<V>,
	in bounds: ClosedRange<V>,
	step: V.Stride = 1,
	onEditingChanged: @escaping (Bool) -> Void = { _ in }
) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint
```

- value는 바인딩하는 값을 의미하고
- bounds는 범위를 나타냅니다.
- step은 각각의 간격을 의미하며
- onEditingChanged는 edit을 시작하거나 끝날 때 호출할 수 있는 클로저입니다.

```Swift
@State var amount: Double = 0.0

VStack {
  HStack {
    Text("0")
    Slider(
    	value: $amount, in: 0.0 ... 10.0, step: 0.5
    )
    Text("10")
  }
  Text("\(amount)")
}
```

<img width="356" alt="스크린샷 2020-10-21 오후 2 53 25" src="https://user-images.githubusercontent.com/48345308/96678699-2f5fa780-13ad-11eb-8865-780a14c8b906.png">



### Stepper

- Stepper는 slider와 비슷한 대신에 cursor아닌 두개의 버튼을 제공합니다. 하나의 버튼은 값이 증가하며 하나는 값이 감소합니다.

```Swift
public init<S, V>(
	_ title: S,
	value: Binding<V>,
	in bounds: ClosedRange<V>,
	step: V.Stride = 1,
	onEditingChanged: @escaping (Bool) -> Void = { _ in }
) where S : StringProtocol, V : Strideable
```

- title은 현재 값을 포함한 title을 적어주는 부분입니다.
- value: 바인딩하는 값을 말합니다.
- bounds: 범위를 나타냅니다.
- step : 각각의 간격을 의미합니다.

```Swift
@State var quantity = 0.0

Stepper("Quantity: \(quantity)", value: $quantity, in: 0...10, step: 0.5)
```

<img width="352" alt="스크린샷 2020-10-21 오후 2 58 42" src="https://user-images.githubusercontent.com/48345308/96679062-ec520400-13ad-11eb-9208-2e03f146b374.png">



### SecureField

- SecureField는 TextField와 기능적으로는 동일하지만 사용자의 input 값을 숨기는 것이 가능합니다.
- 비밀번호와 같은 것은 민감하므로 SecureField를 사용하기 적절합니다.

```Swift
public init<S>(
	_ title: S,
	text: Binding<String>,
	onCommit: @escaping () -> Void = {}
) where S : StringProtocol
```

- title: 아무 input 값이 없을 때 보여지는 text인 placeholder 역할을 합니다. 
- text: 바인딩하는 String 값입니다.
- onCommit: return 키가 눌리는 것과 같은 사용자의 액션이 있을때 호출되는 클로저입니다.



```Swift
@State var password = ""

SecureField.init("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
```



<img width="371" alt="스크린샷 2020-10-21 오후 3 04 20" src="https://user-images.githubusercontent.com/48345308/96679487-b6614f80-13ae-11eb-997f-79fd4a9e8a92.png">



- https://developer.apple.com/videos/play/wwdc2019/216/

