# Chapter 11: Lists & Navigation



- 하나의 view로만 이루어진 앱은 거의 없습니다. 대부분의 앱은 여러 뷰들이 부드럽게 왔다갔다 하는 방식을 택하고 있습니다.
- view들 사이에서 움직이면서 쉬운 방법으로 사용자에게 데이터를 논리적으로 제공해야 합니다.
- SwiftUI는 네비게이션을 관리하면서 데이터를 표시하는 통합된 인터페이스를 제공합니다.



### Navigation through a SwiftUI app

- SwiftUI 앱의 네비게이션을 디자인할 때는 사용자가 앱을 통해 자신있고 직관적으로 작업을 수행할 수 있도록 도와주는 네비게이션 패턴을 만들어야 합니다.

- SwiftUI는 *cross-flatform* 프레임워크이지만 iOS와 iPadOS로 부터 영감받아 디자인 되었습니다. 그러므로 SwiftUI는 이러한 플랫폼들에서 공통적으로 사용되는 패턴과 가이드라인을 통합했습니다.

- SwiftUI는 2가지의 네키게이션 스타일이 존재합니다

  1) **flat**

  2) **hierarchical**

- TabView에서 우리는 flat한 계층 구조를 사용했습니다. flat navigation  구조는 사용자가 카테고리나 뷰들 사이에서 움직일 때 효율적입니다. view 레이아웃은 많은 top-level의 뷰들로 구성이 되고 깊이가 거의 없습니다.

