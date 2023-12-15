import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { AboutComponent } from './about/about.component';
import { Content1Component } from './content1/content1.component';
import { Content2Component } from './content2/content2.component';
import { ContactComponent } from './contact/contact.component';

const routes: Routes = [
    {path: '', component: HomeComponent},
    {path: 'index', component: HomeComponent},
    {path: 'about', component: AboutComponent},
    {path: 'content1', component: Content1Component},
    {path: 'content2', component: Content2Component},
    {path: 'contact', component: ContactComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
