//
//  ItemRowView.swift
//  ToDoAppSwiftUI
//
//  Created by Hamza Azhar on 04/05/2022.
//

import SwiftUI

struct ItemRowView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? .pink : .primary)
                .padding(.vertical, 12)
                .animation(.default)
        }
        .toggleStyle(CheckboxView())
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
    }
}

