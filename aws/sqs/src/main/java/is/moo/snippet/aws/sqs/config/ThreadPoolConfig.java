package is.moo.snippet.aws.sqs.config;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

public class ThreadPoolConfig {
  @Bean
  @Qualifier("publishThreadPoolTaskExecutor")
  public ThreadPoolTaskExecutor publishThreadPoolTaskExecutor() {
    ThreadPoolTaskExecutor threadPoolTaskExecutor = new ThreadPoolTaskExecutor();
    threadPoolTaskExecutor.setCorePoolSize(25);
    threadPoolTaskExecutor.setMaxPoolSize(50);
    threadPoolTaskExecutor.setQueueCapacity(0);
    threadPoolTaskExecutor.setThreadNamePrefix("Publish-");
    threadPoolTaskExecutor.setRejectedExecutionHandler(new BlockingTaskSubmissionPolicy(1000));
    threadPoolTaskExecutor.initialize();
    return threadPoolTaskExecutor;
  }

  @Bean
  @Qualifier("subscribeThreadPoolTaskExecutor")
  public ThreadPoolTaskExecutor subscribeThreadPoolTaskExecutor() {
    ThreadPoolTaskExecutor threadPoolTaskExecutor = new ThreadPoolTaskExecutor();
    threadPoolTaskExecutor.setCorePoolSize(25);
    threadPoolTaskExecutor.setMaxPoolSize(50);
    threadPoolTaskExecutor.setQueueCapacity(0);
    threadPoolTaskExecutor.setThreadNamePrefix("Sub-");
    threadPoolTaskExecutor.setRejectedExecutionHandler(new BlockingTaskSubmissionPolicy(1000));
    threadPoolTaskExecutor.initialize();
    return threadPoolTaskExecutor;
  }


}
