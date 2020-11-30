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
        set(".hud .buttonPause", "click", () -> {
            Game.instance.session.paused = true;
            new JQuery(".hud .pauseMenu").show();
        });
        set(".hud .pauseMenu .resume", "click", () -> {
            Game.instance.session.paused = false;
            new JQuery(".hud .pauseMenu").hide();
        });
        set(".hud .pauseMenu .fullscreen", "click", () -> {
            if(document.fullscreenElement == null) {
                document.body.requestFullscreen();
            } else {
                document.exitFullscreen();
            }
        });
        set(".hud .pauseMenu .levels", "click", () -> {
            Game.instance.changeState("levelMenu");
        });
        set(".hud .tutoPanel .button", "click", () -> {
            new JQuery(".tutoPanel").hide();
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
        new JQuery(".hud .levelNumber p").text("" + (Game.instance.session.levelIndex + 1));

        if(Game.instance.session.levelIndex == 0) {
            var userScore = js.Browser.getLocalStorage().getItem("level-0");

            if(userScore == null) {
                new JQuery(".tutoPanel").show();
            }
        }
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


