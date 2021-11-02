<div *ngIf = "!isLoading">
  <br>
  <div class="row">
      <div class="col">
          <h4 style="text-align:center;">${entity_name}</h4>
      </div>
      <div class="col"  style="text-align:center;">
          <button type="button" class="btn btn-success" [routerLink]="['/${entity_name?uncap_first}/create']">Add new ${entity_name}</button>
      </div>
  </div>
  <br>
   <table class="table" style="width:90%; margin:auto" *ngIf="${entity_name?uncap_first}_list.length != 0">
      <tr>
          <#list persistentProps as prop>
          <#if prop??>
          <th scope="col"> ${prop.name?cap_first} </th>
          </#if>
          </#list>
          <th>&nbsp;</th>
          <th>&nbsp;</th>
      </tr>
      <tr *ngFor="let ${entity_name?uncap_first} of ${entity_name?uncap_first}_list | paginate: { itemsPerPage: elementsPerPage, currentPage: page, totalItems: totalLength }; let i = index" [routerLink]="!isDisabled ? ['/${entity_name?uncap_first}', ${entity_name?uncap_first}.id] : []">
          <#list persistentProps as prop>
            <td scope="row"> {{${entity_name?uncap_first}.${prop.name?uncap_first}}} </td>
          </#list>
          <td style="width: 20%;">
              <button type="button" class="btn btn-warning" (click)="isDisabled=true;" [routerLink]="['/${entity_name?uncap_first}', ${entity_name?uncap_first}.id, 'update']">Edit</button>
          </td>
          <td style="width: 20%;">
              <button type="button" class="btn btn-danger" (click)="isDisabled=true;idToDelete=${entity_name?uncap_first}.id;open(mymodal)">Delete</button>
          </td>
      </tr> 
   </table>
   
   <div class="container" *ngIf="${entity_name?uncap_first}_list.length != 0">
    <br>
    <div class="row justify-content-md-center">
      <div class="col col-lg-2">
          Elements per page:
      </div>
      <div class="col col-md-1">
          <select class="custom-select" [(ngModel)]="elementsPerPage" (ngModelChange)="onChange($event)" name="sel2">
              <option [value]="i" *ngFor="let i of options">{{i}}</option>
          </select>
      </div>
      <div class="col-md-auto">
        <pagination-controls (pageChange)="page = $event; changePage(page)"></pagination-controls>
      </div>
    </div>
  </div>
  <div *ngIf="${entity_name?uncap_first}_list.length == 0" class="alert alert-warning" role="alert" style="text-align:center;">
    There are no ${entity_name} added!
  </div>
</div>
</div>

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
    <button type="button" class="btn btn-danger" (click)="delete${entity_name}(idToDelete);modal.dismiss('Cross click')">Delete</button>
    <button type="button" class="btn btn-secondary" (click)="modal.dismiss('Cross click')">Cancel</button>
  </div>
</ng-template>	