//
//  ViewController.swift
//  PieView
//
//  Created by Shaps Benkau on 20/05/2018.
//  Copyright © 2018 152percent Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var progressView: PieProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.progressView.progress = 1
        }
    }

}
