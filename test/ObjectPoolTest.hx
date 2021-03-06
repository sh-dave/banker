package;

import banker.pool.ObjectPool;
import banker.pool.SafeObjectPool;

class Actor {
	static var nextId = 0;

	public final id: Int;

	public function new() {
		this.id = nextId;
		++nextId;
	}

	public function toString(): String
		return Std.string(id);
}

class ObjectPoolTest {
	static function basic() {
		describe("none");
		final stack = new ObjectPool<Actor>(10, () -> new Actor());

		final actorA = stack.get();
		final actorB = stack.get();
		assert(stack.size == 8);
		stack.put(actorA);
		stack.put(actorB);
		assert(stack.size == 10);
	}

	static final _basic = testCase(basic, Ok);

	static function empty() {
		describe("This raises an exception.");
		final stack = new ObjectPool<Actor>(10, () -> new Actor());

		for (i in 0...11) stack.get();
	}

	static final _empty = testCase(empty, Fail);

	static function emptySafe() {
		describe("This goes without exception.");
		final stack = new SafeObjectPool<Actor>(10, () -> new Actor());

		for (i in 0...11) stack.get();
	}

	static final _emptySafe = testCase(emptySafe, Ok);

	public static final all = testCaseGroup([
		_basic,
		_empty,
		_emptySafe
	]);
}
