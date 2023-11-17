//
//  TabsViewModel.swift
//  SwiftUIWebView
//
//  Created by Delstun McCray on 11/16/23.
//

import Foundation
import UIKit
import SwiftUI

class TabsViewModel: ObservableObject {
    @Published var tabs: [Tab] = []
    
    let mockTabs: [Tab] = [
        Tab(title: "Google", url: "https://www.google.com", timeStamp: Date()),
        Tab(title: "YouTube", url: "https://www.youtube.com", timeStamp: Date()),
        Tab(title: "Twitter", url: "https://www.twitter.com", timeStamp: Date()),
        Tab(title: "Reddit", url: "https://www.reddit.com", timeStamp: Date())
    ]

    
    func createTab(title: String, url: String) {
        let newTab = Tab(title: title, url: url, timeStamp: Date())
        tabs.append(newTab)
        // You can add additional logic here (e.g., saving tabs to UserDefaults).
    }
    
    func loadTabs() {
        // Load tabs from storage (e.g., UserDefaults) if needed.
        // Example: tabs = savedTabsFromUserDefaults
    }
    
    func deleteTab(at indexSet: IndexSet) {
        tabs.remove(atOffsets: indexSet)
        // You can add additional logic here (e.g., updating saved tabs in UserDefaults).
    }
    
    func takeScreenshot(of view: UIView) -> UIImage? {
            let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
            return renderer.image { context in
                view.layer.render(in: context.cgContext)
            }
        }
    
    func assignScreenshotToTab(tab: inout Tab, from view: UIView) {
        if let screenshot = takeScreenshot(of: view) {
            tab.screenshotImage = Image(uiImage: screenshot)
            // Optionally, you can save the screenshot in tab for future use or persistence.
        }
    }
}
