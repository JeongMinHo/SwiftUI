# Chapter 13: Drawing & Custom Graphics



- 더욱 복잡한 앱을 개발하기 시작하면 Swift의 내장되어 있는 control 보다 더 많은 유연성이 필요하다는 것을 알 수 있습니다.
- 운이 좋게도 SwiftUI는  graphic을 생성하는데 도움을 주는 풍부한 라이브러리가 있습니다.
- *Graphic* 은 사용자에게 정보를 효율적이고 이해하기 쉽게 전달할 수 있습니다. 예를 들어, 동일한 정보를 텍스트로 읽는 것보다는 그래픽을 사용하여 요약하는 것이 훨씬 효과적입니다.
- 이번 챕터에서는 SwiftUI의 grphic 들의 사용 방법을 알아보고 몇 개의 graphic 들을 직접 생성해 보도록 하겠습니다.

# 

### Creating shapes

- 이번 챕터에서는 3가지의 초기 badge 들을 만들 것입니다.
- 첫 번째 뱃지는 누군가가 공항을 처음 방문할 때 수여되며, 이 과정을 거치고 나면 아래와 같은 결과를 얻을 수 있습니다.

![스크린샷 2020-10-23 오전 11 33 49](https://user-images.githubusercontent.com/48345308/96949754-a0c16680-1523-11eb-85b9-b5c2a5e44e13.png)

- SwiftUI에서 가장 기본적인 drawing structure들중 하나는 *Shape* 이며 복잡한 drawing들을 쌓는데 가장 단순하고 원시적인 집합입니다.
- 먼저, rectangle shape를 가진 SwiftUI view를 추가합니다. 

<img width="900" alt="스크린샷 2020-10-23 오전 11 39 45" src="https://user-images.githubusercontent.com/48345308/96950084-77550a80-1524-11eb-8fec-5080c18ae5fa.png">

- 위와 같이 작성하면 width와 height이 200씩인 직사각형이 검은색으로 칠해져서 스크린에 나타날 것입니다.
- 기본적으로 SwiftUI는 *shape* 를 전체 컨테이너에 채우지만, 더 작은 컨테이너로 지정하는 것이 가능합니다. 따라서 위에서 처럼 이것의 size를 frame의 width와 height을 통해 설정해주고 있습니다.
- 이 View는 SwiftUI에서 그릴 때 적용되는 몇 가지의 기본값을 보여줍니다. 명시적으로 stroke를 호출하여 채우이지 않으면 Color.primary로 현재의 foreground color로 칠해집니다. 이 Color.primary는 light 모드로 실행하는지, dark 모드로 실행하는지에 따라 달라집니다.
- 이를 확인해보기 위해서  preview 메소드에서 다음을 추가합니다.

```Swift
.environment(\.colorScheme, .dark)
```

- dark 모드일때, *Color.primary* 는 하얀색입니다. 따라서 Canvas에는 검은색 배경에 흰색 사각형을 볼 수 있습니다.

<img width="280" alt="스크린샷 2020-10-23 오전 11 50 14" src="https://user-images.githubusercontent.com/48345308/96950726-ebdc7900-1525-11eb-99b6-52424c0d7fc9.png"> <img width="167" alt="스크린샷 2020-10-23 오전 11 51 40" src="https://user-images.githubusercontent.com/48345308/96950816-20e8cb80-1526-11eb-8167-b852ec9d345a.png">

- 채워지는 색을 바꾸는 방법은 간단합니다. 

```Swift
.fill(Color.blue)
```

- 위와 같이 색깔을 채우면 라이트/다크 모드에 관계없이 색을 blue로 칠하는 것이 가능합니다. 
- 기억해야 될 것은 *.fill* 메소드은 *.frame* 메소드 이전에 호출해야 됩니다!!



### Using gradients

- 이 뱃지에는 2개 이상의 색상 간에 부드러운 전환을 사용하기 위하여 gradient를 사용할 것 입니다.

<img width="846" alt="스크린샷 2020-10-23 오후 12 09 34" src="https://user-images.githubusercontent.com/48345308/96951945-a0779a00-1528-11eb-8299-fa3d59b91aa0.png">

- *LinearGradient* 는 물체를 통과하는 직선을 따라서 색상들 사이에 원활한 전환이 가능합니다.
- *startPoint* 와 *endPoint* 는 UintPoint 구조체를 사용합니다. 
- *UnitPoint* 구조체의 원래의 값은 왼쪽 상단이 (0,0) 이며 오른쪽과 아래로 값이 점점 커집니다. (frame의 origin point와 동일합니다.)
- 시작하는 점과 끝나는 점을 원하는 곳에서 잡을 수 있으며 심지어 view의 밖에서도 잡을 수 있습니다. 
- 주의해야 할 점은 이러한 점은 색상의 끝을 의미하는 것이 아닌 색상 간의 전환의 끝을 말하는 것입니다!



### Rotating shapes

- square를 작성하였던 코드를 반복하는 것이 가능하며 이들 중 2개를 rotate 시킬 것입니다.
- SwiftUI는 *ForEach()* 메서드를 통해 이러한 방식을 제공합니다.

<img width="1034" alt="스크린샷 2020-10-23 오후 1 11 53" src="https://user-images.githubusercontent.com/48345308/96955764-5515b980-1531-11eb-87e2-85b67d56fb33.png">

- 위에 겹치는 것이기 때문에 ZStack을 이용해서 3개의 square를 쌓았습니다. 
- *ForEach* 루프를 통해서 3개의 set을 만들었습니다. 여기서 변수 *i* 가 현재 loop를 돌고 있는 값을 의미합니다.
- *.rotationEffect* modifier를 통해서 회전 효과를 주었으며 *.degree* 는 각도를 위한 지정자입니다. 루프를 돌면서  degree는 60도 만큼 증가하고 있습니다.



### Adding images

- iOS 13에 있는 SF Symbols에는 이미지 셋들이 있고 여기에 있는 비행기 이미지를 사용할 것입니다.

```Swift
Image(systemName: "airplane")
```

- ZStack안의 Rectangle 아래 코드에 이미지를 추가하였습니다. 

  ![스크린샷 2020-10-23 오후 1 17 46](https://user-images.githubusercontent.com/48345308/96956071-25b37c80-1532-11eb-90e4-270f4403c3a1.png)

- 하지만 이때 몇가지 고쳐야 할 점이 있습니다. 

- frame은 rectangle에게만 적용되기 때문에 이미지에는 frame을 설정해준값이 적용되지 않습니다. 대신에 이미지는 default 크기로 보여집니다.

- 이를 해결하기 위한 좋은 방법은 표시되는 frame에 이미지를 채움으로써 모든 크기의 view에 맞게 조정하는 것입니다. 이렇게 한다면 어떠한 앱에서도 이 view를 크기에 맞게 설정하는 것이 가능하며 이는 반응성을 유지할 수 있다는 것을 의미합니다. 

```Swift
struct AirportAwards_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			FirstVisitAward()
				.environment(\.colorScheme, .light)
				.frame(width: 200, height: 200)
			
			FirstVisitAward()
				.environment(\.colorScheme, .dark)
				.frame(width: 200, height: 200)
		}
	}
}
```

- 따라서 위와 같이 frame의 값을 preview에서 잡아주었습니다
- 이미지의 경우는 아래와 가치 frame에 맞게 이미지의 크기가 조절되는 *.resizable()* modifier를 사용하였습니다.
- 그리고 원래 비행기 이미지가 오른쪽으로 되어 있는 것을 *.degrees* modifier를 통해 90도 회전 시켜 비행기가 위를 보게 하고 *.opacity* modifier를 통해 투명도를 조절하였습니다.

![스크린샷 2020-10-23 오후 1.29.16](/Users/user/Library/Application Support/typora-user-images/스크린샷 2020-10-23 오후 1.29.16.png)



### Scaling drawings in views

- 이제 뱃지는 꽤 멋있지만 알아차리지 못할 수 있는 미묘한 버그가 있습니다.

<img width="330" alt="스크린샷 2020-10-23 오후 1 38 55" src="https://user-images.githubusercontent.com/48345308/96957250-1b46b200-1535-11eb-980d-f6091e6b95b5.png">

- 빌드하고 실행해보면 rotated square들이 frame의 바깥에서 title과 text로 bleed 되었습니다.
- 적용한 회전은 frame 안에 머물 수 있을만큼은 크기가 되지 않습니다.
- 이것을 해결하기 위하여 award frame 크기를 조정하여 회전이 된 모양이 frame에 들어가도록 해야합니다.

```Swift
GeometryReader { geometry in
			ZStack {
				ForEach(0..<3) { i in
					Rectangle()
						.fill(LinearGradient(gradient: .init(colors: [Color.green, Color.blue]), startPoint: .bottomLeading, endPoint: .topTrailing))
						// !!!!!
						.frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7)
						.rotationEffect(.degrees(Double(i) * 60))
				}
				Image(systemName: "airplane")
					.resizable()
					.rotationEffect(.degrees(-90))
					.opacity(0.5)
					.scaleEffect(0.7)
			}
		}
```

- *GeometryReader* container는 그 안에 있는 뷰의 크기와 모양을 가져오는 방식을 제공합니다. 이렇게 하면 상수에 의존하지 않고 코드를 작성할 수 있습니다.
- geometry의 인스턴스인 *size* 프로퍼티를 사용하여 view의 width와 height을 가져올 수 있습니다.
- 그리고 각가 0.7 만큼 곱하여 scale의 값을 줄였습니다. 
- SwiftUI의 아름다움은 compile-run loop의 실행 없이 변경하고 결과를 바로 볼 수 있다는 점입니다.(preview에서)
- 마지막으로 image의 값도 *.scaleEffect* modifier를 사용해 크기를 조정하였습니다.

<img width="280" alt="스크린샷 2020-10-23 오후 1 48 22" src="https://user-images.githubusercontent.com/48345308/96957735-6ca37100-1536-11eb-897d-f40b5e163de6.png">



### Other shapes

- SwiftUI는 몇 가지의 shape를 더 제공합니다.

  1) **Circle** : 원의 반지름은 rectangle의 radius 가장 작은 edge의 절반 길이일 것입니다.

  2) **Ellipse** : 타원은 타원이 포함된 view의 프레임 안에서 정렬됩니다.

  3) **Rounded Rectangle** : 날카로운 대신 둥근 모서리를 가지는 직사각형 입니다. 

  4) **Capsule** : 캡슐 모양은 둥근 직사각형이며 모서리의 길이가 직사각형의 가장 작은 자리 길이의 절반입니다.

