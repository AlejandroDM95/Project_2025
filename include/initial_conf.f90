subroutine gen_initial_conf(lattice_type, system_size, part_num, part_density, positions)
    implicit none

    integer, intent(in) ::  part_num
    real, intent(in) :: part_density
    character(5), intent(in) :: lattice_type
    real, intent(out) :: system_size
    real, allocatable, intent(out) :: positions(:, :)

    integer :: i, j, k, uc_onedim, part_index
    real :: lattice_spacing

    print *, 'Initializing configuration for ', trim(lattice_type), ' lattice...'

    allocate(positions(part_num, 3))

    ! Generate the specified lattice type for the specified number of atoms with
    ! the specified particle density.
    select case (trim(lattice_type))
        ! Simple cubic lattice.
        case("SC")

            ! Lattice parameters.
            uc_onedim = int(part_num**(1./3.))
            system_size = (part_num/part_density)**(1./3.)
            lattice_spacing = system_size/uc_onedim

            part_index = 1
            do i = 1, uc_onedim
                do j = 1, uc_onedim
                    do k = 1, uc_onedim
                        positions(part_index, 1) = i - 1
                        positions(part_index, 2) = j - 1
                        positions(part_index, 3) = k - 1

                        part_index = part_index + 1
                    end do
                end do
            end do

        ! Body-centered cubic lattice.
        case("BCC")

            ! Lattice parameters.
            uc_onedim = int((part_num/2)**(1./3.))
            system_size = (part_num/part_density)**(1./3.)
            lattice_spacing = system_size/uc_onedim

            part_index = 1
            do i = 1, uc_onedim
                do j = 1, uc_onedim
                    do k = 1, uc_onedim
                        positions(part_index, 1) = i - 1
                        positions(part_index, 2) = j - 1
                        positions(part_index, 3) = k - 1

                        part_index = part_index + 1

                        ! Add central atom
                        positions(part_index, 1) = i - 1 + 0.5
                        positions(part_index, 2) = j - 1 + 0.5
                        positions(part_index, 3) = k - 1 + 0.5

                        part_index = part_index + 1
                    end do
                end do
            end do

        case default
            print *, 'Invalid value for lattice_type: ', lattice_type
            stop
    end select

    positions(:, :) = lattice_spacing * positions(:, :)
end subroutine gen_initial_conf
