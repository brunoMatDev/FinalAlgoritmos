export default function Input(props){
    
    function callback(){
        
    }
    
    return(
        <input type={props.type} className={props.classes} onClick={callback}>{props.name}</input>
    );
} 