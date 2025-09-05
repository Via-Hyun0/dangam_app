"use client";

import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/Card";
import Button from "@/components/ui/Button";
import { Badge } from "@/components/ui/Badge";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/Table";
import StatCard from "@/components/ui/StatCard";
import { ArrowUp, DollarSign, Star, MessageSquare, PlusCircle, BarChart2 } from 'lucide-react';

// This StatCard is now a bit different as it has a 'change' prop.
// I will create a new, more specific StatCard for this page inside this file.
// This avoids making the shared StatCard too complex.
const DashboardStatCard = ({ title, value, change, icon }: { title: string, value: string, change: string, icon: React.ReactNode }) => (
  <Card>
    <CardHeader className="flex flex-row items-center justify-between pb-2">
      <CardTitle className="text-sm font-medium">{title}</CardTitle>
      {icon}
    </CardHeader>
    <CardContent>
      <div className="text-2xl font-bold">{value}</div>
      <p className="text-xs text-green-600 flex items-center">
        <ArrowUp className="h-4 w-4 mr-1" />
        {change} vs last month
      </p>
    </CardContent>
  </Card>
);

const services = [
    { name: "Professional Rice Harvesting", status: "Active", bookings: 18, revenue: "₩1,540,000", rating: 4.9 },
    { name: "Greenhouse Tomato Management", status: "Active", bookings: 12, revenue: "₩600,000", rating: 4.7 },
    { name: "Apple Picking Assistance", status: "Inactive", bookings: 0, revenue: "₩0", rating: 0 },
];

export default function ServiceManagePage() {
    return (
        <div className="bg-gray-100 min-h-screen">
            <div className="container mx-auto p-4 sm:p-6 lg:p-8">
                <div className="flex justify-between items-center mb-6">
                    <div>
                        <h1 className="text-3xl font-bold">Service Dashboard</h1>
                        <p className="text-gray-500">Manage your business performance efficiently.</p>
                    </div>
                    <Button><PlusCircle className="mr-2 h-4 w-4"/> Add New Service</Button>
                </div>

                <div className="grid gap-6 mb-6 md:grid-cols-2 lg:grid-cols-4">
                    <DashboardStatCard title="Total Revenue" value="₩2,340,000" change="+15%" icon={<DollarSign className="h-5 w-5 text-gray-500"/>} />
                    <DashboardStatCard title="Total Bookings" value="42" change="+8%" icon={<BarChart2 className="h-5 w-5 text-gray-500"/>} />
                    <DashboardStatCard title="Average Rating" value="4.8/5" change="+0.2" icon={<Star className="h-5 w-5 text-gray-500"/>} />
                    <DashboardStatCard title="New Inquiries" value="127" change="-5%" icon={<MessageSquare className="h-5 w-5 text-gray-500"/>} />
                </div>

                <Card>
                    <CardHeader>
                        <CardTitle>Service Performance</CardTitle>
                        <CardDescription>Track the performance of your offered services.</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <Table>
                            <TableHeader>
                                <TableRow>
                                    <TableHead>Service Name</TableHead>
                                    <TableHead>Status</TableHead>
                                    <TableHead>Bookings</TableHead>
                                    <TableHead>Revenue</TableHead>
                                    <TableHead>Rating</TableHead>
                                </TableRow>
                            </TableHeader>
                            <TableBody>
                                {services.map(service => (
                                    <TableRow key={service.name}>
                                        <TableCell className="font-medium">{service.name}</TableCell>
                                        <TableCell><Badge className={service.status === 'Active' ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'}>{service.status}</Badge></TableCell>
                                        <TableCell>{service.bookings}</TableCell>
                                        <TableCell>{service.revenue}</TableCell>
                                        <TableCell>{service.rating > 0 ? `${service.rating} ★` : 'N/A'}</TableCell>
                                    </TableRow>
                                ))}
                            </TableBody>
                        </Table>
                    </CardContent>
                </Card>
            </div>
        </div>
    );
}
