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

        {
            var starContainers = new JQuery(".levelMenu .starsArea");
            var levelBars = new JQuery(".levelMenu .levelBar");
            var nullFound = false;

            for(i in 0...game.Config.levelCount) {
                var userScore:Int = Std.parseInt(js.Browser.getLocalStorage().getItem("level-" + i));

                if(nullFound) {
                    levelBars.eq(i).addClass("locked");
                } else {
                    levelBars.eq(i).removeClass("locked");
                }

                if(userScore == null) {
                    nullFound = true;
                    userScore = 0;
                }

                for(s in 0...3) {
                    starContainers.eq(i).find(".stars li").eq(s).css("opacity", (userScore > s ? "1" : "0"));
                }
            }
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


