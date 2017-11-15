import UIKit

class SantaInfoViewController: UIViewController {

    @IBOutlet weak var input1: UITextField!
    @IBOutlet weak var input2: UITextField!
    @IBOutlet weak var input3: UITextField!
    
    @IBOutlet weak var input4: UITextField!
    @IBOutlet weak var input5: UITextField!
    @IBOutlet weak var input6: UITextField!
    
    
    var priceChoice : String = ""
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        priceChoice = String(sender.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func submitInfo(_ sender: UIButton) {

        if input1.text != "" && input2.text != "" && input3.text != ""
        && input4.text != "" && input5.text != "" && input6.text != ""{
            //uploads data to dynamoDB
            save_gift_DDB(likes: [input1.text!, input2.text!, input3.text!],
                          dislikes: [input4.text!, input5.text!, input6.text!],
                          price_range: priceChoice,
                          completion: {return})
        } else {
            //create a popup that says you need to input values into all text fields
            let alertController = UIAlertController(title: "Missing Required Fields",
                                                    message: "Must fill out all text fields to submit.",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion:  nil)
            return
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
