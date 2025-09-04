import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import Link from "next/link";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Dangam Platform Redesign",
  description: "A collection of redesigned sample pages for the Dangam platform.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={`${inter.className} bg-gray-50 text-gray-800`}>
        <header className="bg-white shadow-sm sticky top-0 z-10">
          <nav className="container mx-auto px-6 py-4 flex justify-between items-center">
            <Link href="/" className="text-2xl font-bold text-primary">
              🍊 Dangam
            </Link>
            <div className="flex items-center space-x-6">
              <Link href="/" className="text-gray-600 hover:text-primary transition-colors">Dashboard</Link>
              <Link href="/dg-work-list" className="text-gray-600 hover:text-primary transition-colors">Find Work</Link>
              <Link href="/dg-work-create" className="text-gray-600 hover:text-primary transition-colors">Post a Job</Link>
            </div>
          </nav>
        </header>
        <main>
          {children}
        </main>
        <footer className="bg-white mt-12 py-6">
          <div className="container mx-auto px-6 text-center text-gray-500">
            <p>&copy; {new Date().getFullYear()} Dangam. All rights reserved.</p>
          </div>
        </footer>
      </body>
    </html>
  );
}
