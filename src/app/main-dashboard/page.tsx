import MobileLayout from '@/components/layout/MobileLayout';
import { Card, CardContent } from "@/components/ui/Card";
import Button from "@/components/ui/Button";
import { Badge } from "@/components/ui/Badge";
import { Search, Edit, Map, Briefcase, Users, CheckCircle, Star } from 'lucide-react';

// A more compact Stat Card for the mobile view
const StatCard = ({ title, value, icon }: { title: string, value: string, icon: React.ReactNode }) => (
  <Card className="p-3 dark:bg-gray-800">
    <div className="flex items-center">
      <div className="p-2 bg-green-100 dark:bg-green-900/20 rounded-md mr-3">
        {icon}
      </div>
      <div>
        <p className="text-sm font-medium text-gray-500 dark:text-gray-400">{title}</p>
        <p className="text-lg font-bold text-gray-900 dark:text-gray-100">{value}</p>
      </div>
    </div>
  </Card>
);

// A simpler Action Card, more like a list item
const ActionCard = ({ title, description, icon, href }: { title: string, description: string, icon: React.ReactNode, href: string }) => (
    <a href={href} className="flex items-center p-4 bg-white dark:bg-gray-800 rounded-lg shadow-sm hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
        <div className="mr-4 text-green-600 dark:text-green-400">{icon}</div>
        <div>
            <h3 className="font-semibold text-gray-900 dark:text-gray-100">{title}</h3>
            <p className="text-sm text-gray-500 dark:text-gray-400">{description}</p>
        </div>
    </a>
);

const WorkItem = ({ title, price, location, time }: { title: string, price: string, location: string, time: string }) => (
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


export default function MainDashboardPage() {
  return (
    <MobileLayout headerText="Dashboard">
      <div className="space-y-6 p-4">
        {/* Quick Actions */}
        <section>
          <h2 className="text-lg font-semibold mb-3 text-gray-800 dark:text-gray-200">Get Started</h2>
          <div className="space-y-3">
            <ActionCard
                title="Find a Job"
                description="Browse local farm work opportunities."
                icon={<Search size={24} />}
                href="/work-list"
            />
            <ActionCard
                title="Post a Job"
                description="Find reliable workers for your farm."
                icon={<Edit size={24} />}
                href="/work-create"
            />
            <ActionCard
                title="Explore the Map"
                description="See all available jobs on a map."
                icon={<Map size={24} />}
                href="/work-map"
            />
          </div>
        </section>

        {/* Platform Stats */}
        <section>
          <h2 className="text-lg font-semibold mb-3 text-gray-800 dark:text-gray-200">Platform Stats</h2>
          <div className="grid grid-cols-2 gap-4">
            <StatCard title="Open Jobs" value="1,247" icon={<Briefcase className="text-green-600" />} />
            <StatCard title="Active Workers" value="856" icon={<Users className="text-green-600" />} />
            <StatCard title="Jobs Completed" value="2,134" icon={<CheckCircle className="text-green-600" />} />
            <StatCard title="Avg. Rating" value="4.8/5" icon={<Star className="text-green-600" />} />
          </div>
        </section>

        {/* Urgent Jobs */}
        <section>
            <div className="flex justify-between items-center mb-3">
                <h2 className="text-lg font-semibold text-gray-800 dark:text-gray-200">🔥 Urgent Jobs</h2>
                <Button href="/work-list" variant="link" className="text-sm text-green-600 dark:text-green-400">View all</Button>
            </div>
            <Card className="overflow-hidden">
              <CardContent className="p-0">
                <WorkItem
                  title="Fruit Picking (Citrus)"
                  price="$25/hour"
                  location="Riverina, NSW"
                  time="Tomorrow"
                />
                <WorkItem
                  title="Vineyard Pruning"
                  price="$28/hour"
                  location="Barossa Valley, SA"
                  time="In 3 days"
                />
                <WorkItem
                  title="General Farm Hand"
                  price="$300/day"
                  location="Atherton Tableland, QLD"
                  time="Next Week"
                />
              </CardContent>
            </Card>
        </section>
      </div>
    </MobileLayout>
  );
}
