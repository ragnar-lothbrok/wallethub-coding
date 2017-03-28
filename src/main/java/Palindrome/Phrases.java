package Palindrome;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.stream.Collectors;

public class Phrases {

	/**
	 * returns the collection of phrases the will be utilized. Phrase selection
	 * will be based on the number of times the occurred in the file.
	 * 
	 * @param inputStreama
	 * @return
	 */
	public List<Object> getTopPhrases(InputStream inputStream, int limit) {
		List<Object> filtered = null;
		// Create a map, where the key is the phrase,
		// and the value is the number of times phrase occurred in the file.
		Map<String, Integer> topPhrases = new LinkedHashMap<String, Integer>();

		try {

			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
			String line = null;

			// Read every line of the file.
			while ((line = bufferedReader.readLine()) != null) {

				// Split the line to get the phrases.
				String[] linePhrases = line.split("\\|");

				// Read every phrase.
				for (String phrase : linePhrases) {

					// Check if the phrase is already in the collection.
					// If true, then increment the value by 1. Else add the
					// phrase
					// as the new entry to the collection.
					if (topPhrases.containsKey(phrase)) {
						topPhrases.put(phrase, topPhrases.get(phrase).intValue() + 1);
					} else {
						topPhrases.put(phrase, 1);
					}
				}
			}

			// Sort the collection by Map value.
			// Limit the collection to 100000.
			filtered = topPhrases.entrySet().stream().sorted(new Comparator<Entry<String, Integer>>() {
				public int compare(Entry<String, Integer> o1, Entry<String, Integer> o2) {
					return -o1.getValue().compareTo(o2.getValue());
				}
			}).limit(limit).collect(Collectors.toList());

		} catch (Exception e) {
			System.out.println("Exception occured : " + e.getMessage());
		}
		return filtered;
	}

}
