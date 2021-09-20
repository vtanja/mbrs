package com.example.${appName}.model;

import java.util.Set;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.*;

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
	@Column
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
}