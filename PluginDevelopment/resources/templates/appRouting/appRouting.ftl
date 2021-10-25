import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
<#list componentNames as component>
<#if components[component].detail>
import { ${components[component].name}DetailComponent } from './components/${component}/${component}-detail/${component}-detail.component';
</#if>
<#if components[component].create||components[component].update>
import { ${components[component].name}FormComponent } from './components/${component}/${component}-form/${component}-form.component';
</#if>
import { ${components[component].name}ListComponent } from './components/${component}-list/${component}-list.component';
</#list>

const routes: Routes = [
<#list componentNames as component>
 {
  path: "${component}",
  children: [
  	<#if components[component].create>
    { path: 'create', component: ${components[component].name}FormComponent },   
    </#if> 
    <#if components[component].detail>
    { path: ':id', component: ${components[component].name}DetailComponent },
    </#if>
    <#if components[component].update>
    { path: ':id/update', component: ${components[component].name}FormComponent },
    </#if>
    { path: '', component: ${components[component].name}ListComponent },
    
  ]
 },
</#list>
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})

export class AppRoutingModule { }
