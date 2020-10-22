# Chapter 8: Introducing Stacks & Containers



- 이전 챕터에서는 SwiftUI의 control들에 대해 공부해보았다면 이번 챕터에서는 관련 있는 view들을 그룹화할 뿐 아니라 서로 배치하는 데 사용되는  **container views** 에 대해서 배울 것입니다.
- 시작하기에 앞서 view들의 사이즈는 정해지는지에 대해서 이해하는 것이 중요합니다.



### Layout and priorities

- UIKit과 AppKit에서는 AutoLayout을 이용해서 view들에게 제약을 주었습니다.
- 일반적인 규칙은 width나 height의 제약 조건들을 사용하여 size를 정적으로 설정하지 않는 이상, 보통 제약 조건을 추가함으로써 parent가 child의 크기를 결정하도록 하는 것입니다.
- family 모델과 비교하기 위해서 AutoLaout은 보수적인 모델입니다.
- SwiftUI는 반대로 작동하게 됩니다. children이 그들의 사이즈를 성하며 parent가 이것에 맞춰서 응답하게 됩니다. 이는 조금 더 현대적인 family 모델이라고 할 수 있습니다.

- View안에 text를 넣었다고 했을 때 Text는 parent의 frame 크기에 해당하는 적절하게 제안된 size가 주어집니다.
- 그러나 Text는 표시할 text의 크기를 계산하고 해당 text에 추가적인 padding이 있는 경우에는 그에 맞게 size를 계산합니다.



### Layout for views with a single child

```Swift
struct ChallengeView: View {
  var body: some View {
    Text("Hello World!")
  }
}
```

- 다음과 같이 Text만을 포함하고 있는 View가 있다고 합니다.
- 이때 Xcode에서 preview를 본다면 text는 스크린의 정중앙에서 보여지는 것을 알 수 있습니다.

<img width="237" alt="스크린샷 2020-10-21 오후 8 25 34" src="https://user-images.githubusercontent.com/48345308/96713454-95632380-13db-11eb-9b99-40e44fabd978.png">

- 모든 view들은 default로 parent의 중앙에 위치하게 되어 있습니다.
- 이때 Text에 background 색상을 준다면 렌덩링 하기 위해 Text를 포함하기 위해 크기가 최소인 것을 볼 수 있습니다.

<img width="503" alt="스크린샷 2020-10-21 오후 8 28 44" src="https://user-images.githubusercontent.com/48345308/96713740-073b6d00-13dc-11eb-89f2-ae31ad151a5b.png">

- SwiftUI는 parent view와 child view의 사이즈를 결정하기 위해 다음의 규칙을 따릅니다.
  1. parent view는 처리할 수 있는 가능한 frame을 결정할 수 있습니다.
  2. parent view는 child view에게 size를 제안합니다.
  3. parent로부터의 제안을 기반으로 하여 child view는 사이즈를 선택합니다.
  4. Parent view는 child view를 포함하도록 사이즈를 조절합니다.
- 이 과정들은 root view 부터 시작하여 마지막 leaf view까지 뷰 계층에서 반복적으로 일어납니다.

```Swift
Text("A great and warm welcome to Kuchi")
        .background(Color.red)
        .frame(width: 150, height: 50, alignment: .center)
        .background(Color.yellow)
```

- 위와 같이 Text를 수정한다면 흥미롭게도 .frame modifier에 의해 생성된 view의 사이즈와 Text의 사이즈가 다르다는 것을 알 수 있습니다.

<img width="258" alt="스크린샷 2020-10-21 오후 8 39 27" src="https://user-images.githubusercontent.com/48345308/96714723-85e4da00-13dd-11eb-8470-7131bba9f875.png">

1. frame view는 150x50 points로 사이즈가 고정되어 있습니다.
2. frame view는 Text에게 size를 제안합니다.
3. Text는 길이를 줄이지 않으면서 최소하게 그 size안에서 text를 보여줄 수 있는 방법을 찾습니다.



- Text는 자동으로 2줄로 배열되어 있습니다. 왜냐하면 150 point는 길이를 줄이지 않기 위해서는 한줄로는 텍스트를 보여줄 수 없기 때문입니다.

- 그러나 frame view는 고정된 프레임 크기(노란색 배경)을 사용하는 반면에 text는 render해야 하는 고정된 프레임 크기(빨간색 배경)을 차지하고 있습니다.

