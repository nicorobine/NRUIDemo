//
//  ViewController.swift
//  NRPresentationControllerDemo
//
//  Created by NicoRobine on 2020/11/27.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let settting: NRPresentationSetting = NRPresentationSetting.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
    }
    
    @IBAction func toSetting(_ sender: Any) {
        
    }
    
    @IBAction func nr_present(_ sender: Any) {
    }
    
    @IBAction func nr_push(_ sender: Any) {
    }
    
    @IBAction func nr_pop(_ sender: Any) {
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return NRPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}

