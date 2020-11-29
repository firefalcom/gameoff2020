package game.logic;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.Vector2;
import js.jquery.JQuery;

class LevelMenuSystem extends whiplash.UiSystem {
    private var engine:Engine;
    private var pageIsGenerated:Bool = false;

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        Game.instance.changeUiState("levelMenu");

        if(!pageIsGenerated) {
            var container = new JQuery(".levelMenu .content");
            var model = new JQuery(".levelMenu .levelBar");
            model.remove();

            for(i in 0...game.Config.levelCount) {
                var entry = model.clone();
                entry.children("p").text("" + (i+1));
                entry.appendTo(container);
                entry.click((e)-> {
                    Game.instance.startGame(i);
                });
            }

            pageIsGenerated = true;
        }
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
        if(whiplash.Input.isKeyJustPressed(' ')) {
            Game.instance.startGame();
        }
    }
}


