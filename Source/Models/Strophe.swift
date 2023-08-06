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
    
    @objc(addRunesObject:)
    @NSManaged public func addToRunes(_ value: Rune)
    
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
}


@objc(Translation)
public class Translation: NSObject, NSCoding {
    var english: String
    var russian: String
    
    init(english: String, russian: String) {
        self.english = english
        self.russian = russian
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        guard let english = aDecoder.decodeObject(forKey: "english") as? String else { return nil }
        guard let russian = aDecoder.decodeObject(forKey: "russian") as? String else { return nil }
        self.init(english: english, russian: russian)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(english, forKey: "english")
        aCoder.encode(russian, forKey: "russian")
    }
}
