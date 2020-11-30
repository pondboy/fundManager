package com.example.financialdemo.domain.enums;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/17 20:15
 */
public enum Type {

    STEADY("steady","稳健型"),
    RADICAL("radical","激进型"),
    OPTION("option","自选基金");

    String code;
    String value;

    Type(String code,String value) {
        this.code = code;
        this.value = value;
    }

    public static Type getEnumByCode(String code) {
        for(Type t : Type.values()) {
            if(t.code.equals(code)) {
                return t;
            }
        }
        return null;
    }

    public String code() {
        return code;
    }

    public String value() {
        return value;
    }
}
