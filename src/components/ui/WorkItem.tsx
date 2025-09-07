import React from 'react';
import { Badge } from "@/components/ui/Badge";

export const WorkItem = ({ title, price, location, time }: { title: string, price: string, location: string, time: string }) => (
    <div className="p-4 border-b border-gray-200 dark:border-gray-700 last:border-b-0">
        <div className="flex justify-between items-center mb-1">
            <h4 className="font-bold text-base text-gray-900 dark:text-gray-100">{title}</h4>
            <Badge className="bg-green-100 text-green-800 dark:bg-green-900/50 dark:text-green-300">{time}</Badge>
        </div>
        <p className="font-semibold text-green-600 dark:text-green-400 mb-2">{price}</p>
        <p className="text-sm text-gray-500 dark:text-gray-400">
            {location}
        </p>
    </div>
);
