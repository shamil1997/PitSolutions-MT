//
//  PetsImageCllectionViewController.swift
//  PitSolutions MT
//
//  Created by Iris Medical Solutions on 02/02/23.
//

import UIKit

class PetsImageCllectionViewController: UIViewController {
    
    private var petDataStruct : Pets?
    private var showAlert = ShowAlerts()
    
    @IBOutlet weak var petImageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.checkAppTimeValidity()
            }
    }
    
    func checkAppTimeValidity() {
        let timeValid = UserDefaults.standard.bool(forKey: "isContentAvailable")
        if timeValid{
            let petsData = ConvertJsonFileToData(fileName: "PetCollectionJson", fileExtension: "json")
            petDataStruct = FetchDataToStructWithData(petsData)
            petImageCollectionView.reloadData()
            getConnectivityStatus()
        }else{
            showAlert.displayError(on: self, title: "Time Over", message: "The alloted time is over. please login tomorrow between 09:00 and 18:00")
            petImageCollectionView.isHidden = true
        }
    }
    
    
    
    private func getConnectivityStatus() {
        if NetworkMonitor.shared.isConnected {
        }else{
            showAlert.displayError(on: self, title: "Network Issue", message: "You're not connected")
        }
    }
    
    
    func FetchDataToStructWithData(_ convertedData : Data?) -> Pets? {
        var DataStructToReturn : Pets
        guard let receivedData = convertedData else {return nil}
        
        do {
            let decodedData = try JSONDecoder().decode(Pets.self, from: receivedData)
            DataStructToReturn = decodedData
            return DataStructToReturn
        }catch let error{
            showAlert.displayError(on: self, title: "Unexpected Error", message: "unexpected error.\(error.localizedDescription)")
            return nil
        }
    }
    
    
    func ConvertJsonFileToData(fileName: String, fileExtension: String) -> Data?{
        var convertedData : Data?
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileExtension) else {return nil}
        do {
            convertedData = try Data(contentsOf: URL(filePath: filepath), options: .mappedIfSafe)
        }catch let error{
            showAlert.displayError(on: self, title: "Unexpected Error", message: "unexpected error.\(error.localizedDescription)")
            return nil
        }
        return convertedData
    }
}
extension PetsImageCllectionViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let petDataCount = petDataStruct?.pets.count else {return 0}
        return petDataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let imageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "petsImageViewCell", for: indexPath) as? PetImageViewCollectionViewCell else {return UICollectionViewCell()}
        imageCollectionViewCell.setupCollectionViewWth((petDataStruct?.pets[indexPath.row])!)
        return imageCollectionViewCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let petDataFetchLink = petDataStruct?.pets[indexPath.row].content_url as? String else {return}
        guard let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "PetDetailsVC") as? PetDetailsViewController else {return}
        detailsViewController.modalPresentationStyle = .overCurrentContext
        detailsViewController.petDetailFetchLink = petDataFetchLink
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}
