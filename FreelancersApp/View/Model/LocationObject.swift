//
//  LocationObject.swift
//  FreelancersApp
//
//  Created by Melina on 30.5.21.
//  Copyright © 2021 cct_edu. All rights reserved.
//

import Foundation
import RealmSwift

 class LocationObject: Object{
    @objc dynamic var title: String?
    @objc dynamic var coordinateLat: Double = 0.0
    @objc dynamic var coordinateLong: Double = 0.0
}
