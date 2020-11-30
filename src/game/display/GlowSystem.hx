package game.display;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class GlowNode extends Node<GlowNode> {
    public var transform:Transform;
    public var glow:Glow;
    public var sprite:Sprite;
}

class GlowSystem extends ListIteratingSystem<GlowNode> {
    private var engine:Engine;

    public function new() {
        super(GlowNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:GlowNode, dt:Float):Void {
        var glow = node.glow;

        glow.time += dt;

        var advance = glow.time * glow.speed * Math.PI * 2;

        node.sprite.alpha = glow.minAlpha + ((1 + Math.cos(Math.PI + advance)) / 2) * (1 - glow.minAlpha);

        if(glow.countLeft != null) {
            while(advance >= Math.PI * 2) {
                advance -= Math.PI * 2;
                glow.countLeft--;

                if(glow.countLeft < 0) {
                    node.sprite.alpha = 0;
                    node.entity.remove(Glow);
                }
            }
        }
    }

    private function onNodeAdded(node:GlowNode) {
        node.glow.time = 0;
    }

    private function onNodeRemoved(node:GlowNode) {
    }
}


