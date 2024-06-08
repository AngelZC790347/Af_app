//
//  SigInAppleButton.swift
//  AutoFitApp
//
//  Created by Angel Zuñiga on 23/05/24.
//

import SwiftUI
import AuthenticationServices
final class SigInApple:UIViewRepresentable{
    func makeUIView(context: Context) -> some UIView {
        return ASAuthorizationAppleIDButton()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}
struct SigInAppleButton: View {
    var body: some View {
        SignInWithAppleButton { req in
            print(req)
        } onCompletion: { res in
            print(res)
        }.signInWithAppleButtonStyle(.black).frame(width: 240,height: 40)
    }
}

#Preview(traits:.fixedLayout(width: 300, height: 50)) {
    SigInAppleButton()
}
