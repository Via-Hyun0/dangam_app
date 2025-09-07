import React from 'react';
import MobileLayout from '@/components/layout/MobileLayout';

const PlaceholderContent = ({ title }: { title: string }) => (
    <div className="p-8 text-center">
        <h2 className="text-2xl font-bold">{title}</h2>
        <p className="text-gray-500 mt-2">This page is under construction.</p>
    </div>
);

const ChatRoomPage: React.FC = () => {
  return (
    <MobileLayout headerText="Messages">
      <PlaceholderContent title="Chat Room" />
    </MobileLayout>
  );
};

export default ChatRoomPage;
