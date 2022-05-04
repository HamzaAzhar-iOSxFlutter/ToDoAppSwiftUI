//
//  AddItemView.swift
//  ToDoAppSwiftUI
//
//  Created by Hamza Azhar on 04/05/2022.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage ("isDarkMode") private var isDarkMode: Bool = false
    @State var task: String = ""
    @Binding var showNewItemView: Bool
    private var isButtonDisabled: Bool {
        self.task.isEmpty
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(10)
                
                Button {
                    addItem()
                } label: {
                    Spacer()
                    Text("SAVE")
                    Spacer()
                }
                .disabled(self.isButtonDisabled)
                .padding()
                .font(.system(size: 24.0, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .background(self.isButtonDisabled ? Color.blue : Color.pink)
                .cornerRadius(10)
                
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
            )
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
        }
        .padding()
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        self.task = ""
        hideKeyboard()
        showNewItemView = false
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(showNewItemView: .constant(true))
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
