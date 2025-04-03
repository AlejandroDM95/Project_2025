!
! global_vars.f90
! Molecular Dynamics Simulation of a Van der Waals Gas
! Ricard Rodriguez
!

module global_vars
    implicit none

    integer :: part_num, step_num, equilibration_step_num
    character(2) :: atom_type
    character(3) :: test_mode
    character(6) :: lattice_type
    real :: system_size, timestep, temperature, collision_frequence, cutoff

    real, parameter :: pi = 3.14159265358979
end module global_vars
