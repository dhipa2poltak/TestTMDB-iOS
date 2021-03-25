//
//  BaseVC.swift
//  TestTMDB
//
//  Created by user on 24/03/21.
//

import Foundation

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }

    func setupNavBar(transparant: Bool) {
        guard let navController = navigationController else { return }

        navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,
                                                           .font: UIFont.preferredFont(forTextStyle: .title1) /* FontFamily.Calibri.bold.font(size: 20) as Any */ ]

        if navController.viewControllers.count > 1 {
            let image = UIImage(named: "ic_back_white")

            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: image,
                style: .plain,
                target: self,
                action: #selector(didTapBack(_:))
            )
        }

        navController.navigationBar.backgroundColor = .white2
        navController.navigationBar.tintColor = .blueAlfa

        let label:UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.size.width - 20, height: 30))
        label.text = "TestTMDB"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left

        self.navigationItem.titleView = label

        /*
        if transparant {
            navController.navigationBar.isTranslucent = true
            navController.navigationBar.setBackgroundImage(
                UIImage(),
                for: .default
            )
            navController.navigationBar.tintColor = .blueAlfa//.white2
            //navController.navigationBar.backgroundColor = .blue
        } else {
            navController.navigationBar.setBackgroundImage(
                #imageLiteral(resourceName: "bg_03").stretchableImage(withLeftCapWidth: 0, topCapHeight: 0),
                for: .default
            )
            navController.navigationBar.isTranslucent = false
            navController.navigationBar.shadowImage = UIImage()
            navController.navigationBar.tintColor = .blueAlfa//.white2
            navController.navigationBar.backgroundColor = .clear
        }

        */
    }

    @objc func didTapBack(_: Any) {
        navigationController?.popViewController(animated: true)
    }

    private func addObserver() {
        print("ADD: layouting-\(addressString(self))")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(layouting(notification:)),
                                               name: NSNotification.Name(rawValue: "layouting-\(addressString(self))"),
                                               object: nil)
    }

    @objc func layouting(notification _: NSNotification? = nil) {}
}
