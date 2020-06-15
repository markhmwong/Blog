import UIKit

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
