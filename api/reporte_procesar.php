<?php

     $destino = "uploads/productos_1000.csv";

     // Ejecutar Python con el archivo
    $comando = escapeshellcmd("python3 procesar_csv.py " . escapeshellarg($destino));
    $salida = shell_exec($comando);

    echo "<h2>Resultados:</h2>";
    echo "<pre>$salida</pre>";

    // version original gpt:
    // if (isset($_FILES['archivo_csv'])) {
    //     $archivo_tmp = $_FILES['archivo_csv']['tmp_name'];
    //     $nombre = $_FILES['archivo_csv']['name'];

    //     // Guardar el archivo temporalmente
    //     $destino = "uploads/" . $nombre;
    //     move_uploaded_file($archivo_tmp, $destino);

    //     // Ejecutar Python con el archivo
    //     $comando = escapeshellcmd("python3 procesar_csv.py " . escapeshellarg($destino));
    //     $salida = shell_exec($comando);

    //     echo "<h2>Resultados:</h2>";
    //     echo "<pre>$salida</pre>";
    // } else {
    //     echo "No se subió ningún archivo.";
    // }

?>
