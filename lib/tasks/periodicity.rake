desc 'Create default Dues'
task create_dues: :environment do

  dues = [
    {
      name: 'Diario',
      periodicity: 1,
      interests: 0
    },
    {
      name: 'Semanal',
      periodicity: 8,
      interests: 0
    },
    {
      name: 'Quincenal',
      periodicity: 15,
      interests: 0
    },
    {
      name: 'Mensual',
      periodicity: 30,
      interests: 0
    }
  ]
  p "################# creating dues #################"
  dues.each_with_index do |item, index|
    Due.create!(id: (index+1), name: item[:name], periodicity: item[:periodicity], interests: item[:interests])
  end
end
