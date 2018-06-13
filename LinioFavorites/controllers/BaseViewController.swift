//
//  BaseViewController.swift
//  LinioFavorites
//
//  Created by Ramses Rodríguez on 13/06/18.
//  Copyright © 2018 Ramses Rodríguez. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var alertController: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showActivityIndicator(){
        OperationQueue.main.addOperation { () -> Void in
            self.alertController = UIAlertController(title: "Espere por favor.\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            indicator.frame=CGRect(x: 0, y: 20, width: self.alertController!.view.frame.size.width, height: self.alertController!.view.frame.size.height-20)
            indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.alertController?.view.addSubview(indicator)
            indicator.isUserInteractionEnabled = false
            indicator.startAnimating()
            
            self.alertController?.show()
        }
    }
    
    func hideActivityIndicator(completion:(() -> Void)?){
        OperationQueue.main.addOperation { () -> Void in
            if self.alertController != nil {
                self.alertController?.dismiss(animated: true, completion: completion)
            }
        }
    }
    
    func showAlertViewWith(title:String, andMessage message:String,completion:(() -> Void)?){
        OperationQueue.main.addOperation { () -> Void in
            let alertMessage = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let alertAction=UIAlertAction(title: "Continuar", style: .default, handler: { (alertAction) in
                if completion != nil {
                    completion!()
                }
            })
            
            alertMessage.addAction(alertAction)
            
            alertMessage.show()
        }
    }
}
