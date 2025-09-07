import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import iPhoneFrame from '@/components/ui/iPhoneFrame';
import { Home, Briefcase, MessageSquare, User, Bell } from 'lucide-react';
import { cn } from '@/lib/utils'; // I'll need to create this utility function

const MobileLayout = ({ children, headerText }: { children: React.ReactNode, headerText: string }) => {
  const location = useLocation();

  const navItems = [
    { href: '/main-dashboard', icon: Home, label: 'Home' },
    { href: '/work-list', icon: Briefcase, label: 'Jobs' },
    { href: '/chat-room', icon: MessageSquare, label: 'Messages' },
    { href: '/profile', icon: User, label: 'Profile' },
  ];

  return (
    <iPhoneFrame>
      <div className="relative flex flex-col h-full bg-gray-50 dark:bg-gray-900 text-gray-800 dark:text-gray-200">
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
          {navItems.map((item) => {
            const isActive = location.pathname === item.href || (item.href === '/main-dashboard' && location.pathname === '/');
            return (
              <Link
                key={item.href}
                to={item.href}
                className={cn(
                  "flex flex-col items-center justify-center w-full hover:text-green-600 dark:hover:text-green-400",
                  isActive ? "text-green-600 dark:text-green-400 font-semibold" : "text-gray-500 dark:text-gray-400"
                )}
              >
                <item.icon size={24} />
                <span className="text-xs mt-1">{item.label}</span>
              </Link>
            );
          })}
        </nav>
      </div>
    </iPhoneFrame>
  );
};

export default MobileLayout;
