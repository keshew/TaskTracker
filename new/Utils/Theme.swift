import SwiftUI

struct Theme {
    static let primaryColor = Color(red: 255/255, green: 218/255, blue: 185/255) // Peach
    static let secondaryColor = Color(red: 255/255, green: 228/255, blue: 205/255) // Light Peach
    static let accentColor = Color(red: 255/255, green: 179/255, blue: 138/255) // Dark Peach
    static let backgroundColor = Color(red: 252/255, green: 247/255, blue: 245/255) // Off White
    static let textColor = Color(red: 74/255, green: 74/255, blue: 74/255) // Dark Gray
    
    static let priorityColors: [TaskPriority: Color] = [
        .low: Color(red: 144/255, green: 238/255, blue: 144/255),
        .medium: Color(red: 255/255, green: 218/255, blue: 185/255),
        .high: Color(red: 255/255, green: 182/255, blue: 193/255)
    ]
    
    static let fontName = "Poppins"
} 