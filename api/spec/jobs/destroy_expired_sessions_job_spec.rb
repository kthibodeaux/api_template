# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DestroyExpiredSessionsJob, type: :job do
  subject(:job) { described_class.perform_later }

  describe '#perform' do
    before do
      FactoryBot.create(:session)
      FactoryBot.create(:session, :expired)
    end

    it 'deletes expired jobs' do
      expect { subject }
        .to change { Session.count }
        .from(2)
        .to(1)
    end

    it 'does not create an event' do
      expect { subject }
        .to_not(change { Event.count })
    end
  end
end
