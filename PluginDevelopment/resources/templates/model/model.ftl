package com.example.demo.model;

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
@Entity
public class ${name}{
<#if identityProp??>
	<#if identityProp.strategy == "identity" >
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	 ${identityProp.visibility} ${identityProp.type.name} ${identityProp.name};
	<#elseif identityProp.strategy == "table" >
	 @Id
	 @GeneratedValue(strategy = GenerationType.TABLE)
	 ${identityProp.visibility} ${identityProp.type.name} ${identityProp.name};
	<#elseif identityProp.strategy == "auto" >
	 @Id
     @GeneratedValue
     ${identityProp.visibility} ${identityProp.type.name} ${identityProp.name};
    <#else>
     @Id
	 @GeneratedValue(generator = "sequence-generator")
	 @GenericGenerator(
			name = "sequence-generator",
			strategy = "org.hibernate.id.enhanced.SequenceStyleGenerator"
	 )
     ${identityProp.visibility} ${identityProp.type.name} ${identityProp.name};	 
	</#if>
</#if>
<#list persistentProps as prop>
	<#if prop.upper == 1 >
	@Column
	${prop.visibility} ${prop.type.name} ${prop.name};
	<#else>
	${prop.visibility} Set<${prop.type.name}> ${prop.name};
	</#if>
</#list>
<#list linkedProps as prop>
	<#if prop.upper == 1 >
	${prop.visibility} ${prop.type.name} ${prop.name};
	<#else>
	${prop.visibility} Set<${prop.type.name}> ${prop.name};
	</#if>
</#list>
}