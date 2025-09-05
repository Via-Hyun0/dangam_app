"use client";

import { useState, useRef, useEffect } from 'react';
import Button from "@/components/ui/Button";
import { Input } from "@/components/ui/Input";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/Avatar";
import { Phone, MoreVertical, Paperclip, Send } from 'lucide-react';

const mockMessages = [
    { id: 1, type: 'system', content: 'You were approved for this job.' },
    { id: 2, from: 'other', content: "Hi there! Thanks for applying for the rice harvesting job. Do you have your own combine?" },
    { id: 3, from: 'me', content: "Hello! Yes, I have a combine and 5 years of experience." },
    { id: 4, from: 'other', content: "Oh, that's great! Can you start tomorrow at 6 AM?" },
    { id: 5, from: 'me', content: "Yes, I can! Could you please provide the exact location?" },
];

const MessageBubble = ({ message }: { message: { from?: string, content: string } }) => {
    const isMe = message.from === 'me';
    const bubbleClasses = isMe
        ? "bg-primary text-primary-foreground self-end"
        : "bg-gray-200 text-gray-800 self-start";
    return (
        <div className={`max-w-xs md:max-w-md p-3 rounded-lg ${bubbleClasses}`}>
            {message.content}
        </div>
    );
};

export default function ChatRoomPage() {
    const [messages, setMessages] = useState(mockMessages);
    const [newMessage, setNewMessage] = useState('');
    const messagesEndRef = useRef<null | HTMLDivElement>(null);

    const scrollToBottom = () => {
        messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
    };

    useEffect(scrollToBottom, [messages]);

    const handleSendMessage = (e: React.FormEvent) => {
        e.preventDefault();
        if (newMessage.trim() === '') return;
        setMessages([...messages, { id: Date.now(), from: 'me', content: newMessage }]);
        setNewMessage('');
    };

    return (
        <div className="flex flex-col h-[calc(100vh-65px)]"> {/* Adjust height based on layout header */}
            {/* Chat Header */}
            <div className="flex items-center p-4 border-b bg-white">
                <Avatar>
                    <AvatarFallback>KN</AvatarFallback>
                </Avatar>
                <div className="flex-grow ml-4">
                    <h2 className="font-semibold">Kim Nongbu</h2>
                    <p className="text-xs text-green-600">Online</p>
                </div>
                <div className="flex items-center space-x-2">
                    <Button variant="ghost" size="icon"><Phone /></Button>
                    <Button variant="ghost" size="icon"><MoreVertical /></Button>
                </div>
            </div>

            {/* Messages Area */}
            <div className="flex-grow p-4 overflow-y-auto bg-gray-50">
                <div className="flex flex-col space-y-4">
                    {messages.map(msg => {
                        if (msg.type === 'system') {
                            return <div key={msg.id} className="text-center text-xs text-gray-500 py-2">{msg.content}</div>
                        }
                        return <MessageBubble key={msg.id} message={msg} />
                    })}
                    <div ref={messagesEndRef} />
                </div>
            </div>

            {/* Input Area */}
            <div className="p-4 border-t bg-white">
                <form onSubmit={handleSendMessage} className="flex items-center space-x-4">
                    <Button variant="ghost" size="icon" type="button"><Paperclip /></Button>
                    <Input
                        placeholder="Type a message..."
                        className="flex-grow"
                        value={newMessage}
                        onChange={(e) => setNewMessage(e.target.value)}
                    />
                    <Button type="submit" size="icon"><Send /></Button>
                </form>
            </div>
        </div>
    );
}
