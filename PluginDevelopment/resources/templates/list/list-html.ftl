<div *ngIf = "!isLoading">
  <br>
  <div class="row">
      <div class="col">
          <h4 style="text-align:center;">${entity_name}</h4>
      </div>
      <div class="col"  style="text-align:center;">
          <button type="button" class="btn btn-success">Add new ${entity_name}</button>
      </div>
  </div>
  <br>
   <table class="table" style="width:90%; margin:auto">
         <tr>
          <#list persistentProps as prop>
              <#if prop??>
              <th scope="col"> ${prop.name?cap_first} </th>
              </#if>
          </#list>
          <th>&nbsp;</th>
          <th>&nbsp;</th>
      </tr>
   </table>
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
    <button type="button" class="btn btn-danger">Delete</button>
    <button type="button" class="btn btn-secondary" (click)="modal.dismiss('Cross click')">Cancel</button>
  </div>
</ng-template>	