import React from 'react';
import MobileLayout from '@/components/layout/MobileLayout';

const PlaceholderContent = ({ title }: { title: string }) => (
    <div className="p-8 text-center">
        <h2 className="text-2xl font-bold">{title}</h2>
        <p className="text-gray-500 mt-2">This page is under construction.</p>
    </div>
);

const WorkCreatePage: React.FC = () => {
  return (
    <MobileLayout headerText="Post a Job">
      <PlaceholderContent title="Create a New Job" />
    </MobileLayout>
  );
};

export default WorkCreatePage;
