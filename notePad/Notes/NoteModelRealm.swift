//
//  NoteModelRealm.swift
//  notePad
//
//  Created by Екатерина Иванова on 27.08.2022.
//

import Foundation
import RealmSwift

class NoteModelRealm: Object {
    @Persisted var text: String = ""
   // @Persisted var date: String = ""
    @Persisted var date: Date 
}
