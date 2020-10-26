# Chapter 14: Animations



- 좋은 앱과 훌륭한 앱의 차이는 디테일에서 옵니다.
- 적절한 자리에 적절한 애니메이션을 사용하는 것은 앱 스토어에서 인기를 얻게 만들어줍니다.
- 애미메이션은 앱을 더 재밌게 할 수 있으며 사용자가 특정 구역에서 더 집중할 수 있게 하는 강력한 역할을 합니다.
- SwiftUI에서의 애니메이션은 AppKit 혹은 UIKit 보다 훨씬 간단합니다. 
- SwiftUI 애니메이션은 지루한 작업을 처리하는 높은 수준의 추상적인 개념입니다. 앱에서 애니메이션을 생성하는 것이 어렵지 않다는 것을 이번 챕터에서 알 수 있을 것입니다.
- 신경을 쓰지 않고도 애니메이션을 조합하거나 overlap하는 것이 가능합니다.



### Adding animation

```Swift
Button(action: {
	self.showDetails.toggle()
}) {
	HStack {
		if showDetails {
			Text("Hide Details")
			Spacer()
			Image(systemName: "chevron.up.square")
			} else {
					Text("Show Details")
					Spacer()
					Image(systemName: "chevron.down.square")
					}					
  	}
}
```

- 이 코드는 text와 이미지인 비행기의 디테일을 어떻게 보여줄지에 대한 코드입니다. 이것은 작동하지만 애니메이션을 적용한다면 더 부드럽게 보일 것입니다.

```Swift
Image(systemName: "chevron.up.square")
	.rotationEffect(.degrees(showDetails ? 0 : 180))
	.animation(.default)
```

- 위의 코드에서 *rotationEffect* modifier만 사용한다면 이전과 같은 것을 볼 수 있습니다.
- 그리고 아래 *.animation* modifier를 사용해야 애니메이션이 적용되는 것을 알 수 있습니다. 애니메이션은 시작 상태에서 종료 상태로 변경되는 기간에 걸벼 발생하게 됩니다.
- SwiftUI에게 animation의 타입을 정할 수 있으며 이것에 맞게 적용될 것입니다.
- 0부터 180까지 rotation이 상태에 따라 변화할 것이며, *.animation()* modfier를 통해 SwiftUI에게 상태 변화에 애니메이션을 주도록 알릴 수 있습니다.
- 이때 애니메이션은 오로시 *image* 의 회전에만 적용되며 다른 곳에서는 적용되지 않습니다.



### Animation types

- 우리는 *default animation* 을 사용해봤지만 SwiftUI에서는 더 많은 타입의 애니메이션을 제공합니다.

```Swift
FlightDetails(flight: flight)
	.offset(x: showDetails ? 0 : -UIScreen.main.bounds.width)
```



### Default animation

```swift
.animation(.default)
```

- *default* 애니메이션은 가장 간단한 애니메이션 타입입니다.
- 이것은 처음에서 끝까지 일정한 비율로 선형변화를 제공합니다.

