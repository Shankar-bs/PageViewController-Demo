//
//  ViewController.swift
//  PageViewController-Demo
//
//  Created by Shankar B S on 14/03/20.
//  Copyright © 2020 Slicode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pageControllerHolderView: UIView!
    lazy var pageViewController: UIPageViewController = {
       return UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupPageViewController()
    }
    
    func setupPageViewController() {
        //set its datasource and delegate methods
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        self.pageViewController.view.frame = .zero
        
        //Show view controller with initial page - page zero
        let pageController = getPageFor(index: 0)
        guard let initialPageController = pageController else { return }
        self.pageViewController.setViewControllers([initialPageController], direction: .forward, animated: false, completion: nil)
        self.addChild(self.pageViewController)
        
        //Add to holder view
        self.pageControllerHolderView.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParent: self)
       
        //Pin to super view - (holder view)
        self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.pageViewController.view.topAnchor.constraint(equalTo: self.pageControllerHolderView.topAnchor).isActive = true
        self.pageViewController.view.leftAnchor.constraint(equalTo: self.pageControllerHolderView.leftAnchor).isActive = true
        self.pageViewController.view.bottomAnchor.constraint(equalTo: self.pageControllerHolderView.bottomAnchor).isActive = true
        self.pageViewController.view.rightAnchor.constraint(equalTo: self.pageControllerHolderView.rightAnchor).isActive = true
    }
    
    //Helper method to create view controllers for page view controller
    //for specified index
    func getPageFor(index: Int) -> PageViewController? {
        guard  let pageController  = self.storyboard?.instantiateViewController(identifier: "PageViewController") as? PageViewController else { return nil }
        pageController.pageIndex = index
        return pageController
    }
}

extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore
        viewController: UIViewController) -> UIViewController? {
        guard let beforePage = viewController as? PageViewController else { return nil }
        let beforePageIndex = beforePage.pageIndex
        //since it is before we need to go back the index
        let newIndex = beforePageIndex - 1
        if newIndex < 0 { return nil }
        return getPageFor(index: newIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let afterPage = viewController as? PageViewController else { return nil }
        let afterPageIndex = afterPage.pageIndex
        //since it is after we need to go forword
        let newIndex = afterPageIndex + 1
        if newIndex < 0 { return nil }
        return getPageFor(index: newIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    }
}

