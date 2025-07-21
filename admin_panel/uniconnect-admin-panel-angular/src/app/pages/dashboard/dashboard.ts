import { Component } from '@angular/core';
import { MatCardModule } from '@angular/material/card';

@Component({
  selector: 'dashboard-page',
  standalone: true,
  imports: [MatCardModule],
  template: `
    <h1>Dashboard</h1>

    <div class="card-grid">
      <mat-card class="dashboard-card">
        <mat-card-title>Total Users</mat-card-title>
        <mat-card-content>123</mat-card-content>
      </mat-card>

      <mat-card class="dashboard-card">
        <mat-card-title>Total Events</mat-card-title>
        <mat-card-content>45</mat-card-content>
      </mat-card>

      <mat-card class="dashboard-card">
        <mat-card-title>Active Sessions</mat-card-title>
        <mat-card-content>7</mat-card-content>
      </mat-card>
      <mat-card class="dashboard-card">
        <mat-card-title>Pending Approvals</mat-card-title>
        <mat-card-content>3</mat-card-content>
      </mat-card>

      <mat-card class="dashboard-card">
        <mat-card-title>Upcoming Events</mat-card-title>
        <mat-card-content>7</mat-card-content>
      </mat-card>
      <mat-card class="dashboard-card">
        <mat-card-title>System Health</mat-card-title>
        <mat-card-content>Good</mat-card-content>
      </mat-card>

      <mat-card class="dashboard-card">
        <mat-card-title>Universities</mat-card-title>
        <mat-card-content>10</mat-card-content>
      </mat-card>
    </div>
  `,
  styles: [`
    h1 {
      margin-bottom: 32px;
      font-size: 2.2rem;
      font-weight: 700;
      color:rgb(0, 0, 0);
      letter-spacing: 1px;
      text-align: center;
    }
    .card-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
      gap: 32px;
      padding: 24px;
      background: #f5f7fa;
      border-radius: 16px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.04);
    }
    .dashboard-card {
      padding: 16px;
      border-radius: 12px;
      box-shadow: 0 2px 8px rgba(25, 87, 2, 0.08);
      background: #fff;
      transition: box-shadow 0.2s, transform 0.2s;
    }
    .dashboard-card:hover {
      box-shadow: 0 4px 16px rgba(25, 87, 2, 0.18);
      transform: translateY(-4px) scale(1.03);
    }
    mat-card-title {
      font-size: 1.1rem;
      font-weight: 600;
      color: #195902;
      margin-bottom: 8px;
    }
    mat-card-content {
      margin: 8px;
      font-size: 3rem;
      font-weight: 200;
      color: #333;
    }
  `]
})
export class Dashboard { }