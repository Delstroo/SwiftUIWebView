//
//  WebView.swift
//  SwiftUIWebView
//
//  Created by Delstun McCray on 11/15/23.
//

import SwiftUI
import WebKit

struct HomeView: View {
    @StateObject var viewModel = WebViewModel()
    @State private var shouldLoadGoogle = false
    @State private var webViewBackgroundColor: Color = .white // Default background color
    
    var body: some View {
        VStack(spacing: 0) {
            // WebView
            WebView(webView: $viewModel.webView)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color.background)
                .onAppear {
                    shouldLoadGoogle = true
                    viewModel.webView.isOpaque = false
                    viewModel.webView.backgroundColor = .clear
                }
                .onChange(of: shouldLoadGoogle) { shouldLoad in
                    if shouldLoad {
                        viewModel.urlString = "https://www.google.com"
                        viewModel.loadUrl()
                        shouldLoadGoogle = false
                    }
                }
            // URLBarView
            URLBarView(viewModel: viewModel, shouldLoadGoogle: $shouldLoadGoogle)
                .ignoresSafeArea()
                .background(Color.background)
        }
        .backgroundStyle(Color.background)
    }
}

struct WebView: UIViewRepresentable {
    @Binding var webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        self.webView = webView
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
}


#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
