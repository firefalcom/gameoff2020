package game.logic;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.Vector2;

import js.Browser.document;

class MainMenuSystem extends whiplash.UiSystem {
    private var engine:Engine;

    public function new() {
        super();
        set(".mainMenu .play", "click", () -> {
            Game.instance.changeState("levelMenu");
        });
        set(".mainMenu .fullScreenButton", "click", () -> {
            if(document.fullscreenElement == null) {
                document.body.requestFullscreen();
            } else {
                document.exitFullscreen();
            }
        });
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        Game.instance.changeUiState("mainMenu");
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
        if(whiplash.Input.isKeyJustPressed(' ')) {
            Game.instance.changeState("levelMenu");
        }
    }
}


