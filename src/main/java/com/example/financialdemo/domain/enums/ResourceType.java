package com.example.financialdemo.domain.enums;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/17 20:15
 */
public enum ResourceType {

    MENU(0,"glyphicon glyphicon-th-list"),
    BUTTON(1,"glyphicon glyphicon-th");

    Integer code;
    String value;

    ResourceType(Integer code, String value) {
        this.code = code;
        this.value = value;
    }

    public static ResourceType getEnumByCode(Integer code) {
        for(ResourceType t : ResourceType.values()) {
            if(t.code.equals(code)) {
                return t;
            }
        }
        return null;
    }

    public Integer code() {
        return code;
    }

    public String value() {
        return value;
    }
}
