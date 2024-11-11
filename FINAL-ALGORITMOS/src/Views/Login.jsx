import { useState } from "react";
import FunctionButton from "../Components/FunctionButton";
import { POST } from "../Services/Fetch";
import "../assets/login.css"
import { useNavigate } from "react-router-dom";
import Input from "../Components/Input";
import 'bootstrap-icons/font/bootstrap-icons.css';


export default function Login(props) {
  const navigate = useNavigate();
  const [username, setUsername] = useState(null);
  const [password, setPassword] = useState(null);
  const [errorMessage, setErrorMessage] = useState(null);

  async function log() {
    let rsp = await POST("Auth/Login", { username: username, password: password });
    console.log(rsp);
    if (rsp != undefined) {
      if (rsp.error == false) {
        props.setUser(rsp);
        navigate("/Home");
      } else {
        setErrorMessage(rsp?.message);
      }
    } else {
      setErrorMessage("no se puede procesar la peticion en este momento");
    }
  }

  return (
    <div className="loginbg container-fluid d-flex justify-content-center align-items-center vh-100">
      <div className="card shadow-lg bg-dark" style={{ width: '400px', borderRadius: '15px', overflow: 'hidden' }}>
        <div className="card-body text-center">
          <h1 style={{ fontFamily: "'Poppins', sans-serif", fontWeight: 'bold', color: 'white' }}>Login</h1>
          <form>
            <div className="mb-3 inputs">
              <div style={{ position: "absolute", left: "-2px", top: "8px" }}>
                <i className="bi bi-person-fill"></i>
                <label style={{ fontSize: "13px" }} className="form-label">Username</label>
              </div>
              <Input type="text" styles={{ borderRadius: '10px', textAlign: "center" }} max="30" classes={"form-control"} setData={setUsername} />
            </div>
            <div className="mb-3 inputs">
              <div style={{ position: "absolute", left: "-2px", top: "8px" }}>
                <i className="bi bi-lock-fill"></i>
                <label style={{ fontSize: "13px" }} className="form-label">Password</label>
              </div>
              <Input type="password" styles={{ borderRadius: '10px', textAlign: "center" }} max="30" classes={"form-control"} setData={setPassword} />
            </div>
            {
              errorMessage &&
              <div class="alert alert-danger" role="alert">
                {errorMessage}
              </div>
            }
            <div className="d-flex justify-content-center">
              <FunctionButton
                callback={log}
                text="Ingresar"
                classes="btn btn-primary"
                style={{ backgroundColor: '#6e8efb', border: 'none', padding: '10px 20px', fontSize: '18px', borderRadius: '10px', transition: '0.3s' }}
              />
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}