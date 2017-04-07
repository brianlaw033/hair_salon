require('spec_helper')

describe(Client) do

  before() do
    @stylist = Stylist.new({:name => "Brian", :id => nil})
    @client = Client.new({:id => nil, :name => 'Client', :stylist_id => 1})
    @client2 = Client.new({:id => nil, :name => 'Client2', :stylist_id => 1})
  end

  describe('#all') do
    it('start off with no clients') do
      expect(Client.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a client by its ID number") do
      @client.save()
      @client2.save()
      expect(Client.find(@client2.id)).to(eq(@client2))
    end
  end

  describe("#==") do
    it("is the same client if it has the same name and id") do
      expect(@client).to(eq(@client))
    end
  end

  describe("#save") do
    it("lets you save lists to the database") do
      @client.save()
      expect(Client.all()).to(eq([@client]))
    end
  end

  describe('#update') do
    it("lets yuo update the name of the stylist") do
      @client.save()
      @client.update('Nanase')
      expect(Client.find(@client.id).name).to(eq('Nanase'))
    end
  end
end
