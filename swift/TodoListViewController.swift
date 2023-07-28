import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    var todoItems: [TodoItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Table View Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        let item = todoItems[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = formatDate(item.dueDate)
        cell.accessoryType = item.isCompleted ? .checkmark : .none
        return cell
    }

    // MARK: - Table View Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoItems[indexPath.row].isCompleted.toggle()
        tableView.reloadData()
    }

    // MARK: - Actions

    @IBAction func addTask(_ sender: Any) {
        if let title = taskTextField.text, !title.isEmpty {
            let dueDate = datePicker.date
            let newTodoItem = TodoItem(title: title, dueDate: dueDate)
            todoItems.append(newTodoItem)
            tableView.reloadData()
            taskTextField.text = ""
            view.endEditing(true)
        }
    }

    // MARK: - Helper Methods

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
