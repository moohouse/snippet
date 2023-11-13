package is.moo.snippet.httpinterface.config;

import is.moo.snippet.httpinterface.PostClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.support.WebClientAdapter;
import org.springframework.web.service.invoker.HttpServiceProxyFactory;

@Configuration
public class HttpClientProxyConfig {
  @Bean
  WebClient jsonplaceholderWebClient() {
    return WebClient.builder().baseUrl("https://jsonplaceholder.typicode.com").build();
  }
  @Bean
  PostClient postsClient(WebClient jsonplaceholderWebClient) {
     HttpServiceProxyFactory httpServiceProxyFactory =
        HttpServiceProxyFactory.builder(WebClientAdapter.forClient(jsonplaceholderWebClient))
            .build();
    return httpServiceProxyFactory.createClient(PostClient.class);
  }
}


