# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionPolicy do
  subject { described_class }
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:session) { FactoryBot.build(:session, user:) }

  permissions :index? do
    specify do
      expect(subject).to permit(user)
      expect(subject).to permit(other_user)
    end
  end

  permissions :show? do
    before { session.save! }

    specify do
      expect(subject).to permit(user, session)
      expect(subject).not_to permit(other_user, session)
    end
  end

  permissions :create? do
    context 'a user is logged in' do
      include_context 'stub logged in user'

      specify do
        expect(subject).to_not permit(user, session)
      end
    end

    context 'a user is not logged in' do
      specify do
        expect(subject).to permit(user, session)
      end
    end
  end

  permissions :destroy? do
    before { session.save! }

    specify do
      expect(subject).to permit(user, session)
      expect(subject).not_to permit(other_user, session)
    end
  end
end
