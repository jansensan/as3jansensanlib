package net.jansensan.time
{
	/**
	 * @author Mat Janson Blanchet
	 */
	public class Time
	{
		private	var	_years		:Number = 0;
		private	var	_months		:Number = 0;
		private	var	_days		:Number = 0;
		private	var	_hours		:Number = 0;
		private	var	_minutes	:Number = 0;
		private	var	_seconds	:Number = 0;
		private	var	_ms			:Number = 0;


		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------

		public static function getTimeDifference(startTime:Date, endTime:Date):Time
		{
			var msDiff:Number = endTime.valueOf() - startTime.valueOf();
			
			var timeDiff:Time = new Time();
			timeDiff.days = Math.round(msDiff / (24 * 60 * 60 * 1000));
			timeDiff.hours = Math.round(msDiff / (60 * 60 * 1000)) % 24;
			timeDiff.minutes = Math.round(msDiff / (60 * 1000)) % 60;
			timeDiff.seconds = Math.round(msDiff / (1 * 1000)) % 60;
			
			return timeDiff;
		}


		public function toString():String
		{
			return '[Time years=' + _years + ' months=' + _months + ' days=' + _days + ' hours=' + _hours + ' minutes=' + _minutes + ' seconds=' + _seconds + ' ms=' + _ms + ']';
		}


		// + ----------------------------------------
		//		[ GETTERS / SETTERS ]
		// + ----------------------------------------

		public function get years():int
		{
			return _years;
		}


		public function set years(years:int):void
		{
			_years = years;
		}


		public function get months():int
		{
			return _months;
		}


		public function set months(months:int):void
		{
			_months = months;
		}


		public function get days():int
		{
			return _days;
		}


		public function set days(days:int):void
		{
			_days = days;
		}


		public function get hours():int
		{
			return _hours;
		}


		public function set hours(hours:int):void
		{
			_hours = hours;
		}


		public function get minutes():int
		{
			return _minutes;
		}


		public function set minutes(minutes:int):void
		{
			_minutes = minutes;
		}


		public function get seconds():int
		{
			return _seconds;
		}


		public function set seconds(seconds:int):void
		{
			_seconds = seconds;
		}


		public function get ms():int
		{
			return _ms;
		}


		public function set ms(ms:int):void
		{
			_ms = ms;
		}
	}
}
