require 'spec_helper'

class DependencyMockup
  include Codesake::Dawn::Kb::DependencyCheck

  def initialize
    message = "This is a mock"
    super(
      :kind=>Codesake::Dawn::KnowledgeBase::DEPENDENCY_CHECK, 
      :applies=>['sinatra', 'padrino', 'rails'],
      :message=> message
    )
    # self.debug = true

    self.safe_dependencies = [{:name=>'this_gem', :version=>['0.3.0', '1.3.3', '2.3.3', '2.4.2', '9.4.31.2']}]
  end
end


describe "The security check for gem dependency should" do
  before(:all) do
    @check = DependencyMockup.new
  end
  # let (:check) {Mockup.new}

  it "fires if vulnerable 0.2.9 version is detected" do
    @check.dependencies = [{:name=>"this_gem", :version=>'0.2.9'}]
    @check.vuln?.should    be_true
  end
  it "doesn't fire if not vulnerable 0.4.0 version is found" do
    @check.dependencies = [{:name=>"this_gem", :version=>'0.4.0'}]
    @check.vuln?.should    be_false
  end

  it "fires if vulnerable 1.3.2 version is found" do
    @check.dependencies = [{:name=>"this_gem", :version=>'1.3.2'}]
    @check.vuln?.should    be_true
  end

  it "doesn't fire if not vulnerable 1.4.2 version is found" do
    @check.dependencies = [{:name=>"this_gem", :version=>'1.4.2'}]
    @check.vuln?.should    be_false
  end

  it "fires when a non vulnerable version is found but there is a fixed version with higher minor release" do
    @check.dependencies = [{:name=>"this_gem", :version=>'2.3.3'}]
    @check.vuln?.should    be_true
  end
  it "should tell me there is a fixed version with 2 as major and 4 as minor release number" do
    @check.is_there_an_higher_minor_version?(['0.3.0', '1.3.3', '2.3.3', '2.4.2', '9.4.31.2'], '2.3.3').should  be_true
  end
  it "doesn't fires when a non vulnerable version is found and there is a fixed version with higher minor release but I asked to honor the minor version (useful with rails gem)" do
    @check.dependencies = [{:name=>"this_gem", :version=>'2.3.3'}]
    @check.save_minor_fixes = true
    @check.vuln?.should    be_false
  end
  it "fires when a vulnerable version (2.3.2) is found even if I asked to save minors..." do
    @check.dependencies = [{:name=>"this_gem", :version=>'2.3.2'}]
    @check.save_minor_fixes = true
    @check.vuln?.should    be_true

  end


end
