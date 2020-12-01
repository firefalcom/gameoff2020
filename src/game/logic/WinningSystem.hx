package game.logic;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.Vector2;
import js.jquery.JQuery;

class WinningSystem extends whiplash.UiSystem {
    private var engine:Engine;

    public function new() {
        super();
        set(".win .retry", "click", () -> {
            Game.instance.startGame(Game.instance.session.levelIndex);
        });
        set(".win .levelSelect", "click", () -> {
            Game.instance.changeState("levelMenu");
            Game.instance.changeUiState("levelMenu");
        });
        set(".win .next", "click", () -> {
            Game.instance.startGame(Game.instance.session.levelIndex + 1);
        });
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        Game.instance.changeUiState("win");
        var session = Game.instance.session;
        var count = session.starsCollected;

        for(i in 0...count) {
            Game.instance.delay(() -> {
                new JQuery(".win .star li")[i].style.opacity = "1";
            }, 1 + i * 0.2);
        }

        {
            var itime = Std.int(session.time);
            var seconds = itime % 60;
            var minutes = Std.int(itime / 60);
            new JQuery(".win .lineTime p")[1].innerText = (minutes + ":" + (seconds < 10 ? "0" : "") + seconds);
        }

        new JQuery(".win .lineLife p")[1].innerText = "" + (session.attempts - 1);
        var score = Std.int(1000 + 1000 * Math.pow(2, count) - session.time - session.attempts * 100);

        if(score < 0) { score = 0; }

        new JQuery(".win .lineScore p")[1].innerText = "" + score;
        {
            var userScore:Int = Std.parseInt(js.Browser.getLocalStorage().getItem("level-" + session.levelIndex));

            if(userScore == null) {
                userScore = 0;
            }

            if(count > userScore) {
                js.Browser.getLocalStorage().setItem("level-" + session.levelIndex, "" + count);
            }
        }

        new JQuery(".win p.levelNumber").text("" + (Game.instance.session.levelIndex + 1));
        whiplash.AudioManager.playSound("moonlander_win_cut", 0.6);
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);

        for(i in 0...3) {
            new JQuery(".win .star li").get(i).style.opacity = "0";
        }
    }

    public override function update(dt:Float) {
    }
}


