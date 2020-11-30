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
    }

    public override function removeFromEngine(engine:Engine) {
        super.removeFromEngine(engine);
    }

    public override function update(dt:Float) {
    }

    private function initLoading() {
        var e = Factory.createCamera();
        Game.instance.camera = e.get(whiplash.phaser.Camera);
        engine.addEntity(e);
        Game.instance.setupCamera();
        var http = new haxe.Http("../data/levels/level" + Game.instance.session.levelIndex + ".json");
        http.onData = parse;
        http.onError = (e) -> {
            Game.instance.changeState("mainMenu");
        };
        http.request();
    }

    private function parse(data) {
        var json = haxe.Json.parse(data);
        var objects:Array<Dynamic> = json.layers[0].objects;
        var mapWidth = json.tilewidth * json.width;
        var mapHeight = json.tileheight * json.height;

        for(o in objects) {
            if(o.ellipse) {
                var radius = o.width / 2;
                var e = Factory.createPlanet(o.type, getProperty(o.properties, "mass", 1000), radius);
                e.get(Transform).position.setTo(o.x + radius - mapWidth / 2, o.y + radius - mapHeight / 2);
                engine.addEntity(e);
                {
                    var launcherValue = getProperty(o.properties, "launcher");

                    if(launcherValue != null) {
                        var p = Factory.createLauncher();
                        p.get(game.logic.Attach).planet = e;
                        p.get(game.logic.Attach).offset = 30;
                        p.get(game.logic.Attach).angle = launcherValue;
                        engine.addEntity(p);
                    }
                }
                {
                    var landValue = getProperty(o.properties, "land");

                    if(landValue != null) {
                        var p = Factory.createLandingPlatform();
                        p.get(game.logic.Attach).planet = e;
                        p.get(game.logic.Attach).angle = landValue;
                        p.get(game.logic.Attach).offset = 5;
                        engine.addEntity(p);
                    }
                }
            } else if(o.point) {
                var e = Factory.createStar();
                e.get(Transform).position.setTo(o.x - mapWidth / 2, o.y - mapHeight / 2);
                Game.instance.session.stars.push(e);
            }
        }

        onLoadComplete();
    }

    private function onLoadComplete() {
        Game.instance.changeState("ingame");
        Game.instance.changeIngameState("preparing");
    }

    static private function getProperty(props:Dynamic, name:String, ?fallback:Dynamic):Dynamic {
        if(props == null) { return fallback; }

        for(prop in ((props):Array<Dynamic>)) {
            if(prop.name == name) {
                return prop.value;
            }
        }

        return fallback;
    }
}
