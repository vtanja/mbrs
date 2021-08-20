package dto;

import java.util.Set;

import lombok.Getter;
import lombok.Setter;

@Getter;
@Setter;
public class ${name}DTO{
<#if identityProp??>
	<#if identityProp.upper == 1 >
	${identityProp.visibility} ${identityProp.type} ${identityProp.name};
	<#else>
	${identityProp.visibility} Set<${identityProp.type}> ${identityProp.name};
	</#if>
</#if>
<#list persistentProps as prop>
	<#if prop.upper == 1 >
	${prop.visibility} ${prop.type} ${prop.name};
	<#else>
	${prop.visibility} Set<${prop.type}> ${prop.name};
	</#if>
</#list>
<#list linkedProps as prop>
	<#if prop.upper == 1 >
	${prop.visibility} ${prop.type}DTO ${prop.name};
	<#else>
	${prop.visibility} Set<${prop.type}DTO> ${prop.name};
	</#if>
</#list>
}