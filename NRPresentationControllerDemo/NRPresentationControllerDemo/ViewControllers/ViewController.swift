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
        if self.presentationController != nil {
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
//        let navi = UINavigationController(rootViewController: controller)
//        navi.modalPresentationStyle = modalPresentationStyle
//
//        // 设置popover
//        navi.preferredContentSize = CGSize(width: 200.0, height: 200.0)
//        navi.popoverPresentationController?.sourceView = popButton
//        navi.popoverPresentationController?.sourceRect = popButton.bounds
//        navi.popoverPresentationController?.permittedArrowDirections = .up
        
        controller.preferredContentSize = CGSize(width: 200.0, height: 200.0)
        controller.popoverPresentationController?.sourceView = popButton
        controller.popoverPresentationController?.sourceRect = popButton.bounds
        controller.popoverPresentationController?.permittedArrowDirections = .any
        
//        controller.preferredContentSize = CGSize(width: 200.0, height: 200.0)
//        controller.popoverPresentationController?.sourceView = popButton
//        controller.popoverPresentationController?.sourceRect = popButton.bounds
//        controller.popoverPresentationController?.permittedArrowDirections = .up
        
        
        print("\(#function) modalPresentationStyle: \(modalPresentationStyle.rawValue)")
        navigationController?.present(controller, animated: true, completion: {
            print("\(#function) finished")
        })
    }
    
    @IBAction func nr_push(_ sender: Any) {
        
    }
    
    @IBAction func nr_pop(_ sender: Any) {
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let navi = UINavigationController(rootViewController: presented);
        let presentationController = NRPresentationController(presentedViewController: navi, presenting: presenting)
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
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
