import Foundation

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
