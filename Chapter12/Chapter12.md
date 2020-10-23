# Chapter 12: Conditional Views



- 이전 챕터에서는 앱의 view들에서 어떻게 일반적으로 navigation 하는것을 알아봤습니다.
- 하지만 우리는 가끔 특정 조건들에 따라서 사용자에게 view를 보여줭야 할 때가 있습니다.
- 이것은 중요한 메세지를 보여주면서 사용자가 현재 context에서는 접근이 불가하다는 것을 피드백 해야 합니다.
- navigation stack 외부에서 view를 표시하면 사용자가 시작한 task에 집중하는 것이 가능합니다.



### Displaying a modal sheet

- 사용자의 액션에 대한 대답의 정보를 보여주기 위해서 우리는 *modal sheet* 을 사용할 것입니다.
- *modal sheet* 은 현재 view에서 사용자의 집중을 끌기에 상당히 유용합니다.
- 모달은 현재 뷰에서 위로 올라오는 형태입니다. 이것은 뷰 계층에 위치하지 않아도 되기 때문에 *NavigationLinks* 에 감쌀 필요가 없습니다.

```Swift
struct FlightRow: View {
	var flight: FlightInformation

	@State private var isPresented = false
	
	var body: some View {
		HStack {
			Button(action: {
				self.isPresented.toggle()
			}, label: {
				HStack {
					Text("\(flight.airline) \(flight.number)")
						.frame(width: 120, alignment: .leading)
					Text(flight.otherAirport)
						.frame(alignment: .leading)
					Spacer()
					Text(flight.flightStatus).frame(alignment: .trailing)
				}
				.sheet(isPresented: $isPresented, onDismiss: {
					print("Modal dismissed. State: \(self.isPresented)")
				}, content: {
					FlightBoardInformation(flight: self.flight)
				})
			})
		}
	}
}
```

- 코드를 다음과 같이 HStack안에 버튼을 넣고 클릭된다면 *.sheet* modifier를 통해 모달을 띄워주고 있습니다. 그 겨로가 아래와 같이 flight 정보에 대한 내용이 modal로 나타나게 됩니다.

<img width="280" alt="스크린샷 2020-10-23 오전 9 59 10" src="https://user-images.githubusercontent.com/48345308/96944667-68675b80-1516-11eb-8cc3-721f2d0b9c26.png">



### Programmatically dismissing a modal

- 이렇게 모달로 띄우면 navigation view는 사라진 것을 알아차릴 수 있습니다. 왜냐하면 modal sheet가 전체 화면을 장악하고 더 이상 기존에 있던 navigation view에 감싸지 않기 때문입니다.
- 또한 modal을 dismiss 하는 버튼을 추가하는 것 같습니다. 예를 들어 Catalyst앱 같은 몇몇의 플랫폼에서는 swipe gesture를 지원하지 않습니다.

```Swift
@Binding var showModal: Bool

Button("Done", action: {
	self.showModal = false 
})
```

- 위와 같이 modal view를 숨기는 버튼을 추가하였습니다. 그리고 caller에게 이 state를 전달해야 합니다.

``` Swift
// FlightRow.swift

FlightBoardInformation(flight: self.flight, showModal: self.$isPresented)
```

- 위와 같이 수정한다면 

<img width="280" alt="스크린샷 2020-10-23 오전 10 07 32" src="https://user-images.githubusercontent.com/48345308/96945066-94371100-1517-11eb-94e4-d5de0161033e.png">

- 모달 뷰의 오른쪽에 Done 버튼이 생성되고 해당 버튼을 클릭한다면 modal이 dismiss 됩니다.
- Modal은 사용자가 집중을 하게 만들기 위할 때 좋은 선택이 됩니다. 
- 정확하게 사용한다면, 사용자에게 관련된 정보에 집중을 할 수 있게 하고 app의 경험을 높일 수 있습니다.
- 그러나 모달 뷰들은 너무 자주 사용하면 app experience를 막을 수 있습니다.
- SwiftUI는 사용자의 집중을 끌 수 있는 특별한 모달 뷰들이 있습니다. (alert, action sheet, popover)



### Creating an alert

- 문제나 요청에 대한 경고를 알려줄 때 alert는 사용자의 집중을 끌 수 있는 중요한 방법입니다.

```Swift
Button("Rebook Flight") {
					self.rebookAlert = true
				}
				.alert(isPresented: $rebookAlert, content: {
					Alert(title: Text("Contact your Airline"), message: Text("We cannot rebook this flight." + "Please contact the airline to reschedule this flight."))
				})
```

- 다음과 같이 Button을 생성하고 *.alert* modifier를 통해 Alert 창을 만드는 것이 가능합니다.
- 그리고 아래에서는 Alert의 title과 message에 대해서 설정할 수 있습니다.
- 다음과 같이 Alert를 생성하면 아래와 같은 화면을 볼 수 있습니다.

<img width="280" alt="스크린샷 2020-10-23 오전 10 30 00" src="https://user-images.githubusercontent.com/48345308/96946223-b7af8b00-151a-11eb-8384-b4af249f0c76.png">

- SwiftUI에서는 iOS에서 했던 것처럼 *UIAlertViewController* 를 추가할 필요가 없습니다. 그저 특정 작업을 수행하는 modal sheet를 만들면 됩니다.



### Adding an action sheet

- action sheet은 사용자의 액션에 반응하여 생길 수 있습니다. 사용자는 이것이 보여지를 기대할 것입니다.
- 예를 들어서, action sheet를 사용하여 action을 확인하거나 여러 가지 옵션 중에서 선택할 수 있게 합니다.
- 이번 섹션에서는, 사용자가 flight을 체크하고 요청을 확인하는 것을 보여주는 action sheet를 만들 것 입니다.

