require 'spec_helper'

describe SubCategory do
  let!(:sub_category0) { create(:sub_category) }
  let!(:sub_category1) do
    create(:sub_category,
      {
        parent_id: sub_category0.id,
        depth: 1
      }
    )
  end
  let!(:sub_category2) do
    create(:sub_category,
      {
        parent_id: sub_category1.id,
        depth: 2
      }
    )
  end

  describe 'destroy' do
    context 'when top-most sub_category is destroyed' do
      before(:each) do
        sub_category0.destroy
        sub_category1.reload
        sub_category2.reload
      end

      it 'should lessen the depth of all the destroyed sub_categorys descendants by 1' do
        expect(sub_category1.depth).to be_eql(0)
        expect(sub_category2.depth).to be_eql(1)
      end
    end
  end
end
