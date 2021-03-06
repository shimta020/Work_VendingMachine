# spec/rspec_helper.rb
# テスト対象をrequireする
require "./vend.rb"

# テスト本体
describe 'add' do
  it '1+1は2になること' do
    expect(add(1,1)).to eq 2
  end
end
teee
