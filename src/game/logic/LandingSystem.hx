package game.logic;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class LandingNode extends Node<LandingNode> {
    public var transform:Transform;
    public var landing:Landing;
}

class LandingSystem extends ListIteratingSystem<LandingNode> {
    private var engine:Engine;

    public function new() {
        super(LandingNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:LandingNode, dt:Float):Void {
        var landing = node.landing;
        landing.time += dt;

        landing.rocketNode.transform.copyFrom(landing.startTransform);

        landing.rocketNode.transform.rotation = landing.time * 360;
    }

    private function onNodeAdded(node:LandingNode) {
        node.landing.time = 0;
        node.landing.startTransform = new Transform();
        node.landing.startTransform.copyFrom(node.landing.rocketNode.transform);
        node.landing.rocketNode.object.setDynamic(false);
    }

    private function onNodeRemoved(node:LandingNode) {
    }
}


