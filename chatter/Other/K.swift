struct K{
    static var registerToChatsSegue = "registerToChats"
    static var loginToChatsSegue = "loginToChats"
    static var welcomeToLoginSegue = "welcomeToLogin"
    static var welcomeToRegisterSegue = "welcomeToRegister"
    static var chatsToMessagesSegue = "chatsToMessages"
    static var nibname = "MessageCell"
    static var customCell = "customCell"
    static var reusablecell = "reusablecell"
    
    struct FStore {
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
    static var collectionsCreated:[String] = []
}
