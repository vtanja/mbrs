import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgxPaginationModule } from 'ngx-pagination';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomepageComponent } from './homepage/homepage.component';

<#list componentNames as component>
<#if components[component].detail>
import { ${components[component].name}DetailComponent } from './components/${component}/${component}-detail/${component}-detail.component';
</#if>
<#if components[component].create||components[component].update>
import { ${components[component].name}FormComponent } from './components/${component}/${component}-form/${component}-form.component';
</#if>
import { ${components[component].name}ListComponent } from './components/${component}/${component}-list/${component}-list.component';
</#list>

@NgModule({
  declarations: [
    AppComponent,
    <#list componentNames as component>
	<#if components[component].detail>
	${components[component].name}DetailComponent,
	</#if>
	<#if components[component].create||components[component].update>
	${components[component].name}FormComponent,
	</#if>
	${components[component].name}ListComponent,
	</#list>
	HomepageComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
    NgxPaginationModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }