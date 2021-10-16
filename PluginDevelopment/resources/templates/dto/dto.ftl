// [ ${.now?date} ${.now?time} ]
// This file is generated based on ${.current_template_name}

package com.example.${appName}.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ${name}DTO{
<#if identityProp??>
	protected ${identityProp.type.name} ${identityProp.name};
<#else>
	protected Long id;
</#if>
<#list persistentProps as prop>
	<#if prop.upper == 1 >
	protected ${prop.type.name} ${prop.name};
	<#else>
	protected Set<${prop.type.name}> ${prop.name};
	</#if>
</#list>
<#if identityProp??>
	public ${identityProp.type.name} getId(){
		return ${identityProp.name};
	}
</#if>
}