```Swift
struct CheckInInfo: Identifiable {
	let id = UUID()
	let airline: String
	let flight: String
}
```

- 위와 같이 CheckInInfo를 정의하고 *Identifiable* 프로토콜을 준수했습니다. 이 프로토콜의 요구사항을 맞추기 위해서는 UUID 타입의 *id* 를 포함하고 있어야 합니다.
- *UUID* 는 고유한 값을 제공하고 *Hashable* 프로토콜을 준수하여 고유한 식별자를 제공하는데 좋습니다.

```Swift
if flight.isCheckInAvailable() {
					Button("Check In for Flight") {
						self.checkInFlight = CheckInInfo(airline: self.flight.airline, flight: self.flight.number)
					}
					.actionSheet(item: $checkInFlight) { flight in
						ActionSheet(
							title: Text("Check In"),
							message: Text("Check in for \(flight.airline)" +
											"Flight \(flight.flight)"),
							buttons: [
								.cancel(Text("Not Now")),
								.destructive(Text("Reschedule"), action: { print("Reschedule flight.") }),
								.default(Text("Check In"), action: { print("Check-in for \(flight.airline) \(flight.flight).")
								})
							]
						)
					}
				}
```

- alert와 마찬가지로 Button을 통해서 action sheet를 추가할 수 있게 하였습니다.*actionSheet(isPresented: content:)* 가 아닌  *actionSheet(item:content:)* 를 사용하였습니다. 옵셔널 변수로 *item* 파라미터를 넘겼습니다. variable이 nil이 아닐때 이것은 *button* 의 액션에서 실행될 되며 action sheet에서 보여질 것입니다. 
- SwiftUI가 sheet를 보여줄때, content 파라미터는 포함되어 있는 bindable 변수가 trigger될 것 입니다.
- alert는 제한적인 피드백을 제공합니다. Action sheet에 더 많은 옵션을 주고 싶다면 ActionSheet에 array를 전달하여 버튼으로 추가하여야 합니다.
- 첫번째로 정의된 버튼은 *.cancel* 버튼 입니다. 사용자가 뒤로 가고 싶을 때 이 버튼을 사용하게 됩니다. 이 옵션을 사용자가 선택했을 떄는 아무것도 안해도 되기 때문에 이 버튼에는 어떠한 파라미터도 필요가 없습니다.
- *.destructive* 의 경우에는 위험한 결과를 가질 때 사용합니다. SwiftUI는 이 액션에 대한 심각성을 빨간색으로 하이라이트 된 Text를 통해서 보여줍니다. 
- *.default* 버튼의 경우에는 action: 을 사용하여 debug console에 메세지를 보여주는 것 등을 할 수 있습니다.

![스크린샷 2020-10-23 오전 10 51 37](https://user-images.githubusercontent.com/48345308/96947290-bd5aa000-151d-11eb-8b0a-276abd5f423e.png)



### Showing a popover

- action sheet와 마찬가지로 *popover* 는 사용자의 액션에 따른 응답으로 보여줍니다.
- *Popover* 는 iPad나 Mac 처럼 디바이스의 크기가 큰 것이 때 효과가 있습니다. 디바이스 크기가 작을때는 modal sheet와 같이 전체 화면에 보여집니다.
- SwitUI는 스크린이 너무 작다면 popover를 modal sheet로 대체하여 render 합니다.
- popover는 state를 저장하고 이것이 보여질때 즉시 변화하는 것이 가능합니다 왜냐하면 사용자는 이것을 언제든지 dismiss 할 수 있기 때문입니다.
- popover를 만들고 사용하는 것은 alert와 action sheet와 비슷합니다.

<img width="568" alt="스크린샷 2020-10-23 오전 11 12 20" src="https://user-images.githubusercontent.com/48345308/96948443-a1a4c900-1520-11eb-9047-c4b6579cbb63.png">

- 다음과 같이 popover를 생성해줍니다. 
- popover는 전통적으로 popover를 시작한 control이 가리키는 방향을 보여줍니다. *.arrowEdge* 는 화살표의 방향을 정의하게 됩니다.
- 여기에서 설정된 *.top* 은 popover sheet가 control을 가리키도록 맨 위에 화살표를 표시하도록 지시합니다. 즉 popover control이 아래에 표시된다는 것을 의미합니다.(??)



- iPad를 target으로 빌드를 하겠습니다. SiwftUI는 iPad에서 split view를 default로 제공합니다. 
- iPad로 보면 pop-up 된 것이 작은 arrow를 가지며 탭한 버튼을 향해서 가리키고 있는 것입니다.

<img width="383" alt="스크린샷 2020-10-23 오전 11 18 15" src="https://user-images.githubusercontent.com/48345308/96948825-740c4f80-1521-11eb-8bc3-eaefaf9a5375.png">



### Key points

- modal sheet는 view의 맨 위에서 보여집니다. *Identifiable* 프로토콜을 준수하는 Bool state variable 또는 optional state variable을 통해서 SwiftUI에게 이것을 보여줘야 할지 말아야 할지 결정합니다.
- action sheet와 popover views는 사용자에게 정보를 제공하고 피드백을 수집하는 가장 일반적인 방법입니다.
- Alerts는 보통 예상하지 못한 상황이나 심한 결과를 초래할 때 사용자에게 정보를 주기 위해 사용합니다
- Action sheet나 popover는 사용자의 액션에 대한 응답을 보여줍니다. Action sheet는 작은 스크린에서 사용하며, popover는 큰 스크린에서 많이 사용합니다.