![스크린샷 2020-10-26 오후 7 54 58](https://user-images.githubusercontent.com/48345308/97164212-2283ef00-17c5-11eb-9187-a29bc1de2bd6.png)



### Eased animations

- *eased animation* 은 앱에서 가장 흔한 것입니다. *eased animation* 은 끝점에서 가속 또는 감속을 제공합니다.
- 이것은 실세계의 변화와 비슷하기 때문에 가장 자연스럽게 보이는 애니메이션입니다.
- 애니메이션은 현실 세계에서의 감속 혹은 가속을 반영합니다.



#### .easeOut



```Swift
.animation(.easeOut)
```

![스크린샷 2020-10-26 오후 8 00 05](https://user-images.githubusercontent.com/48345308/97164675-d8e7d400-17c5-11eb-9bb5-86d082a54749.png)

- 속도는 빨랐다가 점점 느려지며 멈추게 되는 형태를 띄게 됩니다. 
- 아래와 같이 *duration:* 파라미터에 다른 값을 특정할 수 있습니다.

```swit
.animation(.easeOut(duration: 2))
```

- 이것은 위와 똑같지만 끝날때까지 2초가 소요될 것입니다.



#### .easeIn

- 아래와 같이 처음에는 느렸다가 갈수록 빨라지는 애니메이션을 말합니다.

![스크린샷 2020-10-26 오후 8 01 27](https://user-images.githubusercontent.com/48345308/97164811-09c80900-17c6-11eb-9e8e-fe610bce3b8a.png)



#### .easeInOut

- 아래와 같이 처음에는 빨랐다가 나중에 갈수록 느려지는 애니메이션입니다.

![스크린샷 2020-10-26 오후 8 02 22](https://user-images.githubusercontent.com/48345308/97164887-2a905e80-17c6-11eb-8635-9480d418682f.png)





- 만약에 curve의 모양을 제어하고 싶다면 *timingCurve(_:_:_:_:)* 메서드를 사용할 수 있습니다.
- SwiftUI는 애니메이션의 완화를 위해 bezier 곡선을 이용합니다. 이 메서드를 사용하면 0부터 1의 범위에서 해당 곡선에 대한 제어점을 정의할 수 있으며 곡선의 모양은 제어점을 반영하게 됩니다.



### Spring animations

- *eased animation* 시작과 끝점 사이에서 항상 한 방향으로만 이동합니다. SwiftUI에서 스프링 카테고리는 상태 변경이 끝날 때 bounce를 추가하는 것이 가능합니다.



### Why a spring makes a useful animation

- *spring* 은 늘어났다 압축합니다.
- 스프링의 신축이나 압축이 클수록 스프링의 저항은 커지게 됩니다. 
- 물체의 무게는 중력의 당김이 늘어진 spring의 저항을 정확하게 상쇄하는 지점까지 스프링을 늘릴 것입니다.
- 이러한 사이클은 단순한 조화적인 움직임입니다. 마찰력이 없는 세상에서 이 순환은 계속 지속될 것입니다.

![스크린샷 2020-10-26 오후 8 17 19](https://user-images.githubusercontent.com/48345308/97166218-41d04b80-17c8-11eb-91e4-d199b538b8f4.png)

- 하지만 현실 세계에서는 순환을 반복할수록 힘을 잃을 것입니다.
- 이러한 누적된 손실은 합산되며, 결국 무게는 평혐점까지 움직이지 않고 돌아오게 될 것입니다. 이를 그래프로 나타내면 아래와 같을 것입니다.

![스크린샷 2020-10-26 오후 8 18 44](https://user-images.githubusercontent.com/48345308/97166356-73e1ad80-17c8-11eb-83ef-d055f2b3010d.png)



### Creating spring animations

- 우리는 스프링이 어떻게 동작하는지에 대해서 알아보았습니다 이제는 파라미터가 애니메이션에 어떠한 영향을 미칠지에 대해서 알아보겠습니다.
- 기본적으로 스프링 애니메이션을 생성하는 것은 다음과 같습니다.

```Swift
animation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 0))
```

- 위의 파라미터는 애니메이션에 다음과 같은 영향을 끼칩니다.

  1) *mass* : 시스템이 얼마나 길게 bounce할 것인가

  2) *stiffness* : 처음 움직임에서의 속도

  3) *damping* : 시스템이 얼마나 천천히 멈추게 될 것인지

  4) *initialVelocity* : 추가 초기 동작 제공

- *mass* 를 증가시키는 것은 애니메이션이 더 길게 그리고 각각의 점에서 멀리 움직이게 합니다. *mass* 가 작으면 빠르게 멈추고 각각의 끝점이 낮습니다.
- *stiffness* 를 증가시키면 각각의 바운스가 이전의 endpoint 보다 멀리 움직입니다. 그러나 애니메이션의 길이에는 낮은 영향을 끼칩니다.
- *damping* 을 증가시키면 애니메이션을 끝에서 부드럽게 만들 수 있습니다.
- *intialVelocity* 는 이동이 다른 방향에서 극복해야 하기 때문에 시스템의 약간의 지연을 유발할 수 있습니다.



- 애니메이션의 실제 모델은 결과에 직관적으로 연관되지 않습니다.
- SwiftUI는 스프링 애니메이션을 더 직관적인 방법으로 생산할 수 있는 방법을 제공합니다.

```Swift
.animation(.spring(response: 0.55, dampingFraction: 0.45, blendDuratiohn: 0))
```

1) *dampingFraction* 은 얼마나 빠르게 스프링이 정지하는 속도를 제어합니다. 값이 zero이면 영원히 멈추지 않습니다.

2)  *response* 파라미터는 *dampingFraction* 이 0으로 설정된 경우 시스템이 단일 진동을 완료하는 데 걸리는 시간을 정의합니다.

