export default function FunctionButton (props){
    return (
        <button onClick={props.callback} className={props.classes} type="button"><span>{props.text}</span></button>
    );
}