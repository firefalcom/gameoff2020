package game;

import whiplash.math.Vector2;

class Object {
    public var _dynamic:Bool = false;
    public var mass:Int;
    public var velocity:Vector2 = new Vector2(0,0);

    public function new(_dynamic = true, mass) {
        this._dynamic = _dynamic;
        this.mass = mass;
    }

    inline public function isStatic() {
        return !_dynamic;
    }

    inline public function isDynamic() {
        return _dynamic;
    }
}
