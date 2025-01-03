export default function FunctionButton (props){
    return (
        <button onClick={props.callback} className={props.classes} type={props.type}><span>{props.text}</span></button>
    );
}