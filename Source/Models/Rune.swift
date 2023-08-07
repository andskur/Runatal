//
//  Rune.swift
//  Runatal
//
//  Created by Andrey Skurlatov on 30.7.23..
//

import Foundation
import CoreData

public class Rune: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var symbol: String
    @NSManaged public var name: String
    @NSManaged public var meaning: MeaningTranslation // Use the Translation type
    @NSManaged public var sound: String
    @NSManaged public var index: Int16
    @NSManaged public var strophes: NSSet?
        
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
}

