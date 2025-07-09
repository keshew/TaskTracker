import SwiftUI

struct StatsView: View {
    @EnvironmentObject var taskStore: TaskStore
    @State private var quote: Quote?
    @State private var isLoading = false
    
    var completedTasks: Int {
        taskStore.tasks.filter { $0.isCompleted }.count
    }
    
    var totalTasks: Int {
        taskStore.tasks.count
    }
    
    var completionRate: Double {
        guard totalTasks > 0 else { return 0 }
        return Double(completedTasks) / Double(totalTasks)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Progress Circle
                    ZStack {
                        Circle()
                            .stroke(Theme.secondaryColor, lineWidth: 20)
                            .frame(width: 200, height: 200)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(completionRate))
                            .stroke(Theme.accentColor, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                            .frame(width: 200, height: 200)
                            .rotationEffect(.degrees(-90))
                        
                        VStack {
                            Text("\(Int(completionRate * 100))%")
                                .font(.custom(Theme.fontName, size: 40))
                                .bold()
                            Text("Completed")
                                .font(.custom(Theme.fontName, size: 16))
                        }
                        .foregroundColor(Theme.textColor)
                    }
                    .padding(.top)
                    
                    // Stats Cards
                    HStack {
                        StatCard(title: "Total Tasks", value: "\(totalTasks)")
                        StatCard(title: "Completed", value: "\(completedTasks)")
                    }
                    
                    // Productivity Quote
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Daily Inspiration")
                            .font(.custom(Theme.fontName, size: 20))
                            .foregroundColor(Theme.textColor)
                        
                        if isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else if let quote = quote {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\"\(quote.text)\"")
                                    .font(.custom(Theme.fontName, size: 16))
                                    .foregroundColor(Theme.textColor)
                                Text("- \(quote.author)")
                                    .font(.custom(Theme.fontName, size: 14))
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Theme.secondaryColor.opacity(0.3))
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
            .background(Theme.backgroundColor)
            .navigationTitle("Statistics")
            .onAppear {
                fetchQuote()
            }
        }
    }
    
    private func fetchQuote() {
        isLoading = true
        Task {
            quote = await ProductivityService.fetchRandomQuote()
            isLoading = false
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.custom(Theme.fontName, size: 24))
                .bold()
                .foregroundColor(Theme.textColor)
            Text(title)
                .font(.custom(Theme.fontName, size: 14))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Theme.secondaryColor.opacity(0.3))
        .cornerRadius(10)
        .padding(.horizontal)
    }
} 