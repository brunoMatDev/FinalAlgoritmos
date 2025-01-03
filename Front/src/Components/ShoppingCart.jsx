import React, { useContext, useEffect, useState } from "react";
import {
  Button,
  Offcanvas,
  ListGroup,
  Badge,
  Spinner,
  Modal,
} from "react-bootstrap";
import { FaShoppingCart } from "react-icons/fa";
import { DELETE, GET, POST } from "../Services/Fetch";
import { userContext } from "../Routes";

export default function ShoppingCart({ item, loadingCart }) {
  const [show, setShow] = useState(false);
  const [cartItems, setCartItems] = useState([]);
  const [loading, setLoading] = loadingCart;
  const [itemToAdd, setItemToAdd] = item;
  const { isLoggedIn, setShowModal } = useContext(userContext);
  const [totalAmount, setTotalAmount] = useState(0);
  const [notLoggedModal, setNotLoggedModal] = useState(false);
  const [comingSoon, setComingSoon] = useState(false);

  useEffect(() => {
    async function RecoverCart() {
      if (isLoggedIn) {
        setLoading(true);
        let rsp = await GET("products/recovercart");
        if (rsp?.status === 401) {
          localStorage.removeItem("token");
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
      }
    }
    RecoverCart();
    setLoading(false);
    setItemToAdd(null);
  }, [isLoggedIn]);

  useEffect(() => {
    if (cartItems.length !== 0) {
      let total = cartItems?.reduce(
        (accumulated, item) => accumulated + item.price * item.amount,
        0
      );
      setTotalAmount(total);
    }
  }, [cartItems]);

  useEffect(() => {
    async function addToCart() {
      if (itemToAdd != null) {
        setLoading(true);
        toggleOffcanvas(true);
        if (isLoggedIn) {
          let rsp = await POST("products/addtocart", { IdItem: itemToAdd });
          if (rsp?.status === 401) {
            localStorage.removeItem("token");
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
        } else {
          setNotLoggedModal(true);
          toggleOffcanvas(false);
        }
        setLoading(false);
      }
    }
    addToCart();
    setItemToAdd(null);
  }, [itemToAdd]);

  async function decreaseAmount(item) {
    setLoading(true);
    let rsp = await POST("products/removefromcart", { IdItem: item });
    if (rsp?.status === 401) {
      localStorage.removeItem("token");
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
    setLoading(false);
    setTotalAmount(total);
  }

  async function DeleteItem(item) {
    setLoading(true);
    let rsp = await DELETE("products/deleteitem", { IdItem: item });
    if (rsp?.status === 401) {
      localStorage.removeItem("token");
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
    setLoading(false);
    setTotalAmount(total);
  }
  // Función para mostrar u ocultar el Offcanvas (panel lateral)
  const toggleOffcanvas = (bool) => setShow(bool);

  return (
    <div>
      <Button
        variant="primary"
        style={{
          position: "fixed",
          bottom: "20px",
          right: "20px",
          zIndex: 999,
          borderRadius: "50%",
          padding: "20px",
        }}
        onClick={toggleOffcanvas}
      >
        <FaShoppingCart />
        {cartItems.length > 0 && (
          <Badge
            pill
            bg="danger"
            style={{ position: "absolute", top: 0, right: 0 }}
          >
            {cartItems.length}
          </Badge>
        )}
      </Button>

      {/* Offcanvas (panel lateral) para mostrar el contenido del carrito */}
      <Offcanvas
        show={show}
        onHide={toggleOffcanvas}
        className="bg-light"
        placement="end"
      >
        <Offcanvas.Header closeButton>
          <Offcanvas.Title>Carrito de Compras</Offcanvas.Title>
        </Offcanvas.Header>
        <Offcanvas.Body>
          {cartItems.length === 0 ? (
            <p>No hay productos en tu carrito.</p>
          ) : loading ? (
            <Spinner />
          ) : (
            <ListGroup>
              {cartItems.map((item, index) => (
                <ListGroup.Item
                  key={index}
                  style={{ boxShadow: "10px 10px 15px rgba(0, 0, 0, 0.1)" }}
                  className="mb-2"
                >
                  <div className="d-flex justify-content-between">
                    {item.product_name}
                    <span>unidad: ${item.price}</span>
                  </div>
                  <hr></hr>
                  <div className="d-flex justify-content-between">
                    <b>Cantidad: {item.amount}</b>
                    <div>
                      <Button
                        variant="outline-primary"
                        size="sm"
                        style={{ marginLeft: "10px" }}
                        onClick={() => setItemToAdd(item.id)}
                      >
                        +
                      </Button>
                      <Button
                        variant={
                          item.amount === 1
                            ? "outline-secondary"
                            : "outline-danger"
                        }
                        size="sm"
                        style={{ marginLeft: "5px" }}
                        onClick={() => decreaseAmount(item.id)}
                        disabled={item.amount === 1}
                      >
                        -
                      </Button>
                      <Button
                        variant="outline-danger"
                        size="sm"
                        style={{ marginLeft: "20px" }}
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
              <div className="d-flex justify-content-between">
                Total: ${totalAmount}
                {
                  comingSoon ? 
                    <p>¡proximamente!</p>
                  :
                    <Button
                      variant="btn btn-primary"
                      size="sm"
                      style={{ marginLeft: "20px" }}
                      onClick={() => setComingSoon(true)}
                    >
                      Comprar
                    </Button>
                }
              </div>
            </ListGroup>
          )}
        </Offcanvas.Body>
      </Offcanvas>
      {
        <Modal
          show={notLoggedModal}
          onHide={() => setNotLoggedModal(!notLoggedModal)}
        >
          <Modal.Header closeButton>
            <Modal.Title>Inicio de Sesion</Modal.Title>
          </Modal.Header>
          <Modal.Body>Para continuar, primero debe iniciar sesion.</Modal.Body>
          <Modal.Footer>
            <Button
              variant="primary"
              onClick={() => (window.location = "login")}
            >
              Iniciar sesión
            </Button>
          </Modal.Footer>
        </Modal>
      }
    </div>
  );
}
