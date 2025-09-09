<?php
    $tokenActual = '';
    // Generar un token aleatorio si no existe
    if (isset($_SESSION['csrf_token'])) {
        $tokenActual = $_SESSION['csrf_token'];
    }
?>

<div style="text-align: center;display: inline-flex; align-items: center;">
    <img src="../assets/logo_black.svg" alt="Logo">
</div>

<div style="margin-top: 25px; word-wrap: break-word;">
  <p>Token: <i><?php echo $tokenActual ?></i></p>
</div>
