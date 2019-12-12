//
//  FactType.swift
//  Multitheading
//
//  Created by ilya on 12/12/2019.
//  Copyright © 2019 ilya. All rights reserved.
//

import Foundation

enum FactType: String, CaseIterable {
    case date = "By date"
    case math = "Mathematic"
    case trivial = "Trivial"
    
    var idFact: String {
        switch self {
            case .date: return "/date"
            case .math: return "/math"
            case .trivial:  return "/trivia"
        }
    }
}
