// [ ${.now?date} ${.now?time} ]
// This file is generated based on ${.current_template_name}

package com.example.${appName};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ${appName?cap_first}Application {

    public static void main(String[] args) {
        SpringApplication.run(${appName?cap_first}Application.class, args);
    }
}
