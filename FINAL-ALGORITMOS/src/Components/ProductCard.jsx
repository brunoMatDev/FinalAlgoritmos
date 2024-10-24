export default function ProductCard(props) {
    return (
        <div className="product-card">
            <img src={props.imageUrl} alt={props.title} className="product-image" />
            <h2 className="product-title">{props.title}</h2>
            <p className="product-price">${props.price}</p>
        </div>
    );
}