- 이러한 shape들을 합치면 복잡한 결과물을 생성하는 것이 가능합니다. 하지만 이보다 더 복잡한 drawing은 *Paths* 입니다.



### Drawing lines with paths 

- 가끔은 built-in 이 아닌 우리가 원하는 모양의 shape를 정의하고 싶을때가 있습니다.
- 이러한 경우 *paths* 를 사용하며 이것은 개별 세그먼트를 결합시켜서 shape를 정의할 수 있는 방법입니다.
- 이러한 세그먼트는 2차원 형상의 윤곽을 이루며, 이러한 경로를 이용하여 *shape* 를 만들 것입니다.

<img width="883" alt="스크린샷 2020-10-23 오후 1 58 13" src="https://user-images.githubusercontent.com/48345308/96958234-cd7f7900-1537-11eb-992a-858f8756382c.png">

- *Path* 는 경로를 구축하는데 사용하는 enclosure를 생성합니다.
- *move(to:)* 는 path의 시작 위치를 설정하며, 현재 위치를 이동하지만 경로에는 아무것도 추가하지 않습니다.
- 그 다음 3개의 줄을 생성하여 polygon(다각형) 을 만드는 것이 가능합니다. 이것은 마치 도로가 멀어지는 것 같은 3D 효과를 주기도 합니다.(비행기 활주로 느낌??)

