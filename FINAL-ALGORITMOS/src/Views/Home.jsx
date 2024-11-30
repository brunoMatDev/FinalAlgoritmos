import React, { useContext, useEffect, useState } from 'react';
import { Navbar, Container, FormControl, Button, Card, Modal, Badge, Spinner, Dropdown } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';
import { userContext } from '../Routes';
import Skeleton from 'react-loading-skeleton';
import 'react-loading-skeleton/dist/skeleton.css'
import "../../public/images/logo.jpg"
import { GET } from '../Services/Fetch';
import Pagination from '../Components/Pagination';
import ShoppingCart from '../Components/ShoppingCart';
import { jwtDecode } from "jwt-decode";

export default function Home() {
  const navigate = useNavigate();
  const { isLoggedIn, setIsLoggedIn, setShowModal } = useContext(userContext);
  const [products, setProducts] = useState(null);
  const [counter, setCounter] = useState(1);
  const [itemToAdd, setItemToAdd] = useState(null);
  const [addItemLoading, setAddItemLoading] = useState(false);
  const [itemToSearch, setItemToSearch] = useState("");

  useEffect(() => {
    let token = localStorage.getItem("token");
    if (token) {
      setIsLoggedIn(true);
    } else {
      setIsLoggedIn(false)
    }
    async function getProducts() {
      let request = {
        page: `${counter}`
      }
      let rsp;
      if (itemToSearch === "") {
        rsp = await GET("products/ListProducts", request);
      } else {
        request.search = itemToSearch;
        rsp = await GET("products/searchbyname", request);
      }
      if (rsp?.status === 401) {
        setShowModal(true);
        localStorage.removeItem('token');
        setIsLoggedIn(false);
      } else {
        rsp = await rsp.json();
        setProducts(rsp.result);
      }
    }
    getProducts();
  }, [counter, itemToSearch]);
  useEffect(() => {
    setCounter(1);
  }, [itemToSearch]);

  const handleLoginClick = () => navigate("/login");
  function handleLogoutClick() {
    setIsLoggedIn(false);
    localStorage.removeItem('token');
    window.location = "home";
  }

  return (
    <div className="d-flex flex-column min-vh-100 bg-light">
      <Navbar bg="light" expand="lg" className="mb-4 justify-content-between h-25">
        <Container fluid>
          <Navbar.Brand href="">
            <img
              alt=""
              src="../../images/logo.jpg"
              width="40"
              height="40"
              className="d-inline-block align-top"
              style={{ cursor: "pointer" }}
            />
            Carrito de Bruno
          </Navbar.Brand>
          <Navbar.Toggle aria-controls="basic-navbar-nav" />
          <Navbar.Collapse id="basic-navbar-nav" className='text-end'>
            <div className="input-group me-lg-4 w-lg-50">
              <span className="input-group-text bg-light border-0">
                <i className="bi bi-search"></i>
              </span>
              <FormControl
                type="search"
                placeholder="Buscar artículos"
                className="border-0"
                aria-label="Buscar"
                onChange={(e) => setItemToSearch(e.target.value)}
              />
            </div>
            {
              isLoggedIn ?
                <>
                  <Dropdown>
                    <Dropdown.Toggle variant="outline-dark me-1 border-0" id="dropdown-custom-components">
                      <i className="bi bi-person-circle me-2"></i>
                    </Dropdown.Toggle>
                    <Dropdown.Menu className="p-3 shadow-lg position-absolute end-0 justify-self-end" style={{ justifySelf:"end", width: "200px", borderRadius: "8px" }}>
                      <p className="mb-2 text-secondary">
                        <b>Usuario:</b> {` ${localStorage.getItem("token") ? jwtDecode(localStorage.getItem("token")).username : ""}`}
                      </p>
                      <Button variant="outline-primary w-100" onClick={handleLogoutClick}>
                        Cerrar Sesión
                      </Button>
                    </Dropdown.Menu>
                  </Dropdown>
                </>
                :
                <>
                  <Button variant="outline-secondary" className="m-2 px-4" onClick={handleLoginClick}>
                    Iniciar Sesión
                  </Button>
                  <Button href="register" variant="primary" className="m-2 px-4">
                    Registrarse
                  </Button>
                </>
            }
          </Navbar.Collapse>
        </Container>
      </Navbar>
      <div className="flex-grow-1 d-flex flex-column justify-content-center m-0 p-0 w-100">
        <h1 className="mb-4">Bienvenido al carrito de Bruno</h1>
        <h2 className="mb-4 align-self-center">Aquí encontrarás los mejores productos a los mejores precios.</h2>

        <div className='d-flex justify-content-center align-items-start flex-wrap w-100 bg-light'>
          {
            products ? products.length == 0 && <p>"No quedan mas articulos para mostrar, regrese mas tarde para mas productos."</p> : ""
          }
          <div className='d-flex justify-content-center w-100'>
            <Pagination currentPage={counter} onPageChange={setCounter} />
          </div>
          {
            products !== null ?
              <>
                {
                  products?.map((product) => (
                    <Card key={product.id} className='m-2' style={{ width: "300px", height: "400px", overflow: "hidden" }}>
                      <Card.Header className='d-flex flex-wrap justify-content-center'>
                        <Card.Img variant="top" src={`../../images/${product.image_path}.jpg`}
                          alt={product.product_name} style={{ height: '180px', objectFit: 'contain' }}
                          onError={(e) => e.target.src = `../../images/sinimagen.jpg`}
                        />
                        <Card.Title className='text-center' style={{ height: "21px", fontSize: "18px", overflow: "hidden" }}>{product.product_name}</Card.Title>
                      </Card.Header>
                      <Card.Body className='d-flex flex-wrap justify-content-center p-0'>
                        <Card.Text style={{ height: "100px", width: "220px", fontSize: "14px", overflow: "auto" }}>{product.description}</Card.Text>
                        <Card.Footer className='d-flex justify-content-between w-100'>
                          <div className='align-content-center'>
                            ${product.price}
                          </div>
                          {
                            addItemLoading ?
                              <Spinner className='d-flex' />
                              :
                              <Button className='d-flex bg-success' style={{ marginLeft: "auto", height: "40px" }} variant="primary" onClick={() => { setItemToAdd(product.id); }}>Añadir al carrito</Button>
                          }
                        </Card.Footer>
                      </Card.Body>
                    </Card>
                  ))
                }
                {
                  products &&
                  products.length !== 0 &&
                  <div className='d-flex justify-content-center w-100'>
                    <Pagination totalPages={products.length} currentPage={counter} onPageChange={setCounter} />
                  </div>
                }
              </>
              :
              <div className='d-flex justify-content-center'>
                <div className='m-2'>
                  <Skeleton width={360} height={200} count={1} />
                  <Skeleton width={360} height={40} count={1} />
                  <Skeleton width={360} height={20} count={5} />
                </div>
                <div className='m-2'>
                  <Skeleton width={360} height={200} count={1} />
                  <Skeleton width={360} height={40} count={1} />
                  <Skeleton width={360} height={20} count={5} />
                </div>
                <div className='m-2'>
                  <Skeleton width={360} height={200} count={1} />
                  <Skeleton width={360} height={40} count={1} />
                  <Skeleton width={360} height={20} count={5} />
                </div>
              </div>
          }
        </div>
      </div>
      <ShoppingCart item={[itemToAdd, setItemToAdd]} loadingCart={[addItemLoading, setAddItemLoading]} />
      <footer className="bg-dark text-white text-center py-3 mt-4">
        <p className="mb-0">&copy; 2024 Mi E-commerce. Todos los derechos reservados.</p>
      </footer>
    </div >
  );
}