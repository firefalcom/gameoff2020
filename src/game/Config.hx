package game;

@:build(whiplash.Macro.editable())
class Config {
    static public var screen = {
        width: 1280,
        height: 720
    };

    static public var object = {
        maxSpeed: 1000,
        g: 55
    };

    static public var rocket = {
        boost: 500,
        megaboost: 2000,
        launch : 50
    };

    static public var landing = {
        distanceTolerance: 1.5,
        distanceToAxis: 32,
        rotationTolerance: 15,
        maxSpeed: 150
    }
}
