package com.uniconnect.backend.dto;


import com.uniconnect.backend.model.User;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class UsersListResponse {
    final List<User> userList;
}
