//
//  Pattern.swift
//  DesignPatternsApp
//
//  Created by Yevhen Biiak on 19.12.2022.
//

import UIKit

struct Pattern: Decodable {
    
    enum `Type`: String, Decodable {
        case creational
        case structural
        case behavioral
    }
    
    let title: String
    let type: `Type`
    let image: String
    let structure: String
    let complexity: Int
    let popularity: Int
    let intent: String
    let codeExampleURL: String
}
