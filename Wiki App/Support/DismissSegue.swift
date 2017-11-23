//
//  DismissSegue.swift
//  Wiki App
//
//  Created by Mayank Gupta on 04/11/17.
//  Copyright © 2017 Mayank Gupta. All rights reserved.
//

import UIKit

class DismissSegue: UIStoryboardSegue {
    override func perform() {
        let sourceViewController = self.source
        sourceViewController.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
