shared_examples 'api_goodies gem is_soft_deletable' do
  describe ".active" do
    it "returns all records which 'deleted' column is set to false" do
      active = build_valid_model
      active.deleted = false
      active.save!

      inactive = build_valid_model
      inactive.deleted = true
      inactive.save!

      described_class.active.should == [active]
    end
  end

  describe "#soft_delete" do
    it "sets the 'deleted' attribute to true" do
      model = build_valid_model
      model.save!
      model.soft_delete
      model.should be_deleted
    end

    it "sets assigns a time to 'deleted_at'" do
      model = build_valid_model
      model.save!
      model.soft_delete
      model.deleted_at.should_not be_nil
    end

    it "doesn't delete the record from the database" do
      model = build_valid_model
      model.save!
      model.soft_delete
      model.should be_persisted
    end
  end

  begin
    ActiveRecord::Base.attr_protected

    describe "mass assignment protection" do
      before { subject.class.mass_assignment_sanitizer = :strict }

      it "should protect 'deleted' from mass assignment" do
        lambda do
          subject.update_attributes(deleted: true)
        end.should raise_exception ActiveModel::MassAssignmentSecurity::Error
      end

      it "should protect 'deleted_at' from mass assignment" do
        lambda do
          subject.update_attributes(deleted_at: Time.now)
        end.should raise_exception ActiveModel::MassAssignmentSecurity::Error
      end
    end
  rescue RuntimeError => e
    raise e if e.message !~ /`attr_protected`/
  end
end
