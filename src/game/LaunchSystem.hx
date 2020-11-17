package game;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;
import game.RocketSystem;

class LaunchSystem extends ListIteratingSystem<RocketNode> {
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
        var mouseCoords = Game.instance.getMouseWorldPosition();

        if(whiplash.Input.isKeyJustPressed(' ')) {
            var angle = (transform.rotation - 90) * Math.PI / 180;
            var direction = Vector2.getRotatedVector(new Vector2(1, 0), -angle);
            object.setDynamic(true);
            object.velocity = direction * Config.rocket.launch;
            Game.instance.changeIngameState("navigating");

            trace(object.velocity);
        }


        if(whiplash.Input.mouseButtons[0]) {
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


