import Foundation
import Combine

class TaskStore: ObservableObject {
    @Published var tasks: [AppTask] = []
    private let tasksKey = "savedTasks"
    
    init() {
        loadTasks()
    }
    
    private func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: tasksKey),
           let savedTasks = try? JSONDecoder().decode([AppTask].self, from: data) {
            self.tasks = savedTasks
        }
    }
    
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }
    }
    
    func addTask(_ task: AppTask) {
        tasks.append(task)
        saveTasks()
    }
    
    func updateTask(_ task: AppTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            saveTasks()
        }
    }
    
    func deleteTask(_ task: AppTask) {
        tasks.removeAll { $0.id == task.id }
        saveTasks()
    }
    
    func toggleTaskCompletion(_ task: AppTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            saveTasks()
        }
    }
} 