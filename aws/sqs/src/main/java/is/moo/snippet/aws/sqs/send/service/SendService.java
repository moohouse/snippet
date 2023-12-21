package is.moo.snippet.aws.sqs.send.service;

import io.awspring.cloud.sqs.operations.SendResult;
import io.awspring.cloud.sqs.operations.SqsTemplate;
import io.awspring.cloud.sqs.operations.TemplateAcknowledgementMode;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;
import software.amazon.awssdk.services.sqs.SqsAsyncClient;

@Service
@RequiredArgsConstructor
public class SendService {

  final SqsAsyncClient sqsAsyncClient;
  final SqsTemplate sqsTemplate;

  @Bean
  public SqsTemplate send() {

    SendResult<String> result = sqsTemplate.send(to -> to.queue("myQueue")
        .payload("myPayload")
        .header("myHeaderName", "myHeaderValue")
        .headers(Map.of("myOtherHeaderName", "myOtherHeaderValue"))
        .delaySeconds(10)
    );


    return null;

  }
}
