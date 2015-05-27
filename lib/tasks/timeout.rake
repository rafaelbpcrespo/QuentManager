task :timeout => :environment do
  Pedido.timeout
  puts 'Cancelamentos realizados'
end