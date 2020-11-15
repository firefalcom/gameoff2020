package game;

@:build(whiplash.Macro.editable())
class Config {
    static public var screen = {
        width: 1280,
        height: 768
    };

    static public var object = {
        maxSpeed: 200,
        g: 55
    };

    static public var rocket = {
        boost: 1000,
        launch : 100,
    };
}
