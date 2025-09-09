<?php 

?>

<h2>Procesar archivo CSV</h2>

<!-- <form action="../api/reporte_procesar.php" method="post" enctype="multipart/form-data"> -->
<form action="" method="post" enctype="multipart/form-data">

    <div>

        <?php
            require_once("api/utils.php");

            try{
                
                $pyFile = "../api/procesar_csv.py";
                $destino = "../api/uploads/productos_1000.csv";

                // Ejecutar Python con el archivo
                $comando = escapeshellcmd("python3 ".$pyFile." ".escapeshellarg($destino));
                $salida = shell_exec($comando);

                echo "<h2>Resultados:</h2>";
                echo "<pre>$salida</pre>";

            } catch(Exception $e) {
                echo notification_error($e->getMessage());
            }

        ?>

    </div>

    <!-- <label>Selecciona un archivo CSV:</label> -->
    <!-- <input type="file" name="archivo_csv" accept=".csv" required> -->
    <!-- <button type="submit">Procesar</button> -->

</form>

