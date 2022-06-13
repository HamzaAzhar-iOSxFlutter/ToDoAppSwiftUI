//
//  ToDoAppSwiftUIWidget.swift
//  ToDoAppSwiftUIWidget
//
//  Created by Hamza Azhar on 14/06/2022.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct ToDoAppSwiftUIWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var fontStyle: Font {
        if self.widgetFamily == .systemSmall {
            return .system(.footnote, design: .rounded)
        } else {
            return .system(.headline, design: .rounded)
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                backgroundGradient
                
                Image("rocket-small")
                    .resizable()
                    .scaledToFill()
                
                Image("logo")
                    .resizable()
                    .frame(
                        width: self.widgetFamily != .systemSmall ? 56 : 36,
                        height: self.widgetFamily != .systemSmall ? 56 : 36
                    )
                    .offset(x: (geometry.size.width / 2) - 20,
                            y: (geometry.size.height / -2) + 20)
                    .padding(.top, self.widgetFamily != .systemSmall ? 32 : 12)
                    .padding(.trailing, self.widgetFamily != .systemSmall ? 40 : 12)
                
                HStack {
                    Text("Just Do It")
                        .foregroundColor(.white)
                        .font(fontStyle)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            Color(red: 0, green: 0, blue: 0, opacity: 0.5)
                                .blendMode(.overlay)
                        )
                        .clipShape(Capsule())
                    
                    if self.widgetFamily != .systemSmall {
                        Spacer()
                    }
                }
                .padding()
                .offset(y: self.widgetFamily == .systemMedium ? (geometry.size.height / 2) - 120 : (geometry.size.height / 2) - 24)
            }
        }
    }
}

@main
struct ToDoAppSwiftUIWidget: Widget {
    let kind: String = "ToDoAppSwiftUIWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ToDoAppSwiftUIWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Todo launcher")
        .description("This is an example widget for the personal task manager app.")
    }
}

struct ToDoAppSwiftUIWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToDoAppSwiftUIWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            ToDoAppSwiftUIWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            ToDoAppSwiftUIWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
