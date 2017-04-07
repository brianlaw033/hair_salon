class Stylist

  attr_reader(:id, :name)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  def self.all()
    returned_stylists = DB.exec('SELECT * FROM stylists ORDER BY name ASC;')
    stylists = []
    returned_stylists.each do |stylist|
      name = stylist.fetch('name')
      id = Integer(stylist.fetch('id'))
      stylists.push(Stylist.new({:id => id, :name => name}))
    end
    stylists
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM stylists WHERE id = #{id};")
    name = result.first.fetch('name')
    Stylist.new({:id => id, :name => name})
  end

  def save()
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = Integer(result.first.fetch('id'))
  end

  def ==(another_stylist)
    self.name == another_stylist.name && self.id == another_stylist.id
  end

  def update(name)
    DB.exec("UPDATE stylists SET name = '#{name}' WHERE id = #{self.id()};")
  end

  def clients()
    clients_list = []
    results = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id};")
    results.each do |result|
      name = result.fetch('name')
      id = Integer(result.fetch('id'))
      stylist_id = Integer(result.fetch('stylist_id'))
      clients_list.push(Client.new({:id => id, :name => name, :stylist_id => stylist_id}))
    end
    clients_list
  end

  def delete()
    DB.exec("DELETE FROM stylists WHERE id = #{self.id};")
    DB.exec("DELETE FROM clients WHERE stylist_id = #{self.id};")
  end
end
