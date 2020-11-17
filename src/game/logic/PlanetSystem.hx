package game.logic;

import ash.tools.ListIteratingSystem;
import ash.core.*;
import whiplash.phaser.*;

class PlanetNode extends Node<PlanetNode> {
    public var transform:Transform;
    public var shake:Planet;
}

class PlanetSystem extends ListIteratingSystem<PlanetNode> {
    private var engine:Engine;

    public function new() {
        super(PlanetNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    private function updateNode(node:PlanetNode, dt:Float):Void {
    }

    private function onNodeAdded(node:PlanetNode) {
    }

    private function onNodeRemoved(node:PlanetNode) {
    }
}


