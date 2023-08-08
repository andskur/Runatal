//
//  Strophe.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 6.8.23..
//

import Foundation
import CoreData

public class Strophe: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var text: String
    @NSManaged public var translation: Translation // Use the Translation type
    @NSManaged public var index: Int16
    @NSManaged public var runePoem: RunePoem
    @NSManaged public var runes: NSSet?
    @NSManaged public var notes: NSSet?
    
    @objc(addRunesObject:)
    @NSManaged public func addToRunes(_ value: Rune)
    
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
}
