//
//  Door.swift
//

import FlowGraph

// ドアの状態
class Door: FlowGraphType {
    private(set) var isOpen: Bool = false {
        didSet {
            print("isOpen \(self.isOpen)")
            
            if let handler = self.isOpenHandler {
                handler(self.isOpen)
            }
        }
    }
    
    var isOpenHandler: ((Bool) -> Void)?
    
    enum WaitingState {
        case closed
        case opened
    }
    
    enum RunningState {
        case opening
        case closing
    }
    
    enum EventKind {
        case open
        case close
    }
    
    typealias Event = (kind: EventKind, object: Door)
    
    private let graph: FlowGraph<Door>
    
    init() {
        let builder = FlowGraphBuilder<Door>()
        
        // 閉じている
        builder.add(waiting: .closed) { event in
            if case .open = event.kind {
                return .run(.opening, event)
            } else {
                return .stay
            }
        }
        
        // 開いている
        builder.add(waiting: .opened) { event in
            if case .close = event.kind {
                return .run(.closing, event)
            } else {
                return .stay
            }
        }
        
        // 開く
        builder.add(running: .opening) { event in
            event.object.isOpen = true
            return .wait(.opened)
        }
        
        // 閉じる
        builder.add(running: .closing) { event in
            event.object.isOpen = false
            return .wait(.closed)
        }
        
        self.graph = builder.build(initial: .closed)
    }
    
    func run(_ kind: EventKind) {
        self.graph.run((kind, self))
    }
}
