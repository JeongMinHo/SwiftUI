# Chapter 5 



- Apple은 SwiftUI를 모든 디바이스에서 사용할 수 있는 가장 빠른 방법이라고 합니다.
- 사람들은 다른 상황에서, 목적, 그리고 사용시간을 가지고 각각의 디바이스를 사용합니다. 예를들어 애플워치를 항상 차고는 있지만 잠깐 동안만 보고는 합니다. 또는 아이폰과 가장 긴 시간동안 상호작용하지만 iPad나 Mac 만큼 많은 시간을 사용하지 않기도 합니다. 
- Mac이나 iPad에서의 인터렉션은 훨씬 복잡하기 때문에 이러한 플랫폼들에는 더 디테일하게 작업해야 합니다.



- Watch app의 ContentView는 iOS app과 동일합니다 다만 *Slider* 는 - 와 + 버튼으로 실행되며 이 버튼을 통해 카운트를 올리거나 내려야 합니다.



<img width="255" alt="스크린샷 2020-10-20 오후 6 24 43" src="https://user-images.githubusercontent.com/48345308/96567246-87d96b00-1301-11eb-9ec2-c18b54349cfb.png">

- BullsEyeGame 모델 클래스를 두 앱이 공유하기 위해서는 **Target Membership** 을 사용해야 합니다.



### Creating a Swift package

