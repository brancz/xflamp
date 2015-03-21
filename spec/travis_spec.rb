describe XFLamp::TravisCI::Org do
  subject { XFLamp::TravisCI::Org.new({ 'projects' => ['flower-pot/xflamp'] }) }

  it '' do
    TravisStub.single_repo
    project = XFLamp::TravisCI::Project.new 'flower-pot/xflamp'
    expect(subject.project_green?(project)).to be true
  end
end

