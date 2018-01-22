import UIKit
import AWSCognitoIdentityProvider

class HomePageViewController : UIViewController {
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    var role: Roles?{
        didSet{
            DispatchQueue.main.async {
                if self.role != nil{
                    self.selectRoleBtn.isEnabled = false
                    self.selectRoleBtn.tintColor = #colorLiteral(red: 0.9763647914, green: 0.9765316844, blue: 0.9763541818, alpha: 1)

                }else{
                    self.selectRoleBtn.isEnabled = true
                    self.selectRoleBtn.tintColor = #colorLiteral(red: 0.3032028119, green: 0.4540847009, blue: 0.8244939446, alpha: 1)
            
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        self.refresh()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.refresh()
    }
    
    // MARK: - Table view data source
    

    

    // MARK: - IBActions
    @IBOutlet weak var selectRoleBtn: UIBarButtonItem!
    @IBAction func selectRole(_ sender: UIButton) {
        performSegue(withIdentifier: "roleSelectorSegue", sender: nil)
    }
    
    @IBAction func viewInfo(_ sender: UIButton) {
        performSegue(withIdentifier: "infoSegue", sender: nil)
    }
    
    @IBAction func signOut(_ sender: AnyObject) {
        self.user?.signOut()
        self.title = nil
        self.response = nil
        
        self.refresh()
    }
    
    func refresh() {
        user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            if let response = task.result
            {
                for info in response.userAttributes!{
                    UserInfor[info.name!] =  info.value!
                }
            }
            query_DDB { (passed_role) in
            self.role = passed_role
            }
            return nil
        }
    }
}

