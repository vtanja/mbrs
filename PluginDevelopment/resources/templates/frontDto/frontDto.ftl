// [ ${.now?date} ${.now?time} ]
// This file is generated based on ${.current_template_name}

<#list linkedProps as import>
import { ${import.type.name} } from './${imports[import.type.name]}.model';
</#list>

export class ${name}{
<#if identityProp??>
	${identityProp.name}: ${identityProp.type.name} = -1;
<#else>
	id: number = -1;
</#if>
<#list persistentProps as prop>
	<#if prop.upper == 1 >
	${prop.name}: <#if prop.type.name=='number' || prop.type.name=='string' || prop.type.name=='boolean' || prop.type.name=='date' || prop.type.name=='Date'>${prop.type.name}<#else>string</#if> = <#if prop.type.name == 'number'>-1<#elseif prop.type.name=='string'>''<#elseif prop.type.name == 'boolean'>false<#elseif prop.type.name == 'Date'>new Date()<#else>''</#if>;
	<#else>
	${prop.name}: Array<${prop.type.name}> = [];
	</#if>
</#list>
<#list linkedProps as prop>
	<#if prop.upper == 1 >
	${prop.name}: ${prop.type.name} | null = null;
	<#else>
	${prop.name}: Array<${prop.type.name}> = [];
	</#if>
</#list>
}