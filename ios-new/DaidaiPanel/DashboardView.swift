import SwiftUI

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                StatsCard(title: "启用任务", value: "0", icon: "📋")
                StatsCard(title: "环境变量", value: "0", icon: "🔑")
                StatsCard(title: "今日执行", value: "0", icon: "▶️")
                StatsCard(title: "失败任务", value: "0", icon: "❌")
            }
            .padding()
        }
        .navigationTitle("仪表盘")
    }
}

struct StatsCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(value)
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
            Text(icon)
                .font(.title)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
