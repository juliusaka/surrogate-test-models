#!/bin/bash
# run this in git bash terminal to generate all fmus
# git bash: bash generate_fmus.sh

uv run export-fmu models/ClaRaTester/SteamCycle_01.mo ./models/ClaRaTester/libraries.txt --CopyExternalResources
uv run export-fmu models/KoopmanTester/Tu_et_al/NonlinearModel.mo ./models/KoopmanTester/libraries.txt
uv run export-fmu models/KoopmanTester/chaotic_lorenz_system/chaoticLorenz.mo ./models/KoopmanTester/libraries.txt
uv run export-fmu models/SeriesResonanceTesters/SimpleSeriesResonance.mo ./models/SeriesResonanceTesters/libraries.txt
uv run export-fmu models/SeriesResonanceTesters/SimpleSeriesResonanceTwoDyn.mo ./models/SeriesResonanceTesters/libraries.txt
uv run export-fmu models/SeriesResonanceTesters/AdvancedSeriesResonance.mo ./models/SeriesResonanceTesters/libraries.txt
uv run export-fmu models/ThermalTesters/StratifiedHeatFlowModel.mo ./models/ThermalTesters/libraries.txt
uv run export-fmu models/ThermalTesters/ThreeStratifiedHeatFlowModels.mo ./models/ThermalTesters/libraries.txt
