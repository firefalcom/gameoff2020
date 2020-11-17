package game;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.Vector2;

class PrepareSystem extends ash.core.System {
    private var engine:Engine;
    private var rocketEntity:Entity;
    private var startPlanetEntity:Entity;

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        var e = Factory.createRocket();
        e.get(Transform).position.setTo(-10000, 100);
        e.get(Object).setDynamic(false);
        engine.addEntity(e);
        rocketEntity = e;
        startPlanetEntity = engine.getEntityByName("earth");
        engine.getEntityByName("camera").get(Camera).zoomTo(1);
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
        var mouseCoords = Game.instance.getMouseWorldPosition();
        var planetTransform = startPlanetEntity.get(Transform);
        var planetObject = startPlanetEntity.get(Object);
        var planetPosition = planetTransform.position;
        var rocketTransform = rocketEntity.get(Transform);
        var rocketObject = rocketEntity.get(Object);
        var delta = mouseCoords - planetPosition;
        var direction = new Vector2();
        direction.copyFrom(delta);
        direction.normalize();
        var angle = direction.getAngle();
        rocketTransform.position = planetPosition + direction * (planetObject.radius + rocketObject.radius + 1);
        rocketTransform.rotation = (angle * 180 / Math.PI) + 90;

        if(whiplash.Input.isKeyJustPressed(' ') || whiplash.Input.mouseButtons[0]) {
            Game.instance.changeIngameState("launching");
        }
    }
}


