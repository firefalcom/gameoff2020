package game.logic;

import whiplash.math.Vector2;

class Object {
    public var _dynamic:Bool = false;
    public var mass:Int;
    public var radius:Float;
    public var velocity:Vector2 = new Vector2(0,0);

    public function new(_dynamic = true, mass, radius) {
        this._dynamic = _dynamic;
        this.mass = mass;
        this.radius = radius;
    }

    inline public function isStatic() {
        return !_dynamic;
    }

    inline public function isDynamic() {
        return _dynamic;
    }

    inline public function setDynamic(value:Bool) {
        _dynamic = value;
    }
}
