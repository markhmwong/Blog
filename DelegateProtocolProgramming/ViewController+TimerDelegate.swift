extension ViewController: TimerDelegate {}
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
}
