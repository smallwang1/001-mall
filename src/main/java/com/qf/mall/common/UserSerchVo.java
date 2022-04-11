package com.qf.mall.common;

import lombok.Data;

@Data
public class UserSerchVo extends LimitVo{
    private String username;
    private String userSex;
    private String phone;
    private String roleName;

    @Override
    public String toString() {
        return "UserSerchVo{" +
                "username='" + username + '\'' +
                ", userSex='" + userSex + '\'' +
                ", phone='" + phone + '\'' +
                ", roleName='" + roleName + '\'' +
                '}';
    }
}
