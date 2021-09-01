<#list importedPackages as import>
<#if import.typePackage == "">
import putanja.${import.name?lower_case}.model;
</#if>
</#list>

export interface I${name}{
<#if identityProp??>
	<#if identityProp.upper == 1 >
	${identityProp.name}: ${identityProp.type.name};
	<#else>
	${identityProp.name}: Array<${identityProp.type.name}> ;
	</#if>
</#if>
<#list persistentProps as prop>
	<#if prop.upper == 1 >
	${prop.name}: ${prop.type.name};
	<#else>
	${prop.name}: Array<${prop.type.name}> ;
	</#if>
</#list>
<#list linkedProps as prop>
	<#if prop.upper == 1 >
	${prop.name}: I${prop.type.name} ;
	<#else>
	${prop.name}: Array<I${prop.type.name}> ;
	</#if>
</#list>
}