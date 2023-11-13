package is.moo.snippet.httpinterface;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.nio.charset.StandardCharsets;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
@SpringBootTest
@AutoConfigureMockMvc
class HttpInterfaceControllerTest {
  @Autowired
  private MockMvc mockMvc;

  @Test
  void GET_POSTS() throws Exception {
    MvcResult mvcResult = mockMvc.perform(
            MockMvcRequestBuilders
                .get("/posts")
                .contentType(MediaType.APPLICATION_JSON)
                .characterEncoding(StandardCharsets.UTF_8))
        .andDo(print())
        .andExpect(status().is2xxSuccessful()).andReturn();
  }
}