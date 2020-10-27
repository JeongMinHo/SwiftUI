

# Chapter 15: Complex Interfaces



- SwiftUI는 새로운 UI 디자인의 패러다임을 대표합니다.
- 그러나 이것은 새롭지만 UIKit, AppKit 또는 대른 프레임워크에서의 발견되는 동일한 기능을 제공하지는 않습니다.
- 하지만 좋은 점은 위의 것들에서 할 수 있는 것은 SwiftUI를 통해 모두 다시 만드는 것이 가능합니다
- SwiftUI는 기존 프레임워크를 기반으로 구축하여 누락된 기능을 추가하도록 확장하는 기능을 제공합니다.
- 이번 탭터에서는 먼저 UIKit view 내에서 SwiftUI의 사용자 정의 control을 추가합니다. 그리고 그리드에 다른 view를 표시할 수 있는 재사용 가능한 뷰를 구축하는 작업을 배웁니다.



### Integrating with other frameworks

- SwiftUI 이전 프레임워크의 복잡한 작업들을 합치고 싶을 것입니다.
- MapKit 등과 같은 이미 만들어진 프레임워크들은 SwiftUI가 똑같이 가지고 있지 않기 때문입니다.
- 이번 섹션에서는 UITableView용으로 작성된 간단한 오픈 소스를 SwiftUI 앱에 통합 시켜볼 것입니다.
- SPM은 아직 지원하지 않고 있기 때문에 메인 프로젝트의 UI 그룹에 이 파일을 복사할 것입니다.
- UIView와 UIViewController를 SwiftUI에서 작업하기 위해서, *UIViewRepresentable* 과 *UIViewControllerRepresentable* 프로토콜을 준수하는 타입을 생성해야 합니다.
- SwiftUI는 이러한 view들의 life cycle을 관리하기 위해 뷰를 생성하고 구성하기만 하면 framework가 알아서 처리할 것입니다.

<img width="541" alt="스크린샷 2020-10-27 오후 1 29 26" src="https://user-images.githubusercontent.com/48345308/97257154-712e9900-1858-11eb-9799-9058572186d2.png">

- *makeUIViewController*()* 메서드를 통해서 view에 보여질 준비를 하게 됩니다. 여기서는 UITableViewController를 프로그래밍적으로 생성하고 리턴하고 있습니다. 
- 다음의 메서드에서는 *updateUIViewController()* 메서드를 통하여 보여지는 view controller를 상황에 맞게 업데이트 합니다.
- UIKit의 *viewDidLoad()* 에서 일반적으로 하는 작업을 이 메서드에서 하게 됩니다.



### Connecting delegates, data sources and more

- iOS의 UITableView와 친숙하다면 UITableViewController의 data source와 delegate는 어떻게 제공하는지 궁금할 수 있습니다.
- 요구되는 데이터를 구조체에 두고 UIKit으로부터 직접적으로 데이터에 접근하게 되면 앱은 충돌이 발생합니다.
- 대신에 *Coordinator* 객체를 *NsObject* 의 클래스로 생성해야 합니다.
- 아래의 클래스는 SwiftUI와 외부 프레임워크의 데이터 사이의 연결을 하는 역할을 합니다.

```Swift
class Coordinator: NSObject {
	var flightData: [FlightInformation]
	
	init(flights: [FlightInformation]) {
		self.flightData = flights
	}
}
```

- 이니셜라이저를 통해 flight 정보를 받아오고 있습니다.
- 이 *Coordinator* 는 UITableView의 델리게이트와 데이터소스에 연결될 수 있게 해줍니다.

```Swift
// Struct FlightTimeline

func makeCoordinator() -> Coordinator {
		Coordinator(flights: flights)
}
```

- 다음과 같은 메서드를 통해 coordinator를 생성하고 필요한 곳에 SiwftUI 프레임워크를 리턴할 수 있습니다.
- Coordinator 클래스에서 *UITableViewDataSource* 와 *UITableViewDelegate* 를 생성하는 것이 가능합니다. 

