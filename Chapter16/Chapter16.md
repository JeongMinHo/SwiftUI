# Chapter 16: Testing & Debugging



- 앱에 테스트를 추가하는 것은 앱이 원하는 대로 작동하는지 확인 할 수 있는 기본 제공 및 자동화된 방법을 제공합니다.
- 테스트는 코드가 잘 작동하는지를 체크할 뿐만 아니라 원하는 대로 흘러가는지 확인하고 미래의 변화가 기존의 기능을 파괴하지 않을 것을 보장합니다.



### Different types of tests

- 앱에서는 테스트 할 수 있는 방법이 3가지가 존재합니다.
- 복잡성이 올라갈 수록 *unit tests*, *integration tests*, *user interface tests* 순으로 존재합니다.
- 다른 모든 테스트의 기본이 되는 것은 *unit test* 입니다. 각각의 *unit test* 는 함수가 주어진 입력을 처리할 때 예상되는 출력을 얻을 수 있도록 보장합니다. unit test는 실행하는데 milliseconds 밖에 소요되지 않습니다. 
- 다음 테스팅의 계층은 *integration test* 입니다. *Intergation Test* 는 나의 코드가 다른 것들과 잘 작동하는지에 대해서 검증하며 외부 API와 같이 앱 외부의 세계와 얼마나 잘 연동되는지를 확인할 수 있습니다.
  - *integration test*는 *unit test* 보다 복잡하며 결과까지의 시간이 더 오래 걸리며 덜 사용합니다.
- 가장 복잡한 테스는 *UI Test* 라고도 하는 *User Interface test* 입니다. 이것은 사용자가 앱에 직면하는 행동들을 확인합니다.
- UI Test는 앱과의 상호 작용을 시뮬레이션하고 상호 작용에 응답한 후 사용자 인터페이스가 예상되로 잘 동작하는지를 검증합니다. 테스팅 계층 구조를 따라서 테스트를 하는 항복들은 점점 더 넓어지게 됩니다.
- 예를 들어서 unit test에서 *calculateTotal()* 메서드가 알맞은 값을 리턴하는지 확인한다면 *integration test*는 앱이 item들의 순서에 맞게 정확하게 들어가는지에 대해 검증합니다. *UI test* 는 order에 item을 추가하고 사용자의 화면에 맞는 값을 보여지는지에 대해 체크하게 됩니다.
- SwiftUI는 새로운 시각적인 프레임워크이므로, 이번 챕터에서는 Swift를 위한 *UI Test* 작성 방법에 초점을 맞춰서 배우도록 하겠습니다.



### Debugging SwiftUI apps

- 이 프로젝트는 간단한 계산기 입니다.
- 이 앱은 Catalyst를 지원하기 때문에 Mac, iPadOS, iOS에서 모두 지원합니다.
- SwiftUI를 디버깅하는 것은 인터페이스 코드와 SwiftUI 패러다임이 함께 혼합되기 때문에 대부분의 테스트보다 약간 더 많은 고려와 계획을 필요로 합니다.
- SwiftUI는 코드로 이루어져 있기 때문에 다른 코드들과 비슷하게 실행됩니다.

```Swift
Button(action: {
						if let val = Double(self.display) {
							self.memory = self.memory + val
							self.display = ""
							self.pendingOperation = .none
						} else {
							// Add Bug Fix Here
							self.display = "Error"
						}
					}) {
						Text("M+")
							.frame(width: 45, height: 45)
							.addButtonBorder(Color.gray)
					}
```

- 위의 코드는 유저 인터페이스의 버튼을 정의합니다. 첫 번째 블럭은 사용자가 버튼을 눌렀을 때의 액션을 정의합니다. 다음 블럭은 버튼이 view에서 어떻게 보일지를 정의합니다.
- 두 코드는 인접해있지만 항상 동시에 실행되는 것은 아닙니다.



### Setting breakpoints

