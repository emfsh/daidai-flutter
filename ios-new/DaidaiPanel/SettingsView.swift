import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section(header: Text("个人信息")) {
                HStack {
                    Text("用户名")
                    Spacer()
                    Text("admin")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("角色")
                    Spacer()
                    Text("管理员")
                        .foregroundColor(.gray)
                }
            }
            
            Section(header: Text("外观设置")) {
                NavigationLink(destination: Text("深色模式设置")) {
                    Text("深色模式")
                }
            }
            
            Section(header: Text("系统管理")) {
                NavigationLink(destination: Text("开放API")) {
                    Text("开放API")
                }
                NavigationLink(destination: Text("安全设置")) {
                    Text("安全设置")
                }
            }
            
            Section(header: Text("关于")) {
                HStack {
                    Text("版本")
                    Spacer()
                    Text("1.2.6")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("设置")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
