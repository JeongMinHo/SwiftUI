# Chpater 10: Gestures



- 앱을 개발할 때 즐거운 사용자 인터렉션을 제공할 때 dynamic한 사용자 인터렉션을 추가하는 것은 굉장히 유용합니다.
- 터치감을 부드럽게 하거나 시각적인 업데이트를 부드럽게 한다면 유용한 앱과 필수적인 앱의 차이를 만드는 것이 가능합니다.
- 이번 챕터에서는 gesture등을 추가하여 어떻게 직관적이면서 참신한 사용자 인터렉션을 제공할 수 있는지에 대해서 알아보도록 하겠습니다.



### Adding the learn feature

- 우리는 앱에 2개의 tab이 있는 탭바를 추가할 것입니다.
- 먼저 LearnView.swift과 HomeView.swift 파일을 새로 추가했습니다. 
- 새로운 뷰를 생성하고 난 후에 이 보기를 비워두고 새로운 뷰에 접근할 수 있는 방법을 추가하도록 하겠습니다.
- HomeView.swift 파일은 tabs의 host 가 되는 파일입니다.

<img width="800" alt="스크린샷 2020-10-22 오후 4 59 24" src="https://user-images.githubusercontent.com/48345308/96842406-f34d4500-1487-11eb-9885-b3ae4d597089.png">

- 위와 같이 TabView를 생성하고 일단은 EmptyView()로 아무것도 없는 뷰를 만들었습니다.
- 또한 *accentColor* modifier를 사용하여 아이콘이나 text가 클릭되었을 때 빨간색으로 뜨게 하였습니다. 

<img width="1025" alt="스크린샷 2020-10-22 오후 5 03 37" src="https://user-images.githubusercontent.com/48345308/96842861-88503e00-1488-11eb-8038-6a4af14e8667.png">

- icon과 Text를 추가하여 preview를 보시면 그에 따라 tabItem이 생성된 것을 알 수 있습니다.
- *.tag(0)* 는 learn tab의 인덱스를 말합니다.

<img width="338" alt="스크린샷 2020-10-22 오후 5 10 55" src="https://user-images.githubusercontent.com/48345308/96843671-8dfa5380-1489-11eb-866e-dbfa3c793309.png">

- 현재 WelcomeView.swift 파일을 보면 showPractice 프로퍼티가 true 이면 PracticeView를 보여주는 상황인데 이를 *HomeView()*로 대체하겠습니다.



<img width="995" alt="스크린샷 2020-10-22 오후 5 17 23" src="https://user-images.githubusercontent.com/48345308/96844429-753e6d80-148a-11eb-9b3b-2318e3d0387d.png">

- 그리고 HomeView.swift 파일 안에 있는 TabView에 다음과 같이 LearnView와 PracticeView를 추가하면 오른쪽과 같이 탭바의 형태를 띄는 preview를 확인하는 것이 가능합니다!



### Creating a flashcard

- 새로운 "Learn" 탭과 함께 Learn feature의 첫번째 컴포넌트는 flash card의 역할을 하게 될 것입니다.
- card에 대해 이야기 할 때 앱에서는 두 가지의 뜻이 있습니다. (UI component인 시각적인 card와 state인 card data)
  - 둘 다 카드 기능에는 필수적이며 card 자체는 이 두가지를 모두 합친 것입니다.
  - 하지만 visual card는 state 없이 존재할 수 없기 때문에 state를 표시할 수 있는 데이터 구조가 필요합니다.

<img width="350" alt="스크린샷 2020-10-22 오후 5 32 01" src="https://user-images.githubusercontent.com/48345308/96846183-812b2f00-148c-11eb-936d-828382433b19.png">

