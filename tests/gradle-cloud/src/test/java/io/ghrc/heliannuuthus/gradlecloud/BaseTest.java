package io.ghrc.heliannuuthus.gradlecloud;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class BaseTest {

  @Test
  @DisplayName("unit test")
  void test() {
    Assertions.assertEquals(1, Integer.parseInt("1"));
  }
}
