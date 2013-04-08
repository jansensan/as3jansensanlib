package net.jansensan.utils
{
	/**
	* Utilies set for arrays.
	* 
	* @author Mat Janson Blanchet
	*/
	public class ArrayUtils
	{
		// + ----------------------------------------
		//		[ PUBLIC METHODS ]
		// + ----------------------------------------
		
		/**
		 * @param	array			The array into which the search is to be made.
		 * @param	valueToMatch	The value to be found in the array.
		 * 
		 * @return	The index of the found value.
		*/
		public static function findIndexOf(array:Array, valueToMatch:*):int
		{
			var i			:int = 0;
			var loopLength	:int = array.length;
			
			for(i; i < loopLength; i++)
			{
				if(array[i] == valueToMatch)
				{
					return i;
				}
			}
			
			return -1;
		}
		
		
		/**
		 * @param	array			The array into which the search is to be made.
		 * @param	valueToMatch	The value to be found in the array.
		 * 
		 * @return	The index of the first index whose value matches the desired value.
		*/
		public static function findFirstMatchIndex(array:Array, valueToMatch:*):int
		{
			var i			:int = 0;
			var loopLength	:int = array.length;
			var index		:int;
			
			for(i; i < loopLength; i++)
			{
				if(array[i] == valueToMatch)
				{
					index = i;
					break;
				}
				else
				{
					index = -1;
				}
			}
			
			return index;
		}
		
		
		/**
		 * @param	array			The array into which the search is to be made.
		 * @param	valueToMatch	The value to be found in the array.
		 * 
		 * @return	The index of the last index whose value matches the desired value.
		*/
		public static function findLastMatchIndex(array:Array, valueToMatch:*):int
		{
			var i:int = array.length;
			var index		:int;
			
			for(i; i > 0; i--)
			{
				if(array[i] == valueToMatch)
				{
					index = i;
					break;
				}
				else
				{
					index = -1;
				}
			}
			
			return index;
		}
		
		
		/**
		 * @param	array			The array into which the search is to be made.
		 * @param	valueToMatch	The value to be found in the array.
		 * 
		 * @return	An array of all the indexes where the desired value matches.
		*/
		public static function findAllMatches(array:Array, valueToMatch:*):Array
		{
			var i			:int = 0 ;
			var loopLength	:int = array.length;
			var matches		:Array = [];
			
			for(i; i < loopLength; i++)
			{
				if(array[i] == valueToMatch) matches.push(i);
			}
			
			return matches;
		}
		
		
		/**
		 * @param	array			The array into which the search is to be made.
		 * @param	valueToMatch	The value to be found in the array.
		 * 
		 * @return	An integer representing the amount of items that matches the desired value.
		*/
		public static function countMatches(array:Array, valueToMatch:*):int
		{
			var i			:int = 0;
			var loopLength	:int = array.length;
			var numMatches	:int = 0;
			
			for(i; i < loopLength; i++)
			{
				if(array[i] == valueToMatch)
				{
					numMatches++;
				}
			}
			
			return numMatches;
		}
		
		
		/*
		public static function removeDuplicateEntries(array:Array):Array
		{
			
			 * @param array The array into which the search is to be made.
			 * @return An array stripped of duplicate entries.
			
			// FIXME: while loop seems to be infinite
			var tempArray		:Array = array;
			var tempArrayLength	:int = tempArray.length;
			var i				:int;
			var j				:int;
			var	ti				:*;
			
			for(i = 0; i < tempArrayLength; i++)
			{
				ti = tempArray[i];
				for(j = (i + 1); j < tempArrayLength; ++j)
				{
					while(ti == tempArray[j])
					{
						tempArray.splice(j, 1);
					}
				}
			}
			
			return array;
		}
		*/
		
		
		/**
		 * @param	array			The array into which the search is to be made.
		 * @param	valueToMatch	The value to be found in the array.
		 * 
		 * @return	An array stripped of duplicate entries.
		*/
		public static function pushIfMissing(array:Array, valueToMatch:*):Array
		{
			if(ArrayUtils.findIndexOf(valueToMatch, array) == -1)
			{
				array.push(valueToMatch);
			}
			return array;
		}
		
		
		/**
		 * @param	array			The array into which the search is to be made.
		 * @param	indexToMatch	The index to be removed from the array.
		 * 
		 * @return	An array stripped the index to be removed.
		*/
		public static function removeIndex(array:Array, indexToMatch:*):Array
		{
			var i			:int = 0;
			var loopLength	:int = array.length;
			var newArray	:Array = [];
			
			for(i; i < loopLength; i++)
			{
				if(i != indexToMatch)
				{
					newArray.push(array[i]);
				}
			}
			
			return newArray;
		}
		
		
		/**
		 * @param	array			The array into which the search is to be made.
		 * @param	valueToMatch	The value to be removed from the array.
		 * 
		 * @return	An array stripped of the value to be removed.
		*/
		public static function removeValue(array:Array, valueToMatch:*):Array
		{
			var i			:int = 0;
			var loopLength	:int = array.length;
			var newArray	:Array = [];
			
			for(i; i < loopLength; i ++)
			{
				if(array[i] != valueToMatch)
				{
					newArray.push(array[i]);
				}
			}
			
			return newArray;
		}
		
		
		/**
		 * @param	numToShift	The amount of shifting that should be applied to the items in the array.
		 * @param	array		The array to which the modification is to be made.
		 * 
		 * @return	An array with its value shifted.
		*/
		public static function shiftItemsIndex(array:Array, numToShift:int):Array
		{
			var i			:int;
			var arrayLength	:int = array.length;
			var newArray	:Array = new Array(arrayLength);
			
			numToShift = numToShift % arrayLength;
			if(numToShift < 0)
			{
				for(i = 0; i < arrayLength; i++)
				{
					if(i < Math.abs(numToShift))
					{
						newArray[arrayLength - Math.abs(numToShift + i)] = array[i];
					}
					else
					{
						newArray[i - Math.abs(numToShift)] = array[i];
					}
				}
			}
			else if(numToShift > 0)
			{
				for(i = 0; i < arrayLength; i++)
				{
					if((i + numToShift) < arrayLength)
					{
						newArray[(i + numToShift)] = array[i];
					}
					else
					{
						newArray[(i - (arrayLength - numToShift))] = array[i];
					}
				}
			}
			if (numToShift == 0)
			{
				return array;
			}
			else
			{
				return newArray;
			}
		}
		
		
		/**
		 * @param	arrayLength	The length of the array from which random indexes will be obtained. If the parameteter is lower than 1, the function returns null;
		 * @param	numIndexes	The amount of indexes the function will return. The minimum 1 and the maximum is the value of arrayLength. If the numIndexes parameter is less than 1, it is normalized to 1. If numIndexes is more than arrayLength, it is normalized to arrayLength.
		 * @return	An array of the random obtained random indexes.
		*/
		public static function getRandomIndexes(arrayLength:uint = 1, numIndexes:uint = 1):Array
		{
			if(arrayLength < 1)
			{
				return null;
			}
			else
			{
				if(numIndexes < 1)
				{
					numIndexes = 1;
				}
				else if(numIndexes > arrayLength)
				{
					numIndexes = arrayLength;
				}
				
				var index:uint;
				var randomIndexes:Array = [];
				var numRandomIndexes:uint = 0;
				
				var i:int;
				var loopLength:int;
				var indexUsed:Boolean = false;
				
				while(numRandomIndexes < numIndexes)
				{
					index = Math.random() * arrayLength;
					loopLength = randomIndexes.length;
					for(i = 0; i < loopLength; i++)
					{
						if(randomIndexes[i] == index) indexUsed = true;
					}
					if(!indexUsed) randomIndexes.push(index);
					numRandomIndexes = randomIndexes.length;
					indexUsed = false;
				}
				
				return randomIndexes;
			}
		}
		
		
	}
}
