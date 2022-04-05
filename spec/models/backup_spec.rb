# frozen_string_literal: true

require './src/models/backup'

RSpec.describe Backup do
  subject(:backup) do
    described_class.new(
      id: 'a123',
      created_at: '2022-01-01 00:00:00 +0000',
      status: 'Completed 2019-07-08 00:16:04 +0000',
      backup_size: '479.59MB',
      database: 'DATABASE'
    )
  end

  describe '#outdated?' do
    before { allow(Time).to receive(:now).and_return(time_now) }

    context 'when created_at is more than 30 days ago' do
      let(:time_now) { Time.new(2022, 2, 10) }

      it { expect(backup.outdated?).to be(true) }
    end

    context 'when created_at is less than 30 days ago' do
      let(:time_now) { Time.new(2022, 1, 3) }

      it { expect(backup.outdated?).to be(false) }
    end
  end
end
