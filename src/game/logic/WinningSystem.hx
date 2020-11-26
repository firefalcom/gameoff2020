package game.logic;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.Vector2;

class WinningSystem extends whiplash.UiSystem {
    private var engine:Engine;

    public function new() {
        super();
        set(".win .retry", "click", () -> {
            Game.instance.startGame();
        });
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        Game.instance.changeUiState("win");
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
    }
}


