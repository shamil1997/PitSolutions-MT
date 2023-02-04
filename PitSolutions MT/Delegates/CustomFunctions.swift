//
//  CustomFunctions.swift
//  PitSolutions MT
//
//  Created by Iris Medical Solutions on 03/02/23.
//

import Foundation
import UIKit

final class CustomFunctions {
    static let shared = CustomFunctions()
    
    
    
    func isValidTime(_ config : [String: Any]) -> Bool {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let weekday = calendar.component(.weekday, from: date)
        guard let settings = config["settings"] as? [String:Any] else {return false}
        guard let workHours = settings["workHours"] as? String else {return false}
        let components = workHours.components(separatedBy: " ")
        
        if components.count != 4 {
            return false
        }
        
        let daysOfWeek = components[0]
        let startTime = components[1]
        let endTime = components[3]
        
        let startHour = Int(startTime.components(separatedBy: ":")[0]) ?? 0
        let endHour = Int(endTime.components(separatedBy: ":")[0]) ?? 0
        
        let isValidWeekday: Bool
        switch daysOfWeek {
        case "M-F":
            isValidWeekday = weekday >= 2 && weekday <= 6
        case "M-Th":
            isValidWeekday = weekday >= 2 && weekday <= 5
        case "M-W":
            isValidWeekday = weekday >= 2 && weekday <= 4
        case "Tu-F":
            isValidWeekday = weekday >= 3 && weekday <= 6
        case "W-F":
            isValidWeekday = weekday >= 4 && weekday <= 6
        case "M":
            isValidWeekday = weekday == 2
        case "Tu":
            isValidWeekday = weekday == 3
        case "W":
            isValidWeekday = weekday == 4
        case "Th":
            isValidWeekday = weekday == 5
        case "F":
            isValidWeekday = weekday == 6
        default:
            isValidWeekday = false
        }
        return isValidWeekday && hour >= startHour && hour <= endHour
    }
    
    func parseDataFromConfigWithFile(fileName: String, fileExtension: String) -> [String: Any]? {
        var convertedData = [String:Any]()
        guard let jsonFile = Bundle.main.path(forResource: fileName, ofType: fileExtension) else {return nil}
        do {
            let dataConverted = try Data(contentsOf: URL(filePath: jsonFile), options: .mappedIfSafe)
            if let transofrmedData = try JSONSerialization.jsonObject(with: dataConverted, options: .fragmentsAllowed) as? [String:Any]{
                convertedData = transofrmedData
                return convertedData
            }
        }catch let error{
            print(error)
            return nil
        }
        return nil
    }
}
