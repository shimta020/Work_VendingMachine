# rspec ./spec/rspec_vend.rb
# ☝rspec実施する際のコマンド

# テスト対象をrequireする
require "./vend.rb"

describe 'Drink' do
  context 'redbull' do
    it 'redbull_name' do
      expect(Drink.redbull.name).to eq "redbull"
    end
    it 'redbull_price' do
      expect(Drink.redbull.price).to eq 200
    end
    it 'redbull_count' do
      expect(Drink.redbull.count).to eq 5
    end
  end
end

describe 'VendingMachine' do
  before do
    @vm = VendingMachine.new
  end
  # let(:vm){ VendingMachine.new }

  context 'お金を投入した場合' do
    it '1000円投入した場合、投入金額に加算される' do
     expect(@vm.slot_money(1000)).to eq 1000
     expect(@vm.sum_money).to eq 1000
    end
    it '10000円投入した場合、投入金額に加算されない' do
     expect(@vm.slot_money(10000)).to eq 10000
     expect(@vm.sum_money).to eq 0
    end
   end
  context 'お金を返金した場合' do
      it '何も購入していなかったら、投入金額が返される' do
       @vm.slot_money(1000)
       expect(@vm.return_money).to eq 0
      end
     end
     context 'ドリンクの在庫を確認した場合' do
       it '初期値はコーラのみ買える' do
        drink = @vm.check_stock
        # binding.irb
        expect(drink[0][:name]).to eq "coke"
        expect(drink[0][:price]).to eq 120
        expect(drink[0][:count]).to eq 5
       end
        it 'redbullを追加したら、redbullも買える' do
         @vm.add_drink(Drink.redbull)
         drink = @vm.check_stock
         expect(drink[1][:name]).to eq "redbull"
         expect(drink[1][:price]).to eq 200
         expect(drink[1][:count]).to eq 5
      end
    end
      # context 'purchase' do
      #   it 'cokeを1本購入した場合' do
      #    @vm.slot_money(1000)
      #    n = 1
      #    @vm.purchase
      #     binding.irb
      #
      #    vm_b = @vm.purchase
      #    # binding.irb
      #
      #     n = 1
      #     drink = @vm
      #
      #    expect(drink.drink[0][:name]).to eq "coke"
      #    expect(drink[0][:price]).to eq 120
      #    expect(drink[0][:count]).to eq 5
      #   end
      #  end
  end
