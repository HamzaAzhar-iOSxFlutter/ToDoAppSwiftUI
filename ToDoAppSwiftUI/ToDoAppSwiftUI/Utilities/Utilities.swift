//
//  Utilities.swift
//  ToDoAppSwiftUI
//
//  Created by Hamza Azhar on 04/05/2022.
//

import Foundation
import SwiftUI


public let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//MARK: - UI

public var backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

//MARK: - UX
let feedback = UINotificationFeedbackGenerator()
