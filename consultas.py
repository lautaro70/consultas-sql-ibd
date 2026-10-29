"""Funciones para crear las bases de ejemplo y ejecutar las consultas de cada ejercicio."""
import re
from pathlib import Path

import duckdb

CARPETA_SQL = Path(__file__).resolve().parent / "sql"


def crear_base(ejercicio: str) -> duckdb.DuckDBPyConnection:
    """Crea una base en memoria con el esquema y los datos de ejemplo del ejercicio."""
    con = duckdb.connect()
    for archivo in ("01_esquema.sql", "02_datos.sql"):
        con.execute((CARPETA_SQL / ejercicio / archivo).read_text(encoding="utf-8"))
    return con


def cargar_consultas(ejercicio: str) -> dict:
    """Lee 03_consultas.sql y devuelve {número: (enunciado, sql)}."""
    texto = (CARPETA_SQL / ejercicio / "03_consultas.sql").read_text(encoding="utf-8")
    partes = re.split(r"^-- @(\d+) (.*)$", texto, flags=re.MULTILINE)
    consultas = {}
    for i in range(1, len(partes), 3):
        consultas[int(partes[i])] = (partes[i + 1].strip(), partes[i + 2].strip())
    return consultas


def ejecutar(con, consultas: dict, numero: int):
    """Muestra el enunciado y el SQL de una consulta, la ejecuta y devuelve el resultado como DataFrame."""
    enunciado, sql = consultas[numero]
    print(f"{numero}. {enunciado}\n")
    print(sql, "\n")
    sentencias = [s.strip() for s in sql.split(";") if s.strip()]
    for sentencia in sentencias:
        resultado = con.execute(sentencia)
        if sentencia.upper().startswith(("UPDATE", "DELETE", "INSERT")):
            print(f"Filas afectadas: {resultado.fetchone()[0]}")
    if not sentencias[-1].upper().startswith(("UPDATE", "DELETE", "INSERT")):
        return resultado.df()
