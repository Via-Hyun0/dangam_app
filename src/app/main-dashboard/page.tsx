import { Card, CardContent, CardFooter, CardHeader, CardTitle, CardDescription } from "@/components/ui/Card";
import Button from "@/components/ui/Button";
import { Badge } from "@/components/ui/Badge";
import { Activity, ArrowUpRight, Search, Map, Edit } from 'lucide-react'; // Assuming I can't install, I'll mock these or use emojis.

const StatCard = ({ title, value, icon }: { title: string, value: string, icon: React.ReactNode }) => (
  <Card>
    <CardHeader className="flex flex-row items-center justify-between pb-2">
      <CardTitle className="text-sm font-medium">{title}</CardTitle>
      {icon}
    </CardHeader>
    <CardContent>
      <div className="text-2xl font-bold">{value}</div>
    </CardContent>
  </Card>
);

const ActionCard = ({ title, description, icon, href }: { title: string, description: string, icon: React.ReactNode, href: string }) => (
    <Card className="flex flex-col items-center justify-center text-center p-6 hover:bg-gray-50 transition-colors">
        <div className="mb-4 text-primary">{icon}</div>
        <CardTitle className="mb-2">{title}</CardTitle>
        <CardDescription className="mb-4 flex-grow">{description}</CardDescription>
        <Button href={href} size="sm">
            Learn More <span className="ml-2">→</span>
        </Button>
    </Card>
);

const WorkItem = ({ title, price, location, time, distance }: { title: string, price: string, location: string, time: string, distance: string }) => (
    <div className="flex items-center justify-between p-4 border-b last:border-b-0 hover:bg-gray-50">
        <div>
            <p className="font-semibold">{title}</p>
            <p className="text-sm text-gray-500 mt-1">
                {location} &middot; {time}
            </p>
        </div>
        <div className="text-right">
            <p className="font-semibold text-primary">{price}</p>
            <Badge className="mt-1">{distance}</Badge>
        </div>
    </div>
);


export default function MainDashboardPage() {
  return (
    <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-8">
      {/* Hero Section */}
      <div className="text-center py-16">
        <h1 className="text-4xl md:text-5xl font-bold text-gray-900">
          Welcome to the Dangam Platform
        </h1>
        <p className="mt-4 text-lg text-gray-600 max-w-2xl mx-auto">
          Your one-stop solution for connecting agricultural needs with skilled workers.
        </p>
      </div>

      {/* Action Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-12">
        <ActionCard
            title="Find Work"
            description="Browse and apply for agricultural jobs in your area."
            icon={<Search size={32} />}
            href="/work-list"
        />
        <ActionCard
            title="Post a Job"
            description="Create a new job listing to find the help you need."
            icon={<Edit size={32} />}
            href="/work-create"
        />
        <ActionCard
            title="Explore Map"
            description="Visualize job opportunities on an interactive map."
            icon={<Map size={32} />}
            href="/work-map"
        />
      </div>

      <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-4 mb-12">
        <StatCard title="Total Jobs Posted" value="1,247" icon={<Activity className="h-4 w-4 text-gray-500" />} />
        <StatCard title="Active Workers" value="856" icon={<Activity className="h-4 w-4 text-gray-500" />} />
        <StatCard title="Completed Jobs" value="2,134" icon={<Activity className="h-4 w-4 text-gray-500" />} />
        <StatCard title="Average Rating" value="4.8/5" icon={<Activity className="h-4 w-4 text-gray-500" />} />
      </div>

      <Card>
        <CardHeader>
          <CardTitle>🔥 Urgent Job Postings</CardTitle>
          <CardDescription>These jobs need to be filled soon. Apply now!</CardDescription>
        </CardHeader>
        <CardContent className="p-0">
          <WorkItem
            title="Rice Harvesting (Combine Operator)"
            price="₩150,000/day"
            location="Wanju-gun, Jeonbuk"
            time="By tomorrow"
            distance="2km away"
          />
          <WorkItem
            title="Strawberry Farm Maintenance"
            price="₩12,000/hour"
            location="Deokjin-gu, Jeonju"
            time="In 3 days"
            distance="5km away"
          />
          <WorkItem
            title="Barn Cleaning & Feeding"
            price="₩80,000/day"
            location="Maryeong-myeon, Jinan-gun"
            time="In 1 week"
            distance="12km away"
          />
        </CardContent>
        <CardFooter className="justify-end">
            <Button href="/work-list" variant="link">View all jobs</Button>
        </CardFooter>
      </Card>

    </div>
  );
}
