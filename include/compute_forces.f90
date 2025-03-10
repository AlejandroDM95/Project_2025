subroutine compute_forces(part_num, positions, forces, system_size)
    implicit none
    integer, intent(in) :: part_num
    real, intent(in) :: positions(3, part_num)
    real, intent(in) :: system_size
    real, intent(out) :: forces(3, part_num)
    
    integer :: i, j, k
    real :: r, r2, f
    real :: r_vec(3)

    !en unidades reducidas: epsilon = sigma = 1.
    !inicializar vector de fuerzas 
    forces = 0.0

    do i = 1, part_num - 1
        do j = i + 1, part_num
            ! Calcular el vector de desplazamiento entre las partículas i y j.
            r_vec(1) = positions(1, i) - positions(1, j)
            r_vec(2) = positions(2, i) - positions(2, j)
            r_vec(3) = positions(3, i) - positions(3, j)
            
            !aplicar pbc
            do k = 1, 3
                r_vec(k) = pbc(r_vec(k), system_size)
            end do
            
            r2 = r_vec(1)**2 + r_vec(2)**2 + r_vec(3)**2
            r = sqrt(r_sq)
            
            if (r > 0.0) then
                f = 48.0 / (r**14) - 24.0 / (r**8)
            else
            !evitar division entre 0
                f = 0.0
            end if

            !actualizar las fuerzas
            forces(1, i) = forces(1, i) + f * r_vec(1)
            forces(2, i) = forces(2, i) + f * r_vec(2)
            forces(3, i) = forces(3, i) + f * r_vec(3)
            
            forces(1, j) = forces(1, j) - f * r_vec(1)
            forces(2, j) = forces(2, j) - f * r_vec(2)
            forces(3, j) = forces(3, j) - f * r_vec(3)
        end do
    end do
end subroutine compute_forces
