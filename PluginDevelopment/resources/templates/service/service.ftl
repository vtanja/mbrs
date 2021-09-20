package com.example.demo.dto;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import java.util.*;

import com.example.demo.dto.${name}DetailDTO;
import com.example.demo.dto.${name}DTO;
import com.example.demo.model.${name};
import com.example.demo.repository.${name}Repository;
import com.example.demo.exception.NotFoundException;

<#list importedPackages as import>
<#if import.typePackage == "">
import com.example.demo.model.${import.name};
import com.example.demo.dto.${import.name}DTO;
import com.example.demo.dto.${import.name}DetailDTO;
import com.example.demo.service.${import.name}ServiceImpl;
</#if>
</#list>

@Service
public class ${name}Service {
    @Autowired
    private  ${name}Repository  ${repository};
    @Autowired
    private ModelMapper modelMapper;
    
    <#list importedPackages as import>
	<#if import.typePackage == "">
	@Autowired
    private ${import.name}ServiceImpl ${import.name?uncap_first}Service;
	</#if>
	</#list>

    public ResponseEntity<List<${name}DTO>> get${name}Page(int pageNo, int pageSize){
        List<${name}DTO> dtoList = new ArrayList<${name}DTO>();
        Pageable paging = PageRequest.of(pageNo, pageSize);
        Page<${name}> pagedResult = ${repository}.findAll(paging);
         
        if (pagedResult.hasContent()) {
            List<${name}> list = pagedResult.getContent();

            for (${name} ${name?uncap_first} : list)
            {
                ${name}DTO ${name?uncap_first}DTO = modelMapper.map(${name?uncap_first}, ${name}DTO.class);
                dtoList.add(${name?uncap_first}DTO);
            }

        }
        return new ResponseEntity<>(dtoList, HttpStatus.OK);
    }
    
    public ${name} getById(Long id){
        if (${repository}.findById(id).isPresent())
            return ${repository}.findById(id).get();
        else
            return null;
    }

    public ResponseEntity<${name}DetailDTO> get${name}(Long id){
        ${name} ${name?uncap_first} = ${repository}.findById(id).orElseThrow(
            () -> new NotFoundException("${name} with given id was not found."));
        ${name}DetailDTO dto = modelMapper.map(${name?uncap_first}, ${name}DetailDTO.class);
        return new ResponseEntity<>(sto, HttpStatus.OK);
    }

    public List<${name}DTO>getAll(){
        List<${name}> list = ${repository}.findAll();
        List<${name}DTO> dtoList = new LinkedList<>();
        for(${name} ${name?uncap_first}: list) {
            ${name}DTO ${name?uncap_first}Dto = modelMapper.map(${name?uncap_first}, ${name}DTO.class);
            dtoList.add(${name?uncap_first}Dto);
        }
        return dtoList;
    }

    public ResponseEntity<${name}DetailDTO> update${name}(Long id, ${name}DetailDTO ${name?uncap_first}Dto){
        ModelMapper modelMapper = new ModelMapper();
        
        ${name} ${name?uncap_first} = ${repository}.find${name}ById(id);
        if(${name?uncap_first} == null) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST); 
        }
        else {
    		<#list persistentProps as prop>
			${name?uncap_first}.Set${prop.name?cap_first}(${name?uncap_first}Dto.Get${prop.name?cap_first}());
			</#list>
			<#list linkedProps as prop>
			<#if prop.upper == 1 >
			${name?uncap_first}.Set${prop.name?cap_first}(${prop.type.name?uncap_first}Service.GetById(${name?uncap_first}Dto.Get${prop.name?cap_first}().GetId()));
			<#else>
			Set<${prop.type.name}> ${prop.name}Set = new HashSet<>();
			for(${prop.type.name}DTO item : ${name?uncap_first}Dto.Get${prop.name?cap_first}()){
				${prop.type.name} ${prop.type.name?uncap_first} = item.GetId();
				${prop.name}Set.add(${prop.type.name?uncap_first});
			}
			${name?uncap_first}.Set${prop.type.name}(${prop.name}Set);
			</#if>
			</#list>
			${repository}.save(${name?uncap_first});
            return new ResponseEntity<>(retDto, HttpStatus.OK); 
        }
    }

    public ResponseEntity<${name}DetailDTO> create(${name}DetailDTO ${name?uncap_first}Dto){
        ${name} ${name?uncap_first} = new ${name}();
        <#list persistentProps as prop>
		${name?uncap_first}.Set${prop.name?cap_first}(${name?uncap_first}Dto.Get${prop.name?cap_first}());
		</#list>
		<#list linkedProps as prop>
		<#if prop.upper == 1 >
		${name?uncap_first}.Set${prop.name?cap_first}(${prop.type.name?uncap_first}Service.GetById(${name?uncap_first}Dto.Get${prop.name?cap_first}().GetId()));
		<#else>
		Set<${prop.type.name}> ${prop.name}Set = new HashSet<>();
		for(${prop.type.name}DTO item : ${name?uncap_first}Dto.Get${prop.name?cap_first}()){
			${prop.type.name} ${prop.type.name?uncap_first} = item.GetId();
			${prop.name}Set.add(${prop.type.name?uncap_first});
		}
		${name?uncap_first}.Set${prop.type.name}(${prop.name}Set);
		</#if>
		</#list>
		
		${repository}.save(${name?uncap_first});
    
        return new ResponseEntity<>(HttpStatus.OK); 
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

    public final void Save(${name} ${name?uncap_first}){
        ${repository}.save(${name?uncap_first});
    }
}
