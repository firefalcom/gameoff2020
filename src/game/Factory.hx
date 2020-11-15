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
        e.add(new Object(false, 5000, 140));
        return e;
    }

    static public function createRocket() {
        var e = new Entity();
        e.name = "rocket";
        e.add(new Transform());
        e.add(new Sprite("missile"));
        e.add(new Object(true, 5, 10));
        e.add(new Rocket());
        return e;
    }
}

