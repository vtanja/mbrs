<#list importedPackages as import>
<#if import.typePackage == "">
import { ${import.name} } from 'src/app/${import.name}Model';
</#if>
</#list>

export class ${class.name} {
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
	
	constructor(<#list persistentProps as prop> ${prop.name}: ${prop.type.name}<#sep>,</#sep></#list><#list linkedProps as prop><#if prop.upper == 1 >, ${prop.name}: ${prop.type.name}<#else>, ${prop.name}: Array<${prop.type.name}></#if></#list>){
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