package game.logic;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.Vector2;

import js.Browser.document;
import js.jquery.JQuery;

class PauseSystem extends whiplash.UiSystem {
    private var engine:Engine;

    private var attempts:JQuery;
    private var time:JQuery;

    private var lastSeconds:Int;
    private var lastAttempts:Int;

    public function new() {
        super();
        set(".hud .pauseMenu", "click", () -> {
        });
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
            new JQuery(".hud .pauseMenu").show();
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
    }
}


