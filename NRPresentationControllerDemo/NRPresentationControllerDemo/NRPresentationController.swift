//
//  NRPresentationController.swift
//  NRPresentationControllerDemo
//
//  Created by NicoRobine on 2020/11/27.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

import UIKit

class NRPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            return super.frameOfPresentedViewInContainerView;
        }
    }
    
    override var adaptivePresentationStyle: UIModalPresentationStyle {
        get {
            return super.adaptivePresentationStyle;
        }
    }
    
    override var shouldPresentInFullscreen: Bool {
        return super.shouldPresentInFullscreen
    }
    
    override var shouldRemovePresentersView: Bool {
        return super.shouldPresentInFullscreen
    }
    
    override func containerViewWillLayoutSubviews() {
        print("\(#function) in class \(type(of: self))")
        super.containerViewWillLayoutSubviews();
    }
    
    override func containerViewDidLayoutSubviews() {
        print("\(#function) in class \(type(of: self))")
        super.containerViewDidLayoutSubviews();
    }
    
    override func presentationTransitionWillBegin() {
        print("\(#function) in class \(type(of: self))")
        super.presentationTransitionWillBegin();
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin();
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
    }
}
