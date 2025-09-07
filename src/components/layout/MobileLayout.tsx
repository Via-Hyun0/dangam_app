import React from 'react';
import iPhoneFrame from '@/components/ui/iPhoneFrame';
import { Home, Briefcase, MessageSquare, User, Bell } from 'lucide-react';

const MobileLayout = ({ children, headerText }: { children: React.ReactNode, headerText: string }) => {
  return (
    <iPhoneFrame>
      <div className="flex flex-col h-full bg-gray-50 dark:bg-gray-900 text-gray-800 dark:text-gray-200">
        {/* App Header */}
        <header className="flex items-center justify-between flex-shrink-0 px-4 h-14 border-b border-gray-200 dark:border-gray-700">
          <h1 className="text-xl font-bold">{headerText}</h1>
          <button className="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700">
            <Bell size={22} />
          </button>
        </header>

        {/* Scrollable Content Area */}
        <main className="flex-1 overflow-y-auto pb-16">
          {children}
        </main>

        {/* Bottom Navigation */}
        <nav className="absolute bottom-0 left-0 right-0 flex justify-around h-16 bg-white dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700">
          <a href="/main-dashboard" className="flex flex-col items-center justify-center w-full text-green-600 dark:text-green-400 font-semibold">
            <Home size={24} />
            <span className="text-xs mt-1">Home</span>
          </a>
          <a href="/work-list" className="flex flex-col items-center justify-center w-full text-gray-500 dark:text-gray-400 hover:text-green-600 dark:hover:text-green-400">
            <Briefcase size={24} />
            <span className="text-xs mt-1">Jobs</span>
          </a>
          <a href="/chat-room" className="flex flex-col items-center justify-center w-full text-gray-500 dark:text-gray-400 hover:text-green-600 dark:hover:text-green-400">
            <MessageSquare size={24} />
            <span className="text-xs mt-1">Messages</span>
          </a>
          <a href="/my-page" className="flex flex-col items-center justify-center w-full text-gray-500 dark:text-gray-400 hover:text-green-600 dark:hover:text-green-400">
            {/* my-page does not exist, but let's assume it will be created later */}
            <User size={24} />
            <span className="text-xs mt-1">Profile</span>
          </a>
        </nav>
      </div>
    </iPhoneFrame>
  );
};

export default MobileLayout;
