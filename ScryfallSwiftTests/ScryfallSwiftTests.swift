//
//  ScryfallSwiftTests.swift
//  ScryfallSwiftTests
//
//  Created by Roudique on 5/8/18.
//

import XCTest
import ScryfallSwift

class ScryfallSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let json = """
        {
            "object": "card",
            "id": "e6f342b2-1ba6-4b72-9f03-bc076c795b3d",
            "oracle_id": "5546d127-a961-4e33-bbc9-06ee14b0cb04",
            "multiverse_ids": [
                443111
            ],
            "mtgo_id": 67911,
            "name": "Mishra's Self-Replicator",
            "uri": "https://api.scryfall.com/cards/dom/223",
            "scryfall_uri": "https://scryfall.com/card/dom/223?utm_source=api",
            "layout": "normal",
            "highres_image": true,
            "image_uris": {
                "small": "https://img.scryfall.com/cards/small/en/dom/223.jpg?1524792243",
                "normal": "https://img.scryfall.com/cards/normal/en/dom/223.jpg?1524792243",
                "large": "https://img.scryfall.com/cards/large/en/dom/223.jpg?1524792243",
                "png": "https://img.scryfall.com/cards/png/en/dom/223.png?1524792243",
                "art_crop": "https://img.scryfall.com/cards/art_crop/en/dom/223.jpg?1524792243",
                "border_crop": "https://img.scryfall.com/cards/border_crop/en/dom/223.jpg?1524792243"
            },
            "cmc": 5,
            "type_line": "Artifact Creature — Assembly-Worker",
            "oracle_text": "Whenever you cast a historic spell, you may pay {1}. If you do, create a token that's a copy of Mishra's Self-Replicator. (Artifacts, legendaries, and Sagas are historic.)",
            "mana_cost": "{5}",
            "power": "2",
            "toughness": "2",
            "colors": [],
            "color_identity": [],
            "legalities": {
                "standard": "legal",
                "future": "legal",
                "frontier": "legal",
                "modern": "legal",
                "legacy": "legal",
                "pauper": "not_legal",
                "vintage": "legal",
                "penny": "not_legal",
                "commander": "legal",
                "1v1": "legal",
                "duel": "legal",
                "brawl": "legal"
            },
            "reserved": false,
            "foil": true,
            "nonfoil": true,
            "oversized": false,
            "reprint": false,
            "set": "dom",
            "set_name": "Dominaria",
            "set_uri": "https://api.scryfall.com/sets/dom",
            "set_search_uri": "https://api.scryfall.com/cards/search?order=set&q=e%3Adom&unique=prints",
            "scryfall_set_uri": "https://scryfall.com/sets/dom?utm_source=api",
            "rulings_uri": "https://api.scryfall.com/cards/dom/223/rulings",
            "prints_search_uri": "https://api.scryfall.com/cards/search?order=set&q=%21%E2%80%9CMishra%27s+Self-Replicator%E2%80%9D&unique=prints",
            "collector_number": "223",
            "digital": false,
            "rarity": "rare",
            "flavor_text": "It has witnessed history's most significant events, one incarnation after another.",
            "illustration_id": "84e0d6fa-2945-4009-9e0e-5843bff1765f",
            "artist": "Joseph Meehan",
            "frame": "2015",
            "full_art": false,
            "border_color": "black",
            "timeshifted": false,
            "colorshifted": false,
            "futureshifted": false,
            "edhrec_rank": 1868,
            "usd": "0.15",
            "tix": "0.02",
            "eur": "0.15",
            "related_uris": {
                "gatherer": "http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=443111",
                "tcgplayer_decks": "http://decks.tcgplayer.com/magic/deck/search?contains=Mishra%27s+Self-Replicator&page=1&partner=Scryfall",
                "edhrec": "http://edhrec.com/route/?cc=Mishra%27s+Self-Replicator",
                "mtgtop8": "http://mtgtop8.com/search?MD_check=1&SB_check=1&cards=Mishra%27s+Self-Replicator"
            },
            "purchase_uris": {
                "amazon": "https://www.amazon.com/gp/search?ie=UTF8&index=toys-and-games&keywords=Mishra%27s+Self-Replicator&tag=scryfall-20",
                "ebay": "http://rover.ebay.com/rover/1/711-53200-19255-0/1?campid=5337966903&icep_catId=19107&icep_ff3=10&icep_sortBy=12&icep_uq=Mishra%27s+Self-Replicator&icep_vectorid=229466&ipn=psmain&kw=lg&kwid=902099&mtid=824&pub=5575230669&toolid=10001",
                "tcgplayer": "https://scryfall.com/s/tcgplayer/162124",
                "magiccardmarket": "https://scryfall.com/s/mcm/319826",
                "cardhoarder": "https://www.cardhoarder.com/cards/67911?affiliate_id=scryfall&ref=card-profile&utm_campaign=affiliate&utm_medium=card&utm_source=scryfall",
                "card_kingdom": "https://www.cardkingdom.com/catalog/item/217938?partner=scryfall&utm_campaign=affiliate&utm_medium=scryfall&utm_source=scryfall",
                "mtgo_traders": "http://www.mtgotraders.com/deck/ref.php?id=67911&referral=scryfall",
                "coolstuffinc": "https://scryfall.com/s/coolstuffinc/4351931"
            }
        }
        """.data(using: .utf8)!
        
        let jsonDecoder = JSONDecoder()
        let card = try! jsonDecoder.decode(Card.self, from: json)

        assert(card.id.count > 0)
    }
}
