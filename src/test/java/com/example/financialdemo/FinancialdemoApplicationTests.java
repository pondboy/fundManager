package com.example.financialdemo;

import org.junit.jupiter.api.Test;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.test.context.SpringBootTest;

import java.text.DecimalFormat;


@SpringBootTest
@MapperScan(basePackages = {"com.example.financialdemo"})
class FinancialdemoApplicationTests {


    @Test
    void contextLoads() {
    }

    @Test
    void test() {
        DecimalFormat format = new DecimalFormat("#.0000");
        String format1 = format.format(0.8700000445);
        String s = "0.854455766556";
        Double aDouble = Double.valueOf(s);
        System.out.println(aDouble+0.1);

        System.out.println(Double.valueOf(format1));

    }

}
