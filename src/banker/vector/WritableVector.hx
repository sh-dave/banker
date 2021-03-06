package banker.vector;

import banker.vector.internal.RawVector;

/**
	Fixed-length writable array.
**/
@:forward(length, toArray)
// @formatter:off
@:using(
	banker.vector.extension.writable.Copy,
	banker.vector.extension.writable.Fill,
	banker.vector.extension.writable.Functional
) // @formatter:on
@:allow(banker.vector)
abstract WritableVector<T>(RawVector<T>) from RawVector<T> {
	/**
		@return Shallow copy of `array` as `WritableVector<T>`.
	**/
	public static inline function fromArrayCopy<T>(array: Array<T>): WritableVector<T>
		return RawVector.fromArrayCopy(array);

	/**
	 `VectorReference` representation of `this`.
	**/
	public var ref(get, never): VectorReference<T>;

	inline function get_ref(): VectorReference<T>
		return this;

	public inline function new(length: Int)
		this = new RawVector<T>(length);

	@:op([]) public inline function get(index: Int): T {
		assert(index >= 0 && index < this.length, null, "Out of bound.");
		return this[index];
	}

	@:op([]) public inline function set(index: Int, value: T): T {
		assert(index >= 0 && index < this.length, null, "Out of bound.");
		return this[index] = value;
	}

	@:to inline function toReference<T>(): VectorReference<T>
		return this;

	inline function nonWritable(): Vector<T>
		return this;
}
