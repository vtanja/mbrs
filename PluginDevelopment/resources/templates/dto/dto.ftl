package com.example.demo.dto;


import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

<#list importedPackages as import>
<#if import.typePackage != "">
import ${import.typePackage}.${import.name};
</#if>
</#list>

@Getter;
@Setter;
@AllArgsConstructor;
@NoArgsConstructor;
public class ${name}DTO{
<#list persistentProps as prop>
	<#if prop.upper == 1 >
	${prop.visibility} ${prop.type.name} ${prop.name};
	<#else>
	${prop.visibility} Set<${prop.type.name}> ${prop.name};
	</#if>
</#list>
}