3) *blendDuration* 파라미터는 다른 애니메이션 간의 전환 길이를 제어하기 위한 기능을 제공합니다.



### Removing and combining animations

- view의 이동을 적용하고 싶을때 일부만 애니메이션화 하고 싶을 수 있습니다.

<img width="549" alt="스크린샷 2020-10-26 오후 8 39 48" src="https://user-images.githubusercontent.com/48345308/97168208-65e15c00-17cb-11eb-844e-c9b51708dcf0.png">

- 애니메이션을 보면 회전과 동시에 버튼이 커지는 것을 볼 수 있습니다.
- 애니메이션은 애니메이션을 적용한 모등 element에서 상태가 변화할 때 발생합니다. *.animation(nil)* 을 *.scaleEffect()* 와 *.rotationEffect()* 사이에 추가한다면 애니메이션을 추가하기 전에 보이는 fade-out/fade-in 효과와 함께 스케일 변경이 즉시 이루어지게 됩니다. 
- *.animation* modifier를 여러번 사용하면서 애니메이션을 합치는 것도 가능합니다.



### Animating from state changes

- 이번에는 변경된 view의 element에 애니메이션을 적용합니다. 또한 상태 변화가 일어나는 point에서 애니메이션을 적용합니다.
-  그렇게 한다면, 애니메이션은 상태 변화 때문에 발생하는 모든 변화에 적용될 것입니다.

```Swift
// 1
Button(action: {
	self.showDetails.toggle()
})

// 2
Button(action: { withAnimation(.default) {
	self.showDetails.toggle() 
}
```

- 여기서 *.animation(_:)* modifier를 제거하고 대신에 *withAnimation()* method를 통해 Button의 액션에 추가하였습니다. 이것은 default 애니메이션을 호출하지만 이 function안에 어떠한 animation도 전달하는 것이 가능합니다.



### Adjusting animations

- 전체 애니메이션에 흔히 사용되는 몇 가지의 메소드가 있습니다. 
- 이러한 메소드들은 애니메이션을 늦추거나, 반복, 속도를 제어할 수 있습니다.



#### Delay

- *delay()* 메서드는 애니메이션이 발생하기 전에 몇 초의 시간을 특정할 수 있습니다.

```Swift
.animation(Animation.spring().delay(1))
```



#### Speed

- *.speed* 메서드를 통해서 애니메이션의 속도를 바꿀 수 있습니다.
- 이 modifier에 제공한 값을 곱한 값이 애니메이션의 속도가 됩니다.
- 이 modifier는 default나 스프링 애니메이션 등 직접적인 시간의 요소가 부족한 애니메이션의 시간을 조절하는데 유용합니다.

```Swift
.animation(Animation.spring().speed(2))
```



#### Repeating animations

- 애니메이션을 반복하기 위해서는 *.repeatCount(_:autoreverses:)* 를 몇 번동안 반복할지에 대한 숫자를 정의해야 합니다.
- 또한 애니메이션이 반복되기 전에 반대로 갈지도 정할 수 있습니다. 역전이 업다면 이 애니메이션은 뒤로 돌아가지 않고 초기 상태로 즉시 되돌아 갑니다. 역전이 있다면 다시 반복하기 전의 초기 상태로 돌아가게 됩니다.
- *repeatForever(autoreverses:)* 메서드는 애니메이션이 계속 반복하지만, 반복하기 전에 애니메이션의 reverse가 되어야 하는지의 여부를 정의해줘야 합니다.

```swift
.animation(Animation.spring(), repeatCount(2, autoreverses: false))
```

- 이렇게 한다면 애니메이션은 2번을 반복하게 됩니다.



### Extracting animations from the view

- 여기까지, 우리는 애니메이션을 뷰 안에 직접 정의하였습니다. 
- 실제 앱에서는 코드의 다른 요소를 분리하여 보관할 때 코드를 유지 및 관리하는 것이 쉽습니다.

