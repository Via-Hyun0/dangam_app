"use client";

import { useState, useMemo } from 'react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/Card";
import Button from "@/components/ui/Button";
import { Badge } from "@/components/ui/Badge";
import { Input } from "@/components/ui/Input";
import { Search, ListFilter, Map } from "lucide-react";

const sampleWorks = [
    { id: 1, title: "Rice Harvesting (Combine Operator)", description: "Urgent need for an experienced combine operator for a 3-hectare rice field.", category: "Paddy Field", price: "180,000", priceType: "per day", location: "Wanju-gun, Jeonbuk", distance: 2, date: "Tomorrow", time: "6 AM", tags: ["Combine", "Experience"], urgent: true, applicants: 3 },
    { id: 2, title: "Strawberry Farm Maintenance", description: "General maintenance and planting of new strawberry seedlings.", category: "Field", price: "15,000", priceType: "per hour", location: "Deokjin-gu, Jeonju", distance: 5, date: "In 3 days", time: "1 PM", tags: ["Manual Labor", "Beginner"], urgent: false, applicants: 1 },
    { id: 3, title: "Barn Cleaning & Feeding", description: "Daily management of a 60-head cattle barn. Includes cleaning and feeding.", category: "Livestock", price: "120,000", priceType: "per day", location: "Jinan-gun, Jeonbuk", distance: 12, date: "In 1 week", time: "7 AM", tags: ["Livestock", "Physical"], urgent: false, applicants: 0 },
    { id: 4, title: "Apple Picking Assistant", description: "Seasonal apple picking in a large orchard. Lunch provided.", category: "Orchard", price: "13,000", priceType: "per hour", location: "Imsil-gun, Jeonbuk", distance: 8, date: "This weekend", time: "8 AM", tags: ["Meal Included", "Weekend"], urgent: false, applicants: 5 },
];

const WorkListItem = ({ work }: { work: typeof sampleWorks[0] }) => (
    <Card className="hover:border-primary transition-all">
        <CardHeader>
            <div className="flex justify-between items-start">
                <div>
                    <CardTitle>{work.title}</CardTitle>
                    <CardDescription className="mt-1">{work.category}</CardDescription>
                </div>
                <div className="text-right">
                    <p className="text-lg font-bold text-primary">{`₩${work.price}`}</p>
                    <p className="text-xs text-gray-500">{work.priceType}</p>
                </div>
            </div>
        </CardHeader>
        <CardContent>
            <p className="text-sm text-gray-600 mb-4">{work.description}</p>
            <div className="flex items-center space-x-4 text-sm text-gray-500 mb-4">
                <span>📍 {work.location} ({work.distance}km)</span>
                <span>📅 {work.date} at {work.time}</span>
            </div>
            <div className="flex flex-wrap gap-2">
                {work.tags.map(tag => <Badge key={tag}>{tag}</Badge>)}
                {work.urgent && <Badge className="bg-red-100 text-red-700">Urgent</Badge>}
            </div>
        </CardContent>
    </Card>
);


export default function WorkListPage() {
  const [searchTerm, setSearchTerm] = useState('');
  const [category, setCategory] = useState('All');
  const [distance, setDistance] = useState('Any');

  const filteredWorks = useMemo(() => {
    return sampleWorks.filter(work => {
        const searchMatch = work.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
                            work.description.toLowerCase().includes(searchTerm.toLowerCase());

        const categoryMatch = category === 'All' || work.category === category;

        const distanceMatch = distance === 'Any' || work.distance <= parseInt(distance);

        return searchMatch && categoryMatch && distanceMatch;
    });
  }, [searchTerm, category, distance]);

  return (
    <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <div className="grid grid-cols-1 lg:grid-cols-4 gap-8">
        {/* Filters Column */}
        <aside className="lg:col-span-1">
            <Card>
                <CardHeader>
                    <CardTitle className="flex items-center"><ListFilter className="mr-2 h-4 w-4"/> Filters</CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                    <div>
                        <label htmlFor="category" className="text-sm font-medium">Category</label>
                        <select id="category" value={category} onChange={e => setCategory(e.target.value)} className="w-full mt-1 p-2 border rounded-md">
                            <option>All</option>
                            <option>Paddy Field</option>
                            <option>Field</option>
                            <option>Orchard</option>
                            <option>Livestock</option>
                        </select>
                    </div>
                    <div>
                        <label htmlFor="distance" className="text-sm font-medium">Distance</label>
                        <select id="distance" value={distance} onChange={e => setDistance(e.target.value)} className="w-full mt-1 p-2 border rounded-md">
                            <option>Any</option>
                            <option>5</option>
                            <option>10</option>
                            <option>25</option>
                        </select>
                    </div>
                </CardContent>
            </Card>
        </aside>

        {/* Results Column */}
        <main className="lg:col-span-3">
          <Card className="mb-6">
            <CardContent className="p-4">
              <div className="flex items-center gap-4">
                <div className="relative flex-grow">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-5 w-5 text-gray-400" />
                    <Input
                        placeholder="Search by keyword, role, or location..."
                        className="pl-10 w-full"
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                    />
                </div>
                <Button variant="outline"><Map className="mr-2 h-4 w-4" /> Map View</Button>
              </div>
            </CardContent>
          </Card>

          <div className="space-y-6">
            {filteredWorks.length > 0 ? (
                filteredWorks.map(work => <WorkListItem key={work.id} work={work} />)
            ) : (
                <div className="text-center py-16">
                    <p className="text-gray-500">No jobs found that match your search.</p>
                </div>
            )}
          </div>
        </main>
      </div>
    </div>
  );
}
