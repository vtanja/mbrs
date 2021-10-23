import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
<#list components as component>
<#if component.detail>
import { ${component.name}DetailComponent } from './components/${component.name?lower_case}/${component.name?lower_case}-detail/${component.name?lower_case}-detail.component';
</#if>
<#if component.create||component.update>
import { ${component.name}FormComponent } from './components/${component.name?lower_case}/${component.name?lower_case}-form/${component.name?lower_case}-form.component';
</#if>
import { ${component.name}ListComponent } from './components/${component.name?lower_case}-list/${component.name?lower_case}-list.component';
</#list>

const routes: Routes = [
<#list components as component>
 {
  path: "${component.name?lower_case}",
  children: [
  	<#if component.create>
    { path: 'create', component: ${component.name}FormComponent },   
    </#if> 
    <#if component.detail>
    { path: ':id', component: ${component.name}DetailComponent },
    </#if>
    <#if component.update>
    { path: ':id/update', component: ${component.name}FormComponent },
    </#if>
    { path: '', component: ${component.name}ListComponent },
    
  ]
 },
</#list>
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})

export class AppRoutingModule { }
