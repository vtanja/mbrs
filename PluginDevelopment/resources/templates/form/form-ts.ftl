/// [ ${.now?date} ${.now?time} ]
/// This file is generated based on ${.current_template_name}

import { Component } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import { ${entity_name}Service } from 'src/app/shared/services/${component_name}.service';
import { ${entity_name} } from 'src/app/shared/model/${component_name}.model';
<#list associations as field>
import { ${field.fmType.name} } from 'src/app/shared/model/${paths[field.fmType.name]}.model';
</#list>

<#if associations?has_content> 
interface ISelectLists {
<#list associations as field>
	${field.name?uncap_first}List: ${field.fmType.name}[],
</#list>
}
</#if>

@Component({
	selector: 'app-${component_name}-form',
	templateUrl: './${component_name}-form.component.html',
})

export class ${entity_name}FormComponent {
	update: boolean = false;
	id: number = 0;
	entity: ${entity_name};
	
	form: FormGroup = new FormGroup({});

	<#if associations?has_content> 
	selectLists: ISelectLists = {
	<#list associations as field>
	${field.name?uncap_first}List: [],
	</#list>
	}
	</#if> 

    constructor(private service: ${entity_name}Service, 
				private router: Router, 
				private activatedRoute: ActivatedRoute, 
				private fb: FormBuilder)
	{
		this.entity = new ${entity_name}();
		this.form = this.fb.group({
			<#list baseFields as field>
			'${field.name?uncap_first}': new FormControl('', <#if field.editable>Validators.required</#if>),
			</#list>
			<#list associations as field>
			'${field.name?uncap_first}': new FormControl(),
			</#list>
        });

		<#if associations?has_content> 
		this.service.getLists().subscribe(
			(res: any) => {
			    this.selectLists = res;
				console.log(res);
				this.loadData();
			},
			(err: any) => {
				if (err.status == 403)
					alert("Forbidden");
				else 
					alert(err.error);
			}
	  	);
	  	<#else>
	  	this.loadData();
		</#if>
	}

	loadData(){
		if(this.router.url.includes('update')){
			this.update = true;
			this.id = Number(this.activatedRoute.snapshot.paramMap.get('id'));
		
			this.service.get${entity_name}(this.id).subscribe(
				(res: any) => {
					this.entity = res;
					
					<#list associations as field>
					<#if field.upper == 1> 
					let ${field.name?uncap_first}Val = null
					if(this.entity?.${field.name} != null){
						${field.name?uncap_first}Val = this.selectLists.${field.name?uncap_first}List.find(el => el.${assId[field.fmType.name]} == this.entity?.${field.name}?.${assId[field.fmType.name]})
					}
					<#else>
					let ${field.name?uncap_first}Val: (${field.fmType.name} | undefined)[] = []
					this.entity?.${field.name}.forEach(element => {
						let el = this.selectLists.${field.name?uncap_first}List.find(e => e.${assId[field.fmType.name]} == element.${assId[field.fmType.name]})
						${field.name?uncap_first}Val.push(el)
					});
					</#if>
					</#list>
					
					<#list baseFields as field>
					<#if field.fmType.name == 'date'>
					var ${field.name} = new Date(this.entity.${field.name}.toString());
					</#if>
					</#list>
					
					this.form.setValue({
						<#list baseFields as field>
						<#if field.fmType.name == 'date'>
						${field.name?uncap_first}: ${field.name}.toISOString().split('T')[0],
						<#else>
						${field.name?uncap_first}: this.entity?.${field.name},
						</#if>
						</#list>
						<#list associations as field>
						${field.name?uncap_first}: ${field.name?uncap_first}Val,
						</#list>
					})
				},
				(err: any) => {
					if (err.status == 403)
						alert("Forbidden");
					else 
						alert(err.error);
				}
			);
		}
		else {
			this.id = 0;
			this.update = false;
		}
	}

	submit() {
		<#list baseFields as field>
		let ${field.name?uncap_first}Value = this.form.get('${field.name?uncap_first}')?.value;
		</#list>
		<#list associations as field>
		let ${field.name?uncap_first}Value = this.form.get('${field.name?uncap_first}')?.value;
		</#list>

		let dto : ${entity_name} = new ${entity_name}();
		<#list baseFields as field>
		dto.${field.name} = ${field.name?uncap_first}Value;
		</#list>
		<#list associations as field>
		dto.${field.name} = ${field.name?uncap_first}Value;
		</#list>
			
		console.log(dto)
		
		if(this.update) {
			this.service.update${entity_name}(this.id, dto).subscribe(
			(res: any) => {
				this.entity = res;
				this.router.navigateByUrl('/${component_name}');
			},
			(err: any) => {
				console.log(err);
			});
		}
		else {
			this.service.addNew${entity_name}(dto).subscribe(
			(res: any) => {
				this.form.reset();
				this.router.navigateByUrl('/${component_name}');
			},
			(err: any) => {
				console.log(err);
			});
		}
	}
}
