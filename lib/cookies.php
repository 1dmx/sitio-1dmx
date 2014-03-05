<?php

class Cookies {

	private static $ttl = '+1 year';

	public static function ttl($set=false)
	{
		if ($set) {
			self::$ttl = $set;
		} else {
			return strtotime(self::$ttl);
		}
	}

	public function __get($name)
	{
		return $_COOKIE[$name];
	}

	public function __set($name, $value)
	{
		setcookie($name, $value, self::ttl());
	}

}

export('cookie', new Cookies());