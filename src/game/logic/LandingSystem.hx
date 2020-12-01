package game.logic;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class LandingNode extends Node<LandingNode> {
    public var transform:Transform;
    public var landing:Landing;
    public var landingPlatform:LandingPlatform;
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
        var rocketTransform = landing.rocketNode.transform;
        var startTransform = landing.startTransform;
        landing.time += dt;

        var ratio:Float = landing.time / 2;

        var targetRotation = node.transform.rotation;

        if(targetRotation - startTransform.rotation > 360) {
            targetRotation -= 360;
        } else if(targetRotation - startTransform.rotation < - 360) {
            targetRotation += 360;
        }

        rocketTransform.rotation = whiplash.tween.FloatTween.get(startTransform.rotation, targetRotation, EaseOut, ratio);
        rocketTransform.position = whiplash.tween.Vector2Tween.get(startTransform.position, node.landing.finalRocketPosition, EaseOut, ratio);

        if(ratio > 1) {
            Game.instance.changeIngameState("winning");
        }

    }

    private function onNodeAdded(node:LandingNode) {
        node.landing.time = 0;
        node.landing.startTransform = new Transform();
        node.landing.startTransform.copyFrom(node.landing.rocketNode.transform);
        node.landing.rocketNode.object.setDynamic(false);
        node.landing.rocketNode.rocket.boostLevel = 0;
        var angle = (node.transform.rotation - 90) * Math.PI / 180;
        var offset = Vector2.getRotatedVector(new Vector2(node.landing.rocketNode.object.radius + node.landingPlatform.offset, 0), -angle);
        node.landing.finalRocketPosition = node.transform.position + offset;
    }

    private function onNodeRemoved(node:LandingNode) {
    }
}


