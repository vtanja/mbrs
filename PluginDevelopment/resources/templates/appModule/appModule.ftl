import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';


import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

<#list components as component>
<#if component.detail>
import { ${component.name}DetailComponent } from './components/${component.name?lower_case}/${component.name?lower_case}-detail/${component.name?lower_case}-detail.component';
</#if>
<#if component.create||component.update>
import { ${component.name}FormComponent } from './components/${component.name?lower_case}/${component.name?lower_case}-form/${component.name?lower_case}-form.component';
</#if>
import { ${component.name}ListComponent } from './components/${component.name?lower_case}-list/${component.name?lower_case}-list.component';
</#list>

@NgModule({
  declarations: [
    AppComponent,
    <#list components as component>
	<#if component.detail>
	${component.name}DetailComponent,
	</#if>
	<#if component.create||component.update>
	${component.name}FormComponent,
	</#if>
	${component.name}ListComponent,
	</#list>
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
