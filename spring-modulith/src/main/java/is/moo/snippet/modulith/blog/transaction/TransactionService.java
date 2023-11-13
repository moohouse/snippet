package is.moo.snippet.modulith.blog.transaction;

import is.moo.snippet.modulith.blog.notification.NotificationDTO;
import is.moo.snippet.modulith.blog.notification.NotificationService;
import jakarta.transaction.Transactional;
import java.util.Date;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TransactionService {

    private final @NonNull ApplicationEventPublisher events;
    private final @NonNull NotificationService notificationService;

    @Transactional
    public void create(String name) {
        notificationService.createNotification(new NotificationDTO(new Date(), "SMS", name));
        events.publishEvent(new NotificationDTO(new Date(), "SMS", name));
    }
}