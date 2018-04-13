#!/bin/bash

peticiones=(1000 1000 5000 5000 10000 10000 50000 50000 50000 100000 100000 100000)
concurrentes=(50 100 100 250 100 250 100 250 500 100 250 500)
direccionCorta="http://virtual.lab.inf.uva.es:31172/gatosPequenios.html"
direccionLarga="http://virtual.lab.inf.uva.es:31172/perrosGrandes.html"
direccionDinamica="http://virtual.lab.inf.uva.es:31172/phptest.php"
timeout=300
rm -r testRendimiento >/dev/null
mkdir testRendimiento
cd testRendimiento
for j in {1..5}
do
  mkdir "ejecucion"$j
  cd "ejecucion"$j
  mkdir imagenCorta
  cd imagenCorta
  echo "Pruebas en $direccionCorta"
  for i in {1..12}
  do
    nfich="IC"$i
    echo "Lanzando prueba $i con ${peticiones[$i-1]} peticiones y ${concurrentes[$i-1]} clientes"
    ab -k -s $timeout -n ${peticiones[$i-1]} -c ${concurrentes[$i-1]} $direccionCorta >$nfich
    echo "Completada prueba $i"
  done
  cd ..
  mkdir imagenGrande
  cd imagenGrande
  echo "Pruebas en $direccionLarga"
  for i in {1..12}
  do
    nfich="IC"$i
    echo "Lanzando prueba $i con ${peticiones[$i-1]} peticiones y ${concurrentes[$i-1]} clientes"
    ab -k  -s $timeout -n ${peticiones[$i-1]} -c ${concurrentes[$i-1]} $direccionLarga >$nfich
    echo "Completada prueba $i"
  done
  cd ..
  mkdir dinamica
  cd dinamica
  echo "Pruebas en $direccionDinamica"
  for i in {1..12}
  do
    nfich="IC"$i
    echo "Lanzando prueba $i con ${peticiones[$i-1]} peticiones y ${concurrentes[$i-1]} clientes"
    ab -k -s $timeout -n ${peticiones[$i-1]} -c ${concurrentes[$i-1]} $direccionDinamica >$nfich
    echo "Completada prueba $i"
  done
  cd ..
  cd ..
done
exit
