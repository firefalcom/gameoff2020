package game.logic;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

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
        rocketNode = engine.getNodeList(RocketNode).head;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:LandingPlatformNode, dt:Float):Void {
        var transform = node.transform;
        var rocketTransform = rocketNode.transform;
        var rocketObject = rocketNode.object;

        if(rocketObject == null || !rocketObject.isDynamic()) {
            return;
        }

        var distance = transform.position.getDistance(rocketTransform.position);

        if(distance < rocketObject.radius * game.Config.landing.distanceTolerance) {
            var angle = (transform.rotation - 90) * Math.PI / 180;
            var v = Vector2.getRotatedVector(new Vector2(1, 0), -angle);
            var point = transform.position + v;
            var axisDistance = Line.getDistance(new Line(transform.position, point), rocketTransform.position);

            if(axisDistance < game.Config.landing.distanceToAxis) {
                var a = rocketTransform.rotation;
                var b = transform.rotation;
                var difference = 180 - Math.abs(Math.abs(a - b) - 180);

                if(difference < game.Config.landing.rotationTolerance) {
                    var speed = rocketObject.velocity.getLength();

                    if(speed < game.Config.landing.maxSpeed) {
                        node.entity.add(new Landing(rocketNode));
                        Game.instance.changeIngameState("landing");
                    } else {
                        // trace("Too quick : " + speed);
                    }
                } else {
                    // trace("Too much rotation difference : " + difference);
                }
            }
        }
    }

    private function onNodeAdded(node:LandingPlatformNode) {
    }

    private function onNodeRemoved(node:LandingPlatformNode) {
    }
}


