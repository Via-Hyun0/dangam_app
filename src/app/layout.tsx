import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import Link from "next/link";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "FarmWork Connect",
  description: "Connecting farms and workers in Australia.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={`${inter.className} bg-gray-200 dark:bg-gray-950 flex items-center justify-center min-h-screen`}>
        {children}
      </body>
    </html>
  );
}
