# Chapter 4: Integrating SwiftUI (SwiftUI 통합하기)



- SwiftUI가 흥미롭기는 하지만 아마 지금까지 앱들의 대부분은 UIKit을 사용한 Swift에 의해 작성되었을 것입니다. 하지만 이것을 SwiftUI로 다시 작성할 필요는 없습니다!
- 조금의 코드만 더 있다면, UIKit의 view들을 SwiftUI 뷰들로 바꾸는 것이 가능합니다. 
- 애플에서는 SwiftUI를 Swift의 힘과 함께 애플의 모든 플랫폼에서 사용자 인터페이스를 구축하는 혁신적이고 예외적으로 간단한 방법이라고 설명하고 있습니다. 지금까지 대부분의 앱들은 UIKit을 사용하여 개발했지만 SwiftUI는 이러한 프레임워크를 통합해서 사용하는 것이 가능하고 이것에 대해서 이번 챕터에서 이에 대해 알아봅니다.



### Getting started



<img width="550" alt="스크린샷 2020-10-20 오전 10 08 39" src="https://user-images.githubusercontent.com/48345308/96527898-3b1f7100-12bc-11eb-8fdf-efb58607d7a2.png">

- 위의 UIKit으로 만들어진 앱은 1부터 100 사이의 무작위의 값을 보여주게 됩니다. 사용자는 슬라이더를 움직이며 그 타켓값이라고 생각되는 지점에서 "Hit Me!" 를 클릭하고 점수를 보는 것이 가능합니다.



### Targeting iOS 13

- SwiftUI는 iOS 13이상을 필요로 하기 때문에 UIKit 앱의 deployment target을 13 또는 그 이상으로 설정해야 합니다.

