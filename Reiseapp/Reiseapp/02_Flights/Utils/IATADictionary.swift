//
//  IATADictionary.swift
//  Reiseapp
//
//  Created by Jeff Braun on 12.09.25.
//

import Foundation

private let localCityToIATA: [String: String] = [
    // Deutschland
    "berlin": "BER",
    "hamburg": "HAM",
    "frankfurt": "FRA",
    "münchen": "MUC",
    "munich": "MUC",
    "köln": "CGN",
    "cologne": "CGN",
    "düsseldorf": "DUS",
    "duesseldorf": "DUS",
    "stuttgart": "STR",
    "hannover": "HAJ",
    "bremen": "BRE",
    "nürnberg": "NUE",
    "nuernberg": "NUE",
    "leipzig": "LEJ",
    "dresden": "DRS",

    // Europa
    "amsterdam": "AMS",
    "brüssel": "BRU",
    "brussels": "BRU",
    "paris": "CDG",
    "london": "LHR", // Heathrow
    "london gatwick": "LGW",
    "zürich": "ZRH",
    "zurich": "ZRH",
    "genf": "GVA",
    "geneva": "GVA",
    "wien": "VIE",
    "vienna": "VIE",
    "madrid": "MAD",
    "barcelona": "BCN",
    "rom": "FCO",
    "rome": "FCO",
    "mailand": "MXP",
    "milan": "MXP",
    "oslo": "OSL",
    "stockholm": "ARN",
    "kopenhagen": "CPH",
    "copenhagen": "CPH",
    "helsinki": "HEL",
    "warsaw": "WAW",
    "warszawa": "WAW",
    "prag": "PRG",
    "prague": "PRG",
    "budapest": "BUD",

    // Nordamerika
    "new york": "JFK", // Hauptflughafen
    "nyc": "JFK",
    "los angeles": "LAX",
    "san francisco": "SFO",
    "miami": "MIA",
    "chicago": "ORD",
    "toronto": "YYZ",
    "vancouver": "YVR",
    "montreal": "YUL",

    // Asien
    "tokio": "HND",
    "tokyo": "HND",
    "singapur": "SIN",
    "singapore": "SIN",
    "hongkong": "HKG",
    "shanghai": "PVG",
    "peking": "PEK",
    "beijing": "PEK",
    "dubai": "DXB",
    "istanbul": "IST",
    "moskau": "SVO",
    "moscow": "SVO",

    // Ozeanien
    "sydney": "SYD",
    "melbourne": "MEL",
    "auckland": "AKL",

    // Südamerika
    "rio de janeiro": "GIG",
    "são paulo": "GRU",
    "sao paulo": "GRU",
    "buenos aires": "EZE"
]
