//
//  IdentifiableError.swift
//  asesoftware
//
//  Created by Mini on 12/10/23.
//

import Foundation

struct IdentifiableError: Identifiable {
    let id = UUID()
    let message: String
}
