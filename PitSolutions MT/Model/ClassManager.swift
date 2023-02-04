//
//  ClassManager.swift
//  PitSolutions MT
//
//  Created by Iris Medical Solutions on 02/02/23.
//

import Foundation
import UIKit


struct Pets : Decodable {
    var pets : [PetsDetails]
}

struct PetsDetails : Decodable {
    var image_url : String
    var title : String
    var content_url : String
    var date_added : String
}




