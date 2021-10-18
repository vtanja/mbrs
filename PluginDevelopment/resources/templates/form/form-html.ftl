<!-- [ ${.now?date} ${.now?time} ]
This file is generated based on ${.current_template_name}
-->

<div class="container">
	<div class="justify-content-center">
		<div class="col justify-content-between">
		
			<h1 class="h1">${entity_name}</h1>
			
			<form [formGroup]="form">
				<#list baseFields as field>
				<label>${field.label}</label>
				<input class="form-control" type="${field.type}" formControlName=${field.name} <#if !field.editable>disabled</#if>>
            	</#list>
            	
            	<#list associations as field>
				<label>${field.label}</label>
				<#if field.upper == 1>
				<select class="form-control" formControlName=${field.name}>
			        <option [ngValue]="null">
			            --
			        </option>
			        <option *ngFor="let obj of selectLists.${field.fmType.name}List" [ngValue]="obj">
			            ${field.fmType.name}({{obj.id}})
			        </option>
			    </select>
			    <#else>
			    <select multiple class="form-control" formControlName=${field.name}>
			        <option *ngFor="let obj of selectLists.${field.fmType.name}List" [ngValue]="obj">
			            ${field.fmType.name}({{obj.id}})
			        </option>
			    </select>
				</#if> 
				</#list>
				
				<input class="btn btn-primary" type="submit" [disabled]="form.invalid" (click)="submit()"/>
				<input class="btn btn-primary" (click)="cancel()"/>
			</form>
			<br/>
		</div>
    </div>
</div>