- 만약 parent view의 크기가 child view를 포함할 만큼 충분하게 크지 않다면 어떻게 될까요?

  - 그런 상황에서 Text는 text의 길이를 줄이게 됩니다.

  <img width="181" alt="스크린샷 2020-10-21 오후 8 49 38" src="https://media.oss.navercorp.com/user/20997/files/f0e2e080-13de-11eb-8f68-161b1ebc92a5">

- *.minimumScaleFactor* modifier 같은 다른 조건이 없을 경우에 필요하다면 0과 1사이의 값으로 파라미터로 전달된 scale factor에 의해 text는 줄어들 수 있습니다.

- 일반적으로 component는 parent에 의해 제안되어진 size에 맞는 content를 가지려고 노력합니다.

- 공간이 더 필요해서 이것을 할 수 없다면 coponent 타입에 적절하고 엄격한 규칙이 적용됩니다.



- 그러므로 parent가 child의 size를 강제하는 방법은 없다는 것을 깨달았습니다.
- Text와 같은 일부 component 들은 parent가 제안한 크기와 가장 잘 맞는 크기를 선택하려 하지만 render 해야할 text의 크기를 확인합니다.



### Layout for container views

- container view의 경우 하나 또는 2개 이상의 childview들을 포함하며 이들은 다음과 같은 규칙을 따릅니다.
  1. container view는 일반적으로 parent에 의해 제어된 크기로 이핸 frame을 결정합니다.
  2. container view는 가장 제한적인 제약조건 또는 동등학 제약조건의 경우에는 가장 작은 크기의 child view를 선택합니다.
  3. container view는 child view에게 크기를 제안합니다. ***제안되어진 크기는 이용한 크기를 남은 child view 수로 균등하게 나눈 것입니다.***
  4. child view는 parent에게 제안되어진 것을 기초로 하여 그것의 크기를 정합니다.
  5. Container view는 사용 가능한 frame에서 child view과 선택한 사이즈를 빼고 2단계로 다시 돌아갑니다.

<img width="1090" alt="스크린샷 2020-10-21 오후 9 12 20" src="https://media.oss.navercorp.com/user/20997/files/1e7d5900-13e2-11eb-950c-4fb56542c7cd">

![스크린샷 2020-10-21 오후 9 21 38](https://media.oss.navercorp.com/user/20997/files/6a7ccd80-13e3-11eb-9002-3d4dfffa1b67)





<img width="1127" alt="스크린샷 2020-10-21 오후 9 18 47" src="https://media.oss.navercorp.com/user/20997/files/035f1900-13e3-11eb-97db-65ef7ad2fa79">

![스크린샷 2020-10-21 오후 9 22 05](https://media.oss.navercorp.com/user/20997/files/79638000-13e3-11eb-9443-932da13391a3)

- 위와 다르게 아래에는 warm의 스펠링 중 m을 n으로 바꾸었습니다. 그렇게 되면 2개의 child view중에서 오른쪽의 view의 크기가 더 작아져서 먼저 선택되어지고 content를 보여줄 수 있는 가장 작은 크기의 view로 변경합니다. 그렇게 되면 남아있는 왼쪽의 뷰가 더 길어지게 되는 것입니다.



### Layout priority

- Container views는 가장 제한적인 제약 조건을 가진 정도에서 가장 적은 제약 조건을 가진 정도에 따라 정렬합니다.
- 제약 조건이 같을 경우에는 가장 작은 것이 우선순위가 됩니다.
- 그러나 이러한 순서를 바꾸고 싶은 경우가 있습니다. 이를 위해서는 2가지 방법이 존재합니다.
  1. view의 행동을 **modifier** 를 이용하여 바꿉니다.
  2. **layout priority** 로 바꿉니다.



#### Modifier

- modifier를 사용하여 view의 적응성을 높이거나 낮추는 것이 가능합니다.

  1) *Image* 는 가장 적은 적응성을 가진 component 중 하나입니다 왜냐하면 이것은 parent에 의해 제안되어진 크기를 무시하기 때문입니다. 그러나 parent가 어떠한 크기를 제안하더라도 **resizable modifier** 를 사용하면 이것을 무조건적으로 적용시킬 수 있습니다.

  2) *Text* 는 제안된 사이즈에 맞추기 위하여 text를 포맷하거나 wrap하려고 하기 때문에 가장 높은 적응성을 가지고 있습니다. 그러나 이것은 **lineLimit modifier** 에 의해 최대 line 수를 사용한다면 이를 강제하는 것이 가능합니다.



#### Priority

