require 'requirements'

describe "HumanPlayer getting promotion inputs" do
let(:human) { HumanPlayer.new }

  it "returns 'queen' when queen is entered." do
    allow(human).to receive(:gets) {"queen"}
    expect(human.get_promotion_choice).to eq(Queen)
  end

end
