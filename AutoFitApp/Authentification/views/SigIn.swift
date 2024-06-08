//
//  SigIn.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 23/05/24.
//

import SwiftUI
import SafariServices
import WebKit
struct RegisterWebView: UIViewControllerRepresentable {
    let url: String

    func makeUIViewController(context: Context) -> WebViewController {
        WebViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: WebViewController, context: Context) {}
}

class WebViewController: UIViewController, WKNavigationDelegate {
    private var webView: WKWebView!
    private let url: URL

    init(url: String) {
        self.url = URL(string: url)!
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
    }
   
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        /* Succes Register */
        // TODO: Auto login with credentials
        print("redirect")
    }
}

struct SigIn: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State var userAgent:UserAgent
    @State var emailForm:String = ""
    @State var passwordForm:String = ""
    @State private var showRegister = false
    var body: some View {
        VStack(spacing: 30){
            Text("AFit").font(.title).fontWeight(.bold).foregroundStyle(.primary)
            TextField("email", text: $emailForm).frame(height: 40).padding(.leading,30).border(.yellow)
            SecureField("password", text: $passwordForm).frame(height: 40).padding(.leading,30).border(.yellow)
            if userAgent.errorMsg != ""{
                Text(userAgent.errorMsg).foregroundStyle(.red)
            }            
            if  horizontalSizeClass == .compact && verticalSizeClass == .regular{
                Button("Login") {
                    userAgent.login(email: emailForm, password: passwordForm)
                }.foregroundColor(.black)
                    .frame(width: 230,height: 40)
                    .background(Color.gray)
                    .cornerRadius(4)
                    .shadow(color: .gray, radius: 2)
                Button("Register") {
                    showRegister = true
                }.sheet(isPresented: $showRegister, content: {
                    RegisterWebView(url: "http://127.0.0.1:8000/register/")
                }).foregroundColor(.black)
                    .frame(width: 230,height: 40)
                    .background(Color.gray)
                    .cornerRadius(4)
                    .shadow(color: .gray, radius: 2)
            }else{
                HStack{
                    Button("Login") {
                        userAgent.login(email: emailForm, password: passwordForm)
                    }.foregroundColor(.black)
                        .frame(width: 230,height: 40)
                        .background(Color.gray)
                        .cornerRadius(4)
                        .shadow(color: .gray, radius: 2)
                    Spacer()
                    Button("Register") {
                        showRegister = true
                    }.sheet(isPresented: $showRegister, content: {
                        RegisterWebView(url: "http://127.0.0.1:8000/register/")
                    }).foregroundColor(.black)
                        .frame(width: 230,height: 40)
                        .background(Color.gray)
                        .cornerRadius(4)
                        .shadow(color: .gray, radius: 2)
                }.padding(.horizontal,50)
            }
        }.padding([.leading,.trailing],40)
    }
}

#Preview {
    SigIn(userAgent: UserAgent())
}
