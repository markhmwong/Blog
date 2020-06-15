# Delegate Protocol Paradigm
The basics are set up for the timer. This part includes the purpose of this series - delegating methods to another class

# Timer Class
First let's think of what functions that we want to react to certain methods within the Timer. For instance, a stopwatch would typically have a stop and start button

```
protocol TimerProtocol {
    func stop()
    func start()
}
```

Wouldn't it be convenient to have methods within these that would react to it whenever they're run? Let's do that now. Set up a new Protocol with some methods that a class (in this case the ViewController) must abide by

```
protocol TimerDelegate {
    func timerWillStop()
    func timerWillStart()

    func timerDidStop()
    func timerDidStart(time: TimeInterval)
}
```

# Timer Class
Now using the ViewController reference passed as a TimerDelegate type, it's possible to call the methods timerWillStop, timerWillStart etc

```
protocol TimerProtocol {
    func stop()
    func start()
}

class GeneralTimer: NSObject, TimerProtocol {

    private var delegate: TimerDelegate

    private var timer: Timer?

    private var timeDuration: TimerInterval

    private var expires: Date?

    private var currTime: TimerInterval

    init(duration: TimerInterval, viewController: TimerDelegate) {
        self.delegate = viewController
        self.timer = duration
        self.timeDuration = duration
        self.currTime = 0.0
        super.init()
    }

    // Memory management with the timer and invalidation
    func stop() {
        // delegate method
        delegate.timerWillStop()

        // Manage the timer object
        timer.invalidate()
        timer = nil

        // delegate method
        delegate.timerDidstop()
    }

    // Create a new scheduled timer
    func start() {
        // delegate method
        delegate.timerWillStart()
        reviseExpirationDate()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }

    private func reviseExpirationDate() {
        expires = Date().addingTimeInterval(timerInterval: timeDuration)
    }

    @objc func fireTimer() {
        // delegate method
        delegate.timerDidStart(time: currTime)
        currTime = Date().timeIntervalSince(date: expires)
    }
}
```

# ViewController with Delegate methods
These are methods that won't be applied to the GeneralTimer but the ViewController as it references other object we need access to like the View and ViewModel. We'll also need to pass the View Controller reference to which can be of TimerDelegate type, using this type restricts the methods only to the delegate methods, hiding the remaining methods in the ViewController from the Timer Object

# ViewController
```
extension ViewController: TimerDelegate {

    // Delegate Methods
    func timerDidStop() {
        // perform tasks like animations

        // UI
        mainView.updateLabel(string: viewModel?.formattedTime(time: time))
    }

    func timerDidStart(time: TimeInterval) {
        mainView.updateLabel(string: viewModel?.formattedTime(time: time))
    }

    func timerWillStop() {
        // perform animations and update your UI label

    }

    func timerWillStart() {
        // perform animations and update your UI label

    }

    // remaining ViewController code from Part 2
}
```

# View
If you'd like you can hide the timer object and encapsulate the variables with methods in the ViewController to shorten the chaining, instead of the approach below. But this should show the connection between the View -> ViewController -> GeneralTimer

```
class MainView: UIView {

    weak var viewController: ViewController?

    @objc func handleStopButton() {
        viewController.timer.stop()
    }

    @objc func handleStartButton() {
        viewController.timer.start()
    }

}
```

# Close
That's basically it. The paradigm allows a better organisation of your code into meaningful parts, despite the increased files needed to support it but it is much more readable and the GeneralTimer can now be tested much more easily and injected into another part of your application.

The code is provided within this directory, feel free to peruse and use. I do caution though that I have not run the code and have basically written this in a text editor off the top of my head.
