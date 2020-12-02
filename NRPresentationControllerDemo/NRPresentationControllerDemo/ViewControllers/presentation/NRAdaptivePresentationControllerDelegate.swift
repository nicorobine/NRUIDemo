//
//  NRAdaptivePresentationControllerDelegate.swift
//  NRPresentationControllerDemo
//
//  Created by NicoRobine on 2020/11/27.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

import UIKit

class NRAdaptivePresentationControllerDelegate: NSObject, UIAdaptivePresentationControllerDelegate {
    
    override init() {
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        print("\(#function) in class \(type(of: self))")
        return .automatic;
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        print("\(#function) in class \(type(of: self))")
        return .automatic;
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        print("\(#function) in class \(type(of: self))")
        return nil;
    }
    
    func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
        print("\(#function) in class \(type(of: self))")
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        print("\(#function) in class \(type(of: self))")
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        print("\(#function) in class \(type(of: self))")
    }
    
    /// 被呈现的视图是否可以消失，如果返回false则不会消失
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        print("\(#function) in class \(type(of: self))")
        return true
    }
    
    /// 如果presentationControllerShouldDismiss(_)返回false执行这个回调，
    /// 可以做为什么不让展示的视图控制器消失的弹框提醒
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        print("\(#function) in class \(type(of: self))")
    }
}
