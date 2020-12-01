//
//  NRPresentationController.swift
//  NRPresentationControllerDemo
//
//  Created by NicoRobine on 2020/11/27.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

import UIKit

class NRPresentationController: UIPresentationController {
    
    fileprivate let _delegate = NRAdaptivePresentationControllerDelegate()
    
    
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            print("\(#function) in class \(type(of: self))")
            return super.frameOfPresentedViewInContainerView;
        }
    }
    
    override var adaptivePresentationStyle: UIModalPresentationStyle {
        get {
            print("\(#function) in class \(type(of: self))")
            
            return NRPresentationSetting.shared.modalPresentionStyle;
        }
    }
    
    override var shouldPresentInFullscreen: Bool {
        print("\(#function) in class \(type(of: self))")
        return super.shouldPresentInFullscreen
    }
    
    override var shouldRemovePresentersView: Bool {
        print("\(#function) in class \(type(of: self))")
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
        print("\(#function) in class \(type(of: self))")
        super.presentationTransitionDidEnd(completed)
    }
    
    override func dismissalTransitionWillBegin() {
        print("\(#function) in class \(type(of: self))")
        super.dismissalTransitionWillBegin();
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        print("\(#function) in class \(type(of: self))")
        super.dismissalTransitionDidEnd(completed)
    }
    
    override var delegate: UIAdaptivePresentationControllerDelegate? {
        get {
            return _delegate
        } set {}
    }
}
