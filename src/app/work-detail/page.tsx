"use client";

import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/Card";
import Button from "@/components/ui/Button";
import { Badge } from "@/components/ui/Badge";
import { Avatar, AvatarFallback } from "@/components/ui/Avatar";
import { MapPin, Calendar, DollarSign, Check, Star, Briefcase } from 'lucide-react';

const workData = {
    title: "Rice Harvesting (Combine Operator Preferred)",
    category: "Paddy Field",
    location: "Gosan-myeon, Wanju-gun, Jeonbuk",
    distance: "2km away",
    posted: "2 hours ago",
    price: "180,000",
    priceType: "per day",
    description: "We are in urgent need of an experienced operator for a 3-hectare rice field. The harvest is plentiful this year, and we need to complete it quickly. We provide lunch and snacks. Work schedule is adjustable in case of bad weather.",
    requirements: [
        "Combine operator experience (2+ years)",
        "Ability to start work at 6 AM",
        "Physically fit and diligent",
    ],
    tags: ["Combine", "Drying Facility", "Experience Required"],
    employer: {
        name: "Kim Nongbu",
        rating: 4.8,
        reviews: 23,
        completedJobs: 67,
        reliability: "98%",
    }
};

export default function WorkDetailPage() {
    return (
        <div className="bg-gray-100 min-h-screen">
            <div className="container mx-auto p-4 sm:p-6 lg:p-8">
                <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    {/* Main Content */}
                    <main className="lg:col-span-2 space-y-8">
                        <Card>
                            <CardHeader>
                                <Badge className="bg-red-100 text-red-800 w-fit">Urgent</Badge>
                                <CardTitle className="text-3xl !mt-2">{workData.title}</CardTitle>
                                <div className="flex flex-wrap items-center gap-x-4 gap-y-2 text-sm text-gray-500">
                                    <span className="flex items-center"><MapPin className="h-4 w-4 mr-1"/>{workData.location}</span>
                                    <span className="flex items-center"><Calendar className="h-4 w-4 mr-1"/>Posted {workData.posted}</span>
                                </div>
                            </CardHeader>
                            <CardContent>
                                <p className="text-gray-700 leading-relaxed">{workData.description}</p>
                            </CardContent>
                        </Card>

                        <Card>
                            <CardHeader>
                                <CardTitle>Requirements</CardTitle>
                            </CardHeader>
                            <CardContent>
                                <ul className="space-y-2">
                                    {workData.requirements.map(req => (
                                        <li key={req} className="flex items-center">
                                            <Check className="h-5 w-5 text-green-600 mr-2"/>
                                            <span>{req}</span>
                                        </li>
                                    ))}
                                </ul>
                            </CardContent>
                        </Card>

                        <Card>
                             <CardHeader>
                                <CardTitle>Tags</CardTitle>
                            </CardHeader>
                            <CardContent>
                                <div className="flex flex-wrap gap-2">
                                    {workData.tags.map(tag => <Badge key={tag}>{tag}</Badge>)}
                                </div>
                            </CardContent>
                        </Card>
                    </main>

                    {/* Sidebar */}
                    <aside className="space-y-8">
                        <Card>
                             <CardHeader>
                                <CardTitle>Payment</CardTitle>
                            </CardHeader>
                            <CardContent>
                                <p className="text-3xl font-bold text-primary">{`₩${workData.price}`}</p>
                                <p className="text-gray-500">{workData.priceType}</p>
                                <Button className="w-full mt-4">Apply Now</Button>
                                <Button variant="outline" className="w-full mt-2">Ask a Question</Button>
                            </CardContent>
                        </Card>

                        <Card>
                            <CardHeader>
                                <CardTitle>About the Employer</CardTitle>
                            </CardHeader>
                            <CardContent>
                                <div className="flex items-center space-x-4">
                                    <Avatar>
                                        <AvatarFallback>KN</AvatarFallback>
                                    </Avatar>
                                    <div>
                                        <p className="font-semibold">{workData.employer.name}</p>
                                        <div className="flex items-center text-sm text-gray-500">
                                            <Star className="h-4 w-4 mr-1 text-yellow-500"/>
                                            {workData.employer.rating} ({workData.employer.reviews} reviews)
                                        </div>
                                    </div>
                                </div>
                                <div className="grid grid-cols-2 gap-4 mt-4 text-center">
                                    <div>
                                        <p className="font-bold text-lg">{workData.employer.completedJobs}</p>
                                        <p className="text-xs text-gray-500">Jobs Completed</p>
                                    </div>
                                    <div>
                                        <p className="font-bold text-lg">{workData.employer.reliability}</p>
                                        <p className="text-xs text-gray-500">Reliability</p>
                                    </div>
                                </div>
                            </CardContent>
                        </Card>
                    </aside>
                </div>
            </div>
        </div>
    );
}
