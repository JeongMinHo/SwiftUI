# Chapter 9: State & Data Flow



- 이전 챕터에서는 대부분의 UI components를 이용해서 user interface를 구현하였습니다.
- 이번 챕터에서는 SwfitUI에서의 *state* 에 대해서 배워보도록 하겠습니다.



### MVC: The Mammoth View Controller

- UIKit과 AppKit을 사용했더면 **MVC(Model-View-Controller)**  의 개념은 익숙할 것입니다. 그리고 이것은 *Massive View Controller* 라고 불리기도 합니다.
- MVC에서 **View** 는 사용자 인터페이스 이며, **Model** 은 데이터, **Controller** 는 model과 view를 동기적으로 연결하는 역할을 합니다. 그러나 이때 이 연결은 자동으로 이루어지지 않습니다. 그렇기 때문에 model에 변화가 일어날때 가능한 경우 마다 view를 업데이트 하는 코드를 작성해야 합니다.
- 하지만 임의의 데이터 구조가 하나 또는 둘 이상의 데이터 구조로 이루어져 있다면 model과 view를 동기화 하는 것이 어려워집니다.
- *model 외에도 UI는 state에 의존합니다.*
- 예를 들어 component는 toggle이 off이면 hidden해야 되고, button은 text field가 비어 있다면 유효해서는 안됩니다.
- AppKit과 UIKit에서 구현되어진 MVC 패턴은 view와 controller가 별도로 구분된 엔티티가 아니기 때문에 다소 색다릅니다. 대신에 이것을 *View controller* 라고 불리는 하나의 엔티티로 합쳤습니다.



1. *massive view controller* 는 굉장히 문제가 있습니다.
2. UI와 model을 동기화하는 작업이 필요합니다.
3. state는 UI와 항상 동기화되지는 않습니다.
4. moel을 view에서 subview로 업데이트 할 수 있어야 하며 그 반대의 경우도 가능합니다.
5. 이 모든 것은 오류나 버그가 발생하기 쉽습니다.



### A functional user interface

- SwiftUI의 아름다운점은 user interface가 ***functional*** 하다는 것입니다.
- 상황을 어렵게 만들 수 있는 중간의 상태가 없으며 특정 조건에 따라 여러가지의 view가 보여줘야 할지 검사할 필요가 없으며, 상태 변화가 있을 때 사용자 인터페이스의 일부를 수동으로 refresh할 필요가 없어집니다!
- 또한 **[weak self]** 를 사용하여 클로저의 참조 순환을 피해야 한다는 부담에서 해방 되는 것이 가능합니다. 왜냐하면 View는 값 타입이고 capture는 참조가 아닌 복사본을 사용하여 이루어지기 때문입니다.
- *functional* 이기 때문에, 렌더링은 항상 동일한 입력에 의해 동일한 결과가 생성되며 입력을 변경하면 자동으로 update가 됩니다.
- SwiftUI는 많은 좋은 점이 있습니다.
  1. **Declaractive** : 사용자 인터페이스를 구현하는 것이 아닌 선언합니다.
  2. **Functional** : 같은 state에서 UI는 항상 같게 렌더링 됩니다. 다른 말로 UI는 state의 기능을 합니다.
  3. **Reactive** : state가 변경되었을 때, SwiftUI는 자동적으로 UI를 업데이트 합니다.



### State

- 지금까지 공부해오면서 이미 *@State* 어트리뷰트를 봤을 것이라고 생각합니다. 이제는 더 자세하게 알아볼 필요가 있습니다!

<img width="408" alt="스크린샷 2020-10-22 오전 10 10 47" src="https://user-images.githubusercontent.com/48345308/96806364-dd6f5e00-144e-11eb-9580-26eb17464b65.png">



- 위와 같이 ScoreView.swift 파일을 생성하였습니다. 그리고 이것을 ChallengeView.swift 파일 버튼에 추가한다면 아래와 같은 형태를 띄게 됩니다.

<img width="348" alt="스크린샷 2020-10-22 오전 10 12 32" src="https://user-images.githubusercontent.com/48345308/96806461-1b6c8200-144f-11eb-8f31-3f230f500f32.png">



