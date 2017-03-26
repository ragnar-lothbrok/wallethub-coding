import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Time complexity O(n) Best case , Worst Case O<n^2)
 * 
 * @author raghunandan.gupta
 *
 */
public class ComplementaryPairs {

	/**
	 * This class will keep pairs
	 * 
	 * @author raghunandan.gupta
	 *
	 */
	class Pair {
		private int num1;
		private int num2;

		public Pair(int num1, int num2) {
			super();
			this.num1 = num1;
			this.num2 = num2;
		}

		@Override
		public String toString() {
			return "Pair [num1=" + num1 + ", num2=" + num2 + "]";
		}

	}

	public List<Pair> getComplementaryPairs(int[] input, int K) {
		List<Pair> pairs = new ArrayList<Pair>();

		HashMap<Integer, Integer> diffMap = new HashMap<Integer, Integer>();

		// This loop's complexity will be O(N)
		if (input != null) {
			for (int i = 0; i < input.length; i++) {
				if (diffMap.get(input[i]) == null) {
					diffMap.put(input[i], 1);
				} else {
					diffMap.put(input[i], diffMap.get(input[i]) + 1);
				}
			}
		}

		// Iterating through HashMap and decrementing
		for (Integer key : diffMap.keySet()) {
			int remainder = K - key;
			if (diffMap.get(remainder) != null && diffMap.get(remainder) > 0 && diffMap.get(key) > 0) {
				int min = Math.min(diffMap.get(remainder), diffMap.get(key));
				diffMap.put(remainder, diffMap.get(remainder) - min);
				diffMap.put(key, diffMap.get(key) - min);
				if (key != remainder || (key == remainder && min > 1)) {
					Pair pair = new Pair(key, remainder);
					pairs.add(pair);
				}
			}
		}

		return pairs;
	}
}
