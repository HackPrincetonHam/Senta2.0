import UIKit

class ReindeerViewController: UIViewController {

    @IBOutlet weak var studentID: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var residency: UITextField!
    @IBOutlet weak var dropMonth: UITextField!
    @IBOutlet weak var dropDay: UITextField!
    var dateNSNumber : NSNumber?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func confirm(_ sender: UIButton) {
    
        let listOfTextField = [studentID, name, residency, dropMonth, dropDay]
        
        for textField in listOfTextField{
            if textField!.text! == ""{
                let alert = UIAlertController(title: "Missing Inputs", message: "Please fill out the blanks", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
            
            
            if let monthFloat = Float(dropMonth.text!), let dayFloat = Float(dropDay.text!){
                let dateFloat = monthFloat * 100 + dayFloat
                dateNSNumber = NSNumber(value: dateFloat)
            }else{
                let alert = UIAlertController(title: "Wrong Inputs", message: "Please Enter Numbers for Date", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
        
        save_reindeer_DDB(drop_date: dateNSNumber!, drop_location: residency.text!, identity: name.text!, completion: {return})
        
        performSegue(withIdentifier: "homeSegue", sender: nil)
    }
}
    

