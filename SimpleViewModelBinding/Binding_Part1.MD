# Binding

Getting straight to it here's the code:

```
class Dynamic<T> {
	
	typealias Listener = (T) -> ()
	
	var listener: Listener?
	
	var value: T {
		didSet {
			listener?(value)
		}
	}
	
	init(value: T) {
		self.value = value
	}
	
	// binds
	func bindAndFire(listener: @escaping Listener) {
		self.listener = listener
		listener(value)
	}
}
```

Very nice implementation. Taking a generic value on initialisation and leveraging the didSet method and an escaping closure to perform the binding job. In addition, there is a bind() method not included here, as the bindandFire() method already covers it's job by assigning the listener. Have a look at [Dino's Tutorial to see what I mean](https://www.toptal.com/ios/swift-tutorial-introduction-to-mvvm)

## Example
In most cases, there'd be something on the UI to update and we want the model to reflect the change to the UI.
```
class ViewModel {

	var answer: Dynamic<Bool>

	// answer initialised from model
	init(answer: Bool) {
		self.answer = Dynamic(value: answer)
	}

}

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.answer.bindAndFire { [unowned self] (state) in
			DispatchQueue.main.async {
				self.answerLabel.text = "\(state)"
			}
	}


}

```

It's illustrated here the creation of the answer which is passed from the Model to the ViewModel and initialised to the ViewModel's instance variable - answer which is of type Dynamic. Now a Dynamic type also contains a closure which is run whenever the instance variable "value" is updated. Perfect for the UI.


