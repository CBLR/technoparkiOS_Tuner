//
//  ReferenceConstants.swift
//  TP_Tuner
//
//  Created by Roman Babajanyan on 04.11.2020.
//

import Foundation
import FirebaseDatabase
import CodableFirebase

class ReferenceConstants {
	
	static let shared = ReferenceConstants()
	
	var rootId = ""
	
	var tunningsId = "Tunnings"
	
	var allGenres = "Genres"
	
	var allBands = "Bands"
	
	// rockBands.sorted { $0 < $1 }
	
	
	struct Artist: Codable {
		
		var name: String
		var genres: [String: String]?
	}
	
	func uploadData() {
		
		var rockBands = ["Led Zeppelin", "Kasabian", "Kiss", "KoRn", "Megadeth", "Metallica", "Michael Jackson", "System of a Down", "The Misfits", "Sabaton", "Limp Bizkit", "PAIN", "Rammstein", "Lindemann", "Powerwolf", "Muse", "Radiohead", "Green Day", "Twenty One Pilots", "Bring Me The Horizon", "Coldplay", "One Republic", "Nickelback", "David Bowie", "Pink Floyd", "Breaking Benjamin", "My Chemical Romance", "Deftones", "Sum 41", "Slipknot", "Gorillaz", "Dire Straits", "Disturbed", "Iron Maiden", "AC/DC", "Depeche Mode", "Guns N’ Roses", "The Rolling Stones", "Black Sabbath", "Manowar", "Alice In Chains", "Nightwish", "Gojira", "The Beatles", "Rage Against The Machine", "Red Hot Chili Peppers", "Nirvana", "Queen", "Pantera", "Deep Purple", "Ozzy Osbourne", "Van Halen", "Arctic Monkeys", "Bullet For My Valentine", "Hypocrisy", "Apocalyptica", "Amon Amarth", "The Who", "Blink-182", "The Offspring", "Emigrate", "Avatar", "In flames", "Abbath", "Bon Jovi", "Marilyn Manson", "Five Fingers Death Punch", "Static X", "Skillet", "Behemoth", "Scorpions", "Evanescence", "Dope", "Ramones", "Godsmack", "Thousand Foot Krutch", "Motörhead", "Mötley Crüe", "Aerosmith", "A Day to Remember", "Soundgarden", "Shinedown", "Asking Alexandria", "Ghost", "Slayer", "Within Temptation", "Judas Priest", "Helloween", "Children of Bodom", "Sunrise Avenue", "Stone Sour", "The Cure", "Dead by April", "U2", "Killers", "The Doors", "Three Days Grace", "Stone Temple Pilots", "Nine Inch Nails", "ZZ Top", "White zombie", "Jinjer", "Betraying the Martyrs", "Breakdown of Sanity", "Whitechapel", "Architects", "Mudvayne", "Tool", "Avenged Sevenfold", "Linkin Park", "Lamb of God", "Ill Niño", "Trivium", "Parkway Drive", "Machine Head", "Dio", "Twisted Sister", "Accept", "W.A.S.P.", "Anthrax", "Skid Row", "Tank", "Exodus", "Hollywood Undead", "Hollywood Vampires", "Scars on Broadway (Daron Malakian)", "Death", "Coven", "HELLYEAH", "DevilDriver", "Cavalera Conspiracy", "Dimmu Borgir", "In This Moment", "Jonathan Davis", "Drowning Pool", "Down", "Staind", "Coal Chamber", "Starset", "Mushroomhead", "Crazy Town", "Powerman 5000", "P.O.D.", "Motionless in White", "The Pretty Reckless", "Guano Apes", "Billy Talent", "Seether", "Saint Asonia", "The Rasmus", "HIM", "Halestorm", "Foo Fighters", "Black Veil Brides", "Paramore", "The Smashing Pumpkins", "Oasis", "3 Doors Down", "Egypt Central", "Queens of the Stone Age", "Pearl Jam", "Kings of Leon", "Good Charlotte", "Whitesnake", "Maroon 5", "Placebo", "Fever333", "Blur", "The White Stripes", "Foals", "Klaxons", "The Smiths", "Anathema", "Lacuna Coil"]
		
		rockBands = rockBands.sorted { $0 < $1 }
		
		var genres = ["punk": "Punk rock", "aRock": "Alternative Rock", "glam": "Glam rock", "smphRock": "Symphonic rock", "psyd": "Psychedelic Rock", "space": "Space Rock", "indstrlRock": "Industrial Rock", "metal": "Metal", "blckMetal":"Black Metal", "dthMetal": "Death Metal", "grvMetal": "Groove Metal", "metalcore": "Metalcore", "extrMetal": "Extreme Metal", "dthCore": "Deathcore", "altMetal": "Alternative Metal", "numetal": "Nu Metal", "indstrlMetal": "Industrial Metal", "hrdRock": "Hard Rock", "gthMetal": "Gothic Metal", "hvMetal": "Heavy Metal", "pwrMetal": "Power Metal", "flkMetal": "Folk Metal", "spdMetal": "Speed Metal", "rnr": "Rock 'n' Roll ", "prgRock": "Progressive Rock", "blsRock": "Bluse-Rock", "flkRock": "Folk Rock", "elctrRock": "Electronic Rock", "indRock": "Indie Rock", "popRock": "Pop Rock", "artRock": "Art Rock", "glmMetal": "Glam Metal", "shckRock": "Shock Rock", "fnkMetal": "Funk Metal", "trshMetal": "Thrash Metal", "rMetal": "Rap Metal", "rapCore": "Rapcore", "smph": "Symphonic Metal", "grng": "Grunge","pstGrunge": "Post Grunge", "popPunk": "Pop-Punk", "reggae": "Reggae", /*"alt": "Alternative",*/ "postHardcore":"Post-Hardcore", "prgMetal": "Prog Metal", "progMetalcore": "Prog Metalcore", "newWave": "New Wave"]
		
		var covers = ["numetal": "Soad", "altMetal": "BMTH", "metalcore": "BreakdownOfSanity", "aRock": "LinkinPark", "blsRock": "DOORS", "fnkMetal": "KORN", "prgRock": "Muse", "indstrlMetal": "Rammstein", "hrdRock": "Soundgarden", "grng": "Nirvana", "pstGrunge": "ThousandFootKrutch", "popRock": "ZZTOP", "rapCore": "LimpBizkit"]
		
//		for i in 0..<rockBands.count {
//
//			let data = try! FirebaseEncoder().encode(Artist(name: rockBands[i], genres: genres))
//			Database.database().reference(withPath: "Bands").child("b\(i+1)").setValue(data)
//		}
		
		genres.forEach { (key, value) in
			
			var imageCoverId: String?
			
			if let cover = covers[key] {
				imageCoverId = cover
			}
			
			let genre = Genre(title: value, subGenre: nil, imageStringTitle: imageCoverId)
			let data = try! FirebaseEncoder().encode(genre)
			Database.database().reference(withPath: "Genres").child("\(key)").setValue(data)
		}
	}
}
