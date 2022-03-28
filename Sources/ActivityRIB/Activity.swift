public enum Activity: RawRepresentable {
    case copy
    case saveToFiles
    case messages
    case airDrop
    case mail
    case instagram
    case tikTok
    case snapchat
    case vk
    case telegram
    case twitter
    case whatsApp
    case other(String)

    public init?(rawValue: String) {
        switch rawValue {
        case Self.copy.rawValue: self = .copy
        case Self.saveToFiles.rawValue: self = .saveToFiles
        case Self.messages.rawValue: self = .messages
        case Self.airDrop.rawValue: self = .airDrop
        case Self.mail.rawValue: self = .mail
        case Self.instagram.rawValue: self = .instagram
        case Self.tikTok.rawValue: self = .tikTok
        case Self.snapchat.rawValue: self = .snapchat
        case Self.vk.rawValue: self = .vk
        case Self.telegram.rawValue: self = .telegram
        case Self.twitter.rawValue: self = .twitter
        case Self.whatsApp.rawValue: self = .whatsApp
        default: self = .other(rawValue)
        }
    }

    public var rawValue: String {
        switch self {
        case .copy: return "com.apple.UIKit.activity.CopyToPasteboard"
        case .saveToFiles: return "com.apple.DocumentManagerUICore.SaveToFiles"
        case .messages: return "com.apple.UIKit.activity.Message"
        case .airDrop: return "com.apple.UIKit.activity.AirDrop"
        case .mail: return "com.apple.UIKit.activity.Mail"
        case .instagram: return "com.burbn.instagram.shareextension"
        case .tikTok: return "com.zhiliaoapp.musically.ShareExtension"
        case .snapchat: return "com.toyopagroup.picaboo.share"
        case .vk: return "com.vk.vkclient.shareextension"
        case .telegram: return "ph.telegra.Telegraph.Share"
        case .twitter: return "com.apple.UIKit.activity.PostToTwitter"
        case .whatsApp: return "cnet.whatsapp.WhatsApp.ShareExtension"
        case let .other(name): return name
        }
    }

    var name: String {
        switch self {
        case .copy: return "copy"
        case .saveToFiles: return "saveToFiles"
        case .messages: return "messages"
        case .airDrop: return "airDrop"
        case .mail: return "mail"
        case .instagram: return "instagram"
        case .tikTok: return "tikTok"
        case .snapchat: return "snapchat"
        case .vk: return "vk"
        case .telegram: return "telegram"
        case .twitter: return "twitter"
        case .whatsApp: return "whatsApp"
        case let .other(name): return name
        }
    }
}
