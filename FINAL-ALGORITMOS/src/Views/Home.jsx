import React, { useContext, useEffect, useState } from 'react';
import { Navbar, Nav, Container, Form, FormControl, Button, Card, Modal } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';
import { userContext } from '../Routes';

export default function Home() {
  const navigate = useNavigate();
  const { isLoggedIn, setIsLoggedIn } = useContext(userContext);
  const [products] = useState([
    { id: 1, name: 'Producto 1', description: 'Descripción del producto 1' },
    { id: 2, name: 'Producto 2', description: 'Descripción del producto 2' },
    { id: 3, name: 'Producto 3', description: 'Descripción del producto 3' },
  ]);

  useEffect(() => {
    let token = localStorage.getItem("token");
    if(token){
      setIsLoggedIn(true);
    }else{
      setIsLoggedIn(false)
    }
  },[]);

  const handleLoginClick = () => navigate("/login");
  function handleLogoutClick() {
    setIsLoggedIn(false);
    navigate("/login")
  }
  
  return (
    <div className="d-flex flex-column min-vh-100">
      <Navbar bg="light" expand="lg" className="mb-4">
        <Container>
          <Navbar.Brand href="#home">Mi E-commerce</Navbar.Brand>
          <Navbar.Toggle aria-controls="basic-navbar-nav" />
          <Navbar.Collapse id="basic-navbar-nav">
            <Nav className="me-auto">
              <Nav.Link href="#home">Inicio</Nav.Link>
              <Nav.Link href="#products">Productos</Nav.Link>
              <Nav.Link href="#contact">Contacto</Nav.Link>
            </Nav>
            <Form className="d-flex me-2">
              <FormControl
                type="search"
                placeholder="Buscar artículos"
                className="me-2"
                aria-label="Buscar"
              />
              <Button variant="outline-success">Buscar</Button>
            </Form>
            {
              isLoggedIn ?
                <Button variant="outline-primary" className="me-2" onClick={handleLogoutClick}>
                  Cerrar Sesión
                </Button>
                :
                <>
                  <Button variant="outline-primary" className="me-2" onClick={handleLoginClick}>
                    Iniciar Sesión
                  </Button>
                  <Button variant="primary">Registrarse</Button>
                </>
            }
          </Navbar.Collapse>
        </Container>
      </Navbar>

      <Container className="flex-grow-1">
        <h1 className="mb-4">Bienvenido a Mi E-commerce</h1>
        <p className="mb-4">Aquí encontrarás los mejores productos a los mejores precios.</p>

        <div className="row">
          {products.map((product) => (
            <div key={product.id} className="col-md-4 mb-4">
              <Card>
                <Card.Body>
                  <Card.Title>{product.name}</Card.Title>
                  <Card.Text>{product.description}</Card.Text>
                  <Button variant="primary">Ver detalles</Button>
                </Card.Body>
              </Card>
            </div>
          ))}
        </div>
      </Container>

      <footer className="bg-dark text-white text-center py-3 mt-4">
        <p className="mb-0">&copy; 2024 Mi E-commerce. Todos los derechos reservados.</p>
      </footer>
    </div>
  );
}