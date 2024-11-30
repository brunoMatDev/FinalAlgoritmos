import { createContext, useEffect, useState } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Login from "./Views/Login";
import Home from "./Views/Home";
import { Button, Modal } from "react-bootstrap";
import Register from "./Views/Register";
export const userContext = createContext()
export default function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [showModal, setShowModal] = useState(false);

  useEffect(() => {
    let token = localStorage.getItem("token");
    if (token) {
      setIsLoggedIn(true);
    }
  }, []);
  return (
    <>
      <BrowserRouter>
        <userContext.Provider value={{ isLoggedIn, setIsLoggedIn, setShowModal }}>
          <Routes>
            <Route path="/*" element={<Login />}></Route>
            <Route path="Register" element={<Register />}></Route>
            <Route path="Home" element={<Home />}></Route>
          </Routes>
        </userContext.Provider>
      </BrowserRouter>
      {
        <Modal show={showModal} onHide={() => setShowModal(!showModal)}>
          <Modal.Header closeButton>
            <Modal.Title>Token Expirado</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            Tu sesión ha expirado. Por favor, inicia sesión nuevamente.
          </Modal.Body>
          <Modal.Footer>
            <Button variant="primary" onClick={() => window.location = ("login")}>
              Iniciar sesión
            </Button>
          </Modal.Footer>
        </Modal>
      }
    </>
  );
}


