<?php
    require_once('utils.php');

    #api productos
    #proc: sp_productos_venta_select

    $img_dir = "api/imagenes/productos/";
    $img_no_image = "api/imagenes/no_image.jpg";

    $acordion = '<h2>Lista</h2>';
    $acordion .= '  <div class="accordion">';

    $tarjetas = "<h2>Productos</h2>";
    $tarjetas .= '  <div class="productos">';

    //objeto de conexion
    $cnn = conexion();

    $consulta_datos = "CALL sp_productos_venta_select();";

    //fetchAll: para convertir el resultado en un array
    $datos = $cnn->query($consulta_datos);
    $datos = $datos->fetchAll();
    
    foreach($datos as $dato){
        $acordion .= '
            <div class="accordion-item">
            <div class="accordion-header">
                <span>'.$dato['nombre'].'</span>
                <span>Precio: '.number_format($dato['precio'], 2, '.', ',').'</span>
            </div>
            <div class="accordion-content">
                <table>
                <thead>
                    <tr>
                    <th class="col-desc">Descripción</th>
                    <th class="col-stock">Stock</th>
                    <th class="col-img">Imagen</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                    <td>'.$dato['descripcion'].'</td>
                    <td>'.$dato['stock'].'</td>
                    <td><img src="'.$img_dir.$dato['imagen'].'" alt="'.$dato['imagen'].'"></td>
                    </tr>
                </tbody>
                </table>
            </div>
            </div>
        ';

        $tarjetas .= '
            <div class="card" onclick="toggleInfo(this)">
                <img style="max-width: 150px; max-height: 150px;" src="'.$img_dir.$dato['imagen'].'" alt="'.$dato['imagen'].'">
                <div class="card-title">'.$dato['nombre'].'</div>
                <div class="card-info">
                    <p><strong>Descripción:</strong>'.$dato['descripcion'].'</p>
                    <p><strong>Precio:</strong> '.number_format($dato['precio'], 2, '.', ',').'</p>
                    <p><strong>Stock:</strong> '.$dato['stock'].'</p>
                </div>
            </div>
        ';
    }
    
    $acordion .= '  </div>';
    $tarjetas .= '  </div>';

    echo $acordion.'<br/>'.$tarjetas;
?>