- **.layoutPriority modifier** 를 통하여 layout의 우선순위를 바꾸는 방법이 있습니다.
- 이것은 Double value를 가지며 양수 혹은 음수가 가능합니다.
- layout priority가 없는 view는 0의 priority를 가지는 것으로 추측되어집니다.

<img width="1046" alt="스크린샷 2020-10-21 오후 9 54 20" src="https://user-images.githubusercontent.com/48345308/96722119-fabd1180-13e7-11eb-8f5d-f239ec4e6ea3.png">

- **중요한 것은 Stack이 뷰를 최고에서 낮은 값으로 처리한다는 것입니다!**

<img width="1108" alt="스크린샷 2020-10-21 오후 9 56 41" src="https://user-images.githubusercontent.com/48345308/96722406-4ec7f600-13e8-11eb-835a-5e027ed1e4c1.png">

<img width="979" alt="스크린샷 2020-10-21 오후 9 58 07" src="https://user-images.githubusercontent.com/48345308/96722591-82a31b80-13e8-11eb-89d8-27ca2904dd30.png">

- priority의 값을 바꾸면 다음과 같이 처리하게 됩니다!



- 적응도를 바꾸는 두 가지 방법에는 아주 중요한 차이가 있습니다(!)
  - *layout priority를 수동으로 설정하는 것은 정렬 순서 뿐만 아니라 제안된 크기를 변경하게 됩니다.*
- 같은 priority를 가진 view들에서 parent view는 child view의 숫자와 같은 비율로 크기를 제안합니다.
  - 우선순위가 낮은 child view들의 최소 크기를 뺸 다음 가장 높은 우선순위를 가진 child view에게 그 크기를 제안합니다.



