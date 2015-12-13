//
//  ViewController.swift
//  ScrollableViews
//
//  Created by Joe E. on 12/13/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

private let VIEW1 = "View1"
private let VIEW2 = "View2"
private let VIEW3 = "View3"

class ViewController: UIViewController {

    //MARK: @IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Creating our three viewControllers that will each contain their own view
        let view1 = UIViewController(nibName: VIEW1,
            bundle: nil)
        let view2 = UIViewController(nibName: VIEW2, bundle: nil)
        let view3 = UIViewController(nibName: VIEW3, bundle: nil)
        
        //Adding our views to the viewControllers
        scrollView.addSubview(view1.view)
        scrollView.addSubview(view2.view)
        scrollView.addSubview(view3.view)
        
        //Laying out the different views in the scrollView
        view2.view.frame.origin.x = view.frame.width
        view3.view.frame.origin.x = view.frame.width * 2
        
        //Adjusting the size of the scrollViews
        scrollView.contentSize = CGSize(width: view.frame.width * 3, height: view.frame.height)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

}