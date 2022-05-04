//
//  CheckboxView.swift
//  ToDoAppSwiftUI
//
//  Created by Hamza Azhar on 04/05/2022.
//

import SwiftUI

struct CheckboxView: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    feedback.notificationOccurred(.success)
                }
            
            configuration.label
        }
    }
}

struct CheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Placeholder label", isOn: .constant(true))
            .toggleStyle(CheckboxView())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
