require "spec_helper"

RSpec.describe PriorityQueue do
  describe "#initialize" do
    it { expect(PriorityQueue.new).to be_a(PriorityQueue) }
    it { expect(PriorityQueue.new([])).to be_a(PriorityQueue) }
    it { expect(PriorityQueue.new([1, 2, 3])).to be_a(PriorityQueue) }
    it { expect(PriorityQueue.new([[1, "first"], [2, "second"]])).to be_a(PriorityQueue) }
    it { expect { PriorityQueue.new("ad") }.to raise_error(ArgumentError) }
    it { expect { PriorityQueue.new(heap_type: :maximum) }.to raise_error(ArgumentError) }
  end

  context "when each node is integer" do
    context "with min heap" do
      it "works expectedly" do
        pq = PriorityQueue.new([3, 2, 9], heap_type: :min)
        expect(pq.pop).to eq 2
        expect(pq.pop).to eq 3
        pq.push(1)
        pq.push(5)
        pq.push(1)
        pq.push(14)
        expect(pq.pop).to eq 1
        expect(pq.pop).to eq 1
        expect(pq.pop).to eq 5
        expect(pq.pop).to eq 9
        expect(pq.pop).to eq 14
        expect(pq.pop).to be_nil
        pq.push(1)
        expect(pq.pop).to eq 1
      end
    end

    context "with max heap" do
      it "works expectedly" do
        pq = PriorityQueue.new([3, 2, 9], heap_type: :max)
        expect(pq.pop).to eq 9
        expect(pq.pop).to eq 3
        pq.push(14)
        pq.push(5)
        pq.push(1)
        pq.push(14)
        expect(pq.pop).to eq 14
        expect(pq.pop).to eq 14
        expect(pq.pop).to eq 5
        expect(pq.pop).to eq 2
        expect(pq.pop).to eq 1
        expect(pq.pop).to be_nil
        pq.push(1)
        expect(pq.pop).to eq 1
      end
    end
  end

  context "when each node is array" do
    let(:n1) { [1, [1, "first"]] }
    let(:n2) { [2, [2, "second"]] }
    let(:n3) { [3, [3, "third"]] }
    let(:n4) { [4, [4, "forth"]] }
    let(:n5) { [5, [5, "five"]] }

    context "with min heap" do
      it "works expectedly" do
        pq = PriorityQueue.new([n1, n5], heap_type: :min)
        expect(pq.pop).to eq n1
        expect(pq.pop).to eq n5
        expect(pq.pop).to be_nil
        pq.push(n5)
        pq.push(n1)
        pq.push(n3)
        pq.push(n1)
        expect(pq.pop).to eq n1
        expect(pq.pop).to eq n1
        expect(pq.pop).to eq n3
        expect(pq.pop).to eq n5
        expect(pq.pop).to be_nil
      end
    end
    context "with max heap" do
      it "works expectedly" do
        pq = PriorityQueue.new([n1, n5], heap_type: :max)
        expect(pq.pop).to eq n5
        expect(pq.pop).to eq n1
        expect(pq.pop).to be_nil
        pq.push(n5)
        pq.push(n1)
        pq.push(n3)
        pq.push(n5)
        expect(pq.pop).to eq n5
        expect(pq.pop).to eq n5
        expect(pq.pop).to eq n3
        expect(pq.pop).to eq n1
        expect(pq.pop).to be_nil
      end
    end
  end

  describe "#size, #length" do
    let(:pq0) { PriorityQueue.new }
    let(:pq3) { PriorityQueue.new([1, 2, 3]) }
    it { expect(pq0.size).to eq 0 }
    it { expect(pq0.length).to eq 0 }
    it { expect(pq3.size).to eq 3 }
    it { expect(pq3.length).to eq 3 }
  end

  describe "#empty?" do
    it { expect(PriorityQueue.new.empty?).to be_truthy }
  end
end
