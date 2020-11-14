package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class ObjectNode extends Node<ObjectNode> {
    public var transform:Transform;
    public var object:Object;
}

class ObjectSystem extends ListIteratingSystem<ObjectNode> {
    private var engine:Engine;

    public function new() {
        super(ObjectNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:ObjectNode, dt:Float):Void {
        var object = node.object;
        var transform = node.transform;

        if(object.isDynamic()) {
            for(other in nodeList) {
                if(other != node) {
                    var other_transform = other.transform;
                    var delta = other_transform.position - transform.position;
                    var distance = delta.getLength();

                    if(distance > 0) {
                        var direction = delta;
                        direction.normalize();
                        var force = 50 * (other.object.mass) / (distance * distance);
                        object.velocity += direction * force;
                    }
                }
            }

            transform.position += object.velocity * dt;

            var angle = object.velocity.getAngle();
            transform.rotation = (angle * 180/Math.PI) + 90;
        }

    }

    private function onNodeAdded(node:ObjectNode) {
    }

    private function onNodeRemoved(node:ObjectNode) {
    }
}


