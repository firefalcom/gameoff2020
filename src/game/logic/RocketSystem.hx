package game.logic;

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
        var object = node.object;
        var transform = node.transform;

        var boost = 0;

        if(whiplash.Input.keys[' ']) {
            boost= Config.rocket.megaboost;
        }

        if(whiplash.Input.mouseButtons[0]) {
            boost= Config.rocket.boost;
        }

        if(boost != 0) {
            var angle = (transform.rotation - 90) * Math.PI / 180;
            var v = Vector2.getRotatedVector(new Vector2(boost, 0), -angle);
            object.velocity += v * dt;
        }

        {
            var mouseCoords = Game.instance.getMouseWorldPosition();
            var delta = mouseCoords - transform.position;
            var direction = new Vector2();
            direction.copyFrom(delta);
            direction.normalize();
            var angle = direction.getAngle();
            transform.rotation = (angle * 180 / Math.PI) + 90;
        }
    }

    private function onNodeAdded(node:RocketNode) {
    }

    private function onNodeRemoved(node:RocketNode) {
    }
}


