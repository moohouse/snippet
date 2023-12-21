package is.moo.snippet.aws.sqs.config;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.AsyncTaskExecutor;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.services.sqs.SqsAsyncClient;
import io.awspring.cloud.sqs.config.SqsMessageListenerContainerFactory;
@Configuration
@RequiredArgsConstructor
public class SQSConfig {

  ProfileCredentialsProvider credentialsProvider = ProfileCredentialsProvider.create();

  @Bean
  public SqsAsyncClient sqsAsyncClient() {
    return SqsAsyncClient.builder().credentialsProvider(credentialsProvider).build();
  }


  @Bean
  SqsMessageListenerContainerFactory<Object> sqsMessageListenerContainerFactory(SqsAsyncClient sqsAsyncClient) {
    SqsMessageListenerContainerFactory<Object> factory = new SqsMessageListenerContainerFactory<>();
    factory.setSqsAsyncClient(sqsAsyncClient);
    return factory;
  }

//  @Bean
//  public SqsMessageListenerContainerFactory sqsMessageListenerContainerFactory(
//    SqsAsyncClient sqsAsyncClient, @Qualifier("publishThreadPoolTaskExecutor") AsyncTaskExecutor asyncTaskExecutor) {
//
//    SqsMessageListenerContainerFactory factory = new SqsMessageListenerContainerFactory();
//    return SqsMessageListenerContainerFactory
//        .builder()
//        .sqsAsyncClient(sqsAsyncClient)
//        .build();
//  }


//    SimpleMessageListenerContainerFactory factory = new SimpleMessageListenerContainerFactory();
//    factory.setAmazonSqs(amazonSqs);
//    factory.setMaxNumberOfMessages(10);
//    factory.setVisibilityTimeout(20);
//    factory.setWaitTimeOut(10);
//    factory.setBackOffTime(Long.valueOf(60000));
//    factory.setTaskExecutor(asyncTaskExecutor);
//    factory.setQueueMessageHandler(new QueueMessageHandler());
//    return factory;
//  }
  


  //
//  @Bean
//  public SqsAsyncClient sqsAsyncClient() {
//    return SqsAsyncClient.builder().build();
//  }
//
//  @Bean
//  public Listener listener() {
//    return new Listener();
//  }

//  public AmazonSQSAsync amazonSqs() {
//    BasicAWSCredentials bAWSc = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
//    return AmazonSQSAsyncClientBuilder.standard()
//        .withRegion(Regions.AP_NORTHEAST_2)
//        .withCredentials(new AWSStaticCredentialsProvider(bAWSc ))
//        .build();
//  }
//
//  AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
//      .withCredentials(DefaultAWSCredentialsProviderChain.getInstance())
//      .build();



//  private static LazyAwsCredentialsProvider createChain(Builder builder) {
//
//    return LazyAwsCredentialsProvider.create(() -> {
//      AwsCredentialsProvider[] credentialsProviders = new AwsCredentialsProvider[] {
//          ProfileCredentialsProvider.builder()
//              .profileFile("")
//              .profileName(builder.profileName)
//              .build(),
//      };
//
//      return AwsCredentialsProviderChain.builder()
//          .reuseLastProviderEnabled(reuseLastProviderEnabled)
//          .credentialsProviders(credentialsProviders)
//          .build();
//    });
//  }


}