- 데이터 구조를 작성하기 위해 다음과 같이 FlashCard 구조체를 생성하였습니다. 구조체 안에는 사용자가 배우고 싶어하는 데이터를 넣어줘야 합니다.
- 따라서 Challenge 타입의 프로퍼티를 선언하였습니다.
- *id* 는 여러 flashcard view들 통해 반복되는데 유용하게 사용될 수 있습니다. 이때 *identifiable* 프로토콜을 준수하는 구조체로 만들어 SwiftUI의 *forEach* 블록을 사용하고 명시적인 identifier가 지정되지 않았을 때는 초기의 id를 찾게 하는 것이 좋습니다.



#### Identifiable ???

<img width="400" alt="스크린샷 2020-10-22 오후 5 34 47" src="https://user-images.githubusercontent.com/48345308/96846448-e3842f80-148c-11eb-8f38-6dd34031b394.png"> <img width="530" alt="스크린샷 2020-10-22 오후 5 36 40" src="https://user-images.githubusercontent.com/48345308/96846646-27773480-148d-11eb-87d0-db6a32618ff1.png">

- iOS 13에서 처음 나온 *identifiable* 프로토콜을 쉽게 설명해보자면 식별이 가능하게 해주는 프로토콜입니다.
- 프로토콜 안에는 associatedtype ID가 선언되어 있는데 이는 Hashable 프로토콜을 준수하고 있어 HashValue를 가지게 됩니다. 이 hashvalue를 사용하여 인스턴스를 식별 가능하게 해주는 것입니다!



- 앱에서 id 생성기는 없기 때문에 Foundation의 UUID 생성자를 사용해서 고유한 식별자를 FlashCard가 생성될 때마다 제공합니다. 
- 그리고는 FlashCard의 state를 보여줄 수 있는 isActive 프로퍼티를 추가합니다.

```Swift
struct FlashCard {
	var card: Challenge
	let id = UUID()
  var isActive = true
}
```

<img width="745" alt="스크린샷 2020-10-22 오후 5 46 30" src="https://user-images.githubusercontent.com/48345308/96847759-87220f80-148e-11eb-9b2c-004727a3e73b.png">

- UUID란 타입, 인터페이스, 그 외의 기타 항목들을 식별하는데 사용할 수 있는 보편적으로 고유한 값을 만드는 구조체입니다.



- 사용자는 항상 이미 알고 있는 카드의 덱을 거치는 것을 원하지 않을 수 있으니 카드들을 내부 로직에 의해서 선택적으로 필터링 할 수 있게 해줍니다.![스크린샷 2020-10-22 오후 5.52.24](/Users/user/Library/Application Support/typora-user-images/스크린샷 2020-10-22 오후 5.52.24.png)

- 구조체가 *Identifiable* 프로토콜을 준수하게 만듭니다. 이렇게 했을 때 추가적인 작업을 해야 할 필요가 없지만 우리는 이것이 *Equatable* 한지도 알고 싶습니다. 이것은 우리가 비교할 때 더 쉽고 빠르게 비교하는 것이 가능해 같은 카드가 중복되었는지를 체크할 수 있습니다.
- Equatable 프로토콜을 준수하고 *== method* 를 구현하였기 때문에 우리는 == operator를 통해서 두 flash card를 비교하는 것이 가능해졌습니다.



### Building a flash deck

- deck이 새로운 개념은 아니지만 UI에서 사용할 수 있는 완전히 새로운 상태의 구조체를 만들어 연습보다는 학습 기능이 명백해지도록 만들 것입니다.

<img width="400" alt="스크린샷 2020-10-22 오후 6 00 16" src="https://user-images.githubusercontent.com/48345308/96849336-74103f00-1490-11eb-9804-08f465b9d4c4.png">

- 다음과 같이 FlashDeck 클래스를 생성하였습니다.
- 생성자는 words를 map 해서 FlashCard에 전달합니다! 
- FlashDeck 모델의 힘은 *Combine* 으로부터 옵니다. deck이 바뀔 때 UI가 반응하게 만들기 위하여 cards property는 *@Published* 어트리뷰트를 사용하여 subscriber들이 모델이 업데이트 되었을 때 알림을 받을 수 있게 만듭니다.

