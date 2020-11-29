package game.logic;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.Vector2;

import js.Browser.document;
import js.jquery.JQuery;

class HudSystem extends whiplash.UiSystem {
    private var engine:Engine;

    private var attempts:JQuery;
    private var time:JQuery;

    private var lastSeconds:Int;
    private var lastAttempts:Int;

    public function new() {
        super();
        set(".mainMenu .play", "click", () -> {
        });
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        Game.instance.changeUiState("hud");
        attempts = new JQuery(".hud .life p");
        time = new JQuery(".hud .timer p");

        lastSeconds = null;
        lastAttempts = null;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
        var session = Game.instance.session;

        if(Std.int(session.time) != lastSeconds) {
            lastSeconds = Std.int(session.time);
            var seconds = lastSeconds % 60;
            var minutes = Std.int(lastSeconds / 60);
            time.text(minutes + ":" + (seconds < 10 ? "0" : "") + seconds);
        }
        if(Std.int(session.attempts) != lastAttempts) {
            lastAttempts = session.attempts;
            attempts.text("" + lastAttempts);
        }
    }
}


