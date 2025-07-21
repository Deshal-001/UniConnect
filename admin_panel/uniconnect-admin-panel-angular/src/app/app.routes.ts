import { Routes } from '@angular/router';
import { Dashboard } from './pages/dashboard/dashboard';
import { Events } from './pages/events/events';
import { Users } from './pages/users/users';
import { Login } from './pages/login/login';

export const routes: Routes = [
  { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
  { path: 'dashboard', component: Dashboard },
  { path: 'events', component: Events },
  { path: 'users', component: Users },
  { path: 'login', component: Login },
  { path: '**', redirectTo: 'dashboard' }
];