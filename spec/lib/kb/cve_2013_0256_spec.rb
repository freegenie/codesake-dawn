require 'spec_helper'
describe "The CVE-2013-0256 vulnerability" do
	before(:all) do
		@check = Codesake::Dawn::Kb::CVE_2013_0256.new
		# @check.debug = true
	end
  it "fires when vulnerable ruby (1.9.3-p382) and rdoc version (2.3.0) has been found" do
    @check.options={:detected_ruby=>{:engine=>"ruby", :version=>"1.9.3", :patchlevel=>"381"}, :dependencies=>[{:name=>"rdoc", :version=>'2.3.0'}, :root_dir=>"."]}
    @check.vuln?.should   be_true
  end
  it "fires when vulnerable ruby (1.9.2-p342) and rdoc version (2.3.0) has been found" do
    @check.options={:detected_ruby=>{:engine=>"ruby", :version=>"1.9.2", :patchlevel=>"342"}, :dependencies=>[{:name=>"rdoc", :version=>'2.3.0'}, :root_dir=>"."]}
    @check.vuln?.should   be_true
  end

  it "fires when vulnerable ruby (1.9.3-p382) and rdoc version (3.12) has been found" do
    @check.options={:detected_ruby=>{:engine=>"ruby", :version=>"1.9.3", :patchlevel=>"381"}, :dependencies=>[{:name=>"rdoc", :version=>'3.12'}, :root_dir=>"."]}
    @check.vuln?.should   be_true
  end
  it "fires when vulnerable ruby (1.9.2-p342) and rdoc version (3.12) has been found" do
    @check.options={:detected_ruby=>{:engine=>"ruby", :version=>"1.9.2", :patchlevel=>"342"}, :dependencies=>[{:name=>"rdoc", :version=>'3.12'}, :root_dir=>"."]}
    @check.vuln?.should   be_true
  end

  it "doesn't fire when not vulnerable ruby (1.9.3-p383) is found but vulnerable rdoc version (3.12) has been found" do
    @check.options={:detected_ruby=>{:engine=>"ruby", :version=>"1.9.2", :patchlevel=>"342"}, :dependencies=>[{:name=>"rdoc", :version=>'3.99'}, :root_dir=>"."]}
    @check.vuln?.should   be_false
  end

  it "doesn't fire when vulnerable ruby (1.9.3-p382) is found but not vulnerable rdoc version (3.13) has been found" do
    @check.options={:detected_ruby=>{:engine=>"ruby", :version=>"1.9.3", :patchlevel=>"322"}, :dependencies=>[{:name=>"rdoc", :version=>'3.13'}, :root_dir=>"."]}
    @check.vuln?.should   be_false
  end

          # self.safe_dependencies = [{:name=>"rdoc", :version=>['2.3.1', '3.13', '4.0.0']}]

          # self.safe_rubies = [
          #   {:engine=>"ruby", :version=>"1.9.3", :patchlevel=>"p383"}, 
          #   {:engine=>"ruby", :version=>"2.0.0", :patchlevel=>"p0"}
          # ]
end
