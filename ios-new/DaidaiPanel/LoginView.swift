import SwiftUI

struct LoginView: View {
    let onLoginSuccess: () -> Void
    
    @State private var serverUrl = ""
    @State private var username = ""
    @State private var password = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("呆呆面板")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(spacing: 16) {
                TextField("服务器地址", text: $serverUrl)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                TextField("用户名", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("密码", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    isLoading = true
                    // TODO: 实现登录逻辑
                    onLoginSuccess()
                }) {
                    Text(isLoading ? "登录中..." : "登录")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(isLoading)
            }
            .padding(.horizontal, 32)
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(onLoginSuccess: {})
    }
}
