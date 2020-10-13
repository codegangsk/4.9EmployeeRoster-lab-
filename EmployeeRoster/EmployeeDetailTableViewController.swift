
import UIKit

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate, EmployeeTypeDelegate {

    struct PropertyKeys {
        static let unwindToListIndentifier = "UnwindToListSegue"
    }
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var dobDatePicker: UIDatePicker!
    
    @IBOutlet var employeeTypeLabel: UILabel!
    
    var employee: Employee? {
        didSet {
           print("\(employee)")
        }
    }
    var employeeType: EmployeeType? {
        didSet {
            print("\(employeeType!)")
        }
    }
    
    var isEditingBirthday: Bool = false {
        didSet {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    let birthDateLabelIndex = IndexPath(row: 1, section: 0)
    let birthDatePickerIndex = IndexPath(row: 2, section: 0)
    let dateFormatter = DateFormatter()
}

extension EmployeeDetailTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        print("view did load")
    }
}

extension EmployeeDetailTableViewController {
    func updateView() {
        if let employee = employee, let employeeType = employeeType {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            dateFormatter.dateStyle = .medium
            dobLabel.text = dateFormatter.string(from: employee.dateOfBirth)
            dobLabel.textColor = .black
            employeeTypeLabel.text = employeeType.description()
            employeeTypeLabel.textColor = .black
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEmployeeType" {
            let destinationViewController = segue.destination as? EmployeeTypeTableViewController
            destinationViewController?.delegate = self
        }
    }
    
    func didSelect(employeeType: EmployeeType) {
        self.employeeType = employeeType
        employeeTypeLabel.text = "\(employeeType.description())"
        employeeTypeLabel.textColor = .black
    }
}

extension EmployeeDetailTableViewController {
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let unwrappedEmployeeName = nameTextField.text, let unwrappedEmployeeType = employeeType {
            employee = Employee(name: unwrappedEmployeeName, dateOfBirth: dobDatePicker.date, employeeType: unwrappedEmployeeType)
        }
            performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
        performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
    }

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        dobLabel.text = dateFormatter.string(from: sender.date)
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
        dobLabel.textColor = .black
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dobLabel.text = dateformatter.string(from: dobDatePicker.date)
        
        if indexPath == birthDateLabelIndex {
            isEditingBirthday = !isEditingBirthday
        }
    }
}

