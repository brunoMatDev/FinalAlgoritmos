export default function ProductCard(props) {
    return (
        <div className="card h-100">
            <img src={props.imageUrl} alt={props.title} className="card-img-top" />
            <div className="card-body">
                <h5 className="card-title">{props.title}</h5>
                <p className="card-text">${props.price}</p>
            </div>
            <div className="card-footer">
                <button className="btn btn-primary btn-block">Agregar al carrito</button>
            </div>
        </div>
    );
}