- *Target Membership* 은 target들이 한 두개 일때는 적합하나 기능을 추가할 수록 번거로워 집니다.
- 그렇기 때문에 공유 파일들은 pacakge로 묶어 조직화 하는 것이 훨씬 낫습니다. 또한 package는 애플의 모든 생태계에서 공유하기에 훨씬 편리합니다.
- ![스크린샷 2020-10-20 오후 6 29 22](https://user-images.githubusercontent.com/48345308/96567804-2f569d80-1302-11eb-9ffd-fc6f72fc99b7.png)

- Package를 만들면 다음과 같은 Package.swift파일이 생성되며 Sources 와 Tests 그룹까지 생성되는 것을 볼 수 있습니다.



### Customizing your Game Package

![스크린샷 2020-10-20 오후 6 33 03](https://user-images.githubusercontent.com/48345308/96568253-b277f380-1302-11eb-930b-0d2d12ee09ff.png)

- Game 패키지는 BullsEyeGame 모델 클래스만을 필요로 하므로. 드래그 하도록 합니다.
- 이렇게 하게 되면 BullsEyeGame은 더이상 BullsEye 그룹이 아님으로 모든 것을 ***public*** 으로 선언해야 합니다.



### Versioning your Game package

- Package.swift 파일 안에는 어떻게 package를 빌드할지를 나타내주고 있습니다. 
- 이것은 버전에 대한 정보를 가지고 있지 않기 때문에, Xcode는 @avaliable를 통해 각각의 OS에서 가능한지를 나타내주는 것이 가능합니다.

```Swift
platforms: [.iOS(.v13), .macOS(.v10_15), .watchOS(.v6), .tvOS(.v13)]
```



```Swift
import Game
```

- Game 패키지 모듈을 앱에 import 함으로써 언제든지 사용하는 것이 가능합니다.
- Game 패키지를 가지고 있는 두 앱은 *BullsEyeGame.swift* 파일을 공유합니다. 



### Creating a GameView package

- 이번에는 BullsEyeGame.Swift와 ContentView.Swift와 함께 GameView package를 만들어 macOS 앱에서 사용할 수 있는 패키징 기술을 강화할 것입니다.

![스크린샷 2020-10-20 오후 8 11 57](https://user-images.githubusercontent.com/48345308/96578658-83687e80-1310-11eb-8399-08b1c678a365.png)

- 다음과 같이 새로운 패키지를 만듭니다.



![스크린샷 2020-10-20 오후 8 13 34](https://user-images.githubusercontent.com/48345308/96578794-bd398500-1310-11eb-922d-67db6332dc78.png)

- 그 이후 ContentView.swift 파일과 BullsEyeGame.swift 파일을 GameView 폴더안에 복사 붙여 넣기 합니다.



### Desigining for the strengths of each platform

- SwiftUI는 여러가지 플랫폼들에서 실행할 수 있는 강력한 개발 도구를 제공합니다.
- *Toggle, Piceker, Slider* 같은 제어들은 플랫폼마다 다르게 보여지지만 데이터에는 같은 관계를 가지고 있으므로 다른 플랫폼들에서도 쉽게 적용하는 것이 가능합니다.



#### 1. watchOS

- Watch는 정확한 정보를 신속하게 얻을 수 있는 좋은 디바이스입니다.
- 오랜 시간 차고 있으며 알람을 빨리 받을 수 있을 뿐만 아니라 빨리 대답하는 것이 가능합니다.
- 스크린이 매우 작으며 따라서 가장 중요하고 의미 있는 정보들만을 보여줘야 합니다.
- 그리고 중요한 정보들은 2번 혹은 3번 탭 안에서 얻는 것이 가능해야 합니다.



#### 2. macOS/iPadOs

- 사람들은 Mac이나 iPad를 오랜 시간 사용하는 경향이 있으며 더 노트를 적거나, 검색, 정렬 및 필터링 하는 섬세한 작업들을 합니다.
- Mac은 큰 스크린과 키보드를 가지고 있기 때문에 많은 사람은 키보드 단축키로 시간을 줄이는 것을 즐깁니다.
- Mac 사용자들은 여러 창을 여는데에 익숙해져있습니다.



#### 3. tvOS

- Apple TV는 꽤 큰 화면에서 실행되지만 사용자들은 훨씬 더 먼곳에서 보며 한 명 이상의 사용자가 볼 수 있습니다.
- 다른 티비들처럼 꽤 긴 시간을 보게 됩니다.
- Apple TV는 이미지나 영상의 경험을 하는 가장 좋은 방식이지만 텍스트를 읽거나 쓰는 것에는 적합하지 않습니다.
- TableView는 iOS와 tvOS의 디자인적인 차이를 보여주는 예시입니다.
  - iOS앱의 경우 TableView는 사용자가 보기 쉽게 뷰 계층에서 보통 top level일 것입니다. 그러나 tvOS 앱의 경우에는 사용자가 drill down할 때 탭이 사라져서 전체 화면을 경험할 수 있습니다.



### Improving the watchOS app

- iOS와는 다르게 watchOS 에서는 라벨의 텍스트가 너무 길거나 짧거나 합니다.

```Swift
VStack(spacing: -0.01) // spacing을 줘서 UI들을 크기에 맞춥니다.
```



### Extending the Mac Catalyst app

- Mac에서 Mac Catalyst 앱으로 iOS 앱을 실행하는 것은 쉽습니다. 

- 시작하기 위해서 iOS target의 **Sigining and Capabilities** 탭을 찾습니다.

- Bundle identifier의 orgainization identifier를 추가하고 Team을 선택합니다.

  ![스크린샷 2020-10-20 오후 9 27 38](https://user-images.githubusercontent.com/48345308/96585837-15758480-131b-11eb-9864-1397c2ce5a70.png)

![스크린샷 2020-10-20 오후 10 10 36](https://user-images.githubusercontent.com/48345308/96590524-16111980-1321-11eb-8c09-df29689e8101.png)

- 그 이후 General 탭으로 가서 Deployment Info의 Mac에 체크합니다.

<img width="471" alt="스크린샷 2020-10-20 오후 10 11 21" src="https://user-images.githubusercontent.com/48345308/96590621-33de7e80-1321-11eb-9554-b0d62a90f327.png">

- 그 이후 Enabled 버튼을 클릭합니다.
- 그리고 scheme을 Mac으로 전환한 후에 빌드하고 실행하면 성공적으로 빌드가 되는 것을 확인할 수 있습니다.



## Creating a MacOS BullsEye app

![스크린샷 2020-10-20 오후 6 14 39](https://user-images.githubusercontent.com/48345308/96699490-49a77e80-13c9-11eb-8952-c3cf631ff640.png)

- 위와 같이 MacOs 앱을 만들어 줍니다.
- ContentView.swift 파일은 필요하지 않기 때문에 삭제를 해도 됩니다.
- 만들었던 GameView 패키지를 Finder에서 찾아 드래그 해줍니다.

![스크린샷 2020-10-20 오후 6 21 40](https://user-images.githubusercontent.com/48345308/96700316-452f9580-13ca-11eb-9c62-e6e8b8606da8.png)

- 이렇게 한다면 이제 Mac에서도 빌드와 실행이 가능합니다!



### Creating a tvOS BullsEye app

- 마지막으로 tvOS에 대해서 알아보도록 하겠습니다. 
- tvOS의 경우에는 제한적인 뷰와 controls들만이 가능합니다. BullsEye app을 실행하게 된다면 Slider와 Stepper까지 없는 것을 알 수 있습니다.
- 이를 해결하기 위하여 파인더의 *Game* 패키지를 찾아 target page에 있는 libray에 링크를 걸어줍니다.

![스크린샷 2020-10-20 오후 6 25 25](https://user-images.githubusercontent.com/48345308/96700802-cd159f80-13ca-11eb-9199-8991b8b5c697.png)

```Swift
import Game
```

- 위와 같이 Game 모듈을 import 합니다.
- 이렇게 하게 되면 **No such module "Game"** 이라는 에러 메세지가 출력됩니다.
- 이를 해결하기 위해 ContentView 구초레를 수정하는 것이 필요합니다.

```Swift
struct ContentView: View {
  @ObservedObject var game = BullsEyeGame()
	@State var currentValue = 50.0 
  @State var valueString: String = "" 
  @State var showAlert = false
}
```

- 원래의 BullsEye 앱과 동이랗지만 우리는 TextField 때문에 valueString이라는 String 변수가 필요합니다.

```Swift
// body

var body: some View {
  VStack {
		Text("Guess the number:")
		TextField("1-100", text: $valueString, onEditingChanged: {
			_ in self.currentValue = Double(self.valueString) ?? 50.0
		})
			.frame(width: 150.0)
    HStack {
      Text("0")
      GeometryReader { geometry in
        ZStack {
          Rectangle()
					.frame(height: 8.0) 
          Rectangle()
					.frame(width: 8.0, height: 30.0) 
          .offset(x: geometry.size.width * (CGFloat(self.game.targetValue)/100.0 - 0.5), y: 0.0)
				} 
			}
      Text("100")
    }
		.padding(.horizontal) 
  	}
}
```

![스크린샷 2020-10-20 오후 6 30 32](https://user-images.githubusercontent.com/48345308/96701392-82e0ee00-13cb-11eb-815e-69e82cd2f03c.png)

- 수정하고 빌드한다면 위와 같이 실행되는 것을 알 수 있습니다.
- 앱이 시작할 때, **Keyboard connected** 메세지를 볼 수 있으며, Window 메뉴의 *Show Apple TV Remote(Shift-Command-R)* 을 통하여 리모트 컨트롤러로 제어를 하는 것도 가능합니다.