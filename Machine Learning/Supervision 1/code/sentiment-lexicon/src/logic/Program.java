package logic;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

public class Program {

	public static class SentimentWithIntensity {
		public static enum Intensity {
			WEAK, STRONG;
		}

		public final Sentiment sentiment;
		public final Intensity intensity;

		public SentimentWithIntensity(Sentiment sentiment, Intensity intensity) {
			this.sentiment = sentiment;
			this.intensity = intensity;
		}
	}

	public static Map<String, SentimentWithIntensity> loadSentimentLexiconWithIntensity(Path lexiconFile)
			throws IOException {
		Map<String, SentimentWithIntensity> map = new HashMap<String, SentimentWithIntensity>();
		BufferedReader reader = Files.newBufferedReader(lexiconFile);
		String currentLine = null;
		while ((currentLine = reader.readLine()) != null) {
			String[] parts = currentLine.split(" ");
			String word = parts[0].split("=")[1];
			Sentiment polarity = parts[2].split("=")[1].equals("positive") ? Sentiment.POSITIVE : Sentiment.NEGATIVE;
			SentimentWithIntensity.Intensity intensity = parts[1].split("=")[1].equals("weak")
					? SentimentWithIntensity.Intensity.WEAK
					: SentimentWithIntensity.Intensity.STRONG;
			map.put(word, new SentimentWithIntensity(polarity, intensity));
		}
		return map;

	}

	public static Map<String, Sentiment> loadSentimentLexicon(Path lexiconFile) throws IOException {
		Map<String, Sentiment> map = new HashMap<String, Sentiment>();
		Map<String, SentimentWithIntensity> sentimentsWithIntensities = loadSentimentLexiconWithIntensity(lexiconFile);
		for (String string : sentimentsWithIntensities.keySet()) {
			map.put(string, sentimentsWithIntensities.get(string).sentiment);
		}
		return map;
	}

	public static Sentiment simpleClassifier(List<String> words, Path lexiconFile) throws IOException {
		Map<String, Sentiment> lexicon = loadSentimentLexicon(lexiconFile);
		int judgement = 0;
		for (String word : words) {
			Sentiment polarity = lexicon.get(word);
			if (polarity != null) {
				judgement += polarity == Sentiment.POSITIVE ? 1 : -1;
			}
		}
		return judgement >= 0 ? Sentiment.POSITIVE : Sentiment.NEGATIVE;
	}

	public static Sentiment improvedClassifier(List<String> words, Path lexiconFile) throws IOException {
		final double STRONG_MULTIPLIER = 10;
		final double COUNT_MULTIPLIER = 0.03;

		Map<String, SentimentWithIntensity> lexicon = loadSentimentLexiconWithIntensity(lexiconFile);
		int judgement = 0;
		Map<String, Integer> count = new HashMap<String, Integer>();
		for (String word : words) {
			SentimentWithIntensity sentimentWithIntensity = lexicon.get(word);
			if (sentimentWithIntensity != null) {
				Integer c = count.get(word);
				if (c == null) {
					c = 0;
				}
				count.put(word, ++c);
				judgement += (sentimentWithIntensity.sentiment == Sentiment.POSITIVE ? 1 : -1)
						* ((sentimentWithIntensity.intensity == SentimentWithIntensity.Intensity.STRONG
								? STRONG_MULTIPLIER
								: 1) + (c * COUNT_MULTIPLIER));
			}
		}
		return judgement >= 0 ? Sentiment.POSITIVE : Sentiment.NEGATIVE;
	}

	public static void main(String[] args) throws IOException {
		String text = "I like to play this game called nap roulette. It's where I take a nap but don't set an alarm. Will it be a 30 min nap? Will it be a 4 hour nap? Nobody knows. But it's risky. And I like it.";
		List<String> tokens = new ArrayList<String>(new HashSet<String>(Tokenizer.tokenize(new StringReader(text))));

		tokens.sort((s1, s2) -> s1.compareTo(s2));

		System.out.println(tokens);

		Path dataDirectory = Paths.get("data/sentiment_dataset");
		Path lexiconFile = Paths.get("data/sentiment_lexicon");

		System.out.println("Simple " + simpleClassifier(tokens, lexiconFile));
		System.out.println("Improved " + improvedClassifier(tokens, lexiconFile));
		
		Path sentimentFile = dataDirectory.resolve("review_sentiment");
		Map<Path, Sentiment> dataSet = DataPreparation1.loadSentimentDataset(dataDirectory.resolve("reviews"),
				sentimentFile);

		Exercise2 e2 = new Exercise2();
		System.out.println("NB: " + e2.naiveBayes(tokens, e2.calculateSmoothedLogProbs(dataSet), e2.calculateClassProbabilities(dataSet)));
	}

}
