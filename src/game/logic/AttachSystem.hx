package game.logic;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class AttachNode extends Node<AttachNode> {
    public var transform:Transform;
    public var attach:Attach;
}

class AttachSystem extends ListIteratingSystem<AttachNode> {
    private var engine:Engine;

    public function new() {
        super(AttachNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:AttachNode, dt:Float):Void {
    }

    private function onNodeAdded(node:AttachNode) {
        var attach = node.attach;

        if(attach.planet == null) {
            throw "planet must be set";
        }

        var transform = node.transform;
        var planetTransform = attach.planet.get(Transform);
        var planetObject = attach.planet.get(Object);

        var direction = Vector2.getRotatedVector(new Vector2(0, -1), -attach.angle * Math.PI / 180);

        transform.position = planetTransform.position + direction * (planetObject.radius + attach.offset);
        transform.rotation = attach.angle;
    }

    private function onNodeRemoved(node:AttachNode) {
    }
}


