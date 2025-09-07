import React from 'react';
import MobileLayout from '@/components/layout/MobileLayout';
import Button from '@/components/ui/Button';
import Input from '@/components/ui/Input';
import { Textarea } from '@/components/ui/Textarea';

const Label = ({ children, ...props }: React.LabelHTMLAttributes<HTMLLabelElement>) => (
  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1" {...props}>
    {children}
  </label>
);

const WorkCreatePage: React.FC = () => {
  const [formData, setFormData] = React.useState({
    title: '',
    description: '',
    location: '',
    rate: '',
    unit: 'hour',
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    console.log("Form Submitted:", formData);
    // Here you would typically send the data to a server
    alert(`Job "${formData.title}" posted successfully! (Check console for data)`);
  };

  return (
    <MobileLayout headerText="Post a Job">
      <div className="p-4">
        <form className="space-y-6" onSubmit={handleSubmit}>
          <div>
            <Label htmlFor="title">Job Title</Label>
            <Input
              id="title"
              name="title"
              value={formData.title}
              onChange={handleChange}
              placeholder="e.g., Vineyard Pruning"
            />
          </div>

          <div>
            <Label htmlFor="description">Job Description</Label>
            <Textarea
              id="description"
              name="description"
              value={formData.description}
              onChange={handleChange}
              placeholder="Describe the work, requirements, etc."
            />
          </div>

          <div>
            <Label htmlFor="location">Location</Label>
            <Input
              id="location"
              name="location"
              value={formData.location}
              onChange={handleChange}
              placeholder="e.g., Barossa Valley, SA"
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <Label htmlFor="rate">Pay Rate</Label>
              <Input
                id="rate"
                name="rate"
                type="number"
                value={formData.rate}
                onChange={handleChange}
                placeholder="e.g., 28"
              />
            </div>
            <div>
              <Label htmlFor="unit">Per</Label>
              <Input
                id="unit"
                name="unit"
                value={formData.unit}
                onChange={handleChange}
                placeholder="Hour / Day"
              />
            </div>
          </div>

          <div>
            <Button type="submit" className="w-full">Post Job Listing</Button>
          </div>
        </form>
      </div>
    </MobileLayout>
  );
};

export default WorkCreatePage;
