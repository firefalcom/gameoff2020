package game.display;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class CameraNode extends Node<CameraNode> {
    public var transform:Transform;
    public var camera:Camera;
}

class CameraSystem extends ListIteratingSystem<CameraNode> {
    private var engine:Engine;

    public function new() {
        super(CameraNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:CameraNode, dt:Float):Void {
        var rocket = engine.getEntityByName("rocket");

        if(rocket != null) {
            var targetTransform = rocket.get(Transform);
            var targetPosition = targetTransform.position;
            var camera = node.camera;
            var factor = 1.5;
            var rectangle = new phaser.geom.Rectangle(camera.centerX - camera.displayWidth / (2*factor), camera.centerY - camera.displayHeight / (2*factor), camera.displayWidth/ factor, camera.displayHeight / factor);

            if(!rectangle.contains(targetPosition.x, targetPosition.y)) {
                camera.zoomTo(camera.zoom * 0.9, 250);
            } else {
                camera.zoomTo(Math.min(camera.zoom * 1.1, 1), 250);
            }
        }
    }

    private function onNodeAdded(node:CameraNode) {
    }

    private function onNodeRemoved(node:CameraNode) {
    }
}


