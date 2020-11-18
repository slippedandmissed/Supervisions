package uk.ac.cam.jbs52.q9;

import static com.google.common.truth.Truth.assertThat;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public class SearchSetTest {
	
	@Test
	public void searchSet_getNumberElementsIsZero_whenEmpty() {
		SearchSet set = new SearchSet();
		
		int value = set.getNumberElements();
		
		assertThat(value).isEqualTo(0);
	}
	
	@Test
	public void searchSet_getNumberElementsIsThree_whenThreeElementsAdded() {
		SearchSet set = new SearchSet();
		set.insert(1);
		set.insert(2);
		set.insert(3);
		
		int value = set.getNumberElements();
		
		assertThat(value).isEqualTo(3);
	}
	
	@Test
	public void searchSet_containsOne_whenTwoOneThreeAdded() {
		SearchSet set = new SearchSet();
		set.insert(2);
		set.insert(1);
		set.insert(3);
		
		boolean value = set.contains(1);
		
		assertThat(value).isEqualTo(true);
	}
	
	@Test
	public void searchSet_containsOne_whenOneAdded() {
		SearchSet set = new SearchSet();
		set.insert(1);
		
		boolean value = set.contains(1);
		
		assertThat(value).isEqualTo(true);
	}
	
	@Test
	public void searchSet_doesntContainOne_whenTwoAdded() {
		SearchSet set = new SearchSet();
		set.insert(2);
		
		boolean value = set.contains(1);
		
		assertThat(value).isEqualTo(false);
	}
	
	@Test
	public void searchSet_doesntContainOne_whenEmpty() {
		SearchSet set = new SearchSet();
		
		boolean value = set.contains(1);
		
		assertThat(value).isEqualTo(false);
	}

	
}
