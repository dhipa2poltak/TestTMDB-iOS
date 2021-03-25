//
//  BaseVM.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

class BaseVM: NSObject {
    private var owner: String = ""

    override init() {
        super.init()
    }

    convenience init(vc: BaseVC) {
        self.init()
        owner = addressString(vc)
    }

    func didLayout() {
        print("POST: layouting-\(type(of: self))")
        NotificationCenter.default.post(name: NSNotification.Name("layouting-\(owner)"),
                                        object: nil)
    }
}
