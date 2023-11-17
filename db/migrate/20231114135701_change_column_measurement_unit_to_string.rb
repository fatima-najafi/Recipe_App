class ChangeColumnMeasurementUnitToString < ActiveRecord::Migration[7.1]
  def change
    change_column :foods, :measurement_unit, :string
  end
end
