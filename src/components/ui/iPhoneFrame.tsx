import React from 'react';

const iPhoneFrame = ({ children }: { children: React.ReactNode }) => {
  return (
    <div className="bg-gray-200 p-8 rounded-lg">
        <div className="relative mx-auto border-black bg-black border-[10px] rounded-[2.5rem] h-[800px] w-[400px] shadow-xl">
            {/* Top Bezel Elements */}
            <div className="absolute top-0 w-[140px] h-[28px] bg-black left-1/2 -translate-x-1/2 rounded-b-xl">
                <div className="absolute top-[6px] left-1/2 -translate-x-1/2 w-[60px] h-[4px] bg-gray-600 rounded-full"></div>
            </div>
            {/* Side Buttons */}
            <div className="h-[40px] w-[3px] bg-black absolute -start-[13px] top-[100px] rounded-s-lg"></div>
            <div className="h-[40px] w-[3px] bg-black absolute -start-[13px] top-[150px] rounded-s-lg"></div>
            <div className="h-[60px] w-[3px] bg-black absolute -end-[13px] top-[120px] rounded-e-lg"></div>
            {/* Screen Content */}
            <div className="rounded-[2rem] overflow-hidden w-full h-full bg-white dark:bg-black">
                {children}
            </div>
        </div>
    </div>
  );
};

export default iPhoneFrame;
