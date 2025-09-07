export interface MockJob {
  id: number;
  title: string;
  price: string;
  location: string;
  time: string;
}

const jobTitles = [
  "Fruit Picking", "Vineyard Pruning", "General Farm Hand", "Tractor Operator", "Irrigation Technician",
  "Livestock Handling", "Crop Seeding", "Harvesting Crew", "Packing Shed Sorter", "Fence Repair"
];
const jobTypes = ["(Citrus)", "(Apples)", "(Grapes)", "(Seasonal)", "(Vegetables)"];
const locations = [
  "Riverina, NSW", "Barossa Valley, SA", "Atherton Tableland, QLD", "Margaret River, WA",
  "Yarra Valley, VIC", "Huon Valley, TAS", "Sunraysia, VIC", "Goulburn Valley, VIC"
];
const prices = ["$25/hour", "$28/hour", "$300/day", "$24/hour", "$320/day", "$22/hour"];
const times = ["Starts tomorrow", "In 3 days", "Next Week", "Starts Monday", "ASAP", "In 2 weeks"];

const getRandomElement = <T>(arr: T[]): T => arr[Math.floor(Math.random() * arr.length)];

export const generateMockJobs = (count: number): MockJob[] => {
  const jobs: MockJob[] = [];
  for (let i = 1; i <= count; i++) {
    jobs.push({
      id: i,
      title: `${getRandomElement(jobTitles)} ${getRandomElement(jobTypes)}`,
      price: getRandomElement(prices),
      location: getRandomElement(locations),
      time: getRandomElement(times),
    });
  }
  return jobs;
};
