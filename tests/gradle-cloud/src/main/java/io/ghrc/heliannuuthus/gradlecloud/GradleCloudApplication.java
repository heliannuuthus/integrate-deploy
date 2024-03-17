package io.ghrc.heliannuuthus.gradlecloud;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class GradleCloudApplication {
  public static void main(String[] args) {
    // https://docs.spring.io/spring-boot/docs/2.1.5.RELEASE/reference/html/using-boot-devtools.html#using-boot-devtools-restart-disable
    System.setProperty("spring.devtools.restart.enabled", "false");
    SpringApplication.run(GradleCloudApplication.class, args);
  }
}
