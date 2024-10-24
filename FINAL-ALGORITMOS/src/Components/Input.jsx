export default function Input(props){
    
    function callback(e){
        props.setData(e.target.value);
    }
    
    return(
        <input type={props.type} style={props.styles} className={props.classes} onChange={callback}>{props.name}</input>
    );
} 