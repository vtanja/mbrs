// [ ${.now?date} ${.now?time} ]
// This file is generated based on ${.current_template_name}

package com.example.${appName}.service;

import org.modelmapper.ModelMapper;
import com.google.gson.Gson;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import javassist.NotFoundException;
import java.util.*;

import com.example.${appName}.enums.*;
import com.example.${appName}.dtoImpl.${name}DetailDTOImpl;
import com.example.${appName}.dtoImpl.${name}DTOImpl;
import com.example.${appName}.model.${name};
import com.example.${appName}.repository.${name}RepositoryImpl;

<#list imports as import>
import com.example.${appName}.model.${import};
import com.example.${appName}.dtoImpl.${import}DTOImpl;
import com.example.${appName}.dtoImpl.${import}DetailDTOImpl;
import com.example.${appName}.service.${import}ServiceImpl;
</#list>

@Service
public class ${name}Service {
    @Autowired
    private  ${name}RepositoryImpl  ${repository};
    
    <#list imports as import>
	@Autowired
    private ${import}ServiceImpl ${import?uncap_first}Service;
	</#list>

    public ResponseEntity<List<${name}DTOImpl>> getAll${name}(){
    	ModelMapper modelMapper = new ModelMapper();
        List<${name}> list = ${repository}.findAll();
        List<${name}DTOImpl> dtoList = new LinkedList<>();
        for(${name} ${name?uncap_first}: list) {
            ${name}DTOImpl ${name?uncap_first}Dto = modelMapper.map(${name?uncap_first}, ${name}DTOImpl.class);
            dtoList.add(${name?uncap_first}Dto);
        }
        
        return new ResponseEntity<>(dtoList, HttpStatus.OK);
    }
    
    public ${name} getById(Long id){
        if (${repository}.findById(id).isPresent())
            return ${repository}.findById(id).get();
        else
            return null;
    }

