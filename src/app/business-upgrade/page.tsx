"use client";

import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/Card";
import Button from "@/components/ui/Button";
import { Input } from "@/components/ui/Input";
import { Checkbox } from '@/components/ui/Checkbox';
import { Textarea } from '@/components/ui/Textarea';
import { Check, Building, User, ChevronRight, UploadCloud, Tractor, Wrench } from 'lucide-react';

const steps = ["Business Info", "Expertise", "Confirmation"];

const StepIndicator = ({ currentStep }: { currentStep: number }) => (
    <div className="flex items-center justify-center space-x-4">
        {steps.map((step, index) => (
            <div key={step} className="flex items-center">
                <div className={`w-8 h-8 rounded-full flex items-center justify-center text-white ${index < currentStep ? 'bg-green-500' : index === currentStep ? 'bg-primary' : 'bg-gray-300'}`}>
                    {index < currentStep ? <Check size={16} /> : index + 1}
                </div>
                <span className={`ml-2 font-medium ${index === currentStep ? 'text-primary' : 'text-gray-500'}`}>{step}</span>
                {index < steps.length - 1 && <ChevronRight size={20} className="text-gray-300 ml-4" />}
            </div>
        ))}
    </div>
);

const Step1 = () => (
    <>
        <CardHeader>
            <CardTitle>Business Information</CardTitle>
            <CardDescription>Please provide your business registration details.</CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
            <Input placeholder="Business Registration Number" />
            <Input placeholder="Company Name" />
            <div className="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center hover:border-primary cursor-pointer">
                <UploadCloud className="mx-auto h-12 w-12 text-gray-400" />
                <p className="mt-2 text-sm text-gray-600">Upload Business Registration Certificate</p>
            </div>
        </CardContent>
    </>
);

const Step2 = () => (
    <>
        <CardHeader>
            <CardTitle>Expertise & Equipment</CardTitle>
            <CardDescription>Let clients know what you specialize in.</CardDescription>
        </CardHeader>
        <CardContent className="space-y-6">
            <div>
                <h4 className="font-semibold mb-2 flex items-center"><Wrench className="mr-2 h-5 w-5"/> Main Services</h4>
                <div className="grid grid-cols-2 gap-4">
                    <div className="flex items-center space-x-2"><Checkbox id="s1"/><label htmlFor="s1">Paddy Field</label></div>
                    <div className="flex items-center space-x-2"><Checkbox id="s2"/><label htmlFor="s2">Field Work</label></div>
                    <div className="flex items-center space-x-2"><Checkbox id="s3"/><label htmlFor="s3">Orchard</label></div>
                    <div className="flex items-center space-x-2"><Checkbox id="s4"/><label htmlFor="s4">Livestock</label></div>
                </div>
            </div>
            <div>
                <h4 className="font-semibold mb-2 flex items-center"><Tractor className="mr-2 h-5 w-5"/> Equipment</h4>
                <Textarea placeholder="List the equipment you own (e.g., Tractor, Combine)..." />
            </div>
        </CardContent>
    </>
);

const Step3 = () => (
     <>
        <CardHeader>
            <CardTitle>Confirmation</CardTitle>
            <CardDescription>Please review all the information before submitting.</CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
            <div className="p-4 bg-gray-50 rounded-lg">
                <h4 className="font-semibold">Business Info</h4>
                <p className="text-sm text-gray-600">Company Name: Dangam Inc.</p>
                <p className="text-sm text-gray-600">Registration #: 123-45-67890</p>
            </div>
             <div className="p-4 bg-gray-50 rounded-lg">
                <h4 className="font-semibold">Expertise</h4>
                <p className="text-sm text-gray-600">Services: Paddy Field, Field Work</p>
                <p className="text-sm text-gray-600">Equipment: Tractor, Combine</p>
            </div>
        </CardContent>
    </>
);

export default function BusinessUpgradePage() {
    const [step, setStep] = useState(0);

    const nextStep = () => setStep(prev => (prev < steps.length - 1 ? prev + 1 : prev));
    const prevStep = () => setStep(prev => (prev > 0 ? prev - 1 : prev));

    return (
        <div className="bg-gray-100">
            <div className="container mx-auto px-4 sm:px-6 lg:p-8 py-12">
                <div className="max-w-3xl mx-auto">
                    <div className="mb-8">
                        <StepIndicator currentStep={step} />
                    </div>

                    <Card>
                        {step === 0 && <Step1 />}
                        {step === 1 && <Step2 />}
                        {step === 2 && <Step3 />}
                    </Card>

                    <div className="mt-6 flex justify-between">
                        <Button variant="outline" onClick={prevStep} disabled={step === 0}>
                            Previous
                        </Button>
                        {step < steps.length - 1 ? (
                            <Button onClick={nextStep}>Next</Button>
                        ) : (
                             <Button>Submit Application</Button>
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
}
