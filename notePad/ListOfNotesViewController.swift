//
//  ViewController.swift
//  notePad
//
//  Created by Екатерина Иванова on 23.08.2022.
//

import UIKit


enum StateOfList {
    case empty, notEmpty
}

final class ListOfNotesViewController: UIViewController {
    
    private var notes: [NoteModel] = [NoteModel(text: "Go to shop", dateOfCreation: Date()),
                                      NoteModel(text: "Go to shop2", dateOfCreation: Date())]
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteCell.self, forCellReuseIdentifier: "NoteCell")
        return tableView
    }()
    
//    private lazy var label: {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notes"
        self.view.backgroundColor = .systemGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        //addtarget
        if notes.isEmpty {
            setupViewFor(state: .empty)
        } else {
            setupViewFor(state: .notEmpty)
        }
    }

    private func setupViewFor(state: StateOfList) {
        switch state {
        case .empty:
            setupEmptyView()
        case .notEmpty:
            setupTableView()
        }
    }
    
    // создается пустое вью
    private func setupEmptyView() {
        
    }
    
    // создается табличка
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    // нажатие на кнопку в навигеййшн баре
    @objc func addTapped() {
        let vc = EditOrCreateNoteViewController(mission: .create)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListOfNotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteCell
        let note = notes[indexPath.row]
        let dateFormatter = DateFormatter()
        let stringDate = dateFormatter.string(from: note.dateOfCreation)
        let cellModel = NoteCellModel(noteLabelText: note.text, dateLabelText: stringDate)
        cell?.configureCell(cellModel: cellModel)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    // этот метод автоматически вызывается при нажатии на ячейку, также передается индекс паф ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = EditOrCreateNoteViewController(mission: .create, note: NoteModel)
        let vc = EditOrCreateNoteViewController(mission: .create)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
