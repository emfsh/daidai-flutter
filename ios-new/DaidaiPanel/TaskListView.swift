import SwiftUI

struct Task: Identifiable {
    let id: Int
    let name: String
    let cron: String
    let enabled: Bool
}

struct TaskListView: View {
    @State private var tasks: [Task] = []
    
    var body: some View {
        List(tasks) { task in
            VStack(alignment: .leading) {
                Text(task.name)
                    .font(.headline)
                Text("Cron: \(task.cron)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(task.enabled ? "已启用" : "已禁用")
                    .font(.caption)
                    .foregroundColor(task.enabled ? .green : .red)
            }
        }
        .navigationTitle("任务")
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
