# ======================================================================================================================
# Initialize all variables to NA
# ======================================================================================================================
# $LOOP All:
#   {name}.l{sets} = NA;
# $ENDLOOP

# ======================================================================================================================
# Run exogenous_values part of each module
# ======================================================================================================================
@import_from_modules("exogenous_values")

# ======================================================================================================================
# Adjust for inflation and growth
# ======================================================================================================================
@inf_growth_adjust()

# ======================================================================================================================
# Define data groups
# ======================================================================================================================
$GROUP G_imprecise_data
  G_labor_market_data_imprecise$(tData[t])
  G_consumers_data_imprecise$(tData[t])
  G_production_private_data_imprecise$(tData[t])
  G_production_public_data_imprecise$(tData[t])
  G_IO_data_imprecise$(tData[t])
  G_government_data_imprecise$(tData[t])
  G_GovRevenues_data_imprecise$(tData[t])
  G_GovExpenses_data_imprecise$(tData[t])
  G_taxes_data_imprecise$(tData[t])
  G_finance_data_imprecise$(tData[t])
  G_HHincome_data_imprecise$(tData[t])
  G_aggregates_data_imprecise$(tData[t])
  G_struk_data_imprecise$(tData[t])
;

$GROUP G_data  # Variables covered by data that should not be changed by the calibration. 
  G_exports_data$(tData[t])
  G_labor_market_data$(tData[t])
  G_pricing_data$(tData[t])
  G_production_private_data$(tData[t])
  G_production_public_data$(tData[t])
  G_finance_data$(tData[t])
  G_consumers_data$(tData[t])
  G_government_data$(tData[t])
  G_GovRevenues_data$(tData[t])
  G_GovExpenses_data$(tData[t])
  G_taxes_data$(tData[t])
  G_aggregates_data$(tData[t])
  G_IO_data$(tData[t])
  G_HHincome_data$(tData[t])
  G_struk_data$(tData[t])

  G_imprecise_data # Denne bør være overflødig
;
$GROUP G_precise_data G_data, -G_imprecise_data;

# ======================================================================================================================
# Unload data
# ======================================================================================================================
@unload_all_nominal(Gdx\data_nominal);
@unload_all(Gdx\data);

# Save snapshot of all data, to check that all data is intact after calibration.
@set(G_data, _data, .l)