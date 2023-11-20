package is.moo.snippet.config;

import io.micrometer.context.ContextExecutorService;
import io.micrometer.context.ContextSnapshotFactory;
import java.util.concurrent.Executor;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

@RequiredArgsConstructor
public class AsyncTraceContextConfig implements AsyncConfigurer {
  private final ThreadPoolTaskExecutor taskExecutor;

  @Override
  public Executor getAsyncExecutor() {
    return ContextExecutorService.wrap(
        taskExecutor.getThreadPoolExecutor(), ContextSnapshotFactory.builder().build()::captureAll);
  }

}