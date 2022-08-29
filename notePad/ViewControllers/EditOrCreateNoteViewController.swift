//
//  EditOrCreateNoteViewController.swift
//  notePad
//
//  Created by Екатерина Иванова on 23.08.2022.
//

import UIKit
import RealmSwift

enum Mission {
    case edit, create
}

class EditOrCreateNoteViewController: UIViewController {
    
    weak var delegate: EditOrCreateViewControllerDelegate?
    let realm = try! Realm()
    
    private var mission: Mission
    private var noteModel: NoteModel?
    private var indexPathOfEditedNote: IndexPath?
    private var addAction: (() -> ())?
    private var textView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.view.addSubview(textView)
        textView.frame = view.frame
        textView.text = noteModel?.text 
    }
 
    init(mission: Mission,
        addAction: (() -> ())?) {
        self.mission = mission
        self.addAction = addAction
        super.init(nibName: nil, bundle: nil)
    }
    
    init(mission: Mission, note: NoteModel,indexPath: IndexPath ) {
        self.mission = mission
        self.noteModel = note
        self.indexPathOfEditedNote = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        createOrEditNote()
    }
}

extension EditOrCreateNoteViewController {

    func createOrEditNote() {
        if mission == .create {
            try! realm.write {
                let note = NoteModelRealm()
                note.text = textView.text
                note.date = Date()
                realm.add(note)
            }
            
            //addAction?(textView.text)
            addAction?()
            print(realm.objects(NoteModelRealm.self))
        } else if mission == .edit {
        //созраняем изменения в существующей ячейке -- от чего отталкиваемся?
           
            let note = realm.objects(NoteModelRealm.self).first { model in
                model.date == noteModel?.dateOfCreation
            }
            try! realm.write {
                guard let note = note else { return }
                realm.delete(note)
                let noteToAdd = NoteModelRealm()
                noteToAdd.text = textView.text
                noteToAdd.date = Date()
                realm.add(noteToAdd)
            }
            
            delegate?.editNote(text: textView.text, indexPath: indexPathOfEditedNote ?? IndexPath(row: 0, section: 0))
        }
    }
}
