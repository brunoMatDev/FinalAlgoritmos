import { useEffect, useState } from "react";
import ProductCard from "../Components/ProductCard";
import { GET } from "../Services/Fetch";

const Home = () =>{
    const[product, SetProducts] = useState([]);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchProducts = async () => {
            const response = await GET("products/ListaProductos");
            
            if (response && response.data) {
                SetProducts(response.data);
            } else {
                setError("Error al cargar usuarios");
            }
        };

        fetchProducts();
    }, []);

    return(
        <div className="container mt-5">
            <h1 className="text-center mb-4">Lista de Productos</h1>
            <div className="row">
                {product.map(product => (
                    <div className="col-md-4 mb-4" key={product.id}>
                        <ProductCard
                            title={product.nombre}
                            price={product.precio}
                            imageUrl={product.img} // Asumiendo que image es un string en base64
                        />
                    </div>
                ))}
            </div>
        </div>
    );

}

export default Home;