![스크린샷 2020-10-21 오후 10 04 34](https://user-images.githubusercontent.com/48345308/96723332-69e73580-13e9-11eb-82b3-df9d63fddd9b.png)

1. HStack은 낮은 우선순위를 가진 child view에게 요구 되어지는 최소 width를 계산합니다. 가장 왼쪽의 priority가 -1인 Text에게 이러한 일이 이루어지면 수직으로 text를 보여주는 가장 작은 width가 계산되어진 것입니다. 



![스크린샷 2020-10-21 오후 10 06 41](https://user-images.githubusercontent.com/48345308/96723602-b5014880-13e9-11eb-9016-91abd3ded2fa.png)

2. HStack은 높은 우선순위의 child view를 찾습니다. (중간에 있는 priority가 1인 Text)



![스크린샷 2020-10-21 오후 10 08 04](https://user-images.githubusercontent.com/48345308/96723731-e5e17d80-13e9-11eb-931d-b5e211cf2889.png)

3. HStack은 우선순위가 최대값보다 낮은 모든 child view에게 가장 최소의 width를 할당합니다. 최소 너비는 1단계에서 계산이 되었으며 낮은 우선순위를 가진 child view는 priority가 -1인 왼쪽의 text와 priority가 0인 오른쪽의 text 입니다.



![스크린샷 2020-10-21 오후 10 10 14](https://user-images.githubusercontent.com/48345308/96723962-33f68100-13ea-11eb-8f31-f76204138ec6.png)

4. 임의의 width로 보았을 때 우선순위가 낮은 child vivew에 대해 HStack은 최소 너비를 빼는데 이 경우 1단계에서 계산한 최소 너비의 2배가 됩니다.



![스크린샷 2020-10-21 오후 10 11 49](https://user-images.githubusercontent.com/48345308/96724102-6c965a80-13ea-11eb-8a0e-abc2a1fb68cc.png)

5. 가운데에 있는 Text는 text를 보여주기 위한 하나의 라인에 필요한 width를 결정합니다.





### The HStack and the VStack

- HStack과 VStack은 둘 다 container view이며 같은 방식을 행동합니다. 
- 둘의 차이는 HStack은 수평으로 subview를 배치하는 것이고 VStack은 수직으로 subview를 배치하는 것입니다.
- AppKit과 UIKit에는 *UIStackView* 라고 불리는 비슷한 component가 존재하며 subview가 어느 방향으로 배치될지를 결정하는 axis property가 있습니다.

```Swift
// HStack
init(
	alignment: VerticalAlignment = .center, 
  spacing: CGFloat? = nil,
	@ViewBuilder content: () -> Content
)
// VStack
init(
	alignment: HorizontalAlignment = .center, 
  spacing: CGFloat? = nil,
	@ViewBuilder content: () -> Content
)
```

- HStack과 VStack은 다음과 같은 이니셜라이저를 가지며 2개의 추가적인 parameter를 기본적으로 가지고 있습니다.
  1. **alignment**
     - HStack의 경우 vertical과 horizontally로 정렬하는 것이며 subview들을 어떻게 정렬할지를 결정합니다. 둘 다 default 값은 .center입니다.
  2. **spacing**
     - child view 사이의 거리입니다. 기본적으로 nil일 때 *platform-distance* 가 사용됩니다. 그러므로 zero를 원한다면 이것을 명시적으로 설정해줘야 합니다.
  3. **content**
     - child view를 생성하는 클로저입니다. 그러나 container들은 보통 하나 이상의 child를 리턴합니다.



#### A note on alignment

- VStack 정렬은 (*.center, .leading, .trailing*) 3가지의 값을 가지는 반면에 ***HStack은 조금 더 많은 값을 가집니다.***

  1) **firstTextBaseline** : 맨 위의 view를 기준으로 정렬

  2) **lastTextBaseline** : 맨 아래의 text 기준으로 view 정렬

![스크린샷 2020-10-22 오전 12 46 15](https://user-images.githubusercontent.com/48345308/96744439-ff8dbf80-13ff-11eb-9052-c417b4895b07.png)

- 위와 같이 한다면 HStack은 2개의 Text와 Button을 가지며 각각은 다른 font 크기를 가집니다.
- preview에서 볼 수 있듯이 이 3개의 child view는 수직 정렬입니다.

![스크린샷 2020-10-22 오전 12 48 03](https://user-images.githubusercontent.com/48345308/96744662-3fed3d80-1400-11eb-8cbb-d48a5f093dd1.png)

- 위와 같이 HStack의 정렬을 *.bottom* 으로 하면 bottom에 맞춰서 정렬되는 것을 볼 수 있습니다.



![스크린샷 2020-10-22 오전 12 49 30](https://user-images.githubusercontent.com/48345308/96744866-732fcc80-1400-11eb-981f-275d41dc7a69.png)

- 정렬을 *.firstTextBaseline* 으로 한다면 큰 text의 baseline에 맞춰서 첫 번째 Text와 button이 맞춰서 정렬되는 것을 볼 수 있습니다.



### The ZStack

- ZStack에서 child view는 선언된 위치에 따라 정렬되는데 이것은 첫 번째 subview가 stack의 하단에 렌더링 되고 마지막 subview가 맨 위에 있다는 것을 의미합니다.
- **흥미롭게도 subview에 적용되는 *.layoutPriority* 는 Z-order에 영향을 주지 않기 때문에 ZStack의 body에 정의된 순서는 바꾸는 것이 불가능합니다.**
- ZStack의 width와 height은 가장 넓은 view와 가장 높은 view에 의해 결정됩니다.



### Other container views

- 하나의 child view를 가지는 어떠한 view도 container가 되는 것이 가능합니다. 
- Stack view들은 복잡한 user interface들은 작성하는데 매우 유용적입니다. 하지만 작은 단위로 쪼개면 너무 복잡해질수 있습니다.



### The Congratulations View

![스크린샷 2020-10-22 오전 1 10 56](https://user-images.githubusercontent.com/48345308/96747623-737d9700-1403-11eb-9c59-9203546c3a6b.png)



- 이 view의 아래에는 view를 닫고 이전으로 돌아가는 버튼이 있어야 합니다.



![스크린샷 2020-10-22 오전 1 14 03](https://user-images.githubusercontent.com/48345308/96747944-e25af000-1403-11eb-9ea3-b5f476eaa132.png) ![스크린샷 2020-10-22 오전 1 14 40](https://user-images.githubusercontent.com/48345308/96748014-f7378380-1403-11eb-9a83-48f78bab2730.png)



#### User avatar

- 사용자의 아바타와 이름을 색칠된 background에 추가하되, 수직으로 2개로 나누어 지는 색상을 넣는 것은 어떨까?

<img width="457" alt="스크린샷 2020-10-22 오전 1 16 24" src="https://user-images.githubusercontent.com/48345308/96748221-3534a780-1404-11eb-8b35-547a111b8dcd.png">

- 아마 알아차렸을 수도 있지만 이것을 위해서는 *ZStack* 을 사용하는 것이 좋다.

```Swift
struct CongratulationsView: View {
  let avatarSize: CGFloat = 120
  let userName: String
    
    @ObservedObject var challengesViewModel = ChallengesViewModel()
  
  init(userName: String) {
    self.userName = userName
  }
  
  var body: some View {
    VStack {
      Spacer()

      Text("Congratulations!")
        .font(.title)
        .foregroundColor(.gray)
      
      ZStack {
        VStack(spacing: 0) {
          Rectangle()
            .frame(height: 90)
            .foregroundColor(Color(red: 0.5, green: 0, blue: 0).opacity(0.2))
          Rectangle()
            .frame(height: 90)
            .foregroundColor(Color(red: 0.6, green: 0.1, blue: 0.1).opacity(0.4))
        }
        
        Image(systemName: "person.fill")
          .resizable()
          .padding()
          .frame(width: avatarSize, height: avatarSize)
          .background(Color.white.opacity(0.5))
          .cornerRadius(avatarSize / 2, antialiased: true)
          .shadow(radius: 4)
        
        VStack() {
          Spacer()
          Text(userName)
            .font(.largeTitle)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .shadow(radius: 7)
        }.padding()
      }
      .frame(height: 180)
      
      Text("You're awesome!")
        .fontWeight(.bold)
        .foregroundColor(.gray)
      
      Button(action: {
        self.challengesViewModel.restart()
      }, label: {
        Text("Play Again")
      })
        .padding(.bottom)
    }
  }
}

```

<img width="300" alt="스크린샷 2020-10-22 오전 1 31 15" src="https://user-images.githubusercontent.com/48345308/96749841-48487700-1406-11eb-990e-a38240ea9868.png">

- 위와 같은 코드를 작성하여 다음과 같은 View를 만드는 것이 가능합니다.

- Play Again을 스크린의 bottom으로 정렬 시키는 것은 어떻게 할 수 있을까?

![스크린샷 2020-10-22 오전 1 34 27](https://user-images.githubusercontent.com/48345308/96750274-bb51ed80-1406-11eb-96ce-a720e69d5f05.png)

- Text와 Button 사이에 *Spacer()* 를 추가하여 이를 해결하는 것이 가능합니다.



### Completing the challenge view

- *challenge view* 는 질문을 보여주고 정답의 리스트를 보여주게 디자인 되어 있습니다.
- 정답을 보여주는 view의 경우에는 처음에 hidden 했다가 사용자가 스크린을 tap 하게 되면 나타나게 됩니다.



```Swift
// ChallengeView 

let challengeTest: ChallengeTest
@State var showAnswers = false

struct ChallengeView_Previews: PreviewProvider {
	static let challengeTest = ChallengeTest(challenge: Challenge(question: "􏰀􏰁􏰂􏰃 􏰅􏰆􏰇", pronunciation: "Onegai shimasu", answer: "Please"), answers: ["Thank you", "Hello", "Goodbye"])
    
  static var previews: some View {
    return ChallengeView(challengeTest: challengeTest)
  }
}
```



```Swift
struct ChallengeView: View {
    
    let challengeTest: ChallengeTest
    
    @State var showAnswers = false
    
  	var body: some View {
		VStack {
			Button(action: {
				self.showAnswers = !self.showAnswers
			}) {
				QuestionView(question: challengeTest.challenge.question)
				.frame(height: 300)
			}
		
			if showAnswers {
				Divider()
			
        ChoicesView(challengeTest: challengeTest)
				.frame(height: 300)
				.padding()
			}
		}
	}
}
```

- 위와 같이 코드를 작성하도록 합니다.
- QuestionView는 파일을 가지고 있으며 ChoicesView는 ShowAnswers의 값이 true일때만 보여지는 로직입니다.



### Reworking the App Launch

1. 앱이 시작할 때의 initial view를 변경해야 합니다.
2. WelcomeView로 수정합니다.



- 위의 작업은 *SceneDelegate* 에서 rootView를 변경하는 방식으로 작업해야 하는데 이것은 이전 챕터에서도 자주 했으니 참고하길 바랍니다.



```Swift
// StarterView.swift

struct StarterView: View {
  @EnvironmentObject var userViewModel: UserManager
  
  @ViewBuilder
  var body: some View {
    if self.userViewModel.isRegistered {
      WelcomeView()
    } else {
      RegisterView(keyboardHandler: KeyboardFollower())
    }
  }
}

struct StarterView_Previews: PreviewProvider {
  static var previews: some View {
    StarterView()
      .environmentObject(UserManager())
  }
}
```

- 위의 파일을 보면 user manager의 flag에 따라 어떤 view를 보여줄지를 결정하고 있습니다.