![스크린샷 2020-10-22 오전 10 16 20](https://user-images.githubusercontent.com/48345308/96806649-a2b9f580-144f-11eb-8278-51b933abf134.png)

- 위와 같이 작성하면 오류가 발생하는 것을 알 수 있습니다. 이것은 왜냐하면 body안에 있는 프로퍼티들을 수정하여 view의 상태를 변경할 수 없기 때문입니다.



<img width="434" alt="스크린샷 2020-10-22 오전 10 24 16" src="https://user-images.githubusercontent.com/48345308/96807123-bfa2f880-1450-11eb-8970-0c4c50efa9fa.png">

- 그렇다면 위와 같이 numberOfAnswered를 구조체로 감싸고 이 구조체의 인스턴스를 새로운 프로퍼티로 추가하면 될까요?
- 그러나 이것을 컴파일 하려고 하면 다음과 같이 에러가 뜨는 것을 볼 수 있습니다. 왜냐하면 구조체는 값 타입이고 이것은 *view의 내부 상태를 변화하려고 시도하는 것이기 때문입니다.*



### Embedding the state into a class

- 위의 구조체를 클래스로 변경한다면 에러는 사라질 것입니다.
- 위와 같이 하고 App을 실행하면 numberOfAnswered의 프로퍼티 값은 변경되지만 view는 업데이트 되지 않는다는 것을 알 수 있습니다. 
- UIKit을 사용했을 때는 이것이 예상되는 일이었을 것입니다. model이 변화하였을때 사용자 인터페이스와 연관된 부분을 업데이트 하는 것은 개발자의 몫이었습니다.



### Wrap to class, embed to struct

- 구조체와 클래스를 제거하고 model에 따라 UI가 업데이트 되는 방법은 어떻게 해야 될까요?
- 위에서 말했듯이 구조체는 값 타입이기 때문에 작동하지 않았습니다. 값 타입을 수정하려면 mutability해야 하지만 *body* 는 구조체를 포함할 수 없습니다.
- mutating없이 업데이트 하기 위해서는 간단하게 *mutating property를 참조 타입으로 묶으면 됩니다.* (즉 클래스)

```Swift
class Box<T> {
	var wrappedValue: T
	init(initialValue value: T) {
		self.wrappedValue = value
	}
}
```

- 위와 같이 Box 클래스를 생성하였습니다. 이렇게 한다면 value 타입을(사실은 어떠한 타입도) 클래스 안에 wrap할 수 있습니다.

<img width="467" alt="스크린샷 2020-10-22 오전 10 35 49" src="https://user-images.githubusercontent.com/48345308/96807775-5d4af780-1452-11eb-892d-3e1655053e63.png">

- numberOfAnswered의 수정 없이 Box 안에 포함된 값들을 변경하는 것이 가능하기 때문에 이제 이것은 작동할 것입니다!
- 다른 인스턴스를 가리키는 경우에만 변경하지만 대신에 property가 가리키는 인스턴스를 업데이트 해야 합니다.



### The real State

- SwiftUI의 struct와 비슷하게 State를 대체해야 합니다.

<img width="741" alt="스크린샷 2020-10-22 오전 10 58 58" src="https://user-images.githubusercontent.com/48345308/96809322-989af580-1455-11eb-852a-5dc994dbabee.png">

- 우리는 위에서 Box라는 클래스를 사용하여 wrap했다면 이번에는 SwiftUI에 있는 State 구조체를 사용하도록 하겠습니다.
- 그리고 이 State 인스턴스의 value에 접근하고 싶다면 *wrappedValue* 프로퍼티의 값으로 접근해야 합니다.

```Swift
struct ScoreView: View {
	
	var numberOfQuestions = 5
	
	var _numberOfAnswered = State<Int>(initialValue: 0)
	
    var body: some View {
		
		Button(action: {
			self._numberOfAnswered.wrappedValue += 1
			print("Answered: \(self._numberOfAnswered)")
		}) {
			HStack {
				Text("\(self._numberOfAnswered.wrappedValue)/\(numberOfQuestions)")
					.font(.caption)
					.padding(4)
				Spacer()
			}
		}
    }
}
```

- *property wrapper* 타입은 SwifUI에 의해 관리되어지는 read and write할 수 있는 값을 말합니다.
- 이것은 위에서 작성하였던 Box와 비슷하지만 view가 이것을 모니터링 할 수 있는 추가적인 기능이 있습니다.
- *wrapped value* 가 바뀌면 SwiftUI는 그 값을 이용하여 view를 re-render 하게 됩니다.



- 그렇다면 **State<Value>** 와 **@State** 어트리뷰트의 **$ operator** 사이의 관계는 무엇일까요?

```Swift
var _numberOfAnswered = State<Int>(initialValue: 0)

@State var numberOfAnswered = 0
```

- **@State 어트리뷰트로 선언된 프로퍼티는 property wrapper입니다.** 컴파일러는 이름앞에 **_** 를 붙이고 **State<Int>** 타입으로 실제 구현을 하는 형식인 것을 알 수 있습니다.
- 결국 둘은 똑같이 실행됩니다.

- 이것을 통해서 view안의 property를 가지고 그리고 그것을 view body안에서 사용해야할 때 property의 값은 바뀔때 view는 영향을 받지 않습니다. 만약에 *@State* 어트리뷰트를 적용하여 state property로 property를 생성한다면 SwiftUI 덕분에 property의 변화에 따라 뷰는 반응하게 되고 그 프로퍼티의 참조들을 가지고 있는 view는 refresh 됩니다.



### Not everything is reactive

- 현재 numberOfQuestions 하는 reactive 하지 않습니다.그럼 이것도 @State로 선언하면 되는걸까요?
- numberOfAnswered는 view의 일생동안 값이 바뀌는 dynamic한 것입니다. 사실 사용자가 정답을 제공했을 때만 값이 증가합니다.
- 이에 반해 numberOfQuestions는 질문의 총 갯수를 나타내는 것이기 때문에 dynamic 하지 않습니다. 이 값은 바뀌지 않기 때문에 이것은 state로 만들 필요는 없습니다. 심지어 이것은 *var* 로 만들 필요는 없습니다. 

```Swift
let numberOfQuestions: Int
```



### Use binding for two-way reactions

- state 변수는 UI 업데이트를 트리거하는데 유용할 뿐만 아니라 값이 바뀌는 것을 update할 때도 유용합니다.



### How binding is (not) handled in UIKit

- UIKit/AppKit에서 textfield나 textview가 사용자에게 입력 받은 text를 보여주고 읽을 수 있게 하는데 text property를 사용합니다. 
- UIComponents들은 사용자가 입력하여 보여지는 데이터를 text property에 소유한다고 할 수 있습니다. 
- 값이 바뀔때 알 수 있기 위해서 우리는 delegate나 값이 바뀌는 이벤트가 발생할 때 생기는 notification을 subscribe 해야 합니다.
- 또한 사용자의 입력에 유효성을 체크하고 싶다면 text가 바뀔때마다 항상 호출되는 메소드를 사용하여야 합니다.



### Owning the reference, not the data

- SwiftUI는 위의 과정을 더 간단하게 수행합니다.
- 이것은 declaractive한 접근법을 사용하고 state 프로퍼티가 변경될 때 사용자 인터페이스를 자동으로 업데이트 하게 됩니다.
- ***SwiftUI에서 component들은 데이터를 소유하지 않습니다 대신에 데이터가 저장되어 있는 참조 값을 가지게 됩니다.***
- 어떤 component 가 모델을 참조하는지 알기 때문에 모델이 변경될 때 사용자 인터페이스의 어느 부분을 업데이트 해야되는지 파악하는 것이 가능합니다.
- 이것을 위해서 참조를 정교하게 다룰 수 있는 **binding** 을 사용합니다.



- **binding** 은 데이터를 저장하는 프로퍼티와 데이터의 변화에 따라 이를 보여주는 view 간의 two-way connection(양방향)입니다. 
- binding은 데이터를 직접 저장하는 대신에 *source of truth* 에 property를 연결합니다. 이전에도 component들은 데이터를 소유하지 않는 것이 아니라 어딘가에 저장되어 있는 데이터의 참조를 가진다고 말했습니다.

- 만약에 이름의 글자수가 3개 이상부터만 Text로 보여주고 싶다면 아래와 같이 작성하면 된다.

```Swift
if name.count > 3 {
  Text(name)
}
```



### Defining the single sourth of truth

- SwiftUI에 대해서 얘기하다 보면 이 용어에 대해서 많이 들었을 것입니다. 
- 데이터는 하나의 엔티티만이 소유해야 하며,다른 모든 엔티티들은 이것을 복사하는 것이 아닌 같은 데이터를 접근해야 한다는 것입니다.

- 값 타입으로 전달할 때는, 이것의 복사본을 전달하여 복사본의 liftetime에는 제한이 생깁니다. 이것은 원래의 값에는 영향을 끼치지 않습니다. 마찬가지로 원래의 데이터를 바꿔도 복사된 것에는 영향을 끼치진 않습니다.
- ***state를 바꿀 때 사용자 인터 페이스에 자동으로 작용되도록 하고 싶기 때문에 값 타입으로는 UI 상태를 처리하지 않으려고 합니다.***
- 데이터가 참조타입이라면, 데이터를 이동할때마다 실제로는 데이터의 참조를 전달하는 것입니다. 데이터의 접근하는 어느 곳에서도 변경된 데이터를 보는 것이 가능합니다.
- *@State* 로 표시된 프로퍼티는 사실 **State<Value>** 이며 value 타입입니다. 이것을 메소드로 전달할 때, 이것은 사실 복사값을 전달합니다.
- state 프로퍼티는 데이터를 소유해야 하기 때문에 data의 복사값을 전달하여 원래의 데이터와 복사 데이터는 달라집니다.
- SwiftUI에서 @State 프로퍼티를 복사함으로써 여러가지  *source of truth* 를 가지게 됩니다. 더 잘 이해하기 위해서는 이것은 여러개의 *source of untruth* 를 얻게 되는 것입니다. ! (중요)



- 답변한 질문에 대한 갯수를 추적하는 counter를 저장하기 위해 state 변수를 사용하였습니다.
- 동일한 데이터에 접근할 수 있도록 ScoreView에 *binding* 을 전달하였습니다.
- state 프로퍼티 또는 binding 프로퍼티를 통해 데이터를 변경할 때, 데이터를 참조하는 모든 사용자에게 변경 사항을 제공하였습니다.



### The art of observation

- 이제 source of truth를 가지는 데이터를 binding을 통해서 전달했으며 데이터에 따라 상태가 변화 됩니다.
- 여러 프로퍼티로 구현된 모델이 있으며 이를 상태 변수로 사용하려는 경우를 생각했을때 model을 구조체처럼 값 타입으로 구현하게 되면 작동하지만 효율성이 떨어지게 됩니다.
- 실제로 만약 구조체의 인스턴스가 있고 이것들의 프로퍼티가 변경된다면 사실 전체 인스턴스를 업데이트된 프로퍼티로 대체하는 것입니다. 즉 전체 인스턴스가 변경됩니다.
- model의 프로퍼티를 변경할 때, 우리는 그 프로퍼티를 참조하는 UI만 업데이트 하려고 합니다. 지금은 변경되었을 때, struct 인스턴스 전체가 그 주초에의 참조를 가지는 곳에서 refresh되어 업데이트 됩니다. 이것은 성능에 영향을 끼칠 수 있습니다.
- 이것은 구조체를 사용하는 것이 안좋다는 것이 아닌, 같은 모형에 관계없는 프로퍼티들을 넣는것을 피해야 한다는 것입니다.
- model을 참조 타입인 class로 구현한다면 이것은 작동하지 않습니다. 참조 타입의 프로퍼티라면 이것은 새 참조를 할당하는 경우에만 변경되기 때문입니다.
- 그러므로 우리의 모델은 다음과 같아야 합니다.
  1. 참조 타입이어야 합니다.
  2. UI 업데이트를 트리거해야 하는 property를 지정할 수 있습니다.
- 우리는 새로운 3가지의 타입이 필요합니다.
  1. class를 *observable* 하게 선언합니다. 이것은 *state* 프로퍼티들과 비슷하게 사용됩니다.
  2. class 프로퍼티를 *observable* 하게 선언합니다.
  3. Observable한 class 타입의 인스턴스를 프로퍼티로 선언해야 합니다. 이것은 observable한 클래스를 뷰에서 observed된 프로퍼티로 사용하는 것이 가능하게 합니다.



- class를 *observable* 하게 만들기 위하여 우리는 **ObservableObject** 를 준수하게 해야 합니다. 클래스는 **publisher** 가 됩니다. 
- 프로토콜은 자동으로 합쳐지는 하나의 *objectWillChange* 프로퍼티를 정의해야 합니다. (이것은 컴파일러가 하는 역할입니다.)



### Sharing in the environment

- challenge에서 정확한 답을 눌렀을때 이것에 대한 alert를 주어야 합니다.

- 현재는 ChallengesViewModel()을 2군데에서 만들어줬기 때문에 2개의 다른 인스턴스를 가지고 있어 하나가 변경될 때 다른 변화는 이루어지지 않는 것입니다.

- 이러한 작업의 경우 *singleton* 을 사용하는 전형적인 케이스 일 것입니다. 그러나, singleton pattern은 사용하기 좋은 패턴은 아닙니다. 이것은 불필요한 의존성을 만들게 되고 이를 위해 사용하면 의존성 주입 같은 다른 패턴을 사용하면 이를 피할 수 있습니다.

- SwiftUI는 이러한 방법을 제공합니다. 이것은 의존성 주입이 아닌 예를 들어 가방에 가지고 있다가 필요할 때마다 그것을 꺼내서 쓰는 방법과 비슷합니다.

- 가방은 **environment** 라고 불리며 객체는 **environment object** 라고 불립니다.

- 이 패턴은 가장 인기있는 SwiftUI의 2가지 방법에서 사용됩니다. (modifier와 attribute)

  1) *environmentObject(_:)* 를 사용하여 environment에 객체를 주입하는 것이 가능합니다.

  2) *@EnvironmentObject* 를 사용하여, environment에서 객체를 꺼내고오고 이것을 프로퍼티로 저장하는 것이 가능합니다.

