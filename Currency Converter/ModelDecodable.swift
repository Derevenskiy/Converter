//
//  ModelDecodable.swift
//  Currency Converter
//
//  Created by Артем Чернышов on 08.12.2020.
//  Copyright © 2020 Artem Chernyshov. All rights reserved.
//

import Foundation

struct ModelDecodable: Decodable {
    var text: String
    var timestamp: Int
    var value: String
}
