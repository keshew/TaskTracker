import SwiftUI

enum TaskFormMode {
    case new
    case edit(AppTask)
}

struct TaskFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var taskStore: TaskStore
    
    let mode: TaskFormMode
    
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var priority = TaskPriority.medium
    
    init(mode: TaskFormMode) {
        self.mode = mode
        if case .edit(let task) = mode {
            _title = State(initialValue: task.title)
            _description = State(initialValue: task.description)
            _dueDate = State(initialValue: task.dueDate)
            _priority = State(initialValue: task.priority)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Task Title", text: $title)
                        .font(.custom(Theme.fontName, size: 16))
                    
                    TextEditor(text: $description)
                        .font(.custom(Theme.fontName, size: 16))
                        .frame(height: 100)
                }
                
                Section {
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                        .font(.custom(Theme.fontName, size: 16))
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(TaskPriority.allCases, id: \.self) { priority in
                            Text(priority.rawValue)
                                .font(.custom(Theme.fontName, size: 16))
                                .tag(priority)
                        }
                    }
                }
            }
            .navigationTitle(
                "New"
            )
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.custom(Theme.fontName, size: 16)),
                trailing: Button("Save") {
                    saveTask()
                }
                .font(.custom(Theme.fontName, size: 16))
                .disabled(title.isEmpty)
            )
        }
    }
    
    private func saveTask() {
        let task: AppTask
        if case .edit(let existingTask) = mode {
            task = AppTask(id: existingTask.id,
                       title: title,
                       description: description,
                       dueDate: dueDate,
                       priority: priority,
                       isCompleted: existingTask.isCompleted,
                       createdAt: existingTask.createdAt)
            taskStore.updateTask(task)
        } else {
            task = AppTask(title: title,
                       description: description,
                       dueDate: dueDate,
                       priority: priority)
            taskStore.addTask(task)
        }
        presentationMode.wrappedValue.dismiss()
    }
} 