```Swift
GeometryReader { geometry in
			Path { path in
				
				let size = min(geometry.size.width, geometry.size.height)
				let nearLine = size * 0.1
				let farLine = size * 0.9
				
			path.move(to: CGPoint(x: size/2 + nearLine	, y: nearLine))
				path.addLine(to: .init(x: farLine, y: farLine))
				path.addLine(to: .init(x: nearLine, y: farLine))
				path.addLine(to: .init(x: size/2 - nearLine, y: nearLine))
			}
}
```

- 위에서 사용했던 것처럼 *GeometryReader* 를 사용해서 다음과 같이 x와 y좌표 값을 주는 것이 가능합니다. 
- 이렇게 하는 이유는 위에서처럼 직접 수치를 넣는다면 하나하나 수정해야되지만 다음과 같이 GeometryReader를 통해 각각의 size를 얻어와 그 값으로 위치를 정하기 때문에 조금 더 안전한 코드를 작성하는 것이 가능합니다.



### Drawing dashed lines

- 우리는 도로의 가운데에 하얀색 dashed line을 추가하는 것이 가능합니다. 

```Swift
Path { path in
					let size = min(geometry.size.width, geometry.size.height)
					let nearLine = size * 0.1
					let farLine = size * 0.9
					let middle = size / 2
					
					path.move(to: .init(x: middle, y: farLine))
					path.addLine(to: .init(x: middle, y: nearLine))
				}
				.stroke(Color.white, style: .init(lineWidth: 3.0, dash: [geometry.size.height / 20, geometry.size.height / 30], dashPhase: 0))
```

