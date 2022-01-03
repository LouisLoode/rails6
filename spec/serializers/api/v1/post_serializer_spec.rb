RSpec.describe Api::V1::PostSerializer do
  describe '#as_json' do
    let!(:post) { create(:post) }
    subject { JSON.parse(described_class.new(post).to_json)['data']['attributes'] }

    it 'includes attributes' do  
      expect(subject).to match(
        JSON.parse(
          {
            title: post.title,
            body: post.body,
            published_at: post.published_at,
            created_at: post.created_at,
            updated_at: post.updated_at
          }.to_json
        )
      )
    end
  end
end
