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
      context '購入操作' do
        it '何も購入しない' do
          @vm.slot_money(1000)
          @vm.n = -1
          vm_1 = @vm.purchase
          expect(vm_1).to eq 'ありがとうございました〜'
        end
        it '料金不足' do
          vm_2 = @vm.purchase
          expect(vm_2).to eq '料金不足です'
        end
        it '在庫切れ' do
          @vm.slot_money(1000)
          @vm.drink[0][:count] = 0
          @vm.n = 0
          vm_3 = @vm.purchase
          expect(vm_3).to eq '残念！在庫切れです...'
        end
        it 'cokeを一本購入' do
          @vm.slot_money(1000)
          @vm.n = 0
          @vm.purchase
          # binding.irb
          expect(@vm.drink[0][:count]).to eq 4
          expect(@vm.check_sales).to eq '現在の売り上げは120円です'
          expect(@vm.return_money).to eq 0
        end
      end
      context 'ドリンクを購入した場合(スロット機能発動)' do
        it '大当たり(１本無料サービス)' do
          @vm.num1 = 1
          @vm.num2 = 1
          @vm.draw_lots
          @vm.n = 0
          vm_4 = @vm.check_stock
          expect(@vm.drink[0][:count]).to eq 4
        end
        it 'ハズレ' do
          @vm.slot_money(1000)
          @vm.num1 = 1
          @vm.num2 = 2
          expect(@vm.draw_lots).to eq '残念ハズレです...'
          expect(@vm.drink[0][:count]).to eq 5
        end
      end
    end
