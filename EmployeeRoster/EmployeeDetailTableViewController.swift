
import UIKit

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate {

    struct PropertyKeys {
        static let unwindToListIndentifier = "UnwindToListSegue"
    }
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var dobDatePicker: UIDatePicker!
    
    @IBOutlet var employeeTypeLabel: UILabel!
    
    var employee: Employee?
    
    var isEditingBirthday: Bool = false {
        didSet {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    let birthDateLabelIndex = IndexPath(row: 1, section: 0)
    let birthDatePickerIndex = IndexPath(row: 2, section: 0)
    
}

extension EmployeeDetailTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
}

extension EmployeeDetailTableViewController {
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dobLabel.text = dateFormatter.string(from: employee.dateOfBirth)
            dobLabel.textColor = .black
            employeeTypeLabel.text = employee.employeeType.description()
            employeeTypeLabel.textColor = .black
        } else {
            navigationItem.title = "New Employee"
        }
    }
}

extension EmployeeDetailTableViewController {
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let name = nameTextField.text {
            employee = Employee(name: name, dateOfBirth: Date(), employeeType: .exempt)
            performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
        performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
    }
}

extension EmployeeDetailTableViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case birthDatePickerIndex:
            if isEditingBirthday == true {
                return dobDatePicker.frame.height
            } else  {
                return 0
            }
        default:
                return UITableView.automaticDimension
            }
}
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == birthDateLabelIndex {
            isEditingBirthday = !isEditingBirthday
        }
    }
}

