import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskStore: TaskStore
    @State private var showingNewTask = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.backgroundColor.ignoresSafeArea()
                
                List {
                    ForEach(taskStore.tasks.sorted { $0.dueDate < $1.dueDate }) { task in
                        HStack(spacing: 16) {
                            // Completion button
                            Button(action: {
                                taskStore.toggleTaskCompletion(task)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? Theme.accentColor : Theme.textColor)
                                    .frame(width: 44, height: 44) // Увеличиваем область нажатия
                            }
                            .buttonStyle(BorderlessButtonStyle()) // Предотвращает распространение нажатия
                            
                            // Navigation area
                            NavigationLink(destination: TaskDetailView(task: task)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(task.title)
                                            .font(.custom(Theme.fontName, size: 16))
                                            .foregroundColor(Theme.textColor)
                                            .strikethrough(task.isCompleted)
                                        
                                        Text(task.dueDate.formatted(date: .abbreviated, time: .shortened))
                                            .font(.custom(Theme.fontName, size: 12))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                    
                                    Circle()
                                        .fill(Theme.priorityColors[task.priority] ?? Theme.primaryColor)
                                        .frame(width: 12, height: 12)
                                }
                            }
                            .buttonStyle(BorderlessButtonStyle()) // Предотвращает распространение нажатия
                        }
                        .listRowBackground(Theme.backgroundColor)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Tasks")
            .navigationBarItems(trailing: Button(action: {
                showingNewTask = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(Theme.accentColor)
                    .font(.title2)
            })
            .sheet(isPresented: $showingNewTask) {
                TaskFormView(mode: .new)
            }
        }
    }
} 