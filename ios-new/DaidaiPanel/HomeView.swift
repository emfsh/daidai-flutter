import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Label("仪表盘", systemImage: "dashboard")
                }
                .tag(0)
            
            TaskListView()
                .tabItem {
                    Label("任务", systemImage: "list.bullet")
                }
                .tag(1)
            
            EnvListView()
                .tabItem {
                    Label("变量", systemImage: "key")
                }
                .tag(2)
            
            SettingsView()
                .tabItem {
                    Label("设置", systemImage: "gear")
                }
                .tag(3)
        }
        .navigationTitle("呆呆面板")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
