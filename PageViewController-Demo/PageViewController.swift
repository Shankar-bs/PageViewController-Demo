//
//  PageViewController.swift
//  PageViewController-Demo
//
//  Created by Shankar B S on 14/03/20.
//  Copyright © 2020 Slicode. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    //1
    var pageIndex: Int = 0
    @IBOutlet weak var pageIndexLabel: UILabel!
    
    @IBOutlet weak var pageContentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pageIndexLabel.text = "Page Index: \(pageIndex)"
    }
}
