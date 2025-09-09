<?php 
    require_once 'utils.php';
    try{

        $nombre = limpiar_valor($_POST['nombre']);
        $correo = limpiar_valor($_POST['correo']);
        $password = limpiar_valor($_POST['password']);
        $in_fecha_nacimiento = limpiar_valor($_POST['fecha_nacimiento']);

        $partesFecha = explode("-", $in_fecha_nacimiento);
        // echo print_r($partesFecha);
        // exit();

        // obtener la fecha en formato sql valido
        if (count($partesFecha) > 0){
            $fecha_nacimiento = $partesFecha[0].'-'.$partesFecha[1].'-'.$partesFecha[2];
        }else{
            echo notification_error('La fecha de nacimiento no es válida.');
            exit();
        }
        
        // funciont que consulta si en la base de datos el correo ya esta en uso
        if (validar_email_enDB($correo)){
            echo notification_error('El correo ingresado ya se encuentra registrado con otro usuario.');
            exit();            
        }
        
        // Encriptar contraseña
        $password_encriptada = password_hash($password, PASSWORD_DEFAULT, ["cost"=>10]);

        $sp = conexion();
        $sp = $sp->prepare("call sp_usuarios_insert(:p_nombre, :p_correo, :p_password_hash, :p_fecha_nacimiento);");

        $params=[
            ":p_nombre"=>$nombre,
            ":p_correo"=>$correo,
            ":p_password_hash"=>$password_encriptada,
            ":p_fecha_nacimiento"=>$fecha_nacimiento
        ];

        $sp->execute($params);

        if ($sp->rowCount() >= 1){
            $sp = null;
            echo notification_success('Registro guardado exitosamente.'); // - '.$password_encriptada);
            exit();
        }else{
            $sp = null;
            echo notification_error('No se pudo registrar el usuario.'); // - '.$password_encriptada);
            exit();
        }

    }
    catch (PDOException $e) {
        echo notification_error($e->getMessage());
        exit();
    }

?>
