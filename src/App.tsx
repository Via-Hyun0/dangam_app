import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import DashboardPage from './pages/DashboardPage';
import WorkListPage from './pages/WorkListPage';
import ChatRoomPage from './pages/ChatRoomPage';
import ProfilePage from './pages/ProfilePage';
import WorkCreatePage from './pages/WorkCreatePage';
import WorkDetailPage from './pages/WorkDetailPage';
import WorkMapPage from './pages/WorkMapPage';

export default function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<DashboardPage />} />
        <Route path="/main-dashboard" element={<DashboardPage />} />
        <Route path="/work-list" element={<WorkListPage />} />
        <Route path="/chat-room" element={<ChatRoomPage />} />
        <Route path="/profile" element={<ProfilePage />} />
        <Route path="/work-create" element={<WorkCreatePage />} />
        <Route path="/work-detail/:id" element={<WorkDetailPage />} />
        <Route path="/work-map" element={<WorkMapPage />} />
      </Routes>
    </Router>
  );
}
