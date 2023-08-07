//
//  Note.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 7.8.23..
//

import Foundation
import CoreData

public class Note: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var text: String
    @NSManaged public var translation: Translation?
    @NSManaged public var index: Int16
    @NSManaged public var strophe: Strophe
    
//    @objc(addStropheObject:)
//    @NSManaged public func addToStrophe(_ value: Strophe)
    
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
}