- 위의 코드는 path를 작성했던 코드와 비슷합니다. 
- view의 가운데 좌표를 구해 변수로 설정하고 있으며 채우는 대신에 SwiftUI에게 *.strokie* modifier를 사용하여 줄을 만들고 있습니다.
- 그 다음으로는 경로 위에 차를 추가하도록 하겠습니다.

```Swift
Image(systemName: "car.fill")
					.resizable()
					.foregroundColor(Color.blue)
					.scaleEffect(0.20)
					.offset(x: -geometry.size.width / 7.25)
```

- 위와 같이 이미지를 생성해주고 frame에 맞게 사이즈를 맞춰둔 뒤에 차의 색을 변경하였습니다. 또한 scale값으 0.2배로 줄였고 offset을 통해 차의 위치를 결정해주고 있습니다. 이렇게 하고 나면 아래와 같은 형태를 띄게 됩니다.

<img width="260" alt="스크린샷 2020-10-23 오후 2 18 11" src="https://user-images.githubusercontent.com/48345308/96959274-978fc400-153a-11eb-80d1-982f20e44a16.png">



### Drawing arcs and curves

- 경로는 선을 긋는 것보다 더 많은 유연성을 제공합니다. 
- 따라서 곡선을 그리기에 더 적합한 shape을 포함하여 다양한 옵션이 있습니다. 

<img width="531" alt="스크린샷 2020-10-23 오후 2 30 23" src="https://user-images.githubusercontent.com/48345308/96960031-4bde1a00-153c-11eb-8036-2ad28e044f8f.png">

- 먼저 위와 같이 *AirportMealAward.swift* 파일을 만들고 frame 크기와 상관없이 경로를 그리는 데 사용할 위치를 계산하였습니다.



### Drawing quadratic curves

- 2차 곡선의 이름은 2차 산술 방정식의 선 그림을 따라 그리는 것으로 정의합니다.
- SwiftUI는 수학적인 부분을 다루기 때문에 *control point* 라고 불리는 제 3점을 당겨 이 탄성을 통해 이를 다룰 수 있습니다.
- 각 끝에서 곡선은 제어점에 그려진 선에 평행하게 시작되고 모든 점 사이는 완만하게 곡선을 그리게 됩니다.
- 각 변의 중앙의 위치에 인접한 곳에서 이러한 곡선을 정의하는 것이 가능합니다.