```Swift
@Published var cards: [FlashCard]
```

- 마지막으로 FlashDeck을 *ObservableObject* 로 확장해야 합니다.



### Final state

- 학습 기능을 위한 마지막 상태 작업은 상점이 될 것입니다. 이것은 deck(카드들)을 보관하고 사용자의 제어 기능을 제공하여 deck을 관리하거나 UI에서 업데이트 받을 수 있게 합니다.
- top-level state model은 *LearingStore* 로 정합니다.

<img width="458" alt="스크린샷 2020-10-22 오후 6 19 43" src="https://user-images.githubusercontent.com/48345308/96851603-29dc8d00-1493-11eb-9202-7c7167fe1260.png">

1. FlashDeck과 마찬가지로 Combine을 사용하여 *@Published* 어트리뷰트를 프로퍼티에 제공합니다. Store는 전체 deck을 유지할 것 입니다.
2. 현재 카드를 위한 프로퍼티입니다.
3. 현재 점수를 기록하기 위한 프로퍼티입니다.
4. deck을 설정하기 위한 이니셜라이저 입니다. 
5. method를 만들어서 getNextCard() 를 호출하면 다음 카드를 얻는 것이 가능합니다. 이 메소드는 카드를 제공한 다음에 마지막 카드를 제거하는 방식을 띄고 있습니다.
6. 마지막으로 LearningStore 클래스 또한 *ObservableObject* 를 준수해야 합니다.



### Building the UI

- Learn에 대한 UI는 3계층의 view로 구성이 됩니다.
  - 첫 번째는 비어있는 LearnView입니다.
  - 두번째는 LearnView의 상단에 있는 deck view 입니다.
  - 마지막으로는 현재 flashcard view입니다.
- 이제 DeckView와 CardView를 생성하도록 하겠습니다.

<img width="1088" alt="스크린샷 2020-10-22 오후 6 35 57" src="https://user-images.githubusercontent.com/48345308/96853523-6f9a5500-1495-11eb-8e07-a5b626f0c74d.png">

- 위와 같이 CardView를 만들었습니다. 
- 이것은 간단한 끝이 둥글고 몇 개의 Text가 있으며 shadow를 가진 빨간색 카드 입니다. 



<img width="1090" alt="스크린샷 2020-10-22 오후 6 39 02" src="https://user-images.githubusercontent.com/48345308/96853902-dd468100-1495-11eb-924d-39703f255f0a.png">

- 다음과 같이 DeckView를 만들었습니다.
- ZStack을 사용해서 2개의 카드를 포함하고 있는 view를 만들었습니다.
- 하지만 학습 흐름에 따라 동적으로 생성되는 카드 로딩하는 것을 지원하는 객체를 생성하기 위하여 이 view를 구체화시킬 것입니다.
- 카드가 겹겹으로 쌓이기 때문에 Canvas에서 Deckview는 CardView와 같은 형태를 띄는 것을 알 수 있습니다.



<img width="1023" alt="스크린샷 2020-10-22 오후 6 44 34" src="https://user-images.githubusercontent.com/48345308/96854590-a329af00-1496-11eb-96cd-d19998d667b4.png">

- 이번에는 LearnView를 수정해보았습니다. 
- 지침을 제시하는 Text를 추가하고 아래에는 점수에 관련된 Text를 추가하였습니다. 그리고 스크린의 가운데에는 DeckView() 가 나타나게 하였습니다.



### Adding LearningStore to the views

- 프로퍼티를 생성하여 이전에 만들었던 store를 추가하도록 하겠습니다.

```Swift
@ObservedObject var learningStore = LearningStore(deck: ChallengesViewModel().challenges)
```

