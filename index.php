<?php
  if (session_status() === PHP_SESSION_NONE) {
    session_name("prueba_dnc");
    session_start();
  }

  // Generar un token aleatorio si no existe
  if (!isset($_SESSION['csrf_token'])) {
      $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
  }
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" referrerpolicy="no-referrer">
    <link rel="stylesheet" href="css/estilos.css">    
    <link rel="stylesheet" href="css/estilos.css">
    <link rel="stylesheet" href="css/navbar.css">
    <link rel="stylesheet" href="css/formulario.css">
    <link rel="stylesheet" href="css/productos.css">
    <link rel="stylesheet" href="css/tarjetas.css">
    <link rel="stylesheet" href="css/footer.css">
  <title>PruebaDNC</title>
</head>
<body>

  <!-- ******************** NAVBAR ******************** -->
  <nav class="navbar">

    <div class="nav-left">
      <a href="index.php?vista=home">
        <img src="assets/logo.svg" alt="Logo">
      </a>
      <h1>Gabriel Vasquez</h1>
    </div>
    
    <div class="nav-center">
      <!-- <button onclick="location.href='index.php?vista=registro_usuario'">Registro</button>
      <button onclick="location.href='index.php?vista=productos'">Productos</button> -->
    </div>

    <div class="nav-right">
      <ul id="navMenu">
        <li><a href="index.php?vista=home" class="active">Home</a></li>
        <li><a href="index.php?vista=registro_usuario">Usuarios</a></li>
        <li><a href="index.php?vista=lista_productos">Productos</a></li>
        <li><a href="index.php?vista=reporte_productos">Reporte Productos</a></li>
      </ul>
    </div>

  </nav>

  <!-- ******************** CONTENIDO ******************** -->
  <div class="main-content">
    <div class="contenedor">
      <?php 
      
        if(!isset($_GET['vista']) || $_GET['vista'] == ""){
          $_GET['vista'] = "home";
        }

        if(is_file("./views/".$_GET['vista'].".php") && $_GET['vista']!="404"){
          include "./views/".$_GET['vista'].".php";
        } else {
          include "./views/not_found.php";
        }
      
        //revision de variables
        //include './views/debug.php';

      ?>
    </div>
  </div>

  <!-- ******************** FOOTER ******************** -->
  <footer class="fixed-footer">
      &copy; 2025 Gabriel Vasquez. Todos los derechos reservados.
      <div class="social-links">
        <a href="https://www.linkedin.com/in/luis-vasquez-4245a4359/" target="_blank" rel="noopener noreferrer" aria-label="LinkedIn">
          <i class="fa-brands fa-linkedin"></i>
        </a>
        <a href="https://github.com/lgve2701" target="_blank" rel="noopener noreferrer" aria-label="GitHub">
          <i class="fa-brands fa-github"></i>
        </a>
      </div>      
  </footer>

</body>
</html>

<script>

  document.addEventListener("DOMContentLoaded", () => {
    const navLinks = document.querySelectorAll("#navMenu a");

    // Obtener el parámetro ?vista= de la URL
    const params = new URLSearchParams(window.location.search);
    const currentPage = params.get("vista") || "home"; // default "home"

    // Marcar activo según el parámetro
    let activeFound = false;
    navLinks.forEach(link => {
      const url = new URL(link.href, window.location.origin);
      const page = url.searchParams.get("vista");

      if (page === currentPage) {
        link.classList.add("active");
        activeFound = true;
      } else {
        link.classList.remove("active");
      }
      
      //alert('currentPage: ' + currentPage + ', ' + 'page: ' + page);

    });

    // Si no encontró ninguno, marcar el primero
    if (!activeFound && navLinks.length > 0) {
      navLinks[0].classList.add("active");
    }

    // Cambiar activo dinámicamente al hacer clic
    navLinks.forEach(link => {
      link.addEventListener("click", function () {
        navLinks.forEach(l => l.classList.remove("active"));
        this.classList.add("active");
      });
    });
  });

</script>
