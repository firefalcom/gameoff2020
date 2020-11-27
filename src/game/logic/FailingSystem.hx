package game.logic;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.Vector2;

class FailingSystem extends whiplash.UiSystem {
    private var engine:Engine;
    private var timeLeft:Float;

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        new js.jquery.JQuery(".hud .gameOver").show();
        timeLeft = 2;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
        new js.jquery.JQuery(".hud .gameOver").hide();
    }

    public override function update(dt:Float) {
        timeLeft -= dt;

        if(timeLeft < 0) {
            Game.instance.changeIngameState("preparing");
        }
    }
}


