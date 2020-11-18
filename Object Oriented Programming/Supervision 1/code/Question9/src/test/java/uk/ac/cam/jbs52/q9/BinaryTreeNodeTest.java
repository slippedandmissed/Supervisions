package uk.ac.cam.jbs52.q9;

import static com.google.common.truth.Truth.assertThat;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public class BinaryTreeNodeTest {
	
	@Test
	public void binaryTreeNode_getValueIsOne_whenConstructedWithOne() {
		BinaryTreeNode node = new BinaryTreeNode(1);
		
		int value = node.getValue();
		
		assertThat(value).isEqualTo(1);
	}
	
	@Test
	public void binaryTreeNode_getValueIsOne_whenSetOne() {
		BinaryTreeNode node = new BinaryTreeNode(2);
		node.setValue(1);
		
		int value = node.getValue();
		
		assertThat(value).isEqualTo(1);
	}
}
