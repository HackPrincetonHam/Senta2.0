
import Foundation
import AWSCognitoIdentityProvider

class SignInViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
    //this is an array with type of AWSCognitoIdentityPasswordAuthenticationDetails
    var usernameText: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.password.text = nil
        self.username.text = usernameText
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func signInPressed(_ sender: AnyObject) {
        if (self.username.text != nil && self.password.text != nil) {
            //if username and password are set, submit the authentication information.
            let authDetails = AWSCognitoIdentityPasswordAuthenticationDetails(username: self.username.text!, password: self.password.text! )
            //authentication information is stored in a type AWSCognitoIdentityPasswordAuthenticationDetails.
            self.passwordAuthenticationCompletion?.set(result: authDetails)
            //accomplish the task by setting the result.
        } else {
            let alertController = UIAlertController(title: "Missing information",
                                                    message: "Please enter a valid user name and password",
                                                    preferredStyle: .alert)
            //initialize a class of UIAlertController
            let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
            //Strangely, the alert does not displays the message here.
            alertController.addAction(retryAction)
            //UIAlertAction is a button in an AlertController.
        }
    }
}

extension SignInViewController: AWSCognitoIdentityPasswordAuthentication {
    //here the SignInVC is conformed to a password authentication protocol. Extension also allows implementation of the protocol.
    
    public func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
        DispatchQueue.main.async {
            if (self.usernameText == nil) {
                self.usernameText = authenticationInput.lastKnownUsername
                //if the username is nill. The input is the last username before the app is closed.
            }
        }
    }
    
    public func didCompleteStepWithError(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error as? NSError {
                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                        message: error.userInfo["message"] as? String,
                                                        preferredStyle: .alert)
                //set an alert controller with attributes that are looked up from a dictionary in userInfo.
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
                alertController.addAction(retryAction)
                
                self.present(alertController, animated: true, completion:  nil)
            } else {
                self.username.text = nil
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}


