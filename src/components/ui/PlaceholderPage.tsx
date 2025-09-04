import React from 'react';

const PageTitle = ({ title, summary }: { title: string, summary: string }) => (
    <div className="bg-white shadow-sm">
        <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <h1 className="text-3xl font-bold text-gray-900">{title}</h1>
            <p className="mt-2 text-gray-600">{summary}</p>
        </div>
    </div>
);

const PlaceholderContent = () => (
    <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="border-2 border-dashed border-gray-300 rounded-lg h-96 flex items-center justify-center">
            <p className="text-gray-500">Page content will be implemented here.</p>
        </div>
    </div>
);

export default function PlaceholderPage({ title, summary }: { title: string, summary: string }) {
    return (
        <div>
            <PageTitle title={title} summary={summary} />
            <PlaceholderContent />
        </div>
    );
}
