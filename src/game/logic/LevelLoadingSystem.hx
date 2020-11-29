package game.logic;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.Vector2;

class LevelLoadingSystem extends whiplash.UiSystem {
    private var engine:Engine;

    public function new() {
        super();
    }

    public override function addToEngine(engine:Engine) {
        super.addToEngine(engine);
        this.engine = engine;
        initLoading();
        {
            /*            {
                            var e = Factory.createEarth();
                            e.get(Transform).position.setTo(-300, 200);
                            engine.addEntity(e);
                            var p = Factory.createLauncher();
                            p.get(game.logic.Attach).planet = e;
                            p.get(game.logic.Attach).offset = 30;
                            p.get(game.logic.Attach).angle = 25;
                            engine.addEntity(p);
                            var e = Factory.createExotic();
                            e.get(Transform).position.setTo(400, 100);
                            engine.addEntity(e);
                            var e = Factory.createMoon();
                            e.get(Transform).position.setTo(100, -150);
                            engine.addEntity(e);
                            var p = Factory.createLandingPlatform();
                            p.get(game.logic.Attach).planet = e;
                            p.get(game.logic.Attach).angle = -45;
                            engine.addEntity(p);
                        }
                        */
        }
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
    }

    private function initLoading() {
        engine.removeAllEntities();
        var e = Factory.createCamera();
        Game.instance.camera = e.get(whiplash.phaser.Camera);
        engine.addEntity(e);
        Game.instance.setupCamera();
        var http = new haxe.Http("../data/levels/level" + Game.instance.session.levelIndex + ".json");
        http.onData = parse;
        http.request();
    }

    private function parse(data) {
        var json = haxe.Json.parse(data);
        var objects:Array<Dynamic> = json.layers[0].objects;
        var mapWidth = json.tilewidth * json.width;
        var mapHeight = json.tileheight * json.height;

        for(o in objects) {
            if(o.ellipse) {
                var l = o.width / 2;
                var radius = Math.sqrt(l*l*2);
                var e = Factory.createPlanet(o.type, getProperty(o.properties, "mass", 1000), radius);
                e.get(Transform).position.setTo(o.x - mapWidth / 2, o.y - mapHeight / 2);
                engine.addEntity(e);
                var launcherProp = getProperty(o.properties, "launcher");

                if(launcherProp != null) {
                    var p = Factory.createLauncher();
                    p.get(game.logic.Attach).planet = e;
                    p.get(game.logic.Attach).offset = 30;
                    p.get(game.logic.Attach).angle = launcherProp.value;
                    engine.addEntity(p);
                }
            }
        }
    }

    private function onLoadComplete() {
        Game.instance.changeState("ingame");
        Game.instance.changeIngameState("preparing");
    }

    static private function getProperty(props:Dynamic, name:String, ?fallback:Dynamic):Dynamic {
        if(props == null) { return fallback; }

        for(prop in ((props):Array<Dynamic>)) {
            if(prop.name == name) {
                return prop;
            }
        }

        return fallback;
    }
}
