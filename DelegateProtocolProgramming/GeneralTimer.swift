import Foundation

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
