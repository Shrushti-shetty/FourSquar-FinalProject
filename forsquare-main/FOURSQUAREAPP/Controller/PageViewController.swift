//
//  PageViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 30/12/22.
//

import UIKit
protocol Swipe {
    func scrollToIndex(index: Int)
}

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    var indexDelegate: Swipe?
    
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        if let startingViewController = createContentView(at: 0){
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
        
    
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? ContentViewController{
            var index = vc.index
            print(index,"index")
            indexDelegate?.scrollToIndex(index: index)
            currentPage = index
            index -= 1
            return createContentView(at: index)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? ContentViewController{
            var index = vc.index

            currentPage = index

            index += 1
            return createContentView(at: index)
        }
        return nil
    }
    
    func createContentView(at index: Int) -> ContentViewController?{
        if index < 0 || index >= 5{
            return nil
        }
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController{
        vc.index = index
        return vc
        }
        return nil
    }
    
    func changeIndex(index: Int) {
        
        if let startingViewController = createContentView(at: index){
//            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
            if currentPage == index {
                return
            }
            else if index > currentPage{
                currentPage = index
                setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
            }
            else {
                currentPage = index
                setViewControllers([startingViewController], direction: .reverse, animated: true, completion: nil)
            }
        }
    }

}
