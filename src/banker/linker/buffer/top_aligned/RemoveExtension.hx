package banker.linker.buffer.top_aligned;

class RemoveExtension {
	/** @see `banker.linker.interfaces.Remove` **/
	public static inline function remove<K, V>(
		_this: TopAlignedBuffer<K, V>,
		key: K
	): Bool {
		var found = false;
		final keys = _this.keyVector;
		final values = _this.valueVector;
		final len = _this.size;
		var i = 0;
		while (i < len) {
			if (keys[i] != key) {
				++i;
				continue;
			}

			_this.removeAt(keys, values, len, i);
			found = true;
			break;
		}

		return found;
	}

	/** @see `banker.linker.interfaces.Remove` **/
	public static function removeGet<K, V>(_this: TopAlignedBuffer<K, V>, key: K): V {
		final size = _this.size;
		final keys = _this.keyVector;
		final index = keys.ref.findIndexIn(key, 0, size);
		assert(index >= 0, _this.tag, "Not found.");

		final values = _this.valueVector;
		final value = values[index];
		_this.removeAt(keys, values, size, index);
		return value;
	}

	/** @see `banker.linker.interfaces.Remove` **/
	public static function tryRemoveGet<K, V>(
		_this: TopAlignedBuffer<K, V>,
		key: K
	): Null<V> {
		final size = _this.size;
		final keys = _this.keyVector;
		final index = keys.ref.findIndexIn(key, 0, size);

		return if (index >= 0) {
			final values = _this.valueVector;
			final value = values[index];
			_this.removeAt(keys, values, size, index);
			value;
		} else null;
	}

	/** @see `banker.linker.interfaces.Remove` **/
	public static function removeApply<K, V>(
		_this: TopAlignedBuffer<K, V>,
		key: K,
		callback: K->V->Void
	): Void {
		final keys = _this.keyVector;
		final values = _this.valueVector;
		final len = _this.size;
		var i = 0;
		while (i < len) {
			if (keys[i] != key) {
				++i;
				continue;
			}

			callback(keys[i], values[i]);
			_this.removeAt(keys, values, len, i);
			break;
		}
	}

	/**
		Removes all key-value pairs that match `key`.
		The order is not preserved.

		Used for implementing `banker.linker.interfaces.Remove.removeAll()`.
		@return `true` if any found and removed.
	**/
	public static function removeSwapAll<K, V>(
		_this: TopAlignedBuffer<K, V>,
		key: K
	): Bool {
		var found = false;
		final keys = _this.keyVector;
		final values = _this.keyVector;
		var len = _this.size;
		var i = 0;
		while (i < len) {
			if (keys[i] != key) {
				++i;
				continue;
			}

			--len;
			keys[i] = keys[len];
			values[i] = values[len];
			found = true;
		}

		_this.nextFreeSlotIndex = len;

		return found;
	}
}
