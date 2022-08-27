//
//  ViewControllerDelegate.swift
//  notePad
//
//  Created by Екатерина Иванова on 25.08.2022.
//

import Foundation

protocol ViewControllerDelegate {
    func createNote(tableView: ListOfNotesViewController)
    func editNote(tableView: ListOfNotesViewController)
}