<img width="886" alt="스크린샷 2020-10-23 오후 2 35 37" src="https://user-images.githubusercontent.com/48345308/96960303-066e1c80-153d-11eb-9cb9-4726878bc615.png">

- 또한 각각의 중점에 *gradientpoint* 를 설정하여 효과를 주는 것이 가능합니다.

```Swift
.fill( 
  RadialGradient(gradient: .init(colors: [Color.white, Color.yellow]), 
							center: .center, startRadius: geometry.size.width * 0.05, endRadius: geometry.size.width * 0.6))
```

<img width="157" alt="스크린샷 2020-10-23 오후 2 40 12" src="https://user-images.githubusercontent.com/48345308/96960561-a9bf3180-153d-11eb-9fb2-7dbd1d640c5a.png">

- 다음 단계로는 아크를 추가해보도록 하겠습니다.

<img width="1179" alt="스크린샷 2020-10-23 오후 2 43 05" src="https://user-images.githubusercontent.com/48345308/96960725-11757c80-153e-11eb-9383-b5d052f58392.png">

- *addArc* 메서드는 원 부분을 추가하며 원의 중심과 그것의 radius를 지정하고 있습니다.
- 완전한 원은 360 입니다. arc는 원의 일부이기 때문에 SwiftUI는 어느 부분을 차지하는지 지정하고 그것을 그려야 합니다.
- 이 코드에서는 각 원의 90도 사이를 스킵합니다. arc가 그려야 하는 방향을 시작과 끝 angle에 지정하고 있습니다. 



### Fixing performance problems 

- 기본적으로 SwifUI의 graphic render는 *CoreGraphics* 를 사용합니다. 
- SwiftUI는 필요할때 마다 각각의 view들을 스크린에 그립니다. 
- 현대 apple 기기 내부의 프로세서와 그래픽 하드웨어는 강력하기 때문에 사용자가 느려지는 것을 보지 않고 처리하는 것이 가능합니다.
- 그러나 어느 순간 시스템의 과부하로 사용자가 알아차릴 정도로 앱이 느려지게 되기도 합니다. 
- 만약 그것이 발생했다면 *drawingGroup()* modifier를 사용할 수 있습니다. 이 modifier는 최종 표시 전에 뷰의 내용을 offscreen 이미지로 결합합니다. 
- 이 offscreen 구성은 애플의 고성능 그래픽 프레임워크인 Metal을 사용하여 복잡한 view를 렌더링하는데 있어 인상적으로 속도를 향상시켰습니다. 
- 많은 수의 gradient, shadow 및 기타 효과를 사용하다보면 성능 문제가 발생할 가능성이 높아집니다. 그럴때는 *drawingGroup()* 을 생각하세요!



<img width="600" alt="스크린샷 2020-10-23 오후 2 51 44" src="https://user-images.githubusercontent.com/48345308/96961303-47673080-153f-11eb-856b-26622d1020de.png">

- *drawingGroup(opaque: colorMode:)* modifier는 view를 렌더링 하기전에 view의 하위 트리를 만들어 납작해지게 만듭니다.
- 이 view의 내용은 단일 비트맵으로 구성되며, 비트맵은 뷰 대신에 표현 됩니다. 



- 비트맵 방식이란 사각형의 픽셀이 모여 만들어진 이미지를 말합니다. 그렇기 때문에 뚜렷하지 않고 확대했을 때 깨지는 현상이 발생할 수 있습니다.



- animation을 무리하게 사용하게 되면 main thread에 너무 많은 작업을 가중 시킵니다. UIView를 직접 이동시키는 애니메이션의 경우에는 view의 이동에 따라 계속해서 그려줘야 하기 때문에 main thread에 부담이 될 수 있습니다. 반면 Core Animation의 경우 다시 그리지 않고 main thread가 아닌 GPU를 이용하여 비트맵 이미지만 변경시키기 때문에 UIView 애니메이션에 비해 부담이 덜합니다.

(즉 drawRect()를 통해 다시 그리지 않고 비트맵 이미지만 변환시킨다.)