- 한번 environment에 객체로 주입하고 나면, 이것은 view또는 그것의 subview에서도 접근이 가능하나 view의 parent나 상위 뷰에서는 접근할 수 없습니다.

- 지금은 rootView에 이것을 주입하기 위해 ***SceneDelegate*** 에서 작업을 할 것입니다.

```Swift
window.rootViewController = UIHostingController(
        rootView: StarterView()
					.environmentObject(userManager)
					.environmentObject(ChallengesViewModel())
)
```

- 위와 같이 *ChallengesViewModel* 의 인스턴스를 생성하여 이것을 *environment* 에 주입하고 있습니다. 
- 그에 따른 결과로 StarterView의 계층 구조에 있는 모든 view들은 이 인스턴스에 접근하는 것이 가능합니다,
- 이제 ChallengsViewModel의 인스턴스를 생성했던 것을 바꿔줘야 합니다. 

```Swift
@ObservedObject var challengesViewModel = ChallengesViewModel()

@EnvironmentObject var challengesViewModel: ChallengesViewModel
```

- 위와 같이 변경하여 이 프로퍼티는 view의 environment로 부터 가져오는 ChallengesViewModel 인스턴스임을 나타내주는 것이 가능합니다!
- 이제 더 이상 ChallengesViewModel은 이미 존재하는 인스턴스이기 때문에 초기화하지 않아도 됩니다!

