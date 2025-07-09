import SwiftUI

struct TaskDetailView: View {
    @EnvironmentObject var taskStore: TaskStore
    @Environment(\.presentationMode) var presentationMode
    let task: AppTask
    @State private var showingEditSheet = false
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Title Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title")
                        .font(.custom(Theme.fontName, size: 14))
                        .foregroundColor(.gray)
                    Text(task.title)
                        .font(.custom(Theme.fontName, size: 20))
                        .foregroundColor(Theme.textColor)
                }
                .padding(.horizontal)
                
                Divider()
                
                // Description Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.custom(Theme.fontName, size: 14))
                        .foregroundColor(.gray)
                    Text(task.description)
                        .font(.custom(Theme.fontName, size: 16))
                        .foregroundColor(Theme.textColor)
                }
                .padding(.horizontal)
                
                Divider()
                
                // Details Section
                VStack(alignment: .leading, spacing: 16) {
                    DetailRow(title: "Due Date", value: task.dueDate.formatted(date: .long, time: .shortened))
                    DetailRow(title: "Priority", value: task.priority.rawValue)
                    DetailRow(title: "Status", value: task.isCompleted ? "Completed" : "In Progress")
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Action Buttons
                VStack(spacing: 12) {
                    Button(action: {
                        showingEditSheet = true
                    }) {
                        Text("Edit Task")
                            .font(.custom(Theme.fontName, size: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.accentColor)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        showingDeleteAlert = true
                    }) {
                        Text("Delete Task")
                            .font(.custom(Theme.fontName, size: 16))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        .background(Theme.backgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingEditSheet) {
            TaskFormView(mode: .edit(task))
        }
        .alert("Delete Task", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                taskStore.deleteTask(task)
                presentationMode.wrappedValue.dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete this task?")
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.custom(Theme.fontName, size: 14))
                .foregroundColor(.gray)
            Text(value)
                .font(.custom(Theme.fontName, size: 16))
                .foregroundColor(Theme.textColor)
        }
    }
} 