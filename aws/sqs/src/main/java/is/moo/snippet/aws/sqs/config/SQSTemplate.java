package is.moo.snippet.aws.sqs.config;

import io.awspring.cloud.sqs.operations.SqsTemplate;
import io.awspring.cloud.sqs.operations.TemplateAcknowledgementMode;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import software.amazon.awssdk.services.sqs.SqsAsyncClient;

@RequiredArgsConstructor
public class SQSTemplate {
  final SqsAsyncClient sqsAsyncClient;
  @Bean
  public SqsTemplate sqsTemplate() {
    return SqsTemplate.builder()
        .sqsAsyncClient(sqsAsyncClient)
        .configure(options -> options
            .defaultQueue("pa")
            .acknowledgementMode(TemplateAcknowledgementMode.MANUAL)
        )
        .build();
  }
}
