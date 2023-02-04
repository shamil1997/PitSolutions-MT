//
//  PetDetailsViewController.swift
//  PitSolutions MT
//
//  Created by Iris Medical Solutions on 03/02/23.
//

import UIKit
import WebKit

class PetDetailsViewController: UIViewController {

    @IBOutlet weak var petDetailsShowKit: WKWebView!
    var petDetailFetchLink = ""
    private var showAlert = ShowAlerts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        petDetailsShowKit.navigationDelegate = self
        if NetworkMonitor.shared.isConnected{
            loadPetDetails()
        }else{
            showAlert.displayError(on: self, title: "Network Error", message: "Check your Internet Connection")
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        petDetailsShowKit.stopLoading()
    }
    
    
    func loadPetDetails () {
        guard let petDetailUrl = URL(string: petDetailFetchLink) else {return}
        petDetailsShowKit.allowsBackForwardNavigationGestures = true
        DispatchQueue.main.async {
            self.petDetailsShowKit.load(URLRequest(url: petDetailUrl))
        }
    }
}
extension PetDetailsViewController : WKNavigationDelegate {
    
}
