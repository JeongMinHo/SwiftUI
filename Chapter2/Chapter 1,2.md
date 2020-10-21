# Chapter 1: Introduction



- SwiftUI is an innovatice, exceptionally simple way to build user interfaces across all Apple platforms with the power of Swift
  - 애플에서는 SwiftUI를 Swift의 힘과 함께 애플의 모든 플랫폼에서 사용자 인터페이스를 구축하는 혁신적이고 예외적으로 간단한 방법이라고 설명하고 있습니다.
- 2019년에 소개된 SwiftUI는 산업에 새로운 변화를 이끄는 패러다임을 불러왔습니다.
- 수년간 개발자들은 상태 관리 문제들과 복잡한 코드들을 다루면서 반드시 필요한 프로그래밍 모델들을 사용해 왔습니다.
- 또한 걱정하지 않아도 됩니다. UIKit이나 AppKit을 이용하는 것을 즐겼다면, SwiftUI와 이러한 프레임워크들을 통합해서 사용하는 것이 가능합니다.



# Chapter 2: Getting Started



```Swift
window.rootViewController = UIHostingController(rootView: contentView)
```

- 위의 UIHostingController는 위의 몇 줄을 이용하여 ContentView 인스턴스를 생성하며 SwiftUI를 위한 view controller를 생성합니다.

- UIHostingController는 존재하는 앱과 SwiftUI를 합칠 수 있게 합니다. 앱이 시작할 때, ContentView.swift에 정의되어 있는 ContentView의 인스턴스를 window에 보여줍니다. 이것은 View 프로토콜을 준수하는 구조체입니다.

```Swift
struct ContentView: View {
  var body: some View {
    Text("Hello World")
  }
}
```

- 위의 코드가 SwiftUI에서 Text view를 포함하는 ContentView를 선언하는 방식이며 Hello World를 보여주게 됩니다.



### ContentView 미리보기

- ContentView 구조체 아래, ContentView_Previews는 ContentView의 인스턴스를 포함하는 view입니다.

```SwiftUI
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
```

- 여기는 미리보기에 대한 샘플 데이터를 지정하는 것이 가능하며 다른 스크린과 폰트 사이즈를 비교하는 것이 가능합니다.

![스크린샷 2020-10-19 오후 7 52 35](https://user-images.githubusercontent.com/48345308/96441543-a3cb0700-1244-11eb-99e1-76dccfac1543.png)

- 기본적으로 preview는 현재 활성화된 scheme을 사용합니다.



### Previewing in landscape

- static previews 프로퍼티안에 *previewLayout* 을 추가하여 ContentView()를 변경합니다.

```Swift
ContentView()
	.previewLayout(.fixed(width: 568, height: 320))
```



### Creating your UI

- SwiftUI 앱은 스토리보드나 view controller가 없고 ContentView.Swift가 이 역할을 대신하게 됩니다.
- 코드와 object-library를 드래그해서 UI를 생성하고 코드에서 직접 스토리보드를 실행하는 것이 가능합니다!
- ***모든것은 항상 동기화되어 있습니다.***
- SwiftUI is **declarative** 
  - UI가 어떻게 보이길 원하는지 선언해야 하며 SwiftUI는 우리의 선언한 작업들을 효율적으로 코드로 변환하게 됩니다.
  - 애플은 코드를 읽기 쉽게 유지하는데 필요한 만큼 많은 뷰를 만들 것을 권장합니다. (?) ->잭 많은 뷰가 생기면 복잡해지는 것이 아닌가?
  - 매개 변수화되어 재사용 가능한 뷰들은 권장 되어지며, 이것들은 함수로 코드를 추출하는 것과 같습니다.



### Some SwiftUI vocabulary

1. **Canvas and Minimap** : SwiftUI에서 최대 경험을 얻기 위해서는 Xcode 11과 macOS 10.15 이상이 필요합니다.  그래야만 *canvas* 에서 앱의 뷰들의 preview를 보는 것이 가능합니다. 또한 코드의 *minimap* 을 볼 수 있습니다. (Editor -> Hide Minimap)
2. **Modifiers** : UIKit 객체들의 속성이나 프로퍼티를 설정하는 대신에 배경색, 폰트, 패딩등과 같은 많은 것을 *modifier methods* 를 호출하여 해결할 수 있습니다.

3. **Container views** : 아마 HStack과 VStack과 같은 container views를 사용한다면 SwiftUI에서 앱의 UI를 생성하는 것이 꽤 쉽다는 것을 알 수 있습니다. 그외의 ZStack과 Group 같은 container views도 있습니다. 



### Updating the UI

- SwiftUI에서 " ***normal*** " 을 사용하여 변수와 상수를 사용할 수 있지만 값의 변화에 따라 UI가 업데이트 되어야 할 때는 변수에 **@State** 를 지정해야 합니다. 
- SwiftUI에서 @State 변수가 변경한다면 뷰는 모습을 비활성화하고 body를 재계산합니다.



### Bindings

- ***$*** 은 작은 상징치고는 굉장히 파워풀하고 쿨한 기능을 가지고 있습니다.
- 예를 들어 rGuess에서 이것은 읽기 전용의 그냥 값이라면 $rGuess는 읽기-쓰기 바인딩이 된다.
- 사용자가 슬라이더의 값을 변경하는 동안에 추측하는 색상을 업데이트 하기 위해서는 이것이 필요합니다!



### Extracting subviews

- 재사용하기 위해서 뷰는 어떠한 파라미터들이 필요하다.
- value 변수에서 *@State* 대신에 *@Binding* 을 사용하였다. 왜냐하면 ColorSlider 뷰는 이 데이터를 가지지 않고 부모 뷰로부터 초기 값을 받으며 값이 바뀌기 때문이다.



### Live Preview

![스크린샷 2020-10-19 오후 9 08 19](https://user-images.githubusercontent.com/48345308/96449033-383a6700-124f-11eb-896c-2846a4da2f85.png)





