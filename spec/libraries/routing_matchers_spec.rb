RSpec.describe Spree::PossibleBlog, type: :model do
  context 'The route matcher' do
    let(:new_blog) {create(:blog)}
    it 'is true when valid page' do
      request = double('request', path: new_blog.permalink)
      expect(described_class.matches?(request)).to eq(true)
    end

    it 'ignores case' do
      request = double('request', path: new_blog.permalink.upcase)
      expect(described_class.matches?(request)).to eq(true)
    end

    it 'ignores leading slashes' do
      request = double('request', path: "/#{new_blog.permalink}")
      expect(described_class.matches?(request)).to eq(true)
    end

    it 'ignores trailing slashes' do
      request = double('request', path: "#{new_blog.permalink}/")
      expect(described_class.matches?(request)).to eq(true)
    end

    it 'is false when using reserved permalink name' do
      request = double('request', path: "login")
      expect(described_class.matches?(request)).to eq(false)
    end

    it 'is true when going to a valid subpage' do
      request = double('request', path: "#{new_blog.permalink}/archive")
      expect(described_class.matches?(request)).to eq(true)
    end
  end
end

RSpec.describe Spree::PossiblePage, type: :model do
  context 'The route matcher' do
    let(:new_page) {create(:page)}
    it 'is true when valid page' do
      request = double('request', path: new_page.path)
      expect(described_class.matches?(request)).to eq(true)
    end

    it 'correctly matches the root page' do
      create(:page, path: "/")
      request = double('request', path: "/")
      expect(described_class.matches?(request)).to eq(true)
    end

    it 'ignores case' do
      request = double('request', path: new_page.path.upcase)
      expect(described_class.matches?(request)).to be true
    end

    it 'ignores leading slashes' do
      request = double('request', path: "/#{new_page.path}")
      expect(described_class.matches?(request)).to be true
    end

    it 'ignores trailing slashes' do
      request = double('request', path: "#{new_page.path}/")
      expect(described_class.matches?(request)).to be true
    end

    it 'is false when using reserved slug name' do
      request = double('request', path: "login")
      expect(described_class.matches?(request)).to be false
    end
  end
end