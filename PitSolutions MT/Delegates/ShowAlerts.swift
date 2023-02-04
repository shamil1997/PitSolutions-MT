//
//  ShowAlerts.swift
//  PitSolutions MT
//
//  Created by Iris Medical Solutions on 03/02/23.
//

import Foundation
import UIKit


class ShowAlerts : NSObject {    
     func displayError(on viewController: UIViewController, title : String, message: String) {
        let title_attribute = setAttributedString(NSAttributedString(string: title), isBold: true, fontsize: 18, fontColor: .blue)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
         alertController.setValue(title_attribute, forKey: "attributedTitle")
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    @objc func setAttributedString(_ attrString: NSAttributedString, isBold: Bool, fontsize: CGFloat, fontColor: UIColor) -> NSMutableAttributedString {
        let mutableAttrString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attrString)
        let headerStart: Int = 0
        let headerEnd: Int = attrString.length
        
        if isBold == true {
            mutableAttrString.addAttribute(NSAttributedString.Key.font, value: BoldAppFontOfSize(fontsize), range: NSMakeRange(headerStart, headerEnd))
        }else {
            mutableAttrString.addAttribute(NSAttributedString.Key.font, value: AppFontOfSize(fontsize), range: NSMakeRange(headerStart, headerEnd))
        }
        mutableAttrString.addAttribute(NSAttributedString.Key.foregroundColor, value: fontColor, range: NSMakeRange(headerStart, headerEnd))
        
        return mutableAttrString
    }
    func currentTopViewController() -> UIViewController {
        var topVC: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController
        while ((topVC?.presentedViewController) != nil) {
            topVC = topVC?.presentedViewController
        }
        return topVC!
    }
    @objc func BoldAppFontOfSize(_ size: CGFloat)-> UIFont{
        let font = UIFont(name: "HelveticaNeue-Bold", size: size)
        return font!
    }
    @objc func AppFontOfSize(_ size: CGFloat)-> UIFont{
        let font = UIFont(name: "Helvetica Neue", size: size)
        return font!
    }
}
