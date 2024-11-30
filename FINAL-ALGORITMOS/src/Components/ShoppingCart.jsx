import React, { useContext, useEffect, useState } from 'react';
import { Button, Offcanvas, ListGroup, Badge, Spinner, Modal } from 'react-bootstrap';
import { FaShoppingCart } from 'react-icons/fa';
import { DELETE, GET, POST } from '../Services/Fetch';
import { userContext } from '../Routes';

export default function ShoppingCart({ item, loadingCart }) {
  // Estado para el carrito de compras
  const [show, setShow] = useState(false);
  const [cartItems, setCartItems] = useState([]);
  const [addItemLoading, setAddItemLoading] = loadingCart;
  const [itemToAdd, setItemToAdd] = item;
  const { isLoggedIn, setShowModal } = useContext(userContext);
  const [totalAmount, setTotalAmount] = useState(0);
  const [notLoggedModal, setNotLoggedModal] = useState(false);
  
  useEffect(() => {
    async function addtocart() {
      setAddItemLoading(true);
      let rsp;
      if (itemToAdd != null) {
        toggleOffcanvas(true);
        if(isLoggedIn){
          rsp = await POST("products/addtocart", { IdItem: itemToAdd });
        }else{
          setNotLoggedModal(true);
          toggleOffcanvas(false);
        }
      } else {
        if(isLoggedIn){
          rsp = await GET("products/recovercart");
        }
      }
      if (rsp?.status === 401) {
        localStorage.removeItem('token');
        setShowModal(true);
        toggleOffcanvas(false);
      } else {
        if (rsp !== undefined) {
          rsp = await rsp?.json();
          if (rsp !== null) {
            setCartItems(rsp?.cartItems);
          }
        }
      }
      setAddItemLoading(false);
      setItemToAdd(null);
    }
    addtocart();
  }, [itemToAdd, isLoggedIn]);

  useEffect(() => {
    if (cartItems.length !== 0) {
      let total = cartItems?.reduce((accumulated, item) => accumulated + item.price * item.amount, 0);
      setTotalAmount(total);
    }
  }, [cartItems]);

  async function decreaseAmount(item) {
    setAddItemLoading(true);
    let rsp = await POST("products/removefromcart", { IdItem: item });
    if (rsp?.status === 401) {
      localStorage.removeItem('token');
      setShowModal(true);
      return;
    } else {
      if (rsp !== undefined) {
        rsp = await rsp.json();
        if (rsp !== null) {
          setCartItems(rsp.cartItems);
        }
      }
    }
    setAddItemLoading(false);
    setTotalAmount(total);
  }

  async function DeleteItem(item) {
    setAddItemLoading(true);
    let rsp = await DELETE("products/deleteitem", { IdItem: item });
    if (rsp?.status === 401) {
      localStorage.removeItem('token');
      setShowModal(true);
      return;
    } else {
      if (rsp !== undefined) {
        rsp = await rsp.json();
        if (rsp !== null) {
          setCartItems(rsp.cartItems);
        }
      }
    }
    setAddItemLoading(false);
    setTotalAmount(total);
  }
  // Función para mostrar u ocultar el Offcanvas (panel lateral)
  const toggleOffcanvas = (bool) => setShow(bool);

  return (
    <div>
      <Button
        variant="primary"
        style={{
          position: 'fixed',
          bottom: '20px',
          right: '20px',
          zIndex: 999,
          borderRadius: '50%',
          padding: '20px',
        }}
        onClick={toggleOffcanvas}
      >
        <FaShoppingCart />
        {cartItems.length > 0 && (
          <Badge pill bg="danger" style={{ position: 'absolute', top: 0, right: 0 }}>
            {cartItems.length}
          </Badge>
        )}
      </Button>

      {/* Offcanvas (panel lateral) para mostrar el contenido del carrito */}
      <Offcanvas show={show} onHide={toggleOffcanvas} className="bg-light" placement="end">
        <Offcanvas.Header closeButton>
          <Offcanvas.Title>Carrito de Compras</Offcanvas.Title>
        </Offcanvas.Header>
        <Offcanvas.Body>
          {cartItems.length === 0 ? (
            <p>No hay productos en tu carrito.</p>
          ) : (
            addItemLoading ?
              <Spinner />
              :
              <ListGroup>
                {cartItems.map((item, index) => (
                  <ListGroup.Item key={index} style={{ boxShadow: "10px 10px 15px rgba(0, 0, 0, 0.1)" }} className='mb-2'>
                    <div className='d-flex justify-content-between'>
                      {item.product_name}
                      <span>unidad: ${item.price}</span>
                    </div>
                    <hr></hr>
                    <div className='d-flex justify-content-between'>
                      <b>Cantidad: {item.amount}</b>
                      <div>
                        <Button
                          variant="outline-primary"
                          size="sm"
                          style={{ marginLeft: '10px' }}
                          onClick={() => setItemToAdd(item.id)}
                        >
                          +
                        </Button>
                        <Button
                          variant={item.amount === 1 ? "outline-secondary" : "outline-danger"}
                          size="sm"
                          style={{ marginLeft: '5px' }}
                          onClick={() => decreaseAmount(item.id)}
                          disabled={item.amount === 1}
                        >
                          -
                        </Button>
                        <Button
                          variant="outline-danger"
                          size="sm"
                          style={{ marginLeft: '10px' }}
                          onClick={() => DeleteItem(item.id)} // Eliminar artículo
                        >
                          <i className="bi bi-trash-fill"></i>
                        </Button>
                      </div>
                      Total: ${item.price * item.amount}
                    </div>
                    {/* {setTotalAmount(2)} */}
                  </ListGroup.Item>
                ))}
                Total: ${totalAmount}
              </ListGroup>
          )}

        </Offcanvas.Body>
      </Offcanvas>
      {
        <Modal show={notLoggedModal} onHide={() => setNotLoggedModal(!notLoggedModal)}>
          <Modal.Header closeButton>
            <Modal.Title>Inicio de Sesion</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            Para continuar, primero debe iniciar sesion.
          </Modal.Body>
          <Modal.Footer>
            <Button variant="primary" onClick={() => window.location = ("login")}>
              Iniciar sesión
            </Button>
          </Modal.Footer>
        </Modal>
      }
    </div>
  );
};
