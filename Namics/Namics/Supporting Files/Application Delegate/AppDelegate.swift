//
//  AppDelegate.swift
//  Namics
//
//  Created by Administrator on 21.09.17.
//  Copyright © 2017 Namics. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    var window: UIWindow?
    
    // MARK: - Private API
    private func loadRates() {
        RESTManager.shared.loadData(from: Urls.rates, method: .get, parameters: nil) { (success, response) in
            if let response = response as? JSON {
                if let rates = response[Keys.quotes] as? JSON {
                    DataManager.shared.rates = rates
                    print("Rates fetched successfully")
                }
            }
        }
    }

    // MARK: - UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        loadRates()
        
        return true
    }

}
