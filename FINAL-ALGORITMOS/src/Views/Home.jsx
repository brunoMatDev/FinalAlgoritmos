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
        <>
        {product.length > 0 ? (
            product.map((item,index) =>(
                <ProductCard
                imageUrl = {item.img}
                tittle= {item.nombre}
                price = {item.precio}
                />
            ))
        ) : (
            <div className="text-gray-600 text-center">No se encontraron usuarios.</div>
        )}

        </>
    );

}

export default Home;