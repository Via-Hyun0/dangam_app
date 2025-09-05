"use client";

import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription, CardFooter } from "@/components/ui/Card";
import Button from "@/components/ui/Button";
import { Badge } from "@/components/ui/Badge";
import { Input } from "@/components/ui/Input";
import { Textarea } from "@/components/ui/Textarea"; // Assuming I'll create this
import { PlusCircle, Edit, Trash2 } from 'lucide-react';

const sampleServices = [
    { id: 1, name: "Professional Rice Harvesting", category: "Paddy Field", status: "Active", price: "₩150/pyeong" },
    { id: 2, name: "Greenhouse Tomato Management", category: "Facility", status: "Active", price: "₩200,000/month" },
    { id: 3, name: "Apple Picking Assistance", category: "Orchard", status: "Draft", price: "TBD" },
];

const ServiceCard = ({ service, onEdit }: { service: typeof sampleServices[0], onEdit: () => void }) => (
    <Card>
        <CardHeader>
            <div className="flex justify-between items-start">
                <CardTitle>{service.name}</CardTitle>
                <Badge className={service.status === 'Active' ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'}>
                    {service.status}
                </Badge>
            </div>
            <CardDescription>{service.category}</CardDescription>
        </CardHeader>
        <CardContent>
            <p className="font-semibold text-lg">{service.price}</p>
        </CardContent>
        <CardFooter className="flex justify-end space-x-2">
            <Button variant="outline" size="sm" onClick={onEdit}><Edit className="mr-2 h-4 w-4"/> Edit</Button>
            <Button variant="outline" size="sm"><Trash2 className="mr-2 h-4 w-4"/> Delete</Button>
        </CardFooter>
    </Card>
);

const ServiceModal = ({ isOpen, onClose }: { isOpen: boolean, onClose: () => void }) => {
    if (!isOpen) return null;
    return (
        <div className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center">
            <Card className="w-full max-w-2xl">
                <CardHeader>
                    <CardTitle>Register New Service</CardTitle>
                    <CardDescription>Fill in the details for your new service.</CardDescription>
                </CardHeader>
                <CardContent className="space-y-4">
                    <Input placeholder="Service Name (e.g., Professional Rice Harvesting)" />
                    <Textarea placeholder="Service Description..." />
                    <Input placeholder="Price (e.g., ₩150/pyeong)" />
                </CardContent>
                <CardFooter className="flex justify-end space-x-2">
                    <Button variant="outline" onClick={onClose}>Cancel</Button>
                    <Button onClick={onClose}>Save Service</Button>
                </CardFooter>
            </Card>
        </div>
    );
};


export default function ServiceRegisterPage() {
    const [isModalOpen, setModalOpen] = useState(false);
    return (
        <div className="bg-gray-100 min-h-screen">
            <div className="container mx-auto p-4 sm:p-6 lg:p-8">
                <div className="flex justify-between items-center mb-6">
                    <div>
                        <h1 className="text-3xl font-bold">Manage My Services</h1>
                        <p className="text-gray-500">Register and manage the services you offer.</p>
                    </div>
                    <Button onClick={() => setModalOpen(true)}>
                        <PlusCircle className="mr-2 h-4 w-4"/> Add New Service
                    </Button>
                </div>

                <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
                    {sampleServices.map(service => (
                        <ServiceCard key={service.id} service={service} onEdit={() => setModalOpen(true)} />
                    ))}
                </div>

                <ServiceModal isOpen={isModalOpen} onClose={() => setModalOpen(false)} />
            </div>
        </div>
    );
}
