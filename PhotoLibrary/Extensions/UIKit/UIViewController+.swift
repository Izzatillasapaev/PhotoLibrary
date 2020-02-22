
import Foundation
import UIKit

extension UIViewController {
  class var storyboardId: String {
    return "\(self)"
  }
    func presentFullScreen(vc: UIViewController) {
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    func presentModallyFullScreen(vc: UIViewController) {
        
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
  // MARK: Progress hud
   
  func fromSB() -> Self {
    func selfInstance<T>(_ controller: T) -> T {
      let storyboard = UIStoryboard(name: className, bundle: nil)
      if let nVC = storyboard.instantiateInitialViewController() as? UINavigationController {
        return nVC.viewControllers[0] as! T
      } else {
        return storyboard.instantiateInitialViewController() as! T
      }
    }
    return selfInstance(self)
  }
  
  
  // MARK: Alerts
  func showAlert(title: String, messageBody: String) {
    let alert = UIAlertController(title: title, message: messageBody, preferredStyle: .alert)
    let actionClose = UIAlertAction(title: "ОК", style: .default)
    alert.addAction(actionClose)
    self.present(alert, animated: true)
  }
  
    func showAlert(with title: String? = nil, message: String? = nil, style: UIAlertController.Style = .alert, ok: String? = nil, action: (() -> ())? = nil, actions: [UIAlertAction]? = nil) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: style)
    var neededActions: [UIAlertAction] = []
    if let ok = ok {
      neededActions = [UIAlertAction(title: ok, style: .default, handler: { _ in action?() })]
    } else if let action = action {
      neededActions = [UIAlertAction(title: "Продолжить", style: .default,
                                     handler: { _ in action() })]
    } else if let actions = actions {
      neededActions = actions
    }
    neededActions.forEach { ac.addAction($0) }
    present(ac, animated: true, completion: nil)
  }
    
    // MARK: Error
//    func showError(title titleText: String = "Произошла ошибка!", message: String,  complition: (() -> Void)? = nil) {
//           print("ERROR", message)
//           let vc = ErrorViewController().fromSB()
//           vc.modalPresentationStyle = .overCurrentContext
//           vc.setUp(title: titleText, message: message, complition: complition)
//           present(vc, animated: false, completion: nil)
//       }
//
//    // MARK: Success
//    func showSuccess(message: String,  complition: (() -> Void)? = nil) {
//           print("ERROR", message)
//           let vc = SuccessViewController().fromSB()
//           vc.modalPresentationStyle = .overCurrentContext
//           vc.setUp(message: message, complition: complition)
//           present(vc, animated: false, completion: nil)
//       }
    
    
    // MARK: Helpers
    func checkIfIphoneX()->Bool{
        if UIDevice().userInterfaceIdiom == .phone {
            let screenHeight = UIScreen.main.nativeBounds.height
            return screenHeight >= 2436 ? true : false
        }
        return false
    }
    
    
}

extension UIViewController {
    
    func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension UIViewController {
//    func isLoading(loading: Bool) {
//        loading ? self.showLoadingHUD() : self.dismissLoadingHUD()
//    }
    func showError(message: String) {
        self.showAlert(title: "Произошла ошибка", messageBody: message)
    }
    func showSuccess(message: String) {
        self.showAlert(title: "Успех!", messageBody: message)
    }
}

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
