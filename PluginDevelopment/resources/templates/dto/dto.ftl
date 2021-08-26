package demo.dto;

import java.util.Set;

import lombok.Getter;
import lombok.Setter;

<#list importedPackages as import>
<#if import.typePackage != "">
import ${import.typePackage}.${import.name};
<#else>
import demo.dto.${import.name}DTO;
</#if>
</#list>

@Getter;
@Setter;
public class ${name}DTO{
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
	${prop.visibility} ${prop.type.name}DTO ${prop.name};
	<#else>
	${prop.visibility} Set<${prop.type.name}DTO> ${prop.name};
	</#if>
</#list>
}