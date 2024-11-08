#!/usr/bin/env bash

GALAXY_SLOTS=$1

echo "===================================================================="
echo "     Create Config machine for CESM                                 "
echo "     Tool will be running with $GALAXY_SLOTS processors (MPI tasks) "
echo "===================================================================="


cat > config_machines_galaxy.xml << EOF
<?xml version="1.0"?>
<config_machines>
  <machine MACH="galaxy">
    <DESC>
          VM
          x4 CPUs
          Gold Centos 7
    </DESC>
    <NODENAME_REGEX>UNSET</NODENAME_REGEX>
    <OS>LINUX</OS>
    <PROXY>UNSET</PROXY>
    <COMPILERS>gnu</COMPILERS>
    <MPILIBS>mpich</MPILIBS>
    <SAVE_TIMING_DIR>UNSET</SAVE_TIMING_DIR>
    <CIME_OUTPUT_ROOT>\$ENV{HOME}/work</CIME_OUTPUT_ROOT>
    <DIN_LOC_ROOT>\$ENV{HOME}/inputdata</DIN_LOC_ROOT>
    <DIN_LOC_ROOT_CLMFORC>\$ENV{HOME}/inputdata/atm/datm7</DIN_LOC_ROOT_CLMFORC>
    <DOUT_S_ROOT>\$ENV{HOME}/archive/\$CASE</DOUT_S_ROOT>
    <BASELINE_ROOT>UNSET</BASELINE_ROOT>
    <CCSM_CPRNC>UNSET</CCSM_CPRNC>
    <GMAKE>make</GMAKE>
    <GMAKE_J>$GALAXY_SLOTS</GMAKE_J>
    <BATCH_SYSTEM>none</BATCH_SYSTEM>
    <SUPPORTED_BY>nobody</SUPPORTED_BY>
    <MAX_TASKS_PER_NODE>$GALAXY_SLOTS</MAX_TASKS_PER_NODE>
    <MAX_MPITASKS_PER_NODE>$GALAXY_SLOTS</MAX_MPITASKS_PER_NODE>
    <PROJECT_REQUIRED>FALSE</PROJECT_REQUIRED>
    <mpirun mpilib="default">
      <executable>mpiexec</executable>
      <arguments>
        <arg name="anum_tasks"> -np \$TOTALPES</arg>
      </arguments>
    </mpirun>
    <module_system type="none"/>
    <environment_variables>
      <env name="KMP_STACKSIZE">64M</env>
    </environment_variables>
    <resource_limits>
      <resource name="RLIMIT_STACK">-1</resource>
    </resource_limits>
  </machine>
</config_machines>
EOF

echo "Configuration machine created."
