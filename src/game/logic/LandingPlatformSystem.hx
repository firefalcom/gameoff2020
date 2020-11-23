package game.logic;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

import game.logic.RocketSystem;

class LandingPlatformNode extends Node<LandingPlatformNode> {
    public var transform:Transform;
    public var platform:LandingPlatform;
}

class LandingPlatformSystem extends ListIteratingSystem<LandingPlatformNode> {
    private var engine:Engine;

    private var rocketNode:RocketNode;

    public function new() {
        super(LandingPlatformNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:LandingPlatformNode, dt:Float):Void {
        if(rocketNode == null) {
            rocketNode = engine.getNodeList(RocketNode).head;

            if(rocketNode == null) {
                return;
            }
        }

        var transform = node.transform;
        var rocketTransform = rocketNode.transform;
        var rocketObject = rocketNode.object;

        var distance = transform.position.getDistance(rocketTransform.position);

        if(distance < rocketObject.radius * game.Config.landing.distanceTolerance) {
            var a = rocketTransform.rotation;
            var b = transform.rotation;
            var difference = 180 - Math.abs(Math.abs(a - b) - 180);

            if(difference < game.Config.landing.rotationTolerance) {
                var speed = rocketObject.velocity.getLength();

                if(speed < game.Config.landing.maxSpeed) {
                    trace("Won!");
                }
            }
        }
    }

    private function onNodeAdded(node:LandingPlatformNode) {
    }

    private function onNodeRemoved(node:LandingPlatformNode) {
    }
}


