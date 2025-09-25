#!/bin/bash
# NOTE: This script requires a bash environment to run properly.
# On Windows, use one of the following:
# - Git Bash: bash generate_fmus.sh
# 
# If you're using PowerShell/CMD, use generate_fmus.ps1 or generate_fmus.bat instead
set -euo pipefail

N_WORKERS=8

# Insert your commands here
# #############
for cmd in \
    "uv run export-fmu models/ClaRaTester/SteamCycle_01.mo ./models/ClaRaTester/libraries.txt --CopyExternalResources" \
    "uv run export-fmu models/KoopmanTester/Tu_et_al/NonlinearModel.mo ./models/KoopmanTester/libraries.txt" \
    "uv run export-fmu models/KoopmanTester/chaotic_lorenz_system/chaoticLorenz.mo ./models/KoopmanTester/libraries.txt" \
    "uv run export-fmu models/SeriesResonanceTesters/SimpleSeriesResonance.mo ./models/SeriesResonanceTesters/libraries.txt" \
    "uv run export-fmu models/SeriesResonanceTesters/SimpleSeriesResonanceTwoDyn.mo ./models/SeriesResonanceTesters/libraries.txt" \
    "uv run export-fmu models/SeriesResonanceTesters/AdvancedSeriesResonance.mo ./models/SeriesResonanceTesters/libraries.txt" \
    "uv run export-fmu models/ThermalTesters/StratifiedHeatFlowModel.mo ./models/ThermalTesters/libraries.txt" \
    "uv run export-fmu models/ThermalTesters/ThreeStratifiedHeatFlowModels.mo ./models/ThermalTesters/libraries.txt"
do
    echo "Launching: $cmd"
    
    # Wait if we have too many jobs running
    while [ $(jobs -r | wc -l) -ge $N_WORKERS ]; do
        sleep 1
    done
    
    # Launch the job in background
    bash -c "$cmd" &
done

# wait for all remaining jobs
wait
echo "✅ All jobs finished."
