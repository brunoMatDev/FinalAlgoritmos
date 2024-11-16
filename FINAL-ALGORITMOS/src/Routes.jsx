import { createContext, useEffect, useState } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Login from "./Views/Login";
import Home from "./Views/Home";
export const userContext = createContext()
export default function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  useEffect(() => {
    let token = localStorage.getItem("token");
    if(token){
      setIsLoggedIn(true);
    }
  },[]);
  return (
    <>
      <BrowserRouter>
        <userContext.Provider value={{ isLoggedIn, setIsLoggedIn }}>
          <Routes>
            <Route path="/*" element={<Login/>}></Route>
            {isLoggedIn &&
              <Route path="Home" element={<Home />}></Route>
            }
          </Routes>
        </userContext.Provider>
      </BrowserRouter>
    </>
  );
}


