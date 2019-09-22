//
//  Language.swift
//  
//
//  Created by Henrik Panhans on 06.08.19.
//

import Foundation

/// Enum to specify the language used in a weather response
public enum Language: String, Codable, Equatable, CaseIterable {
    ///Arabic language
    case arabic = "ar"
    ///Azerbaijani language
    case azerbaijani = "az"
    ///Belarusian language
    case belarusian = "be"
    ///Bulgarian language
    case bulgarian = "bg"
    ///Bengali language
    case bengali = "bn"
    ///Bosnian language
    case bosnian = "bs"
    ///Catalan language
    case catalan = "ca"
    ///Czech language
    case czech = "cs"
    ///Danish language
    case danish = "da"
    ///German language
    case german = "de"
    ///Greek language
    case greek = "el"
    ///English language
    case english = "en"
    ///Esperanto language
    case esperanto = "eo"
    ///Spanish language
    case spanish = "es"
    ///Estonian language
    case estonian = "et"
    ///Finnish language
    case finnish = "fi"
    ///French language
    case french = "fr"
    ///Hebrew language
    case hebrew = "he"
    ///Hindi language
    case hindi = "hi"
    ///Croatian language
    case croatian = "hr"
    ///hungarian language
    case hungarian = "hu"
    ///Indonesian language
    case indonesian = "id"
    ///Icelandic language
    case icelandic = "is"
    ///Italian language
    case italian = "it"
    ///Japanese language
    case japanese = "ja"
    ///Georgian language
    case georgian = "ka"
    ///Kannada language
    case kannada = "kn"
    ///Korean language
    case korean = "ko"
    ///Cornish language
    case cornish = "kw"
    ///Latvian language
    case latvian = "lv"
    ///Malayam language
    case malayam = "ml"
    ///Marathi language
    case marathi = "mr"
    ///Norwegian Bokmål language
    case norwegianBokmål = "nb"
    ///Dutch language
    case dutch = "nl"
    ///Punjabi language
    case punjabi = "pa"
    ///Polish language
    case polish = "pl"
    ///Portuguese language
    case portuguese = "pt"
    ///Romanian language
    case romanian = "ro"
    ///Russian language
    case russian = "ru"
    ///Slovak language
    case slovak = "sk"
    ///Slovenian language
    case slovenian = "sl"
    ///Serbian language
    case serbian = "sr"
    ///Swedish language
    case swedish = "sv"
    ///Tamil language
    case tamil = "ta"
    ///Telugu language
    case telugu = "te"
    ///Tetum language
    case tetum = "tet"
    ///Turkish language
    case turkish = "tr"
    ///Ukrainian language
    case ukrainian = "uk"
    ///Urdu language
    case urdu = "ur"
    ///Simplified Chinese language
    case simplifiedChinese = "zh"
    ///Traditional Chinese language
    case traditionalChinese = "zh-tw"

    ///English language
    public static let `default`: Language = Language.english
}
