//
//  WebViewModel.swift
//  SwiftUIWebView
//
//  Created by Delstun McCray on 11/15/23.
//

import Foundation
import WebKit

class WebViewModel: ObservableObject {
    @Published var urlString: String = ""
    @Published var history: [HistoryModel] = []
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false

    var webView: WKWebView
    private let historyLimitMonths = 1

    init() {
        let configuration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: .zero, configuration: configuration)
        setupBindings()
        loadHistoryItems()
    }

    private func setupBindings() {
        webView.publisher(for: \.canGoBack)
            .assign(to: &$canGoBack)
        
        webView.publisher(for: \.canGoForward)
            .assign(to: &$canGoForward)
    }
    
    func loadUrl() {
        let input = urlString.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if input.isEmpty { return }
        var urlToLoad: URL?

        if let url = URL(string: input), UIApplication.shared.canOpenURL(url) {
            // Input is a valid URL
            urlToLoad = url
        } else {
            // Input is not a valid URL, treat it as a search query
            let baseURL = "https://www.google.com/search?q="
            if let encodedQuery = input.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: baseURL + encodedQuery) {
                urlToLoad = url
            }
        }

        if let url = urlToLoad {
            webView.load(URLRequest(url: url))
            saveHistoryItem(HistoryModel(title: "Custom Title", url: url, timestamp: Date()))
        }
    }

    
    func goForward() {
        webView.goForward()
    }
    
    func goBack() {
        webView.goBack()
    }

    func saveHistoryItem(_ historyItem: HistoryModel) {
        history.append(historyItem)
        cleanOldHistoryItems()
        saveHistoryToUserDefaults()
    }

    private func saveHistoryToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(history) {
            UserDefaults.standard.set(encoded, forKey: "historyItems")
        }
    }

    private func cleanOldHistoryItems() {
        let currentDate = Date()
        history = history.filter { historyItem in
            let timeDifference = Calendar.current.dateComponents([.month], from: historyItem.timestamp, to: currentDate)
            return (timeDifference.month ?? 0) <= historyLimitMonths
        }
    }

    func loadHistoryItems() {
        if let data = UserDefaults.standard.data(forKey: "historyItems") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([HistoryModel].self, from: data) {
                history = decoded
            }
        }
    }
}
