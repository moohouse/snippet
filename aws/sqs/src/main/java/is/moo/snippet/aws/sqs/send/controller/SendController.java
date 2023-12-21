package is.moo.snippet.aws.sqs.send.controller;

import io.awspring.cloud.sqs.operations.SqsTemplate;
import io.awspring.cloud.sqs.operations.TemplateAcknowledgementMode;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import software.amazon.awssdk.services.sqs.SqsAsyncClient;

@RestController
@RequiredArgsConstructor
public class SendController {




  @GetMapping("send")
  public String mooing() {


    return "Moo!";

    }
  }


}
