import UIKit

class RoleSelectorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func confirmBtnTapped(_ sender:UIButton){
        let _ = self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func chooseRoleBtnTapped(_ sender:UIButton){
        
        delete_role_DDB(role: sender.currentTitle!) {return}
        
        save_role_DDB(role: sender.currentTitle!, completion: {return})
        if sender.currentTitle! == "Senta"{
            performSegue(withIdentifier: "sentaSegue", sender: nil)
        }else{
            performSegue(withIdentifier: "reindeerSegue", sender: nil)
        }
    }
}
