export default function FunctionButton (props){
    return (
        <button onClick={props.callback} class={props.class}>
            <span>{props.text}</span>
        </button>
    );
}