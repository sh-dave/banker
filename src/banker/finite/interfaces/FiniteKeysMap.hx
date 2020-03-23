package banker.finite.interfaces;

import banker.vector.Vector;

/**
	Interface that can be used for classes generated by `FiniteKeys` macro.

	Not that this is not automatically implemented.
**/
interface FiniteKeysMap<K, V> {
	/**
		@return The value mapped from `key`.
	**/
	function get(key: K): V;

	/**
		Creates a function that gets the value mapped from `key`.
	**/
	function getter(key: K): () -> V;

	/**
		Sets `value` for `key`.
	**/
	function set(key: K, value: V): V;

	/**
		Creates a function that sets the value for `key`.
	**/
	function setter(key: K): (value: V) -> Void;

	/**
		Creates a vector from all keys of `this`.
	**/
	function exportKeys(): Vector<K>;

	/**
		Creates a vector from all values of `this`.
	**/
	function exportValues(): Vector<V>;
}
