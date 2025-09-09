<?php

    function conexion(){
		// prod
		// $host = "localhost";
		// $dbname = "db_prueba_dnc";
		// $username = 'mysql_root';
		// $password = 'Pass1234';
        // $port = "3307";
		// $fullHost = $host.':'.$port;

		//dev
		$host = "localhost";
		$dbname = "db_prueba_dnc";
		$username = 'root';
		$password = 'root';
        $port = "3306";
		$fullHost = $host.':'.$port;

		//echo 'mysql:host='.$fullHost.';dbname='.$dbname.';userName='.$username.';password='.$password;
        $pdo = new PDO('mysql:host='.$fullHost.';dbname='.$dbname, $username, $password);
        return $pdo;
    }

    //validar nombre de usuario, solo letras, numeros, guion y guion bajo, entre 4 y 16 caracteres
    $regUsuario = "/^[a-zA-Z0-9\_\-]{4,16}$/";
    //validar passwords, letras, numeros y caracteres especiales, entre 4 y 12 caracteres
    $regPassword = "/^[a-zA-Z0-9@$.-+*]{4,12}$/";
    //sirve para validar que ingresen nombre y apellido o apellido y nombre
    $namePattern = "/^([a-zA-Z]+) ([a-zA-Z]+)$/";
    //sirve para validar email
    $emailPattern = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'; //'/^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$/';
    //ingresar lo que sea pero sin espacios, sirve para el username y password
    $notOnlySpacesPattern = '/^[a-zA-Z0-9]+$/';
    //esta expresion solo permite letras a-z, numeros 0-9 y guiones bajo y normal
    $slugPattern = '/^[a-z0-9_]+(?:-[a-z0-9_]+)*$/';

	//buscador
	$regBuscador = "/^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ ]{1,30}$/";


    function validar_userName($userName){
        if(preg_match($regUsuario, $userName)){
            return true;
        }
        return false;
    }

    function validar_password($password){
        if(preg_match($regPassword, $password)){
            return true;
        }
        return false;
    }

	function validar_buscador($busqueda){
		if(preg_match($regBuscador, $busqueda)){
            return true;
        }
        return false;
	}

	function validar_usuario_enDB($usuario){
		$campo = 'usuario';
		$sp = conexion();
		$sp = $sp->prepare("call sp_usuarios_revisar_existencia(:p_campo, :p_valor);");

		$params=[
			":p_campo"=>$campo,
			":p_valor"=>$usuario
		];
		$sp->execute($params);

		if ($sp->rowCount() >= 1){
			return false;
		}
		$sp = null;
		return true;
	}

	function validar_email_enDB($email){
		$campo = 'email';
		$sp = conexion();
		$sp = $sp->prepare("call sp_usuarios_revisar_existencia(:p_campo, :p_valor);");

		$params=[
			":p_campo"=>$campo,
			":p_valor"=>$email
		];
		$sp->execute($params);

		if ($sp->rowCount() >= 1){
			return true;
		}
		$sp = null;
		return false;
	}


	function limpiar_valor($cadena){
		$cadena=trim($cadena);
		$cadena=stripslashes($cadena);
		$cadena=str_ireplace("<script>", "", $cadena);
		$cadena=str_ireplace("</script>", "", $cadena);
		$cadena=str_ireplace("<script src", "", $cadena);
		$cadena=str_ireplace("<script type=", "", $cadena);
		$cadena=str_ireplace("SELECT * FROM", "", $cadena);
		$cadena=str_ireplace("DELETE FROM", "", $cadena);
		$cadena=str_ireplace("INSERT INTO", "", $cadena);
		$cadena=str_ireplace("DROP TABLE", "", $cadena);
		$cadena=str_ireplace("DROP DATABASE", "", $cadena);
		$cadena=str_ireplace("TRUNCATE TABLE", "", $cadena);
		$cadena=str_ireplace("SHOW TABLES;", "", $cadena);
		$cadena=str_ireplace("SHOW DATABASES;", "", $cadena);
		$cadena=str_ireplace("<?php", "", $cadena);
		$cadena=str_ireplace("?>", "", $cadena);
		$cadena=str_ireplace("--", "", $cadena);
		$cadena=str_ireplace("^", "", $cadena);
		$cadena=str_ireplace("<", "", $cadena);
		$cadena=str_ireplace("[", "", $cadena);
		$cadena=str_ireplace("]", "", $cadena);
		$cadena=str_ireplace("==", "", $cadena);
		$cadena=str_ireplace(";", "", $cadena);
		$cadena=str_ireplace("::", "", $cadena);
		$cadena=trim($cadena);
		$cadena=stripslashes($cadena);
		return $cadena;
	}

	function notification_success($msg){
		return '
			<div class="notification_success">
				<strong>Exito!</strong>
				<br/><br/>
				<p>'.$msg.'</p>
			</div>
		';
	}

	function notification_error($msg){
		return '
			<div class="notification_error">
				<strong>Error!</strong>
				<br/><br/>
				<p>'.$msg.'</p>
			</div>
		';
	}

	function notification_info($msg){
		return '
			<div class="notification_info">
				<strong>Información</strong>
				<br/><br/>
				<p>'.$msg.'</p>
			</div>
		';
	}

?>