- 앱을 실행하는 동안 코드를 중지하기 위해서는 디버거가 특정 라인의 코드에 도달하면 코드 실행을 중지할 수 있도록 *breakpoint* 를 설정해야 합니다.
- 그런 다음 변수를 검사하고 코드를 통과하면서 코드의 다른 요소를 검사하는 것이 가능합니다.
- 브레이크 포인트를 설정하기 위해서는 **Debug -> Breakpoints -> Add breakpoint at Current Line** 순서로 클릭하거나 break point를 설정하기 원하는 라인의 마진을 클릭하면 됩니다. (코드 라인의 숫자가 적혀 있는 곳)
- 아래와 같이 break point를 걸 수 있습니다.

![스크린샷 2020-10-27 오전 12 50 22](https://user-images.githubusercontent.com/48345308/97195198-663f1e80-17ee-11eb-8ad8-d0373d4e753e.png)

- 시뮬레이터에서 디버그 모드를 사용할 수 있지만 preview에서도 가능합니다. Xcode가 업데이트 되어서 책과 다르게 play 버튼을 우 클릭하면 아래와 같이 debug preview를 선택하는 것이 가능합니다.

![스크린샷 2020-10-27 오전 1 06 43](https://user-images.githubusercontent.com/48345308/97197189-aef7d700-17f0-11eb-988e-9bdf8fa3edd1.png)

- 앱이 실행되다가 break point에 도달하게 되면 앱은 멈추고 Xcode는 우리가 컨트롤 할 수 있게 합니다. 

![스크린샷 2020-10-27 오전 1 08 38](https://user-images.githubusercontent.com/48345308/97197382-f3837280-17f0-11eb-96b9-da826feac3f7.png)

- 그리고 위와 같이 *debug area* 가 나타나게 됩니다. debug area가 보이지 않는다면 **View -> Debug Area -> Show Debug area** 혹은 **Shift + Command + Y** 를 누르면 됩니다.

- debug area의 왼쪽 부분은 변수 뷰를 포함합니다. 이것은 현재 실행되고 있는 앱의 활성화된 변수의 status와 값을 보여줍니다.
- 오른쪽 부분은 상호작용 할 수 있는 콘솔이며 Xcode의 복잡하지만 강력한 디버깅을 할 수 있는 부분입니다. (간단하게 lldb에 대해 설명하자면 Xcode의 기본 컴파일러는 LLVM을 채택하였는데 LLVM에서 지원하는 디버거가 lldb이다.)
- break point를 사용하는 것은 코드를 중단 할 뿐만 아니라 해당 코드가 실행 됐는지를 확인 할 수 있는 방법입니다. (저 또한 예를 들어 원하는 메서드등이 실행 됐는지를 체크하고 싶을 때 브레이크 포인트를 걸고는 합니다.)
- 코드와 SwiftUI의 UI 요소들이 합쳐진 것은 복잡할 수 있지만 breakpoint는 이것이 실행됐는지 혹은 언제 실행됐는지를 알 수 있게 해줍니다. 



### Exploring breakpoint control

- 브레이크 포인트를 멈출 때, 코드 에디터와 debug area 사이의 아래와 같은 툴바를 볼 수 있습니다.

![스크린샷 2020-10-27 오전 1 16 39](https://user-images.githubusercontent.com/48345308/97198380-119da280-17f2-11eb-9d55-9909e10219c4.png)

- 첫 번째 버튼의 경우 debug area를 보일지 말지를 토글 하는 버튼입니다.
- 두 번째 버튼의 경우 모든 breakpoint를 삭제할지 말지를 결정하는 버튼입니다.
- 세번째 버튼은 앱을 계속해서 실행하게 해주는 버튼입니다.
- 그 이후 3개의 버튼들은 코드에서 다음으로 넘어갈 수 있게 해주는 버튼입니다.
  1. 첫 번째 버튼은 현재 라인의 코드의 어떤 메서드나 함수의 호출을 실행 시킵니다.
  2. 두 번째 버튼은 현재 라인의 코드를 실행하나 메서드의 호출이 있다면 그 메소드나 함수의 내부의 첫 번째 코드에서 일시 정지합니다.
  3. 마지막 버튼은 현재 메소드나 함수의 마지막까지 실행을 하게 됩니다.

![image](https://user-images.githubusercontent.com/48345308/97199925-eddb5c00-17f3-11eb-8c55-819e59daad08.png)

- 위와 같이 memory의 값을 확인 하면 현재 0.0인 것을 알 수 있습니다.



### Adding UI tests

- 이 코드를 실행하다 보면 버그가 있다는 것을 알 수 있습니다. 디스플레이의 기본값은 빈 문자열이며, 디스플레이는 빈 문자열을 0으로 변환합니다.
- 그러나, **M+** 버튼의 코드는 빈 string 값을 double로 변환하려고 합니다. 이 변환이 실패한다면 사용자는 에러 값을 보게 될 것입니다. (숫자를 입력하지 않고 M+ 버튼을 클릭했을 때의 상황)
- 모든 앱의 상황 마다 테스트를 쓰지는 않지만, 버그를 찾았을 때는 test를 생성하는 것이 효율적인 방법입니다. 
- 테스트를 생성하는 것은 사실 버그를 고치는 것을 보장합니다. 

![스크린샷 2020-10-27 오전 1 36 04](https://user-images.githubusercontent.com/48345308/97200613-c89b1d80-17f4-11eb-898b-85da8443c413.png)

- UI 테스트를 하기 위해서는 **File -> New -> Target -> iOS** 에서 **UI Testing Bundle** 을 선택하고 생성합니다.
- 생성을 하고 나면 아래와 같은 파일이 생성됩니다.

```Swift
import XCTest

class SwiftCalcUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {

            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

```

- 이 파일을 보면 **XCTest** 프레임워크를 import 하고 있으며 이것은 애플의 default 테스팅 라이브러리를 포함하고 있습니다. 
- 또한 이 클래스는 모든 테스트 클래스가 동작하는 **XCTestCase** 를 상속하고 있습니다.
- 위에서 보시면 4개의 default 메소드가 제공되는 것을 알 수 있습니다. 처음 두 메소드 같은 경우에는 테스트의 과정에서 중요한 역할을 하는 메서드입니다.
- 테스트 과정에서 각각의 클래스의 test method 마다 *setUpWithError()* 메서드가 호출되며 그 이후 test method가 완료 될 때마다 *tearDownWithError()* 가 호출됩니다.
- 테스트는 입력 집합이 예상되는 출력 집합의 결과를 초래하는지 검증하는 것입니다.
  - *setUpWithError()* 메서드는 각각의 테스트 메소드가 실행되기 전의 state를 보장하며 *tearDownWithError()* 메서드를 통해 알려진 시작 조건으로 돌아가도록 사용해야 합니다.

```
 override func setUpWithError() throws {
        continueAfterFailure = false
}
```

- 위의 라인은 실패가 발생하면 testing을 멈춥니다. 이 값을 false로 설정하여 첫 번째 실패 이후에 test 과정을 멈추게 합니다.
- UI 테스트의 특성상 테스트가 실패하면 거의 항상 알 수 없는 상태가 됩니다. 부정확한 정보에 대해 장기간 실행되는 테스트를 계속하기 보다는 테스트를 멈추고 수정하기 위해 사용됩니다.
- 세번째로 있는 *testExample()* 메서드는 sample 테스트를 포함합니다. 이 메서드를 보면 옆에 작은 회색 다이아몬드 모양이 있습니다. 이는 Xcode가 이것은 테스트라는 것을 인지 합니다. 하지만 테스트는 아직 실행되지 않은 상태입니다.
  - 테스트가 실행되고 성공하면 이것은 초록색 체크 표시로 바뀌고 실패 한다면 빨간색 배경의 X 표시가 됩니다.
- 테스트의 명명은 만드시 앞에 *test* 로 시작해야 합니다. 그렇지 않으면 프레임워크는 메서드를 무시하고 실행할 때 테스트 하지 않습니다.
- 아래와 같이 앞에 test를 붙이지 않으면 다이아몬드 모양이 표시되지 않는 것을 볼 수 있습니다.

![스크린샷 2020-10-27 오전 2 00 01](https://user-images.githubusercontent.com/48345308/97203415-21b88080-17f8-11eb-9e34-d761d48e67d5.png)



### Creating a UI Test

- 테스트의 명확한 명명을 하는 것은 많은 종류의 테스트 중에서 어떤 것이 실패했는지를 아는데에 좋습니다.

- 테스트의 명명은 테스트를 하는 대상, 테스트의 환경 또는 결과가 어떻게 되야 할지를 명시해야 합니다.

- UI test는 앱이 이제 막 시작된 상태에서 시작하므로, 앱이 방금 시작된 상태의 각 테스트를 작성하는 것이 가능합니다.

  - 하지만 각각의 실행 마다 앱이 초기화 되는 것은 아닙니다.
  - 이런 경우에는 위에서 보았던 *setUpWithError()* 혹은 *tearDownWithError()* 메서드를 사용하여 각 테스트 전에 앱이 알려진 특정 상태에 있는지 확인하고 변경된 사항을 다시 clear하는 것이 가능합니다.
  - 예를 들어 데이터, 설정, 위치 지역이나 정보들을 테스트가 실행될 떄 정해줘야 한다면 여기서 설정하면 됩니다.

- UI test를 시작하기 위한 몇가지 방법이 존재합니다.

  1) Command - 6의 *Test Navigator* 로 갑니다. 아래와 같이 test navigator로 가면 버튼을 클릭하여 테스트를 실행하는 것이 가능합니다. 클래스 이름이나 테스트 프레임워크 오른쪽 위에 마우스를 올려 놓으면 순서대로 실행할 테스트 그룹을 실행할 수 있는 버튼이 나옵니다!

  ![스크린샷 2020-10-27 오전 2 07 47](https://user-images.githubusercontent.com/48345308/97204251-377a7580-17f9-11eb-953c-d7c7e08eb562.png)

  

  - 지금은 아무것도 테스트하지 않기 때문에 완료되지 않습니다. 이것을 어떻게 실행하고 어떻게 실행되는지에 배워보도록 하겠습니다.
  - Test는 Swift 코드이기 때문에 app을 디버그 하는 것처럼 test를 디버그 하는 것이 가능합니다.
  - 때때로 Test가 예상대로 작동되지 않는 이유를 알아야 합니다.
  - 앱을 싱행하고 나면 lldb prompt의 콘솔에 *po app* 을 입력합니다. 그렇다면 아래와 같이 콘솔에 뜨는 것을 확인할 수 있습니다.

  <img width="560" alt="스크린샷 2020-10-27 오전 2 17 06" src="https://user-images.githubusercontent.com/48345308/97205223-84128080-17fa-11eb-99d1-dd45cf424143.png">

- ***po*** 명령어를 사용하면 객체의 상태를 검사하는 것이 가능하며 위의 경우에는 *XCUIElement* 의 하위 클래스인 *XCUIApplication* 으로 선언한 앱 객체를 검사하는 것입니다.

- 이것을 사용하여 UI Test에서 각 객체를 검사할 수 있습니다.

- 앱의 객체는 어플리케이션에서 시작하여 앱의 모든 UI 요소를 통해 이어지는 트리를 포함하고 이 요소들은 각각 *XCUIElemnt* 타입이기도 합니다.



### Accessing UI elements

```Swift
func testPressMemoryPlusAtAppStartShowZeroInDisplay() throws {
       
    let app = XCUIApplication()
    app.launch()

		let memoryButton = app.buttons["M+"]
		memoryButton.tap()
}
```

- *XCUIApplication* 은 User Interface 타입의 각각의 객체 요소를 포함하고 있습니다. 
- 이 쿼리는 먼저 button의 요소만 필터링하고 그런 다음 "M+" 라벨을 가지고 있는 element로 필터링합니다.
- SwiftUI 버튼은 iOS에서는 UIButton이 되며 macOS에서는 NSBUtton이 되는 것처럼 각각의 element를 플랫폼에 따라서 새로운 방식으로 정의해 제공합니다.
- button 객체를 가지고 있다면 *tap()* 메서드를 호출할 때 버튼을 탭 하는 것과 같은 형태를 띕니다.



### Reading the user interface

- 우리는 "M+" 라벨을 자기고 있는 버튼을 찾을 수 있습니다. 그러나 이것은 앱의 상태에 따라 control의 텍스트가 변경되기 때문에 디스플레이는 작동하지 않습니다.
- 그러나 테스트 내에서 쉽게 찾을 수 있도록 인터페이스 element에 attribute를 추가하는 것이 가능합니다.

![스크린샷 2020-10-27 오전 2 30 46](https://user-images.githubusercontent.com/48345308/97206708-6cd49280-17fc-11eb-96ea-75028b42be44.png)

- 다음과 같이 Text의 아래에 *.accessibility(identifier: "display")* 를 추가하였습니다.

  - 이 메서드는 UI element 결과의 접근성을 설정합니다. 이는 단순히 UI element의 test를 위한 상수 label을 제공하게 됩니다.
  - 만약 이 식별자를 제공하지 않는다면, 일반적으로 "M+" 버튼과 마찬가지로 control의 라벨 값으로 접근해야 합니다.

  ![스크린샷 2020-10-27 오전 2 35 00](https://user-images.githubusercontent.com/48345308/97207154-04d27c00-17fd-11eb-817f-77266533c98d.png)

- 그 결과 위의 값이 Text에 접근이 가능합니다. 이제 첫 번째 진짜 테스트를 실행하는 것입니다. 위에서 작성했던 코드의 순서대로 설명해보자면
  1. *accessibility(identifier:)* 을 사용하여 앱에서 보여지는 element를 찾았습니다.
  2. step 1의 첫 번째 결과는 UI test에서 대부분의 UI element와 마찬가지로  *XCUIElement* 입니다. 이것은 label 프로퍼티를 조사할 수 있습니다.
  3. 레이블이 예상되는 결과와 일치하는지 확인하기 위하여 *XCTAssert* 를 사용하였습니다. 모든 테스팅은 XCT로 시작합니다. 각 테스트에서 test 통과 또는 실패 여부를 결정할 수 있는 하나 이상의 *XCTAssert* 를 수행해야 합니다.
- 이 경우네는 string의 값이 "0" 으로 보여지는지를 체크합니다. 결과가 실패할 것이라는 것을 알고 있지만 테스트를 실행하고 나면 빨간 색의 배경에 흰색 X가 표시되는 것을 볼 수 있습니다.

![스크린샷 2020-10-27 오전 2 40 25](https://user-images.githubusercontent.com/48345308/97207816-c5f0f600-17fd-11eb-90de-586b1972c0ec.png)



### Adding more complex tests

- 이상적으로는 UI를 구축하는 동시에 UI를 테스트 하는 것이 좋습니다.
- 하지만 현실의 개발에서는, 이미 어플리케이션이 존재하는 것에 테스트를 추가하고는 할 것입니다.
- 이번에는 두 개의 한 자릿수 숫자를 추가하여 정확한 합을 얻을 수 있는지 테스트해봅니다.

```Swift
let threeButton = app.buttons["3"]
threeButton.tap()

let addButton = app.buttons["+"]
addButton.tap()
		
let fiveButton = app.buttons["5"]
fiveButton.tap()
		
let equalButton = app.buttons["="]
equalButton.tap()
		
let display = app.staticTexts["display"]
let displayText = display.label
		
XCTAssert(displayText == "8")
```

- 다음과 같이 테스트를 실행하면 3 더하기 5는 8이니 실패하지 않을 것이라고 생각했을겁니다.

  - *XCTAssert* 에 breakpoint를 걸고 displayText가 어떤지 체크해보도록 하겠습니다.

  <img width="471" alt="스크린샷 2020-10-27 오전 9 39 10" src="https://user-images.githubusercontent.com/48345308/97242852-46344d00-1838-11eb-976c-81d2d7edafeb.png">

- 다음과 같이 "8.0"이 나와 String 값인 "8" 가는 다른걸로 보고 테스트에 실패한 것입니다.
- 따라서 8.0으로 수정한다면 테스트에 통과하는 것을 알 수 있습니다.



### Simulating user interaction

- 디스플레이를 왼쪽으로 스와이프 하면 메모리에서 지워지도록 하는 제스처를 추가하겠습니다.
- 제스처의 효과는 **MC** 키를 클릭하는 것과 같고 *self.memory* 의 값을 0으로 설정합니다.

```Swift
let memorySwipe = DragGesture(minimumDistance: 20)
	.onEnded { (_) in
	self.memory = 0.0
}

.gesture(memorySwipe) // 아래에 다음과 같에 제스처를 추가합니다.

.accessibility(identifier: "memoryDisplay")
```

- 위와 같이 제스처를 추가하였습니다.
- 이 제스처를 메모리 디스플레이에 추가할 수 있습니다. 

- 그리고 위에 처럼 identifier를 생성해서 접근할 수 있게 합니다.
- 몇 개의 숫자를 누르고 **M+** 버튼을 탭하여 값을 메모리에 저장합니다. 메모리 디스플레이가 나타나면 저장된 자릿수가 표시되고 메모리 디스플레이를 왼쪽으로 스와이프하면 이 값이 clear됩니다.

<img width="284" alt="스크린샷 2020-10-27 오전 9 54 26" src="https://user-images.githubusercontent.com/48345308/97243775-68c76580-183a-11eb-87f4-246612825e2e.png">

<img width="454" alt="스크린샷 2020-10-27 오전 9 56 40" src="https://user-images.githubusercontent.com/48345308/97243941-b8a62c80-183a-11eb-8adf-023befdfc015.png">

- 위의 코드에는 몇 가지 새로운 것이 있습니다.
  1. XCUIElemnt *exists* 프로퍼티는 element가 존재할때 ture 입니다. 메모리 디스플레이가 보이지 않는다면 이것은 실패할 것입니다.
  2. *swipeLeft()* 메소드는 왼쪽에서 오른쪽으로 스와이프 액션을 생성하는 메서드입니다. 이와 추가적으로 오른쪽, 위, 아래등도 있습니다.
  3. *XCTAssertFalse()* 테스트는 *XCTAssert* 와 반대로 행동합니다. 값이 true가 아니라 false이면 성공하게 됩니다. 여기서 디스플레이를 스와이프 하면 값이 사라지게 되니 테스트를 통과하게 됩니다.

- 이 챕터에서 논의된 것 이외에도 많은 testing element가 존재합니다. 

  1. **.isHittable** : element가 현재 위치에서 클릭이나, tap, 혹은 press될 수 있는지를 확인합니다. Offscreen element의 경우 존재하지만 hittable 하지는 않습니다.
  2. **typeText()** : 이 메소드는 마치 사용자가 통화 컨트롤에서 텍스트를 입력하는 것 처럼 작용합니다.
  3. **.press(forDuration:)** : 사용자가 하나의 손가락으로 특정 시간동안 터치하는 것을 수행할 수 있습니다.
  4. **.press(forDuration: thenDragTo:)** : 스와이프 메서드는 제스처의 속도를 제공하는 것을 보장하지 않습니다. 이 메서드를 통해서 정확한 드래그 액션 수행을 사용할 수 있습니다.
  5. **.waitForExistence()** : element가 스크린의 즉시 보이지 않을시에 잠깐 멈출 때 유용합니다.

  https://developer.apple.com/documentation/xctest/xcuielement



### Testing multiple platforms

- SwiftUI의 많은 약속들은 Apple의 여러 플랫폼에서 작동하는 앱을 구축하는 것에서 비롯됩니다.
- iOS 앱이 매우 적은 작업으로 macOS 앱이 될 수 있습니다. 하지만, 앱과 앱 테스트가 모든 플랫폼에서 작동하도록 하기 위해서는 몇 가지 주의해야 할 점이 있습니다.
- 이전 챕터에서도 공부했듯이 플랫폼이 다름으로 몇가지 유저 인터페이스가 다를 수 있습니다. 
- iOS 기기에서 버튼을 누르는 것은 MacOS에서 마우스를 클릭하는 것과 같은 UI 작업으로 번역됩니다.

<img width="1076" alt="스크린샷 2020-10-27 오전 10 09 32" src="https://user-images.githubusercontent.com/48345308/97244619-84337000-183c-11eb-84c9-7e96d5526694.png">



- macOS로 테스트를 실행하면 다음과 같은 에러를 볼 수 있습니다. *.swipeLeft()* 액션은 에러를 생성합니다. 왜냐하면 Catalyst는 테스트 프레임워크에서 macOS에 대한 스와이프 액션이 제공되지 않기 때문입니다.
- 이를 해결하기 위해 Xcode의 조건부 컴파일 블럭을 사용할 수 있습니다. 

```Swift
#if !targetEnvironment(macCatalyst) 
	// Test to exclude
#endif

#if !os(watchOS) 
	// Your XCTest code
#endif
```



### Key points

- 디버깅 테스트를 작성하는 것은 SwiftUI에서 코드와 사용자 인터페이스 element의 결합으로 인해 조금 더 주의를 기울여야 합니다.
- SwiftUI의 디버깅에서는 breakpoint를 이용하고 Swift 코드를 이용할 수 있습니다.
- 테스트는 코드의 동작을 확인하는 것이 가능하며 테스트는 알려진 입력과 시작 상태가 주어진 경우 예상 출력이 발생하는지 확인해야 합니다.
- 사용자 인터페이스 혹은 UI 테스트는 앱의 인터페이스와 상호작용의 예상되는 결과가 출력되는지를 검증합니다.
- *accessibilityIdentifier* 을 이용하여 testing 해야 하는 라벨을 식별하는 것이 가능합니다.
- 테스트에서 앱을 실행하는 데 사용되는 **XCUIApplication** 요소에서 모든 사용자 인터페이스 요소를 찾을 수 있습니다.
- 다른 플랫폼은 다른 사용자 인터페이스 테스트가 필요한 경우가 있습니다. 조건부 컴파일을 사용하여 테스트를 플랫폼 및 운영체제에 일치시킬 수 있습니다.



### Challenge

- Catalyst앱에서는 위에서 말했던 것처럼 swipe 제스처가 작동하지 않으므로 같은 결과를 나타내기 위한 대체되는 메소드를 제공할 필요가 있습니다.
- 이 앱의 Catalyst version에서 swipe gesture 처럼 두번 탭 하면 메모리를 보여주는 제스처를 추가하십시오.

```Swift
#if targetEnvironment(macCatalyst)
	let doubleTap = TapGesture(count: 2)
		.onEnded { _ in self.memory = 0.0
}
#else
let memorySwipe = DragGesture(minimumDistance: 20)
	.onEnded { _ in self.memory = 0.0
}
#endif
```



```Swift
제스처를 추가할 때도 다음과 같이 OS 환경에 맞게 나눠서 제스처를 추가해야 합니다,

#if targetEnvironment(macCatalyst)
...
	.gesture(doubleTap)
#else 
...
	.gesture(memorySwipe)
```

