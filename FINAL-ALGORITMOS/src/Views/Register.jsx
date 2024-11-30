import { useState } from "react";
import Input from "../Components/Input";
import { ClipLoader } from "react-spinners";
import FunctionButton from "../Components/FunctionButton";
import { POST } from "../Services/Fetch";

export default function Register() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [password2, setPassword2] = useState("");
  const [name, setName] = useState("");
  const [lastName, setLastName] = useState("");
  const [loading, setLoading] = useState(false);
  const [errorMessage, setErrorMessage] = useState(null);
  const [succesfulMessage, setSuccesfulMessage] = useState(null);

  function CheckValidity() {
    if (password !== password2) {
      setErrorMessage("Las contraseñas no coinciden");
    } else if (username.length < 8) {
      setErrorMessage("el nombre de usuario debe tener al menos 8 caracteres");
    } else if (password.length < 8) {
      setErrorMessage("La contraseña debe tener al menos 8 caracteres");
    } else if (name === "" || lastName === "") {
      setErrorMessage("Ingrese nombre y apellido");
    } else {
      setErrorMessage(null)
      return true;
    }
  }

  async function Register() {
    setLoading(true);
    if (CheckValidity()) {
      let rsp = await POST("Auth/register", { Username: username, Password: password, Name: name, LastName: lastName });
      if (rsp) {
        rsp = await rsp.json();
        console.log(rsp);
        if (rsp?.error === false) {
          setSuccesfulMessage(rsp?.message);
        } else {
          setErrorMessage(rsp?.message);
        }
      }
    }
    setLoading(false);
  }

  return (
    <div className="registerbg container-fluid d-flex justify-content-center align-items-center vh-100">
      <div className="shadow-lg bg-dark" style={{ width: '400px', borderRadius: '15px', overflow: 'hidden' }}>
        <div className="card-body text-center p-6">
          <h1 style={{ fontFamily: "'Poppins', sans-serif", fontWeight: 'bold', color: 'white' }}>¡Nos alegra que te unas al equipo!</h1>
          <form>
            <div className="mb-3 inputs">
              <div style={{ position: "absolute", left: "-18px", top: "8px" }}>
                <i className="bi bi-person-circle me-1" style={{ color: "white" }}></i>
                <label className="form-label">Usuario</label>
              </div>
              <Input type="text" styles={{ borderRadius: '10px', textAlign: "center" }} max="30" classes={"form-control"} setData={setUsername} />
            </div>
            <div className="mb-3 inputs">
              <div style={{ position: "absolute", left: "-18px", top: "8px" }}>
                <i className="bi bi-file-lock2 me-1" style={{ color: "white" }}></i>
                <label className="form-label">Contraseña</label>
              </div>
              <Input type="password" styles={{ borderRadius: '10px', textAlign: "center" }} max="30" classes={"form-control"} setData={setPassword} />
            </div>
            <div className="mb-3 inputs">
              <i className="bi bi-file-lock2 me-1" style={{ position: "absolute", left: "-18px", top: "8px", color: "white" }}></i>
              <label className="form-label" style={{ position: "absolute", left: "2px", top: "1px" }}>Repetir</label>
              <label className="form-label" style={{ position: "absolute", left: "2px", top: "17px" }}>Contraseña</label>
              <Input type="password" styles={{ borderRadius: '10px', textAlign: "center" }} max="30" classes={"form-control"} setData={setPassword2} />
            </div>
            <div className="mb-3 inputs">
              <div style={{ position: "absolute", left: "-18px", top: "8px" }}>
                <i className="bi bi-file-lock2 me-1" style={{ color: "white" }}></i>
                <label className="form-label">Nombre</label>
              </div>
              <Input type="text" styles={{ borderRadius: '10px', textAlign: "center" }} max="30" classes={"form-control"} setData={setName} />
            </div>
            <div className="mb-3 inputs">
              <div style={{ position: "absolute", left: "-18px", top: "8px" }}>
                <i className="bi bi-file-lock2 me-1" style={{ color: "white" }}></i>
                <label className="form-label">Apellido</label>
              </div>
              <Input type="text" styles={{ borderRadius: '10px', textAlign: "center" }} max="30" classes={"form-control"} setData={setLastName} />
            </div>
            {
              errorMessage &&
              <div className="alert alert-danger" role="alert">
                {errorMessage}
              </div>
            }
            <div className="d-flex justify-content-center">
              {
                loading ?
                  <ClipLoader
                    loading={loading}
                    color={"#6600A1"}
                    size={150}
                    aria-label="Loading Spinner"
                    data-testid="loader"
                  />
                  :
                  !succesfulMessage ?
                    <FunctionButton
                      callback={Register}
                      text="Registrarse"
                      classes="btn btn-primary"
                      style={{ backgroundColor: '#6e8efb', border: 'none', padding: '10px 20px', fontSize: '18px', borderRadius: '10px', transition: '0.3s' }}
                    />
                    :
                    <div className="alert alert-success" role="alert">
                      {succesfulMessage}
                    </div>
              }
            </div>
            <a href="home" className="text-secondary m-0 mt-1">Volver</a>
          </form>
        </div>
      </div>
    </div>
  );
}