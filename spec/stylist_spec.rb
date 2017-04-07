require('spec_helper')
require('pry')

describe(Stylist) do

  before() do
    @stylist = Stylist.new({:name => "Brian", :id => nil})
    @stylist2 = Stylist.new({:name => "Brian2", :id => nil})
    @client = Client.new({:id => nil, :name => 'Client', :stylist_id => @stylist.id()})
    @client2 = Client.new({:id => nil, :name => 'Client2', :stylist_id => @stylist.id()})
  end

  describe('#all') do
    it('start off with no stylists') do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a station by its ID number") do
      @stylist.save()
      @stylist2.save()
      expect(Stylist.find(@stylist2.id)).to(eq(@stylist2))
    end
  end

  describe("#==") do
    it("is the same station if it has the same name and id") do
      expect(@stylist).to(eq(@stylist))
    end
  end

  describe("#save") do
    it("lets you save lists to the database") do
      @stylist.save()
      expect(Stylist.all()).to(eq([@stylist]))
    end
  end

  describe('#update') do
    it("lets yuo update the name of the stylist") do
      @stylist.save()
      @stylist.update('Nanase')
      expect(Stylist.find(@stylist.id).name).to(eq('Nanase'))
    end
  end

  describe ('#clients') do
    it("returns an array of clients for that stylist") do
      @stylist.save()
      client = Client.new({:id => nil, :name => 'Client', :stylist_id => @stylist.id()})
      client.save()
      client2 = Client.new({:id => nil, :name => 'Client', :stylist_id => @stylist.id()})
      client2.save()
      expect(@stylist.clients()).to(eq([client, client2]))
    end
  end

end
