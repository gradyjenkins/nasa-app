//
//  Photo.swift
//  nasa_app
//
//  Created by Grady Jenkins on 12/20/18.
//  Copyright © 2018 Grady Jenkins. All rights reserved.
//

import Foundation
struct Photo: Codable {
    var copyright: String
    var date: Date
    var explanation: String
    var hdurl: String
    var media_type: String
    var service_version: String
    var title: String
    var url: String
}