![스크린샷 2020-10-22 오후 10 16 43](https://user-images.githubusercontent.com/48345308/96877165-463cf180-14b4-11eb-9879-f7e65d0354e2.png)

- 너무 많은 카테고리나 알아볼 수 없는 카테고리들은 사용자를 힘들게 합니다.
- *Hierarchical navigation*은 사용자에게 더 적은 선택사항을 제공하고 더 깊은 하단 구조를 제공합니다.
- SwiftUI에서는 이를 사용하기 위해 **NavigationView** 를 사용합니다. flat layout가 비교해서 계층 레이아웃은 top - level view가 적고 더 깊은 스택의 view들을 포함하고 있습니다.
- 계층적인 네비게이션은 횡방향으로의 전환이 거의 필요없고 보다 구체적인 정보로 이동하는 view stack일 때 사용하는 것이 좋습니다.

![스크린샷 2020-10-22 오후 10 19 42](https://user-images.githubusercontent.com/48345308/96877500-b0ee2d00-14b4-11eb-8fc6-17ac28696775.png)



### Creating navigation views

<img width="1094" alt="스크린샷 2020-10-22 오후 10 22 48" src="https://user-images.githubusercontent.com/48345308/96877842-1e9a5900-14b5-11eb-9dcf-7096a8d8ec37.png">

- 전에도 했듯이 다음과 같이 탭바를 생성하였습니다.
  1. TabView control을 사용해서 tab view를 생성했습니다.
  2. TabView에 포함하여 view들을 제공합니다. 각 view들은 tab의 content가 되고 modifier를 통해 이 tab에 정보를 정의하는 것이 가능합니다.
  3. *.tabItem()* 메서드를 통해서 각 탭에 image, text의 조합을 설정했습니다.
  4. 각각의 탭은 system image와 text label을 보여줍니다. text view의 tab label에는 Image혹은 Text만 가능합니다.
- 두 개의 tab 이미지가 같기 떄문에 구분하기가 어렵습니다. 이를 해결하기 위하여 Text를 통해 각각의 view를 구분하였습니다.
- 많은 앱들은 tab view에 의해 제공되어지는 *flat navigation* 스타일을 효과적으로 사용합니다.



### Using navigation views

- navigation view는 stack에 많은 view들이 정렬되어 있고, 한 view에서 다른 것으로 전환하는 것이 가능합니다. 각 view에서 사용자들은 stack에 있는 새로운 view로 이어지는 선택을 하게 됩니다.
- stack의 뒤로 가는 것이 가능하지만 jump 하는 것은 불가능합니다. 
- 큰 스크린의 디바이스에서, SwiftUI는 split-view 인터페이스를 제공하여 앱의 주요 view를 별도의 창으로 구분합니다.

![스크린샷 2020-10-23 오전 1 13 29](https://user-images.githubusercontent.com/48345308/96900362-f880b300-14cc-11eb-9772-b59bcad26211.png)

1. NavigationView를 view들의 stack에 가장 먼저 정의하고 네비게이션 계층 구조를 보여주었습니다. 여리서 우리는 두개의 옵션을 통해서 사용자가 각각의 item을 선택할 수 있게 하였습니다. navigation view는 또한 toolbar와 이러한 view들이 다시 뒤로 돌아갈 수 있는 link를 제공합니다. (UINavigationController와 비슷)
2. NavigationLink 구조체는 버튼을 통해 navigation stack에 더 깊게 들어갈 수 있도록 하였습니다. *destination* 파라미터는 사용자가 버튼을 클릭하였을 때 다음 단계의 viw stack의 view가 무엇인지를 알려줍니다.
3. NavigationLink에 포함되어 view는 link를 보여줍니다. 
4. *navigationBarTitle(_:)* 메소드를 사용하여 우리는 NavigationView의 위에 link를 보여줍니다.



- NavigationView가 아닌 ZStack에 *navigationBarTitle(_:)* 을 호출하는 것은 이상하게 보일 수 있습니다. 그러나 이것은 view들의 계층 구조를 정의하는 것이기 때문입니다. view의 title은 view stack에서 이동될때 바뀌기 때문입니다.

- iPhone과 Apple TV에서 SwiftUI는 디폴트로 navigation stack을 사용합니다. 큰 iPhone, iPad, Mac에서 Apple은 styled navigation의 split-view를 기본으로 사용합니다.



### Displaying a list of data

![스크린샷 2020-10-23 오전 1 22 38](https://user-images.githubusercontent.com/48345308/96901452-3f22dd00-14ce-11eb-855c-746a36c23ab8.png)

- 위처럼 FlightBoard.swift 파일을 수정합니다.
- 우리는 이전에 만들었던 navigation link에 이것을 업데이트 해야합니다.

```Swift
NavigationLink(destination: FlightBoard(
		boardName: "Arrivals", flightData: self.flightInfo.arrivals())) {
						Text("Arrivals")
}
NavigationLink(destination: FlightBoard(
	boardName: "Departures", flightData: self.flightInfo.departures())) {
						Text("Departures")
```

- 사용자가 버튼을 클릭해서 view들이 전환될 때 2개의 파라미터를 추가하였습니다. 
- SwiftUI에서 *ForEach* 의 data를 통해서 loop를 도는 것이 가능합니다.

![스크린샷 2020-10-23 오전 1 29 57](https://user-images.githubusercontent.com/48345308/96902266-44ccf280-14cf-11eb-98c0-82878097cf91.png)

- 다음과 같이 *ForEach* 를 사용하여 전달된 data를 순회하고 클로저는 각각의 element를 호추하여 현재 element를 전달해줍니다. 클로저 안에서 view에 보여질 element를 정의합니다.
- 여기서 Text는 flight airline과 숫자를 보여줍니다.



### Making your data more compatible with iteration

- *forEach*를 통해서 전달받은 데이터는 배열의 각 요소를 고유하게 식별할 수 있는 방법을 제공합니다.
- 이 순회에서는 *id* 파라미터를 이용하며, SwifUI는 *\.id* 프로퍼티를 사용하여 배열의 각각의 요소에 고유한 식별자가 됩니다.
- 고유한 식별자를 위해 요구되는 것은 *Hashable* 프로토콜을 준수해야 한다는 것입니다. 
- 만약에 class가 Hashable 하다면 전체 객체를 고유한 식별자로 사용하는 것이 가능합니다. 그렇다면 id 파라미터로 \.self 를 전달하는 것이 가능해집니다.
- Swift 5.1에서 새로 나온 이 **Identifiable** 프로토콜은 SwiftUI가 각각의 데이터에 고유한 식별자를 어떻게 정할지를 알려줍니다. 이 프로토콜의 유일한 조건은 Hashable을 준수하는 *id* 라는 프로퍼티를 갖는것입니다.
- FlightInformation 클래스가 *Identifiable* 프로토콜을 준수한다면 ForEach에서 id를 생략하는 것이 가능합니다!



### Showing scrolling data

```Swift
var body: some View {
		VStack {
			Text(boardName)
				.font(.title)
			ForEach(flightData) {
				flight in
				VStack {
					Text("\(flight.airline) \(flight.number)")
					Text("\(flight.flightStatus) at \(flight.currentTimeString)")
					Text("At gate \(flight.gate)")
				}
			}
		}
	}
```

<img width="286" alt="스크린샷 2020-10-23 오전 1 48 25" src="https://user-images.githubusercontent.com/48345308/96904266-d89fbe00-14d1-11eb-977a-49a1e905573e.png">

- 위와 같이 Text를 나타내면 스크린에 넘어서게 되고 스크린의 넘어선 Text들은 볼 수가 없습니다.
- 첫 번째로는 *ScrollView* 를 사용하는 것입니다. 

<img width="286" alt="스크린샷 2020-10-23 오전 1 51 46" src="https://user-images.githubusercontent.com/48345308/96904610-506de880-14d2-11eb-8ddf-4b7ddaa98393.png">

- ScrollView를 포함하면 다음과 같이 아래의 Text를 보기 위해서 스크롤을 내리면 됩니다.
- SwiftUI는 VStack으로 묶여 있기 떄문에 이것은 수직 스크롤만 지원합니다. 만약에 Text가 view의 width를 넘어가면 보이지 않게 됩니다. 이것을 해결하기 위하여 *ScrollView* 의 원하는 축을  전달하여 양방향에서 모두 스크롤할 수 있게 됩니다.

```Swift
ScrollView([.horizontal, .vertical])
```

- 위와 같이 스크롤 뷰에게 스크롤 할 방향을 알려주는 것이 가능합니다.



### Creating lists

- 데이터를 통해서 반복해서 사용자에게 표시하는 것은 일반적인 작업이기 때문에 모든 플랫폼들은 이러한 작업을 위한 control이 내장되어 있습니다.
- SwiftUI는 *List* 구조체를 제공하고 *ForEach* 는 이것을 더 사용하기 쉽게 만들어 줍니다.
- *List* 를 사용하면 한 column에 정렬된 데이터를 표시합니다.

![스크린샷 2020-10-23 오전 1 59 16](https://user-images.githubusercontent.com/48345308/96905398-5ca67580-14d3-11eb-998e-476a6a88c42f.png)

- 이렇게 *List* 를 사용한다면 자동으로 스크롤을 제공합니다. iOS에서 UITableView를 사용해 본적이 있다면 이것은 훨씬 덜한 노력으로 SwiftUI에서 같은 결과로 생성됩니다. 

```Swift
NavigationView {
				List(flightData) {
					flight in
					Text("\(flight.airline) \(flight.number)")
				}
			}
```

- 다음과 같이 NavigationView로 묶는다면 아래와 같은 View를 볼 수 있습니다.

<img width="250" alt="스크린샷 2020-10-23 오전 2 21 43" src="https://user-images.githubusercontent.com/48345308/96907669-7f865900-14d6-11eb-8c68-f9f5ff702324.png">

- 하지만 2개의 backlink가 생기기 때문에 이는 navigation view의 개념과 맞지 않습니다. 따라서 navigation을 실행하기 전에 flight board에 대한 정보를 조금 더 추가해야 합니다. 따라서 아래와 같이 *navigationBarTitle* 에 대한 정보를 추가해야 합니다.

```Swift
.navigationBarTitle(boardName)
```



### Adding navigation links

![스크린샷 2020-10-23 오전 2 27 23](https://user-images.githubusercontent.com/48345308/96908231-4a2e3b00-14d7-11eb-81a9-778baab58799.png)

- 위와 같이 Flight에 대한 정보를 보여주는 FlightBoardInformation view를 추가하였습니다.



```Swift
// FlightRow.swift

struct FlightRow: View {
	
	var flight: FlightInformation
	
	var body: some View {
		HStack {
			Text("\(self.flight.airline) \(self.flight.number)")
				.frame(width: 120, alignment: .leading)
			Text(self.flight.otherAirport)
					.frame(alignment: .leading)
			Spacer()
			Text(self.flight.flightStatus) .frame(alignment: .trailing)
		}
	}
}

struct FlightRow_Previews: PreviewProvider {
	static var previews: some View {
		FlightRow(flight: FlightInformation.generateFlight(0))
	}
}
```

- 위와 같이 FlightRow.swift 파일을 생성하여 각각의 row는 도시와 flight의 정보를 보여주는 역할을 합니다.

```Swift
List(flightData) { flight in
  NavigationLink(destination: FlightBoardInformation(flight: flight)) {
    FlightRow(flight: flight)
  }
} .navigationBarTitle(boardName)
```

- 다음과 같이 FlightBoard.swift 파일을 수정하면 NavigationLink에 의해서 각 row에 따른 flight 정보로 넘어가는 view를 보는 것이 가능합니다. 따라서 아래와 같은 형태를 띄게 됩니다.

<img width="280" alt="스크린샷 2020-10-23 오전 2 36 47" src="https://user-images.githubusercontent.com/48345308/96909154-99c13680-14d8-11eb-810c-3f8bf96d4dca.png">



### Adding items to the navigation bar

- navigation view stack의 각각의 뷰들은 navigation bar를 가집니다.
- 일반적으로 navigation bar는 이전의 view로 돌아갈 수 있는 link를 가집니다. 
- 원한다면 navigation bar에 item을 추가하는 것이 가능합니다.

```Swift
// FlightBoard.swift

@State private var hideCanceled = false
```

- 이 변수를 cancelled된 flight을 숨기는데에 사용될 것입니다. 이제 flights을 필터링하고 state variable을 업데이트하는 computed property를 생성합니다.

```Swift
var shownFlights: [FlightInformation] {
		hideCanceled ? flightData.filter { $0.status != .cancelled } : flightData
}
```

- 이러한 변화로 인해 *hideCancelled* state 변수는 필터링 된 새로운 list를 사용할 수 있게 됩니다.

```Swift
.navigationBarItems(trailing: Toggle(isOn: $hideCancelled, label: {
    Text("Hide Cancelled")
  })
)
```

- *navigationBarItems(trailing:)* 메서드는 navigation. bar의 trailing edge에 버튼을 추가합니다.
- toggle은 *hideCancelled* binding을 toggle 합니다. 이 state 변수를 사용하여 SwiftUI는 값이 바뀔때마다 refresh하고 업데이트 할 수 있습니다.



### Key points

- App navigation은 일반적으로 뷰들에서 flat과 hierarchical한 구조를 합친 형태입니다.
- Tab view들은 flat navigation으로 보여주어 뷰들 사이에 빠른 전환이 가능하게 합니다.
- Navigation view들은 view stack 사이의 계층 구조를 생성하고. 이 Stack을 사용해서 사용자는 돌아가거나 앞으로 가거나 하는 것이 가능합니다.
- navigation link는 뷰와 view stack 사이에 연결을 해줍니다.
- View stack에는 하나의 NavigationView만을 가져야 합니다. 
- naviagion view stack을 control에 의해서 변화하여 적용하는 것이 가능합니다.
- *ScrollView* 는 view들의 section을 묶어서 스크롤할 수 있고 그 나머지 view에는 영향을 끼치지 않습니다.
- SwiftUI는 *ForEach* 옵션의 경우 data를 받아와 각각의 element들을 view에 렌더링하는 것을 가능하게 합니다.
- *List* 는 데이터의 요소들을 리스트 형식으로 보여주는데에 사용합니다.
- *List* 와 *ForEach* 를 사용하여 데이터는 각각의 element에 고유한 식별자를 제공합니다. 이를 위해서는 *Hashable* 프로토콜을 사용하여 각각의 어트리뷰트를 특정해야 하며 object는 Hashable한 데이터를 받아오고 *Identifiable* 프로토콜을 준수해야 합니다.