```Swift
extension Coordinator: UITableViewDataSource { func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	
	flightData.count
	
}
	
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

	let timeFormatter = DateFormatter()
	
	timeFormatter.timeStyle = .short
	timeFormatter.dateStyle = .none
		
	let flight = self.flightData[indexPath.row]
	let scheduledString = timeFormatter.string(from: flight.scheduledTime)
	let currentString = timeFormatter.string(from: flight.currentTime ?? flight.scheduledTime)
	let cell = tableView.dequeueReusableCell( withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell
		
	var flightInfo = "\(flight.airline)\(flight.number)"
	flightInfo = flightInfo + "\(flight.direction == .departure ? "to" : "from")"
	
	flightInfo = flightInfo + " \(flight.otherAirport)"
	flightInfo = flightInfo + " - \(flight.flightStatus)"
		
	cell.descriptionLabel.text = flightInfo
		
	if flight.status == .cancelled {
		cell.titleLabel.text = "Cancelled"
	} else if flight.timeDifference != 0 {
		var title = "\(scheduledString)"
		title = title + " Now: \(currentString)"
		cell.titleLabel.text = title
	} else { cell.titleLabel.text =
		"On Time for \(scheduledString)"
	}
	cell.titleLabel.textColor = UIColor.black
	cell.bubbleColor = flight.timelineColor
	return cell
} }
```

- 그 다음에는 UITableViewDatasource를 UITableView에 설정합니다.

```Swift
uiViewController.tableView.dataSource = context.coordinator
```



```Swift
NavigationLink(destination: FlightTimeline(flights: self.flightInfo)) {
  Text("Flight Timeline")
}
```

- 그리고 ContentView에 다음과 같이 NavigationLink를 생성한다면 아래와 같이 view를 볼 수 있습니다.

