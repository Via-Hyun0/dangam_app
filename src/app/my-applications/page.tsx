"use client";

import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/Card";
import Button from "@/components/ui/Button";
import { Badge } from "@/components/ui/Badge";
import StatCard from "@/components/ui/StatCard";
import { Briefcase, CheckCircle, Clock, XCircle } from 'lucide-react';

const sampleApplications = [
    { id: 1, title: "Rice Harvesting", employer: "Kim Nongbu", status: "approved", appliedAt: "2 days ago", workDate: "2025-09-06", price: "180,000", priceType: "per day" },
    { id: 2, title: "Strawberry Farm Maintenance", employer: "Lee Farms", status: "pending", appliedAt: "1 day ago", workDate: "2025-09-07", price: "15,000", priceType: "per hour" },
    { id: 3, title: "Barn Cleaning & Feeding", employer: "Park Ranch", status: "rejected", appliedAt: "3 days ago", workDate: "2025-09-10", price: "120,000", priceType: "per day" },
    { id: 4, title: "Apple Picking Assistant", employer: "Choi Orchard", status: "completed", appliedAt: "1 week ago", workDate: "2025-08-30", price: "13,000", priceType: "per hour" },
];

const statusConfig = {
    pending: { icon: <Clock className="h-4 w-4" />, color: "bg-yellow-500", label: "Pending" },
    approved: { icon: <CheckCircle className="h-4 w-4" />, color: "bg-green-500", label: "Approved" },
    rejected: { icon: <XCircle className="h-4 w-4" />, color: "bg-red-500", label: "Rejected" },
    completed: { icon: <Briefcase className="h-4 w-4" />, color: "bg-blue-500", label: "Completed" },
};

const ApplicationCard = ({ app }: { app: typeof sampleApplications[0] }) => {
    const status = statusConfig[app.status as keyof typeof statusConfig];
    return (
        <Card>
            <CardHeader>
                <div className="flex justify-between items-start">
                    <div>
                        <CardTitle>{app.title}</CardTitle>
                        <CardDescription>Applied to {app.employer}</CardDescription>
                    </div>
                    <Badge className={`${status.color} text-white`}>{status.label}</Badge>
                </div>
            </CardHeader>
            <CardContent>
                <div className="flex justify-between text-sm">
                    <p className="text-gray-500">Applied: {app.appliedAt}</p>
                    <p className="font-semibold text-primary">{`₩${app.price}/${app.priceType}`}</p>
                </div>
            </CardContent>
        </Card>
    );
};


export default function MyApplicationsPage() {
    const [activeTab, setActiveTab] = useState('All');
    const tabs = ['All', 'Pending', 'Approved', 'Rejected', 'Completed'];

    const filteredApplications = sampleApplications.filter(app => activeTab === 'All' || app.status === activeTab.toLowerCase());

    return (
        <div className="bg-gray-100 min-h-screen">
            <div className="container mx-auto p-4 sm:p-6 lg:p-8">
                <Card className="mb-6">
                    <CardHeader>
                        <CardTitle>My Activities</CardTitle>
                        <CardDescription>Track and manage your job applications.</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
                            <StatCard title="Pending" value="2" icon={<Clock className="h-4 w-4 text-gray-500"/>} />
                            <StatCard title="Approved" value="1" icon={<CheckCircle className="h-4 w-4 text-gray-500"/>} />
                            <StatCard title="This Month's Income" value="₩180,000" icon={<Briefcase className="h-4 w-4 text-gray-500"/>} />
                            <StatCard title="Avg. Rating" value="4.9/5" icon={<Briefcase className="h-4 w-4 text-gray-500"/>} />
                        </div>
                    </CardContent>
                </Card>

                <div className="mb-6">
                    <div className="border-b border-gray-200">
                        <nav className="-mb-px flex space-x-8" aria-label="Tabs">
                            {tabs.map(tab => (
                                <button
                                    key={tab}
                                    onClick={() => setActiveTab(tab)}
                                    className={`${
                                        activeTab === tab
                                        ? 'border-primary text-primary'
                                        : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                                    } whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm`}
                                >
                                    {tab}
                                </button>
                            ))}
                        </nav>
                    </div>
                </div>

                <div className="space-y-4">
                    {filteredApplications.map(app => (
                        <ApplicationCard key={app.id} app={app} />
                    ))}
                </div>
            </div>
        </div>
    );
}
