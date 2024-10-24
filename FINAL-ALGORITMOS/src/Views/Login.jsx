import FunctionButton from "../Components/FunctionButton";
import "../assets/login.css"

export default function Login(props) {
    return (
        <div className="conteiner d-flex justify-content-center align-items-center vh-100">
            <div className="card">
                <div className="card-body">
                    <h1>BRUNO'S</h1>
                    <form>
                        <div class="mb-3">
                            <label for="usuario" class="form-label">Usuario</label>
                            <input type="text" class="form-control" id="usuario" name="usuario" />
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" />
                        </div>
                        <div className="d-flex justify-content-center">
                            <FunctionButton
                                call=""
                                text="Ingresar"
                                class="btn btn-outline-primary"
                            />
                        </div>
                    </form>
                </div>
            </div>
        </div>
    );
}