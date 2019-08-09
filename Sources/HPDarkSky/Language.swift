//
//  Language.swift
//  
//
//  Created by Henrik Panhans on 06.08.19.
//

import Foundation

public enum Language: String {
    case arabic = "ar"
    case azerbaijani = "az"
    case belarusian = "be"
    case bulgarian = "bg"
    case bengali = "bn"
    case bosnian = "bs"
    case catalan = "ca"
    case czech = "cs"
    case danish = "da"
    case german = "de"
    case greek = "el"
    case english = "en"
    case esperanto = "eo"
    case spanish = "es"
    case estonian = "et"
    case finnish = "fi"
    case french = "fr"
    case hebrew = "he"
    case hindi = "hi"
    case croatian = "hr"
    case hungarian = "hu"
    case indonesian = "id"
    case icelandic = "is"
    case italian = "it"
    case japanese = "ja"
    case georgian = "ka"
    case kannada = "kn"
    case korean = "ko"
    case cornish = "kw"
    case latvian = "lv"
    case malayam = "ml"
    case marathi = "mr"
    case norwegianBokmål = "nb"
    case dutch = "nl"
    case punjabi = "pa"
    case polish = "pl"
    case portuguese = "pt"
    case romanian = "ro"
    case russian = "ru"
    case slovak = "sk"
    case slovenian = "sl"
    case serbian = "sr"
    case swedish = "sv"
    case tamil = "ta"
    case telugu = "te"
    case tetum = "tet"
    case turkish = "tr"
    case ukrainian = "uk"
    case urdu = "ur"
    case simplifiedChinese = "zh"
    case traditionalChinese = "zh-tw"

    public static let `default`: Language = Language.english
}
