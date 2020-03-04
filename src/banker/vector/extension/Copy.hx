package banker.vector.extension;

class Copy {
	/**
		@return Shallow copy of `this`.
	**/
	#if !banker_generic_disable
	@:generic
	#end
	public static inline function copy<T>(_this: VectorReference<T>): Vector<T> {
		return Vector.fromData(_this.data.copy());
	}

	/**
		@return Shallow copy of `this`.
	**/
	#if !banker_generic_disable
	@:generic
	#end
	public static inline function copyWritable<T>(
		_this: VectorReference<T>
	): WritableVector<T> {
		return WritableVector.fromData(_this.data.copy());
	}

	/**
		Creates a new vector by shallow-copying a range of `this`.
	**/
	#if !banker_generic_disable
	@:generic
	#end
	public static inline function subVector<T>(
		_this: VectorReference<T>,
		position: Int,
		length: Int
	): Vector<T> {
		return Vector.fromData(_this.data.sub(position, length));
	}

	/** @see `subVector()` **/
	#if !banker_generic_disable
	@:generic
	#end
	public static inline function subVectorWritable<T>(
		_this: VectorReference<T>,
		position: Int,
		length: Int
	): WritableVector<T> {
		return WritableVector.fromData(_this.data.sub(position, length));
	}

	/** @see `concat()` **/
	#if !banker_generic_disable
	@:generic
	#end
	public static inline function concatWritable<T>(
		_this: VectorReference<T>,
		otherVector: VectorReference<T>
	): WritableVector<T> {
		final thisLength = _this.length;
		final otherLength = otherVector.length;
		final newVector = new WritableVector(thisLength + otherLength);
		// @formatter:off
		VectorTools.blit(_this, 0, newVector, 0, thisLength);
		VectorTools.blit(otherVector, 0, newVector, thisLength, otherLength);
		// @formatter:on
		return newVector;
	}

	/**
		Returns a new concatenated vector.
	**/ #if !banker_generic_disable @:generic #end
	public static inline function concat<T>(
		_this: VectorReference<T>,
		otherVector: VectorReference<T>
	): Vector<T> {
		return concatWritable(_this, otherVector).nonWritable();
	}

	/**
		Creates a new vector by slicing `this`.
		@param startPosition The position in `this` to begin (included).
		@param endPosition The position in `this` to end (not included).
	**/
	#if !banker_generic_disable
	@:generic
	#end
	public static inline function slice<T>(
		_this: VectorReference<T>,
		startPosition: Int,
		endPosition: Int
	): Vector<T> {
		return Vector.fromData(_this.data.sub(
			startPosition,
			endPosition - startPosition
		));
	}

	/** @see `Copy.slice()` **/
	#if !banker_generic_disable
	@:generic
	#end
	public static inline function sliceWritable<T>(
		_this: VectorReference<T>,
		startPosition: Int,
		endPosition: Int
	): WritableVector<T> {
		return slice(_this, startPosition, endPosition).writable();
	}

	/**
		Creates a new array by slicing `this`.
		@param startPosition The position in `this` to begin (included).
		@param endPosition The position in `this` to end (not included).
	**/
	#if !banker_generic_disable
	@:generic
	#end
	public static function sliceToArray<T>(
		_this: VectorReference<T>,
		startPosition: Int,
		endPosition: Int
	): Array<T> {
		return [for (i in startPosition...endPosition) _this[i]];
	}
}