- LearningStore은 *ObservedObject* 이며 이것은 LearnView의 *published* 된 프로퍼티가 변경 되었을 때 뷰가 다시 작성 되도록 해줍니다.
- 여기에서 score Text를 업데이트 하는 것도 가능합니다.

```Swift
// 1
Text("Remembered 0/0")

// 2
Text("Remebered \(self.learningStore.score)" + "/\(self.learningStore.deck.cards.count)")
```



- DeckView에서는 LearningStore 내에서 일부 데이터를 받아서 CardView components로 전달할 수 있어야 합니다.

```Swift
@ObservedObject var deck: FlashDeck
	
	let onMemorized: () -> Void
	
	init(onMemorized: @escaping () -> Void, deck: FlashDeck) {
		self.onMemorized = onMemorized
		self.deck = deck
}
```

- 사용자가 카드를 암기할 때 사용할 콜백뿐만 아니라 view가 subscribing할 항목을 얻기 위한 프로퍼티를 추가하였습니다. onMemorized는 클로저로 선언되어 있고 deck은 *@ObservedObject* 입니다.



```Swift
// LearnView.swift

DeckView(onMemorized: {
		self.learningStore.score += 1
}, deck: learningStore.deck)
```

- 위에서 DeckView를 수정하면서 LearnView.swift 파일에서도 DeckView 생성하는 부분을 수정해야 합니다.
- 여기서 onMemorized로 전달받은 클로저로 사용자가 카드를 암기했을 때 어떻게 점수를 증가시킬지 알 수 있습니다. 아직 까지는 onMemorized를 트리거 하는 부분이 없지만 곧 추가할 것입니다.



- 그 다음으로는 learning store로 부터 카드 각각의 데이터를 가져올 것입니다.

<img width="400" alt="스크린샷 2020-10-22 오후 7 09 08" src="https://user-images.githubusercontent.com/48345308/96857558-1254d280-149a-11eb-970b-c349bdd95114.png">

- CardView 구조체 안에 FlashCard 타입 프로퍼티를 선언하였습니다.
- 프로퍼티는 state object가 아닙니다 왜냐하면 FlashCard의 값을 변경할 계획이 없기 때문입니다. 카드 데이터는 고정되어 있습니다.



- 여러개의 CardView들을 제공하기 위해서 우리는 bottom view에 도움을 받을 수 있는 메서드를 추가해야 합니다.

<img width="462" alt="스크린샷 2020-10-22 오후 7 21 48" src="https://user-images.githubusercontent.com/48345308/96858919-d6bb0800-149b-11eb-9a10-00a72bf90efc.png">

- 이 메서드들은 FlashCard를 이용하여 CardView를 반드는 것을 도와주고 있습니다.
- FlashCard를 받아와 CardView를 리턴하는 getCardView() 메서드의 경우 [FlashCard] 배열인 deck에서  isActive의 값이 true인 것을 필터링 합니다. 그리고 createCardView 메서드에서 FlashCard를 파라미터로 받아와 CardView를 리턴하는 메서드를 이용합니다.



```Swift
ZStack { ForEach(deck.cards.filter({ $0.isActive })) {
		card in
		self.getCardView(for: card)
	}
}
```

<img width="725" alt="스크린샷 2020-10-22 오후 8 24 59" src="https://user-images.githubusercontent.com/48345308/96865240-aa57b980-14a4-11eb-8975-5b922499ecd1.png">

- data의 컬렉션에서 온 demand view들을 계산하는 구조체입니다.
- 위에서는 ForEach을 통해 deck에서 모든 활성화된 카드를 가져오고 위에서 만들었던 도우미 메서드를 사용해서 각 CardView를 생성하는 것입니다!



### Your first gesture

