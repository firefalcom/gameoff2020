package game.logic;

import game.logic.RocketSystem;
import whiplash.phaser.Transform;

class Landing {
    public var time:Float = 0;
    public var rocketNode:RocketNode;

    public var startTransform:Transform;

    public function new(rocketNode) {
        this.rocketNode = rocketNode;
    }
}
