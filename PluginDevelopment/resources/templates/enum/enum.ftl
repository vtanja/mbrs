// [ ${.now?date} ${.now?time} ]
// This file is generated based on ${.current_template_name}

package com.example.${appName}.enums;

public enum ${name} {
    <#list values as value>
    ${value},
    </#list>
}