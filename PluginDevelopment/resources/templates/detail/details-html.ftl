<!-- [ ${.now?date} ${.now?time} ]
This file is generated based on ${.current_template_name}
-->

<div class="container">
	<div class="justify-content-center">
		<div class="col justify-content-between">
			<h1 class="h1">${entity_name}</h1>
            <#if component.update><a [routerLink]="['/${entity_name?uncap_first}', obj?<#if id == "">id<#else>${id}</#if>, 'update']" class="btn btn-info m-2">Edit</a></#if>
            <#if component.delete><a class="btn btn-danger m-2" (click)="open(mymodal)">Delete</a></#if>
		</div>
		<div class="col">
            <#list baseFields as field>
			<p><strong>${field.label}</strong> {{ obj?.${field.name} }}</p>
            </#list>
            <#list associations as association>
            <p><strong>${association.label}</strong>:</p>
            <#if association.upper == 1>
             <a [routerLink]="['/${association.fmType.name?uncap_first}', {{ 'obj?.' + ${association.name?uncap_first} + '?.${assId[association.fmType.name]}' }}]">
                    ${ association.label + ' ({{ ${association.name?uncap_first}.${assId[association.fmType.name]} }})' }</a></p>
            <#else>
            <ul>
                <li *ngFor="let item of obj?.${association.name}">
                    <a [routerLink]="['/${association.fmType.name?uncap_first}', item.${assId[association.fmType.name]}]">${ association.label + ' ({{ item.${assId[association.fmType.name]} }})' }</a>
                </li>
            </ul>
            </#if>
            </#list>
		</div>
    </div>
</div>

 <#if component.delete>
<ng-template #mymodal let-modal>
  <div class="modal-header">
    <h4 class="modal-title" id="modal-basic-title">Delete</h4>
    <button type="button" class="close" aria-label="Close" (click)="modal.dismiss('Cross click')">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
  <div class="modal-body">
    <h5 class="text-danger">Are you sure that you want to delete ${entity_name}?</h5>
  </div>
  <div class="modal-footer">
    <button type="button" class="btn btn-danger" (click)="delete();modal.dismiss('Cross click')">Delete</button>
    <button type="button" class="btn btn-secondary" (click)="modal.dismiss('Cross click')">Cancel</button>
  </div>
</ng-template>
</#if>