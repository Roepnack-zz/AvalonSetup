//
//  Character.swift
//  AvalonApp
//
//  Created by M. Paul Weeks on 1/16/16.
//  Copyright © 2016 Scott Roepnack. All rights reserved.
//

enum CharacterID {
    case BasicBlue
    case Merlin
    case Percival
    case BasicRed
    case Assassin
    case Mordred
    case Morgana
    case Oberon
}

protocol Character {
    var id: CharacterID { get }
    var name: String { get }
    var is_red: Bool { get }
    
    func can_see(other: Character) -> Bool
    
    func introduction(playerName: String) -> String
    
    func flavor() -> String
}

struct BasicBlue: Character {
    let id = CharacterID.BasicBlue
    let name = "Servant of Arthur"
    let is_red = false
    
    func can_see(other: Character) -> Bool {
        return false
    }
    
    func introduction(playerName: String) -> String {
        return "You (\(playerName)) are a \(name) (Normal Blue)."
    }
    
    func flavor() -> String {
        return "No flavor text yet."
    }
}

struct Merlin: Character {
    let id = CharacterID.Merlin
    let name = "Merlin"
    let is_red = false
    
    func can_see(other: Character) -> Bool {
        return other.is_red && (other.id != CharacterID.Mordred)
    }
    
    func introduction(playerName: String) -> String {
        return "You (\(playerName)) are \(name) (a member of the blue team)."
    }
    
    func flavor() -> String {
        return "No flavor text yet."
    }
}

struct Percival: Character {
    let id = CharacterID.Percival
    let name = "Percival"
    let is_red = false
    
    func can_see(other: Character) -> Bool {
        return [CharacterID.Merlin, CharacterID.Morgana].contains(other.id)
    }
    
    func introduction(playerName: String) -> String {
        return "You (\(playerName)) are \(name) (a member of the blue team)."
    }
    
    func flavor() -> String {
        return "No flavor text yet."
    }
}

struct BasicRed: Character {
    let id = CharacterID.BasicRed
    let name = "Minion of Mordred"
    let is_red = true
    
    func can_see(other: Character) -> Bool {
        return other.is_red && other.id != CharacterID.Oberon
    }
    
    func introduction(playerName: String) -> String {
        return "You (\(playerName)) are a \(name) (Normal Red)."
    }
    
    func flavor() -> String {
        return "No flavor text yet."
    }
}

struct Assassin: Character {
    let id = CharacterID.Assassin
    let name = "Assassin"
    let is_red = true
    
    func can_see(other: Character) -> Bool {
        return other.is_red && other.id != CharacterID.Oberon
    }
    
    func introduction(playerName: String) -> String {
        return "You (\(playerName)) are the \(name) (a member of a red team)."
    }
    
    func flavor() -> String {
        return "No flavor text yet."
    }
}

struct Mordred: Character {
    let id = CharacterID.Mordred
    let name = "Mordred"
    let is_red = true
    
    func can_see(other: Character) -> Bool {
        return other.is_red && other.id != CharacterID.Oberon
    }
    
    func introduction(playerName: String) -> String {
        return "You (\(playerName)) are \(name) (a member of the red team)."
    }
    
    func flavor() -> String {
        return "No flavor text yet."
    }
}

struct Morgana: Character {
    let id = CharacterID.Morgana
    let name = "Morgana"
    let is_red = true
    
    func can_see(other: Character) -> Bool {
        return other.is_red && other.id != CharacterID.Oberon
    }
    
    func introduction(playerName: String) -> String {
        return "You (\(playerName)) are \(name) (a member of the red team)."
    }
    
    func flavor() -> String {
        return "No flavor text yet."
    }
}

struct Oberon: Character {
    let id = CharacterID.Oberon
    let name = "Oberon"
    let is_red = true
    
    func can_see(other: Character) -> Bool {
        return false
    }
    
    func introduction(playerName: String) -> String {
        return "You (\(playerName)) are \(name) (a member of the red team)."
    }
    
    func flavor() -> String {
        return "No flavor text yet."
    }
}