![스크린샷 2020-10-27 오후 1 56 14](https://user-images.githubusercontent.com/48345308/97258640-2f9fed00-185c-11eb-9974-f1826ee63b53.png)



### Building reusable views

- SwiftUI는 작은 view들로부터 view들을 구성하게 됩니다.
- 그렇기 때무에 작은 뷰들이 모여서 큰 블럭을 생성하게 되기도 합니다.
- 코드를 깔끔하게 view를 나누는 것이 좋습니다.
- 이것은 여러 앱에서 다양한 장소에서 component를 재사용할 수 있게 해줍니다.

<img width="322" alt="스크린샷 2020-10-27 오후 1 58 11" src="https://user-images.githubusercontent.com/48345308/97258737-755cb580-185c-11eb-9343-e135c11af12c.png">

- 현재 Awards 버튼을 누르면 다음과 같이 스크롤 할 수 있는 뷰가 나옵니다. 이것은 예상할 수 있듯이 SwiftUI의 리스트 입니다.
- UIKit 앱에서는 이와 미슷하게 grid를 생성하기 위해서 UICollectionView를 사용하였습니다. 불행하게도 SiwftUI의 현재 버전에는 이와 동일한 뷰는 없습니다,
- 그렇기 때문에 SwiftUI에서 grid를 생성하여 UICollectionView를 대체하도록 하겠습니다.
- 아래와 같은 파일을 생성하였습니다.

```Swift
import SwiftUI

struct GridView: View {
	
	var items: [Int]
	
    var body: some View {
		ScrollView {
			ForEach(0..<items.count) { index in
				Text("\(self.items[index])")
			}
		}
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
		GridView(items: [11,3,7,17,5,2])
    }
}
```

<img width="280" alt="스크린샷 2020-10-27 오후 2 02 31" src="https://user-images.githubusercontent.com/48345308/97258980-10558f80-185d-11eb-9cbd-f9f1b821eb80.png">



### Displaying a grid

- grid를 조직하기 위해서는 몇 가지 방법이 있으나 가장 흔한 방법은 몇개의 column과 row로 구성하는 것입니다.
- 그리드의 첫번째 item은 첫 번째 row와 첫 번째 section에서 시작합니다. 그리고 row가 멈출때까지 다음 row로 넘어갑니다. 이것을 통해 보여질 아이템들의 마지막에 도달하게 됩니다.
- SwiftUI에서는 VStack을 이용하여 grid를 구성하고 HStack을 이용하여 각각의 row를 구성할 수 있습니다.

```Swift
var columns: Int
	
var numberRows: Int {
  guard items.count > 0 else {
		return 0
	}
		return (items.count - 1) / columns + 1
}
```

- 이 코드는 먼저 array가 element로 구성되어 있는지 체크를 하고 그렇지 않다면 0을 리턴합니다. 그리고는 각각의 column의 요소에 따라 각각의 남은 element들을 계산하게 됩니다.

<img width="855" alt="스크린샷 2020-10-27 오후 2 08 16" src="https://user-images.githubusercontent.com/48345308/97259308-ddf86200-185d-11eb-933c-9c9c2f30a318.png">

```Swift
func elementFor(row: Int, column: Int) -> Int? {
		let index = row * self.columns + column
		return index < items.count ? index : nil
	}
```

- 이 메서드는 row와 column을 이전과 같은 계산으로 수행하게 합니다. 그리고 index가 배열의 유효한 위치에 있는지를 체크합니다. 그렇지 않다면 nil을 리턴하여 가리킵니다. 그렇지 않다면 유효한 index 입니다.



### Using a ViewBuilder

- 현재의 form의 그리드는 Text View 입니다. 우리는 이미지를 가지고도 그리드를 만들어 보려고 합니다.
- 이것은 SwiftUI의 ViewBuilder를 사용하면 각각의 cell에 그리드를 보여주는 것이 훨씬 더 편리할 것입니다.

```Swift
ForEach(0..<items.count) { index in
	Text("\(self.items[index])") 
}
```

- *ForEach* loop를 통해 view에게 전달합니다. ForEach는 ViewBuilder에서 뷰를 위한 파라미터를 생성합니다.

```Swift
struct GridView<Content>: View where Content: View {
  ...
  
  let content: (Int) -> Content
}
```

- 또한 view의 커스텀 이니셜라이저를 아래와 같이 생성합니다.

```Swift
init(columns: Int, items: [Int],
	@ViewBuilder content: @escaping (Int) -> Content) {
	self.columns = columns 
  self.items = items 
  self.content = content
}
```

- 이 새로운 이니셜라이저는 content라는 이름을 가진 enclosure를 받아오고 이것에는 columns과 배열의 갯수에 대한 정보가 있습니다.
- 이것은 또한 Int 파라마티러를 받을 것이라고 정의되어 있습니다.

```Swift
ForEach(0..<self.numberRows) { row in 
	HStack {
		ForEach(0..<self.columns) { column in 
			Group {
        if self.elementFor(row: row, column: column) != nil { 
          self.content(
            self.items[
							self.elementFor(row: row, column: column)!]) } 
        else {
							Spacer() 
        		}
      		} 		
				}
			}
	}
```

![스크린샷 2020-10-27 오후 2 19 37](https://user-images.githubusercontent.com/48345308/97260030-74795300-185f-11eb-9611-090813c9ecab.png)



### Spacing the grid

- 이번 그리드에서 column의 view의 사이즈를 나누고 이것을 *GeomentryReader* 를 통해 view의 사이즈를 받아옵니다.

```Swift
 GeometryReader { geometry in
  ScrollView {

```

- 위와 같이  *GeometryReader* 를 통해 그리드의 columns의 갯수를 가져와 view의 width를 정해줍니다.
- 이것은 결국 columns에 따라 width를 공평하게 부여하는 것이며 view의 frame의 width와 height에 값을 설정해주게 됩니다.

![스크린샷 2020-10-27 오후 2 23 43](https://user-images.githubusercontent.com/48345308/97260307-06815b80-1860-11eb-84d1-7707adeffc56.png)



### Making the grid generic

- 제네릭은 사용하는 데이터의 타입을 특정지을 수 있습니다. 하나의 함수에 각각의 데이터를 사용하는 것이 가능합니다.

```Swift
struct GridView<Content, T>: View where Content: View 
```

- 여기서 struct에서 제네릭 타입을 사용했으며, Int, String 또는 다른 타입을 특정지은 것이 아니라 T로 나타내었습니다.

```Swift
var items: [T]
let content: (T) -> Content
init(columns: Int, itmes: [T], 
    @ViewBuilder content: @escaping (T) -> Content)
```

- 위와 같이 특정 타입을 명시하는 것이 아닌 placeholder의 값이었던 T로 변경해줍니다!



### Using the grid

```Swift
VStack {
		Text("Your Awards (\(activeAwards.count))")
		.font(.title)
		GridView(columns: 2, items: activeAwards) { item in
			VStack {
        item.awardView
				Text(item.title) 
      }.padding(5)
	} 
}
```

![스크린샷 2020-10-27 오후 2 27 37](https://user-images.githubusercontent.com/48345308/97260653-91faec80-1860-11eb-8753-66bef4dd3e02.png)

- 위와 같은 형태의 view를 띄는 것을 확인 할 수 있습니다.
- 이것이 Swift와 제네릭을 이용한 SwiftUI의 힘입니다. 이번 section에서는 기본적인 list와 배열에 각각의 뷰를 집어넣었습니다.
- 그리곡 각각의 배열에 있는 값들을 grid를 통해 grid에 어떻게 보여줄지에 대해서 공부해보았습니다.