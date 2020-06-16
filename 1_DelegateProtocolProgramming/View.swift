import UIKit

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
