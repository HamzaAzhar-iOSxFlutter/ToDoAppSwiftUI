//
//  ContentView.swift
//  ToDoAppSwiftUI
//
//  Created by Hamza Azhar on 08/04/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @AppStorage ("isDarkMode") private var isDarkMode: Bool = false
    @State private var showNewItemView: Bool = false
    @State var task: String = ""
    private var isButtonDisabled: Bool {
        self.task.isEmpty
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: - Main View
                VStack {
                    //MARK: - Header View
                    HStack(spacing: 10) {
                        Text("ToDo")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                            
                        Spacer()
                        
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                        
                        Button {
                            isDarkMode.toggle()
                            AudioPlayer.shared.playSound(sound: "sound-tap", type: "mp3")
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: .center)
                                .font(.system(.title, design: .rounded))
                        }

                    }
                    .padding()
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 80)
                    //MARK: - New task button
                    Button {
                        self.showNewItemView = true
                        AudioPlayer.shared.playSound(sound: "sound-ding", type: "mp3")
                        feedback.notificationOccurred(.success)
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .semibold, design: .rounded))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(colors: [Color.pink, Color.blue], startPoint: .leading, endPoint: .trailing)
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, y: 4.0)
                    .cornerRadius(100)

                    
                    List {
                        ForEach(items) { item in
                          ItemRowView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                    .navigationBarTitle("Daily Tasks", displayMode: .large)
                    .navigationBarHidden(true)
                }
                .blur(radius: showNewItemView ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5))
                
                if self.showNewItemView {
                    BlankView(backgroundColor: isDarkMode ? Color.black : Color.gray,
                              backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation {
                                self.showNewItemView = false
                            }
                        }
                    AddItemView(showNewItemView: $showNewItemView)
                }
            }
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor.clear
            })
            .background(
                BackgroundImageView()
                    .blur(radius: showNewItemView ? 8.0 : 0, opaque: false)
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
            Text("Select an item")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
