shared_examples 'api_goodies gem has_and_belongs_to_many_with' do |attribute, association|
  let(:association_attribute) { :"#{association.to_s.singularize}_#{attribute.to_s.pluralize}" }
  let(:association_ids) { :"#{association.to_s.singularize}_ids" }

  it 'creates an attr_writer for attribute named <assocation_name>_<attribute_name pluralized>' do
    subject.respond_to?(:"#{association_attribute}=").should == true
  end

  it 'creates a method named <assocation_name>_<attribute_name plurazlied> that returns <association>.map &<attribute>' do
    baz1 = create_valid_model(association)
    baz2 = create_valid_model(association)
    subject.attributes = {association => [baz1, baz2]}
    subject.send(association_attribute).should == [baz1.send(attribute), baz2.send(attribute)]
  end

  it 'searches the associated class by <attribute_name pluralized>' do
    baz1 = create_valid_model(association)
    baz2 = create_valid_model(association)
    subject.attributes = {association_attribute => [baz1.send(attribute), baz2.send(attribute)]}
    subject.send(association_attribute).should == [baz1.send(attribute), baz2.send(attribute)]
  end

  it 'gives precendence to *_<attribute_name pluralized> over *_ids' do
    baz1 = create_valid_model(association)
    baz2 = create_valid_model(association)
    subject.attributes = {association => [baz1], association_attribute => [baz2.send(attribute)]}
    subject.send(association).to_a.should == [baz2]
  end

  describe 'before_validation' do
    it 'sets (or overwrites) *_id from *_<attribute_name>' do
      baz1 = create_valid_model(association)
      baz2 = create_valid_model(association)
      subject.attributes = {association => [baz1], association_attribute => [baz2.send(attribute)]}
      subject.send(association_ids).should == [baz1.id]
      subject.valid?
      subject.send(association_ids).should == [baz2.id]
    end

    it 'does not clear *_id if *_<attribute_name> is nil' do
      baz = create_valid_model(association)
      subject.attributes = {association_ids => [baz.id], association_attribute => nil}
      subject.send(association_ids).should == [baz.id]
      subject.valid?
      subject.send(association_ids).should == [baz.id]
    end
  end
end
