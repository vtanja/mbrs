// [ ${.now?date} ${.now?time} ]
// This file is generated based on ${.current_template_name}

package com.example.${appName}.dto;

import java.util.Set;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ${name}DetailDTO{
<#if identityProp??>
	${identityProp.visibility} ${identityProp.type.name} ${identityProp.name};
<#else>
	private Long id;
</#if>
<#list persistentProps as prop>
	<#if prop.upper == 1 >
	${prop.visibility} ${prop.type.name} ${prop.name};
	<#else>
	${prop.visibility} Set<${prop.type.name}> ${prop.name};
	</#if>
</#list>
<#list linkedProps as prop>
	<#if prop.upper == 1 >
	${prop.visibility} ${prop.type.name}DTO ${prop.name};
	<#else>
	${prop.visibility} Set<${prop.type.name}DTO> ${prop.name};
	</#if>
</#list>
<#if identityProp??>
	public ${identityProp.type.name} getId(){
		return ${identityProp.name};
	}
</#if>
}