"use client";

import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/Card";
import Button from "@/components/ui/Button";
import { Input } from "@/components/ui/Input";
import { Textarea } from "@/components/ui/Textarea";
import { Select } from "@/components/ui/Select";
import { Checkbox } from "@/components/ui/Checkbox";
import { Briefcase, Calendar, DollarSign, MapPin, Info } from 'lucide-react';

const FormSection = ({ icon, title, children }: { icon: React.ReactNode, title: string, children: React.ReactNode }) => (
    <Card>
        <CardHeader>
            <CardTitle className="flex items-center">
                {icon}
                <span className="ml-2">{title}</span>
            </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
            {children}
        </CardContent>
    </Card>
);

export default function WorkCreatePage() {
    return (
        <div className="bg-gray-100 min-h-screen">
            <div className="container mx-auto p-4 sm:p-6 lg:p-8">
                <div className="max-w-3xl mx-auto">
                    <div className="text-center mb-8">
                        <h1 className="text-4xl font-bold">Create a New Job Posting</h1>
                        <p className="text-gray-500 mt-2">Fill in the details below to find the right person for your job.</p>
                    </div>

                    <form className="space-y-8">
                        <FormSection icon={<Briefcase />} title="Job Details">
                            <Input placeholder="Job Title (e.g., Rice Harvesting)" />
                            <Textarea placeholder="Detailed job description..." />
                        </FormSection>

                        <FormSection icon={<Calendar />} title="Schedule">
                            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <Input type="date" />
                                <Input type="date" />
                            </div>
                            <Select>
                                <option>All Day</option>
                                <option>Morning</option>
                                <option>Afternoon</option>
                            </Select>
                        </FormSection>

                        <FormSection icon={<MapPin />} title="Location">
                            <Input placeholder="Address (e.g., Jeonju, Jeonbuk)" />
                            <Input placeholder="Detailed location (e.g., behind the community center)" />
                        </FormSection>

                        <FormSection icon={<DollarSign />} title="Payment">
                            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <Input type="number" placeholder="Amount" />
                                <Select>
                                    <option>Per Hour</option>
                                    <option>Per Day</option>
                                    <option>Total</option>
                                </Select>
                            </div>
                        </FormSection>

                        <FormSection icon={<Info />} title="Additional Information">
                            <Textarea placeholder="Additional details (e.g., meals provided, accommodation available)..." />
                            <div className="flex items-center space-x-2">
                                <Checkbox id="urgent" />
                                <label htmlFor="urgent" className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70">
                                    This is an urgent request
                                </label>
                            </div>
                        </FormSection>

                        <div className="flex justify-end space-x-4">
                            <Button variant="outline" type="button">Save as Draft</Button>
                            <Button type="submit">Post Job</Button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    );
}
