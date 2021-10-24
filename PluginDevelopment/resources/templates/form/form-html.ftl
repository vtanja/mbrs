<!-- [ ${.now?date} ${.now?time} ]
This file is generated based on ${.current_template_name}
-->

<div class="container">
	<div class="justify-content-center">
		<div class="col justify-content-between">
		
			<h1 class="h1">${entity_name}</h1>
			
			<form [formGroup]="form">
				<#list baseFields as field>
				<label <#if !field.visible>[hidden]=true</#if>>${field.label}</label>
				<input <#if !field.visible>[hidden]=true</#if> class="form-control" type="${field.type}" formControlName=${field.name} <#if !field.editable>[disabled]=true</#if>>
            	</#list>
            	
            	<#list associations as field>
				<label <#if !field.visible>[hidden]=true</#if>>${field.label}</label>
				<#if field.upper == 1>
				<select <#if !field.visible>[hidden]=true</#if> class="form-control" formControlName=${field.name} <#if !field.editable>[disabled]=true</#if>>
			        <option [ngValue]="null">
			            --
			        </option>
			        <option *ngFor="let obj of selectLists.${field.label?uncap_first}List" [ngValue]="obj">
			            ${field.fmType.name}({{obj.id}})
			        </option>
			    </select>
			    <#else>
			    <select <#if !field.visible>[hidden]=true</#if> multiple class="form-control" formControlName=${field.name} <#if !field.editable>[disabled]=true</#if>>
			        <option *ngFor="let obj of selectLists.${field.label?uncap_first}List" [ngValue]="obj">
			            ${field.fmType.name}({{obj.id}})
			        </option>
			    </select>
				</#if> 
				</#list>
				<br>
				<input class="btn btn-primary" type="submit" [disabled]="form.invalid" (click)="submit()"/>&nbsp;&nbsp;&nbsp;
				<button class="btn btn-primary" (click)="cancel()">Cancel</button>
			</form>
			<br/>
		</div>
    </div>
</div>
