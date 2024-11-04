import { useState } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Login from "./Views/Login";
import Home from "./Views/Home";
function App() {
  const [user, setUser] = useState(null);

  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route path="/*" element={<Login setUser={setUser}/>}></Route>
          <Route path="/Home" element={<Home />}></Route>
          { user &&
            <Route path="Home" element={<Home/>}></Route>
          }
        </Routes>
      </BrowserRouter>
    </>
  );
}

export default App;
