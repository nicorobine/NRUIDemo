//
//  ViewController.swift
//  NRPresentationControllerDemo
//
//  Created by NicoRobine on 2020/11/27.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var popButton: UIButton!
    
    var adaptiveDelegate: NRAdaptivePresentationControllerDelegate?
    
    let setting: NRPresentationSettingViewController = NRPresentationSettingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
        popoverPresentationController?.delegate = self
    }
    
    @IBAction func toSetting(_ sender: Any) {
        navigationController?.pushViewController(setting, animated: true)
    }
    
    @IBAction func nr_cancel(_ sender: Any) {
        if self.presentingViewController != nil {
            self.dismiss(animated: true) {
                print("\(#function) finished")
            }
        }
    }
    
    @IBAction func nr_present(_ sender: Any) {
        let controller = storyboard!.instantiateViewController(identifier: "ViewController")
        //        let controller = NRTipsViewController(with: "测试测试")
        
        let modalPresentationStyle = setting.setting.modalPresentionStyle
        controller.modalPresentationStyle = modalPresentationStyle
        controller.transitioningDelegate = self
        let navi = UINavigationController(rootViewController: controller)
        navi.modalPresentationStyle = modalPresentationStyle
        navi.transitioningDelegate = self
        
        // 设置popover
        navi.preferredContentSize = CGSize(width: 200.0, height: 200.0)
        navi.popoverPresentationController?.sourceView = popButton
        navi.popoverPresentationController?.sourceRect = popButton.bounds
        navi.popoverPresentationController?.permittedArrowDirections = .up
        
        adaptiveDelegate = NRAdaptivePresentationControllerDelegate()
        navi.presentationController?.delegate = adaptiveDelegate
        
        print("\(#function) modalPresentationStyle: \(modalPresentationStyle.rawValue)")
        navigationController?.present(navi, animated: true, completion: {
            print("\(#function) finished")
        })
    }
    
    @IBAction func nr_push(_ sender: Any) {
        
    }
    
    @IBAction func nr_pop(_ sender: Any) {
        if self.presentingViewController != nil {
            self.dismiss(animated: true) {
                print("\(#function) finished")
            }
        }
    }
    
    @IBAction func nr_popover(_ sender: Any) {
        
        // 导航上的其它barButtonItem仍然可以点击，popoverPresentationController
        // 会自动把其它的barButtonItem添加到
        
        let controller = storyboard!.instantiateViewController(identifier: "ViewController")
        controller.transitioningDelegate = self
        let navi = UINavigationController(rootViewController: controller)
        navi.modalPresentationStyle = .popover
        navi.transitioningDelegate = self
        
        // 设置popover
        navi.preferredContentSize = CGSize(width: 200.0, height: 200.0)
        navi.popoverPresentationController?.permittedArrowDirections = .up
        navi.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems?[1]
        navi.popoverPresentationController?.passthroughViews = [popButton];
        
        adaptiveDelegate = NRAdaptivePresentationControllerDelegate()
        navi.presentationController?.delegate = adaptiveDelegate
        
        print("\(#function) modalPresentationStyle: \(modalPresentationStyle.rawValue)")
        navigationController?.present(navi, animated: true, completion: {
            print("\(#function) finished")
        })
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        var controller = presented
        
        if !controller.isKind(of: UINavigationController.self) {
            controller = UINavigationController(rootViewController: presented);
        }
        
        let presentationController = NRPresentationController(presentedViewController: controller, presenting: presenting)
        return presentationController;
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

extension ViewController : UIPopoverPresentationControllerDelegate {
    
    func popoverPresentationController(_ popoverPresentationController: UIPopoverPresentationController, willRepositionPopoverTo rect: UnsafeMutablePointer<CGRect>, in view: AutoreleasingUnsafeMutablePointer<UIView>) {
        print("\(#function)")
    }
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        print("\(#function)")
    }
    
    // ios13弃用
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    // ios 13弃用
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
