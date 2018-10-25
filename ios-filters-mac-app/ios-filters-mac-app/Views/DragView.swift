//
//  DragView.swift
//  ios-filters-mac-app
//
//  Created by Conner on 10/25/18.
//  Copyright © 2018 Conner. All rights reserved.
//
import Cocoa

protocol DragProtocol {
    func dragged(fileAtURL URL: NSURL)
}

class DragView: NSView {
    private var isCorrectFileType = false
    private var acceptedFileExtensions = ["jpg", "png"]
    var delegate: DragProtocol?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let NSFilenamesPboardTypeTemp = NSPasteboard.PasteboardType("NSFilenamesPboardType")
        registerForDraggedTypes([NSFilenamesPboardTypeTemp])
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        isCorrectFileType = checkExtension(drag: sender)
        return []
    }

    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        return isCorrectFileType ? .copy : []
    }

    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let url = sender.fileURL else { return false }
        if isCorrectFileType { delegate?.dragged(fileAtURL: url) }
        return true
    }

    fileprivate func checkExtension(drag: NSDraggingInfo) -> Bool {
        guard let fileExtension = drag.fileURL?.pathExtension?.lowercased() else {
            return false
        }
        return acceptedFileExtensions.contains(fileExtension)
    }
}

extension NSDraggingInfo {
    var fileURL: NSURL? {
        let NSFilenamesPboardTypeTemp = NSPasteboard.PasteboardType("NSFilenamesPboardType")
        let filenames = draggingPasteboard.propertyList(forType: NSFilenamesPboardTypeTemp) as? [String]
        let pathToFirstFile = filenames?.first

        return pathToFirstFile.map(NSURL.init)
    }
}

