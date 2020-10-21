# Chapter 6: Intro to Controls: Text & Image



- 이번 챕터에서는 UIKit 또는 AppKit에서도 사용 가능한 SwiftUI의 UI 컨트롤에 대해서 배울 것입니다.



### Getting Started

- 프로젝트 파일에서 SwiftUI View를 선택하고 WelcomeView.swift 파일을 생성하였습니다.



### Changing the root view

```Swift
// SceneDelegate 

// 현재 rootView는 EmptyView()로 설정되어 있습니다.
window.rootViewController = UIHostingController(
	rootView: EmptyView()
)

// 아래와 같이 rootView를 WelcomeView()로 바꾸는 것이 가능합니다.
window.rootViewController = UIHostingController(
	rootView: WelcomeView()
)
```



### WelcomeView!

- 현재 WelcomeView는 Text 컴포넌트와 바디 프로퍼티를 포함하는 구조체로 이루어져 있습니다.
- Preview provider의 이름은 WelcomeView_Previews 입니다.
- Xcode는 *assistant panel* 을 보여주며 필요할 떄 **Resume** 버튼을 클릭하면 preview를 활성화 또는 비활성화 하는 것이 가능합니다.



### Text

- 만약에 input field에 아무것도 보이지 않는다면 사용자는 그 안에 무엇이 있는지 알 수 없을것입니다. 그렇기 때문에 text는 굉장히 중요합니다. 
- text는 문맥을 제공하며 UIKit이나 AppKit에서 UILabel은 이와 비슷하게 사용됩니다.
- 지금까지 보았듯이, Text는 간단하게 호출되면 text를 보여줍니다.
- 이것의 가장 간단하고 흔한 방법은 단일 파라미터를 사용하여 initializer를 사용하는 것입니다.

```Swift
Text("Welcome to Kuchi")
```

![image](https://user-images.githubusercontent.com/48345308/96609846-ed474f00-1335-11eb-91eb-663b02024095.png)



### Modifiers

- 이제 Text를 스크린에 보여주는 것을 했으며 다음은 이것의 모습을 변경하는 것입니다.
- 사이즈, weight, color, italic등의 많은 옵션들이 있으며 이것을 통해 스크린에 text가 어떻게 보여질지를 변경하는 것이 가능합니다.
- Text 인스턴스가 보여지는 것을 바꾸기 위해 modifiers를 사용합니다.
- 그러나 그것을 넘어 일반적으로 어떠한 *view* 들도 modifier를 사용하는 것이 가능합니다.

```Swift
Text("Welcome to Kuchi")
	.font(.system(size: 30))
```

<img width="519" alt="스크린샷 2020-10-21 오전 12 52 16" src="https://user-images.githubusercontent.com/48345308/96611478-ace8d080-1337-11eb-94ea-a7189a1acb6f.png">

<img width="519" alt="스크린샷 2020-10-21 오전 12 52 43" src="https://user-images.githubusercontent.com/48345308/96611542-bd00b000-1337-11eb-86ec-aba55919c7ef.png">

- 각각의 modifier들을 사용하면 다음과 같이 변하는 것을 볼 수 있습니다!
- 마지막 두개의 *.lineLimit* 과 *.multilineTextAlignment* 는 변화가 없는 것처럼 느껴질 수 있지만 이는 lineLimit의 default 값은 nil이고 .multilineTextAlignment의 default 값은 leading 이기 때문입니다.
- 이 default 값은 후에 변경될 수 있기 때문에 선언하는 것이 좋습니다.
- *popup canvas inspector* 의 경우는 뷰 컴포넌트를 **Command-click** 하면 됩니다.

<img width="348" alt="스크린샷 2020-10-21 오전 12 59 39" src="https://user-images.githubusercontent.com/48345308/96612426-b3c41300-1338-11eb-9b74-567018484fce.png">

- Text는 간단한 컴포넌트이지만 많은 modifier들을 가지고 있습니다. 

- SwiftUI는 2가지 카테고리의 modifier를 요구합니다.

  1) View 프로토콜과 함꼐 모든 view에서 사용 가능한 modifier

  2) 특정 타입의 인스턴스에서만 사용 가능한 특정 타입의 modifier



<img width="463" alt="스크린샷 2020-10-21 오전 1 14 53" src="https://user-images.githubusercontent.com/48345308/96614220-d48d6800-133a-11eb-9a89-beed5f35636e.png"><img width="460" alt="스크린샷 2020-10-21 오전 1 15 14" src="https://user-images.githubusercontent.com/48345308/96614248-e111c080-133a-11eb-9c71-39e9f5efe28b.png">

- 애플 개발자 공식 문서 혹은 View 라이브러리에서 modifier들을 확인하는 것이 가능합니다!



#### Are modifiers efficient?

- 모든 modifier들은 새로운 뷰를 리턴하기 때문에 이러한 과정이 효과적인 방법인가에 대해서 궁금증을 가질 수 있습니다.
- SwiftUI는 modifier를 호출할때마다 새로운 view에 view를 포함시킵니다.
- 이것은 반복적인 과정으로서 view들의 stack을 만들어냅니다.
- 직관적으로 이것은 자원의 낭비처럼 보일 수 있습니다.
- 사실은 SwiftUI는 이 스택을 view의 실제 렌더링에 사용되는 효율적인 데이터 구조로 만들게 됩니다.(?)



### Order of modifiers

- modifier의 호출되는 순서는 중요합니다.

```Swift
// 1번쨰
Text("Welcome to Kuchi")
	.background(Color.red)
	.padding()

// 2번째
Text("Welcome to Kuchi")
	.padding()
	.background(Color.red)
```

