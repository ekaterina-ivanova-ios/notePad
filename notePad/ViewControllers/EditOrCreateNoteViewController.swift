//
//  EditOrCreateNoteViewController.swift
//  notePad
//
//  Created by Екатерина Иванова on 23.08.2022.
//

import UIKit

enum Mission {
    case edit, create
}

class EditOrCreateNoteViewController: UIViewController {
    
    var delegate: ViewControllerDelegateProtocol?
    
    private var mission: Mission
    
    private var textView: UITextView = {
        let textView = UITextView()
        
        return textView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.view.addSubview(textView)
        textView.frame = view.frame
    }
 
    init(mission: Mission) {
        self.mission = mission
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditOrCreateNoteViewController {
    
    
    func createOrEditNote() {
        //если пользователь нажал на кнопку add, то создаем новую ячейку
        if {
        delegate?.createNote()
        } else {
        //созраняем изменения в существующей ячейке
        delegate?.editNote()
        }
    }
}
