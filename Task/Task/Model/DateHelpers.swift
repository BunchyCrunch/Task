//
//  DateHelpers.swift
//  Task
//
//  Created by Josh Sparks on 9/25/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

import Foundation

extension Date {
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        return formatter.string(from: self)
    }
}
