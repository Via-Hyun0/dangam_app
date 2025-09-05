"use client";

import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/Card";
import Button from "@/components/ui/Button";
import { Badge } from "@/components/ui/Badge";
import { List, Map, Star } from 'lucide-react';

const sampleWorks = [
    { id: 1, title: "Rice Harvesting (Combine Operator)", distance: 2.1, price: "180,000/day", urgent: true },
    { id: 2, title: "Strawberry Farm Maintenance", distance: 5.2, price: "15,000/hour", urgent: false },
    { id: 3, title: "Barn Cleaning & Feeding", distance: 8.7, price: "120,000/day", urgent: false },
    { id: 4, title: "Apple Picking Assistant (Urgent)", distance: 12.3, price: "13,000/hour", urgent: true },
];

const WorkItem = ({ work, isSelected, onClick }: { work: typeof sampleWorks[0], isSelected: boolean, onClick: () => void }) => (
    <Card
        className={`cursor-pointer transition-all ${isSelected ? 'border-primary shadow-lg' : 'hover:border-gray-300'}`}
        onClick={onClick}
    >
        <CardContent className="p-4">
            <div className="flex justify-between items-start">
                <CardTitle className="text-base">{work.title}</CardTitle>
                {work.urgent && <Badge className="bg-red-100 text-red-800">Urgent</Badge>}
            </div>
            <div className="flex justify-between items-center mt-2 text-sm">
                <p className="text-gray-500">{work.distance}km away</p>
                <p className="font-semibold text-primary">{`₩${work.price}`}</p>
            </div>
        </CardContent>
    </Card>
);

const MapPlaceholder = () => (
    <div className="w-full h-full bg-gray-200 rounded-lg flex items-center justify-center">
        <div className="text-center text-gray-500">
            <Map className="mx-auto h-16 w-16 mb-4"/>
            <p className="font-semibold">Map Area</p>
            <p className="text-sm">An interactive map would be displayed here.</p>
        </div>
    </div>
);

export default function WorkMapPage() {
    const [selectedWorkId, setSelectedWorkId] = useState<number | null>(1);

    return (
        <div className="flex h-[calc(100vh-65px)]"> {/* Adjust height based on layout header */}
            {/* Sidebar */}
            <aside className="w-full md:w-1/3 lg:w-1/4 h-full flex flex-col border-r bg-white">
                <div className="p-4 border-b">
                    <h2 className="text-lg font-semibold">Jobs Near You</h2>
                    <p className="text-sm text-gray-500">Found {sampleWorks.length} jobs</p>
                </div>
                <div className="flex-grow p-4 space-y-4 overflow-y-auto">
                    {sampleWorks.map(work => (
                        <WorkItem
                            key={work.id}
                            work={work}
                            isSelected={selectedWorkId === work.id}
                            onClick={() => setSelectedWorkId(work.id)}
                        />
                    ))}
                </div>
            </aside>

            {/* Map Area */}
            <main className="flex-grow h-full p-4 bg-gray-100">
                <MapPlaceholder />
            </main>
        </div>
    );
}
