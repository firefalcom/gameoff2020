package game.display;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class RocketNode extends Node<RocketNode> {
    public var transform:Transform;
    public var logicRocket:game.logic.Rocket;
    public var displayRocket:game.display.Rocket;
    public var sprite:Sprite;
    public var object:game.logic.Object;
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
        var displayRocket = node.displayRocket;
        var boostLevel = node.logicRocket.boostLevel;
        var boostEntities = displayRocket.boostEntities;
        var sound = displayRocket.sound;
        var object = node.object;

        sound.setVolume((boostLevel) * 0.2);

        for(i in 0...boostEntities.length) {
            var e = boostEntities[i];

            if(e != null) {
                if(i == boostLevel) {
                    e.get(Sprite).alpha = 0.6;
                } else {
                    e.get(Sprite).alpha = 0;
                }
            }
        }

        Game.instance.session.time += dt;

        if(object.justCollide) {
            node.sprite.play("explosion");
            object.justCollide = false;
        }
    }

    private function onNodeAdded(node:RocketNode) {
        node.displayRocket.sound = whiplash.AudioManager.playSound("thruster", 0, true);
    }

    private function onNodeRemoved(node:RocketNode) {
        whiplash.AudioManager.stopSound("thruster");
    }
}


