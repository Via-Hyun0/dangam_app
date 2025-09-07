import React from 'react';
import MobileLayout from '@/components/layout/MobileLayout';
import { WorkItem } from '@/components/ui/WorkItem';
import { generateMockJobs } from '@/data/mocks';

const WorkListPage: React.FC = () => {
  const jobs = generateMockJobs(100);

  return (
    <MobileLayout headerText="Find Work">
      <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm">
        {jobs.map((job) => (
          <WorkItem
            key={job.id}
            title={job.title}
            price={job.price}
            location={job.location}
            time={job.time}
          />
        ))}
      </div>
    </MobileLayout>
  );
};

export default WorkListPage;
