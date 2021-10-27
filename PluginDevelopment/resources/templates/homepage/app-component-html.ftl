<!--
 [ ${.now?date} ${.now?time} ]
 This file is generated based on ${.current_template_name}
-->
<div *ngIf="!show">
<br>
<h4 style="text-align: center;">Dashboard</h4>
<div class="container mx-auto mt-5" style="width:75%; text-align: center;">
<br>
<#list componentNames?chunk(3) as row>
<div class="row" >
  <#list row as component>
  <#if component??>
  	<div class="card" style="width:20%; height: 140px; margin-bottom: 5%; margin-left: 5%; cursor: pointer;" routerLink="/${component}" (click)="show=true">
            <div class="card-body mt-4" style="font-weight: bold; text-align: center;">
                ${component}
            </div>
        </div>
  </#if>
  </#list>
 </div>
</#list>
</div>
</div>
<div *ngIf="show">
<router-outlet></router-outlet>
</div>