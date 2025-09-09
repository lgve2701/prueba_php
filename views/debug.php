<?php

    // incluir archivo en index para revisar variables internas de PHP //
    echo "<div style='text-align:center; background-color: #fff;'>";
    echo "VARIABLES DE INICIO: <br /> ";
    echo "vista:" .  $_GET['vista'] . "<br>";
    echo "Host: " . $_SERVER['HTTP_HOST'] . "<br>";
    echo "Ruta completa (URI): " . $_SERVER['REQUEST_URI'] . "<br>";
    echo "Script ejecutado: " . $_SERVER['SCRIPT_NAME'] . "<br>";
    echo "Query string: " . $_SERVER['QUERY_STRING'] . "<br>";
    echo "</div>";

?>
