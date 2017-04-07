class Client
  attr_reader(:id, :name, :stylist_id)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @stylist_id = attributes.fetch(:stylist_id)
  end

  def self.all()
    returned_clients = DB.exec('SELECT * FROM clients ORDER BY name ASC;')
    clients = []
    returned_clients.each do |client|
      name = client.fetch('name')
      id = Integer(client.fetch('id'))
      stylist_id = Integer(client.fetch('stylist_id'))
      clients.push(Client.new({:id => id, :name => name, :stylist_id => stylist_id}))
    end
    clients
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM clients WHERE id = #{id};")
    name = result.first.fetch('name')
    stylist_id = Integer(result.first.fetch('stylist_id'))
    Client.new({:id => id, :name => name, :stylist_id => stylist_id})
  end

  def save()
    result= DB.exec("INSERT INTO clients (name, stylist_id) VALUES ('#{@name}', #{@stylist_id}) RETURNING id;")
    @id = result.first.fetch('id')
  end

  def ==(another_client)
    self.name().==(another_client.name()).&(self.stylist_id().==(another_client.stylist_id()))
  end

  def update(name)
    DB.exec("UPDATE clients SET name = '#{name}' WHERE id = #{self.id()};")
  end

  def stylists()
    results = DB.exec("SELECT * FROM stylists WHERE id = #{self.stylist_id};")
    name = results.first.fetch('name')
    result = Stylist.new({:name => name, :id => self.stylist_id})
    result
  end

  def delete()
    DB.exec("DELETE FROM clients WHERE id = #{self.id};")
  end
end
