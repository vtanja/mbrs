// [ ${.now?date} ${.now?time} ]
// This file is generated based on ${.current_template_name}

package com.example.${appName}.model;

import java.util.*;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.*;

import com.example.${appName}.enums.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity<#if tableName != "">(name="${tableName}")</#if>
public class ${name}{
<#if identityProp??>
	@Id
 	<#if identityProp.strategy == "identity" >
	@GeneratedValue(strategy = GenerationType.IDENTITY)
  	<#elseif identityProp.strategy == "table" >
	@GeneratedValue(strategy = GenerationType.TABLE)
  	<#elseif identityProp.strategy == "auto" >
    @GeneratedValue
   	<#else>
	@SequenceGenerator(
		name = "sequence-generator",
		sequenceName = "sequence-generator",
		allocationSize = 1
	)
	@GeneratedValue(
		generator = "sequence-generator",
		strategy = GenerationType.SEQUENCE
	)	 
  	</#if>
    ${identityProp.visibility} ${identityProp.type.name} ${identityProp.name};
<#else>
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
</#if>
<#list persistentProps as prop>
	<#if prop.upper == 1 >
	@Column<#if prop.type.name == 'String'><#if prop.length??>(length = ${prop.length})</#if><#elseif prop.type.name == 'double' || prop.type.name == 'float'><#if prop.precision??>(precision = ${prop.precision})</#if></#if>
	${prop.visibility} ${prop.type.name} ${prop.name};
	
	<#else>
	${prop.visibility} Set<${prop.type.name}> ${prop.name};
	
	</#if>
</#list>
<#list oneToManyProps as prop>
   	@OneToMany(mappedBy = "${prop.mappedBy}" <#if prop.cascade??>, cascade = CascadeType.${prop.cascade} </#if>)
   	${prop.visibility} Set<${prop.type.name}> ${prop.name};
   	
</#list>
<#list manyToOneProps as prop>
	@ManyToOne
    @JoinColumn(name="${prop.columnName}_id")
    ${prop.visibility} ${prop.type.name} ${prop.name};
    
</#list>
<#list manyToManyProps as prop>
	<#if prop.joinTable?? && !prop.mappedBy??>
	@ManyToMany(fetch = FetchType.${prop.fetchType?upper_case})
    @JoinTable(name = "${prop.joinTable}",
            joinColumns = { @JoinColumn(name = "${name?uncap_first}_id") },
            inverseJoinColumns = { @JoinColumn(name = "${prop.type.name?uncap_first}_id") })
	<#else>
	@ManyToMany(fetch = FetchType.${prop.fetchType?upper_case},
            mappedBy = "${prop.mappedBy}")
   	</#if>
   	${prop.visibility} Set<${prop.type.name}> ${prop.name};
   	
</#list>
<#list oneToOneProps as prop>
<#if prop.columnName??>
	@OneToOne
    @JoinColumn(name = "${prop.columnName}_id")
<#else>
	@OneToOne(mappedBy = "${name?uncap_first}")
</#if>
	${prop.visibility} ${prop.type.name} ${prop.name};
</#list>
<#if identityProp??>
	public ${identityProp.type.name} getId(){
		return ${identityProp.name};
	}
</#if>
}