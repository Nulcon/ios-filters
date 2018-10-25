//
//  ViewController.swift
//  ios-filters-mac-app
//
//  Created by Conner on 10/25/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Cocoa

class ImageFilterViewController: NSViewController, DragProtocol {
    func dragged(fileAtURL URL: NSURL) {
        imageView.isHidden = false
        imageView.image = NSImage(byReferencing: URL as URL)
        dragAnImageLabel.isHidden = true
    }
    
    private let filter = CIFilter(name: "CIColorControls")!
    
    @IBOutlet var imageView: NSImageView!
    @IBOutlet var dragAnImageLabel: NSTextField!
    @IBOutlet var dragView: DragView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dragView.delegate = self
    }
}

