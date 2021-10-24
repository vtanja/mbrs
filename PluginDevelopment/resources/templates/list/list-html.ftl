<div *ngIf = "!isLoading">
  <br>
  <div class="row">
      <div class="col">
          <h4 style="text-align:center;">${entity_name}</h4>
      </div>
      <div class="col"  style="text-align:center;">
          <button type="button" class="btn btn-success">Add new ${entity_name?uncap_first}</button>
      </div>
  </div>
  <br>