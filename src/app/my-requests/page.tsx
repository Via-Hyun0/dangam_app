"use client";

import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription, CardFooter } from "@/components/ui/Card";
import Button from "@/components/ui/Button";
import { Badge } from "@/components/ui/Badge";
import StatCard from "@/components/ui/StatCard";
import { Users, Check, Clock, Edit } from 'lucide-react';

const sampleRequests = [
    { id: 1, title: "Rice Harvesting", status: "recruiting", applicants: 5, views: 47, workDate: "2025-09-06", price: "180,000", priceType: "per day" },
    { id: 2, title: "Strawberry Farm Maintenance", status: "in-progress", applicants: 8, views: 62, workDate: "2025-09-05", price: "15,000", priceType: "per hour" },
    { id: 3, title: "Barn Cleaning & Feeding", status: "completed", applicants: 3, views: 28, workDate: "2025-08-30", price: "120,000", priceType: "per day" },
];

const statusConfig = {
    recruiting: { color: "bg-blue-100 text-blue-800", label: "Recruiting" },
    'in-progress': { color: "bg-yellow-100 text-yellow-800", label: "In Progress" },
    completed: { color: "bg-green-100 text-green-800", label: "Completed" },
};

const RequestCard = ({ request }: { request: typeof sampleRequests[0] }) => {
    const status = statusConfig[request.status as keyof typeof statusConfig];
    return (
        <Card>
            <CardHeader>
                <div className="flex justify-between items-start">
                    <CardTitle>{request.title}</CardTitle>
                    <Badge className={status.color}>{status.label}</Badge>
                </div>
                <CardDescription>Work Date: {request.workDate}</CardDescription>
            </CardHeader>
            <CardContent>
                <div className="flex justify-between items-center text-sm text-gray-500">
                    <span>{request.applicants} Applicants</span>
                    <span>{request.views} Views</span>
                </div>
            </CardContent>
            <CardFooter className="bg-gray-50 px-6 py-4 flex justify-between items-center">
                 <p className="font-semibold text-primary">{`₩${request.price}/${request.priceType}`}</p>
                 <div>
                    <Button variant="outline" size="sm" className="mr-2">Manage Applicants</Button>
                    <Button size="sm">Edit</Button>
                 </div>
            </CardFooter>
        </Card>
    );
};


export default function MyRequestsPage() {
    return (
        <div className="bg-gray-100 min-h-screen">
            <div className="container mx-auto p-4 sm:p-6 lg:p-8">
                <Card className="mb-6">
                    <CardHeader>
                        <CardTitle>Manage My Job Requests</CardTitle>
                        <CardDescription>Oversee your posted jobs and manage applicants.</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
                            <StatCard title="Recruiting" value="5" icon={<Users className="h-4 w-4 text-gray-500"/>} />
                            <StatCard title="Total Applicants" value="23" icon={<Users className="h-4 w-4 text-gray-500"/>} />
                            <StatCard title="Completed Jobs" value="12" icon={<Check className="h-4 w-4 text-gray-500"/>} />
                            <StatCard title="Expired Jobs" value="3" icon={<Clock className="h-4 w-4 text-gray-500"/>} />
                        </div>
                    </CardContent>
                </Card>

                <div className="space-y-4">
                    {sampleRequests.map(req => (
                        <RequestCard key={req.id} request={req} />
                    ))}
                </div>
            </div>
        </div>
    );
}
