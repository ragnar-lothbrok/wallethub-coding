package Palindrome;

public class Palindrome {

	/**
	 * Here we are parsing string from both ends. So loop will run n/2 times.
	 * 
	 * Time Complexity O(n) Space Complexity O(1)
	 * 
	 * @param input
	 * @return
	 */
	public Boolean isPalindrome(String input) {
		if (input == null || input.trim().length() == 0) {
			return true;
		} else {
			input = input.trim();
			for (int i = 0; i < input.trim().length() / 2; i++) {
				if (input.charAt(i) != input.charAt(input.length() - i - 1)) {
					return false;
				}
			}
		}
		return true;
	}

}
