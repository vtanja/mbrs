package com.example.demo.model;

import java.util.Set;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ${name}{
<#if identityProp??>
	<#if identityProp.upper == 1 >
	${identityProp.visibility} ${identityProp.type.name} ${identityProp.name};
	<#else>
	${identityProp.visibility} Set<${identityProp.type.name}> ${identityProp.name};
	</#if>
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
	${prop.visibility} ${prop.type.name} ${prop.name};
	<#else>
	${prop.visibility} Set<${prop.type.name}> ${prop.name};
	</#if>
</#list>
}