    public ResponseEntity<${name}DetailDTOImpl> get${name}(Long id){
    	ModelMapper modelMapper = new ModelMapper();
    	if(${repository}.findById(id).isPresent()){
    		${name} ${name?uncap_first} = ${repository}.findById(id).get();
    		${name}DetailDTOImpl dto = modelMapper.map(${name?uncap_first}, ${name}DetailDTOImpl.class);
        	return new ResponseEntity<>(dto, HttpStatus.OK);
    	}
    	else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    public List<${name}DTOImpl>getAll(){
    	ModelMapper modelMapper = new ModelMapper();
        List<${name}> list = ${repository}.findAll();
        List<${name}DTOImpl> dtoList = new LinkedList<>();
        for(${name} ${name?uncap_first}: list) {
            ${name}DTOImpl ${name?uncap_first}Dto = modelMapper.map(${name?uncap_first}, ${name}DTOImpl.class);
            dtoList.add(${name?uncap_first}Dto);
        }
        return dtoList;
    }

    public ResponseEntity<${name}DetailDTOImpl> update${name}(Long id, ${name}DetailDTOImpl ${name?uncap_first}Dto){
        ModelMapper modelMapper = new ModelMapper();
        
        ${name} ${name?uncap_first} = ${repository}.find${name}By${id}(id);
        if(${name?uncap_first} == null) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST); 
        }
        else {
    		<#list persistentProps as prop>
    		<#if prop.type.name=='String' || prop.type.name=='Int' || prop.type.name=='Integer' || prop.type.name=='long' || prop.type.name=='float' || prop.type.name=='double' || prop.type.name=='boolean' || prop.type.name=='Boolean' || prop.type.name=='Char' || prop.type.name=='Date'>
    		${name?uncap_first}.set${prop.name?cap_first}(${name?uncap_first}Dto.get${prop.name?cap_first}());
    		<#else>${name?uncap_first}.set${prop.name?cap_first}(${prop.type.name}.valueOf(${name?uncap_first}Dto.get${prop.name?cap_first}()));
    		</#if>
			</#list>
			<#list linkedProps as prop>
			<#if prop.upper == 1 >
			if(${name?uncap_first}Dto.get${prop.name?cap_first}() != null) {
				${name?uncap_first}.set${prop.name?cap_first}(${prop.type.name?uncap_first}Service.getById(${name?uncap_first}Dto.get${prop.name?cap_first}().getId()));
			}
			<#else>
			if(${name?uncap_first}Dto.get${prop.name?cap_first}() != null) {
				Set<${prop.type.name}> ${prop.name}Set = new HashSet<>();
				for(${prop.type.name}DTOImpl item : ${name?uncap_first}Dto.get${prop.name?cap_first}()){
					${prop.type.name} ${prop.type.name?uncap_first} = ${prop.type.name?uncap_first}Service.getById(item.getId());
					${prop.name}Set.add(${prop.type.name?uncap_first});
				}
				${name?uncap_first}.set${prop.name?cap_first}(${prop.name}Set);
			}
			</#if>
			</#list>
			${repository}.save(${name?uncap_first});
            return new ResponseEntity<>(modelMapper.map(${name?uncap_first}, ${name}DetailDTOImpl.class), HttpStatus.OK); 
        }
    }

    public ResponseEntity<${name}DetailDTOImpl> create(${name}DetailDTOImpl ${name?uncap_first}Dto){
    	ModelMapper modelMapper = new ModelMapper();
        ${name} ${name?uncap_first} = new ${name}();
        
        <#list persistentProps as prop>
        <#if prop.type.name=='String' || prop.type.name=='Int' || prop.type.name=='Integer' || prop.type.name=='long' || prop.type.name=='float' || prop.type.name=='double' || prop.type.name=='boolean' || prop.type.name=='Boolean' || prop.type.name=='Char' || prop.type.name=='Date'>
    	${name?uncap_first}.set${prop.name?cap_first}(${name?uncap_first}Dto.get${prop.name?cap_first}());
    	<#else>${name?uncap_first}.set${prop.name?cap_first}(${prop.type.name}.valueOf(${name?uncap_first}Dto.get${prop.name?cap_first}()));
    	</#if>
		</#list>
		<#list linkedProps as prop>
		<#if prop.upper == 1 >
		if(${name?uncap_first}Dto.get${prop.name?cap_first}() != null) {
			${name?uncap_first}.set${prop.name?cap_first}(${prop.type.name?uncap_first}Service.getById(${name?uncap_first}Dto.get${prop.name?cap_first}().getId()));
		}
		<#else>
		if(${name?uncap_first}Dto.get${prop.name?cap_first}() != null) {
			Set<${prop.type.name}> ${prop.name}Set = new HashSet<>();
			for(${prop.type.name}DTOImpl item : ${name?uncap_first}Dto.get${prop.name?cap_first}()){
				${prop.type.name} ${prop.type.name?uncap_first} = ${prop.type.name?uncap_first}Service.getById(item.getId());
				${prop.name}Set.add(${prop.type.name?uncap_first});
			}
			${name?uncap_first}.set${prop.name?cap_first}(${prop.name}Set);
		}
		</#if>
		</#list>
		
		${repository}.save(${name?uncap_first});
    
        return new ResponseEntity<>(modelMapper.map(${name?uncap_first}, ${name}DetailDTOImpl.class), HttpStatus.OK); 
    }

    public ResponseEntity<Void> delete${name}(Long id){
        try{
            ${repository}.deleteById(id);
            return new ResponseEntity<>(HttpStatus.OK);
        }
        catch(Exception e){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
    
    public ResponseEntity<String> getLists(){
        HashMap<String,Object> map = new HashMap<>();
        Gson gson = new Gson();
        
        <#list linkedProps as prop>
        List<${prop.type.name}DTOImpl> ${prop.name?uncap_first}List = ${prop.type.name?uncap_first}Service.getAll();
        map.put("${prop.name}List", ${prop.name?uncap_first}List);
		</#list>
		String json = gson.toJson(map);
        return new ResponseEntity<>(json, HttpStatus.OK);
    }

    public final void Save(${name} ${name?uncap_first}){
        ${repository}.save(${name?uncap_first});
    }
}