<img width="353" alt="스크린샷 2020-10-21 오전 1 21 32" src="https://user-images.githubusercontent.com/48345308/96615041-c2f89000-133b-11eb-8788-6c7544bb5441.png">

- 위의 이미지와 같이 순서에 따라 다르게 보여지는 것을 알 수 있습니다.



### Image

- 이미지는 굉장히 중요합니다.
- 이번 section에서는 UI에 이미지를 어떻게 추가하는지 알아보겠습니다.

```Swift
struct WelcomeView: View {
    var body: some View {
        Image(systemName: "table")
    }
}
```

![스크린샷 2020-10-21 오전 1 31 15](https://user-images.githubusercontent.com/48345308/96616103-1fa87a80-133d-11eb-824d-cd4bc64fe509.png)

- 위와 같은 코드를 작성하면 작은 테이블 이미지가 보이는 것을 확인할 수 있습니다.



### Changing the image size

- 어떠한 modifier도 없이 image를 생성했을때, SwiftUI는 기본 해상도로 렌더링을 하고 가로 세로 비율을 유지합니다.
- 위의 이미지의 경우에는 **SF Symbols** 에서 가져온 것이며 2019년에 Apple에 의해서 소개된 것입니다.
- 만약에 image의 사이즈를 변경하고 싶다면, 우리는 2개의 파라미터를 가지고 있는 **resizable** modifier를 적용해야 합니다.(*.tile and .stretch*)
- 만약 어떠한 파라미터도 제공하지 않는다면, SwiftUI는 4방향의 inset을 주지 않고 .stretch resizing mode가 될것입니다.

```Swift
var body: some View {
  Image(systemName: "table")
	.resizable()
	.frame(width: 30, height: 30) 
}
```

- *resizable* modifier를 사용해야만 크기에 맞게 이미지의 사이즈가 변경됩니다!

```Swift
var body: some View {
        Image(systemName: "table")
            .resizable()
            .frame(width: 80, height: 80)
            .cornerRadius(30 / 2)
            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            .background(Color(white: 0.9))
            .clipShape(Circle())
            .foregroundColor(.red)
}
```

<img width="516" alt="스크린샷 2020-10-21 오전 1 39 27" src="https://user-images.githubusercontent.com/48345308/96617179-431ff500-133e-11eb-8fac-5adbf572dfd9.png">

- 각각의 modifier의 호출에 따라 image가 어떻게 변경되는지 위의 이미지를 보시면 확인하실 수 있습니다!



### Brief overview of stack views

```Swift
struct WelcomeView: View {
    
    var body: some View {
        HStack {
            Image(systemName: "table")
            .resizable()
            .frame(width: 30, height: 30) .overlay(Circle().stroke(Color.gray, lineWidth: 1)) .background(Color(white: 0.9))
            .clipShape(Circle()) .foregroundColor(.red)
            Text("Welcome to Kuchi") .font(.system(size: 30))
            .bold()
            .foregroundColor(.red) .lineLimit(2) .multilineTextAlignment(.leading)
        }
    }
}
```

- 위와 같이 **HStack** 을 사용한다면 이미지와 Text를 Horizontal한 레이아웃으로 보는 것이 가능합니다.

![스크린샷 2020-10-21 오전 1 43 36](https://user-images.githubusercontent.com/48345308/96617660-d822ee00-133e-11eb-9853-6d94d7d341f2.png)



### More on Image

- image에는 **opacity, blur, constrast, brightness, hue, clipping, interpolation, aliasing** modifier들이 있습니다.
- 이러한 modifier들은 View 프로토콜에 정의되어 있으므로 image뿐만 아니라 다른 view에서도 사용이 가능합니다!

```Swift
Image("welcome-background", bundle: nil)
                .resizable()
                .scaledToFit()
                .aspectRatio(1, contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .saturation(0.5)
                .blur(radius: 5)
                .opacity(0.08)
```

<img width="500" alt="스크린샷 2020-10-21 오전 1 48 33" src="https://user-images.githubusercontent.com/48345308/96618156-8a5ab580-133f-11eb-8303-a41be34ffbf1.png">



### Splitting Text

```Swift
VStack {
  Text("Welcome to Kuchi")
	.font(.system(size: 30))
	.bold()
	.foregroundColor(.red) .lineLimit(2) .multilineTextAlignment(.leading)
}

VStack {
	Text("Welcome to") .font(.system(size: 30))
		.bold()
		.foregroundColor(.red) 
  	.lineLimit(2) 
  	.multilineTextAlignment(.leading)
		Text("Kuchi") .font(.system(size: 30))
		.bold()
		.foregroundColor(.red)
  	.lineLimit(2) 
  	.multilineTextAlignment(.leading)
}
```

- 위와 같이 하나의 text를 VStack으로 묶어 View를 분리하는 것이 가능합니다.

```Swift
VStack {
  	Text("Welcome to")
		.font(.system(size: 30))
		.bold() 
  	Text("Kuchi")
		.font(.system(size: 30))
		.bold() 
}
	.foregroundColor(.red)
	.lineLimit(2)
	.multilineTextAlignment(.leading)
```

- 또한 다음과 같이 subview에 하나 또는 그 이상의 modifier를 적용하는 것이 가능합니다!

```Swift
.font(.headline)
.font(.largeTitle)
```

- VStack안에 있는 font의 크기를 위와 같이 조절해서 두 text의 폰트 사이즈를 다르게 하는 것이 가능합니다.