```Swift
var flightDetailAnimation: Animation {
		Animation.easeInOut
}
```

- 위와 같이 custom한 애니메이션 프로퍼티를 정의할 수 있으며 아래와 같이 적용하는 것이 가능합니다.

```Swift
withAnimation(self.flightDetailAnimation) {
  ...
}
```



### Animating view transitions

- 전환은 view를 표시하고 숨기기 위한 특정 애니메이션입니다.
- 기본적으로, view transition은 스크린에서 보이거나 보이지 않거나 할때입니다.
- 우리가 이미 배워왔던 애니메이션들도 transition과 함께 합니다.
- 애니메이션과 같이 *default transition* 은 하나의 가능한 애니메이션일 뿐입니다.

```Swift
if showDetails {
  FlightDetails(flight: flight)
  	.transition(.slide)
}

Button(action: {
  withAnimation {
	self.showDetails.toggle() }
}) {
```

- 위와 같이 한다면 view는 왼쪽으로 부터 슬라이드 될 것입니다.
- 이러한 transition은 텍스트 방향이 오른쪽에서 왼쪽에서 읽어지는 사례를 다룰 때 사용됩니다.



### View transition types

- 위에서는 slide transition을 사용했습니다. slide transition은 왼쪽 모서리에서 오른쪽 모소리로 슬라이딩 하는 효과를 말합니다.
- 또한 몇 가지의 transition animation이 존재합니다.
- default transition 타입은 view를 추가하거나 제거할때 opacity를 바꿉니다. view가 삽입될 때는 투명해지고 제거될 때는 그거에 반대입니다.
- *.move(edge:)* tranisition은 특정 모서리에 추가되거나 제거되는 것이 가능합니다.

```swift
.transition(.move(edge: .bottom))
```

- 물론 top, leading, trailing도 가능합니다.
- 움직임을 넘어서 transition은 view를 스크린에 나타내는 것에 애니메이션을 추가하는 것이 가능합니다.
- *.scale* transition은 단일 점에서 삽입할 때 뷰가 확장되거나 중앙의 단일 점으로 제거될 때 뷰가 축소되는 원인이 되기도 합니다.
- 또한 *.anchor* 파라미터를 특정하여 어디가 애니메이션의 중앙이 될 지를 특정하는 것이 가능합니다.



- 마지막 transition 타입은 offset을 특정하여 CGSize 혹은 Length의 값 쌍으로 지정하는 것이 가능합니다.
- view가 삽입될 때 해당 간격에서 벗어나거나 제거될 때 상쇄됩니다.



### Extracting transitions from the view

- 애니메이션처럼 view에서부터 transition을 추출하는 것이 가능합니다.

```swift
extension AnyTransition {
		static var flightDetailsTransition: AnyTransition {
			AnyTransition.slide
    }
}

if showDetails {
  FlightDetails(flight: flight)
  	.transition(.flightDetailsTransition)
}
```



### Async transitions

- SwiftUI는 view를 추가하거나 제거할 때 별도의 transition을 제공할 수 있습니다.

```Swift
extension AnyTransition {
		static var flightDetailsTransition: AnyTransition {
			let insertion = AnyTransition.move(edge: .trailing)
				.combined(with: .opacity)
			let removal = AnyTransition.scale(scale: 0.0)
				.combined(with: .opacity)
			return .asymmetric(insertion: insertion, removal: removal)
		}
	}
```

- *combined(with:)* modifier를 이용해서 두 개의 transition을 합치는 것이 가능합니다.



### Key points

- 단순히 그렇게 하려고 애니메이션을 사용하지 않고 목적을 가져야 합니다.
- 애니메이션을 0.25초에서 1초 사이의 길이를 가지는게 좋습니다. 짧은 애니메이션은 알아차리기 힘들고, 긴 애니메이션은 어떤거를 해야할 사용자들을 화나게 할 수 있습니다.
- 애니메이션을 앱과 사용하는 플랫폼에 일관성을 가지게 해야 합니다.
- 애니메이션은 선택입니다. 
- 애니메이션이 다른 상태로 이동하는 흐름에서 부드럽게 해야 합니다.
- 애니메이션은 앱을 사용하는데 있어서 큰 차이를 만듭니다.

