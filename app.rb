require("sinatra")
  require("sinatra/reloader")
  also_reload("lib/**/*.rb")
  require("./lib/stylist")
  require("./lib/client")
  require('pry')
  require("pg")

  DB = PG.connect({:dbname => "hair_salon"})

  get("/") do
    @stylists = Stylist.all()
    @clients = Client.all()
    erb(:index)
  end

  get("/new/stylist") do
    erb(:new_stylist)
  end

  post("/new/stylist") do
    name = params.fetch('name')
    Stylist.new({:name => name, :id => nil}).save()
    redirect to ('/')
  end

  get("/stylists/:id") do
    id = Integer(params.fetch('id'))
    @stylist = Stylist.find(id)
    @clients = @stylist.clients()
    erb(:stylist)
  end

  patch ("/update/stylist/:id") do
    id = Integer(params.fetch('id'))
    name = params.fetch("name")
    stylist = Stylist.find(id)
    stylist.update(name)
    redirect to ("/stylists/#{id}")
  end

  delete ("/delete/stylist/:id") do
    id = Integer(params.fetch('id'))
    stylist = Stylist.find(id)
    stylist.delete()
    redirect to ('/')
  end

  post("/new/client/:id") do
    stylist_id = Integer(params.fetch('id'))
    name = params.fetch('name')
    Client.new({:name => name, :id => nil, :stylist_id => stylist_id}).save()
    redirect to ("/stylists/#{stylist_id}")
  end

  get("/clients/:id") do
    id = Integer(params.fetch('id'))
    @client = Client.find(id)
    @stylist = @client.stylists()
    erb(:client)
  end

  patch ("/update/client/:id") do
    id = Integer(params.fetch('id'))
    name = params.fetch("name")
    client = Client.find(id)
    client.update(name)
    redirect to ("/clients/#{id}")
  end

  delete ("/delete/client/:id") do
    id = Integer(params.fetch('id'))
    client = Client.find(id)
    client.delete()
    redirect to ('/')
  end
