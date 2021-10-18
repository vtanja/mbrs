/// [ ${.now?date} ${.now?time} ]
/// This file is generated based on ${.current_template_name}

import { Component } from '@angular/core';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import { ${entity_name}Service } from '../${entity_name?uncap_first}.service';
import { I${entity_name} } from 'src/app/shared/model/${entity_name?uncap_first}.model';
<#list associations as field>
import { I${field.fmType.name} } from 'src/app/shared/model/${field.fmType.name?uncap_first}.model';
</#list>

<#if associations?has_content> 
interface ISelectLists {
<#list associations as field>
	${field.label?uncap_first}List: I${field.fmType.name}[],
</#list>
}
</#if>

@Component({
	selector: 'app-${entity_name?uncap_first}-form',
	templateUrl: './${entity_name?uncap_first}-form.component.html',
})

export class ${entity_name}FormComponent {
	update: boolean = false;
	id: number = 0;
	entity: I${entity_name} | undefined;
	
	form: FormGroup = new FormGroup({});

	<#if associations?has_content> 
	selectLists: ISelectLists = {
	<#list associations as field>
	${field.label?uncap_first}List: [],
	</#list>
	}
	</#if> 

    constructor(private service: ${entity_name}Service, 
				private router: Router, 
				private activatedRoute: ActivatedRoute, 
				private fb: FormBuilder)
	{
		this.form = this.fb.group({
			<#list baseFields as field>
			'${field.name?uncap_first}': new FormControl(),
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
						${field.name?uncap_first}Val = this.selectLists.${field.label?uncap_first}List.find(el => el.${assId[field.fmType.name]} == this.entity?.${field.name}.${assId[field.fmType.name]})
					}
					<#else>
					let ${field.name?uncap_first}Val: (I${field.fmType.name} | undefined)[] = []
					this.entity?.${field.name}.forEach(element => {
						let el = this.selectLists.${field.label?uncap_first}List.find(e => e.${assId[field.fmType.name]} == element.${assId[field.fmType.name]})
						${field.name?uncap_first}Val.push(el)
					});
					</#if>
					</#list>
					
					this.form.setValue({
						<#list baseFields as field>
						${field.name?uncap_first}: this.entity?.${field.name},
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

		let dto = {
			<#list baseFields as field>
			${field.name}: ${field.name?uncap_first}Value,
			</#list>
			<#list associations as field>
			${field.name}: ${field.name?uncap_first}Value,
			</#list>
		}
		console.log(dto)
		
		if(this.update) {
			this.service.update${entity_name}(this.id, dto).subscribe(
			(res: any) => {
				this.entity = res;
			},
			(err: any) => {
				console.log(err);
			});
		}
		else {
			this.service.create${entity_name}(dto).subscribe(
			(res: any) => {
				this.form.reset();
			},
			(err: any) => {
				console.log(err);
			});
		}
	}
	
	cancel(){
	
	}
}