import UIKit
import AWSCognitoIdentityProvider

class UserDetailTableViewController : UITableViewController {
    
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
        self.tableView.delegate = self
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let response = self.response  {
            return response.userAttributes!.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attribute", for: indexPath)
        let userAttribute = self.response?.userAttributes![indexPath.row]
        cell.textLabel!.text = userAttribute?.name
        cell.detailTextLabel!.text = userAttribute?.value
        return cell
    }
    
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
        self.tableView.reloadData()
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

