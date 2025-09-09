const formularios_ajax = document.querySelectorAll(".FormularioAjax");

formularios_ajax.forEach(formularios => {
    formularios.addEventListener("submit", submit_formulario_ajax);
});

function submit_formulario_ajax(e){
    e.preventDefault();

    let enviar = confirm("Deseas enviar los datos?");
    if (enviar == true){

        let body = new FormData(this);
        let method = this.getAttribute("method"); //indica si es POST o GET
        let action = this.getAttribute("action"); //url donde enviar el formulario

        let headers = new Headers();

        //crear un array [config] para utilizar el api fetch de javascript
        let config = {
            method: method,
            headers: headers,
            mode: 'cors',
            cache: 'no-cache',
            body: body
        };

        //llamada y obtencion de respuesta
        fetch(action,config)
        .then(respuesta => respuesta.text())
        .then(respuesta => {
            if (respuesta.includes('Registro guardado exitosamente.')) {
                limpiarCampos();
            }
            let contenedor = document.querySelector(".notificationArea");
            contenedor.innerHTML = respuesta;
        })

    }
}

function limpiarCampos(){
    try{
        document.getElementById("nombre").value = '';
        document.getElementById("correo").value = '';
        document.getElementById("password").value = '';
        document.getElementById("fecha_nacimiento").value = '';
    } catch(e) {
        notification_error(e);
    }
}

const txtNombre = document.getElementById('nombre');
txtNombre.addEventListener('focus', function() {
    console.log('Input field is now focused!');
    txtNombre.classList.remove('errorbox');
});
const txtCorreo = document.getElementById('correo');
txtCorreo.addEventListener('focus', function() {
    console.log('Input field is now focused!');
    txtCorreo.classList.remove('errorbox');
});
const txtPassword = document.getElementById('password');
txtPassword.addEventListener('focus', function() {
    console.log('Input field is now focused!');
    txtPassword.classList.remove('errorbox');
});
const txtFechaNacimiento = document.getElementById('fecha_nacimiento');
txtFechaNacimiento.addEventListener('focus', function() {
    console.log('Input field is now focused!');
    txtFechaNacimiento.classList.remove('errorbox');
});

function validarCampoObligatorio(campo){
    if (campo.value.trim().length <= 0) {
        campo.classList.add('errorbox');
        return false;
    }
    return true;
}

function validarPreGuardar(){
    try{
        let continuar = true;

        if (!validarCampoObligatorio(txtNombre)) continuar = false;
        if (!validarCampoObligatorio(txtCorreo)) continuar = false;
        if (!validarCampoObligatorio(txtPassword)) continuar = false;
        if (!validarCampoObligatorio(txtFechaNacimiento)) continuar = false;
        
        if (continuar == false){
            notification_error('Debes completar los campos requeridos.');
            return false;
        }

        // -- validar que el correo sea un formato correcto -- //
        const correo = document.getElementById("correo").value;
        const correoRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!correoRegex.test(correo)) {
            notification_error('El valor del correo no es un formato válido.'); // alert('El correo no es válido. - ' + correo);
            return false;
        } else {
            notification_clear();
        }

        // -- validar password -- //
        const pass = txtPassword.value;
        const passwordRegex = /^(?=(?:.*[A-Z]){2,})(?=.*\d)(?=.*[!@#$%^&*()_\-+=\[\]{};:'",.<>?/\\|`~]).{8,}$/;
        if (!passwordRegex.test(pass)){
            notification_error('El password debe contener al menos 8 caracteres (Con mínimo 2 mayúsculas, 1 dígito y un sígno especial)'); // alert('El correo no es válido. - ' + correo);
            return false;
        } else {
            notification_clear();
        }

        // -- validar que el usuario a registrar sea mayor a 17 años -- //
        const fechaNacimiento = new Date(document.getElementById("fecha_nacimiento").value);
        const hoy = new Date();
        const edad = hoy.getFullYear() - fechaNacimiento.getFullYear();
        const mes = hoy.getMonth() - fechaNacimiento.getMonth();
        const dia = hoy.getDate() - fechaNacimiento.getDate();
        let edadReal = edad;
        if (mes < 0 || (mes === 0 && dia < 0)) {
            edadReal--;
        }
        if (edadReal < 17) {
            notification_error('Debes tener al menos 17 años.'); // alert('Debes tener al menos 17 años.');
            return false;
        } else {
            notification_clear();
        }

    } catch(e) {
        notification_error(e);
        return false;
        //alert(e);
    }

    return continuar;
}

function notification_clear(){
    let contenedor = document.querySelector(".notificationArea");
    contenedor.innerHTML = '';
}

function notification_success(msg){
    let contenedor = document.querySelector(".notificationArea");
    contenedor.innerHTML = '<div class="notification_success"><strong>Exito!</strong><br/><br/><p>'+ msg +'</p></div>';
}
function notification_error(msg){
    let contenedor = document.querySelector(".notificationArea");
    contenedor.innerHTML = '<div class="notification_error"><strong>Error!</strong><br/><br/><p>'+ msg +'</p></div>';
}
function notification_info(msg){
    let contenedor = document.querySelector(".notificationArea");
    contenedor.innerHTML = '<div class="notification_info"><strong>Información</strong><br/><br/><p>'+ msg +'</p></div>';
}
