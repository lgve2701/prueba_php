
<div class="formWrapper">
    <div class="notificationArea"></div>
    <form id="registroForm" action="../api/registro_insertar.php" method="POST" class="FormularioAjax" autocomplete="off">
        
        <h2>Registro de usuario</h2>

        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" maxlength="120">

        <label for="correo">Correo:</label>
        <input type="email" id="correo" name="correo" maxlength="160">
        <div id="correoError" class="error"></div>

        <label for="password">Contraseña:</label>
        <input type="password" id="password" name="password" maxlength="255">

        <label for="fecha_nacimiento">Fecha de Nacimiento:</label>
        <input type="date" id="fecha_nacimiento" name="fecha_nacimiento">
        <div id="fechaError" class="error"></div>

        <button type="submit" onclick="return validarPreGuardar();">Registrar</button>

    </form>
</div>

<script src="../js/formulario.js"></script>
