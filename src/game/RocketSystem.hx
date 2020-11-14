package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class RocketNode extends Node<RocketNode> {
    public var transform:Transform;
    public var rocket:Rocket;
    public var object:Object;
}

class RocketSystem extends ListIteratingSystem<RocketNode> {
    private var engine:Engine;

    public function new() {
        super(RocketNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:RocketNode, dt:Float):Void {

        if(whiplash.Input.mouseButtons[0]) {
            var object = node.object;
            var transform = node.transform;
            var angle = transform.rotation * Math.PI / 180;
            var v = Vector2.getRotatedVector(new Vector2(0, 1000), angle);
            object.velocity += v * dt;
        }
    }

    private function onNodeAdded(node:RocketNode) {
    }

    private function onNodeRemoved(node:RocketNode) {
    }
}