- SwiftUI의 제스처는 UIKit/AppKit 과는 그렇게 다르지는 않지만 단순하고 다소 우아해서 일부 개발자들 사이에서는 이것이 더 강력하다는 인식을 주고 있습니다.
- 비록 SwiftUI의 제스처가 능력 면에서 더 좋아진 것은 아니지만 SwiftUI의 접근 방식은 더 쉽고 제스처들을 더 흥미롭게 사용하는 것이 가능합니다.

- 이전에 우리는 CardView의 현지어와 번역된 단어를 추가했습니다. 하지만 사용자가 바로 답을 받지 않고 자신의 지식을 테스트하고 싶다면 어떻게 해야 될까요?
- 일단은 현지어를 보여주고 필요하다면 번역된 단어를 보여주는 것이 좋을 것 같습니다.
- 이거를 해결하기 위해 우리는 간단한 tap gesture 인터렉션을 추가할 것입니다.

```Swift
// CardView.swift

@State var revealed = false

.gesture(TapGesture().onEnded({
			withAnimation(.easeIn) {
				self.revealed = !self.revealed
      }
})
```

- 먼저 카드의 답변이 공개되었는지에 대한 여부를 나타내는 property를 추가했습니다.
- 그 다음에 *.gesture* modifier를 통해서 제스처를 생성했습니다. *onEnded* 블럭은 tap gesture가 포함되고 나서 어떠한 일이 발생할지에 대한 추가적인 코드를 제공합니다. 여기서 애니메이션을 *.easeIn* 으로 주었고 revealed 프로퍼티는 값이 바뀝니다.
- 지금은 revealed 프로퍼티가 아무 역할도 하지 않습니다. 하지만 답변 Text를 revealed의 값에 따라 보여줄지를 결정할 수 있습니다.

```Swift
if self.revealed { Text(flashCard.card.answer)
	.font(.caption)
	.foregroundColor(.white) 
}
```

<video src="/Users/user/Library/Application Support/typora-user-images/화면 기록 2020-10-22 오후 8.58.31.mov"></video>



### Custom gestures

- Tap gesture나 다른 간단한 제스쳐들도 좋지만 종종 훨씬 정교한 제스처가 필요한 경우가 있습니다.
- 이 앱에서는 그들이 카드를 기억했는지 안했는지에 대한 인터렉션을 알려주는 제스처를 제공하고 싶습니다.
- 우리는 drag gesture를 사용해서 drag의 방향에 따라 결과를 평가하는 제스처를 만들 것입니다.

```Swift
// DeckView.swift

enum DiscardedDirection {
  case left
	case right
}

// CardView.swift
typealias CardDrag = (_ card: FlashCard,
_ direction: DiscardedDirection) -> Void

let dragged: CardDrag

func createCardView(for card: FlashCard) -> CardView { let view = CardView(card, onDrag: { card, direction in
	if direction == .left {
			self.onMemorized() }
	})
	return view 
}
```

- direction이 왼쪽이면 onMemorized() 가 호출되고 LearningStore의 counter가 1 증가합니다.
- 만든 drag gesture를 사용하기 위해 다음의 프로퍼티를 추가합니다,

```Swift
@State var offset: CGSize = .zero
```

- card를 움직이게 되면 offset은 업데이트 되어져야 합니다.
- 그리고 drag gesture를 body의 가장 위에 추가합니다. 

```Swift
ZStack {
  
}

return ZStack {
  
}
```

- ZStack 위에 drag gesture를 추가할 것이므로 ZStackd을 return해야 합니다. (??? 질문)
  - **월요일**



```Swift
let drag = DragGesture()
			.onChanged { self.offset = $0.translation }
			.onEnded {
				if $0.translation.width < -100 {
					self.offset = .init(width: -1000, height: 0)
					self.dragged(self.flashCard, .left)
				} else if $0.translation.width > 100 {
					self.offset = .init(width: 1000, height: 0)
					self.dragged(self.flashCard, .right)
				} else {
					self.offset = .zero
				}
}
```

