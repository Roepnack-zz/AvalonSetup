//
//  CharacterService.swift
//  AvalonApp
//
//  Created by M. Paul Weeks on 1/16/16.
//  Copyright © 2016 Scott Roepnack. All rights reserved.
//
import UIKit
import Darwin

class PlayerMeta: CustomStringConvertible {
    var name: String
    var email: String
    var id: String
    var character: Character?
    var sees: [PlayerMeta]
    
    init(playerStruct: Player){
        name = playerStruct.name
        email = playerStruct.email
        id = email
        character = nil
        sees = [PlayerMeta]()
    }
    
    var description: String {
        return "This is a player meta object"
    }
    
    func secretMessage() -> String {

        var names = String()
        
        var localSees = sees
        
        var retVal = String()

        retVal = (character?.introduction(name))! + "\n\n"
        
        if localSees.count == 0 {
            retVal += "You see nothing."
        }
        else if localSees.count == 1 {
            retVal += "You see \(localSees[0].name)."
        }
        else {
            let allButLast = localSees.removeAtIndex(localSees.count - 1)
            for p in localSees {
                names += p.name + ", "
            }
            names.characters.dropLast(2)
            names += "and \(allButLast.name)"
            retVal += "You see \(names)."
        }
        return retVal
    }
}

class CharacterDisplayViewModel {
    var character: Character
    var quantity: Int = 0
    
    init(character: Character) {
        self.character = character
    }
}

struct CharacterSubmitViewModel {
    var players: [Player]
    var characters: [CharacterID: Int]
}

class CharacterHandler {
    let CharacterTypes: [Character] = [
        Merlin(),
        Percival(),
        BasicBlue(),
        Assassin(),
        Mordred(),
        Morgana(),
        Oberon(),
        BasicRed(),
    ]
    
    func getAllCharacters() -> [Character]{
        return CharacterTypes
    }
    
    func getCharacterById(character_id: CharacterID) -> Character {
        for character_type in getAllCharacters() {
            if character_type.id == character_id {
                return character_type
            }
        }
        // fuck this
        return BasicBlue()
    }
    
    func getDefaults(numPlayers: Int) -> [CharacterDisplayViewModel] {
        var hash = [CharacterID: CharacterDisplayViewModel]()
        for char in getAllCharacters() {
            hash[char.id] = CharacterDisplayViewModel(character: char)
        }
        hash[CharacterID.Merlin]!.quantity = 1
        hash[CharacterID.BasicBlue]!.quantity = 2
        hash[CharacterID.Assassin]!.quantity = 1
        hash[CharacterID.Mordred]!.quantity = 1
        
        if numPlayers >= 6 {
            hash[CharacterID.Percival]!.quantity += 1
        }
        if numPlayers >= 7 {
            hash[CharacterID.Morgana]!.quantity += 1
        }
        if numPlayers >= 8 {
            hash[CharacterID.BasicBlue]!.quantity += 1
        }
        if numPlayers >= 9 {
            hash[CharacterID.BasicBlue]!.quantity += 1
        }
        if numPlayers >= 10 {
            hash[CharacterID.BasicRed]!.quantity += 1
        }
        
        var out = [CharacterDisplayViewModel]()
        for (_, vm) in hash {
            out.append(vm)
        }
        return out
    }
    
    func createPlayerMeta(playerStruct: Player) -> PlayerMeta {
        return PlayerMeta(playerStruct: playerStruct)
    }
    
    func submitCharacters(viewModel: CharacterSubmitViewModel){
        let players = viewModel.players.map(createPlayerMeta)
        
        var character_pool = [CharacterID]()
        for (character_id, quantity) in viewModel.characters {
            if quantity > 0 {
                for _ in 1...quantity {
                    character_pool.append(character_id)
                }
            }
        }
        if character_pool.count != players.count {
            // raise exception
            return
        }
        
        for player in players {
            let character_length = UInt32(character_pool.count)
            let character_index = Int(arc4random_uniform(character_length))
            let character_id = character_pool.removeAtIndex(character_index)
            let character = getCharacterById(character_id)
            player.character = character
        }
        
        for p1 in players {
            for p2 in players {
                if !(p1.id == p2.id && p1.name == p2.name){
                    if p1.character!.can_see(p2.character!) {
                        p1.sees.append(p2)
                    }
                }
            }
        }
        
        let firstPlayer = "\(players[(Int(arc4random()) % players.count)].name) goes first."
        
        MessageSender().sendMessages(players, firstPlayer: firstPlayer)
    }
}