![스크린샷 2020-10-20 오전 10 11 58](https://user-images.githubusercontent.com/48345308/96528064-b2550500-12bc-11eb-968d-f9cfb7a6f874.png)



### Hosting a SwiftUI view in a UIKit project

- SwiftUI 뷰를 존재하고 있는 UIKit app에 host로 통합하기 위한 가장 쉬운 방법은 다음과 같습니다.
  1. 프로젝트에 SwiftUI 뷰 파일을 추가합니다.
  2. RGBullsEye를 실행하는 버튼을 추가합니다. (SwiftUI로 만들어진 프로젝트)
  3. **Hosting ViewController** 를 storyboard로 드래그 하고 segue를 생성합니다.
  4. 뷰 컨트롤러 코드의 ***@IBSegueAction*** 에 segue를 연결하고 hosting viewcontroller의  *rootView* SwiftUI 뷰 인스턴스로 설정합니다.

![스크린샷 2020-10-20 오전 10 45 41](https://user-images.githubusercontent.com/48345308/96529982-6789bc00-12c1-11eb-8aa2-ac921727b154.png)



![스크린샷 2020-10-20 오전 10 52 07](https://user-images.githubusercontent.com/48345308/96530384-4ecdd600-12c2-11eb-89c7-87c6f8bb4863.png)

- 그 이후, 스토리 보드에서 라이브러리를 열고 버튼을 추가하며 title을 Play RGBullsEye로 수정하였습니다.
- 또한 버튼의 bottom margin과 horizontally center를 잡아 제약조건을 추가하였습니다.



![스크린샷 2020-10-20 오전 10 54 01](https://user-images.githubusercontent.com/48345308/96530510-918fae00-12c2-11eb-9d54-f5033cff3dee.png)

- 다음으로, 라이브러리에서 **Hosting View Controller** 를 스토리보드에 드래그하고 **Play RGBullsEye** 버튼을 컨트롤 드래그해 *Show* 를 선택합니다.

- ***Hosting View Controller*** 란 content가 SwiftUI View인 UIViewController 입니다!

  ![스크린샷 2020-10-20 오후 2 14 35](https://user-images.githubusercontent.com/48345308/96543099-995d4b80-12de-11eb-9fbf-d431d80c4d10.png)

- 애플 공식 문서를 본다면 UIHostingController란 SwiftUI의 뷰 계층을 관리하는 UIKIt view contoller라는 것을 알 수 있습니다.



![스크린샷 2020-10-20 오전 11 06 43](https://user-images.githubusercontent.com/48345308/96531322-57bfa700-12c4-11eb-8bc4-9468a80a1686.png)

- viewController에서 SwiftUI를 import한 후 *segue* 를 컨트롤 드래그 하여 viewController에 @IBSegueAction을 생성합니다.
- *@IBSegueAction* 은 Xcode11에서 새로 나왔으며 *prepare(for:sender:)* 대신에 UIKit 앱에서 사용하는 것이 가능합니다.
- 이것은 특히 목적지 뷰 컨트롤러를 생성할 때 프로퍼티를 설정하는 경우 유용합니다. 이것은 segue에 바로 연결되며  segue identifier도 필요 없습니다.

```Swift
@IBSegueAction func openRGBullsEye(_ coder: NSCoder) -> UIViewController? {
	return UIHostingController(coder: coder, rootView: ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5))
}
```

- 마지막으로 다음과 같이 코드를 박성하여 rootView를 설정하게 됩니다. 이렇게 하면 RGBullsEye SwiftUI파일이 열리는 것을 확인할 수 있습니다.



### Hosting a view controller in a SwiftUI project

- 이번에는 RGBullsEye에 BullsEye vie controller를 생성하여 반대로 해볼 것입니다.

- 다음과 같은 순서를 따르게 됩니다.

  1. RGBullsEye에 Main.storyboard와 ViewController.swift 파일을 추가합니다.

  2. 스토리보드의 **identity inspector** 에서 ViewController의 StoryBoard ID를 설정합니다.

  3. ViewController를 위한 대표하는 구조체를 생성합니다.

  4. ContentView에게 *NavigationLink* 를 추가합니다.

     
   
     <img width="424" alt="스크린샷 2020-10-20 오후 2 20 28" align = "left" src="https://user-images.githubusercontent.com/48345308/96543474-69fb0e80-12df-11eb-8d0d-7ec8229c11ae.png" >
  
  - NavigationLink란 navigation presentation을 관리하는 뷰입니다.
  - NavigationLink를 사용하여 링크 안에 어떤 종류의 것을 보여줘야 할지 제공해야 합니다. 이를 통해서 NavigationView의 다음 View로 넘어가는 것을 가능하게 해줍니다.
  
  ```Swift
  struct ContentView: View {
    var body: some View {
      NavigationView {
        NavigationLink(destination: NextContentView()) {
          Text("Hello")
        }
      }
    }
  }
  
  struct NextContentView: View {
    var body: some View {
      VStack {
        Text("World")
      }
    }
  }
  ```
  
  

![스크린샷 2020-10-20 오후 5.53.53](/Users/user/Library/Application Support/typora-user-images/스크린샷 2020-10-20 오후 5.53.53.png)

![스크린샷 2020-10-20 오전 11 29 41](https://user-images.githubusercontent.com/48345308/96532796-8db25a80-12c7-11eb-94d9-3623d445d5b4.png)

- 위와 마찬가지로 ViewControllerd와 Storyboard 파일을 복사하여 붙여넣습니다.



![스크린샷 2020-10-20 오전 11 31 07](https://user-images.githubusercontent.com/48345308/96532881-c18d8000-12c7-11eb-97da-7b2a1480a05c.png)

- 다음으로 storyboard에서 Storyboard ID를 설정합니다.



#### Conformint to UIViewControllerRepresentable



<img width="756" alt="스크린샷 2020-10-20 오후 2 24 01" src="https://user-images.githubusercontent.com/48345308/96543709-e857b080-12df-11eb-8a3a-d0990c0bf9c8.png">

- UIViewControllerRepresentable은 프로토콜로서 UIKIt view controller를 보여주는 view 입니다.
- UIKit에서는 SwiftUI를 위해 UIHostingViewController가 있었다면 SwiftUI에서는 UIKit View Controller를 부르기 위해 UIViewControllerRepresentable을 사용하게 됩니다.
- 이를 위해 UIViewControllerRepresentable을 준수하는 struct를 만들고 SwiftUI 뷰 계층에 UIViewController를 포함하도록 프로토콜 요구사항을 구현해야 합니다.



```Swift
struct ViewControllerRepresentation:
UIViewControllerRepresentable {
  
	func makeUIViewController( context: UIViewControllerRepresentableContext <ViewControllerRepresentation>) -> ViewController { 			
    UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
	  withIdentifier: "ViewController") as! ViewController
}
  
func updateUIViewController( _ uiViewController: ViewController, context: UIViewControllerRepresentableContext <ViewControllerRepresentation>) {

}}
```

- 위와 같은 구조체를 생성합니다.
- **UIViewControllerRepresentable** 프로토콜은 *make* 메소드와 *update* 메소드를 요구합니다.
- **makeUIViewController(context:)** 메서드는 *Main.Storyboard* 파일로부터 *ViewController* 를 초기화합니다. (위에서 Storyboard ID를 선언해야 했던 이유입니다.)
- 다음으로 요구되는 메소드인 *updateUIViewController(_:context:)* 는 ViewController과 SwiftUI view에 어떠한 데이터도 종속되지 않기 때문에 비워둡니다.



#### Navigation to the view controller

```Swift
NavigationLink(destination: ViewControllerRepresentation()) {
  Text("Play BullsEye")
}
.padding(.bottom)
```

- ContentView에 다음과 같이 추가하며 bottom에만 padding을 넣어 줍니다.
- 그리고 slider의 아래에 버튼을 추가하여 Tap할 때 BullsEye 뷰가 naviation stack에 push되게 합니다.



```Swift
NavigationView {
  VStack {
	...
	}
	.navigationBarTitle("RGBullsEye")
	.background(Color(.systemBackground))
}
.navigationViewStyle(StackNavigationViewStyle())
```

- 다음과 같이 NavigationView를 VStack에 embed 시킵니다.

  - top-level VStack을 NavigationView에 감싸면서 NavigationLink가 작동하게 되었습니다.

- 하지만 이렇게 했을 때 BullsEye view의 navigation bar title이 없습니다.

  - SwiftUI가 navigation controller를 사용할지라도 SwiftUI navigation controller와 BullsEye view Controller 사이에는 **wrapper view controller** 가 있기 때문입니다. 

  - 이 wrapper view controller는 navigation controller의 title에 대한 정보를 가지고 있지 않습니다.

  - ```Swift
    override func viewWillAppear(_ animated: Bool) {
    	super.viewWillAppear(animated)
            
    	parent?.navigationItem.title = "BullsEye"
    }
    ```

  - 다음과 같이 한다면 title이 보이는 것을 확인할 수 있습니다.

  - BullsEye의 view controller는 그것의 부모에게 title이 무엇인지를 알려줄 수 있게 됐기 때문입니다.



### Hosting a UIKit view with data dependencies

- 지금까지는 BullsEye view controller와 나머지 SwiftUI 앱과의 데이터 의존성이 없었기 때문에 그렇게 어렵지 않았습니다.

- 여기에서는 SwiftUI 슬라이더 뷰를 UISlider로 대체할 것입니다.

- SwiftUI Slider는 UIKit의 thumbTintColor 프로퍼티가 없기 떄문에 UISlider를 사용하여 이 프로퍼티에 접근해야 합니다.

- 이를 위해 우리는 다음과 같은 순서를 따를 것입니다.

  1. UIViewRepresentable을 준수하는 SwiftUI view를 생성하기.
  2. *make* 메소드를 UIkit view를 초기화하면서 실행하기
  3. *update* 메소드를 SwiftUI view로부터 UIKit 뷰로 업데이트할 때 실행하기
  4. *Coordinator* 를 생성하고 UIKit view로부터 SwiftUI view를 업데이트 하는 target-action 메소드 실행하기.

  

<img width="753" alt="스크린샷 2020-10-20 오후 2 33 20" src="https://user-images.githubusercontent.com/48345308/96544274-3620e880-12e1-11eb-94e9-c4f2a13adac1.png">

<img width="619" alt="스크린샷 2020-10-20 오후 2 35 47" src="https://user-images.githubusercontent.com/48345308/96544440-8c8e2700-12e1-11eb-917c-e5aa09500446.png">

- UIKit의 view들 SwiftUI view 계층으로 통합시킬때 사용되는 프로토콜입니다.
- 위 프로토콜을 준수하면 다음과 같은 2개의 메서드를 구현해야 합니다.
- *makeUIView()* 메서드의 경우는 view 객체를 생성하고 초기 상태를 설정하는 역할을 합니다.
- *updateUIView()* 메서드의 경우 특정 뷰의 상태를 SwiftUI의 새로운 정보로부터 업데이트하는 역할을 합니다.



```Swift
struct ColorUISlider: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let slider = UISlider(frame: .zero)
        return slider
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
```

- ColorUISlider는 UIViewController가 아닌 UIView를 wrap 하기 때문에 UIViewControllerRepresentable이 아닌 UIViewRepresentable을 준수해야 합니다.



- 그 다음 우리가 해결해야 할 복잡한 문제 중 하나는 UIKit의 color와 SwiftUI의 color 타입이 다르다는 것입니다. 따라서 color를 UIColor로 선언해야 합니다.
- 다른 것은 UISilder의 경우 값이 Float 이지만 Slider는 Double이라는 것입니다.

<img width="381" alt="스크린샷 2020-10-20 오후 1 11 24" src="https://user-images.githubusercontent.com/48345308/96539329-c5280380-12d5-11eb-83cc-75f3cc263af2.png">

```Swift
slider.thumbTintColor = color
slider.value = Float(value)

ColorUISlider(color: .red, value: .constant(0.5))
            .previewLayout(.sizeThatFits)
```

- 다음과 같이 코드를 작성하면 위의 형태를 띄게 됩니다.



```Swift
func updateUIView(_ uiView: UISlider, context: Context) {      
	uiView.value = Float(self.value)
}
```

- 다음과 같이 선언한다면 UISlider가 SwiftUI view로부터 Double 값을 받아오면 Float 값으로 업데이트 하게 됩니다.



```Swift
class Coordinator: NSObject {
		var parent: ColorUISlider
    init(_ parent: ColorUISlider) {
			self.parent = parent
    }
}

func makeCoordinator() -> Coordinator {
		Coordinator(self)
}
```

- 다음과 같이 Coordinator를 ColorUISlider 구조체에 추가합니다.
- 이 Coordinator 클래스를 생성했기 때문에, UIViewRepresentable 프로토콜은 *makeCoordinator()* 메서드를 요구하게 됩니다.

- Coordinator의 목적은 ColorSlider 프로퍼티의 값을 UISlider의 값으로 전달하는 것입니다.

  - 이는 ContentView의 @State 변수의 참조를 바인딩하여 UISlider의 값을 효과적으로 ContentView에 업데이트 하는 것이 가능합니다.

  - UISlider의 값을 얻기 위하여 Coordinator는 UISlider의 valueChanged 이벤트 액션을 실행해야 합니다.

  - ```Swift
    @objc func updateColorUISlider(_ sender: UISlider) {
    		parent.value = Double(sender.value)
    }
    ```

  - 위와 같은 메서드를 통해서 UISlider의 값이 변경되는 이벤트가 발생하면 그 값을 얻어오는 것이 가능합니다.

  - ```Swift
    slider.addTarget(context.coordinator, action: #selector(Coordinator.updateColorUISlider(_:)), for: .valueChanged)
    ```

  - UIKit 표준 addTarget 메서드를 사용하여 UISlider 이벤트와 Coordinator의 updateColorUISlider() 액션을 연결합니다.

  - 이 메서드는 valueChanged가 발생할때마다 호출됩니다.

