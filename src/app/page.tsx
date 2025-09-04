import Link from 'next/link';
import { Card, CardHeader, CardTitle, CardDescription } from '@/components/ui/Card';

const pages = [
  { href: '/main-dashboard', title: 'Main Dashboard', description: 'The main landing page of the application.' },
  { href: '/work-list', title: 'Work List', description: 'A list of available work opportunities.' },
  { href: '/business-upgrade', title: 'Business Upgrade', description: 'Upgrade your business account.' },
  { href: '/chat-room', title: 'Chat Room', description: 'Communicate with other users.' },
  { href: '/my-applications', title: 'My Applications', description: 'View and manage your job applications.' },
  { href: '/my-requests', title: 'My Requests', description: 'View and manage your work requests.' },
  { href: '/service-manage', title: 'Manage Service', description: 'Manage the services you offer.' },
  { href: '/service-register', title: 'Register Service', description: 'Register a new service to offer.' },
  { href: '/work-create', title: 'Create Work Request', description: 'Create a new request for work.' },
  { href: '/work-detail', title: 'Work Detail', description: 'View the details of a work request.' },
  { href: '/work-map', title: 'Work Map', description: 'View work requests on a map.' },
];

export default function RootDashboardPage() {
  return (
    <div>
      <div className="bg-white">
        <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-16 text-center">
            <h1 className="text-4xl font-extrabold text-gray-900">Project Sample Pages</h1>
            <p className="mt-4 text-lg text-gray-600 max-w-2xl mx-auto">
                This is a collection of all the redesigned pages. Click on any card to explore the new design and layout.
            </p>
        </div>
      </div>

      <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="grid sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
            {pages.map((page) => (
                <Link href={page.href} key={page.href} className="block hover:-translate-y-1 transition-transform">
                    <Card className="h-full">
                        <CardHeader>
                            <CardTitle>{page.title}</CardTitle>
                            <CardDescription>{page.description}</CardDescription>
                        </CardHeader>
                    </Card>
                </Link>
            ))}
        </div>
      </div>
    </div>
  );
}
