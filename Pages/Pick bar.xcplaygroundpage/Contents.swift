/*:
 ### 물체를 집어서 이동시키기
 - 참고 : iOS Swift Game Development Cookbook
 - 직접 position을 바꾸지 않고 jointPin으로 고정한 후에 이동시키는 방법
 - static인 경우에는 이동불가. pinned인 경우에는 회전만
 - allowsRotation이 false이면 이동만
 - allowsRotation이 true인 경우에는 touch한 위치를 중심으로 회전하면서 움직인다.
 
*/
import UIKit
import SpriteKit

class GameScene: SKScene {
    var dragNode: SKNode?
    var dragJoint: SKPhysicsJointPin?

    override func didMoveToView(view: SKView) {
        // SKScene의 경계에 physicsbody 설정
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.speed = 1

        // Make ball
        let ball = SKShapeNode(circleOfRadius: 20)
        do {
            ball.physicsBody = SKPhysicsBody(circleOfRadius: 20)
            ball.physicsBody?.restitution = 1.0


            ball.fillColor = [#Color(colorLiteralRed: 0.2818343937397003, green: 0.5693024396896362, blue: 0.1281824260950089, alpha: 1)#]
            ball.position = CGPointMake(160,400)
        }

        // Make bar
        let bar = SKSpriteNode(color: [#Color(colorLiteralRed: 0.9346159696578979, green: 0.6284804344177246, blue: 0.107728436589241, alpha: 1)#], size: CGSizeMake(100,20))
        do {
            bar.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(100,20))
            //bar.physicsBody?.pinned = true
            //bar.physicsBody?.dynamic = false
            //bar.physicsBody?.allowsRotation = false

            bar.position = CGPointMake(160, 20)
        }

        addChild(ball)
        addChild(bar)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // We only care about one touch at a time
        if let touch = touches.first {
            // Work out what node got touched
            let touchPosition = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchPosition)
            // Make sure that we're touching something that _can_ be dragged
            if touchedNode == self.dragNode || touchedNode.physicsBody == nil {
                return
            }

            // Create the invisible drag node, with a small static body
            let newDragNode = SKNode()
            newDragNode.position = touchPosition
            newDragNode.physicsBody = SKPhysicsBody(rectangleOfSize:CGSize(width: 10, height: 10))
            newDragNode.physicsBody?.dynamic = false
            self.addChild(newDragNode)

            // Link this new node to the object that got touched
            let newDragJoint = SKPhysicsJointPin.jointWithBodyA( touchedNode.physicsBody!, bodyB:newDragNode.physicsBody!, anchor:touchPosition)
            self.physicsWorld.addJoint(newDragJoint)
            // Store the reference to the joint and the node
            self.dragNode = newDragNode
            self.dragJoint = newDragJoint
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            // When the touch moves, move the static drag node. 
            // The joint will drag the connected
            // object with it.
            let touchPosition = touch.locationInNode(self)
            self.dragNode?.position = touchPosition
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        stopDragging()
    }

    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        stopDragging()
    }

    func stopDragging() {
        // Remove the joint and the drag node. self.physicsWorld.removeJoint(dragJoint!) dragJoint = nil
        self.dragNode?.removeFromParent()
        self.dragNode = nil
    }
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // add SKView
        do {
            let skView = SKView(frame:CGRectMake(0, 0, 320, 480))
            skView.showsFPS = true
            // physics body를 보여준다.
            skView.showsPhysics = true
            //skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true

            let scene = GameScene(size: CGSizeMake(320, 480))
            scene.scaleMode = .AspectFit

            skView.presentScene(scene)
            self.view.addSubview(skView)
        }
    }
}

PlaygroundHelper.showViewController(ViewController())

