//
//  Category.swift
//  IOSExpenseTracker
//
//  Created by dremobaba on 2022/12/28.
//

import Foundation
import SwiftUIFontIcon

struct Category {
    let id: Int
    let name: String
    let icon: FontAwesomeCode
    var mainCategoryId: Int?
}
