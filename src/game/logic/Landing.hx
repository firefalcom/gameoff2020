package game.logic;

import game.logic.RocketSystem;
import whiplash.phaser.Transform;
import whiplash.math.Vector2;

class Landing {
    public var time:Float = 0;
    public var rocketNode:RocketNode;

    public var startTransform:Transform;
    public var finalRocketPosition:Vector2;

    public function new(rocketNode) {
        this.rocketNode = rocketNode;
    }
}