<img width="300" alt="스크린샷 2020-10-22 오후 3 06 09" src="https://user-images.githubusercontent.com/48345308/96831484-1ff96080-1478-11eb-9ab6-9071ab6e6b43.png"><img width="300" alt="스크린샷 2020-10-22 오후 3 06 38" src="https://user-images.githubusercontent.com/48345308/96831518-31426d00-1478-11eb-84e9-68727e734f82.png"> 

- 이제 이와 같이 정답을 바꾸면 자동으로 다음 challenge로 넘어가는 것을 확인할 수 있습니다!
- 하지만 정답을 맞춘 개수에 대한 counter가 업데이트 되지 않으며 Play Again 버튼이 아직 동작하지 않으므로 이를 수정해야 합니다.



1. PlayButton 수정

```Swift
@EnvironmentObject var challengesViewModel: ChallengesViewModel
```

- 간단하게 observed object가 아닌 *@EnvironmentObject* 로 ChallengeViewModel 프로퍼티를 만들면 이는 해결됩니다.



2. 정답 갯수 counter Text

```Swift
// ScoreView.swift

@State var numberOfAnswered: Int = 0
```

- 현재 numberOfAnswered 프로퍼티는 *@State* 로 선언되어 있어 이것이 제대로 기능하기 위해서는 superview에 전달되어야 합니다.
- environment 부터 challenge view model에서 이것을 가져오고자 할 수 있지만 이는 불필요한 의존성을 만드는 것일 수도 있습니다.
- 이러한 간단한 view는 한 쌍의 숫자만 보여주면 되므로 최대한 간단하게 만드는 것이 좋습니다.
- Parent view가 매개변수로 전달할 수 있게 하기 위하여 우리는 이것을 *binding* 으로 바꿉니다.

