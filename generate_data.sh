# This script generates data for surrogate models using the FMUs in the repository.
# Add the scripts here
echo "Generating data..."
# # ClaRa Tester (Steam Cycle) # # 
uv run data_generation pModel=SteamCycle01
uv run data_preperation pModel=SteamCycle01 pModel.dataset_prep.parameters_remove=true
uv run data_generation pModel=SteamCycle01 pModel.RawData.controls_sampling_strategy=RS
uv run data_preperation pModel=SteamCycle01 pModel.RawData.controls_sampling_strategy=RS pModel.dataset_prep.test_fraction=1.0 pModel.dataset_prep.validation_fraction=0.0 pModel.dataset_prep.parameters_remove=true
# # Koopman Tester # # 
uv run data_generation pModel=chaoticLorentz
uv run data_preperation pModel=chaoticLorentz pModel.dataset_prep.parameters_remove=true
uv run data_generation pModel=KoopmanTu
uv run data_preperation pModel=KoopmanTu pModel.dataset_prep.parameters_remove=true
# # Mechanical Tester # #
uv run data_generation pModel=CartPole
uv run data_preperation pModel=CartPole pModel.dataset_prep.parameters_remove=true
# # Series Resonance Tester # #
uv run data_generation pModel=SimpleSeriesResonance
uv run data_preperation pModel=SimpleSeriesResonance pModel.dataset_prep.parameters_remove=true
uv run data_generation pModel=SimpleSeriesResonanceTwoDyn
uv run data_preperation pModel=SimpleSeriesResonanceTwoDyn pModel.dataset_prep.parameters_remove=true
# # # # generate more data with other sampling strateiges for simple series resonance
uv run data_generation pModel=SimpleSeriesResonance pModel.RawData.controls_sampling_strategy=RS pModel.RawData.n_samples=100
uv run data_preperation pModel=SimpleSeriesResonance pModel.RawData.controls_sampling_strategy=RS pModel.RawData.n_samples=100 pModel.dataset_prep.test_fraction=1.0 pModel.dataset_prep.validation_fraction=0.0 pModel.dataset_prep.parameters_remove=true
uv run data_generation pModel=SimpleSeriesResonance pModel.RawData.controls_sampling_strategy=RF pModel.RawData.n_samples=100
uv run data_preperation pModel=SimpleSeriesResonance pModel.RawData.controls_sampling_strategy=RF pModel.RawData.n_samples=100 pModel.dataset_prep.test_fraction=1.0 pModel.dataset_prep.validation_fraction=0.0 pModel.dataset_prep.parameters_remove=true
uv run data_generation pModel=SimpleSeriesResonance pModel.RawData.controls_include=false pModel.RawData.initial_states_include=true pModel.dataset_prep.start_time=0.0
uv run data_preperation pModel=SimpleSeriesResonance pModel.RawData.controls_include=false pModel.RawData.initial_states_include=true pModel.dataset_prep.start_time=0.0 pModel.dataset_prep.parameters_remove=true
# # Thermal Testers (Stratified Heat Flow, SHF)
uv run data_generation pModel=SHF
uv run data_preperation pModel=SHF pModel.dataset_prep.parameters_remove=true
uv run data_generation pModel=SHF_three
uv run data_preperation pModel=SHF_three pModel.dataset_prep.parameters_remove=true
# # # # generate more data with other sampling strategies for SHF
uv run data_generation pModel=SHF pModel.RawData.parameters_include=true
uv run data_preperation pModel=SHF pModel.RawData.parameters_include=true
uv run data_generation pModel=SHF pModel.RawData.controls_sampling_strategy=RS pModel.RawData.n_samples=100 pModel.dataset_prep.parameters_remove=true
uv run data_preperation pModel=SHF pModel.RawData.controls_sampling_strategy=RS pModel.RawData.n_samples=100 pModel.dataset_prep.test_fraction=1.0 pModel.dataset_prep.validation_fraction=0.0 pModel.dataset_prep.parameters_remove=true
echo "Data generation complete."
