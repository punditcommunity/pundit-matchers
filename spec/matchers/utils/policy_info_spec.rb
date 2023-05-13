# frozen_string_literal: true

RSpec.describe Pundit::Matchers::Utils::PolicyInfo do
  subject(:policy_info) { described_class.new(policy) }

  let(:policy_class) do
    Class.new(TestPolicy) do
      def update?
        false
      end

      def create?
        true
      end

      def new?
        true
      end
    end
  end

  let(:policy) { policy_class.new }

  describe '#actions' do
    subject(:actions) { policy_info.actions }

    it 'returns correct actions' do
      expect(actions).to eq(%i[create new update])
    end
  end

  describe '#permitted_actions' do
    subject(:permitted_actions) { policy_info.permitted_actions }

    it 'returns actions with "true" result only' do
      expect(permitted_actions).to eq(%i[create new])
    end
  end

  describe '#forbidden_actions' do
    subject(:forbidden_actions) { policy_info.forbidden_actions }

    it 'returns actions with "false" result only' do
      expect(forbidden_actions).to contain_exactly(:update)
    end
  end
end
