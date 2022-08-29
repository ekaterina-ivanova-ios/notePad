//
//  ViewControllerDelegate.swift
//  notePad
//
//  Created by Екатерина Иванова on 25.08.2022.
//

import Foundation

protocol EditOrCreateViewControllerDelegate: AnyObject {
//    func createNote(text: String)
    func editNote(text: String, indexPath: IndexPath)
}
