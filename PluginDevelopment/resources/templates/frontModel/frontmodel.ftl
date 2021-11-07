// [ ${.now?date} ${.now?time} ]
// This file is generated based on ${.current_template_name}

<#if importedPackages??>
<#list importedPackages as import>
<#if import.typePackage == "">
import { ${import.name} } from 'src/app/shared/model/${import.name}';
</#if>
</#list>
</#if>

export class ${class.name} {
<#if identityProp??>
	<#if identityProp.upper == 1 >
		${identityProp.name}: number;
	</#if>
</#if>
<#if persistentProps??>
	<#list persistentProps as prop>
		<#if prop.upper == 1 >
		${prop.name}: ${prop.type.name};
		<#else>
		${prop.name}: Array<${prop.type.name}>;
		</#if>
	</#list>
</#if>
<#if linkedProps??>
	<#list linkedProps as prop>
		<#if prop.upper == 1 >
		${prop.name}: ${prop.type.name};
		<#else>
		${prop.name}: Array<${prop.type.name}>;
		</#if>
	</#list>
</#if>
	
	constructor(<#list persistentProps as prop> ${prop.name}: ${prop.type.name}<#sep>,</#sep></#list><#if (persistentProps?size>0)><#if linkedProps??>,</#if></#if><#list linkedProps as prop><#if prop.upper == 1 >${prop.name}: ${prop.type.name}<#sep>,</#sep><#else>${prop.name}: Array<${prop.type.name}><#sep>,</#sep></#if></#list><#if identityProp??><#if identityProp.upper == 1 >,${identityProp.name}: number</#if></#if>){
		<#if identityProp??>
		  this.${identityProp.name} = ${identityProp.name};
		</#if>
		<#if persistentProps??>
		<#list persistentProps as prop>
			this.${prop.name} = ${prop.name};
		</#list>
		</#if>
		<#if linkedProps??>
		<#list linkedProps as prop>
			<#if prop.upper == 1 >
			this.${prop.name} = ${prop.name};
			<#else>
			this.${prop.name} = new Array<${prop.type.name}>();
			</#if>
		</#list>
		</#if>
	}
}