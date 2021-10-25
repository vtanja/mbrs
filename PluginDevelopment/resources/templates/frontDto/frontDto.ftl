// [ ${.now?date} ${.now?time} ]
// This file is generated based on ${.current_template_name}

<#list importedPackages as import>
<#if import.typePackage == "">
import { ${import.name} } from './${imports[import.name]}.model';
</#if>
</#list>

export class ${name}{
<#if identityProp??>
	${identityProp.name}: ${identityProp.type.name} = -1;
<#else>
	id: number = -1;
</#if>

<#list persistentProps as prop>
	<#if prop.upper == 1 >
	${prop.name}: ${prop.type.name} = <#if prop.type.name == 'number'>-1<#elseif prop.type.name=='string'>''<#elseif prop.type.name == boolean>false<#else>new Date()</#if>;
	<#else>
	${prop.name}: Array<${prop.type.name}> = [];
	</#if>
</#list>
<#list linkedProps as prop>
	<#if prop.upper == 1 >
	${prop.name}: ${prop.type.name} = new ${prop.type.name}();
	<#else>
	${prop.name}: Array<${prop.type.name}> = [];
	</#if>
</#list>
}