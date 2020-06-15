# Code Part 2

# Timer Class
```
protocol TimerProtocol {
    func stop()
    func start()
}

class GeneralTimer: NSObject, TimerProtocol {

    private var timer: Timer?

    private var timeDuration: TimerInterval

    private var expires: Date?

    init(duration: TimerInterval) {
        super.init()
        self.timer = duration
        self.timeDuration = duration
    }

    // Memory management with the timer and invalidation
    func stop() {
        timer.invalidate()
        timer = nil
    }

    // Create a new scheduled timer
    func start() {
        reviseExpirationDate()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)

    }

    private func reviseExpirationDate() {
        expires = Date().addingTimeInterval(timerInterval: timeDuration)
    }

    @objc func fireTimer() {
        let timeRemaining = Date().timeIntervalSince(date: expires)
    }
}
```

# ViewController
```
class ViewController: UIViewController {

    private var viewModel: ViewModel?

    private var timer: GeneralTimer?

    private lazy var mainView: MainView = {
        let view = UIView()
        view.translateAutoresizingMasksIntoConstraints = false
        return view
    }()

    private var viewModel

    init(timer: GeneralTimer?, viewModel: ViewModel) {
        self.timer = timer
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        guard let viewModel = viewModel else { return }

        let formattedTime = viewModel.formattedTime(time: 0.0)

        // start the view with our initial value
        mainView.updateLabel(string: formattedTime)
        view.addSubview(mainView)

        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true // you may need to include the safe area layout guide to support the notch phones. Since the top and bottom Bezels will continue to exist for the 5-6 years because of iPhone SE 2.
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
```

# View
```
class MainView: UIView {

    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.translateAutoresizingMasksIntoConstraints = false
        return label
    }()

    lazy var stopButton: UIButton = {
        let button = UIButton()
        button.translateAutoresizingMasksIntoConstraints = false
        button.setTitle("Stop", for: .normal)
        button.addTarget(self, action: #selector(handleStopButton), for: .touchDown)
        return button
    }()

    lazy var startButton: UIButton = {
        let button = UIButton()
        button.translateAutoresizingMasksIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(handleStartButton), for: .touchDown)
        return button
    }()

    private var parentViewController: ViewController

    init(viewController: ViewController) {
        setupView()
        parentViewController = viewController
    }

    // center the label and place it in the middle
    func setupView() {
        addSubview(timeLabel)
        addSubview(startButton)
        addSubview(stopButton)

        timeLabel.centerXAnchor(equalTo: centerXAnchor).isActive = true
        timeLabel.centerYAnchor(equalTo: centerYAnchor).isActive = true

        startButton.bottomAnchor(equalTo: bottomAnchor).isActive = true
        startButton.trailingAnchor(equalTo: centerYAnchor).isActive = true

        stopButton.bottomAnchor(equalTo: bottomAnchor).isActive = true
        stopButton.leadingAnchor(equalTo: centerYAnchor).isActive = true
    }

    func updateLabel(string: String) {
        DispatchQueue.main.async {
            self.timeLabel.text = string
        }
    }

    @objc func handleStopButton() {
        // Part 3
    }

    @objc func handleStartButton() {
        // Part 3
    }
}
```

# ViewModel
```
class ViewModel: NSObject {

    private var currTime: TimeInterval

    init() {
        self.currTime = 0.0
        super.init()
    }

    func formattedTime(time: TimeInterval) -> String {
        // I'll leave this up to you to format the time the way you want. This can be easily done with some maths to get the common format - 00:00:00
        return "00:00:00"
    }
}
```

Part 3 will look at incorporating the delegate methods.

[Would you like to know more? Check out Part 3](./Delegate_Part3.MD)
