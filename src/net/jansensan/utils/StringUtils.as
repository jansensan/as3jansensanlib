package net.jansensan.utils
{
	/**
	 * @author Mat Janson Blanchet
	 */
	public class StringUtils
	{
		/**
		 * Sets a minimum amount of digits to a string, for example, for if a number like "6" needs to be displayed like "06". Zeros are added at the beginning of the display.
		 * 
		 * @param number	The number to display.
		 * @param numDigits	The amount of digits desired for the display.
		 * 
		 * @return	A string with the proper amount of digits.
		 */
		public static function setMinNumDigits	(	number:uint,
													numDigits:uint
												):String
		{
			var numbers:Array = number.toString().split("");
			var numberString:String = "";
			
			if(numbers.length < numDigits)
			{
				var i:int;
				var numLoops:int;
				
				// leading zeros
				numLoops = numDigits - numbers.length;
				for(i = 0; i < numLoops; ++i)
				{
					numberString += "0";
				}
				
				// remaining numbers
				numLoops = numbers.length;
				for(i = 0; i < numLoops; ++i)
				{
					numberString += numbers[i].toString();
				}
			}
			else
			{
				numberString = number.toString();
			}
			return numberString;
		}


		/**
		 * Converts a number to a 00:00:00,000 format.
		 * 
		 * @param number	The number to convert.
		 * 
		 * @return	A string formatted to to a 00:00:00,000.
		 */
		public static function convertSecondsToHHMMSSmmm(number:Number):String
		{
			var HHMMSSmmm:String = "";
			var hours:int;
			var minutes:int;
			var seconds:int;
			var milliseconds:Number;
			
			milliseconds = Math.round((number - int(number)) * 1000);
			seconds = int(number);
			hours = int(seconds / (60 * 60));
			seconds -= hours * (60 * 60);
			minutes = int(seconds / 60);
			seconds -= minutes * 60;
			
			HHMMSSmmm += StringUtils.setMinNumDigits(hours, 2) + ":";
			HHMMSSmmm += setMinNumDigits(minutes, 2) + ":";
			HHMMSSmmm += setMinNumDigits(seconds, 2) + ",";
			HHMMSSmmm += setMinNumDigits(milliseconds, 3);
			
			return HHMMSSmmm;
		}
	}
}
