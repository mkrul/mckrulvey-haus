import axios from "axios";
import "./App.css";
import {
  BrowserRouter as Router,
  Routes,
  Route,
  Navigate,
} from "react-router-dom";
import "bulma/css/bulma.min.css";
import NavBar from "./components/shared/NavBar";
import HomePage from "./components/pages/HomePage";
import ReptilesPage from "./components/pages/ReptilesPage";

function App() {
  const loc = window.location;
  axios.defaults.baseURL = `${loc.protocol}//${loc.hostname}${
    loc.hostname === "localhost" ? ":3000" : ""
  }`;

  return (
    <div className="App">
      <NavBar />
      <Router>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/guides/reptiles" element={<ReptilesPage />} />
          <Route path="*" element={<Navigate to="/" />} />
        </Routes>
      </Router>
    </div>
  );
}

export default App;