```Swift
@Binding var numberOfAnswered: Int
```

- 마찬가지로 ScoreView를 사용하는 *ChallengeView* 에서도 이와 마찬가지로 합니다.

![스크린샷 2020-10-22 오후 3 34 44](https://user-images.githubusercontent.com/48345308/96833925-1eca3280-147c-11eb-9d42-51849004fb24.png)

- 이렇게 선언하면 numberOfAnswered의 경우에는 read-only 프로퍼티라 할당될 수 없다고 합니다. **Binding** 에서는 이렇게 immutable한 값들을 binding할 수 있는 ***constant()*** 전역 메소드를 가지고 있습니다.

<img width="281" alt="스크린샷 2020-10-22 오후 3 36 16" src="https://user-images.githubusercontent.com/48345308/96834073-56d17580-147c-11eb-8e8e-c52caeefd6c5.png">

- 다음과 같이 진행한다면 이제 정답을 맞추면 counter Text가 잘맞게 변경되는 것을 볼 수 있습니다!



### Understanding environment properties

- SwiftUI는 environment에 넣기 굉장히 유용하고 재미있는 것을 제공합니다. 
- SwiftUI는 자동으로 동일한 환경을 시스템 관리 환경 값으로 계산합니다.

https://developer.apple.com/documentation/swiftui/environmentvalues



- 예를 들어서, 어둡거나 밝은 것과 같은 색의 속성을 찾는 것이 가능합니다. 그리고 이것은 reactvie 하게 적용되어 값이 변경되면 이 프로퍼티가 사용된곳은 어디서라도 UI를 업데이트 합니다.
- 우리의 앱에서 이것이  landscape모드일때는 보기 안좋기 때문에 이것을 수정할 것입니다.

![스크린샷 2020-10-22 오후 3 43 41](https://user-images.githubusercontent.com/48345308/96834677-5edde500-147d-11eb-84e7-6cde582ad8a9.png)

- 이것을 보기 좋게 만들기 위하여 우리는 device orientation의 변화를 감지하고 그거에 맞게 변화할 수 있게 해야 합니다.
- property 값의 변경 사항을 읽고 이것의 변화를 subscribe 하려면 우리는 새로운 *@Environment* attribute 사용하여 property key를 원하는 곳에 전달할 수 있습니다.

```Swift
@Envrionment(\.verticalSizeClass) var verticalSizeClass
```

- 프로퍼티에는 어떠한 이름을 붙이는 것도 가능하지만 혼란을 피하기 위해서 key 경로에 명시된 원래 이름을 명시하는 것이 좋습니다. 타입을 따로 지정할 필요는 없습니다.
- ***@ViewBuilder*** 가 필요합니다. 왜냐하면 body는 여러 view들을 return할 가능성이 있기 때문입니다.

```Swift
@ViewBuilder
	var body: some View {
		
		if verticalSizeClass == .compact {
			VStack {
				HStack {
					Button(action: {
							self.showAnswers = !self.showAnswers }) {
						QuestionView(
							question: challengeTest.challenge.question)
					}
					if showAnswers {
						Divider()
						ChoicesView(challengeTest: challengeTest)
					}
				}
				ScoreView(
					numberOfQuestions: 5,
					numberOfAnswered: $numberOfAnswered
				)
			}
		} else {
	
			VStack {
				Button(action: {
						self.showAnswers = !self.showAnswers }) {
					QuestionView(
						question: challengeTest.challenge.question) .frame(height: 300)
				}
				ScoreView(
					numberOfQuestions: 5,
					numberOfAnswered: $numberOfAnswered
				)
				if showAnswers {
					Divider()
					ChoicesView(challengeTest: challengeTest)
						.frame(height: 300)
						.padding() }
			}
			
		}
```

- 이런식으로 *verticalSizeClass* 를 기준으로 하여 compact일때와 아닐 때 뷰의 위치를 다르게 설정하는 것도 가능합니다.
- 그 결과 landscape 모드일 때 아래와 같은 형태를 띄게 됩니다!

<img width="600" alt="스크린샷 2020-10-22 오후 3 57 37" src="https://user-images.githubusercontent.com/48345308/96835990-51295f00-147f-11eb-8222-86a043e9281a.png">

- 계층의 어느 수준에서나 *.environment(_:_:)* modifier를 통해서 모든 environment property에 수동으로 다른 값을 할당 받을 수도 있습니다.

// WelcomeView.swift

![스크린샷 2020-10-22 오후 4 03 39](https://user-images.githubusercontent.com/48345308/96836592-28559980-1480-11eb-8b66-a216accfbe1a.png)

- 위에서 다음과 같이 vertical size class의 .compact로 값을 세팅한다면 아래와 같은 형태를 띄게 될 것입니다.

<img width="300" alt="스크린샷 2020-10-22 오후 4 04 53" src="https://user-images.githubusercontent.com/48345308/96836710-5509b100-1480-11eb-9516-7617911a3244.png">



### Creating custom environment properties

- Environment 프로퍼티들은 굉장히 유용하며 다재다능하기 때문에 이것을 직접 만들 수 있다면 좋을 것입니다.
- custom한 environment property를 만드는 방법은 크게 2가지 단계가 있습니다.
  1. *EnvironmentKey* 를 준수하는 property 키로 사용할 struct 타입을 생성해야 합니다.
  2.  *EnvironmentValues* 의 확장에 Newly-computed 프로퍼티를 추가하여 새로 계산된 속성을 추가해야 합니다.

```Swift
struct QuestionPerSessionKey: EnvironmentKey {
	static var defaultValue: Int = 5
}
```

-  key는 *subscript operator* 로 사용됩니다.
- 이 프로퍼티에 할당된 default 값은 어디에서도 초기화 되지 않습니다.

<img width="433" alt="스크린샷 2020-10-22 오후 4 14 14" src="https://user-images.githubusercontent.com/48345308/96837589-a4041600-1481-11eb-97f2-02e6ef9d935f.png">

- EnvironmentValues를 확장해야 합니다.
- questionsPerSession computed property를 추가해야 합니다.
- property의 reading 및 writing에 접근하려면 QuestionPerSessionKey를 사용해야 합니다.



### Key points

- 우리는 선언하는 뷰에서 소유한 데이터로 사용할 때 @State 를 사용하여 프로퍼티를 생성합니다. 프로퍼티의 값이 바뀌면 이 프로퍼티를 사용하는 UI는 자동적으로 re-render 합니다.
- @Binding을 사용하면 @State와 비슷하지만 데이터는 어디에서든지 저장될 수 있습니다. State property나 상위 뷰의 observable objet 등에서도.
- *ObservedObject* 를 준수하는 클래스의 인스턴스로 **@ObservedObject** 프로퍼티를 생성할 수 있습니다. 클래스는 하나 또는 그 이상의 *@Published* 프로퍼티들을 정의할 수 있습니다. 이러한 변수들은 state 변수처럼 작용하지만 이것은 view가 아닌 class로 구현하는 것은 다르다.
- *observable object* 들을 주입하기 위한 가방으로 **@EnvironmentObject** 를 사용합니다. 우리는 뷰로부터 이것들을 꺼내와서 자손 뷰들에서 이것을 주입하는 것이 가능합니다.
- **@Environment** 는 *ColorScheme, locale*  같은 시스템 환경 값으로의 접근이 가능합니다. 우리는 environment property를 생성하는 것이 가능하며 이것은 반응성있고 binding을 모두 할 수 있는 장점이 있습니다.
- 우리는 또한 우리의 커스텀한 *environment* 프로퍼티를 생성해보았습니다.



https://developer.apple.com/documentation/swiftui/state-and-data-flow

https://jaredsinclair.com/2020/05/07/swiftui-cheat-sheet.html