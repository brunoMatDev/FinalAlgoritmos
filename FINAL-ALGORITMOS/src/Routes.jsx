import { useState } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Home from "./Layouts/Home";
import Login from "./Views/Login";

function App() {
  const [user, setUser] = useState(null);

  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route path="/*" element={<Login />}></Route>
          { user &&
            <Route path="Home" element={<Home/>}></Route>
          }
        </Routes>
      </BrowserRouter>
    </>
  );
}

export default App;
