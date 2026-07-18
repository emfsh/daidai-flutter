import SwiftUI

struct EnvVar: Identifiable {
    let id: Int
    let name: String
    let value: String
    let enabled: Bool
}

struct EnvListView: View {
    @State private var envVars: [EnvVar] = []
    
    var body: some View {
        List(envVars) { env in
            VStack(alignment: .leading) {
                Text(env.name)
                    .font(.headline)
                Text(env.value)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(env.enabled ? "已启用" : "已禁用")
                    .font(.caption)
                    .foregroundColor(env.enabled ? .green : .red)
            }
        }
        .navigationTitle("环境变量")
    }
}

struct EnvListView_Previews: PreviewProvider {
    static var previews: some View {
        EnvListView()
    }
}
