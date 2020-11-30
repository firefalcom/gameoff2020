package game.logic;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.Vector2;

class PrepareSystem extends ash.core.System {
    private var engine:Engine;
    private var rocketEntity:Entity;
    private var launcherEntity:Entity;

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        {
            var e = Factory.createRocket();
            e.get(Transform).position.setTo(-10000, 100);
            e.get(Object).setDynamic(false);
            rocketEntity = e;
            engine.addEntity(e);
        }
        {
            for(e in Game.instance.session.stars) {
                engine.removeEntity(e);
                engine.addEntity(e);
            }
        }
        launcherEntity = engine.getEntityByName("launcher");
        engine.getEntityByName("camera").get(Camera).zoomTo(1);
        rocketEntity.get(Transform).position.copyFrom(launcherEntity.get(Transform).position);
        Game.instance.changeIngameState("launching");
        Game.instance.session.attempts++;
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
    }
}


