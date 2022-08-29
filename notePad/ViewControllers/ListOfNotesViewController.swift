import UIKit
import RealmSwift

enum StateOfList {
    case empty, notEmpty
}

final class ListOfNotesViewController: UIViewController {
    
    private let realm = try! Realm()
    private var notes: (Results<NoteModelRealm>)?
    //private var notes: [NoteModel] = []
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteCell.self, forCellReuseIdentifier: "NoteCell")
        return tableView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Количество заметок: 0"
        label.frame = CGRect(x: 60, y: 100, width: 200, height: 20)
        //label.frame = view.frame
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notes"
        self.view.backgroundColor = .systemGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        //addtarget
        
        notes = realm.objects(NoteModelRealm.self)
        guard let notes = notes else { return }
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
        view.addSubview(label)
        view.backgroundColor = .systemPink
    }
    
    // создается табличка
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    // нажатие на кнопку в навигейшн баре
    @objc func addTapped() {
        let vc = EditOrCreateNoteViewController(mission: .create) { [weak self]  in
            guard let self = self else { return }
//            let model = NoteModel(text: text, dateOfCreation: Date())
//            self.notes.insert(model, at: 0)
            if self.tableView.superview == nil {
                self.setupTableView()
            }
            self.tableView.reloadData()
        }
        
        //Помещает контроллер представления в стек приемника и обновляет отображение.
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListOfNotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteCell
        guard let notes = notes else { return UITableViewCell() }
        let note = notes[indexPath.row]
        let dateFormatter = DateFormatter()
        let stringDate = dateFormatter.string(from: note.date)
        let cellModel = NoteCellModel(noteLabelText: note.text, dateLabelText: stringDate)
        cell?.configureCell(cellModel: cellModel)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 0
    }
    
    // этот метод автоматически вызывается при нажатии на ячейку, также передается индекс паф ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let notes = notes else { return }
        let note = notes[indexPath.row]
        let otherNote = NoteModel(text: note.text, dateOfCreation: note.date)
        //создаем экземпляр вьюконтроллера, на который собираемся осуществить переход
        let vc = EditOrCreateNoteViewController(mission: .edit, note: otherNote, indexPath: indexPath)
        //назначаем вьюконтроллеру делегата
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ListOfNotesViewController: EditOrCreateViewControllerDelegate {
//    func createNote(text: String) {
//        //необходимо добавить новую ячейку в таблицу
//        print("create")
//        let model = NoteModel(text: text, dateOfCreation: Date())
//        notes.insert(model, at: 0)
//        tableView.reloadData()
//    }
    
    func editNote(text: String, indexPath: IndexPath) {
        //необходимо обновить ячейку в таблице
        print("edit")
//        let model = NoteModel(text: text, dateOfCreation: Date())
//        notes.remove(at: indexPath.row)
//        notes.insert(model, at: 0)
        tableView.reloadData()
    }
    
}
