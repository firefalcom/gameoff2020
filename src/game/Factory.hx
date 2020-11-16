package game;

import ash.core.*;
import whiplash.phaser.*;
import whiplash.math.*;

class Factory {

    static var phaserScene : phaser.Scene;

    static public function preload(scene:phaser.Scene) {
        phaserScene = scene;
    }

    static public function load(scene:phaser.Scene) {
    }


    static public function createBackground() {
        var e = new Entity();
        e.add(new Transform());
        e.add(new Sprite("background"));
        e.get(Transform).scale.setTo(2,2);
        return e;
    }

    static public function createPlanet() {
        var e = new Entity();
        e.add(new Transform());
        e.add(new Sprite("planet"));
        e.add(new Object(false, 5000, 130));
        return e;
    }

    static public function createRocket() {
        var e = new Entity();
        e.name = "rocket";
        e.add(new Transform());
        e.add(new Sprite("missile"));
        e.add(new Object(true, 5, 20));
        e.add(new Rocket());
        e.get(Transform).scale.setTo(2,2);
        return e;
    }

    static public function createCamera() {
        var e = new Entity();
        e.name = "camera";
        e.add(new Transform());
        e.add(new Camera(0, 0, Config.screen.width, Config.screen.height));
        return e;
    }
}

