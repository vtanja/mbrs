export interface I${name}{
<#if identityProp??>
	<#if identityProp.upper == 1 >
	${identityProp.name}: ${identityProp.type};
	<#else>
	${identityProp.name}: Array<${identityProp.type}> ;
	</#if>
</#if>
<#list persistentProps as prop>
	<#if prop.upper == 1 >
	${prop.name}: ${prop.type};
	<#else>
	${prop.name}: Array<${prop.type}> ;
	</#if>
</#list>
<#list linkedProps as prop>
	<#if prop.upper == 1 >
	${prop.name}: I${prop.type} ;
	<#else>
	${prop.name}: Array<I${prop.type}> ;
	</#if>
</#list>
}