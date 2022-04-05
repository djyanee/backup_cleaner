# frozen_string_literal: true

require './src/services/parser'

RSpec.describe Parser do
  subject(:parser) { described_class.new(file_path: 'spec/fixtures/backups.txt') }

  describe '#call' do
    let(:backup1) do
      Backup.new(id: 'a810', created_at: '2019-07-10 00:08:02 +0000', status: 'Completed 2019-07-10 00:18:53 +0000',
                 backup_size: '482.43MB', database: 'DATABASE')
    end
    let(:backup2) do
      Backup.new(id: 'a179', created_at: '2019-07-09 00:06:19 +0000', status: 'Completed 2019-07-09 00:23:42 +0000',
                 backup_size: '480.99MB', database: 'DATABASE')
    end
    let(:backup3) do
      Backup.new(id: 'a278', created_at: '2022-04-01 00:06:19 +0000', status: 'Completed 2019-07-08 00:16:04 +0000',
                 backup_size: '479.59MB', database: 'DATABASE')
    end
    let(:backup4) do
      Backup.new(id: 'a827', created_at: '2019-07-07 00:08:02 +0000', status: 'Completed 2019-07-07 00:18:43 +0000',
                 backup_size: '481.75MB', database: 'DATABASE')
    end

    it 'returns correctly parsed backup instances' do
      expect(parser.call).to contain_exactly(backup1, backup2, backup3, backup4)
    end
  end
end
