"use client";

import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/Card";
import Button from "@/components/ui/Button";
import { Input } from "@/components/ui/Input";
import { Check, Building, User, ChevronRight, UploadCloud } from 'lucide-react';

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
            <div>
                <label className="font-medium">Business Type</label>
                <div className="grid grid-cols-2 gap-4 mt-2">
                    <Button variant="outline" className="flex flex-col h-auto p-4 items-start text-left focus:border-primary focus:ring-2">
                        <User className="mb-2"/>
                        <span className="font-semibold">Individual</span>
                        <span className="text-xs text-gray-500">For sole proprietors.</span>
                    </Button>
                    <Button variant="outline" className="flex flex-col h-auto p-4 items-start text-left focus:border-primary focus:ring-2">
                        <Building className="mb-2"/>
                        <span className="font-semibold">Corporation</span>
                        <span className="text-xs text-gray-500">For registered companies.</span>
                    </Button>
                </div>
            </div>
            <Input placeholder="Business Registration Number (e.g., 000-00-00000)" />
            <Input placeholder="Company Name" />
            <Input placeholder="CEO/Owner Name" />
             <div className="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center hover:border-primary cursor-pointer">
                <UploadCloud className="mx-auto h-12 w-12 text-gray-400" />
                <p className="mt-2 text-sm text-gray-600">Click to upload Business Registration Certificate</p>
                <p className="text-xs text-gray-500">PDF, PNG, JPG up to 10MB</p>
            </div>
        </CardContent>
    </>
);
// ... Other steps would be defined similarly

export default function BusinessUpgradePage() {
    const [step, setStep] = useState(0);

    const nextStep = () => setStep(prev => (prev < steps.length - 1 ? prev + 1 : prev));
    const prevStep = () => setStep(prev => (prev > 0 ? prev - 1 : prev));

    return (
        <div className="bg-gray-100">
            <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-12">
                <div className="max-w-3xl mx-auto">
                    <div className="mb-8">
                        <StepIndicator currentStep={step} />
                    </div>

                    <Card>
                        {step === 0 && <Step1 />}
                        {/* Add other steps here */}
                        {step === 1 && <CardContent><p>Step 2: Expertise details form goes here.</p></CardContent>}
                        {step === 2 && <CardContent><p>Step 3: Confirmation of all details goes here.</p></CardContent>}
                    </Card>

                    <div className="mt-6 flex justify-between">
                        <Button variant="outline" onClick={prevStep} disabled={step === 0}>
                            Previous
                        </Button>
                        <Button onClick={nextStep} disabled={step === steps.length - 1}>
                            Next
                        </Button>
                        {step === steps.length - 1 && (
                             <Button>Submit Application</Button>
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
}
