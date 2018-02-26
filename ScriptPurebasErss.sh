#!/bin/bash

peticiones=(1000 1000 5000 5000 10000 10000 50000 50000 50000 100000 100000 100000)
concurrentes=(50 100 100 250 100 250 100 250 500 100 250 500)
direccionCorta="http://virtual.lab.inf.uva.es:31172/gatosPequenios.html"
direccionLarga="http://virtual.lab.inf.uva.es:31172/perrosGrandes.html"
direccionDinamica="http://virtual.lab.inf.uva.es:31172/phptest.php"
timeout=1000000
rm -r pruebas
mkdir pruebas
cd pruebas
mkdir imagenCorta
cd imagenCorta
echo "Pruebas en $direccionCorta"
for i in {1..12}
do
    nfich="IC"$i
    echo "Lanzando prueba $i con ${peticiones[$i-1]} peticiones y ${concurrentes[$i-1]} clientes"
    ab -n ${peticiones[$i-1]} -c ${concurrentes[$i-1]} -s $timeout -r $direccionCorta >$nfich
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
    ab -n ${peticiones[$i-1]} -c ${concurrentes[$i-1]} -s $timeout -r $direccionLarga >$nfich
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
    ab -n ${peticiones[$i-1]} -c ${concurrentes[$i-1]} -s $timeout -r $direccionDinamica >$nfich
    echo "Completada prueba $i"
done
exit