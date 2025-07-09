import Foundation

enum TaskPriority: String, Codable, CaseIterable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

struct AppTask: Identifiable, Codable {
    var id: UUID
    var title: String
    var description: String
    var dueDate: Date
    var priority: TaskPriority
    var isCompleted: Bool
    var createdAt: Date
    
    init(id: UUID = UUID(), 
         title: String = "", 
         description: String = "", 
         dueDate: Date = Date(), 
         priority: TaskPriority = .medium,
         isCompleted: Bool = false,
         createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.priority = priority
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
} 