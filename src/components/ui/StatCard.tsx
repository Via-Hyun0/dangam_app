import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/Card";

const StatCard = ({ title, value, icon }: { title: string, value: string, icon?: React.ReactNode }) => (
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

export default StatCard;
