# This script generates data for surrogate models using the FMUs in the repository.
# Add the scripts here
echo "Generating data..."
# # ClaRa Tester (Steam Cycle) # # 
uv run data_generation pModel=SteamCycle01
uv run data_preperation pModel=SteamCycle01
uv run data_generation pModel=SteamCycle01 pModel.RawData.controls_sampling_strategy=RS
uv run data_preperation pModel=SteamCycle01 pModel.RawData.controls_sampling_strategy=RS pModel.dataset_prep.test_fraction=1.0 pModel.dataset_prep.validation_fraction=0.0
# # Koopman Tester # # 
uv run data_generation pModel=chaoticLorentz
uv run data_preperation pModel=chaoticLorentz
uv run data_generation pModel=KoopmanTu
uv run data_preperation pModel=KoopmanTu
# # Mechanical Tester # #
uv run data_generation pModel=CartPole
uv run data_preperation pModel=CartPole
# # Series Resonance Tester # #