- 각각의 움직임들은 onChanged 이벤트가 발생할때 drag하면서 다 기록됩니다. *offset* 프로퍼티를 움직이면서(x와 y의 좌표 객체) 사용자의 드래그 모션에 맞게 값이 변합니다.
- 예를 들어서 사용자가 좌표상에서  (0,0)에서 드래그를 시작했다면 *onChanged* 트리거됩니다 사용자가 (200, -100) 까지 드래그 했다면 offset의 x축은 200만큼 증가하고 offset의 y축은 100만큼 감소합니다. 이 의미는 component는 사용자의 손가락에 따라 그거에 맞게 스크린에서 움직인다는 것입니다.
- *onEnded* 이벤트는 사용자가 drag를 멈췄을 때 발생합니다. (즉, 스크린에서 손가락을 떼는 순간) 
- 우리는 사용자가 카드를 어떤 방향으로 드래그 했는지 어떤 목적을 위해 드래그 했는지를 결정해야 합니다.(카드를 넘기거나, 아니면 카드의 원래 좌표로 돌아갈지)
- 우리는 -1000과 1000을 사용자가 왼쪽 혹은 오른쪽으로 드래그했는지에 대한 선택에 따라 값을 클로저에 넘기고 있습니다. 



### Combining gestures for more complex interactions

- 만약 사용자가 카드를 길게 선택하고 있을 때 인터렉션이 가능하다면 이것은 더 시각적으로 좋은 지표를 제공할 수 있을 것입니다.


길게 누르고 있다면 물체는 튀거나 튀어나오는 것 같은 것을 통해 물체가 움직일 수 있다는 시각적인 단서를 제공할 수 있습니다.

- SwiftUI는 2개의 제스처들을 합쳐서 추가할 수 있는 기능을 제공하고 있습니다.

- SwiftUI는 그것들이 어떻게 상호작용할지에 대한 몇 가지 옵션을 제공합니다.

  1) Sequenced: 다른 제스쳐를 따라가는 제스처

  2) Simultaneous: 동시에 함께 활성화 되는 제스처

  3) Exclusive : 두개가 추가 될 수 있지만, 한번에 하나만 활성화 되는 제스처

- 이번에는 simultaneous 제스처를 통해 drag 제스처가 가능하다는 것을 알려주는 단서를 어떻게 제스처로 제공할지에 대해 알아보겠습니다.

```Swift
@GestureState var isLongPressed = false
```

- *@GestureState* 라고 불리는 새로운 state attribut를 볼 수 있습니다. 이것은 gesture의 state를 저장하고 gesture가 view에서 그려지며 영향을 끼치는 동안을 받아오는 것이 가능합니다.
- 이 프로퍼티는 card가 긴 시간동안 눌렸는지 안눌렸는지에 대한 것을 저장합니다. 그리고 gesture가 끝나고 나면 reset할 것입니다.
- 만약에 *@State* 프로퍼티를 쓰지 않는다면, 프로퍼티는 gesture가 끝나도 reset 되지 않을 것입니다.

```Swift
let longPress = LongPressGesture() .updating($isLongPressed) { value, state, transition in
    state = value
  }
.simultaneously(with: drag)


.gesture(longPress) 
.scaleEffect(isLongPressed ? 1.1 : 1)
```



### Key points

- 제스처는 직관적인 사용자 경험에서 기쁨을 줄 수 있는 좋은 방법입니다. SwiftUI는 이것을 더쉽고 효과적으로 추가할 수 있는 modifier 들을 제공하고 있습니다. 

  1) Apple이 라이브러리에 넣어 놓은 간단한 제스처를 만드는 방법을 배워보고 이 gesture modifier를 사용하는 방법에 대해서 공부했습니다.

  2) 특정 인터렉션에 대해 custom한 제스처를 만드는 방법에 대해서 공부했습니다.

  3) 유동적인 경험을 통해 gesture와 애니메이션을 어떻게 합치는지에 대해서 공부했습니다.