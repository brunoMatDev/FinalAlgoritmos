import { useEffect, useState } from "react";
import FunctionButton from "../Components/FunctionButton";
import { POST } from "../Services/Fetch";
import "../assets/login.css"
import { useNavigate } from "react-router-dom";
import Input from "../Components/Input";

export default function Login(props) {
    const navigate = useNavigate();
    const [username, setUsername] = useState(null);
    const [password, setPassword] = useState(null);
    const [errorMessage, setErrorMessage] = useState(null);

    async function log(){
        var rsp = await POST("Auth/Login", {username: username, password: password});

        if(rsp != null){
            props.setUser(rsp);
            navigate("/Home");
        }else{
            setErrorMessage(rsp?.message);
        }
    }

    return (
        <div className="container-fluid d-flex justify-content-center align-items-center vh-100" style={{ background: 'linear-gradient(135deg, #6e8efb, #a777e3)' }}>
            <div className="card shadow-lg" style={{ width: '400px', borderRadius: '15px', overflow: 'hidden' }}>
                <div className="card-body text-center">
                    <h1 style={{ fontFamily: "'Poppins', sans-serif", fontWeight: 'bold', color: '#000' }}>BRUNO'S</h1>
                    <form>
                        <div className="mb-3">
                            <label htmlFor="usuario" className="form-label" style={{ color: '#fff' }}>Usuario</label>
                            <Input type="text" styles={{ borderRadius: '10px' }} classes={"form-control"} setData={setUsername}/>
                        </div>
                        <div className="mb-3">
                            <label htmlFor="password" className="form-label" style={{ color: '#fff' }}>Password</label>
                            <Input type="password" styles={{ borderRadius: '10px' }} classes={"form-control"} setData={setPassword}/>
                        </div>
<<<<<<< HEAD
                        {
                            errorMessage && 
                            <div>
                                {errorMessage}
                            </div>
                        }
=======
>>>>>>> 7a8eaf77fcc5bc91f6799f91d2180c9ba8b69fd7
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