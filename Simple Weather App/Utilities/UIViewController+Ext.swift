import UIKit

extension UIViewController{
    func displayAnAlert(title: String, message: String, action: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {self.present(alert, animated: true, completion: nil)}
    }
    
    func imageShadow(_ image: UIImageView){
        image.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        image.layer.shadowOpacity = 1
        image.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        image.layer.shadowRadius = 5
    }
    
    
    func buttonShadow(_ button: UIButton){
        button.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        button.layer.shadowRadius = 5
    }
    
    
    func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
