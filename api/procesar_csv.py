import sys
import pandas as pd

# print(f"PRUEBA DE RESULTADOS DESDE PYTHON")

# Ruta del archivo desde PHP
archivo = sys.argv[1]

# Leer CSV
df = pd.read_csv(archivo)

# Validación mínima
if not {'Producto', 'Precio', 'Stock'}.issubset(df.columns):
    print("El archivo CSV debe contener las columnas: Producto, Precio, Stock")
    sys.exit(1)

# Procesos
promedio_precio = df['Precio'].mean()
producto_mayor_stock = df.loc[df['Stock'].idxmax(), 'Producto']
total_productos = len(df)

# Resultados
print(f"Promedio de precios: {promedio_precio:.2f}")
print(f"Producto con mayor stock: {producto_mayor_stock}")
print(f"Total de productos: {total_productos}")
