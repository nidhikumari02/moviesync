import Foundation

class TodoItem {
    var title: String
    var dueDate: Date
    var isCompleted: Bool

    init(title: String, dueDate: Date) {
        self.title = title
        self.dueDate = dueDate
        self.isCompleted = false
    }
}
